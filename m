Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE808C433E5
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 21:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB90061A24
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 21:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238492AbhCXVcp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 17:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238495AbhCXVck (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 17:32:40 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723D5C06174A
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 14:32:40 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j7so267489wrd.1
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 14:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ErFfbaVocqHONkBYYrYroPIP2f0Kvb63Ez6Rku7Eens=;
        b=tj/HbXMnHSE00ZsTw7tmjQTobaFzumcwki0plAPNjLBYe0oRU0Zp+yf12MjZriGNbQ
         ZbY8KipV+Lmsxs+WiMYz5NO97pCAO3HHWA/oHi2NUBIncHlz7kznohGLEt5gLOeGz+N1
         WXDYChJDFHzyRDMT5RVLATyPojPXVqShBQFGDR5aASeXr7x7RjqLPfn1ycST3Ygfm7jN
         05KuzujkamBaecfb18vJQg+vfO0izWt5YoFJze1FoZVohQFEVXdvVEV2/XeHLcbLT8H+
         JdPBXf3fpVkToH6qkO+dgQbiTWMh2bmEbN2X/uVDgJm3U5RWXXGMGDK73ybn5sM2xh8o
         FtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ErFfbaVocqHONkBYYrYroPIP2f0Kvb63Ez6Rku7Eens=;
        b=oqOSWb4YjfIe8xvYfQDRyZX+cB4CNOLt+4C+8oko75fPirr/8Q7UYLGDKLohE5nRfS
         1Y5xC7BdUETlJqDvti0Y5XzNnaPwu8PBZhYiNz9LmaaqeJui1Co0v37I/kgSlaHEJM+9
         CIEDRYmOygQEdB2ucnwkcNZjqeQyhAUEIOwcUF0H72MugeDzWtcQ503xXYMMojEwD7F2
         M+2L05Y3FM9n/0lasxVlvmnMdfpPTNxl9rQdsy5xqBK4KLdO6G0Rbn8ryb29Vw1G/Stm
         /OO3fbMB68XGyfRcyvXrmQ+RewP3zXJIS07sBD0fvI7IRc7JPUFPjxNWvu44EObdwnUH
         6EUQ==
X-Gm-Message-State: AOAM533nV2UAK9VSr6lrnT3Kt6ZS8o1BgCBEecoW4WPppS2ql5mUJIJX
        JxrO7jADZ+eyrsbVNnLDd/I9fzGqQos=
X-Google-Smtp-Source: ABdhPJwoRaFBF8yiRROjAC81LQf5T3oCCxyUdtLWuugL67qc+CzfFCpHWdN1okxGvJ3cw4z3GQn3Vg==
X-Received: by 2002:adf:9bce:: with SMTP id e14mr5792233wrc.29.1616621559235;
        Wed, 24 Mar 2021 14:32:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m11sm4866036wri.44.2021.03.24.14.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 14:32:38 -0700 (PDT)
Message-Id: <39f7e384611dd335e6d83ed4ca764a1ee022576f.1616621553.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.859.git.1616621553.gitgitgadget@gmail.com>
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 24 Mar 2021 21:32:31 +0000
Subject: [PATCH 5/7] merge-ort: preserve cached renames for the appropriate
 side
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Previous commits created an in-memory cache of the results of rename
detection, and added logic to detect when that cache could appropriately
be used in a subsequent merge operation -- but we were still
unconditionally clearing the cache with each new merge operation anyway.
If it is valid to reuse the cache from one of the two sides of history,
preserve that side.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 5d56b0f90128..0dffd65ee1a3 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -475,17 +475,18 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 	/* Free memory used by various renames maps */
 	for (i = MERGE_SIDE1; i <= MERGE_SIDE2; ++i) {
 		strintmap_func(&renames->dirs_removed[i]);
-
-		partial_clear_dir_rename_count(&renames->dir_rename_count[i]);
-		if (!reinitialize)
-			strmap_clear(&renames->dir_rename_count[i], 1);
-
 		strmap_func(&renames->dir_renames[i], 0);
-
 		strintmap_func(&renames->relevant_sources[i]);
-		strset_func(&renames->cached_target_names[i]);
-		strmap_func(&renames->cached_pairs[i], 1);
-		strset_func(&renames->cached_irrelevant[i]);
+		if (!reinitialize)
+			assert(renames->cached_pairs_valid_side == 0);
+		if (i != renames->cached_pairs_valid_side) {
+			strset_func(&renames->cached_target_names[i]);
+			strmap_func(&renames->cached_pairs[i], 1);
+			strset_func(&renames->cached_irrelevant[i]);
+			partial_clear_dir_rename_count(&renames->dir_rename_count[i]);
+			if (!reinitialize)
+				strmap_clear(&renames->dir_rename_count[i], 1);
+		}
 	}
 	renames->cached_pairs_valid_side = 0;
 	renames->dir_rename_mask = 0;
-- 
gitgitgadget

