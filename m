Return-Path: <SRS0=CKFy=AO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF209C433E0
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 03:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7AA9207E8
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 03:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKP7o1BF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgGCD0t (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 23:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGCD0t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 23:26:49 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C139FC08C5C1
        for <git@vger.kernel.org>; Thu,  2 Jul 2020 20:26:48 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w3so19320035wmi.4
        for <git@vger.kernel.org>; Thu, 02 Jul 2020 20:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=SuN6eWHvCeqRM35cnnziAiEQb/Ol8Z4Vib9ANVpkuOc=;
        b=LKP7o1BFo1gQHmDqat/amEacizI7Dp8wJA6cS0rBvRHOL4MdTt/kKe/gGGSLrdiO22
         DQMGG6bfoSi5xG8W5+eJDFptZvHpSXKAL0t+zsNoKemKiDNH4i35a0bAjTk1ZXOO8HsD
         mabdspPOlMqmwYN78/YnSM/g/m52nuNSaN0Z/qm3WK0cLktAx+x605ihRZ6vDo9Xd2PJ
         YI5gwS1oaSLq7nuYHJdsFmHqkQvctVGH3zevBiXjDXAfhmPOhutDr+CTcD1MQZYdMqi2
         eH9t2FmGJqp2wmIO1YXTKQzAZoSusle+qNHbXAu6I2zxcD9/fUfqC2Hvdx0rrWs3NB6f
         +G9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=SuN6eWHvCeqRM35cnnziAiEQb/Ol8Z4Vib9ANVpkuOc=;
        b=RmYFvI1DOkNQfPbO+ASRnWbGYmAx5vF5ntU9d4uZPQDXpWyi6qpO5MtpnBV5ZCzeH5
         ry1m6txSQmD+wAY1w/9CzsF25e+PQW++rfdMZdfq+joK5Zk97MMBf6wDdnYhEvHATyVd
         6RR3xW+x7u0+dq/DXJUHSB4uwQUtcr3XqZNMsz+TqnxojnrvwBMdUyQLQcr72VM26KW9
         DiuXdb6sDiYjsjVwa4t+663usdkLMjBiwO7GNV32763tQvuealrPgjMXswW1SLvWY2ca
         qy7WrsmBbGoVON7dp643Vd6sAxFM9PVYfQTijMQywDxzk8tNm8a7bEzNjvkikepc1GeW
         crAg==
X-Gm-Message-State: AOAM530mSmgvZ09up1RpDDSDK45wTCXzHT3WQ0qAm4Ud7nx1fbxewqA2
        ogH2mNkBxD7Z/4FEfAAqZ3aXBLDb
X-Google-Smtp-Source: ABdhPJwo7ydZa/pe+qDZKmHTFXOkxmFHPg658/Bq2FOdX5Ih+uN/vNyoUs1AWDojle1GFNhw701zQg==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr35837528wmb.61.1593746807124;
        Thu, 02 Jul 2020 20:26:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y16sm12555561wro.71.2020.07.02.20.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 20:26:46 -0700 (PDT)
Message-Id: <pull.781.v7.git.git.1593746805771.gitgitgadget@gmail.com>
In-Reply-To: <pull.781.v6.git.git.1593650687697.gitgitgadget@gmail.com>
References: <pull.781.v6.git.git.1593650687697.gitgitgadget@gmail.com>
From:   "sunlin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Jul 2020 03:26:45 +0000
Subject: [PATCH v7] Support auto-merge for meld to follow the vim-diff
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

Make the mergetool used with "meld" backend behave similarly to
"vimdiff" by telling it to auto-merge non-conflicting parts and
highlight the conflicting parts when `mergetool.meld.useAutoMerge` is
configured with `true`, or `auto` for detecting the `--auto-merge`
option automatically.

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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-781%2Fsunlin7%2Fmaster-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-781/sunlin7/master-v7
Pull-Request: https://github.com/git/git/pull/781

Range-diff vs v6:

 1:  63ee3406d2 ! 1:  ec2b49b9b8 Support auto-merge for meld to follow the vim-diff behavior
     @@ Metadata
       ## Commit message ##
          Support auto-merge for meld to follow the vim-diff behavior
      
     -    Make the mergetool used with "meld" backend behave similarly to how
     -    "vimdiff" behavior by telling it to auto-merge parts without conflicts
     -    and highlight the parts with conflicts when configuring
     -    `mergetool.meld.useAutoMerge` with `true`, or `auto` for automatically
     -    detecting the option.
     +    Make the mergetool used with "meld" backend behave similarly to
     +    "vimdiff" by telling it to auto-merge non-conflicting parts and
     +    highlight the conflicting parts when `mergetool.meld.useAutoMerge` is
     +    configured with `true`, or `auto` for detecting the `--auto-merge`
     +    option automatically.
      
          Helped-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
          Helped-by: Junio C Hamano <gitster@pobox.com>
     @@ Documentation/config/mergetool.txt: mergetool.meld.hasOutput::
       	and `false` avoids using `--output`.
       
      +mergetool.meld.useAutoMerge::
     -+	Older versions of `meld` do not support the `--auto-merge` option.
     -+	Setting `mergetool.meld.useAutoMerge` to `true` tells Git to
     -+	unconditionally use the `--auto-merge` option with `meld`.  Setting
     -+	this value to `auto` makes git detect whether `--auto-merge` is
     -+	supported and will only use `--auto-merge` when available.  A value
     -+	of `false` avoids using `--auto-merge` altogether, and is the default
     -+	value.
     ++	When the `--auto-merge` is given, meld will merges all non-conflicting
     ++	part automatically, highlight the conflicting part and waiting for user
     ++	decision.  Setting `mergetool.meld.useAutoMerge` to `true` tells Git to
     ++	unconditionally use the `--auto-merge` option with `meld`.  Setting this
     ++	value to `auto` makes git detect whether `--auto-merge` is supported and
     ++	will only use `--auto-merge` when available.  A value of `false` avoids
     ++	using `--auto-merge` altogether, and is the default value.
      +
       mergetool.keepBackup::
       	After performing a merge, the original file with conflict markers
     @@ mergetools/meld: diff_cmd () {
      -	meld_path="${meld_path:-meld}"
      +# Get meld help message
      +init_meld_help_msg () {
     -+	if test -z "${meld_help_msg:+set}"
     ++	if test -z "${meld_help_msg}"
      +	then
      +		meld_path="$(git config mergetool.meld.path || echo meld)"
      +		meld_help_msg=$($meld_path --help 2>&1)
     @@ mergetools/meld: diff_cmd () {
      +# Check the features and set flags
      +check_meld_for_features () {
      +	# Check whether we should use 'meld --output <file>'
     -+	if test -z "${meld_has_output_option:+set}"
     ++	if test -z "${meld_has_output_option}"
       	then
      -		: use configured value
      -	elif "$meld_path" --help 2>&1 |
     @@ mergetools/meld: diff_cmd () {
      +			: use configured value
      +			;;
      +		*)
     -+			: treat meld_has_output_option as "auto"
     ++			: empty or invalid configured value, detecting "--output" automatically
      +			init_meld_help_msg
      +
      +			case "$meld_help_msg" in
     @@ mergetools/meld: diff_cmd () {
      +		esac
      +	fi
      +	# Check whether we should use 'meld --auto-merge ...'
     -+	if test -z "${meld_use_auto_merge_option:+set}"
     ++	if test -z "${meld_use_auto_merge_option}"
       	then
      -		: old ones mention --output and new ones just say OPTION...
      -		meld_has_output_option=true
      -	else
      -		meld_has_output_option=false
      +		meld_use_auto_merge_option=$(git config mergetool.meld.useAutoMerge)
     -+		case "$meld_use_auto_merge_option" in
     -+		[Tt]rue|[Yy]es|[Oo]n|1)
     ++		case "${meld_use_auto_merge_option,,*}" in
     ++		true|yes|on|1)
      +			meld_use_auto_merge_option=true
      +			;;
      +		auto)


 Documentation/config/mergetool.txt |  9 ++++
 mergetools/meld                    | 80 ++++++++++++++++++++++++------
 2 files changed, 73 insertions(+), 16 deletions(-)

diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
index 09ed31dbfa..b7657734a0 100644
--- a/Documentation/config/mergetool.txt
+++ b/Documentation/config/mergetool.txt
@@ -30,6 +30,15 @@ mergetool.meld.hasOutput::
 	to `true` tells Git to unconditionally use the `--output` option,
 	and `false` avoids using `--output`.
 
+mergetool.meld.useAutoMerge::
+	When the `--auto-merge` is given, meld will merges all non-conflicting
+	part automatically, highlight the conflicting part and waiting for user
+	decision.  Setting `mergetool.meld.useAutoMerge` to `true` tells Git to
+	unconditionally use the `--auto-merge` option with `meld`.  Setting this
+	value to `auto` makes git detect whether `--auto-merge` is supported and
+	will only use `--auto-merge` when available.  A value of `false` avoids
+	using `--auto-merge` altogether, and is the default value.
+
 mergetool.keepBackup::
 	After performing a merge, the original file with conflict markers
 	can be saved as a file with a `.orig` extension.  If this variable
diff --git a/mergetools/meld b/mergetools/meld
index 7a08470f88..5e6b50d480 100644
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
+	if test -z "${meld_help_msg}"
+	then
+		meld_path="$(git config mergetool.meld.path || echo meld)"
+		meld_help_msg=$($meld_path --help 2>&1)
+	fi
+}
 
-	if meld_has_output_option=$(git config --bool mergetool.meld.hasOutput)
+# Check the features and set flags
+check_meld_for_features () {
+	# Check whether we should use 'meld --output <file>'
+	if test -z "${meld_has_output_option}"
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
+	if test -z "${meld_use_auto_merge_option}"
 	then
-		: old ones mention --output and new ones just say OPTION...
-		meld_has_output_option=true
-	else
-		meld_has_output_option=false
+		meld_use_auto_merge_option=$(git config mergetool.meld.useAutoMerge)
+		case "${meld_use_auto_merge_option,,*}" in
+		true|yes|on|1)
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
