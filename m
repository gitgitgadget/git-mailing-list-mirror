Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0F1C433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 17:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C85364E56
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 17:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbhBHRJ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 12:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbhBHRIa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 12:08:30 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B38C061788
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 09:07:49 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j11so13257227wmi.3
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 09:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QJqX8OA7G9Q+tWoLR6H1jPhkQTU9iAX+TXNL+XWjQHQ=;
        b=ktazpSr76SBXr70lcuE8XbxAk52lmnOdead0jgheC1mtEFzINovy/2lSczd6m8nsVO
         OSzp3EBvUm/4ARV8rgyAZcgTo/+XHT9dptNdPPvociyEVKJq5Mlc0N+ksFUQ6GClv3lW
         +ZWpy8tmXhBt3zFXCfmaCQTb3CqDSHOvtUPVJvJIK71HacMTNEK+t93musxteovBq5kh
         bMcrLLyjaouN6zZKeHIKccp1QrepuUUauuS9/WAiDPv7inft8Ao+eERWMXWaM9UdULGP
         tYaK+RV/ZeIaNRhZEeacLTYRa4A06ZjE/VkYCQJ1n+COaT+5HPBaDqL5MdaG68SMpxqS
         21tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QJqX8OA7G9Q+tWoLR6H1jPhkQTU9iAX+TXNL+XWjQHQ=;
        b=M6d7HYuFDexHo5r5sgTDU2Ha5+hsxtqRWxucJJOebZDbqsGtsSXIfQrk8459GssyRY
         XHZmZDohcQMLIO1B1ZTTTRxBAwWNU5KZzX7+YjNJf1v1KNy4lymbYWWj8uKaLnsP1Oic
         SAPIm6EcuxYDgJORT+czoFF4fa4br7DvDEW66wMvK5HGTNDwk67QrZoEJgMA9d7IiRVn
         ZgvCUp9lGagMs6lI7B2ccJUMC0sui3K+7eod3LPslyDC0W1xmVuyHaG2Kcl+m/OCWmJG
         QfdJL2y+NyeigZE4IQiwiABsRqN20FofqLZ9tiUGsybhQzPO3dgtQRgdhhNKfoUCYE/8
         ArFg==
X-Gm-Message-State: AOAM530v959nI0fd1WbbiNyUiHvOb61JQ431EuQdTOz2Nd3Eb55Zis5q
        i6bRjTd5mQ9W34/A3Z5SbmbXuJ+PQb8=
X-Google-Smtp-Source: ABdhPJxfgZxP/7lQ0/xsR2YjsvItlvHKvLL4Ut+oWcTdGrzbuslFt1vqth5by7xdPA/6VrwE561XTQ==
X-Received: by 2002:a05:600c:354c:: with SMTP id i12mr15550437wmq.51.1612803746780;
        Mon, 08 Feb 2021 09:02:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w11sm8751827wmi.37.2021.02.08.09.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 09:02:24 -0800 (PST)
Message-Id: <pull.870.v2.git.1612803744188.gitgitgadget@gmail.com>
In-Reply-To: <pull.870.git.1612711153591.gitgitgadget@gmail.com>
References: <pull.870.git.1612711153591.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 Feb 2021 17:02:23 +0000
Subject: [PATCH v2] git-difftool-helper.sh: learn a new way go back to last
 save point
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

`git difftool` only allow us to select file to view in turn.
If there is a commit with many files and we exit in the search,
We will have to traverse list again to get the file diff which
we want to see. Therefore, here is a new method: every time before
we view the file diff, the current coordinates will be stored in
`GIT_DIR/difftool-last-position`, this file will be deleted after
successful traversing. But if an unexpected exit occurred midway or
users similar to using "ctrl+c" kill the process,and the user wants
to redo the same `git difftoool`, git will view the coordinates in
the save point, ask user if they want continue from the last position.
This will improve the user experience.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    git-difftool-helper.sh: learn a new way skip to save point
    
    git user may should travel the diff list to choice file diff to view, if
    they exit in midway,they must travel it again. By saving current
    coordinates in GIT_DIR/difftool-last-position method, provides a
    possibility for this user-friendly solution.
    
    this patch's origin discuss is here:
    https://lore.kernel.org/git/gOXOaoqn-E9A2ob7ykWEcDc7ZxmSwAjcP5CCFKfr5ejCOWZQ1lfAUZcbgYT9AyQCcDgJvCrnrtziXiels-Hxol3xlkGTVHk24SvAdaSUtKQ=@rtzoeller.com/
    
    Thanks!

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-870%2Fadlternative%2Fdifftool_save_point-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-870/adlternative/difftool_save_point-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/870

Range-diff vs v1:

 1:  e77c3e33ba85 ! 1:  2468eaff322b git-difftool-helper.sh: learn a new way skip to save point
     @@ Metadata
      Author: ZheNing Hu <adlternative@gmail.com>
      
       ## Commit message ##
     -    git-difftool-helper.sh: learn a new way skip to save point
     +    git-difftool-helper.sh: learn a new way go back to last save point
      
     -    `git difftool` only allow us to select file to view In turn.
     -    If there is a commit with many files and we exit in search,
     +    `git difftool` only allow us to select file to view in turn.
     +    If there is a commit with many files and we exit in the search,
          We will have to traverse list again to get the file diff which
     -    we want to see.Therefore,here is a new method:every time before
     -    we view the file diff,the current coordinates will be stored in
     -    `GIT_DIR/difftool_skip_to`,this file will be deleted after
     -    successful traversing.But if an unexpected exit occurred midway,
     -    git will view the coordinates in the save point,ask user if they
     -    want continue from the last saved point.This will improve the
     -    user experience.
     +    we want to see. Therefore, here is a new method: every time before
     +    we view the file diff, the current coordinates will be stored in
     +    `GIT_DIR/difftool-last-position`, this file will be deleted after
     +    successful traversing. But if an unexpected exit occurred midway or
     +    users similar to using "ctrl+c" kill the process,and the user wants
     +    to redo the same `git difftoool`, git will view the coordinates in
     +    the save point, ask user if they want continue from the last position.
     +    This will improve the user experience.
      
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
     @@ git-difftool--helper.sh
       # Copyright (c) 2009, 2010 David Aguilar
       
       TOOL_MODE=diff
     -+GIT_DIFFTOOL_SKIP_TO_FILE="$GIT_DIR/difftool-skip-to"
     ++GIT_DIFFTOOL_LAST_POSITION="$GIT_DIR/difftool-last-position"
     ++DIFFTOOL_FIRST_NUM="1"
       . git-mergetool--lib
       
       # difftool.prompt controls the default prompt/no-prompt behavior
     @@ git-difftool--helper.sh: launch_merge_tool () {
       	# the user with the real $MERGED name before launching $merge_tool.
       	if should_prompt
       	then
     -+		if test -f "$GIT_DIFFTOOL_SKIP_TO_FILE"
     ++		if test -f "$GIT_DIFFTOOL_LAST_POSITION"
      +		then
     -+			SAVE_POINT_NUM=$(cat "$GIT_DIFFTOOL_SKIP_TO_FILE")
     -+			if test $SAVE_POINT_NUM -le $GIT_DIFF_PATH_TOTAL &&
     -+				test $SAVE_POINT_NUM -gt $GIT_DIFF_PATH_COUNTER
     ++			if SAVE_POINT_NUM=$(cat 2>/dev/null "$GIT_DIFFTOOL_LAST_POSITION") &&
     ++				test "$SAVE_POINT_NUM" -le "$GIT_DIFF_PATH_TOTAL" &&
     ++					test "$SAVE_POINT_NUM" -gt "$GIT_DIFF_PATH_COUNTER"
      +			then
     -+				# choice skip or not skip when check first file.
     -+				if test $GIT_DIFF_PATH_COUNTER -eq "1"
     ++				if test "$GIT_DIFF_PATH_COUNTER" -eq "$DIFFTOOL_FIRST_NUM"
      +				then
     -+					printf "do you want to skip to last time difftool save point($SAVE_POINT_NUM) [Y/n]?"
     ++					printf "Do you want to start from the possible last file you were viewing? [Y/n]?"
      +					read skip_ans || return
      +					if test "$skip_ans" = y
      +					then
     @@ git-difftool--helper.sh: launch_merge_tool () {
      +				fi
      +			fi
      +		fi
     -+		# write the current coordinates to .git/difftool-skip-to
     -+		if test !$SAVE_POINT_NUM || $SAVE_POINT_NUM -ne $GIT_DIFF_PATH_COUNTER
     ++		if test -z "$SAVE_POINT_NUM" ||
     ++			test "$SAVE_POINT_NUM" -ne "$GIT_DIFF_PATH_COUNTER"
      +		then
     -+			echo $GIT_DIFF_PATH_COUNTER > $GIT_DIFFTOOL_SKIP_TO_FILE
     ++			echo "$GIT_DIFF_PATH_COUNTER" >"$GIT_DIFFTOOL_LAST_POSITION"
      +		fi
       		printf "\nViewing (%s/%s): '%s'\n" "$GIT_DIFF_PATH_COUNTER" \
       			"$GIT_DIFF_PATH_TOTAL" "$MERGED"
     @@ git-difftool--helper.sh: else
       	done
       fi
       
     -+if test -f $GIT_DIFFTOOL_SKIP_TO_FILE &&
     -+	test $GIT_DIFF_PATH_COUNTER -eq $GIT_DIFF_PATH_TOTAL
     ++if test "$GIT_DIFF_PATH_COUNTER" -eq "$GIT_DIFF_PATH_TOTAL"
      +then
     -+	rm $GIT_DIFFTOOL_SKIP_TO_FILE
     ++	rm -f "$GIT_DIFFTOOL_LAST_POSITION"
      +
      +fi
       exit 0


 git-difftool--helper.sh | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index 46af3e60b718..a01aa7c9d551 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -6,6 +6,8 @@
 # Copyright (c) 2009, 2010 David Aguilar
 
 TOOL_MODE=diff
+GIT_DIFFTOOL_LAST_POSITION="$GIT_DIR/difftool-last-position"
+DIFFTOOL_FIRST_NUM="1"
 . git-mergetool--lib
 
 # difftool.prompt controls the default prompt/no-prompt behavior
@@ -40,6 +42,30 @@ launch_merge_tool () {
 	# the user with the real $MERGED name before launching $merge_tool.
 	if should_prompt
 	then
+		if test -f "$GIT_DIFFTOOL_LAST_POSITION"
+		then
+			if SAVE_POINT_NUM=$(cat 2>/dev/null "$GIT_DIFFTOOL_LAST_POSITION") &&
+				test "$SAVE_POINT_NUM" -le "$GIT_DIFF_PATH_TOTAL" &&
+					test "$SAVE_POINT_NUM" -gt "$GIT_DIFF_PATH_COUNTER"
+			then
+				if test "$GIT_DIFF_PATH_COUNTER" -eq "$DIFFTOOL_FIRST_NUM"
+				then
+					printf "Do you want to start from the possible last file you were viewing? [Y/n]?"
+					read skip_ans || return
+					if test "$skip_ans" = y
+					then
+						return
+					fi
+				else
+					return
+				fi
+			fi
+		fi
+		if test -z "$SAVE_POINT_NUM" ||
+			test "$SAVE_POINT_NUM" -ne "$GIT_DIFF_PATH_COUNTER"
+		then
+			echo "$GIT_DIFF_PATH_COUNTER" >"$GIT_DIFFTOOL_LAST_POSITION"
+		fi
 		printf "\nViewing (%s/%s): '%s'\n" "$GIT_DIFF_PATH_COUNTER" \
 			"$GIT_DIFF_PATH_TOTAL" "$MERGED"
 		if use_ext_cmd
@@ -102,4 +128,9 @@ else
 	done
 fi
 
+if test "$GIT_DIFF_PATH_COUNTER" -eq "$GIT_DIFF_PATH_TOTAL"
+then
+	rm -f "$GIT_DIFFTOOL_LAST_POSITION"
+
+fi
 exit 0

base-commit: e6362826a0409539642a5738db61827e5978e2e4
-- 
gitgitgadget
