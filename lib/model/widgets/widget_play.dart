import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:seins/model/netease/model/song.dart';
import 'package:seins/model/netease/provider/play_songs_model.dart';
import 'package:seins/model/widgets/widget_round_img.dart';
import 'package:seins/utils/navigator_util.dart';

import '../../application.dart';
import 'common_text_style.dart';
import 'h_empty_view.dart';

/// 所有页面下面的播放条
class PlayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Consumer<PlaySongsModel>(builder: (context, model, child) {
        Widget child;

        if (model.allSongs.isEmpty)
          child = Text('暂无正在播放的歌曲');
        else {
          Song curSong = model.curSong;
          child = GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              NavigatorUtil.goPlaySongsPage(context);
            },
            child: Row(
              children: <Widget>[
                RoundImgWidget(curSong.picUrl, 80),
                HEmptyView(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(curSong.name, style: commonTextStyle, maxLines: 1, overflow: TextOverflow.ellipsis,),
                      Text(curSong.artists, style: common13TextStyle,),
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    if(model.curState == null){
                      model.play();
                    }else {
                      model.togglePlay();
                    }
                  },
                  child: Image.asset(
                    model.curState == AudioPlayerState.PLAYING
                        ? 'images/pause.png'
                        : 'images/play.png',
                    width: ScreenUtil().setWidth(50),
                  ),
                ),
                HEmptyView(15),
                GestureDetector(
                  onTap: (){},
                  child: Image.asset(
                    'images/list.png',
                    width: ScreenUtil().setWidth(50),
                  ),
                ),
              ],
            ),
          );
        }

        return Container(
          width: Application.screenWidth,
          height: ScreenUtil().setWidth(110) + Application.bottomBarHeight,
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey[200])),
              color: Colors.white),
          alignment: Alignment.topCenter,
          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
          child: Container(
            width: Application.screenWidth,
            height: ScreenUtil().setWidth(110),
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
            alignment: Alignment.center,
            child: child,
          ),
        );
      }),
    );
  }
}
