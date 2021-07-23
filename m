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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FB8C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 12:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3707F60E95
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 12:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbhGWMOa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 08:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbhGWMO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 08:14:28 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94070C06175F
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 05:55:01 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l11-20020a7bc34b0000b029021f84fcaf75so3460417wmj.1
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 05:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TVK0Yc51pWKWhE8HF8xtg5T3t6+DIcR3OfwUI+86W9A=;
        b=BfAkS0VCX452J29mSOmtSQ+MQWElwaZlYGO5rX3uuRSx4iV2Ogj7cywKGMB702JCCF
         +iF22+yhwCGqUIaqyvu0cGO3LVyXgSzCq5vPtZgS6PP6rMzpO5g2tOoAjxzCyO8e5zUv
         wMsL03hYYb4dU/wlSBYcGh7QtAAAkugrdreY9ux8o/sdVgruE+D++6O3+n0+b33m4nm2
         nFzdeWYvuKgk2hdMPblPB8xU3fA2oatz6FOHbB6TK1Fa2neXQuRYEYHTzTutpD4w2SP1
         KOHwtY6pfvk3WH0NFJ3WIeFT575XitpFDYhvKvqAled4HLeP0wKglLQhCBeAxEkJxSN1
         FK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TVK0Yc51pWKWhE8HF8xtg5T3t6+DIcR3OfwUI+86W9A=;
        b=STGYomARzaqofGCbnP/CCVnYEAqxZ6cbhaiQwqpyP8TUNpC7sPRk3D9e5B270BMxxN
         olZzAoDBaWegC1z7+74qMw3Ms1nL9Wu6iBl0TW7ZCj50qi+U+r5qUiLbhcR05v36AsWS
         0Cjki17pSfWklyKJK8P/GL1AjR2P9d4W9xaLhAQ8ein0O5MwGhE7AAnijHnbV0dPZ9uL
         PbBdIqtW7ujwo6HTpBIq5oJ+vh4k5TDxb+vbPXcEcUE3SHk7To3dMkMW4zVnYDVvY9id
         5fGTYCDgY2QNsjzHd5ECp/vFMsJPgtGRw/b9dt0p7/B9ms994QpdK741wUBPyJqHDWSK
         irzw==
X-Gm-Message-State: AOAM530gw4Zmc/Rwoag5TSa6yUoP9PX4bjXngz4KF1cN9fRZgCuZfVta
        0EfT8zmtJaMfhAVBvfJd1f514JkNiAU=
X-Google-Smtp-Source: ABdhPJxT9QelQ6M8/mhZwxMZ4Yh2JQFzgDqAMZZUHUVBNitpUp0//4U04cTD7F6QaOXOIJO6haTpnQ==
X-Received: by 2002:a05:600c:4f05:: with SMTP id l5mr14020887wmq.96.1627044900227;
        Fri, 23 Jul 2021 05:55:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n5sm31730528wri.31.2021.07.23.05.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 05:54:59 -0700 (PDT)
Message-Id: <77367a69daad042d2a6ed56b922ade892337cf16.1627044897.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.990.git.1627044897.gitgitgadget@gmail.com>
References: <pull.990.git.1627044897.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Jul 2021 12:54:52 +0000
Subject: [PATCH 2/7] merge-ort: set up a memory pool
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
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
index e361443087a..cb33c76760f 100644
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
@@ -4344,6 +4363,12 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 
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

