Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C16C433DF
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 20:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19F9A20663
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 20:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYyNxcqS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389277AbgF2Uli (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731670AbgF2TOG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:06 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5460BC08EDF6
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 00:07:24 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r12so15320202wrj.13
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 00:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ln0DzJbdIGJSQVUGmFjmFQSFIx3zC6UZ84eLkUcgpZw=;
        b=jYyNxcqSff5AaNILzuc5qptsjl5/+R/HYg/jFzH9qzCEu8serA3rYKRIPZtAnKJs73
         LqqACrPwVq+VWq2w+feDnAvDwzyNv/d4DrBXIO8mM013fuzaNEaDv5gaTR8dF3YynjVp
         9kM1UqxpE4w1bz1qFdK7mdL8mrS24JZ2Ypa5oOPdxq9/K5B0YXK1kLrAen8dHW1ivshO
         UylMlYks0v9+4QsYkPBHRZjoDdF6mFqL11+GaPl67FAUEUHzdYqdX8uAYgim994hpZNE
         LqVHS4XpGyuOn7KTkQYgbmrp7U/TBMZF4Fdw/eSJ9/X243pThaKjvNKAsu5u9B6VQHBx
         M5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ln0DzJbdIGJSQVUGmFjmFQSFIx3zC6UZ84eLkUcgpZw=;
        b=Cytll7r6t8E4xEyY6uxl89jtGCYmvRaV2ND4/4CXZ/irHqfGnLLwqfHFNjVKKX7ghY
         uqNrbu+ODpMqEpU+T9YCDXfqW9ozDtWL+toiMscIqfPTcYbYK1t/GK0/qtitb1qJMLn0
         w59vS1DnlZ6GWnCM+gZN+1EAsO5nAWCmDI86zZpDtdkfkwMr0FN3iJOcCwnAED/9MMl6
         OB4JeAieqWx/MTOKfq+QoHEiDKr7EHdbGQLbvaboW69RIywscD5L6wMiFr7SRu07dCl8
         inChYPAn3dpat0HcMdZaRp30TfqAOqzn43iee7zGA4J+OuuplJYcd00T/h2AcXZgcwfP
         DozA==
X-Gm-Message-State: AOAM533sFFDPZ/o97w03l9Ac4bMxeeiBE7/UqEZe1oAqF6oRdW1OUqQo
        bPsQ+1ANmVtElADhEs6Z9B5CPzL7
X-Google-Smtp-Source: ABdhPJyjvk+QHfLiT6kLWMv2zZ7JfVf9ehCcl6HD0iTIGobqBrr0K1dWQxMpP0ZQhinLTVx+5rBqzw==
X-Received: by 2002:a05:6000:cf:: with SMTP id q15mr16050130wrx.203.1593414442929;
        Mon, 29 Jun 2020 00:07:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e25sm48190007wrc.69.2020.06.29.00.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 00:07:22 -0700 (PDT)
Message-Id: <pull.781.v3.git.git.1593414441313.gitgitgadget@gmail.com>
In-Reply-To: <pull.781.v2.git.git.1591672753363.gitgitgadget@gmail.com>
References: <pull.781.v2.git.git.1591672753363.gitgitgadget@gmail.com>
From:   "sunlin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Jun 2020 07:07:21 +0000
Subject: [PATCH v3] Enable auto-merge for meld to follow the vim-diff beharior
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

The mergetool "meld" does NOT merge the no-conflict changes, while the
mergetool "vimdiff" will merge the no-conflict parts and highlight the
conflict parts.
This patch will make the mergetool "meld" similar to "vimdiff",
auto-merge the no-conflict parts, highlight conflict parts.

Signed-off-by: Lin Sun <lin.sun@zoom.us>
---
    Enable auto-merge for meld to follow the vimdiff beharior
    
    Hi, the mergetool "meld" does NOT merge the no-conflict changes, while
    the mergetool "vimdiff" will merge the no-conflict changes and highlight
    the conflict parts. This patch will make the mergetool "meld" similar to
    "vimdiff", auto-merge the no-conflict changes, highlight conflict parts.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-781%2Fsunlin7%2Fmaster-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-781/sunlin7/master-v3
Pull-Request: https://github.com/git/git/pull/781

Range-diff vs v2:

 1:  6e98a10bfa ! 1:  3b70fd0bfc Enable auto-merge for meld to follow the vim-diff beharior
     @@ Commit message
      
       ## mergetools/meld ##
      @@ mergetools/meld: merge_cmd () {
     + 	then
     + 		check_meld_for_output_version
     + 	fi
     ++	if test -z "${meld_has_auto_merge_option:+set}"
     ++	then
     ++		check_meld_for_auto_merge_version
     ++	fi
     ++
     ++	option_auto_merge=
     ++	if test "$meld_has_auto_merge_option" = true
     ++	then
     ++		option_auto_merge="--auto-merge"
     ++	fi
       
       	if test "$meld_has_output_option" = true
       	then
      -		"$merge_tool_path" --output="$MERGED" \
     -+		"$merge_tool_path" --auto-merge --output="$MERGED" \
     ++		"$merge_tool_path" $option_auto_merge --output="$MERGED" \
       			"$LOCAL" "$BASE" "$REMOTE"
       	else
      -		"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
     -+		"$merge_tool_path" --auto-merge "$LOCAL" "$MERGED" "$REMOTE"
     ++		"$merge_tool_path" $option_auto_merge "$LOCAL" "$MERGED" "$REMOTE"
       	fi
       }
       
     +@@ mergetools/meld: check_meld_for_output_version () {
     + 		meld_has_output_option=false
     + 	fi
     + }
     ++
     ++# Check whether we should use 'meld --auto-merge ...'
     ++check_meld_for_auto_merge_version () {
     ++	meld_path="$(git config mergetool.meld.path)"
     ++	meld_path="${meld_path:-meld}"
     ++
     ++	if meld_has_auto_merge_option=$(git config --bool mergetool.meld.hasAutoMerge)
     ++	then
     ++		: use configured value
     ++	elif "$meld_path" --help 2>&1 |
     ++		grep -e '--auto-merge' -e '\[OPTION\.\.\.\]' >/dev/null
     ++	then
     ++		: old ones mention --auto-merge and new ones just say OPTION...
     ++		meld_has_auto_merge_option=true
     ++	else
     ++		meld_has_auto_merge_option=false
     ++	fi
     ++}


 mergetools/meld | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/mergetools/meld b/mergetools/meld
index 7a08470f88..91b65ff22c 100644
--- a/mergetools/meld
+++ b/mergetools/meld
@@ -7,13 +7,23 @@ merge_cmd () {
 	then
 		check_meld_for_output_version
 	fi
+	if test -z "${meld_has_auto_merge_option:+set}"
+	then
+		check_meld_for_auto_merge_version
+	fi
+
+	option_auto_merge=
+	if test "$meld_has_auto_merge_option" = true
+	then
+		option_auto_merge="--auto-merge"
+	fi
 
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
 
@@ -34,3 +44,21 @@ check_meld_for_output_version () {
 		meld_has_output_option=false
 	fi
 }
+
+# Check whether we should use 'meld --auto-merge ...'
+check_meld_for_auto_merge_version () {
+	meld_path="$(git config mergetool.meld.path)"
+	meld_path="${meld_path:-meld}"
+
+	if meld_has_auto_merge_option=$(git config --bool mergetool.meld.hasAutoMerge)
+	then
+		: use configured value
+	elif "$meld_path" --help 2>&1 |
+		grep -e '--auto-merge' -e '\[OPTION\.\.\.\]' >/dev/null
+	then
+		: old ones mention --auto-merge and new ones just say OPTION...
+		meld_has_auto_merge_option=true
+	else
+		meld_has_auto_merge_option=false
+	fi
+}

base-commit: 07d8ea56f2ecb64b75b92264770c0a664231ce17
-- 
gitgitgadget
