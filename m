Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDC8C4338F
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 17:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 103ED61050
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 17:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhGaR15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Jul 2021 13:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhGaR1w (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Jul 2021 13:27:52 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065A9C0613CF
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 10:27:45 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id z4so15736340wrv.11
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 10:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0G2Aq0f99MPciHnA4RscP5rIVPzkEOXnzeJ+kRWgLxI=;
        b=DY/+MM4FJcwZfhvMP5+Jm6m1VD0xYbSIVk5DFvcE4o/OJzGLnXyIIHBEbrSofzbKai
         ExrTwzcoOWiM6mEewZq/l18erBh0XDIuX3MJu8EhN+l3W2Ppc+hm7X7n38ckN96wS5Vm
         HZ7XQOmeUj416BK+HCmao9ARtL9onFv0OO9yB4U21ZBvqCyjtYfqJbRBcKp2v6OK3lFf
         YbP65Blq5SzAM1jRy7SMO8Svep8ZqBiQd0kowkQPJyM1HBkeyhHdgzbAZCzGbSGXmD+x
         2NJuTLZ6ClXQDEgA3N9LD/bzC56O8jndsx5vJ18r8tDX+gvq53xOCabhvfW7Yr1zxDZz
         gG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0G2Aq0f99MPciHnA4RscP5rIVPzkEOXnzeJ+kRWgLxI=;
        b=AeHtUTZWA2nFewLAEQfZXeTzEDyAE51crV6yHX+AADohzRSV1D3y+bjFGV7S5RrP/J
         E+QkGS3URnKMx6V5pFvz0H5g/AmxbhPEEiyjetLscDtXuJVFiQ3eXWn+COqP0vtCwOnT
         eebjudBEZ9Lze3CcEGOPhaH2bZcAyUO7rHYiByimqfwvFTpJ8mbAJYtaX/CAUuFzc4jg
         t0DbQQEYPLzrTIIRvzH/+Ohf3sfo/XjH3HtQKFElhPPzgoeBPz0GTs3djLi0sq++F6NV
         1mb6nPCD62DuuC45Fjhazn0qDJNR3rzwNW5lIDieo3VbFKKiQsPrVog8BfcRY0ucR0zm
         ytIQ==
X-Gm-Message-State: AOAM5323MqaZvQRiNp+XMgcaX5ldSqiosQItVkHcnYdAwtmtKC7/OpjH
        vHx/+jEaF1VHfotL9F6KU9pmgQz1Q3g=
X-Google-Smtp-Source: ABdhPJyCWOPJMZUDkEDAFN/csozjtCq0kaKXleumjXOj7nmuYtELPMzD21EWFsOkGn/JrDKeQc0gPw==
X-Received: by 2002:a5d:6d86:: with SMTP id l6mr9174314wrs.260.1627752463612;
        Sat, 31 Jul 2021 10:27:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b14sm5568032wrm.43.2021.07.31.10.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 10:27:43 -0700 (PDT)
Message-Id: <6646f6fd1cae3b7ebe279317b95405f2b6d71e9e.1627752458.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.990.v4.git.1627752458.gitgitgadget@gmail.com>
References: <pull.990.v3.git.1627645664.gitgitgadget@gmail.com>
        <pull.990.v4.git.1627752458.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 31 Jul 2021 17:27:33 +0000
Subject: [PATCH v4 4/9] merge-ort: set up a memory pool
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
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

