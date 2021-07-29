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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF1EC432BE
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 03:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F09D6101C
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 03:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbhG2D6w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 23:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbhG2D6s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 23:58:48 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89798C061765
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 20:58:44 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e2so5017645wrq.6
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 20:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=AXse4muAeaYC3gLbixhZ8tneVeIz+kqzyPqgyg820Pk=;
        b=u7FypVuhad9vAIkxZ6dCrgoQsfcgFYGWeAnar+NkVDgHOUvHcjcyVapqEMSfq0jYo+
         yzAzBap557X6u7+ZBSyqNPzBHP71dHS2Jo8kBqBAvSNuQ9MpEbUvmN/iByQshG6FvQr7
         HW3TekrASCpGZGHRUYkhHzqXJbEby59LNtXChDXjl6rf3c0YbkWRA6QVoMS2dsT2oGoG
         4C8L+slccSwiA159reu8GWVaS5WrMFo3IswfmQiotN9K7qNebI/nHEKoxPu/22nb62Kf
         39DVswNP0R4mmwurI1aFmXn9pgayKbgurHxgjzgewtEmczctvs/SCo6RSTvqahHyrmdi
         0l7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=AXse4muAeaYC3gLbixhZ8tneVeIz+kqzyPqgyg820Pk=;
        b=GkVbN4cBBtoEr31zLRxqDQlPm1NYBLBDD12m5z7bbx/95iF9vYWdEc2J5EhpQs26VA
         oU/k471H2HH6+bZUneH1AqM9fdsFEf/LwSqdnLLlt8HJ1nRwsCkDGIIzX/5yxO5XRb65
         K5JIFkiwnbIlw70UTGNGnZzQXoOsF2hxD3MkgfZuyTWkozOBUoaOR/dJ1uvFsrOKw95z
         c+Gw6b95LFS3b+nyaltoKXUnThBzYxiyAxSRNoaxM1YSBDZyGZa2UrixnH/n1dFdxI/5
         0Aqs+VjFxvQhVuz40roGtMuv8CFhtKwX2KrOgKQi0WXhOrWXHO3qyGXMT9L9MiOCuYyB
         OeFg==
X-Gm-Message-State: AOAM531WT4Z5QmreiZwve2JH2//BLK9IOp2wfMf3z1hj77Xl4Oqf0DTO
        MB6HsdKmydkQshxl5lfkeYgiILm4dRo=
X-Google-Smtp-Source: ABdhPJz+1sLqaPZ7mEWuhmDhT96tsjjTttGc8AsYQIz+Z7j22AN2eOI5F7OzQaf9a3RKiRFH3HwvNw==
X-Received: by 2002:a5d:508b:: with SMTP id a11mr2557251wrt.244.1627531123138;
        Wed, 28 Jul 2021 20:58:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7sm2068964wrr.54.2021.07.28.20.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 20:58:42 -0700 (PDT)
Message-Id: <ea08b34d29b999c1df54bce8dc668f1a23915471.1627531121.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.990.v2.git.1627531121.gitgitgadget@gmail.com>
References: <pull.990.git.1627044897.gitgitgadget@gmail.com>
        <pull.990.v2.git.1627531121.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Jul 2021 03:58:35 +0000
Subject: [PATCH v2 1/7] diffcore-rename: use a mem_pool for exact rename
 detection's hashmap
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
 diffcore-rename.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 4ef0459cfb5..73d884099eb 100644
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
 
@@ -354,8 +356,8 @@ static int find_exact_renames(struct diff_options *options)
 	for (i = 0; i < rename_dst_nr; i++)
 		renames += find_identical_files(&file_table, i, options);
 
-	/* Free the hash data structure and entries */
-	hashmap_clear_and_free(&file_table, struct file_similarity, entry);
+	/* Free the hash data structure (entries will be freed with the pool) */
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

