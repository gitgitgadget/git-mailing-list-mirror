Return-Path: <SRS0=Nv7C=AP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AFAC433DF
	for <git@archiver.kernel.org>; Sat,  4 Jul 2020 01:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 188C62075D
	for <git@archiver.kernel.org>; Sat,  4 Jul 2020 01:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBU1sbTD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgGDBQo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jul 2020 21:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgGDBQo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jul 2020 21:16:44 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004DEC061794
        for <git@vger.kernel.org>; Fri,  3 Jul 2020 18:16:43 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f7so31450777wrw.1
        for <git@vger.kernel.org>; Fri, 03 Jul 2020 18:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=E758uvowPA7wVVsMFca3moq3mOxb74U1ixQFjHuBrDg=;
        b=lBU1sbTDQ6wGC7kvl9wEuX13OQIR0MY6TdOsW6gnZwwqjB9TiEug0MEduF3ApOLsPA
         RireAKiynQhuceHbzGCPypRiU6MbHeH/Mx2cxMUmeM+Y/U5CfbNHKzjIhG06ACC7vO9j
         SPIe9gPvdmi4iZe4x/pQn/UFcUp9iul0IDkuq1ay594ilZV6WzPIkjvcOVPv4eetMOsl
         m9DB3mP70gFbPHD5Ejuf8yC9N6/Os5NrHPTIsX4PPV8uFELK0qqQ1hUf3X3e0Tr+3Dc/
         +0PbYbBhP5ovUqKePGGZtxzFTt5aEYkiAhz9U1WyQjL2UBtBNOMWPHFK9Pb0AkqQAy+Y
         Frug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=E758uvowPA7wVVsMFca3moq3mOxb74U1ixQFjHuBrDg=;
        b=dozfqqnRdTMMdw6GzkVyGZ9jXIAlvRvQ5ZxqB2vAtMn36nw+2PC8D3bkYoqsch6cUi
         ovcILleua5yKttogqkRA172CiwqXsekhqhBTJPcO/KOwp2Sm9C5xnSLQzarDFVL0vimM
         Eq7H8jtVGjb4uwBzYI132j0918RXNXCaFQO5a9Y67y1DjPmYOFXEQA9VOHFn+h1s8P2+
         3q0bgnekvyLPYwxT5Dg4SgmRMSKEHxWb8tza/dTJIVk7iAIGUe+h1tprV8InEt65QJri
         YI5aPw0EnHYEJWx5FthtEzSW9iU+P3yQT/JI2ET1n1ef+mFeEZb/hFM0dULFZx65p2E8
         5q5w==
X-Gm-Message-State: AOAM530UuxZVzX2BO/C+2M+UgslSF49WmzC4s9S2wZsdQw9CPHvLGA4V
        hGTqvTgzfXYR4G/bcWuOlsQQ09ET
X-Google-Smtp-Source: ABdhPJzWbk9ftY8sTiBiiiv+0yxqTYpyZikGRT7xGjLfS/Y+uxjoBEh02ep7wyBmfyI3g4AgB7EpgQ==
X-Received: by 2002:adf:ea0f:: with SMTP id q15mr9240960wrm.113.1593825402261;
        Fri, 03 Jul 2020 18:16:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q5sm6005640wrp.60.2020.07.03.18.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 18:16:41 -0700 (PDT)
Message-Id: <pull.781.v8.git.git.1593825400699.gitgitgadget@gmail.com>
In-Reply-To: <pull.781.v7.git.git.1593746805771.gitgitgadget@gmail.com>
References: <pull.781.v7.git.git.1593746805771.gitgitgadget@gmail.com>
From:   "sunlin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 04 Jul 2020 01:16:40 +0000
Subject: [PATCH v8] Support auto-merge for meld to follow the vim-diff
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-781%2Fsunlin7%2Fmaster-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-781/sunlin7/master-v8
Pull-Request: https://github.com/git/git/pull/781

Range-diff vs v7:

 1:  ec2b49b9b8 ! 1:  f28a32c66e Support auto-merge for meld to follow the vim-diff behavior
     @@ Metadata
       ## Commit message ##
          Support auto-merge for meld to follow the vim-diff behavior
      
     -    Make the mergetool used with "meld" backend behave similarly to
     -    "vimdiff" by telling it to auto-merge non-conflicting parts and
     -    highlight the conflicting parts when `mergetool.meld.useAutoMerge` is
     -    configured with `true`, or `auto` for detecting the `--auto-merge`
     -    option automatically.
     +    Make the mergetool used with "meld" backend behave similarly to "vimdiff" by
     +    telling it to auto-merge non-conflicting parts and highlight the conflicting
     +    parts when `mergetool.meld.useAutoMerge` is configured with `true`, or `auto`
     +    for detecting the `--auto-merge` option automatically.
      
          Helped-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
          Helped-by: Junio C Hamano <gitster@pobox.com>
     @@ Documentation/config/mergetool.txt: mergetool.meld.hasOutput::
       	and `false` avoids using `--output`.
       
      +mergetool.meld.useAutoMerge::
     -+	When the `--auto-merge` is given, meld will merges all non-conflicting
     -+	part automatically, highlight the conflicting part and waiting for user
     -+	decision.  Setting `mergetool.meld.useAutoMerge` to `true` tells Git to
     -+	unconditionally use the `--auto-merge` option with `meld`.  Setting this
     -+	value to `auto` makes git detect whether `--auto-merge` is supported and
     -+	will only use `--auto-merge` when available.  A value of `false` avoids
     -+	using `--auto-merge` altogether, and is the default value.
     ++	When the `--auto-merge` is given, meld will merge all non-conflicting
     ++	parts automatically, highlight the conflicting parts and waiting for
     ++	user decision.  Setting `mergetool.meld.useAutoMerge` to `true` tells
     ++	Git to unconditionally use the `--auto-merge` option with `meld`.
     ++	Setting this value to `auto` makes git detect whether `--auto-merge`
     ++	is supported and will only use `--auto-merge` when available.  A
     ++	value of `false` avoids using `--auto-merge` altogether, and is the
     ++	default value.
      +
       mergetool.keepBackup::
       	After performing a merge, the original file with conflict markers
     @@ mergetools/meld: diff_cmd () {
      -	meld_path="${meld_path:-meld}"
      +# Get meld help message
      +init_meld_help_msg () {
     -+	if test -z "${meld_help_msg}"
     ++	if test -z "$meld_help_msg"
      +	then
      +		meld_path="$(git config mergetool.meld.path || echo meld)"
      +		meld_help_msg=$($meld_path --help 2>&1)
     @@ mergetools/meld: diff_cmd () {
      +# Check the features and set flags
      +check_meld_for_features () {
      +	# Check whether we should use 'meld --output <file>'
     -+	if test -z "${meld_has_output_option}"
     ++	if test -z "$meld_has_output_option"
       	then
      -		: use configured value
      -	elif "$meld_path" --help 2>&1 |
     @@ mergetools/meld: diff_cmd () {
      +		esac
      +	fi
      +	# Check whether we should use 'meld --auto-merge ...'
     -+	if test -z "${meld_use_auto_merge_option}"
     ++	if test -z "$meld_use_auto_merge_option"
       	then
      -		: old ones mention --output and new ones just say OPTION...
      -		meld_has_output_option=true
      -	else
      -		meld_has_output_option=false
      +		meld_use_auto_merge_option=$(git config mergetool.meld.useAutoMerge)
     -+		case "${meld_use_auto_merge_option,,*}" in
     -+		true|yes|on|1)
     -+			meld_use_auto_merge_option=true
     -+			;;
     -+		auto)
     -+			# testing the "--auto-merge" option only if config is "auto"
     -+			init_meld_help_msg
     ++		if test -z "$meld_use_auto_merge_option"
     ++		then
     ++			meld_use_auto_merge_option=false
     ++		else
     ++			bool_value=$(git config --bool mergetool.meld.useAutoMerge 2>/dev/null)
     ++			if test -n "$bool_value"
     ++			then
     ++				meld_use_auto_merge_option="$bool_value"
     ++			elif test "$meld_use_auto_merge_option" = "auto" \
     ++				|| test "$meld_use_auto_merge_option" = "Auto"
     ++			then
     ++				# testing the "--auto-merge" option only if config is "[Aa]uto"
     ++				init_meld_help_msg
      +
     -+			case "$meld_help_msg" in
     -+			*"--auto-merge"*)
     -+				meld_use_auto_merge_option=true
     -+				;;
     -+			*)
     ++				case "$meld_help_msg" in
     ++				*"--auto-merge"*)
     ++					meld_use_auto_merge_option=true
     ++					;;
     ++				*)
     ++					meld_use_auto_merge_option=false
     ++					;;
     ++				esac
     ++			else
      +				meld_use_auto_merge_option=false
     -+				;;
     -+			esac
     -+			;;
     -+		*)
     -+			meld_use_auto_merge_option=false
     -+			;;
     -+		esac
     ++			fi
     ++		fi
       	fi
       }


 Documentation/config/mergetool.txt | 10 ++++
 mergetools/meld                    | 85 ++++++++++++++++++++++++------
 2 files changed, 79 insertions(+), 16 deletions(-)

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
index 7a08470f88..7b9d917f7a 100644
--- a/mergetools/meld
+++ b/mergetools/meld
@@ -3,34 +3,87 @@ diff_cmd () {
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
+		if test -z "$meld_use_auto_merge_option"
+		then
+			meld_use_auto_merge_option=false
+		else
+			bool_value=$(git config --bool mergetool.meld.useAutoMerge 2>/dev/null)
+			if test -n "$bool_value"
+			then
+				meld_use_auto_merge_option="$bool_value"
+			elif test "$meld_use_auto_merge_option" = "auto" \
+				|| test "$meld_use_auto_merge_option" = "Auto"
+			then
+				# testing the "--auto-merge" option only if config is "[Aa]uto"
+				init_meld_help_msg
+
+				case "$meld_help_msg" in
+				*"--auto-merge"*)
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
