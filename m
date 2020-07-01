Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3D5C433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 07:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC8C020663
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 07:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1QyfX2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgGAHGu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgGAHGu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 03:06:50 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C57C061755
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 00:06:49 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j4so20197363wrp.10
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 00:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Qk3RbKn/b30KgxNR66P6xQzYm4Ych45pxhQgoUA1zo8=;
        b=G1QyfX2z6vRGm9iWd9FPzILcTuTKjYm2IndM7+gl2aYbA6ZW7kMb1B6Wy8G1D3ngs0
         BFemmq194ggFPluSbUvH4SeCcIMmTzkBhB44wT+j7Nii5QRjYrQXnp93letk1flypTYA
         KEOPVwuS6oL6kPvyvBVhJNKm/GimgI0K7VxUjWGL6YiCe1ZB6LIpy6Sut61QbCklTn9D
         XFnRI9iVPCeHjETFC1Zd6ZQ2a0ujiFXk7U0T/bW0Go+QnQ2Mq0nojVwyxAO8gGJ1md79
         IlvAEbiZDxMEni4Q2VI6PP9DN4qF2lyfJuLz7potHLXfqFF76gSxOoIfrS03EoKtdxfI
         TThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Qk3RbKn/b30KgxNR66P6xQzYm4Ych45pxhQgoUA1zo8=;
        b=cGOn54Tr+XyRR0DGWaCcUq8NCaHNs5EscVnBoBg81ZBLI5jA0YgVy7q7sqX19Z/l4V
         iJJlnn1ogT5ujtemuWfvoW9S7G9Mrt/waNDAxRrg29qfMkCGYPvuKx8NHYC9Xg2YkWz7
         xF/cRxHS9MUNdjj/r4cBT21AKwmHHohJKQCg6Pc0nx4RzoSH063ejy7Avs9GiRAa+CCr
         OjW081idEOgNJAG7hCnrIHNhnEoxqXFj/n0gJbjSxIDro0OfzOxGX4JOlYMktSphQ/Wb
         PxuSxLr1A+jTnwPk0Ee9hu6eRUZC+GzVnYJZSI0F2KDhITjLA8S5/MlIDpYUkBraFXE7
         895g==
X-Gm-Message-State: AOAM5300UCcTMsR+O0yr414b5sNbgtfgIraof1m6Q1S4QrArdMHr0VtY
        IGeCHHG9M7mtjEy6ChLSrti6krRAuok=
X-Google-Smtp-Source: ABdhPJynexuJrWj7CCV6Iu+7284CjXZkbtTDCmNlFerAKIgQk79PrO4tAlLXscSJOwc/uIMd2KtqPg==
X-Received: by 2002:a5d:6412:: with SMTP id z18mr24771627wru.310.1593587208159;
        Wed, 01 Jul 2020 00:06:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u84sm5936450wme.42.2020.07.01.00.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 00:06:47 -0700 (PDT)
Message-Id: <pull.781.v5.git.git.1593587206520.gitgitgadget@gmail.com>
In-Reply-To: <pull.781.v4.git.git.1593516397380.gitgitgadget@gmail.com>
References: <pull.781.v4.git.git.1593516397380.gitgitgadget@gmail.com>
From:   "sunlin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Jul 2020 07:06:46 +0000
Subject: [PATCH v5] Enable auto-merge for meld to follow the vim-diff beharior
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sunlin <sunlin7@yahoo.com>, Lin Sun <lin.sun@zoom.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lin Sun <lin.sun@zoom.us>

Make the mergetool used with "meld" backend behave similarly to
how "vimdiff" behavior by telling it to auto-merge parts without
conflicts and highlight the parts with conflicts when configuring
`mergetool.meld.hasAutoMerge` with `true`, or `auto` for
automatically detecting the option.

Signed-off-by: Lin Sun <lin.sun@zoom.us>
---
    Enable auto-merge for meld to follow the vimdiff beharior
    
    Hi, the mergetool "meld" does NOT merge the no-conflict changes, while
    the mergetool "vimdiff" will merge the no-conflict changes and highlight
    the conflict parts. This patch will make the mergetool "meld" similar to
    "vimdiff", auto-merge the no-conflict changes, highlight conflict parts.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-781%2Fsunlin7%2Fmaster-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-781/sunlin7/master-v5
Pull-Request: https://github.com/git/git/pull/781

Range-diff vs v4:

 1:  93ae3ec011 ! 1:  344817d579 Enable auto-merge for meld to follow the vim-diff beharior
     @@
       ## Metadata ##
     -Author: lin.sun <lin.sun@zoom.us>
     +Author: Lin Sun <lin.sun@zoom.us>
      
       ## Commit message ##
          Enable auto-merge for meld to follow the vim-diff beharior
      
          Make the mergetool used with "meld" backend behave similarly to
     -    how "vimdiff" beheaves by telling it to auto-merge parts without
     -    conflicts and highlight the parts with conflicts.
     +    how "vimdiff" behavior by telling it to auto-merge parts without
     +    conflicts and highlight the parts with conflicts when configuring
     +    `mergetool.meld.hasAutoMerge` with `true`, or `auto` for
     +    automatically detecting the option.
      
     -    Signed-off-by: lin.sun <lin.sun@zoom.us>
     +    Signed-off-by: Lin Sun <lin.sun@zoom.us>
     +
     + ## Documentation/config/mergetool.txt ##
     +@@ Documentation/config/mergetool.txt: mergetool.meld.hasOutput::
     + 	to `true` tells Git to unconditionally use the `--output` option,
     + 	and `false` avoids using `--output`.
     + 
     ++mergetool.meld.hasAutoMerge::
     ++	Older versions of `meld` do not support the `--auto-merge` option.
     ++	Setting `mergetool.meld.hasOutput` to `true` tells Git to
     ++	unconditionally use the `--auto-merge` option, and `false` avoids using
     ++	`--auto-merge`, and `auto` detect whether `meld` supports `--auto-merge`
     ++	by inspecting the output of `meld --help`, otherwise, follow meld's
     ++	default behavior.
     ++
     + mergetool.keepBackup::
     + 	After performing a merge, the original file with conflict markers
     + 	can be saved as a file with a `.orig` extension.  If this variable
      
       ## mergetools/meld ##
      @@ mergetools/meld: diff_cmd () {
     @@ mergetools/meld: diff_cmd () {
      +# Get meld help message
      +get_meld_help_msg () {
      +	meld_path="$(git config mergetool.meld.path || echo meld)"
     -+  $meld_path --help 2>&1
     ++	$meld_path --help 2>&1
      +}
       
      -	if meld_has_output_option=$(git config --bool mergetool.meld.hasOutput)
     @@ mergetools/meld: diff_cmd () {
      -		grep -e '--output=' -e '\[OPTION\.\.\.\]' >/dev/null
      +		meld_has_output_option=$(git config --bool mergetool.meld.hasOutput)
      +		if test "$meld_has_output_option" = true -o \
     -+						"$meld_has_output_option" = false
     ++			"$meld_has_output_option" = false
      +		then
      +			: use configured value
     -+		else												# treat meld_has_output_option as "auto"
     ++		else
     ++			# treat meld_has_output_option as "auto"
      +			if test -z "$meld_help_msg"
      +			then
      +				meld_help_msg="$(get_meld_help_msg)"
      +			fi
      +
     -+			if echo "$meld_help_msg" |
     -+							grep -e '--output=' -e '\[OPTION\.\.\.\]' >/dev/null
     -+			then
     -+				: old ones mention --output and new ones just say OPTION...
     -+				meld_has_output_option=true
     -+			else
     -+				meld_has_output_option=false
     -+			fi
     ++			case "$meld_help_msg" in
     ++				*"--output="* | *"[OPTION"???"]"*)
     ++					# old ones mention --output and new ones just say OPTION...
     ++					meld_has_output_option=true ;;
     ++				*)
     ++					meld_has_output_option=false ;;
     ++			esac
      +		fi
      +	fi
      +	# Check whether we should use 'meld --auto-merge ...'
     @@ mergetools/meld: diff_cmd () {
      -		meld_has_output_option=true
      -	else
      -		meld_has_output_option=false
     -+		meld_has_auto_merge_option=$(git config --bool mergetool.meld.hasAutoMerge)
     -+		if test "$meld_has_auto_merge_option" = true -o \
     -+						"$meld_has_auto_merge_option" = false
     ++		meld_has_auto_merge_option=$(git config mergetool.meld.hasAutoMerge)
     ++		if test "$meld_has_auto_merge_option" = auto
      +		then
     -+			: use configured value
     -+		else												# treat meld_has_auto_merge_option as "auto"
     ++			# testing the "--auto-merge" option only if config is "auto"
      +			if test -z "$meld_help_msg"
      +			then
      +					meld_help_msg="$(get_meld_help_msg)"
      +			fi
      +
     -+			if echo "$meld_help_msg" | grep -e '--auto-merge' >/dev/null
     -+			then
     -+					meld_has_auto_merge_option=true
     -+			else
     -+				meld_has_auto_merge_option=false
     -+			fi
     ++			case "$meld_help_msg" in
     ++				*"--auto-merge"*)
     ++					: old ones mention --output and new ones just say OPTION...
     ++					meld_has_auto_merge_option=true ;;
     ++				*)
     ++					meld_has_auto_merge_option=false ;;
     ++			esac
      +		fi
       	fi
       }


 Documentation/config/mergetool.txt |  8 ++++
 mergetools/meld                    | 72 +++++++++++++++++++++++-------
 2 files changed, 64 insertions(+), 16 deletions(-)

diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
index 09ed31dbfa..9a74bd98dc 100644
--- a/Documentation/config/mergetool.txt
+++ b/Documentation/config/mergetool.txt
@@ -30,6 +30,14 @@ mergetool.meld.hasOutput::
 	to `true` tells Git to unconditionally use the `--output` option,
 	and `false` avoids using `--output`.
 
+mergetool.meld.hasAutoMerge::
+	Older versions of `meld` do not support the `--auto-merge` option.
+	Setting `mergetool.meld.hasOutput` to `true` tells Git to
+	unconditionally use the `--auto-merge` option, and `false` avoids using
+	`--auto-merge`, and `auto` detect whether `meld` supports `--auto-merge`
+	by inspecting the output of `meld --help`, otherwise, follow meld's
+	default behavior.
+
 mergetool.keepBackup::
 	After performing a merge, the original file with conflict markers
 	can be saved as a file with a `.orig` extension.  If this variable
diff --git a/mergetools/meld b/mergetools/meld
index 7a08470f88..9ee835b1e5 100644
--- a/mergetools/meld
+++ b/mergetools/meld
@@ -3,34 +3,74 @@ diff_cmd () {
 }
 
 merge_cmd () {
-	if test -z "${meld_has_output_option:+set}"
+	check_meld_for_features
+
+	option_auto_merge=
+	if test "$meld_has_auto_merge_option" = true
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
+get_meld_help_msg () {
+	meld_path="$(git config mergetool.meld.path || echo meld)"
+	$meld_path --help 2>&1
+}
 
-	if meld_has_output_option=$(git config --bool mergetool.meld.hasOutput)
+# Check the features and set flags
+check_meld_for_features () {
+	# Check whether we should use 'meld --output <file>'
+	if test -z "${meld_has_output_option:+set}"
 	then
-		: use configured value
-	elif "$meld_path" --help 2>&1 |
-		grep -e '--output=' -e '\[OPTION\.\.\.\]' >/dev/null
+		meld_has_output_option=$(git config --bool mergetool.meld.hasOutput)
+		if test "$meld_has_output_option" = true -o \
+			"$meld_has_output_option" = false
+		then
+			: use configured value
+		else
+			# treat meld_has_output_option as "auto"
+			if test -z "$meld_help_msg"
+			then
+				meld_help_msg="$(get_meld_help_msg)"
+			fi
+
+			case "$meld_help_msg" in
+				*"--output="* | *"[OPTION"???"]"*)
+					# old ones mention --output and new ones just say OPTION...
+					meld_has_output_option=true ;;
+				*)
+					meld_has_output_option=false ;;
+			esac
+		fi
+	fi
+	# Check whether we should use 'meld --auto-merge ...'
+	if test -z "${meld_has_auto_merge_option:+set}"
 	then
-		: old ones mention --output and new ones just say OPTION...
-		meld_has_output_option=true
-	else
-		meld_has_output_option=false
+		meld_has_auto_merge_option=$(git config mergetool.meld.hasAutoMerge)
+		if test "$meld_has_auto_merge_option" = auto
+		then
+			# testing the "--auto-merge" option only if config is "auto"
+			if test -z "$meld_help_msg"
+			then
+					meld_help_msg="$(get_meld_help_msg)"
+			fi
+
+			case "$meld_help_msg" in
+				*"--auto-merge"*)
+					: old ones mention --output and new ones just say OPTION...
+					meld_has_auto_merge_option=true ;;
+				*)
+					meld_has_auto_merge_option=false ;;
+			esac
+		fi
 	fi
 }

base-commit: 07d8ea56f2ecb64b75b92264770c0a664231ce17
-- 
gitgitgadget
