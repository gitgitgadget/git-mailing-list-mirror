Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B41C433DF
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 00:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8B74206DF
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 00:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeiS80FX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgGIAfK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 20:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgGIAfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 20:35:09 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF7CC061A0B
        for <git@vger.kernel.org>; Wed,  8 Jul 2020 17:35:09 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f139so129921wmf.5
        for <git@vger.kernel.org>; Wed, 08 Jul 2020 17:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=3Xg22ED4aVYk/zCHjhrkgs0kXKnZR9w9HdEACn3D3oc=;
        b=AeiS80FXS6Lod0DxM1OEzH9OV7aH3m5/7/AinGHWrVs8+x2cHKiGztOywxKIUvLDDD
         AZUvjunlnV60TIoHBYYLvPqw3Gwd3P+xdg6PmA9qwHHBN2hcZoe0nEfRzy04qoiapY7u
         STmY8f0jUfBzVdWMAwY7+2Fmte+rAI1zO/g+LPimvtuJep0Hhrd3K32XjzQzUnBvBKZo
         3JwbMDnqLnmQb6ZF8qNFWY6+9OEsxF97kjBF3fJ44L88wLWeNgOjE3xQMwY+tfWD2E+4
         KiSE3ZhSHgjHSGmsb/CY9Wleq7EL4PUoJIn6FIUqzGdRN5o4MwaxtSLzJI1gOuF82pNt
         T+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=3Xg22ED4aVYk/zCHjhrkgs0kXKnZR9w9HdEACn3D3oc=;
        b=oSEqa0uPnZ7y/OzTJ3B3IejXneDzfODTMMRJh6Bcw0yBUDIgQYMJ/5EqNSXBHpd3CW
         O/9jM7gdk72FY9GW2H1HHaYi3TwsJtCu5dPieUQD5Gn6eGJ6DdKeJ2VswC6l6c9ryLh5
         jpFmIFYjNItzNriAeQ4pECwZ7VKfCs+IblGyP9A7/z9dyvabvaJb1V2dWTqitgsthO0T
         w/GU37Okh6FrrDlpyTHjMSdrxOca2iZ0/P214aV9RUqA8hRLK7dA9lvxWBrwrvJagxMP
         pVtuGOZu8fV4fIMTMNInev97XKXIiTET5MoA10vx4PpGRHWyB9o95oFDy1mOvE1qpa5I
         Fk7A==
X-Gm-Message-State: AOAM532WEkSEj/MRKtzVkx0jbEETGrXhLNuE3vbx4nRjpayrWNvlj2FM
        ziM6GI4e4jBRoGgooeM6BuCkhbmU
X-Google-Smtp-Source: ABdhPJwxTms7WEsQat96+uxHL21hj1nxgnhH6Y51Vp3cFTaM/sI2cKX1o7kGvmDUN1snXm0GOqQshA==
X-Received: by 2002:a7b:cb47:: with SMTP id v7mr11110208wmj.57.1594254907657;
        Wed, 08 Jul 2020 17:35:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b23sm2434478wmd.37.2020.07.08.17.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 17:35:07 -0700 (PDT)
Message-Id: <pull.781.v13.git.git.1594254906647.gitgitgadget@gmail.com>
In-Reply-To: <pull.781.v12.git.git.1594178716840.gitgitgadget@gmail.com>
References: <pull.781.v12.git.git.1594178716840.gitgitgadget@gmail.com>
From:   "sunlin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Jul 2020 00:35:06 +0000
Subject: [PATCH v13] Support auto-merge for meld to follow the vim-diff
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-781%2Fsunlin7%2Fmaster-v13
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-781/sunlin7/master-v13
Pull-Request: https://github.com/git/git/pull/781

Range-diff vs v12:

 1:  b130cf38b5 ! 1:  b949e5721a Support auto-merge for meld to follow the vim-diff behavior
     @@ mergetools/meld: diff_cmd () {
      +			init_meld_help_msg
      +
      +			case "$meld_help_msg" in
     -+			*"--auto-merge"*|*'[OPTION...]')
     ++			*"--auto-merge"*|*'[OPTION...]'*)
      +				meld_use_auto_merge_option=true
      +				;;
      +			*)


 Documentation/config/mergetool.txt | 10 ++++
 mergetools/meld                    | 86 ++++++++++++++++++++++++------
 2 files changed, 80 insertions(+), 16 deletions(-)

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
index 7a08470f88..5e5872e1c3 100644
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
+		meld_help_msg=$("$meld_path" --help 2>&1)
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
+			*"--output="*|*'[OPTION...]'*)
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
+		true|false)
+			: use well formatted boolean value
+			;;
+		auto)
+			# testing the "--auto-merge" option only if config is "auto"
+			init_meld_help_msg
+
+			case "$meld_help_msg" in
+			*"--auto-merge"*|*'[OPTION...]'*)
+				meld_use_auto_merge_option=true
+				;;
+			*)
+				meld_use_auto_merge_option=false
+				;;
+			esac
+			;;
+		*)
+			if meld_use_auto_merge_option=$(\
+				 git config --bool mergetool.meld.useAutoMerge)
+			then
+				: use normalized boolean value
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
