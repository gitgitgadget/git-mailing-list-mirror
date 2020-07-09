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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE6BC433DF
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 04:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 164992070E
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 04:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCWnh/wY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgGIE23 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 00:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgGIE23 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 00:28:29 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6521C061A0B
        for <git@vger.kernel.org>; Wed,  8 Jul 2020 21:28:28 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q5so809397wru.6
        for <git@vger.kernel.org>; Wed, 08 Jul 2020 21:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=PrXGV9cj1D2wB4YvUm1f25G/9FEy5zgIsB34BHh+7Cc=;
        b=OCWnh/wYLw2Bt+EyCyMktquxDDfDSGfvnAFCLsFh0DZB6PsPzP48JDGUMgPX6j+NIa
         vu28fV/vNoGaLX8v690liUVgR/29zel33f5Ksn0eCpHOH+TlEbA3zoVWUgshrub6eFAa
         PeTPQD6vuFiIwCYjHcuSendmYoftNgHVjvtTvfcqSUSZ9gqmALLiWTYfa2kvj/PDI0OK
         SmUqdxxepzVn7QQK45N9J5fX5mI8jAQY7A2Bei3LZGPS98IPhroNeU1xw21xozA09ug7
         ll4GQQK1noGVK4RthcGYihQ5Fsyi7bqBdPddMgr0/jPMD2EHw5CwBLl2ok1dY6nLNQDK
         Miow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=PrXGV9cj1D2wB4YvUm1f25G/9FEy5zgIsB34BHh+7Cc=;
        b=ZOH+AbvaZmYrXliAP8gEnYUmsmRtp5n8ejyTy0nBrlGrI7ai7vmxur15jPSdKBfl8S
         Qu81kcRLTe/GS5w+uWqUXo9uzNvn/3F0V3cnw0WQmX1KK1Ety8mI6U8hRYd7MmWh5LAR
         34f6mXFfjVSMBYB8wXIOudTyekuauRYLq5GZH0bAjXRU7s32qn/C1pT2+Tt9EOir89zT
         TyputjkJCYiq0pcU9D97Tl31jlOa2/rpYj/zBqAZ4CcPUVHwMif7ZKlSeB37zJ4Hb12V
         BIIiTN2uPE1NLGtdN1cFH732GgtN+wWD0N/EnXGG1z2BKQPFe/kXNU1mt3DfANDa0aTg
         HGkg==
X-Gm-Message-State: AOAM531RjAFDDnV6blFV2pqgMYupLszlL6G/RV98XBPpoGrD33YeuRN1
        8qzk1pLqWqvZ3Ls9TlaUCtrdQ6RX
X-Google-Smtp-Source: ABdhPJys9SrKXWG2e7y4TFwy0EJCPAEioXniylzGl4WyvD6FZAOtPYedKQf/D9DYRYu2AE/boZtFpw==
X-Received: by 2002:adf:91e1:: with SMTP id 88mr54186084wri.89.1594268907472;
        Wed, 08 Jul 2020 21:28:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m9sm2691352wml.45.2020.07.08.21.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 21:28:26 -0700 (PDT)
Message-Id: <pull.781.v14.git.git.1594268906195.gitgitgadget@gmail.com>
In-Reply-To: <pull.781.v13.git.git.1594254906647.gitgitgadget@gmail.com>
References: <pull.781.v13.git.git.1594254906647.gitgitgadget@gmail.com>
From:   "sunlin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Jul 2020 04:28:26 +0000
Subject: [PATCH v14] Support auto-merge for meld to follow the vim-diff
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-781%2Fsunlin7%2Fmaster-v14
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-781/sunlin7/master-v14
Pull-Request: https://github.com/git/git/pull/781

Range-diff vs v13:

 1:  b949e5721a ! 1:  ce4e4cbfc0 Support auto-merge for meld to follow the vim-diff behavior
     @@ mergetools/meld: diff_cmd () {
      +			esac
      +			;;
      +		*)
     -+			if meld_use_auto_merge_option=$(\
     ++			# try other boolean value with git
     ++			if meld_use_auto_merge_option=$(
      +				 git config --bool mergetool.meld.useAutoMerge)
      +			then
      +				: use normalized boolean value


 Documentation/config/mergetool.txt | 10 ++++
 mergetools/meld                    | 87 ++++++++++++++++++++++++------
 2 files changed, 81 insertions(+), 16 deletions(-)

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
index 7a08470f88..d95b4ee630 100644
--- a/mergetools/meld
+++ b/mergetools/meld
@@ -3,34 +3,89 @@ diff_cmd () {
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
+			# try other boolean value with git
+			if meld_use_auto_merge_option=$(
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
