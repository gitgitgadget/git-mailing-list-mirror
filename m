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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D683C433E1
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 06:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43E9B20771
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 06:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sV2Z57ml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgGGGSD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgGGGSC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 02:18:02 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B21C061755
        for <git@vger.kernel.org>; Mon,  6 Jul 2020 23:18:02 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q15so41978814wmj.2
        for <git@vger.kernel.org>; Mon, 06 Jul 2020 23:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=/lwTKF5iaQdnxI1YSpnNzlop+KN1F35+y6osIRWK/cs=;
        b=sV2Z57mlZE2G+y9PmRtVqSAC737DkjBb9d3cltMSfjMncj5ffkSTDux4nbQZFpbYT8
         1CUPEhYeLSHfg9bI//WKXceMlPefC+TjZ5eOSc/CysCy+DfBDeVdKQouSx6UgDsE3lCC
         TSVAX/ykHDJLOI2QTBtEtHCj87YN5MhBK5I6mtQbe4aQ3TfF1ZAZyEJ4M4UE/mTuDlBs
         kEOcrApSw/RHFpDRsrFUrHAnAKXhm9wEBtGnvybNUng48OULGdpse5scH1YTpTJ5rBSJ
         le/bUpm3IOmyiCLIM4nbwiYz2Zfj93ntjSb6a2K85V9PwcJ2n2SO3QkOuZC1fJCEQVcK
         etsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=/lwTKF5iaQdnxI1YSpnNzlop+KN1F35+y6osIRWK/cs=;
        b=IlSV6fOHvv4mxBpjWlhXQ8xfmKiYVbCVbG8xuvc4NpTuXNPoSdJCVRVfy9qp/5VeVA
         1jCw2oSvJDsAIZikOpk2LzuTZrJ8EgiI7ir9vM0NiJ3PN7mzoZgFWx5JH4WE1pkZ4spv
         4tmZR5LaX8b19UWWLjlEvE4nKuD4lsrZ5l5X3Za3M/I2ah52cAPdtBVuK462NnqxxyrS
         zAbhBqgv5hlLMCZMX56yqyoWIYsl8KsqH1CoYx2U6b4PqgVhqVfPI3fQz8l6FVEqZma0
         Mzfq1w9/cpEWHsnu6h5c5E+lHVchOMjKuLhOXdWjWNTKH7UYk1ygUeFMXebn1g3IMNUR
         XQIQ==
X-Gm-Message-State: AOAM5324D84H35Bk1jlrIerHJ2VgY89GmE+TwOqUQVRpbQrh7vRKsbA5
        oWJRXtdjyeh8P6LX+1LgJOlkGdpo
X-Google-Smtp-Source: ABdhPJxcJEDROGLszfKuGJh84x/VsbumdEpMB3bPQSyQKlD5kHyreSBzl8HVSCSqtqOocFHv0KwRDA==
X-Received: by 2002:a1c:6308:: with SMTP id x8mr2583397wmb.92.1594102681047;
        Mon, 06 Jul 2020 23:18:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o9sm26716945wrs.1.2020.07.06.23.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 23:18:00 -0700 (PDT)
Message-Id: <pull.781.v10.git.git.1594102679750.gitgitgadget@gmail.com>
In-Reply-To: <pull.781.v9.git.git.1594002423685.gitgitgadget@gmail.com>
References: <pull.781.v9.git.git.1594002423685.gitgitgadget@gmail.com>
From:   "sunlin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jul 2020 06:17:59 +0000
Subject: [PATCH v10] Support auto-merge for meld to follow the vim-diff
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-781%2Fsunlin7%2Fmaster-v10
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-781/sunlin7/master-v10
Pull-Request: https://github.com/git/git/pull/781

Range-diff vs v9:

 1:  95586fb2c2 ! 1:  a4f1b8c2fa Support auto-merge for meld to follow the vim-diff behavior
     @@ Commit message
          for detecting the `--auto-merge` option automatically.
      
          Helped-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     -    Helped-by: Junio C Hamano <gitster@pobox.com>
          Helped-by: David Aguilar <davvid@gmail.com>
          Signed-off-by: Lin Sun <lin.sun@zoom.us>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## Documentation/config/mergetool.txt ##
      @@ Documentation/config/mergetool.txt: mergetool.meld.hasOutput::
     @@ Documentation/config/mergetool.txt: mergetool.meld.hasOutput::
       
      +mergetool.meld.useAutoMerge::
      +	When the `--auto-merge` is given, meld will merge all non-conflicting
     -+	parts automatically, highlight the conflicting parts and waiting for
     ++	parts automatically, highlight the conflicting parts and wait for
      +	user decision.  Setting `mergetool.meld.useAutoMerge` to `true` tells
      +	Git to unconditionally use the `--auto-merge` option with `meld`.
      +	Setting this value to `auto` makes git detect whether `--auto-merge`
     @@ mergetools/meld: diff_cmd () {
      +		"")
      +			meld_use_auto_merge_option=false
      +			;;
     -+		[Aa]uto)
     -+			# testing the "--auto-merge" option only if config is "[Aa]uto"
     ++		[Tt]ure|TRUE)
     ++			meld_use_auto_merge_option=true
     ++			;;
     ++		[Ff]alse|FALSE)
     ++			meld_use_auto_merge_option=false
     ++			;;
     ++		[Aa]uto|AUTO)
     ++			# testing the "--auto-merge" option only if config is "auto"
      +			init_meld_help_msg
      +
      +			case "$meld_help_msg" in
     @@ mergetools/meld: diff_cmd () {
      +			esac
      +			;;
      +		*)
     ++			# try detect boolean for 'on'||'yes'||numberic value
      +			bool_value=$(git config --bool mergetool.meld.useAutoMerge 2>/dev/null)
      +			if test -n "$bool_value"
      +			then


 Documentation/config/mergetool.txt | 10 ++++
 mergetools/meld                    | 93 +++++++++++++++++++++++++-----
 2 files changed, 87 insertions(+), 16 deletions(-)

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
index 7a08470f88..0250c1554a 100644
--- a/mergetools/meld
+++ b/mergetools/meld
@@ -3,34 +3,95 @@ diff_cmd () {
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
+		[Tt]ure|TRUE)
+			meld_use_auto_merge_option=true
+			;;
+		[Ff]alse|FALSE)
+			meld_use_auto_merge_option=false
+			;;
+		[Aa]uto|AUTO)
+			# testing the "--auto-merge" option only if config is "auto"
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
+			# try detect boolean for 'on'||'yes'||numberic value
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
