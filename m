Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E47C43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D91CC2083B
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="BypM4iCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgIPSJE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbgIPSHv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 14:07:51 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536B7C061756
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 11:07:51 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id o5so9091494qke.12
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 11:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6gVVOBGTmn8w/w2wgbowEBipPA6rBGV/NBds/GeyL/g=;
        b=BypM4iCIRgJvjtq4o8z+tyew4nNP47zAMKcaOKnIPnOUzmUQUy7aS79dTSgH6ZAixB
         VIsJAAonDqQ8vyQ/2Vatx5Y6nD2RrfCYwIM/bo0xmqX3T649lKqjcfcXtsqBblVyObhv
         Y2Tx/1iJUG+QpDX1qEXPRAy+qNdZ1kfCcaGJZJI2UwTOUeXGvlNFEO08WtIBYDioou99
         9IZ2cLch/6LRivM/9VNBytU1LfjBiL6HdXXBr1uWBUhu+SywzxBQ/WXSJKoAhiatwiCV
         CP1eaR/KPYDtpKAjyVayID3wo9EIv4Aa/jlGhrIu+bBtAerKck1s37bxBM5cX+o2Zt9d
         herQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6gVVOBGTmn8w/w2wgbowEBipPA6rBGV/NBds/GeyL/g=;
        b=FQBaWWVvwyjvuzUXU8ddruuXMmFcPRHP9sjyzvM2HS3co5lAIgVYX6/JSBQDjIsYRJ
         su6M2zD+++b9jzAElKqLMuMctfB1dSdjX+tfKeJ71xbItScYoreTBhHXh8Wm49zgIMB4
         WXl6SKLRH3vRscgxDV3yn3mP8XzJRwhZR8IiJYnGhXXQ+uVjzWO4iX1tVNpZ0UpHzESS
         Nf8YEs/gz55MVvIg/MzPCowoyi2XDZxfHlBmQupiDmXUXuQQADt65QCzWv7K5T8V/ZDk
         rXggQafMcN+bYlVCnkZmuKX1ObBjBhDJuN+UrNndDBFCI28GiNHy211ubtXsNQ+HF8Tr
         B+ng==
X-Gm-Message-State: AOAM532xD3MWeaf60XXiE9JO7lzaKS82GzBmp2zDWSoATygnrTavv+BU
        E98YH/e+c6VpLFg0r3QDMmA6hUS7NP1wnJ0Q
X-Google-Smtp-Source: ABdhPJwFd6iveCdBeZLNRbfjoVbzNoo/PKM6eQoiBrNxa4OAyEv3wkslX2GzLhkfTVAp46ncjWEh+Q==
X-Received: by 2002:a37:7fc3:: with SMTP id a186mr19592527qkd.381.1600279669984;
        Wed, 16 Sep 2020 11:07:49 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:e86e:6adf:7537:ae24])
        by smtp.gmail.com with ESMTPSA id o4sm19337326qkk.75.2020.09.16.11.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 11:07:48 -0700 (PDT)
Date:   Wed, 16 Sep 2020 14:07:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v2 08/13] bloom: use provided 'struct bloom_filter_settings'
Message-ID: <b8e1e48bef3bbee631dbb88b832fae98a20c940b.1600279373.git.me@ttaylorr.com>
References: <cover.1599664389.git.me@ttaylorr.com>
 <cover.1600279373.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1600279373.git.me@ttaylorr.com>
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
index 45fcd62596..1ca754f19c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1434,6 +1434,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 			ctx->r,
 			c,
 			1,
+			ctx->bloom_settings,
 			&computed);
 		if (computed & BLOOM_COMPUTED) {
 			ctx->count_bloom_filter_computed++;
@@ -1691,17 +1692,6 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
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
@@ -2147,6 +2137,7 @@ int write_commit_graph(struct object_directory *odb,
 	uint32_t i, count_distinct = 0;
 	int res = 0;
 	int replace = 0;
+	struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
 
 	if (!commit_graph_compatible(the_repository))
 		return 0;
@@ -2160,6 +2151,14 @@ int write_commit_graph(struct object_directory *odb,
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
2.28.0.510.g86fdc5f89a

