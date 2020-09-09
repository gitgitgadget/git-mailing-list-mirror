Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4DDC433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 17:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B6B42166E
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 17:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="VNx4oq4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730988AbgIIRSs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgIIP17 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 11:27:59 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA876C0619E4
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 08:23:38 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id k25so2233055qtu.4
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 08:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BiRjnylEnwVA2iK7QdJpzD0m8pgZZ1JnlR/W6/KtEAM=;
        b=VNx4oq4p6ZONNoye5f3Xv6hfTDw+WIPmk4KObTJMGWDibPjNjuHyq7EBwatTjt+CQc
         FKnF9nW0rSLzuevKUkuEVDYLz1yWPzi21ucnSyd4WUU8qHEgEVJtMkV/7U+G5GQ1GDQK
         UfTYjyBvxQWDCRxA0i8emhuA/d1I6jvy9N88Jew/HXY3Y5Xaez3AOZmLRS3XKSo2U1TE
         O/tIGThWMhkL+N9dlXIi43Nm0nKcmgDtFs/tTRxG6efL43sfrcc0iaZO8apB/St5pm4G
         yIYtKUa+45kZ9vQae7rV95QFZYqDZ0XxYOJJXs6m3offek1S3Zux4QcFUPSyZYg0UIZJ
         8R6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BiRjnylEnwVA2iK7QdJpzD0m8pgZZ1JnlR/W6/KtEAM=;
        b=Zz2YpZxcqMaDd2pePYJSB/uCAKXm8uc25mPE+tywXnE3VXJOklQqo3Joa6ThcIn9sc
         6QW741+wKBbguxHuJlW2QLGgzi1FMOk07J/KcKkbjpfuI9HX0iQCzTgouigwu1AZTTI/
         rrnY849T+h8/IPxkx3XAiPnH7J3YLIsUeIwCi8mQ340fpgQFLs16eURCwyiBXBf4+OY4
         T8HlwbivhZYD8OFc3/ipVB5XSvHyGYHpkwIR8ul+mYzF+hI0205FMtz1A18hKATTpuVK
         yitLTreUrgqEn22RkPadvIwsvp5z7u0tuEfWizxSwXvMgNWF5XvNEMXb4z9GI9XGqgBb
         fYEQ==
X-Gm-Message-State: AOAM5311FCQmTXa8yPVZ5b9uTW4dwSf9xO4nrIzXWJ/8BfKYsLpOa9bY
        Mt4PxNDqjQ93gPDqRMgiMQKjvflqHOxoz3DI
X-Google-Smtp-Source: ABdhPJzsoVN+h1ljXBkarqz8H/nyFU29DKUao09QSyhs47EE58TQovLnyCq8lMfqBnM+5IdNOaxCdw==
X-Received: by 2002:ac8:794f:: with SMTP id r15mr3631963qtt.147.1599665015147;
        Wed, 09 Sep 2020 08:23:35 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:10e2:cf5e:922:2af0])
        by smtp.gmail.com with ESMTPSA id f8sm3134094qtx.81.2020.09.09.08.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:23:34 -0700 (PDT)
Date:   Wed, 9 Sep 2020 11:23:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH 08/12] bloom: use provided 'struct bloom_filter_settings'
Message-ID: <2841ecf152fc42a9955e7609c174959d525f0830.1599664389.git.me@ttaylorr.com>
References: <cover.1599664389.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1599664389.git.me@ttaylorr.com>
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
index b8b2c7ca65..500f29525a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1442,6 +1442,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 			ctx->r,
 			c,
 			1,
+			ctx->bloom_settings,
 			&computed);
 		if (computed & BLOOM_COMPUTED) {
 			ctx->count_bloom_filter_computed++;
@@ -1699,17 +1700,6 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
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
@@ -2155,6 +2145,7 @@ int write_commit_graph(struct object_directory *odb,
 	uint32_t i, count_distinct = 0;
 	int res = 0;
 	int replace = 0;
+	struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
 
 	if (!commit_graph_compatible(the_repository))
 		return 0;
@@ -2168,6 +2159,14 @@ int write_commit_graph(struct object_directory *odb,
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
2.28.0.462.g4ff11cec37

