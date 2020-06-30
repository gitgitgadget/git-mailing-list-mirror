Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29600C433E0
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 11:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F104920720
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 11:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uafRv5y1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbgF3L0l (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 07:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgF3L0k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 07:26:40 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146AAC061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 04:26:40 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f18so11684856wrs.0
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 04:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4NafHl2FiNT32aE1atjJFizf2TNRIsXyUx4MFQVUEG8=;
        b=uafRv5y1sajxYXAfC33zhCtKfjpoyOZxMHG5sDpRogWcV1JS55YmhNDKVblG3wS1gX
         TqvjJsf1xl9Op9ejnnVhi9rmrtm3rWn8av3wZXg4ZXeHS3foLDkxgX8L4+TsK3AGo7B3
         wLdNsxBNyqlj88Kg3+f/cvvsWfg1j3Ndr9ZqQBA2fMINnoKfbN/XfyMFC9W1DGEXlQAi
         ABwApqw7qcCAsEnbBlIpEookRjQLQS74XCY77CJUXdFQ4gJv74oGQ69TDg3bHlgb1cbC
         kJ5L42NgF4Chsco8N1to3gtSQ5ziWa076qJnMty4p1nVQ2Fhz7juTdDsEYHBsQDudQZz
         oxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4NafHl2FiNT32aE1atjJFizf2TNRIsXyUx4MFQVUEG8=;
        b=K0nOf81Q3OuiiXwnlPfjLx5zEDPv9DrfuRo2pDvuFuTqpxSnCdd9xYqHWfXxyUXCBf
         j/BYbueVvpogFWwrtc1gZ8PXBEdW5QN1lv8OY844DkSNkYO9m7QEdgexlRRpiBe/Muup
         PA2nxoKOHofdHDj9RiNFMWixrlYG5nMCduRrNs7LCZprWAoSZBQbpJ0f/4sO9WfpvDma
         HqCR6ZTW0ewT9bpnov6No2qw8vHrsCoSaWKQvsIqFH9BaHYeU4e7CU4IOA4dSelrxKQH
         n43IVHhrtVX1pxPma6ssQZIbFNzxZ38FA45Q2D9l7C06wTYokc1qlbqm7FYbxD6gTFhz
         zgKQ==
X-Gm-Message-State: AOAM532QlNJuTX0OMo+27vMQoPCgRspzn74lkFtOptVNvvz+kV87+o2M
        NMJMrTG3H1UfMPpz3/6J+NgYFtNiidw=
X-Google-Smtp-Source: ABdhPJx8Rx0UyWSG0ruARIort+OY0H4SAG0yhwU925h6zt/COs3vZ1iSt2Dk+xxxjahucts7PPd5lQ==
X-Received: by 2002:adf:c382:: with SMTP id p2mr21102233wrf.283.1593516398555;
        Tue, 30 Jun 2020 04:26:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a15sm3907226wrh.54.2020.06.30.04.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 04:26:37 -0700 (PDT)
Message-Id: <pull.781.v4.git.git.1593516397380.gitgitgadget@gmail.com>
In-Reply-To: <pull.781.v3.git.git.1593414441313.gitgitgadget@gmail.com>
References: <pull.781.v3.git.git.1593414441313.gitgitgadget@gmail.com>
From:   "sunlin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Jun 2020 11:26:37 +0000
Subject: [PATCH v4] Enable auto-merge for meld to follow the vim-diff beharior
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sunlin <sunlin7@yahoo.com>, "lin.sun" <lin.sun@zoom.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "lin.sun" <lin.sun@zoom.us>

Make the mergetool used with "meld" backend behave similarly to
how "vimdiff" beheaves by telling it to auto-merge parts without
conflicts and highlight the parts with conflicts.

Signed-off-by: lin.sun <lin.sun@zoom.us>
---
    Enable auto-merge for meld to follow the vimdiff beharior
    
    Hi, the mergetool "meld" does NOT merge the no-conflict changes, while
    the mergetool "vimdiff" will merge the no-conflict changes and highlight
    the conflict parts. This patch will make the mergetool "meld" similar to
    "vimdiff", auto-merge the no-conflict changes, highlight conflict parts.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-781%2Fsunlin7%2Fmaster-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-781/sunlin7/master-v4
Pull-Request: https://github.com/git/git/pull/781

Range-diff vs v3:

 1:  3b70fd0bfc ! 1:  93ae3ec011 Enable auto-merge for meld to follow the vim-diff beharior
     @@ Metadata
       ## Commit message ##
          Enable auto-merge for meld to follow the vim-diff beharior
      
     -    The mergetool "meld" does NOT merge the no-conflict changes, while the
     -    mergetool "vimdiff" will merge the no-conflict parts and highlight the
     -    conflict parts.
     -    This patch will make the mergetool "meld" similar to "vimdiff",
     -    auto-merge the no-conflict parts, highlight conflict parts.
     +    Make the mergetool used with "meld" backend behave similarly to
     +    how "vimdiff" beheaves by telling it to auto-merge parts without
     +    conflicts and highlight the parts with conflicts.
      
     -    Signed-off-by: Lin Sun <lin.sun@zoom.us>
     +    Signed-off-by: lin.sun <lin.sun@zoom.us>
      
       ## mergetools/meld ##
     -@@ mergetools/meld: merge_cmd () {
     - 	then
     - 		check_meld_for_output_version
     - 	fi
     -+	if test -z "${meld_has_auto_merge_option:+set}"
     -+	then
     -+		check_meld_for_auto_merge_version
     -+	fi
     +@@ mergetools/meld: diff_cmd () {
     + }
     + 
     + merge_cmd () {
     +-	if test -z "${meld_has_output_option:+set}"
     ++	check_meld_for_features
      +
      +	option_auto_merge=
      +	if test "$meld_has_auto_merge_option" = true
     -+	then
     + 	then
     +-		check_meld_for_output_version
      +		option_auto_merge="--auto-merge"
     -+	fi
     + 	fi
       
       	if test "$meld_has_output_option" = true
       	then
     @@ mergetools/meld: merge_cmd () {
       	fi
       }
       
     -@@ mergetools/meld: check_meld_for_output_version () {
     - 		meld_has_output_option=false
     - 	fi
     - }
     -+
     -+# Check whether we should use 'meld --auto-merge ...'
     -+check_meld_for_auto_merge_version () {
     -+	meld_path="$(git config mergetool.meld.path)"
     -+	meld_path="${meld_path:-meld}"
     +-# Check whether we should use 'meld --output <file>'
     +-check_meld_for_output_version () {
     +-	meld_path="$(git config mergetool.meld.path)"
     +-	meld_path="${meld_path:-meld}"
     ++# Get meld help message
     ++get_meld_help_msg () {
     ++	meld_path="$(git config mergetool.meld.path || echo meld)"
     ++  $meld_path --help 2>&1
     ++}
     + 
     +-	if meld_has_output_option=$(git config --bool mergetool.meld.hasOutput)
     ++# Check the features and set flags
     ++check_meld_for_features () {
     ++	# Check whether we should use 'meld --output <file>'
     ++	if test -z "${meld_has_output_option:+set}"
     + 	then
     +-		: use configured value
     +-	elif "$meld_path" --help 2>&1 |
     +-		grep -e '--output=' -e '\[OPTION\.\.\.\]' >/dev/null
     ++		meld_has_output_option=$(git config --bool mergetool.meld.hasOutput)
     ++		if test "$meld_has_output_option" = true -o \
     ++						"$meld_has_output_option" = false
     ++		then
     ++			: use configured value
     ++		else												# treat meld_has_output_option as "auto"
     ++			if test -z "$meld_help_msg"
     ++			then
     ++				meld_help_msg="$(get_meld_help_msg)"
     ++			fi
      +
     -+	if meld_has_auto_merge_option=$(git config --bool mergetool.meld.hasAutoMerge)
     -+	then
     -+		: use configured value
     -+	elif "$meld_path" --help 2>&1 |
     -+		grep -e '--auto-merge' -e '\[OPTION\.\.\.\]' >/dev/null
     -+	then
     -+		: old ones mention --auto-merge and new ones just say OPTION...
     -+		meld_has_auto_merge_option=true
     -+	else
     -+		meld_has_auto_merge_option=false
     ++			if echo "$meld_help_msg" |
     ++							grep -e '--output=' -e '\[OPTION\.\.\.\]' >/dev/null
     ++			then
     ++				: old ones mention --output and new ones just say OPTION...
     ++				meld_has_output_option=true
     ++			else
     ++				meld_has_output_option=false
     ++			fi
     ++		fi
      +	fi
     -+}
     ++	# Check whether we should use 'meld --auto-merge ...'
     ++	if test -z "${meld_has_auto_merge_option:+set}"
     + 	then
     +-		: old ones mention --output and new ones just say OPTION...
     +-		meld_has_output_option=true
     +-	else
     +-		meld_has_output_option=false
     ++		meld_has_auto_merge_option=$(git config --bool mergetool.meld.hasAutoMerge)
     ++		if test "$meld_has_auto_merge_option" = true -o \
     ++						"$meld_has_auto_merge_option" = false
     ++		then
     ++			: use configured value
     ++		else												# treat meld_has_auto_merge_option as "auto"
     ++			if test -z "$meld_help_msg"
     ++			then
     ++					meld_help_msg="$(get_meld_help_msg)"
     ++			fi
     ++
     ++			if echo "$meld_help_msg" | grep -e '--auto-merge' >/dev/null
     ++			then
     ++					meld_has_auto_merge_option=true
     ++			else
     ++				meld_has_auto_merge_option=false
     ++			fi
     ++		fi
     + 	fi
     + }


 mergetools/meld | 73 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 57 insertions(+), 16 deletions(-)

diff --git a/mergetools/meld b/mergetools/meld
index 7a08470f88..1b92771228 100644
--- a/mergetools/meld
+++ b/mergetools/meld
@@ -3,34 +3,75 @@ diff_cmd () {
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
+  $meld_path --help 2>&1
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
+						"$meld_has_output_option" = false
+		then
+			: use configured value
+		else												# treat meld_has_output_option as "auto"
+			if test -z "$meld_help_msg"
+			then
+				meld_help_msg="$(get_meld_help_msg)"
+			fi
+
+			if echo "$meld_help_msg" |
+							grep -e '--output=' -e '\[OPTION\.\.\.\]' >/dev/null
+			then
+				: old ones mention --output and new ones just say OPTION...
+				meld_has_output_option=true
+			else
+				meld_has_output_option=false
+			fi
+		fi
+	fi
+	# Check whether we should use 'meld --auto-merge ...'
+	if test -z "${meld_has_auto_merge_option:+set}"
 	then
-		: old ones mention --output and new ones just say OPTION...
-		meld_has_output_option=true
-	else
-		meld_has_output_option=false
+		meld_has_auto_merge_option=$(git config --bool mergetool.meld.hasAutoMerge)
+		if test "$meld_has_auto_merge_option" = true -o \
+						"$meld_has_auto_merge_option" = false
+		then
+			: use configured value
+		else												# treat meld_has_auto_merge_option as "auto"
+			if test -z "$meld_help_msg"
+			then
+					meld_help_msg="$(get_meld_help_msg)"
+			fi
+
+			if echo "$meld_help_msg" | grep -e '--auto-merge' >/dev/null
+			then
+					meld_has_auto_merge_option=true
+			else
+				meld_has_auto_merge_option=false
+			fi
+		fi
 	fi
 }

base-commit: 07d8ea56f2ecb64b75b92264770c0a664231ce17
-- 
gitgitgadget
