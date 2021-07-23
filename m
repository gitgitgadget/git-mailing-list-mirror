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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80841C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 12:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64BD060E8C
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 12:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbhGWMOg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 08:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235255AbhGWMOa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 08:14:30 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061F7C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 05:55:04 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id o3-20020a05600c5103b029024c0f9e1a5fso3193722wms.4
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 05:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=iXLcgMxHCbt+03h0fepgjvJEaxUsjTUn0v81mLtQI/Q=;
        b=JQKxxjsl07AeRpA1kYcHl2DvzsTreEhvqU7WqDKP+8sCntQF7Bvcu39lI3Yl/7EIeg
         tS7bMDf9B50g3/pSyqEviJ9QY1bQ9c35AUOtj8/kWVO9vFRAk0tJb6dlsJWyHlWHoFAm
         wjkUjSMiqf5ijrOQXmueLhkf7SfB4/le7M460+iSBuZpTFX92ZdlDU1iCtzuBpka4lo0
         wcWVkHE/fRF/KdytZVWzoOvRdC6+IKJs9VLx7o9Dp85DQ5pypQtY0LnccBhlKGU9FSVC
         A/7pTeDFfapWZUEzKjfHPT2pmj/GN7I11VfAbMIiY9cekpik8iifUco14qW/oy7Nvl97
         bi8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=iXLcgMxHCbt+03h0fepgjvJEaxUsjTUn0v81mLtQI/Q=;
        b=Z5k3K0BdzCBSLZrCQ5IAsDINGtNrLjyk7U+J9u0Yp7bg7SRDtthyWRcFLwWPGqiDSY
         P2/4uvjLKuE0TZkydqrz8tMMGN8JLstdL+KesR5AQWx/pT+5LCFiXF9J72IEpeH7bJn7
         47cc9YnQbiG9uKSQWmdgfexOlgEWCr1b0IozIU3C6GhvV1scOjGhNJ/RnaxsA+/9cRBI
         MuumuANRLnlMMw1GfrdNcRlrqTEs1lfF5+inbfHFa+z/KaDQ5Qo8tMIZ8nnJfJwqKnfK
         CMu3c3fk8YlIbhwKpJjrkaX054I1Sp1wRJySl7dULEKtkf9kgSVMVEyK2c2ECwdL9xfn
         INlA==
X-Gm-Message-State: AOAM531SK2Wtj9zdkWYbPkIpvStP/5jWLK8cK+cVvtKMvnwjhgofVjaE
        k9VdGB7a5Dpy4Nzfj+/CK3/cBFBUpJI=
X-Google-Smtp-Source: ABdhPJxv45RF7GjICHma2kyrCwEnFXpolN0apJZksx4hU76A5Ag8gPBBEaeF090gKpjdp1KqCpwUIw==
X-Received: by 2002:a7b:c4d3:: with SMTP id g19mr4371540wmk.78.1627044902602;
        Fri, 23 Jul 2021 05:55:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p2sm27246111wma.27.2021.07.23.05.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 05:55:02 -0700 (PDT)
Message-Id: <629d042884a6a846faca411b01b1b15ace99b540.1627044898.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.990.git.1627044897.gitgitgadget@gmail.com>
References: <pull.990.git.1627044897.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Jul 2021 12:54:56 +0000
Subject: [PATCH 6/7] merge-ort: store filepairs and filespecs in our mem_pool
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28),
this change improves the performance as follows:

                            Before                  After
    no-renames:       198.1 ms ±  2.6 ms     198.5 ms ±  3.4 ms
    mega-renames:     715.8 ms ±  4.0 ms     679.1 ms ±  5.6 ms
    just-one-mega:    276.8 ms ±  4.2 ms     271.9 ms ±  2.8 ms

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c |  9 ++++-----
 diffcore.h        |  1 +
 merge-ort.c       | 26 ++++++++++++++------------
 3 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 09606501cea..e30e4288d1b 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -1334,7 +1334,6 @@ static void free_filespec_data(struct diff_filespec *spec)
 		diff_free_filespec_data(spec);
 }
 
-MAYBE_UNUSED
 static void pool_free_filespec(struct mem_pool *pool,
 			       struct diff_filespec *spec)
 {
@@ -1351,7 +1350,6 @@ static void pool_free_filespec(struct mem_pool *pool,
 	free_filespec_data(spec);
 }
 
-MAYBE_UNUSED
 void pool_diff_free_filepair(struct mem_pool *pool,
 			     struct diff_filepair *p)
 {
@@ -1370,6 +1368,7 @@ void pool_diff_free_filepair(struct mem_pool *pool,
 }
 
 void diffcore_rename_extended(struct diff_options *options,
+			      struct mem_pool *pool,
 			      struct strintmap *relevant_sources,
 			      struct strintmap *dirs_removed,
 			      struct strmap *dir_rename_count,
@@ -1683,7 +1682,7 @@ void diffcore_rename_extended(struct diff_options *options,
 			pair_to_free = p;
 
 		if (pair_to_free)
-			diff_free_filepair(pair_to_free);
+			pool_diff_free_filepair(pool, pair_to_free);
 	}
 	diff_debug_queue("done copying original", &outq);
 
@@ -1693,7 +1692,7 @@ void diffcore_rename_extended(struct diff_options *options,
 
 	for (i = 0; i < rename_dst_nr; i++)
 		if (rename_dst[i].filespec_to_free)
-			free_filespec(rename_dst[i].filespec_to_free);
+			pool_free_filespec(pool, rename_dst[i].filespec_to_free);
 
 	cleanup_dir_rename_info(&info, dirs_removed, dir_rename_count != NULL);
 	FREE_AND_NULL(rename_dst);
@@ -1710,5 +1709,5 @@ void diffcore_rename_extended(struct diff_options *options,
 
 void diffcore_rename(struct diff_options *options)
 {
-	diffcore_rename_extended(options, NULL, NULL, NULL, NULL);
+	diffcore_rename_extended(options, NULL, NULL, NULL, NULL, NULL);
 }
diff --git a/diffcore.h b/diffcore.h
index b58ee6b1934..badc2261c20 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -181,6 +181,7 @@ void partial_clear_dir_rename_count(struct strmap *dir_rename_count);
 void diffcore_break(struct repository *, int);
 void diffcore_rename(struct diff_options *);
 void diffcore_rename_extended(struct diff_options *options,
+			      struct mem_pool *pool,
 			      struct strintmap *relevant_sources,
 			      struct strintmap *dirs_removed,
 			      struct strmap *dir_rename_count,
diff --git a/merge-ort.c b/merge-ort.c
index 59428e45884..d29c7fe8a30 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -690,7 +690,6 @@ static void path_msg(struct merge_options *opt,
 	strbuf_addch(sb, '\n');
 }
 
-MAYBE_UNUSED
 static struct diff_filespec *pool_alloc_filespec(struct mem_pool *pool,
 						 const char *path)
 {
@@ -712,7 +711,6 @@ static struct diff_filespec *pool_alloc_filespec(struct mem_pool *pool,
 	return spec;
 }
 
-MAYBE_UNUSED
 static struct diff_filepair *pool_diff_queue(struct mem_pool *pool,
 					     struct diff_queue_struct *queue,
 					     struct diff_filespec *one,
@@ -930,6 +928,7 @@ static void add_pair(struct merge_options *opt,
 		     unsigned dir_rename_mask)
 {
 	struct diff_filespec *one, *two;
+	struct mem_pool *pool = opt->priv->pool;
 	struct rename_info *renames = &opt->priv->renames;
 	int names_idx = is_add ? side : 0;
 
@@ -980,11 +979,11 @@ static void add_pair(struct merge_options *opt,
 			return;
 	}
 
-	one = alloc_filespec(pathname);
-	two = alloc_filespec(pathname);
+	one = pool_alloc_filespec(pool, pathname);
+	two = pool_alloc_filespec(pool, pathname);
 	fill_filespec(is_add ? two : one,
 		      &names[names_idx].oid, 1, names[names_idx].mode);
-	diff_queue(&renames->pairs[side], one, two);
+	pool_diff_queue(pool, &renames->pairs[side], one, two);
 }
 
 static void collect_rename_info(struct merge_options *opt,
@@ -2893,6 +2892,7 @@ static void use_cached_pairs(struct merge_options *opt,
 {
 	struct hashmap_iter iter;
 	struct strmap_entry *entry;
+	struct mem_pool *pool = opt->priv->pool;
 
 	/*
 	 * Add to side_pairs all entries from renames->cached_pairs[side_index].
@@ -2906,9 +2906,9 @@ static void use_cached_pairs(struct merge_options *opt,
 			new_name = old_name;
 
 		/* We don't care about oid/mode, only filenames and status */
-		one = alloc_filespec(old_name);
-		two = alloc_filespec(new_name);
-		diff_queue(pairs, one, two);
+		one = pool_alloc_filespec(pool, old_name);
+		two = pool_alloc_filespec(pool, new_name);
+		pool_diff_queue(pool, pairs, one, two);
 		pairs->queue[pairs->nr-1]->status = entry->value ? 'R' : 'D';
 	}
 }
@@ -3016,6 +3016,7 @@ static int detect_regular_renames(struct merge_options *opt,
 	diff_queued_diff = renames->pairs[side_index];
 	trace2_region_enter("diff", "diffcore_rename", opt->repo);
 	diffcore_rename_extended(&diff_opts,
+				 opt->priv->pool,
 				 &renames->relevant_sources[side_index],
 				 &renames->dirs_removed[side_index],
 				 &renames->dir_rename_count[side_index],
@@ -3066,7 +3067,7 @@ static int collect_renames(struct merge_options *opt,
 
 		if (p->status != 'A' && p->status != 'R') {
 			possibly_cache_new_pair(renames, p, side_index, NULL);
-			diff_free_filepair(p);
+			pool_diff_free_filepair(opt->priv->pool, p);
 			continue;
 		}
 
@@ -3079,7 +3080,7 @@ static int collect_renames(struct merge_options *opt,
 
 		possibly_cache_new_pair(renames, p, side_index, new_path);
 		if (p->status != 'R' && !new_path) {
-			diff_free_filepair(p);
+			pool_diff_free_filepair(opt->priv->pool, p);
 			continue;
 		}
 
@@ -3197,7 +3198,7 @@ cleanup:
 		side_pairs = &renames->pairs[s];
 		for (i = 0; i < side_pairs->nr; ++i) {
 			struct diff_filepair *p = side_pairs->queue[i];
-			diff_free_filepair(p);
+			pool_diff_free_filepair(opt->priv->pool, p);
 		}
 	}
 
@@ -3210,7 +3211,8 @@ simple_cleanup:
 	if (combined.nr) {
 		int i;
 		for (i = 0; i < combined.nr; i++)
-			diff_free_filepair(combined.queue[i]);
+			pool_diff_free_filepair(opt->priv->pool,
+						combined.queue[i]);
 		free(combined.queue);
 	}
 
-- 
gitgitgadget

