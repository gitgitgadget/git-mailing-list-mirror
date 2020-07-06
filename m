Return-Path: <SRS0=tGm0=AR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4FFC433E0
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 02:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C07882070C
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 02:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8ejnPyj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgGFC1H (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Jul 2020 22:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728566AbgGFC1H (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Jul 2020 22:27:07 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E1DC061794
        for <git@vger.kernel.org>; Sun,  5 Jul 2020 19:27:06 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k6so39205751wrn.3
        for <git@vger.kernel.org>; Sun, 05 Jul 2020 19:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=aku0PiUleBhk0kcayg0aJEvpUhdEiEDHdirP3HKRaNk=;
        b=A8ejnPyjvAuO5M2YnEzqWiDCFiawPtdxMtj9yvL69Ppo5UX/ZAPHGbtlwsGly07oUz
         x6DfcnuDS0QZtLeMupcbZTz9/va4bYdOSL6+6hCUoKW4ndQijIRtWJ/HkNW8I0PzmAW4
         bGVILXKdTVPpk+uICI2CiLFzex/dQwn6KlII/xHMdevRbApy02O3v0BCpmEHtRq4y7u+
         WQWabpnwTakOTf+w8nuPTMGbb51/ZIjvVxr2PtqdiwoBrTc/vf0BzaYKRHuZXXOWeG39
         EjXlnuOViVb2oCAXzzIiHKwz9x4wkq2boZAn0jDgabY8HCPOVogaHRCo9y6XMJvsaNcl
         l5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=aku0PiUleBhk0kcayg0aJEvpUhdEiEDHdirP3HKRaNk=;
        b=lE5bWocfAECbN1H6IDVW96nYGxp6OCOMqH4b5G1BanoUnv9taqLF25+yqzZ6kkAOq1
         isfBxIutnuofomenatQaukT9bUfutSf19mTCxd7XPkTScSXPmpsjNm4O8haaZGTGJSDb
         HaYutpNntG15hDN5fZHFyTw2B2W7ga8vZ/XpEmkdQDGZOXTO5we3vIUM4Qw/Y9BM/l/C
         JTInL76As9yGyKteADHENRGidGXy9A/P6YCFb9EOlfKGMibnqQEyKlaBTLh/DQp5syZn
         RMYC1TwCDt/XfYQbVhx5reLRSOAfbS6sdooZbrf90RO/BpQZPMj2ChVG8LsxHYhbiqRq
         qo9w==
X-Gm-Message-State: AOAM531cBsFWMYiu/1nPageIvNAX/JNf2gtoq2GPZXQ2RA+E0w0AY+0q
        me+QTQKJ5G0ivIJ9GbrY0LCgBg7U
X-Google-Smtp-Source: ABdhPJx+XVC6agfItTreFozUxqnGzDiYdw7yp3DXvZV64DeItSrFwKeBRwVZdbXaEnNiiX8naPKAMA==
X-Received: by 2002:adf:9404:: with SMTP id 4mr45165669wrq.367.1594002425348;
        Sun, 05 Jul 2020 19:27:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b184sm22251199wmc.20.2020.07.05.19.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 19:27:04 -0700 (PDT)
Message-Id: <pull.781.v9.git.git.1594002423685.gitgitgadget@gmail.com>
In-Reply-To: <pull.781.v8.git.git.1593825400699.gitgitgadget@gmail.com>
References: <pull.781.v8.git.git.1593825400699.gitgitgadget@gmail.com>
From:   "sunlin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Jul 2020 02:27:03 +0000
Subject: [PATCH v9] Support auto-merge for meld to follow the vim-diff
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
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: David Aguilar <davvid@gmail.com>
Signed-off-by: Lin Sun <lin.sun@zoom.us>
---
    Enable auto-merge for meld to follow the vimdiff beharior
    
    Hi, the mergetool "meld" does NOT merge the no-conflict changes, while
    the mergetool "vimdiff" will merge the no-conflict changes and highlight
    the conflict parts. This patch will make the mergetool "meld" similar to
    "vimdiff", auto-merge the no-conflict changes, highlight conflict parts.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-781%2Fsunlin7%2Fmaster-v9
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-781/sunlin7/master-v9
Pull-Request: https://github.com/git/git/pull/781

Range-diff vs v8:

 1:  f28a32c66e ! 1:  95586fb2c2 Support auto-merge for meld to follow the vim-diff behavior
     @@ mergetools/meld: diff_cmd () {
      -	else
      -		meld_has_output_option=false
      +		meld_use_auto_merge_option=$(git config mergetool.meld.useAutoMerge)
     -+		if test -z "$meld_use_auto_merge_option"
     -+		then
     ++		case "$meld_use_auto_merge_option" in
     ++		"")
      +			meld_use_auto_merge_option=false
     -+		else
     ++			;;
     ++		[Aa]uto)
     ++			# testing the "--auto-merge" option only if config is "[Aa]uto"
     ++			init_meld_help_msg
     ++
     ++			case "$meld_help_msg" in
     ++			*"--auto-merge"*)
     ++				meld_use_auto_merge_option=true
     ++				;;
     ++			*)
     ++				meld_use_auto_merge_option=false
     ++				;;
     ++			esac
     ++			;;
     ++		*)
      +			bool_value=$(git config --bool mergetool.meld.useAutoMerge 2>/dev/null)
      +			if test -n "$bool_value"
      +			then
      +				meld_use_auto_merge_option="$bool_value"
     -+			elif test "$meld_use_auto_merge_option" = "auto" \
     -+				|| test "$meld_use_auto_merge_option" = "Auto"
     -+			then
     -+				# testing the "--auto-merge" option only if config is "[Aa]uto"
     -+				init_meld_help_msg
     -+
     -+				case "$meld_help_msg" in
     -+				*"--auto-merge"*)
     -+					meld_use_auto_merge_option=true
     -+					;;
     -+				*)
     -+					meld_use_auto_merge_option=false
     -+					;;
     -+				esac
      +			else
      +				meld_use_auto_merge_option=false
      +			fi
     -+		fi
     ++			;;
     ++		esac
       	fi
       }


 Documentation/config/mergetool.txt | 10 ++++
 mergetools/meld                    | 86 ++++++++++++++++++++++++------
 2 files changed, 80 insertions(+), 16 deletions(-)

diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
index 09ed31dbfa..031c78aa95 100644
--- a/Documentation/config/mergetool.txt
+++ b/Documentation/config/mergetool.txt
@@ -30,6 +30,16 @@ mergetool.meld.hasOutput::
 	to `true` tells Git to unconditionally use the `--output` option,
 	and `false` avoids using `--output`.
 
+mergetool.meld.useAutoMerge::
+	When the `--auto-merge` is given, meld will merge all non-conflicting
+	parts automatically, highlight the conflicting parts and waiting for
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
index 7a08470f88..ba6607a088 100644
--- a/mergetools/meld
+++ b/mergetools/meld
@@ -3,34 +3,88 @@ diff_cmd () {
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
+		meld_use_auto_merge_option=$(git config mergetool.meld.useAutoMerge)
+		case "$meld_use_auto_merge_option" in
+		"")
+			meld_use_auto_merge_option=false
+			;;
+		[Aa]uto)
+			# testing the "--auto-merge" option only if config is "[Aa]uto"
+			init_meld_help_msg
+
+			case "$meld_help_msg" in
+			*"--auto-merge"*)
+				meld_use_auto_merge_option=true
+				;;
+			*)
+				meld_use_auto_merge_option=false
+				;;
+			esac
+			;;
+		*)
+			bool_value=$(git config --bool mergetool.meld.useAutoMerge 2>/dev/null)
+			if test -n "$bool_value"
+			then
+				meld_use_auto_merge_option="$bool_value"
+			else
+				meld_use_auto_merge_option=false
+			fi
+			;;
+		esac
 	fi
 }

base-commit: 07d8ea56f2ecb64b75b92264770c0a664231ce17
-- 
gitgitgadget
