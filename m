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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBAFC433E0
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 11:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6FE9229C4
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 11:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbgL1LRf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 06:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbgL1LRe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 06:17:34 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B0BC06179A
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 03:16:17 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id q18so11061727wrn.1
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 03:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rjn+0mwSTH6YTjRp31OOFmg0eS5Ry84Z1I2Z2bLweJU=;
        b=phhfmkcmWwlXBJhmSw7ZVyHwM4cU77ejfCV3uv/EE22nEd4cnQRay2at/5OU4wkChz
         AjHHJXFWzPitFQq+0c6P1i3HgijAVHBfOQxCqQZbpP9cAXQm8bnhHcMc7DjkmpdABU/K
         8+EGoSEIOiHiAPEJ61fVAGRZdu3WoPV2ErW78Ab6vwgZi8vAVI+wydgaXxQTeiOErll3
         WsGUacu9gH4lrsPozwcp13DnSMHJ9qMj+/qtltUOb4TN+EjRYRBFwh7KwjybeJx2UF/5
         wT42i6HsAa/W4BZgqJ7/zjSbUwkhkRGYJgWEyLsZJYSywKMuYwN8fJaPvzwyAhaMY+JY
         pG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rjn+0mwSTH6YTjRp31OOFmg0eS5Ry84Z1I2Z2bLweJU=;
        b=VnZ2GAOQzgUk2fSoZJCGJiYxDb/toImcKiv8XOXdH5W8ur3QdiHYsOOMeUND6hcgVz
         NSG0gxo7Bl5VDFgQ4Duh0WPJUre/NCbvBv41lyxYVN7sO8H0elibYU0iaSJNCq6ahGGg
         q+/pFAmNOcIrJOHHAiWzyE/CrnmTECF+n6bGKjr7CCn86gSfl2QGs6pjsQ84K3hskQOh
         HfhtZ9zkZJ7z8o5t55NBoKMHHYHsKyAfrPoMKRxmm8SOTdDHsyFKCh0bv2ULud6myHb8
         koacRGbZnHCJGG6nhmjs9a1CBi+ywA+M3Sl7MWbql3Iy+edQIx5RKmZumzZCHldS3Vui
         nnMg==
X-Gm-Message-State: AOAM5325tYdsoLEdhVYzkysM7vJFN+0HXheU+4tLH8CTjWJrSp0WbPXt
        MCnWlfDFEsdSjWb9OltnUzTcYRe/oGg=
X-Google-Smtp-Source: ABdhPJyS/kvzBjlgB41Y1ioidjLC4S/4ETFJkpO8XEoiF3HKpHmbOPJAKvYs+D+LqV58IOVjiBUvVw==
X-Received: by 2002:a5d:4ccf:: with SMTP id c15mr51274334wrt.237.1609154176125;
        Mon, 28 Dec 2020 03:16:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h4sm53377836wrt.65.2020.12.28.03.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 03:16:15 -0800 (PST)
Message-Id: <baae700676405fba5153ec9d8c8f32760bda0a70.1609154168.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
References: <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
        <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Dec 2020 11:16:02 +0000
Subject: [PATCH v5 05/11] commit-graph: add a slab to store topological levels
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhishek Kumar <abhishekkumar8222@gmail.com>

In a later commit we will introduce corrected commit date as the
generation number v2. Corrected commit dates will be stored in the new
seperate Generation Data chunk. However, to ensure backwards
compatibility with "Old" Git we need to continue to write generation
number v1 (topological levels) to the commit data chunk. Thus, we need
to compute and store both versions of generation numbers to write the
commit-graph file.

Therefore, let's introduce a commit-slab `topo_level_slab` to store
topological levels; corrected commit date will be stored in the member
`generation` of struct commit_graph_data.

The macros `GENERATION_NUMBER_INFINITY` and `GENERATION_NUMBER_ZERO`
mark commits not in the commit-graph file and commits written by a
version of Git that did not compute generation numbers respectively.
Generation numbers are computed identically for both kinds of commits.

A "slab-miss" should return `GENERATION_NUMBER_INFINITY` as the commit
is not in the commit-graph file. However, since the slab is
zero-initialized, it returns 0 (or rather `GENERATION_NUMBER_ZERO`).
Thus, we no longer need to check if the topological level of a commit is
`GENERATION_NUMBER_INFINITY`.

We will add a pointer to the slab in `struct write_commit_graph_context`
and `struct commit_graph` to populate the slab in
`fill_commit_graph_info` if the commit has a pre-computed topological
level as in case of split commit-graphs.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-graph.c | 45 ++++++++++++++++++++++++++++++---------------
 commit-graph.h |  1 +
 2 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index d5b33b4f7ac..c98e8910fe2 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -64,6 +64,8 @@ void git_test_write_commit_graph_or_die(void)
 /* Remember to update object flag allocation in object.h */
 #define REACHABLE       (1u<<15)
 
+define_commit_slab(topo_level_slab, uint32_t);
+
 /* Keep track of the order in which commits are added to our list. */
 define_commit_slab(commit_pos, int);
 static struct commit_pos commit_pos = COMMIT_SLAB_INIT(1, commit_pos);
@@ -768,6 +770,9 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 	item->date = (timestamp_t)((date_high << 32) | date_low);
 
 	graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
+
+	if (g->topo_levels)
+		*topo_level_slab_at(g->topo_levels, item) = get_be32(commit_data + g->hash_len + 8) >> 2;
 }
 
 static inline void set_commit_tree(struct commit *c, struct tree *t)
@@ -956,6 +961,7 @@ struct write_commit_graph_context {
 		 changed_paths:1,
 		 order_by_pack:1;
 
+	struct topo_level_slab *topo_levels;
 	const struct commit_graph_opts *opts;
 	size_t total_bloom_filter_data_size;
 	const struct bloom_filter_settings *bloom_settings;
@@ -1102,7 +1108,7 @@ static int write_graph_chunk_data(struct hashfile *f,
 		else
 			packedDate[0] = 0;
 
-		packedDate[0] |= htonl(commit_graph_data_at(*list)->generation << 2);
+		packedDate[0] |= htonl(*topo_level_slab_at(ctx->topo_levels, *list) << 2);
 
 		packedDate[1] = htonl((*list)->date);
 		hashwrite(f, packedDate, 8);
@@ -1332,11 +1338,10 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 					_("Computing commit graph generation numbers"),
 					ctx->commits.nr);
 	for (i = 0; i < ctx->commits.nr; i++) {
-		uint32_t generation = commit_graph_data_at(ctx->commits.list[i])->generation;
+		uint32_t level = *topo_level_slab_at(ctx->topo_levels, ctx->commits.list[i]);
 
 		display_progress(ctx->progress, i + 1);
-		if (generation != GENERATION_NUMBER_INFINITY &&
-		    generation != GENERATION_NUMBER_ZERO)
+		if (level != GENERATION_NUMBER_ZERO)
 			continue;
 
 		commit_list_insert(ctx->commits.list[i], &list);
@@ -1344,29 +1349,26 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 			struct commit *current = list->item;
 			struct commit_list *parent;
 			int all_parents_computed = 1;
-			uint32_t max_generation = 0;
+			uint32_t max_level = 0;
 
 			for (parent = current->parents; parent; parent = parent->next) {
-				generation = commit_graph_data_at(parent->item)->generation;
+				level = *topo_level_slab_at(ctx->topo_levels, parent->item);
 
-				if (generation == GENERATION_NUMBER_INFINITY ||
-				    generation == GENERATION_NUMBER_ZERO) {
+				if (level == GENERATION_NUMBER_ZERO) {
 					all_parents_computed = 0;
 					commit_list_insert(parent->item, &list);
 					break;
-				} else if (generation > max_generation) {
-					max_generation = generation;
+				} else if (level > max_level) {
+					max_level = level;
 				}
 			}
 
 			if (all_parents_computed) {
-				struct commit_graph_data *data = commit_graph_data_at(current);
-
-				data->generation = max_generation + 1;
 				pop_commit(&list);
 
-				if (data->generation > GENERATION_NUMBER_MAX)
-					data->generation = GENERATION_NUMBER_MAX;
+				if (max_level > GENERATION_NUMBER_MAX - 1)
+					max_level = GENERATION_NUMBER_MAX - 1;
+				*topo_level_slab_at(ctx->topo_levels, current) = max_level + 1;
 			}
 		}
 	}
@@ -2102,6 +2104,7 @@ int write_commit_graph(struct object_directory *odb,
 	int res = 0;
 	int replace = 0;
 	struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
+	struct topo_level_slab topo_levels;
 
 	prepare_repo_settings(the_repository);
 	if (!the_repository->settings.core_commit_graph) {
@@ -2128,6 +2131,18 @@ int write_commit_graph(struct object_directory *odb,
 							 bloom_settings.max_changed_paths);
 	ctx->bloom_settings = &bloom_settings;
 
+	init_topo_level_slab(&topo_levels);
+	ctx->topo_levels = &topo_levels;
+
+	if (ctx->r->objects->commit_graph) {
+		struct commit_graph *g = ctx->r->objects->commit_graph;
+
+		while (g) {
+			g->topo_levels = &topo_levels;
+			g = g->base_graph;
+		}
+	}
+
 	if (flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS)
 		ctx->changed_paths = 1;
 	if (!(flags & COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS)) {
diff --git a/commit-graph.h b/commit-graph.h
index f8e92500c6e..00f00745b79 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -73,6 +73,7 @@ struct commit_graph {
 	const unsigned char *chunk_bloom_indexes;
 	const unsigned char *chunk_bloom_data;
 
+	struct topo_level_slab *topo_levels;
 	struct bloom_filter_settings *bloom_filter_settings;
 };
 
-- 
gitgitgadget

