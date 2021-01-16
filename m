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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24C5C4332D
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 18:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 882AF2255F
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 18:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbhAPSMp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 13:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbhAPSMo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 13:12:44 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12343C0613CF
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 10:11:28 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id k10so10074891wmi.3
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 10:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1c1aCEdyHy2ZwQKD9MQBGvB9fCTDPABdf9O5BY4o+yg=;
        b=HXgCZKoh6F7OuEXFMs5znjpqy4x6kNcziFPdYdfMrywB0jrtDYruYk1Uxv8ThDPCAM
         NKz8PTvrG1vqMqnaPFgRNx2fyqiBaqgyJSEZ1agxHHliMYoFblrMo7XJ0Ib3X6jBNsmy
         ZGQwyYwk+K2DnRk0qKPHftkQHUxJjG11Dta5TWcd9G4lShInEF2SmFaFHPW20SuPKpuz
         UJh72Xq38CkU9opYmmPdd3w7eR9Ja+N39An/Jj/IqnMKTffX/ggi9sKa1zaVx39Uv4LJ
         Ui23qwoifwEQHx+4Sdz1XS99CYYR8B1duUdbqt3n5nygGhfGCkuZOtv635BLhEFzxdCM
         1WbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1c1aCEdyHy2ZwQKD9MQBGvB9fCTDPABdf9O5BY4o+yg=;
        b=pL7XhkyW5w4Kq37OAMtAyaObrGmLBSLDQUJBUdGxs61H3tgDK2rOn+A+pnUaz2eB/v
         3z2/MfKggHgcUhv0FAzT+9p4eYYLXcZCExZr8rovjfJA/qG+sN0o78QuenU2USkLWp4L
         kj//lJn7UnJtA3sHXLtn76D3GJWi2Nk5Fz0QoOFAwijPE7jYRx/gCnHRDUb1JuP0Z/c8
         YT83NWjY/PNCYDlR4GZc7T5gPVdTjX+2Cvz/+XGgkwIOiCCX9vwUp5xSDhaAWqxWkGsz
         zo49GTh+ZkF/KUkVaGHyV8L1GJ3xHgBqPwEgB1fPhhs5e1qe5bkRO2uAU9TBzVrvwP8g
         qh5w==
X-Gm-Message-State: AOAM533TkmL3S6mvtGIOOdIQjXZ5VAeB0TdCjExWfSD7p71ulIpfARNY
        6a6INwz67An2uJRCii3dvGrkbHPHoto=
X-Google-Smtp-Source: ABdhPJzm2k8ggmFgFVu9e8eMAxWqlzT4TPDqhZ9lGnEtC2bhcmgB53syNghCjvSY6XxvQ2Tpj1xqZw==
X-Received: by 2002:a1c:24c4:: with SMTP id k187mr14324452wmk.14.1610820686480;
        Sat, 16 Jan 2021 10:11:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u205sm16543503wme.42.2021.01.16.10.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 10:11:25 -0800 (PST)
Message-Id: <fbd8feb5d8c0a52a9451c82db930baa4fa5f840f.1610820679.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v6.git.1610820679.gitgitgadget@gmail.com>
References: <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
        <pull.676.v6.git.1610820679.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 16 Jan 2021 18:11:12 +0000
Subject: [PATCH v6 05/11] commit-graph: add a slab to store topological levels
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
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
index 3d59b8b905d..3b69c3cc329 100644
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
@@ -772,6 +774,9 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 	item->date = (timestamp_t)((date_high << 32) | date_low);
 
 	graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
+
+	if (g->topo_levels)
+		*topo_level_slab_at(g->topo_levels, item) = get_be32(commit_data + g->hash_len + 8) >> 2;
 }
 
 static inline void set_commit_tree(struct commit *c, struct tree *t)
@@ -960,6 +965,7 @@ struct write_commit_graph_context {
 		 changed_paths:1,
 		 order_by_pack:1;
 
+	struct topo_level_slab *topo_levels;
 	const struct commit_graph_opts *opts;
 	size_t total_bloom_filter_data_size;
 	const struct bloom_filter_settings *bloom_settings;
@@ -1106,7 +1112,7 @@ static int write_graph_chunk_data(struct hashfile *f,
 		else
 			packedDate[0] = 0;
 
-		packedDate[0] |= htonl(commit_graph_data_at(*list)->generation << 2);
+		packedDate[0] |= htonl(*topo_level_slab_at(ctx->topo_levels, *list) << 2);
 
 		packedDate[1] = htonl((*list)->date);
 		hashwrite(f, packedDate, 8);
@@ -1336,11 +1342,10 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
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
@@ -1348,29 +1353,26 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
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
@@ -2106,6 +2108,7 @@ int write_commit_graph(struct object_directory *odb,
 	int res = 0;
 	int replace = 0;
 	struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
+	struct topo_level_slab topo_levels;
 
 	prepare_repo_settings(the_repository);
 	if (!the_repository->settings.core_commit_graph) {
@@ -2132,6 +2135,18 @@ int write_commit_graph(struct object_directory *odb,
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

