Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F392C433DF
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 07:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E91D92072E
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 07:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4NXdGs8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgFDHaF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 03:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbgFDHaE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 03:30:04 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5C5C05BD1E
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 00:30:03 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t16so1861685plo.7
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 00:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pBFV12diVbOYQ6HJcfExL/djUWV0D75u+tb0XBmy4Do=;
        b=m4NXdGs8COQvLggZ5x5ybayOYNyseDkzYbJBrWaMBm6HjqsmNL/mzgdYcL7G2HipAG
         CPYHy1s0kN7x+mzzbD9kcbNG8jc0KUk7s/+Joh6PAkn18marTcUrIc4GeW0VKmIg0HZE
         exVR3s+DN27B66SipSyhehzeBK4YMEd9vrIypLxNKeiqdtqXwByGClR3E2Uak2L9osUj
         CMaIh/CAj9dHBA9w2bTl9W/ab4MTb/0kSGdpLL/VOclLS25IvzELeIZ2RHUrXrMYl5QN
         ZsQ1yHJ2Hn05HGa+cr6K99EVuy4XEgnLVanbQjWZ85UeZUtFSFu6eB+RPjZpmBBNLYxA
         Uqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pBFV12diVbOYQ6HJcfExL/djUWV0D75u+tb0XBmy4Do=;
        b=cXuVlKLraCmS021rtAVMyuNfrk9m28Zk9riWD9GQQp8j8FgtftqIsUfIB7Pel/Ylxl
         wTw71J2BtOJJzA2Ok7TibLtqLUCriLCWKt+RbT9nwnE6JN9aZdYcbAYWbPaRkKBd+MYM
         sK/nr0iW2jReFyFx8AWOPWYJKutS4dm8rLLTGJbIekANiVHRS5g0hUppc9hsZO0puu5N
         tqdC5N1XziG6hxSShKVyH73YuUXAGOMGZ2NYE6TU/AT6H2gxV0eXVKZGNBhJa/MPAGAH
         qM6HoJcNSvi8tsOrUDVSMNE+zTqunt/yhXOkEFX/SH8JHhLs77y6psncJLMN7NIs1Yy5
         oG9Q==
X-Gm-Message-State: AOAM531538tuMR1T7ZLl9auG/MdJyGksAG0rGEATVqTkWI7iE5q+mTsS
        yfJ80DWEWiiHhl1ZVVMmm3j3tvnJ
X-Google-Smtp-Source: ABdhPJwai10FHN8rcMYw8IGm7AbkV5UC+9VabyKH7ayWcDo/scml8Z/5HaE7WheYwYxjXlrF+8hsNQ==
X-Received: by 2002:a17:902:8303:: with SMTP id bd3mr3648286plb.217.1591255802806;
        Thu, 04 Jun 2020 00:30:02 -0700 (PDT)
Received: from localhost.localdomain ([2409:4064:2480:9552:2003:1696:484d:e269])
        by smtp.gmail.com with ESMTPSA id c12sm3335108pgt.91.2020.06.04.00.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 00:30:02 -0700 (PDT)
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, jnareb@gmail.com
Subject: [GSoC Patch 3/3] commit: convert commit->graph_pos to a slab
Date:   Thu,  4 Jun 2020 12:57:59 +0530
Message-Id: <20200604072759.19142-4-abhishekkumar8222@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
References: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The member graph_pos refers to the integer position used to identify a
commit in commit-graph files. However, graph_pos is not useful in other
contexts and bloats the struct.

Let's move it to a commit-slab and shrink the struct by four bytes.

Existing references to graph_pos are replaced using
'contrib/coccinelle/graph_pos.cocci'.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 alloc.c                            |  1 -
 bloom.c                            |  6 ++--
 commit-graph.c                     | 50 +++++++++++++++++++++++-------
 commit-graph.h                     |  3 ++
 commit.c                           |  2 +-
 commit.h                           |  2 --
 contrib/coccinelle/graph_pos.cocci | 12 +++++++
 7 files changed, 58 insertions(+), 18 deletions(-)
 create mode 100644 contrib/coccinelle/graph_pos.cocci

diff --git a/alloc.c b/alloc.c
index cbed187094..f37fb3b8b6 100644
--- a/alloc.c
+++ b/alloc.c
@@ -108,7 +108,6 @@ void init_commit_node(struct repository *r, struct commit *c)
 {
 	c->object.type = OBJ_COMMIT;
 	c->index = alloc_commit_index(r);
-	c->graph_pos = COMMIT_NOT_FROM_GRAPH;
 }
 
 void *alloc_commit_node(struct repository *r)
diff --git a/bloom.c b/bloom.c
index 9b86aa3f59..5bee5bb0c1 100644
--- a/bloom.c
+++ b/bloom.c
@@ -34,14 +34,14 @@ static int load_bloom_filter_from_graph(struct commit_graph *g,
 {
 	uint32_t lex_pos, start_index, end_index;
 
-	while (c->graph_pos < g->num_commits_in_base)
+	while (graph_pos(c) < g->num_commits_in_base)
 		g = g->base_graph;
 
 	/* The commit graph commit 'c' lives in doesn't carry bloom filters. */
 	if (!g->chunk_bloom_indexes)
 		return 0;
 
-	lex_pos = c->graph_pos - g->num_commits_in_base;
+	lex_pos = graph_pos(c) - g->num_commits_in_base;
 
 	end_index = get_be32(g->chunk_bloom_indexes + 4 * lex_pos);
 
@@ -188,7 +188,7 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 
 	if (!filter->data) {
 		load_commit_graph_info(r, c);
-		if (c->graph_pos != COMMIT_NOT_FROM_GRAPH &&
+		if (graph_pos(c) != COMMIT_NOT_FROM_GRAPH &&
 			r->objects->commit_graph->chunk_bloom_indexes) {
 			if (load_bloom_filter_from_graph(r->objects->commit_graph, filter, c))
 				return filter;
diff --git a/commit-graph.c b/commit-graph.c
index 9ce7d4acb1..7ff460b442 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -87,6 +87,34 @@ static int commit_pos_cmp(const void *va, const void *vb)
 	       commit_pos_at(&commit_pos, b);
 }
 
+define_commit_slab(graph_pos_slab, uint32_t);
+static struct graph_pos_slab graph_pos_slab = COMMIT_SLAB_INIT(1, graph_pos_slab);
+
+uint32_t graph_pos(const struct commit *c)
+{
+	uint32_t *pos = graph_pos_slab_peek(&graph_pos_slab, c);
+
+	return pos ? *pos : COMMIT_NOT_FROM_GRAPH;
+}
+
+static void set_graph_pos(const struct commit *c, const uint32_t position)
+{
+	unsigned int i = graph_pos_slab.slab_count;
+	uint32_t *pos = graph_pos_slab_at(&graph_pos_slab, c);
+
+	/*
+	 * commit-slab initializes with zero, overwrite this with
+	 * COMMIT_NOT_FROM_GRAPH
+	 */
+	for (; i < graph_pos_slab.slab_count; ++i)
+	{
+		memset(graph_pos_slab.slab[i], COMMIT_NOT_FROM_GRAPH,
+		       graph_pos_slab.slab_size * sizeof(uint32_t));
+	}
+
+	*pos = position;
+}
+
 define_commit_slab(generation_slab, uint32_t);
 static struct generation_slab generation_slab = COMMIT_SLAB_INIT(1, generation_slab);
 
@@ -697,7 +725,7 @@ static struct commit_list **insert_parent_or_die(struct repository *r,
 	c = lookup_commit(r, &oid);
 	if (!c)
 		die(_("could not find commit %s"), oid_to_hex(&oid));
-	c->graph_pos = pos;
+	set_graph_pos(c, pos);
 	return &commit_list_insert(c, pptr)->next;
 }
 
@@ -711,7 +739,7 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 
 	lex_index = pos - g->num_commits_in_base;
 	commit_data = g->chunk_commit_data + GRAPH_DATA_WIDTH * lex_index;
-	item->graph_pos = pos;
+	set_graph_pos(item, pos);
 	set_generation(item, get_be32(commit_data + g->hash_len + 8) >> 2);
 }
 
@@ -741,7 +769,7 @@ static int fill_commit_in_graph(struct repository *r,
 	 * Store the "full" position, but then use the
 	 * "local" position for the rest of the calculation.
 	 */
-	item->graph_pos = pos;
+	set_graph_pos(item, pos);
 	lex_index = pos - g->num_commits_in_base;
 
 	commit_data = g->chunk_commit_data + (g->hash_len + 16) * lex_index;
@@ -786,8 +814,8 @@ static int fill_commit_in_graph(struct repository *r,
 
 static int find_commit_in_graph(struct commit *item, struct commit_graph *g, uint32_t *pos)
 {
-	if (item->graph_pos != COMMIT_NOT_FROM_GRAPH) {
-		*pos = item->graph_pos;
+	if (graph_pos(item) != COMMIT_NOT_FROM_GRAPH) {
+		*pos = graph_pos(item);
 		return 1;
 	} else {
 		struct commit_graph *cur_g = g;
@@ -843,11 +871,11 @@ static struct tree *load_tree_for_commit(struct repository *r,
 	struct object_id oid;
 	const unsigned char *commit_data;
 
-	while (c->graph_pos < g->num_commits_in_base)
+	while (graph_pos(c) < g->num_commits_in_base)
 		g = g->base_graph;
 
 	commit_data = g->chunk_commit_data +
-			GRAPH_DATA_WIDTH * (c->graph_pos - g->num_commits_in_base);
+			GRAPH_DATA_WIDTH * (graph_pos(c) - g->num_commits_in_base);
 
 	hashcpy(oid.hash, commit_data);
 	set_commit_tree(c, lookup_tree(r, &oid));
@@ -861,7 +889,7 @@ static struct tree *get_commit_tree_in_graph_one(struct repository *r,
 {
 	if (c->maybe_tree)
 		return c->maybe_tree;
-	if (c->graph_pos == COMMIT_NOT_FROM_GRAPH)
+	if (graph_pos(c) == COMMIT_NOT_FROM_GRAPH)
 		BUG("get_commit_tree_in_graph_one called from non-commit-graph commit");
 
 	return load_tree_for_commit(r, g, (struct commit *)c);
@@ -1247,7 +1275,7 @@ static void close_reachable(struct write_commit_graph_context *ctx)
 			continue;
 		if (ctx->split) {
 			if ((!parse_commit(commit) &&
-			     commit->graph_pos == COMMIT_NOT_FROM_GRAPH) ||
+			     graph_pos(commit) == COMMIT_NOT_FROM_GRAPH) ||
 			    flags == COMMIT_GRAPH_SPLIT_REPLACE)
 				add_missing_parents(ctx, commit);
 		} else if (!parse_commit_no_graph(commit))
@@ -1493,7 +1521,7 @@ static uint32_t count_distinct_commits(struct write_commit_graph_context *ctx)
 			if (ctx->split) {
 				struct commit *c = lookup_commit(ctx->r, &ctx->oids.list[i]);
 
-				if (!c || c->graph_pos != COMMIT_NOT_FROM_GRAPH)
+				if (!c || graph_pos(c) != COMMIT_NOT_FROM_GRAPH)
 					continue;
 			}
 
@@ -1527,7 +1555,7 @@ static void copy_oids_to_commits(struct write_commit_graph_context *ctx)
 		ctx->commits.list[ctx->commits.nr] = lookup_commit(ctx->r, &ctx->oids.list[i]);
 
 		if (ctx->split && flags != COMMIT_GRAPH_SPLIT_REPLACE &&
-		    ctx->commits.list[ctx->commits.nr]->graph_pos != COMMIT_NOT_FROM_GRAPH)
+		    graph_pos(ctx->commits.list[ctx->commits.nr]) != COMMIT_NOT_FROM_GRAPH)
 			continue;
 
 		if (ctx->split && flags == COMMIT_GRAPH_SPLIT_REPLACE)
diff --git a/commit-graph.h b/commit-graph.h
index 653bd041ad..3cb59ba336 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -8,6 +8,7 @@
 #include "object-store.h"
 #include "oidset.h"
 
+#define COMMIT_NOT_FROM_GRAPH 0xFFFFFFFF
 #define GENERATION_NUMBER_INFINITY 0xFFFFFFFF
 #define GENERATION_NUMBER_MAX 0x3FFFFFFF
 #define GENERATION_NUMBER_ZERO 0
@@ -142,4 +143,6 @@ void free_commit_graph(struct commit_graph *);
 void disable_commit_graph(struct repository *r);
 
 uint32_t generation(const struct commit *c);
+
+uint32_t graph_pos(const struct commit *c);
 #endif
diff --git a/commit.c b/commit.c
index 8dad0f8446..da6de08b2b 100644
--- a/commit.c
+++ b/commit.c
@@ -339,7 +339,7 @@ struct tree *repo_get_commit_tree(struct repository *r,
 	if (commit->maybe_tree || !commit->object.parsed)
 		return commit->maybe_tree;
 
-	if (commit->graph_pos != COMMIT_NOT_FROM_GRAPH)
+	if (graph_pos(commit) != COMMIT_NOT_FROM_GRAPH)
 		return get_commit_tree_in_graph(r, commit);
 
 	return NULL;
diff --git a/commit.h b/commit.h
index 01e1c4c3eb..0b10464a10 100644
--- a/commit.h
+++ b/commit.h
@@ -10,8 +10,6 @@
 #include "pretty.h"
 #include "commit-slab.h"
 
-#define COMMIT_NOT_FROM_GRAPH 0xFFFFFFFF
-
 struct commit_list {
 	struct commit *item;
 	struct commit_list *next;
diff --git a/contrib/coccinelle/graph_pos.cocci b/contrib/coccinelle/graph_pos.cocci
new file mode 100644
index 0000000000..0929164bdf
--- /dev/null
+++ b/contrib/coccinelle/graph_pos.cocci
@@ -0,0 +1,12 @@
+@@
+struct commit *c;
+expression E;
+@@
+- c->graph_pos = E
++ set_graph_pos(c, E)
+
+@@
+struct commit *c;
+@@
+- c->graph_pos
++ graph_pos(c)
-- 
2.27.0

