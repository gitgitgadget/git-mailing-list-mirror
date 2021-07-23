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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F58EC4320A
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 12:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 435D460E53
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 12:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbhGWMO3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 08:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235206AbhGWMO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 08:14:28 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F124DC061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 05:55:00 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e2so2255126wrq.6
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 05:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=gpsvLaWgPvvMD33tMjM4ZkG9Z9LR9WQE9oNq5yJMXjw=;
        b=EjVaVWkCn8iBLO9s7qZRNuFzlHZE6AkMtXdHNoWjc8IJ37tWtbv4snpeuUgxJLlFiP
         +oWkLs57gVt7QBA8NWGsvxNnX1EoK4ey4//oC7zZ7bF/asTtlbyUvLbTnFoJtIb1YNbe
         tNgXOEMzSGFHuFVZ4k9EYVSEOJEaK7wxEvy0ctveLJ4E6/9V5An1Dw7u50xeaZpHDTun
         Ed3n2U4ssCN+TChwPU1VvwM/I3SDRahmGVuHw9yS6WpjmZi7OtcmQ7ML3IH/Gy9iLvA4
         hnISgfm8IbM95dI+YL68qvaCC2DSFbzorLYl+Xh9lSW7hKUfbYMGtj3QqSFWdjoGoHxN
         FOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=gpsvLaWgPvvMD33tMjM4ZkG9Z9LR9WQE9oNq5yJMXjw=;
        b=nPEAyzkVpn4Cj/VxhouvhU2nRtGCUE4KNMQXtagENIrTqLIiFi0LQRbA2KesWT5ogi
         YIbzwhG/SmDPf5B8MRtbZVx7+sQQq4sYPNN8JyUNBz6mU7DVUnhL4LS3HQmeHKBcjPNp
         hzmyj/3x862f0nSI9qglm+l4XpS1Kg+JsKggAL55are8iCzv/5Q3pmIUZ7tX6AdTR2Vy
         UiJuK3LnOt6KLVl5gJqhPjw2D2a4EIjf7loT9VpyFRKZGsTvTJHyIywvSBIZlMG1H2zU
         JSFecFssHK4Rc53nZpuZY9sfVzmw+KismpO4MPqCih8Kh6ZgrN/3N9vtVzlgKDdcvRDF
         oPWg==
X-Gm-Message-State: AOAM530wSAWfnClU+1w381RB1MD3cefSnbkkQyk/HlvhCXisodVmxEaK
        aCtuf1QFhwEv2EzLSVLL/iQZEV/kFs0=
X-Google-Smtp-Source: ABdhPJzvE07otzziAsqVuG5pJxsYV+3/YyjMCoQ6ocNpp/Us5xyUiUHHNIiT98PuLmIWSdgi3QQXqQ==
X-Received: by 2002:adf:e405:: with SMTP id g5mr5105793wrm.365.1627044899592;
        Fri, 23 Jul 2021 05:54:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x8sm32819286wrt.93.2021.07.23.05.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 05:54:59 -0700 (PDT)
Message-Id: <9f8ab62b84256be6d7d984d576ff4fda09d88a1d.1627044897.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.990.git.1627044897.gitgitgadget@gmail.com>
References: <pull.990.git.1627044897.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Jul 2021 12:54:51 +0000
Subject: [PATCH 1/7] diffcore-rename: use a mem_pool for exact rename
 detection's hashmap
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

Exact rename detection, via insert_file_table(), uses a hashmap to store
files by oid.  Use a mem_pool for the hashmap entries so these can all be
allocated and deallocated together.

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28),
this change improves the performance as follows:

                            Before                  After
    no-renames:      204.2  ms ±  3.0  ms   202.5  ms ±  3.2  ms
    mega-renames:      1.076 s ±  0.015 s     1.072 s ±  0.012 s
    just-one-mega:   364.1  ms ±  7.0  ms   357.3  ms ±  3.9  ms

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 4ef0459cfb5..23b917eca42 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -317,10 +317,11 @@ static int find_identical_files(struct hashmap *srcs,
 }
 
 static void insert_file_table(struct repository *r,
+			      struct mem_pool *pool,
 			      struct hashmap *table, int index,
 			      struct diff_filespec *filespec)
 {
-	struct file_similarity *entry = xmalloc(sizeof(*entry));
+	struct file_similarity *entry = mem_pool_alloc(pool, sizeof(*entry));
 
 	entry->index = index;
 	entry->filespec = filespec;
@@ -336,7 +337,8 @@ static void insert_file_table(struct repository *r,
  * and then during the second round we try to match
  * cache-dirty entries as well.
  */
-static int find_exact_renames(struct diff_options *options)
+static int find_exact_renames(struct diff_options *options,
+			      struct mem_pool *pool)
 {
 	int i, renames = 0;
 	struct hashmap file_table;
@@ -346,7 +348,7 @@ static int find_exact_renames(struct diff_options *options)
 	 */
 	hashmap_init(&file_table, NULL, NULL, rename_src_nr);
 	for (i = rename_src_nr-1; i >= 0; i--)
-		insert_file_table(options->repo,
+		insert_file_table(options->repo, pool,
 				  &file_table, i,
 				  rename_src[i].p->one);
 
@@ -355,7 +357,7 @@ static int find_exact_renames(struct diff_options *options)
 		renames += find_identical_files(&file_table, i, options);
 
 	/* Free the hash data structure and entries */
-	hashmap_clear_and_free(&file_table, struct file_similarity, entry);
+	hashmap_clear(&file_table);
 
 	return renames;
 }
@@ -1341,6 +1343,7 @@ void diffcore_rename_extended(struct diff_options *options,
 	int num_destinations, dst_cnt;
 	int num_sources, want_copies;
 	struct progress *progress = NULL;
+	struct mem_pool local_pool;
 	struct dir_rename_info info;
 	struct diff_populate_filespec_options dpf_options = {
 		.check_binary = 0,
@@ -1409,11 +1412,18 @@ void diffcore_rename_extended(struct diff_options *options,
 		goto cleanup; /* nothing to do */
 
 	trace2_region_enter("diff", "exact renames", options->repo);
+	mem_pool_init(&local_pool, 32*1024);
 	/*
 	 * We really want to cull the candidates list early
 	 * with cheap tests in order to avoid doing deltas.
 	 */
-	rename_count = find_exact_renames(options);
+	rename_count = find_exact_renames(options, &local_pool);
+	/*
+	 * Discard local_pool immediately instead of at "cleanup:" in order
+	 * to reduce maximum memory usage; inexact rename detection uses up
+	 * a fair amount of memory, and mem_pools can too.
+	 */
+	mem_pool_discard(&local_pool, 0);
 	trace2_region_leave("diff", "exact renames", options->repo);
 
 	/* Did we only want exact renames? */
-- 
gitgitgadget

