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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046D7C4320A
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 11:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA2A86103B
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 11:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238771AbhG3LsD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 07:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238728AbhG3Lr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 07:47:56 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0B3C0613D3
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 04:47:50 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n12so10981151wrr.2
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 04:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0G2Aq0f99MPciHnA4RscP5rIVPzkEOXnzeJ+kRWgLxI=;
        b=vFAK0RtNHQy/5q/Z232GWuKXRDme3koSMm5RKqI0AqW2aA08D6SwXtHBt6qwJQvtIJ
         9lT2j4ClJLw8Q3RVxWWa0Wz8fM7VF3vDbRZYr2BtFp/Aa7bgy3mooVWLCZQ1GfF1Od5v
         dnFOwOztECPJVOT5O7VrmAK+uyEPQeX45T9h93X2/9BgDvibnlEvJ+Y8yL8Ljcd+zOsw
         UFapl5mi3iPnwDlZpe/az7pXJQ/XhdOW+FyJd+POl2PszcoBs5Y/Q80L2XhpFFmEQceM
         dUsLcJKv3Nay+NRuWX5mqgN4rSLFDtcrlwv6a2Eu57jkHfF7XRNnA/hoCTB11Z/V+2wL
         pj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0G2Aq0f99MPciHnA4RscP5rIVPzkEOXnzeJ+kRWgLxI=;
        b=lk4xTYxrzHo8UTuK+PxczzLBrI0C1ptqtIFODBl2JlJ/ZIyoGhPJLv7LIebRBKetG2
         8Gi6aRuTKm9qYtBm/AgwgrEPVhITOP+cAFDa1EPvJF7H6d3YD/7mz+sE39gLhxyxJqxV
         xobfEbh78QmfayNaknJs6mjkjvx3f1y/su3YHe9u2wY0yFb7vTgpwSETWgz8Q30rrjuZ
         nPOzufP3Q+FhRdCH9ob5zUKo6vM5bb6MNn3jSSoiCTPCH6zlrbYEdBXZts0tHxWKcHlr
         Z3tn5Ps/drTkASKMKZs7LtbJjfxB+dMGTkgiBWmgbMrKqRqJ26n257/29oux8jq31NGN
         tHSg==
X-Gm-Message-State: AOAM532RYX0+A5godJ3yN9uI5J6Zv0NBhHbzjQeKtRseA5iuymFd86RS
        sfejDrCQlHCR9wJ/rRtk9LQT358CPxg=
X-Google-Smtp-Source: ABdhPJymrSz2yEDX4X9OGireS5uQLAEmB2djCVfG/Qd/ncM7ArWRLypZQpN0YtNPfLAmp9EmUJsTAA==
X-Received: by 2002:a5d:6908:: with SMTP id t8mr2635561wru.421.1627645669326;
        Fri, 30 Jul 2021 04:47:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b15sm1755093wrr.27.2021.07.30.04.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 04:47:48 -0700 (PDT)
Message-Id: <6646f6fd1cae3b7ebe279317b95405f2b6d71e9e.1627645664.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.990.v3.git.1627645664.gitgitgadget@gmail.com>
References: <pull.990.v2.git.1627531121.gitgitgadget@gmail.com>
        <pull.990.v3.git.1627645664.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 30 Jul 2021 11:47:39 +0000
Subject: [PATCH v3 4/9] merge-ort: set up a memory pool
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

merge-ort has a lot of data structures, and they all tend to be freed
together in clear_or_reinit_internal_opts().  Set up a memory pool to
allow us to make these allocations and deallocations faster.  Future
commits will adjust various callers to make use of this memory pool.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 63f67246d3d..3f425436263 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -37,6 +37,8 @@
 #include "unpack-trees.h"
 #include "xdiff-interface.h"
 
+#define USE_MEMORY_POOL 1 /* faster, but obscures memory leak hunting */
+
 /*
  * We have many arrays of size 3.  Whenever we have such an array, the
  * indices refer to one of the sides of the three-way merge.  This is so
@@ -339,6 +341,17 @@ struct merge_options_internal {
 	 */
 	struct strmap conflicted;
 
+	/*
+	 * pool: memory pool for fast allocation/deallocation
+	 *
+	 * We allocate room for lots of filenames and auxiliary data
+	 * structures in merge_options_internal, and it tends to all be
+	 * freed together too.  Using a memory pool for these provides a
+	 * nice speedup.
+	 */
+	struct mem_pool internal_pool;
+	struct mem_pool *pool; /* NULL, or pointer to internal_pool */
+
 	/*
 	 * paths_to_free: additional list of strings to free
 	 *
@@ -603,6 +616,12 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 		strmap_clear(&opti->output, 0);
 	}
 
+#if USE_MEMORY_POOL
+	mem_pool_discard(&opti->internal_pool, 0);
+	if (!reinitialize)
+		opti->pool = NULL;
+#endif
+
 	/* Clean out callback_data as well. */
 	FREE_AND_NULL(renames->callback_data);
 	renames->callback_data_nr = renames->callback_data_alloc = 0;
@@ -4381,6 +4400,12 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 
 	/* Initialization of various renames fields */
 	renames = &opt->priv->renames;
+#if USE_MEMORY_POOL
+	mem_pool_init(&opt->priv->internal_pool, 0);
+	opt->priv->pool = &opt->priv->internal_pool;
+#else
+	opt->priv->pool = NULL;
+#endif
 	for (i = MERGE_SIDE1; i <= MERGE_SIDE2; i++) {
 		strintmap_init_with_options(&renames->dirs_removed[i],
 					    NOT_RELEVANT, NULL, 0);
-- 
gitgitgadget

