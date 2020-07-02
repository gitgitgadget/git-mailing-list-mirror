Return-Path: <SRS0=gkpi=AN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257BDC433E0
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 00:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E95CC20748
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 00:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWqqcdDa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgGBAov (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 20:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgGBAov (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 20:44:51 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FCCC08C5C1
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 17:44:50 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o2so25652459wmh.2
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 17:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=rY2JlmSiRymAhujh4j3riFuRowqF9WJs8O+bKdzYN+4=;
        b=lWqqcdDajR90HkX/i0x3mcDK90PRQov6On+MXLU8zQMpsxjLpOLPUuS5bxir8UHxTH
         QC+KaXVTjuWwqpZurgl6I3SJ+enoRgAl9xAzjGf8uPwNW/EqRa4ob3RxWSRJ529tQha6
         01nd4r62zxrT2v7VhGmkpcXE38sVbMOOnrvx62iv1r/E1xdVEqZwATUYIhck/6WhkQF2
         G4+tEq/iukKLYQBPQr16040edEUW+Le6NNlWJzCdyCOran6JzGKaSLxtg3XtH6TI8Kqf
         d3zYtym2v/sPvIJ2WGxCnNNdzJ9/pLeBKJ+ZkPErmaX6nR/GdKtgyY84OQRHiV/9YBcP
         9chQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=rY2JlmSiRymAhujh4j3riFuRowqF9WJs8O+bKdzYN+4=;
        b=pb8bobt3IPXNNTEMEA5BVD1xNI0CfSY6c4zWgEPf8/noJqzDSYVudldtGi+ECxRAcD
         oLdZmJ3fG+UlCsQMhXNYH5zAW8cbOm8EZTff8hD4AFMvR+7+xCvDqHq40g12av+L3VkO
         yTlefgewuxaLqdDMvzREaDNAI/veNvuuANp+C1QoHesjonISIbRsxB9cCo9STgUpNLsp
         pY08059JVniV0Qn1XH05BPEuqOXY/749wK8sgxCaBYalwtvy3jFuIsJw8e3TuY363RYt
         0mpFe7jF2TqS+/f+Sq6/Rsyt2KhOFN1L6uFHfJSSExWNQdoRuXK3QyxveIDippW0THdq
         zuTQ==
X-Gm-Message-State: AOAM5328Zo8FSBoPbMAaOBVfV8Zvq71VLxQZhxMD0IQHaboclebLWT6Z
        Y0FiE7bCVbhMMm5qtmr/i+L1sKOV
X-Google-Smtp-Source: ABdhPJxyYaVlCfSSNFtkY943ReGbO0A0oSO3wIP4rAbItmv5R28MUB84QX5hKDjIk09Wsfqfw3j6Mg==
X-Received: by 2002:a05:600c:4109:: with SMTP id j9mr27952944wmi.157.1593650688968;
        Wed, 01 Jul 2020 17:44:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j14sm8891551wrs.75.2020.07.01.17.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 17:44:48 -0700 (PDT)
Message-Id: <pull.781.v6.git.git.1593650687697.gitgitgadget@gmail.com>
In-Reply-To: <pull.781.v5.git.git.1593587206520.gitgitgadget@gmail.com>
References: <pull.781.v5.git.git.1593587206520.gitgitgadget@gmail.com>
From:   "sunlin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Jul 2020 00:44:47 +0000
Subject: [PATCH v6] Support auto-merge for meld to follow the vim-diff
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

Make the mergetool used with "meld" backend behave similarly to how
"vimdiff" behavior by telling it to auto-merge parts without conflicts
and highlight the parts with conflicts when configuring
`mergetool.meld.useAutoMerge` with `true`, or `auto` for automatically
detecting the option.

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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-781%2Fsunlin7%2Fmaster-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-781/sunlin7/master-v6
Pull-Request: https://github.com/git/git/pull/781

Range-diff vs v5:

 1:  344817d579 ! 1:  63ee3406d2 Enable auto-merge for meld to follow the vim-diff beharior
     @@ Metadata
      Author: Lin Sun <lin.sun@zoom.us>
      
       ## Commit message ##
     -    Enable auto-merge for meld to follow the vim-diff beharior
     +    Support auto-merge for meld to follow the vim-diff behavior
      
     -    Make the mergetool used with "meld" backend behave similarly to
     -    how "vimdiff" behavior by telling it to auto-merge parts without
     -    conflicts and highlight the parts with conflicts when configuring
     -    `mergetool.meld.hasAutoMerge` with `true`, or `auto` for
     -    automatically detecting the option.
     +    Make the mergetool used with "meld" backend behave similarly to how
     +    "vimdiff" behavior by telling it to auto-merge parts without conflicts
     +    and highlight the parts with conflicts when configuring
     +    `mergetool.meld.useAutoMerge` with `true`, or `auto` for automatically
     +    detecting the option.
      
     +    Helped-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
     +    Helped-by: David Aguilar <davvid@gmail.com>
          Signed-off-by: Lin Sun <lin.sun@zoom.us>
      
       ## Documentation/config/mergetool.txt ##
     @@ Documentation/config/mergetool.txt: mergetool.meld.hasOutput::
       	to `true` tells Git to unconditionally use the `--output` option,
       	and `false` avoids using `--output`.
       
     -+mergetool.meld.hasAutoMerge::
     ++mergetool.meld.useAutoMerge::
      +	Older versions of `meld` do not support the `--auto-merge` option.
     -+	Setting `mergetool.meld.hasOutput` to `true` tells Git to
     -+	unconditionally use the `--auto-merge` option, and `false` avoids using
     -+	`--auto-merge`, and `auto` detect whether `meld` supports `--auto-merge`
     -+	by inspecting the output of `meld --help`, otherwise, follow meld's
     -+	default behavior.
     ++	Setting `mergetool.meld.useAutoMerge` to `true` tells Git to
     ++	unconditionally use the `--auto-merge` option with `meld`.  Setting
     ++	this value to `auto` makes git detect whether `--auto-merge` is
     ++	supported and will only use `--auto-merge` when available.  A value
     ++	of `false` avoids using `--auto-merge` altogether, and is the default
     ++	value.
      +
       mergetool.keepBackup::
       	After performing a merge, the original file with conflict markers
     @@ mergetools/meld: diff_cmd () {
      +	check_meld_for_features
      +
      +	option_auto_merge=
     -+	if test "$meld_has_auto_merge_option" = true
     ++	if test "$meld_use_auto_merge_option" = true
       	then
      -		check_meld_for_output_version
      +		option_auto_merge="--auto-merge"
     @@ mergetools/meld: diff_cmd () {
      -	meld_path="$(git config mergetool.meld.path)"
      -	meld_path="${meld_path:-meld}"
      +# Get meld help message
     -+get_meld_help_msg () {
     -+	meld_path="$(git config mergetool.meld.path || echo meld)"
     -+	$meld_path --help 2>&1
     ++init_meld_help_msg () {
     ++	if test -z "${meld_help_msg:+set}"
     ++	then
     ++		meld_path="$(git config mergetool.meld.path || echo meld)"
     ++		meld_help_msg=$($meld_path --help 2>&1)
     ++	fi
      +}
       
      -	if meld_has_output_option=$(git config --bool mergetool.meld.hasOutput)
     @@ mergetools/meld: diff_cmd () {
      -	elif "$meld_path" --help 2>&1 |
      -		grep -e '--output=' -e '\[OPTION\.\.\.\]' >/dev/null
      +		meld_has_output_option=$(git config --bool mergetool.meld.hasOutput)
     -+		if test "$meld_has_output_option" = true -o \
     -+			"$meld_has_output_option" = false
     -+		then
     ++		case "$meld_has_output_option" in
     ++		true|false)
      +			: use configured value
     -+		else
     -+			# treat meld_has_output_option as "auto"
     -+			if test -z "$meld_help_msg"
     -+			then
     -+				meld_help_msg="$(get_meld_help_msg)"
     -+			fi
     ++			;;
     ++		*)
     ++			: treat meld_has_output_option as "auto"
     ++			init_meld_help_msg
      +
      +			case "$meld_help_msg" in
     -+				*"--output="* | *"[OPTION"???"]"*)
     -+					# old ones mention --output and new ones just say OPTION...
     -+					meld_has_output_option=true ;;
     -+				*)
     -+					meld_has_output_option=false ;;
     ++			*"--output="* | *'[OPTION...]'*)
     ++				# All version that has [OPTION...] supports --output
     ++				meld_has_output_option=true
     ++				;;
     ++			*)
     ++				meld_has_output_option=false
     ++				;;
      +			esac
     -+		fi
     ++			;;
     ++		esac
      +	fi
      +	# Check whether we should use 'meld --auto-merge ...'
     -+	if test -z "${meld_has_auto_merge_option:+set}"
     ++	if test -z "${meld_use_auto_merge_option:+set}"
       	then
      -		: old ones mention --output and new ones just say OPTION...
      -		meld_has_output_option=true
      -	else
      -		meld_has_output_option=false
     -+		meld_has_auto_merge_option=$(git config mergetool.meld.hasAutoMerge)
     -+		if test "$meld_has_auto_merge_option" = auto
     -+		then
     ++		meld_use_auto_merge_option=$(git config mergetool.meld.useAutoMerge)
     ++		case "$meld_use_auto_merge_option" in
     ++		[Tt]rue|[Yy]es|[Oo]n|1)
     ++			meld_use_auto_merge_option=true
     ++			;;
     ++		auto)
      +			# testing the "--auto-merge" option only if config is "auto"
     -+			if test -z "$meld_help_msg"
     -+			then
     -+					meld_help_msg="$(get_meld_help_msg)"
     -+			fi
     ++			init_meld_help_msg
      +
      +			case "$meld_help_msg" in
     -+				*"--auto-merge"*)
     -+					: old ones mention --output and new ones just say OPTION...
     -+					meld_has_auto_merge_option=true ;;
     -+				*)
     -+					meld_has_auto_merge_option=false ;;
     ++			*"--auto-merge"*)
     ++				meld_use_auto_merge_option=true
     ++				;;
     ++			*)
     ++				meld_use_auto_merge_option=false
     ++				;;
      +			esac
     -+		fi
     ++			;;
     ++		*)
     ++			meld_use_auto_merge_option=false
     ++			;;
     ++		esac
       	fi
       }


 Documentation/config/mergetool.txt |  9 ++++
 mergetools/meld                    | 80 ++++++++++++++++++++++++------
 2 files changed, 73 insertions(+), 16 deletions(-)

diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
index 09ed31dbfa..625ad34230 100644
--- a/Documentation/config/mergetool.txt
+++ b/Documentation/config/mergetool.txt
@@ -30,6 +30,15 @@ mergetool.meld.hasOutput::
 	to `true` tells Git to unconditionally use the `--output` option,
 	and `false` avoids using `--output`.
 
+mergetool.meld.useAutoMerge::
+	Older versions of `meld` do not support the `--auto-merge` option.
+	Setting `mergetool.meld.useAutoMerge` to `true` tells Git to
+	unconditionally use the `--auto-merge` option with `meld`.  Setting
+	this value to `auto` makes git detect whether `--auto-merge` is
+	supported and will only use `--auto-merge` when available.  A value
+	of `false` avoids using `--auto-merge` altogether, and is the default
+	value.
+
 mergetool.keepBackup::
 	After performing a merge, the original file with conflict markers
 	can be saved as a file with a `.orig` extension.  If this variable
diff --git a/mergetools/meld b/mergetools/meld
index 7a08470f88..5bc03f564a 100644
--- a/mergetools/meld
+++ b/mergetools/meld
@@ -3,34 +3,82 @@ diff_cmd () {
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
+	if test -z "${meld_help_msg:+set}"
+	then
+		meld_path="$(git config mergetool.meld.path || echo meld)"
+		meld_help_msg=$($meld_path --help 2>&1)
+	fi
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
+		case "$meld_has_output_option" in
+		true|false)
+			: use configured value
+			;;
+		*)
+			: treat meld_has_output_option as "auto"
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
+	if test -z "${meld_use_auto_merge_option:+set}"
 	then
-		: old ones mention --output and new ones just say OPTION...
-		meld_has_output_option=true
-	else
-		meld_has_output_option=false
+		meld_use_auto_merge_option=$(git config mergetool.meld.useAutoMerge)
+		case "$meld_use_auto_merge_option" in
+		[Tt]rue|[Yy]es|[Oo]n|1)
+			meld_use_auto_merge_option=true
+			;;
+		auto)
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
+			meld_use_auto_merge_option=false
+			;;
+		esac
 	fi
 }

base-commit: 07d8ea56f2ecb64b75b92264770c0a664231ce17
-- 
gitgitgadget
