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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DB7C432BE
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 11:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EC886052B
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 11:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238774AbhG3LsE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 07:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238709AbhG3Lr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 07:47:57 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8ECC0613CF
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 04:47:52 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id u15-20020a05600c19cfb02902501bdb23cdso9032024wmq.0
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 04:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=XNtC/p8BeIl4g0JeAYc6QF8lRXLJ0YJUip1x0g2U0sA=;
        b=GruPoREGGuy2bW3xjldd/Mfx+vOWleYZ6qY5wwYhotldZP63/I3AhkNhPeoaYf8mSQ
         vdHeyEVfi12sDdc92+FFRNO2dKvvIS3TdrpOfv40GgLSjeRLwdSI/Es0uUOSrx1JbeqT
         DUnfXuwQJosFLrNQH+IT/KCd9DCXsrbCsxaG5CxDmmINug1tiL96wL74ttSha0pcb9AN
         EyMMRIG/+1p5yeGWssnWGeMN4XwmFNiUmQB0W9TCy8xCYKfULtlscQ1w36z0wM96CfQK
         Wj/izRtPG41/iSz6NbMCiXtwV0qqhg38zg1eHQVh6aMKdqLuWrdoDavPyHSMzf/T4GDI
         Ol9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=XNtC/p8BeIl4g0JeAYc6QF8lRXLJ0YJUip1x0g2U0sA=;
        b=iTXzBLDAk1C2SCtFSrICy3HT2FzmWBEictXdLnkgK9awxfe0cNrjhBreg1jYQwQx2Z
         QkYk+yIFdQo/UZwHxzk7W2hjmnrkB3bMuIxIGx0qHZTHrytFF0JdSOUZ2ObNEBwqgkVG
         LL0iHTzcCyTymM1WudFQyBArNLAYE0D1SsD0OMjrg274pwR6zHVldsBZ21Zpf7a08BDU
         lienc5cJ4WIieR0jeTSxS8CFEZxI0vkkbkdtApoDUarDf29c3BWxzNKSXjazxSahemND
         2NKZsZXOFB7kaxmmq3aU555QY16UGJI94r4anFLDaZzC9mL7d9vbOqZJ2tZiTZzZmcIt
         AqRg==
X-Gm-Message-State: AOAM531hh33vLlfHWHZxOxsgO4OcpS/rg3H/GrhKi2tnodDytlDnNtwI
        1+MfxJhedQMrQ/3Vz/W+4ayn05llxWU=
X-Google-Smtp-Source: ABdhPJxjZhCYELVy82GdysMDVPYh8s/Osop36dIbFw8eg+0D35r7bw2iifyu53geV+cfZhdO8eM9KQ==
X-Received: by 2002:a05:600c:290:: with SMTP id 16mr2533700wmk.71.1627645671406;
        Fri, 30 Jul 2021 04:47:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j14sm1516404wrr.16.2021.07.30.04.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 04:47:51 -0700 (PDT)
Message-Id: <4ffa5af8b570772bc4ccc859ce05c04c289646b0.1627645664.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.990.v3.git.1627645664.gitgitgadget@gmail.com>
References: <pull.990.v2.git.1627531121.gitgitgadget@gmail.com>
        <pull.990.v3.git.1627645664.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 30 Jul 2021 11:47:42 +0000
Subject: [PATCH v3 7/9] merge-ort: store filepairs and filespecs in our
 mem_pool
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
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
index 5bc559f79e9..7e6b3e1b143 100644
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
index e79830f9181..f4f0a3d57f0 100644
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

