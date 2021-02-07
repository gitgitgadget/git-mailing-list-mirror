Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8500BC433E9
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 15:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4862D64E43
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 15:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhBGPXU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 10:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhBGPUj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 10:20:39 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2976C06174A
        for <git@vger.kernel.org>; Sun,  7 Feb 2021 07:19:16 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id j21so8108956wmj.0
        for <git@vger.kernel.org>; Sun, 07 Feb 2021 07:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Hl2daMntIRljEd7rX9R0WqLNy4jlPeQxBvrL2mQbQ7s=;
        b=PfLefJ6L4d6b+cTZuoclnpbpH20g6tl8xhiaMvOWab4sw2bzgWZrw1Dndum1iRWElL
         jUr1MtgOdjninfsAcSAtlonOkUGSrl3uKpTAf0I4CxzxT2U/f1IQeQbEvBxFqUkKum59
         Kd+2rn5pKENSwaTK8v5WxA52mIbhK41zGFiCTY1T7eZOpVVSPXyWL0xI+xg5EnLyS6fU
         cTofcPzl0davxRoISiuQOloNPYvWIZf+2AoGw31PGQG1DkIfz3VmWXCNMif5ZFsDLcup
         kvsTtCdccc6JP+lbY13eo2XVKXNbh4KjdQ5k0tOkzjRdnVTF8Fgu/PehmEcPLPfqeABm
         7rEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Hl2daMntIRljEd7rX9R0WqLNy4jlPeQxBvrL2mQbQ7s=;
        b=qD+ZfAJHcOYIWqgn9HOB48ViliZtqUFa/JQ0lREM5LGkTa1K4erHjwXUWjtt+xOVpj
         gMinWHxraX7yD/Qh+4pN8ahcKcul6FHm6+5QL8i7Ls/hsZzm6dEvd7rMukqPtPdtKLS4
         FPAbaGFCmtrH7RTNU7802aVe/LaR0YWgc/WJunpkiEE6UVPmPA+m5NpT+3doNfTdPTb7
         ReYLqAQtXcg9F0VfF+IW/41R+ecaN19R3ZCddSS3CdIHPN5iOn0Ln8mgVEyQ3QRFGPl5
         oYStqBCGjVByP3oYUuiwQob5LDjEuKGnj6O1T/w75eznWlNvBmNyT5HCWbGICRcl7ksr
         aY2w==
X-Gm-Message-State: AOAM532tAEsE0k5Vwsz1C/h4BRT6k0W/WrTWTCt6TqchKXOHcbIgCDBk
        tCOkBppbyDUniuF8a+5lBNoXZxDpt54=
X-Google-Smtp-Source: ABdhPJw3y/01jZPD2U4eL3fc/P0eVgqlc7z0TejrCEn4ackwVn4U3X7baWtDx9qVy6fT6AqPTnvzDg==
X-Received: by 2002:a05:600c:4ecb:: with SMTP id g11mr10993889wmq.71.1612711155256;
        Sun, 07 Feb 2021 07:19:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t17sm4658579wmi.20.2021.02.07.07.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 07:19:14 -0800 (PST)
Message-Id: <pull.870.git.1612711153591.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sun, 07 Feb 2021 15:19:13 +0000
Subject: [PATCH] git-difftool-helper.sh: learn a new way skip to save point
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

`git difftool` only allow us to select file to view In turn.
If there is a commit with many files and we exit in search,
We will have to traverse list again to get the file diff which
we want to see.Therefore,here is a new method:every time before
we view the file diff,the current coordinates will be stored in
`GIT_DIR/difftool_skip_to`,this file will be deleted after
successful traversing.But if an unexpected exit occurred midway,
git will view the coordinates in the save point,ask user if they
want continue from the last saved point.This will improve the
user experience.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    git-difftool-helper.sh: learn a new way skip to save point
    
    this patch's origin discuss is here:
    https://lore.kernel.org/git/gOXOaoqn-E9A2ob7ykWEcDc7ZxmSwAjcP5CCFKfr5ejCOWZQ1lfAUZcbgYT9AyQCcDgJvCrnrtziXiels-Hxol3xlkGTVHk24SvAdaSUtKQ=@rtzoeller.com/
    
    git user may should travel the diff list to choice file diff to view, if
    they exit in midway,they must travel it again. I’m on the basis of the
    "difftool_skip_to" suggested by Junio,Provides a possibility for this
    user-friendly solution.
    
    Thanks!

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-870%2Fadlternative%2Fdifftool_save_point-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-870/adlternative/difftool_save_point-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/870

 git-difftool--helper.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index 46af3e60b718..56ec1d38a7a1 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -6,6 +6,7 @@
 # Copyright (c) 2009, 2010 David Aguilar
 
 TOOL_MODE=diff
+GIT_DIFFTOOL_SKIP_TO_FILE="$GIT_DIR/difftool-skip-to"
 . git-mergetool--lib
 
 # difftool.prompt controls the default prompt/no-prompt behavior
@@ -40,6 +41,31 @@ launch_merge_tool () {
 	# the user with the real $MERGED name before launching $merge_tool.
 	if should_prompt
 	then
+		if test -f "$GIT_DIFFTOOL_SKIP_TO_FILE"
+		then
+			SAVE_POINT_NUM=$(cat "$GIT_DIFFTOOL_SKIP_TO_FILE")
+			if test $SAVE_POINT_NUM -le $GIT_DIFF_PATH_TOTAL &&
+				test $SAVE_POINT_NUM -gt $GIT_DIFF_PATH_COUNTER
+			then
+				# choice skip or not skip when check first file.
+				if test $GIT_DIFF_PATH_COUNTER -eq "1"
+				then
+					printf "do you want to skip to last time difftool save point($SAVE_POINT_NUM) [Y/n]?"
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
+		# write the current coordinates to .git/difftool-skip-to
+		if test !$SAVE_POINT_NUM || $SAVE_POINT_NUM -ne $GIT_DIFF_PATH_COUNTER
+		then
+			echo $GIT_DIFF_PATH_COUNTER > $GIT_DIFFTOOL_SKIP_TO_FILE
+		fi
 		printf "\nViewing (%s/%s): '%s'\n" "$GIT_DIFF_PATH_COUNTER" \
 			"$GIT_DIFF_PATH_TOTAL" "$MERGED"
 		if use_ext_cmd
@@ -102,4 +128,10 @@ else
 	done
 fi
 
+if test -f $GIT_DIFFTOOL_SKIP_TO_FILE &&
+	test $GIT_DIFF_PATH_COUNTER -eq $GIT_DIFF_PATH_TOTAL
+then
+	rm $GIT_DIFFTOOL_SKIP_TO_FILE
+
+fi
 exit 0

base-commit: e6362826a0409539642a5738db61827e5978e2e4
-- 
gitgitgadget
