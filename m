Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553F4C433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 20:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E13520774
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 20:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Jyv/dV3W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgHKUv5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgHKUv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 16:51:56 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBC8C06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 13:51:56 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id g26so182749qka.3
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 13:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F8i3CrolrB3qgXoLmj1WcoctSOJOAoCyWhuWJxecEPA=;
        b=Jyv/dV3WJCsbx2oRcBGn0L/Lhs9EIVZ2xakHIvL/xRJnwKxMctf9rfwp4PHHk2d98+
         8Ubal2q+eQutB6D9aMbNK08FjIt2J+l6Qc7hf1Q9l5A5Gq2qo7fo+KORZQe9XMz4DdVZ
         riXgd6NEE7l3g8U/bJEtk/jlxsXXlHc9Ex4bsQrmssr6e+589alXeinLJyf9dNEb7ABT
         vUC0G8JRXWqZrv4m+BB6kCVAi4w/p/S+rrg1Jc0t1VdyEXgV5KRdt/UBUg4h5J9tbSth
         giAvNkcDqXNARWFLYsrovsmnKEuk4+tIlTCb1qXF+C0lL4YP/J7qZKWvxN11vN2c3Ob0
         tYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F8i3CrolrB3qgXoLmj1WcoctSOJOAoCyWhuWJxecEPA=;
        b=FLtadGKw3+SaspfmuI3FfKK99MMQlXX1ti4j+Yu0sTbWA2O1epnYdNF8TN6LJxNQkc
         +/vX8W+cMLDIY8u/NS23HopJmTvT93DU/iVMafPVcCdMbFsR2X8Gm8bUNspoAivKjkKv
         9t73n7VeMj1Ly11PJFo8U9JLRyimT/SA+YYYsmNBWa9C7oim33f0x2xAGCD07kOHxCj4
         DpKEpRtlyLx9KVhsAD7Joz1vFhO2zglcFylKnhqgnDeM2hmHTTwmmpRxhG3QFY+3pF8x
         VlG7vfcOwYj7kosQyix2q1oNSn62tLOh128ACv1cSNV4EMAOrdNT5sT5XqSETBhbjO35
         9IQw==
X-Gm-Message-State: AOAM531MlzFJtRZrxvSXGtDsn8rxpmZVWZ2ogTEo1xT2+XWILW8JchK1
        mYgWTW4CYy3yvw4t8Hi9b2OcXs7/yrxOTErl
X-Google-Smtp-Source: ABdhPJyHy6f4PScoTzlymZfJH/lK7dCa8piZ+7wbCOMNoKL0QrwjvGXQmsDHgi6230b8jYDPuTu0tA==
X-Received: by 2002:a37:44b:: with SMTP id 72mr3019610qke.494.1597179114965;
        Tue, 11 Aug 2020 13:51:54 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a92f:57be:59a6:7cb2])
        by smtp.gmail.com with ESMTPSA id q34sm21757089qtk.32.2020.08.11.13.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 13:51:54 -0700 (PDT)
Date:   Tue, 11 Aug 2020 16:51:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, szeder.dev@gmail.com,
        gitster@pobox.com
Subject: [PATCH v3 08/14] bloom: use provided 'struct bloom_filter_settings'
Message-ID: <4f08177dbe0f3cddfcc7cddbdb65446f410b6ecf.1597178915.git.me@ttaylorr.com>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1597178914.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When 'get_or_compute_bloom_filter()' needs to compute a Bloom filter
from scratch, it looks to the default 'struct bloom_filter_settings' in
order to determine the maximum number of changed paths, number of bits
per entry, and so on.

All of these values have so far been constant, and so there was no need
to pass in a pointer from the caller (eg., the one that is stored in the
'struct write_commit_graph_context').

Start passing in a 'struct bloom_filter_settings *' instead of using the
default values to respect graph-specific settings (eg., in the case of
setting 'GIT_TEST_BLOOM_SETTINGS_MAX_CHANGED_PATHS').

In order to have an initialized value for these settings, move its
initialization to earlier in the commit-graph write.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bloom.c               | 13 ++++++-------
 bloom.h               |  3 ++-
 commit-graph.c        | 21 ++++++++++-----------
 t/helper/test-bloom.c |  1 +
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/bloom.c b/bloom.c
index a8a21762f4..0cf1962dc5 100644
--- a/bloom.c
+++ b/bloom.c
@@ -180,13 +180,12 @@ static int pathmap_cmp(const void *hashmap_cmp_fn_data,
 struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 						 struct commit *c,
 						 int compute_if_not_present,
+						 const struct bloom_filter_settings *settings,
 						 int *computed)
 {
 	struct bloom_filter *filter;
-	struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
 	int i;
 	struct diff_options diffopt;
-	int max_changes = 512;
 
 	if (computed)
 		*computed = 0;
@@ -211,7 +210,7 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 	repo_diff_setup(r, &diffopt);
 	diffopt.flags.recursive = 1;
 	diffopt.detect_rename = 0;
-	diffopt.max_changes = max_changes;
+	diffopt.max_changes = settings->max_changed_paths;
 	diff_setup_done(&diffopt);
 
 	/* ensure commit is parsed so we have parent information */
@@ -223,7 +222,7 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 		diff_tree_oid(NULL, &c->object.oid, "", &diffopt);
 	diffcore_std(&diffopt);
 
-	if (diffopt.num_changes <= max_changes) {
+	if (diffopt.num_changes <= settings->max_changed_paths) {
 		struct hashmap pathmap;
 		struct pathmap_hash_entry *e;
 		struct hashmap_iter iter;
@@ -260,13 +259,13 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 			diff_free_filepair(diff_queued_diff.queue[i]);
 		}
 
-		filter->len = (hashmap_get_size(&pathmap) * settings.bits_per_entry + BITS_PER_WORD - 1) / BITS_PER_WORD;
+		filter->len = (hashmap_get_size(&pathmap) * settings->bits_per_entry + BITS_PER_WORD - 1) / BITS_PER_WORD;
 		filter->data = xcalloc(filter->len, sizeof(unsigned char));
 
 		hashmap_for_each_entry(&pathmap, &iter, e, entry) {
 			struct bloom_key key;
-			fill_bloom_key(e->path, strlen(e->path), &key, &settings);
-			add_key_to_filter(&key, filter, &settings);
+			fill_bloom_key(e->path, strlen(e->path), &key, settings);
+			add_key_to_filter(&key, filter, settings);
 		}
 
 		hashmap_free_entries(&pathmap, struct pathmap_hash_entry, entry);
diff --git a/bloom.h b/bloom.h
index baa91926db..3f19e3fca4 100644
--- a/bloom.h
+++ b/bloom.h
@@ -92,10 +92,11 @@ void init_bloom_filters(void);
 struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 						 struct commit *c,
 						 int compute_if_not_present,
+						 const struct bloom_filter_settings *settings,
 						 int *computed);
 
 #define get_bloom_filter(r, c) get_or_compute_bloom_filter( \
-	(r), (c), 0, NULL)
+	(r), (c), 0, NULL, NULL)
 
 int bloom_filter_contains(const struct bloom_filter *filter,
 			  const struct bloom_key *key,
diff --git a/commit-graph.c b/commit-graph.c
index ba2a2cfb22..48d4697f54 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1432,6 +1432,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 			ctx->r,
 			c,
 			1,
+			ctx->bloom_settings,
 			&computed);
 		if (computed) {
 			ctx->count_bloom_filter_computed++;
@@ -1688,17 +1689,6 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	int num_chunks = 3;
 	uint64_t chunk_offset;
 	struct object_id file_hash;
-	struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
-
-	if (!ctx->bloom_settings) {
-		bloom_settings.bits_per_entry = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY",
-							      bloom_settings.bits_per_entry);
-		bloom_settings.num_hashes = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_NUM_HASHES",
-							  bloom_settings.num_hashes);
-		bloom_settings.max_changed_paths = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_MAX_CHANGED_PATHS",
-							  bloom_settings.max_changed_paths);
-		ctx->bloom_settings = &bloom_settings;
-	}
 
 	if (ctx->split) {
 		struct strbuf tmp_file = STRBUF_INIT;
@@ -2144,6 +2134,7 @@ int write_commit_graph(struct object_directory *odb,
 	uint32_t i, count_distinct = 0;
 	int res = 0;
 	int replace = 0;
+	struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
 
 	if (!commit_graph_compatible(the_repository))
 		return 0;
@@ -2157,6 +2148,14 @@ int write_commit_graph(struct object_directory *odb,
 	ctx->split_opts = split_opts;
 	ctx->total_bloom_filter_data_size = 0;
 
+	bloom_settings.bits_per_entry = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY",
+						      bloom_settings.bits_per_entry);
+	bloom_settings.num_hashes = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_NUM_HASHES",
+						  bloom_settings.num_hashes);
+	bloom_settings.max_changed_paths = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_MAX_CHANGED_PATHS",
+							 bloom_settings.max_changed_paths);
+	ctx->bloom_settings = &bloom_settings;
+
 	if (flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS)
 		ctx->changed_paths = 1;
 	if (!(flags & COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS)) {
diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index 531af439c2..4af949164c 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -40,6 +40,7 @@ static void get_bloom_filter_for_commit(const struct object_id *commit_oid)
 	setup_git_directory();
 	c = lookup_commit(the_repository, commit_oid);
 	filter = get_or_compute_bloom_filter(the_repository, c, 1,
+					     &settings,
 					     NULL);
 	print_bloom_filter(filter);
 }
-- 
2.28.0.rc1.13.ge78abce653

