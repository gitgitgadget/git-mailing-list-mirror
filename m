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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0136BC432BE
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 17:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2D9161042
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 17:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhGaR2B (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Jul 2021 13:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbhGaR1z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Jul 2021 13:27:55 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF44C061798
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 10:27:48 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h13so2238583wrp.1
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 10:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=XNtC/p8BeIl4g0JeAYc6QF8lRXLJ0YJUip1x0g2U0sA=;
        b=q+haH9aOwiVWhSlZAjQ5fU0tkEdTSxjbBdaZz3zcpR3D02BFN7Z8dXT3iYrwGBV8Ff
         CH5J1q92Lr+93Hyz6snLSgzhavnXT6pN6E9prGcpUaqtPqHaYHLLNQ8Co0nlR16iJWGf
         nJeDq/xXYzK6RKqV9FyWldKb48a+zhIgDr4LUosYHxUdPVHD5sL9EgfKDrC9T5lRPE72
         sRfUW9v5t7kgVwo1deMyjSnc2y5NdsWD7lcUaWKd/gVcHLaffJCwzSaxDai76DmwpGuA
         cT4Lsfc9Ef3Vc8iGZp+XSXyAdG7aIZrEhKHFc1TGysUtkn6VmDUXM2/ohEPVs4i+4Jvs
         Ff7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=XNtC/p8BeIl4g0JeAYc6QF8lRXLJ0YJUip1x0g2U0sA=;
        b=Eris57wSFfrT/oDmBMfOI/IOn5ruSEj1CPgOU0OdkO144fq2Jq3w0DQJuGKolccwlf
         fTYEVScCFefNn2mbg+mgViZgTDNOzJFsPWXgzWzsGFozjKJG5tXzsbBXrKd/QhVi4Jg1
         1ty3tiOVJYxnvmMlM6JAfvNhD0/eA97zMkNrHR4eKwsZhxa8sqrKnTggioa0RSWbj5Rj
         qj5MFruf8yul9f2cq62Rl1hYMm0MYcgoOmt0u3QchBkMOicJ2Woi8oFXqB4H1ZylNwgo
         4PY7pkE482QRyr8cP1NtbVtjbfAWQqnPkOShC+sVGo1OXUqYpqLkfRiysYs3I1elVWuW
         pjBg==
X-Gm-Message-State: AOAM530Et5/iRs1EVhhzvMvIQbKekWHZ7S17hLiVHMiPqGoLL/h/h7mC
        uB6ofXJB4PwjTRyEGqYlIuhLgoajTkU=
X-Google-Smtp-Source: ABdhPJxSwViigFYfPzxmoyMQPeNTlTmA8y2r16+IOOX6Y3GMuPO+SN666UctJKJwM69nkfvf8v100w==
X-Received: by 2002:a5d:4e87:: with SMTP id e7mr8760325wru.188.1627752465881;
        Sat, 31 Jul 2021 10:27:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e5sm6664198wrr.36.2021.07.31.10.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 10:27:45 -0700 (PDT)
Message-Id: <4ffa5af8b570772bc4ccc859ce05c04c289646b0.1627752458.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.990.v4.git.1627752458.gitgitgadget@gmail.com>
References: <pull.990.v3.git.1627645664.gitgitgadget@gmail.com>
        <pull.990.v4.git.1627752458.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 31 Jul 2021 17:27:36 +0000
Subject: [PATCH v4 7/9] merge-ort: store filepairs and filespecs in our
 mem_pool
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
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

