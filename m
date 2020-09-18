Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3799C43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 02:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EA4B206B6
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 02:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="HM41Vdbu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgIRC7p (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 22:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbgIRC7b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 22:59:31 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264EFC061788
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 19:59:31 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n133so4612584qkn.11
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 19:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E12jXRgdP146uYSPs4osYnTSt/N+u1QZoMLSFzMtLlA=;
        b=HM41VdbuuiELBT58FmJAYB6f9Q5VXeSTm+ltTkf50v1g8jBodJyY/b5JDG3CjvBd3w
         RxqAjzgCDADZrjaDB7rb1E8qcc/dufkU+H9pghxq+GD9Y9RIKV/bfxd4YHNbWKR2IZ9C
         zjFYmSdzeSDKQgOmYE+3gNf6eH9knz5X3oT9kfuwWZ2ueZNt/ZvaYUNxNU2ArdC6MNhI
         +Lhgd0CaqkBZpOsccalLcpKro/t+3EB1wgtf7mIdzgfXPwi1XzWeeBwVbIAur1K6k/ex
         +hGyiv5AU6rHepR4hW6uuYjpZ1XGqzdB3OKC8n+FPFDFxaGB+vN1l+bq/hhQ5Z8AJWVn
         JWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E12jXRgdP146uYSPs4osYnTSt/N+u1QZoMLSFzMtLlA=;
        b=Dw18X67lXlmjZuZ5+8DPBmoko15nAWcXFC2+eY/Jv/Z79N5j4eIS0b6EA5wpe/NkN/
         o58eb+VfGcpWdDLvrCzaLfPAHT7a6z+rPFGcrfrTQE0+xeUBMP+mlB0OrqNMuCZQbeV5
         A3A5aWWKtnpDzy/fmP7X69phBZl5OO7zIQ4DDyU/tf5RrkxxJibzrcKMtJGKXqiSiU0z
         cTPYLmESBzZ4EuHu9uAJkxeYZC/obhJaudVIkjF2xVNtVi/nBwSqFM68zL/K7s1Im1qm
         1tMzLbqGMzty3A7kj3oAUuGdi1Zb3bIGA1nchDRywY43CuUf7uxwLqn370+i3lxN6EOO
         7Dnw==
X-Gm-Message-State: AOAM533foC/zggJDug5cW7DkOvyy51+NH1tmGPsKsrG5vahBdcJuUcot
        YqD4uo5xte5TeYfbRw8N3MmDDnshoIhrDuLo
X-Google-Smtp-Source: ABdhPJwl+8/SSy4P8V5ZWp+x6RAFJWrl8KuRZzsxI5+9N2F9xIIr0WZO1jQfIdBN2eei7cXxUx8JIg==
X-Received: by 2002:a37:a250:: with SMTP id l77mr30380147qke.219.1600397970024;
        Thu, 17 Sep 2020 19:59:30 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:2003:d617:ca70:4fd1])
        by smtp.gmail.com with ESMTPSA id d12sm1244116qka.34.2020.09.17.19.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 19:59:29 -0700 (PDT)
Date:   Thu, 17 Sep 2020 22:59:27 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v3 08/13] bloom: use provided 'struct bloom_filter_settings'
Message-ID: <3745baf8ef8810fe8e6031d06d2f6b8d967ef13c.1600397826.git.me@ttaylorr.com>
References: <cover.1599664389.git.me@ttaylorr.com>
 <cover.1600397826.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1600397826.git.me@ttaylorr.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 bloom.c               | 13 ++++++-------
 bloom.h               |  3 ++-
 commit-graph.c        | 21 ++++++++++-----------
 t/helper/test-bloom.c |  1 +
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/bloom.c b/bloom.c
index 393c61b4bc..2d6aef9098 100644
--- a/bloom.c
+++ b/bloom.c
@@ -180,13 +180,12 @@ static int pathmap_cmp(const void *hashmap_cmp_fn_data,
 struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 						 struct commit *c,
 						 int compute_if_not_present,
+						 const struct bloom_filter_settings *settings,
 						 enum bloom_filter_computed *computed)
 {
 	struct bloom_filter *filter;
-	struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
 	int i;
 	struct diff_options diffopt;
-	int max_changes = 512;
 
 	if (computed)
 		*computed = BLOOM_NOT_COMPUTED;
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
index e2e035ad14..c6d77e8393 100644
--- a/bloom.h
+++ b/bloom.h
@@ -98,10 +98,11 @@ enum bloom_filter_computed {
 struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 						 struct commit *c,
 						 int compute_if_not_present,
+						 const struct bloom_filter_settings *settings,
 						 enum bloom_filter_computed *computed);
 
 #define get_bloom_filter(r, c) get_or_compute_bloom_filter( \
-	(r), (c), 0, NULL)
+	(r), (c), 0, NULL, NULL)
 
 int bloom_filter_contains(const struct bloom_filter *filter,
 			  const struct bloom_key *key,
diff --git a/commit-graph.c b/commit-graph.c
index ecdab89e93..50519eb968 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1435,6 +1435,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 			ctx->r,
 			c,
 			1,
+			ctx->bloom_settings,
 			&computed);
 		if (computed & BLOOM_COMPUTED) {
 			ctx->count_bloom_filter_computed++;
@@ -1692,17 +1693,6 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
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
@@ -2148,6 +2138,7 @@ int write_commit_graph(struct object_directory *odb,
 	uint32_t i, count_distinct = 0;
 	int res = 0;
 	int replace = 0;
+	struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
 
 	if (!commit_graph_compatible(the_repository))
 		return 0;
@@ -2161,6 +2152,14 @@ int write_commit_graph(struct object_directory *odb,
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
index 9f7bb729fc..46e97b04eb 100644
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
2.28.0.510.g375ecf1f36

