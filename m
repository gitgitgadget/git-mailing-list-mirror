Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C26AC4727E
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 14:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC58921531
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 14:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmAGzSvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgJGOJ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 10:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728577AbgJGOJy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 10:09:54 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74A6C0613D2
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 07:09:53 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id p15so2467868wmi.4
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 07:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y8g9rCoMUT6HMs0B9h7lOOzFLzETFkz2Vc3uvyYBhP8=;
        b=bmAGzSvD6LKWJnPy4m2vVi7VDmcO/gZ9y+gseDIba3XjCRmd92u/ipJzEUB7Jrihjv
         P6EAN9vM5XpOi3bHSe+GsYmoss/iqIjSShSCsgRB/oMkqxai1nRn201cooRycbtRUZJr
         ooLMNr3hnpogHs9bIoy2iXEX2+7xy5bgDZmWtGoDLvZkxXhfmh+pqFquw+QBajHcXizL
         LZ3pmpwWnuv27bTVOyF3DbuCDKX21p4wojgdXRZQ2PVLdgO9WoTdzMCGh8+t95WpyaVY
         UUUCr3NZuNu0oAGIzHxwRM1TU+gMFFOzZU1Wg+9j6riIQgW+HNQQvxCz5OfdtGzv/Z1I
         8sWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=y8g9rCoMUT6HMs0B9h7lOOzFLzETFkz2Vc3uvyYBhP8=;
        b=bzTgqjNrp4WznzSW5n2XjRcPS2nDM11/1awEl28ufbLC/zqNEWPgLRNyQUNQAUe/uG
         OgewI3jiuBbPj0XYiHWZiiqzGEgNbtPg4qX2HE06qDpEjV/CNEqdkBls56gS89VhA2+B
         XwG9FG/Vl5aVeGlgYgGk3ClkpUcpcvsWGvGmxTHZXucJfTgb6J5C0IcTYzHiKhXBPvoS
         CNhwcSIneM8pQTx34pf/burjBl2OsiPA0v5PSCCCTL4n3P0P78Ofe0moljOFnmaD3K30
         u49cGOMMSXU0dxKZI7LdMZnlnUl5X3VuZcBKkm+jDO2QWmUaMljWHVwSujZg+p78FtKn
         ubkA==
X-Gm-Message-State: AOAM530URtmecmy/OriEdCLtk5v6Ih7NV8mDs252OCIgU2wfHAn8IBE1
        4uNYf+iP95scmm8CMshWet34IPOY59w=
X-Google-Smtp-Source: ABdhPJztHDYBnFUrDY+8gSLpMS269B5scxowurV/sWQHFnuWpTooEmabK1ISsdgwq7RKu4A2UDRfSw==
X-Received: by 2002:a7b:ce86:: with SMTP id q6mr3663996wmj.163.1602079792268;
        Wed, 07 Oct 2020 07:09:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d30sm3302195wrc.19.2020.10.07.07.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 07:09:51 -0700 (PDT)
Message-Id: <e067f653ad5d474eee5f40c13bb02fde26ebdb9b.1602079786.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Oct 2020 14:09:40 +0000
Subject: [PATCH v4 05/10] commit-graph: add a slab to store topological levels
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
generation number v2. This value will be stored in the new seperate
Generation Data chunk. However, to ensure backwards compatibility with
"Old" Git we need to continue to write generation number v1, which is
topological level, to the commit data chunk. This means that we need to
compute both versions of generation numbers when writing the
commit-graph file. Therefore, let's introduce a commit-slab to store
topological levels; corrected commit date will be stored in the member
`generation` of struct commit_graph_data.

When Git creates a split commit-graph, it takes advantage of the
generation values that have been computed already and present in
existing commit-graph files.

So, let's add a pointer to struct commit_graph as well as struct
write_commit_graph_context to the topological level commit-slab
and populate it with topological levels while writing a commit-graph
file.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-graph.c | 47 ++++++++++++++++++++++++++++++++---------------
 commit-graph.h |  1 +
 2 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index bfc532de6f..cedd311024 100644
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
@@ -962,6 +967,7 @@ struct write_commit_graph_context {
 		 changed_paths:1,
 		 order_by_pack:1;
 
+	struct topo_level_slab *topo_levels;
 	const struct commit_graph_opts *opts;
 	size_t total_bloom_filter_data_size;
 	const struct bloom_filter_settings *bloom_settings;
@@ -1108,7 +1114,7 @@ static int write_graph_chunk_data(struct hashfile *f,
 		else
 			packedDate[0] = 0;
 
-		packedDate[0] |= htonl(commit_graph_data_at(*list)->generation << 2);
+		packedDate[0] |= htonl(*topo_level_slab_at(ctx->topo_levels, *list) << 2);
 
 		packedDate[1] = htonl((*list)->date);
 		hashwrite(f, packedDate, 8);
@@ -1350,11 +1356,11 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 					_("Computing commit graph generation numbers"),
 					ctx->commits.nr);
 	for (i = 0; i < ctx->commits.nr; i++) {
-		timestamp_t generation = commit_graph_data_at(ctx->commits.list[i])->generation;
+		timestamp_t level = *topo_level_slab_at(ctx->topo_levels, ctx->commits.list[i]);
 
 		display_progress(ctx->progress, i + 1);
-		if (generation != GENERATION_NUMBER_INFINITY &&
-		    generation != GENERATION_NUMBER_ZERO)
+		if (level != GENERATION_NUMBER_INFINITY &&
+		    level != GENERATION_NUMBER_ZERO)
 			continue;
 
 		commit_list_insert(ctx->commits.list[i], &list);
@@ -1362,29 +1368,27 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
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
+				if (level == GENERATION_NUMBER_INFINITY ||
+				    level == GENERATION_NUMBER_ZERO) {
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
 
-				if (data->generation > GENERATION_NUMBER_V1_MAX)
-					data->generation = GENERATION_NUMBER_V1_MAX;
+				if (max_level > GENERATION_NUMBER_V1_MAX - 1)
+					max_level = GENERATION_NUMBER_V1_MAX - 1;
+				*topo_level_slab_at(ctx->topo_levels, current) = max_level + 1;
 			}
 		}
 	}
@@ -2142,6 +2146,7 @@ int write_commit_graph(struct object_directory *odb,
 	int res = 0;
 	int replace = 0;
 	struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
+	struct topo_level_slab topo_levels;
 
 	if (!commit_graph_compatible(the_repository))
 		return 0;
@@ -2163,6 +2168,18 @@ int write_commit_graph(struct object_directory *odb,
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
index 8be247fa35..2e9aa7824e 100644
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

