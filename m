Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F575C433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 07:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72B7120656
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 07:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwZEks5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgGGHNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 03:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgGGHNr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 03:13:47 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E077BC061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 00:13:46 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r12so43918344wrj.13
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 00:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=v8H9Yke9u9d4/q6iB8I1wOwL5aP2amGW8Qpctvg7zEM=;
        b=SwZEks5hFQMix4XE3lbsuQatoO/B6g82QGiI3ubos9Nl5U3hbIo1NK7LRU2hkPrDZ8
         ZH7rKd/xSiqZWeDUGbPM7HXRBhEy1BVXCufpvHN5/j0LryAvP3qXvucvKn+l6y9gJaPC
         bpslAcO6xptefVVmWQiLqOGKF6838wExgO6objG4TZpzWPOVy4OPuGuntaiyuxHkaI6g
         b2HIYSHvVccAlAZXtZRgOodeIz27731EYEuf33Sf/NejJJAe0VU6J1nw6niYBM4HC7Cm
         SxUi9Gr01aRkboa4fT6vlLSTmDltGmFfShGxlsQgdrGxx0BL2pjr1rAsKeKn7QdL+5i8
         vfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=v8H9Yke9u9d4/q6iB8I1wOwL5aP2amGW8Qpctvg7zEM=;
        b=di2LTo50wP4qtf0KbPmlHo1aqNqhLkHS9gG1TrySWH4+dAohXiIxNxHZ6AFxz7HoP2
         OVucGhvo4uhUTw2XAK1vXdYxY+i24u7ziPi2Km8n8cD/UNlR5uhZlPbwBE3LFyRfMuAX
         12bdqdybP33cIr8s5Oe1kegi6NFbEq0Y0FNSJRUIu4bCgk0KZJ0ET0nGSXJ96jkqcazx
         A90jHQEvv+PgEHbH7UploXFoNEYm7LC83JE0OYjuRpjMPmizTSPRfO0ysEFg6wIHoTYY
         TMkgnvB+0HdZ7FkeF78npNnn5kPHbrgQReBxEyosKXgDPX7SnY1RHyfkj0qwY/1CzNnU
         GDkQ==
X-Gm-Message-State: AOAM531vyYGwP367LSHbzQETEuIjbDzxvk+WPiaeQouVCtXE+57YRfq6
        PWFEQHlqPescF22RnRLiWhcuX+a4
X-Google-Smtp-Source: ABdhPJzvkoWW7a9mik3gFiOukYqY3YSb/mD1C6vNUBg+FXMrBjvBiNeOx0lEj5I92RLxhlvUxxgwmQ==
X-Received: by 2002:a5d:4707:: with SMTP id y7mr29593655wrq.261.1594106025365;
        Tue, 07 Jul 2020 00:13:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k14sm26509481wrn.76.2020.07.07.00.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 00:13:44 -0700 (PDT)
Message-Id: <pull.781.v11.git.git.1594106024078.gitgitgadget@gmail.com>
In-Reply-To: <pull.781.v10.git.git.1594102679750.gitgitgadget@gmail.com>
References: <pull.781.v10.git.git.1594102679750.gitgitgadget@gmail.com>
From:   "sunlin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jul 2020 07:13:43 +0000
Subject: [PATCH v11] Support auto-merge for meld to follow the vim-diff
 behavior
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     sunlin <sunlin7@yahoo.com>, Lin Sun <lin.sun@zoom.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lin Sun <lin.sun@zoom.us>

Make the mergetool used with "meld" backend behave similarly to "vimdiff" by
telling it to auto-merge non-conflicting parts and highlight the conflicting
parts when `mergetool.meld.useAutoMerge` is configured with `true`, or `auto`
for detecting the `--auto-merge` option automatically.

Helped-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
Helped-by: David Aguilar <davvid@gmail.com>
Signed-off-by: Lin Sun <lin.sun@zoom.us>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
    Enable auto-merge for meld to follow the vimdiff beharior
    
    Hi, the mergetool "meld" does NOT merge the no-conflict changes, while
    the mergetool "vimdiff" will merge the no-conflict changes and highlight
    the conflict parts. This patch will make the mergetool "meld" similar to
    "vimdiff", auto-merge the no-conflict changes, highlight conflict parts.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-781%2Fsunlin7%2Fmaster-v11
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-781/sunlin7/master-v11
Pull-Request: https://github.com/git/git/pull/781

Range-diff vs v10:

 1:  a4f1b8c2fa ! 1:  8015c4c98e Support auto-merge for meld to follow the vim-diff behavior
     @@ mergetools/meld: diff_cmd () {
      -		meld_has_output_option=true
      -	else
      -		meld_has_output_option=false
     -+		meld_use_auto_merge_option=$(git config mergetool.meld.useAutoMerge)
     -+		case "$meld_use_auto_merge_option" in
     -+		"")
     -+			meld_use_auto_merge_option=false
     -+			;;
     -+		[Tt]ure|TRUE)
     -+			meld_use_auto_merge_option=true
     -+			;;
     -+		[Ff]alse|FALSE)
     -+			meld_use_auto_merge_option=false
     -+			;;
     -+		[Aa]uto|AUTO)
     -+			# testing the "--auto-merge" option only if config is "auto"
     -+			init_meld_help_msg
     -+
     -+			case "$meld_help_msg" in
     -+			*"--auto-merge"*)
     -+				meld_use_auto_merge_option=true
     -+				;;
     -+			*)
     -+				meld_use_auto_merge_option=false
     -+				;;
     -+			esac
     -+			;;
     -+		*)
     -+			# try detect boolean for 'on'||'yes'||numberic value
     -+			bool_value=$(git config --bool mergetool.meld.useAutoMerge 2>/dev/null)
     -+			if test -n "$bool_value"
     ++		if meld_use_auto_merge_option=$( \
     ++			git config --bool mergetool.meld.useAutoMerge 2>/dev/null)
     ++		then
     ++			: use configured value
     ++		else
     ++			meld_use_auto_merge_option=$(git config mergetool.meld.useAutoMerge)
     ++			if test "$meld_use_auto_merge_option" = "auto"
      +			then
     -+				meld_use_auto_merge_option="$bool_value"
     ++				# testing the "--auto-merge" option only if config is "auto"
     ++				init_meld_help_msg
     ++
     ++				case "$meld_help_msg" in
     ++				*"--auto-merge"* | *'[OPTION...]'*)
     ++					meld_use_auto_merge_option=true
     ++					;;
     ++				*)
     ++					meld_use_auto_merge_option=false
     ++					;;
     ++				esac
      +			else
      +				meld_use_auto_merge_option=false
      +			fi
     -+			;;
     -+		esac
     ++		fi
       	fi
       }


 Documentation/config/mergetool.txt | 10 ++++
 mergetools/meld                    | 81 ++++++++++++++++++++++++------
 2 files changed, 75 insertions(+), 16 deletions(-)

diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
index 09ed31dbfa..16a27443a3 100644
--- a/Documentation/config/mergetool.txt
+++ b/Documentation/config/mergetool.txt
@@ -30,6 +30,16 @@ mergetool.meld.hasOutput::
 	to `true` tells Git to unconditionally use the `--output` option,
 	and `false` avoids using `--output`.
 
+mergetool.meld.useAutoMerge::
+	When the `--auto-merge` is given, meld will merge all non-conflicting
+	parts automatically, highlight the conflicting parts and wait for
+	user decision.  Setting `mergetool.meld.useAutoMerge` to `true` tells
+	Git to unconditionally use the `--auto-merge` option with `meld`.
+	Setting this value to `auto` makes git detect whether `--auto-merge`
+	is supported and will only use `--auto-merge` when available.  A
+	value of `false` avoids using `--auto-merge` altogether, and is the
+	default value.
+
 mergetool.keepBackup::
 	After performing a merge, the original file with conflict markers
 	can be saved as a file with a `.orig` extension.  If this variable
diff --git a/mergetools/meld b/mergetools/meld
index 7a08470f88..3463aee87e 100644
--- a/mergetools/meld
+++ b/mergetools/meld
@@ -3,34 +3,83 @@ diff_cmd () {
 }
 
 merge_cmd () {
-	if test -z "${meld_has_output_option:+set}"
+	check_meld_for_features
+
+	option_auto_merge=
+	if test "$meld_use_auto_merge_option" = true
 	then
-		check_meld_for_output_version
+		option_auto_merge="--auto-merge"
 	fi
 
 	if test "$meld_has_output_option" = true
 	then
-		"$merge_tool_path" --output="$MERGED" \
+		"$merge_tool_path" $option_auto_merge --output="$MERGED" \
 			"$LOCAL" "$BASE" "$REMOTE"
 	else
-		"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
+		"$merge_tool_path" $option_auto_merge "$LOCAL" "$MERGED" "$REMOTE"
 	fi
 }
 
-# Check whether we should use 'meld --output <file>'
-check_meld_for_output_version () {
-	meld_path="$(git config mergetool.meld.path)"
-	meld_path="${meld_path:-meld}"
+# Get meld help message
+init_meld_help_msg () {
+	if test -z "$meld_help_msg"
+	then
+		meld_path="$(git config mergetool.meld.path || echo meld)"
+		meld_help_msg=$($meld_path --help 2>&1)
+	fi
+}
 
-	if meld_has_output_option=$(git config --bool mergetool.meld.hasOutput)
+# Check the features and set flags
+check_meld_for_features () {
+	# Check whether we should use 'meld --output <file>'
+	if test -z "$meld_has_output_option"
 	then
-		: use configured value
-	elif "$meld_path" --help 2>&1 |
-		grep -e '--output=' -e '\[OPTION\.\.\.\]' >/dev/null
+		meld_has_output_option=$(git config --bool mergetool.meld.hasOutput)
+		case "$meld_has_output_option" in
+		true|false)
+			: use configured value
+			;;
+		*)
+			: empty or invalid configured value, detecting "--output" automatically
+			init_meld_help_msg
+
+			case "$meld_help_msg" in
+			*"--output="* | *'[OPTION...]'*)
+				# All version that has [OPTION...] supports --output
+				meld_has_output_option=true
+				;;
+			*)
+				meld_has_output_option=false
+				;;
+			esac
+			;;
+		esac
+	fi
+	# Check whether we should use 'meld --auto-merge ...'
+	if test -z "$meld_use_auto_merge_option"
 	then
-		: old ones mention --output and new ones just say OPTION...
-		meld_has_output_option=true
-	else
-		meld_has_output_option=false
+		if meld_use_auto_merge_option=$( \
+			git config --bool mergetool.meld.useAutoMerge 2>/dev/null)
+		then
+			: use configured value
+		else
+			meld_use_auto_merge_option=$(git config mergetool.meld.useAutoMerge)
+			if test "$meld_use_auto_merge_option" = "auto"
+			then
+				# testing the "--auto-merge" option only if config is "auto"
+				init_meld_help_msg
+
+				case "$meld_help_msg" in
+				*"--auto-merge"* | *'[OPTION...]'*)
+					meld_use_auto_merge_option=true
+					;;
+				*)
+					meld_use_auto_merge_option=false
+					;;
+				esac
+			else
+				meld_use_auto_merge_option=false
+			fi
+		fi
 	fi
 }

base-commit: 07d8ea56f2ecb64b75b92264770c0a664231ce17
-- 
gitgitgadget
