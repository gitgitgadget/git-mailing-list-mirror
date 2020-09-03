Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFABC43461
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 22:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6877A20716
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 22:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Jzt3q7I+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbgICWqn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 18:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbgICWqh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 18:46:37 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE3AC061244
        for <git@vger.kernel.org>; Thu,  3 Sep 2020 15:46:37 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id o5so4652070qke.12
        for <git@vger.kernel.org>; Thu, 03 Sep 2020 15:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uxiuIK+jPRSc7gmqToFl9A5SprpoJ36HUo59Kr/HhjM=;
        b=Jzt3q7I+M8kQDoFti9FQ0Tpf5W7U+v3BWV31mnOZWZdRYAxeMWeCCia7iv67vY7RAJ
         y1A9CchoyYobVj6PYxFH3j9/Kre4mkIAc+bxGXo/G7TXZtVvECVV2xw2MGfLSpOpiNsT
         v/0vpZAZLmnxqXiTGyNxKKcx21lmF1U+iK8elx0m6JIPCXyTFfPk0qY1i08iC/mtaKTQ
         PeR/z/gjk9HhRj8PL9tZkX8jjZpySw3R+LmJFDWUjCwgk+bjsT7t/hcCETmjjZ6wW2rq
         gYMWBahGmB7pCVKVX81QDnz3UaehGX4bEbifpZsZDjcAR/jAg2n00MurmIJCZ7dYxprY
         BT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uxiuIK+jPRSc7gmqToFl9A5SprpoJ36HUo59Kr/HhjM=;
        b=Y7qXZKO3ChBLXAAH5y82/KtwcTLNJzN8mpX3upaDamD5+Vjt0v+4OnG4JJwRhVOkRn
         Yj24EfU+8fwZ+pTlPZ6TXly8BWBlNjfjL5LwjAvOGDAKtfjaCpSBuXo7zQ0b8MM8sxLD
         YQkj102sqg4RQDvtQSouHxTY2PIT51bc0BOrR/gWyPVyDRlwborPJiBivUmE1LVOG0XX
         QC4gaVwFYGMOrsk/ipBVuFM0J6ojJ340WCjDeC+bYK/MZkiu9GXgTdOyJzkZc8CgMVCS
         37QLjUWnj2nGG+4OAIEdRqnGirjr3FOrfDDTtqHHedACEKskCqiLjOrBKOi+7FoYfXli
         Z35Q==
X-Gm-Message-State: AOAM533RL45vntc2YboLj5A3SleyYe2LQGblxrZvTSlLJ7VrJYSUZH49
        dh1Es8kEYrDqv7e2znVY+h+upTkdPDq6Vqgx
X-Google-Smtp-Source: ABdhPJxVH+AEAEDpgue2XqVCdX1IVd45ngGPT0fNUTYLMaqi8NsdTWUdHNRRhuk2sG/jnSrB0xXnNA==
X-Received: by 2002:a05:620a:4d9:: with SMTP id 25mr5250313qks.483.1599173196046;
        Thu, 03 Sep 2020 15:46:36 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a97c:6dae:76a4:c715])
        by smtp.gmail.com with ESMTPSA id i66sm3341816qkc.63.2020.09.03.15.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:46:35 -0700 (PDT)
Date:   Thu, 3 Sep 2020 18:46:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v4 08/14] bloom: use provided 'struct bloom_filter_settings'
Message-ID: <89bedba0899bfd1f9904c1122c2872ef39f69564.1599172908.git.me@ttaylorr.com>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1599172907.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1599172907.git.me@ttaylorr.com>
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
index cabac7f45b..7ba9ae26e1 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1439,6 +1439,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 			ctx->r,
 			c,
 			1,
+			ctx->bloom_settings,
 			&computed);
 		if (computed) {
 			ctx->count_bloom_filter_computed++;
@@ -1695,17 +1696,6 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
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
@@ -2151,6 +2141,7 @@ int write_commit_graph(struct object_directory *odb,
 	uint32_t i, count_distinct = 0;
 	int res = 0;
 	int replace = 0;
+	struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
 
 	if (!commit_graph_compatible(the_repository))
 		return 0;
@@ -2164,6 +2155,14 @@ int write_commit_graph(struct object_directory *odb,
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
2.27.0.2918.gc99a27ff8f

