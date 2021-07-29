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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5025FC43214
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 03:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 347CA60F6B
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 03:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbhG2D6x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 23:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbhG2D6t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 23:58:49 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65C2C061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 20:58:45 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m19so2789277wms.0
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 20:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WF5AmD88C4NG/9ryr4hlysEDGCGo787AyAD7Vzg4JRQ=;
        b=tTG75+dhikTw2WLd72Vb48vvWSVxAZ04hLBGoq9kGtTj+j3N5xQHJIwZuVVQZsywjH
         JuRf3f152TbwV8tchBFFnMqEKpkWuo9URIPov51gI0PN7o5TCoRRumxNl37tpVW0MCBt
         dyPUf11MZ2pGS3VOQMsUk9uijpbcBLLljaOCGdaJvQyYM58gA4vZa19OpvN4CsatLpVr
         7NXbrhP+CT0GZvnUwQ1zRn5ekScAyMa3unU9PtNz6g5laZ6TEJ19y/pMrEIRhVv1pZYE
         Ck2jZEUlMosMXDcWGG3Ko9kpSAyqgtGBKmvxKPtweZt50P9SDFW+7hb7sNoDj8pKHd9u
         V4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WF5AmD88C4NG/9ryr4hlysEDGCGo787AyAD7Vzg4JRQ=;
        b=OdLNFJbFpi6+6T3CbehChGR1/X7o7mhrn5oJRt9VH7NPvE89Y0nNe3TL3VjnWJjCv+
         DOBNrtHKCQ9s4YqyXC6yAiKiNMmmmnQWSHNsIsH5tKfUTmoiKkUCR9GCi8LyswUy/DpT
         yjtCa/7suHDsxNnOUOnspG7gL85v2GtCKY8h7ilA70GRJpYsboIHIL8+zUvifnU7jC9y
         qtL5vC5IJneJSYIojIzFHgBwLKStSyJAWKlRwIDUwRD1VZpAeLdJY1XVBmptKr33GTww
         UCrLvayK1WJOGq4NyqaX+kr3vnnNWldxlGUrwNfesguqVeWOL/nFnldU/yLUy75mC6ik
         JpRQ==
X-Gm-Message-State: AOAM533NtnbH/a/LdhUsa8fWeVqSx+HIJNLc6C0brqN+RybHDgyJ+zOo
        PMbI5AwHRMV2Yw8jFIHUt90jk9W6XQ4=
X-Google-Smtp-Source: ABdhPJwPrjgAcC2lwgKNEHVz4NNjEyfOJ/ZGzdqaLqGfzKq9LbpCvOeL1NRRQCVG8Vpe/I8XQybjIA==
X-Received: by 2002:a05:600c:5117:: with SMTP id o23mr2569608wms.85.1627531124427;
        Wed, 28 Jul 2021 20:58:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v18sm1354101wml.24.2021.07.28.20.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 20:58:44 -0700 (PDT)
Message-Id: <c715086910714fc8ac160c96e5827e8f0a820240.1627531121.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.990.v2.git.1627531121.gitgitgadget@gmail.com>
References: <pull.990.git.1627044897.gitgitgadget@gmail.com>
        <pull.990.v2.git.1627531121.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Jul 2021 03:58:37 +0000
Subject: [PATCH v2 3/7] merge-ort: set up a memory pool
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
index 39ddc9b9f2f..2bca4b71f2a 100644
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
@@ -4368,6 +4387,12 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 
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

