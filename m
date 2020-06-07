Return-Path: <SRS0=8Spe=7U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E70EC433DF
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 19:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E98CE20748
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 19:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtA3Pyw6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgFGTev (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Jun 2020 15:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgFGTeu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jun 2020 15:34:50 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A0DC08C5C3
        for <git@vger.kernel.org>; Sun,  7 Jun 2020 12:34:51 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id i4so1036309pjd.0
        for <git@vger.kernel.org>; Sun, 07 Jun 2020 12:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WFSh+kMCaUkTsGRgdsJeaxg1eZEomM3rPHsa9cAn2zY=;
        b=dtA3Pyw6CSePlU4aTNce9GT3GVpLkDjgcZNiR3Gj6Ja0rVEqyUqxU3OGv3k3ECvjFO
         oCQ+e+G7C9S0ziXIjy12Rg6b8hJmgPyiiCtHAkt2bkPMcM6yE/ido91s0TzWm8GzTJ6O
         IRG2GLFRC6iVluX69qRjHd1x6Z5dNoKfxcQERMIyXA6+qZjg7eEOsMpoAMlcrU5zLEfg
         ZgOkAEvKfLYMKrcTJoh2pbLDvrarw9WyPEFIu46qIDs75T43ECFq/Fg5aeeRJic+/lNo
         rgNx2nKFe/TXryE6wcDUy3xlRk/Rxl7XF0Q5tGnkT8t/1Tu65gIFrSl3drSJvpeNN5gm
         jEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WFSh+kMCaUkTsGRgdsJeaxg1eZEomM3rPHsa9cAn2zY=;
        b=XKpfE7GX6P+5ek7XiVEbGlGOr/Sr8QdLk+Vsrg/rTitpC8fSzvNE4FP6g8AoRlAahi
         Tbn6b8+9RcBXZi6sgbAyL8MRMIDTT/QQcsOlPoQd+uNXf5K2N/1r40dsMIpjVTPR1Kw3
         2wTzscU29MHUThb3awOYW8DU3p54O4+EJA4cLUNwmdJHziqoFYiX+apvdxwFfZEDrmO9
         u8LhdqPuTmpfnZ8O9OUr9q5RzyNaANtq2gjPaXZgaw8ztnd8iHIfnfJXY1yau95tahLx
         a2GQw7M71nXXAzl3SB61OPKv2jqx32T8JJLWGeFf8gzkivgV3SG9RbryWfAo0PSpVuEu
         s+jA==
X-Gm-Message-State: AOAM531wCVw6p46szjb7KGAbuJlfzIe1a9//8kGP9x+FfOnb1t1q4c51
        GcxtoFV/vZPxo0A3jvJ69DXtUxFt
X-Google-Smtp-Source: ABdhPJxT5WQ8iUKPaV+Mn7lsc2qoCUPV78/OfIR22Rb6xvMc+QOGv3UdiuJfUYl2vH2CH+Kk5V/PmA==
X-Received: by 2002:a17:90a:aa8f:: with SMTP id l15mr14668214pjq.156.1591558490204;
        Sun, 07 Jun 2020 12:34:50 -0700 (PDT)
Received: from localhost.localdomain ([2409:4064:58e:925f:60d1:f386:43d2:4abb])
        by smtp.gmail.com with ESMTPSA id n69sm158595pfd.171.2020.06.07.12.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 12:34:49 -0700 (PDT)
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Cc:     jnareb@gmail.com, stolee@gmail.com
Subject: [GSOC Patch v2 4/4] commit-graph: minimize commit_graph_data_slab access
Date:   Mon,  8 Jun 2020 01:02:37 +0530
Message-Id: <20200607193237.699335-5-abhishekkumar8222@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200607193237.699335-1-abhishekkumar8222@gmail.com>
References: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
 <20200607193237.699335-1-abhishekkumar8222@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In an earlier patch, multiple struct acccesses to `graph_pos` and
`generation` were auto-converted to multiple method calls.

Since the values are fixed and commit-slab access costly, we would be
better off with storing the values as a local variable and reuse it.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>

[1]: https://lore.kernel.org/git/9a15c7ba-8b55-099a-3c59-b5e7ff6124f6@gmail.com/
---
 bloom.c        |  5 +++--
 commit-graph.c | 55 +++++++++++++++++++++++++++++-----------------
 commit-reach.c | 59 ++++++++++++++++++++++++++++++++------------------
 commit.c       |  6 +++--
 revision.c     | 12 ++++++----
 5 files changed, 88 insertions(+), 49 deletions(-)

diff --git a/bloom.c b/bloom.c
index df62e3763d..568ebd75e7 100644
--- a/bloom.c
+++ b/bloom.c
@@ -33,15 +33,16 @@ static int load_bloom_filter_from_graph(struct commit_graph *g,
 					struct commit *c)
 {
 	uint32_t lex_pos, start_index, end_index;
+	uint32_t graph_pos = commit_graph_position(c);
 
-	while (commit_graph_position(c) < g->num_commits_in_base)
+	while (graph_pos < g->num_commits_in_base)
 		g = g->base_graph;
 
 	/* The commit graph commit 'c' lives in doesn't carry bloom filters. */
 	if (!g->chunk_bloom_indexes)
 		return 0;
 
-	lex_pos = commit_graph_position(c) - g->num_commits_in_base;
+	lex_pos = graph_pos - g->num_commits_in_base;
 
 	end_index = get_be32(g->chunk_bloom_indexes + 4 * lex_pos);
 
diff --git a/commit-graph.c b/commit-graph.c
index 0dc79e7c90..5b10d1da2c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -141,10 +141,12 @@ static int commit_gen_cmp(const void *va, const void *vb)
 	const struct commit *a = *(const struct commit **)va;
 	const struct commit *b = *(const struct commit **)vb;
 
+	uint32_t generation_a = commit_graph_generation(a);
+	uint32_t generation_b = commit_graph_generation(b);
 	/* lower generation commits first */
-	if (commit_graph_generation(a) < commit_graph_generation(b))
+	if (generation_a < generation_b)
 		return -1;
-	else if (commit_graph_generation(a) > commit_graph_generation(b))
+	else if (generation_a > generation_b)
 		return 1;
 
 	/* use date as a heuristic when generations are equal */
@@ -726,6 +728,7 @@ static struct commit_list **insert_parent_or_die(struct repository *r,
 static void fill_commit_graph_info(struct commit *item, struct commit_graph *g, uint32_t pos)
 {
 	const unsigned char *commit_data;
+	struct commit_graph_data *graph_data;
 	uint32_t lex_index;
 
 	while (pos < g->num_commits_in_base)
@@ -733,8 +736,10 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 
 	lex_index = pos - g->num_commits_in_base;
 	commit_data = g->chunk_commit_data + GRAPH_DATA_WIDTH * lex_index;
-	commit_graph_data_at(item)->graph_pos = pos;
-	commit_graph_data_at(item)->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
+
+	graph_data = commit_graph_data_at(item);
+	graph_data->graph_pos = pos;
+	graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
 }
 
 static inline void set_commit_tree(struct commit *c, struct tree *t)
@@ -750,6 +755,7 @@ static int fill_commit_in_graph(struct repository *r,
 	uint32_t *parent_data_ptr;
 	uint64_t date_low, date_high;
 	struct commit_list **pptr;
+	struct commit_graph_data *graph_data;
 	const unsigned char *commit_data;
 	uint32_t lex_index;
 
@@ -763,7 +769,8 @@ static int fill_commit_in_graph(struct repository *r,
 	 * Store the "full" position, but then use the
 	 * "local" position for the rest of the calculation.
 	 */
-	commit_graph_data_at(item)->graph_pos = pos;
+	graph_data = commit_graph_data_at(item);
+	graph_data->graph_pos = pos;
 	lex_index = pos - g->num_commits_in_base;
 
 	commit_data = g->chunk_commit_data + (g->hash_len + 16) * lex_index;
@@ -776,7 +783,7 @@ static int fill_commit_in_graph(struct repository *r,
 	date_low = get_be32(commit_data + g->hash_len + 12);
 	item->date = (timestamp_t)((date_high << 32) | date_low);
 
-	commit_graph_data_at(item)->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
+	graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
 
 	pptr = &item->parents;
 
@@ -808,8 +815,9 @@ static int fill_commit_in_graph(struct repository *r,
 
 static int find_commit_in_graph(struct commit *item, struct commit_graph *g, uint32_t *pos)
 {
-	if (commit_graph_position(item) != COMMIT_NOT_FROM_GRAPH) {
-		*pos = commit_graph_position(item);
+	uint32_t graph_pos = commit_graph_position(item);
+	if (graph_pos != COMMIT_NOT_FROM_GRAPH) {
+		*pos = graph_pos;
 		return 1;
 	} else {
 		struct commit_graph *cur_g = g;
@@ -864,12 +872,13 @@ static struct tree *load_tree_for_commit(struct repository *r,
 {
 	struct object_id oid;
 	const unsigned char *commit_data;
+	uint32_t graph_pos = commit_graph_position(c);
 
-	while (commit_graph_position(c) < g->num_commits_in_base)
+	while (graph_pos < g->num_commits_in_base)
 		g = g->base_graph;
 
 	commit_data = g->chunk_commit_data +
-			GRAPH_DATA_WIDTH * (commit_graph_position(c) - g->num_commits_in_base);
+			GRAPH_DATA_WIDTH * (graph_pos - g->num_commits_in_base);
 
 	hashcpy(oid.hash, commit_data);
 	set_commit_tree(c, lookup_tree(r, &oid));
@@ -1301,7 +1310,7 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 					_("Computing commit graph generation numbers"),
 					ctx->commits.nr);
 	for (i = 0; i < ctx->commits.nr; i++) {
-		uint32_t generation = commit_graph_data_at(ctx->commits.list[i])->generation;
+		uint32_t generation = commit_graph_generation(ctx->commits.list[i]);
 
 		display_progress(ctx->progress, i + 1);
 		if (generation != GENERATION_NUMBER_INFINITY &&
@@ -1316,23 +1325,26 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 			uint32_t max_generation = 0;
 
 			for (parent = current->parents; parent; parent = parent->next) {
+				generation = commit_graph_generation(parent->item);
 
 				if (generation == GENERATION_NUMBER_INFINITY ||
 				    generation == GENERATION_NUMBER_ZERO) {
 					all_parents_computed = 0;
 					commit_list_insert(parent->item, &list);
 					break;
-				} else if (commit_graph_generation(parent->item) > max_generation) {
-					max_generation = commit_graph_generation(parent->item);
+				} else if (generation > max_generation) {
+					max_generation = generation;
 				}
 			}
 
 			if (all_parents_computed) {
-				commit_graph_data_at(current)->generation = max_generation + 1;
+				struct commit_graph_data *graph_data = commit_graph_data_at(current);
+
+				graph_data->generation = max_generation + 1;
 				pop_commit(&list);
 
-				if (commit_graph_generation(current) > GENERATION_NUMBER_MAX)
-					commit_graph_data_at(current)->generation = GENERATION_NUMBER_MAX;
+				if (graph_data->generation > GENERATION_NUMBER_MAX)
+					graph_data->generation = GENERATION_NUMBER_MAX;
 			}
 		}
 	}
@@ -2301,6 +2313,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 		struct commit *graph_commit, *odb_commit;
 		struct commit_list *graph_parents, *odb_parents;
 		uint32_t max_generation = 0;
+		uint32_t generation;
 
 		display_progress(progress, i + 1);
 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
@@ -2339,8 +2352,9 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 					     oid_to_hex(&graph_parents->item->object.oid),
 					     oid_to_hex(&odb_parents->item->object.oid));
 
-			if (commit_graph_generation(graph_parents->item) > max_generation)
-				max_generation = commit_graph_generation(graph_parents->item);
+			generation = commit_graph_generation(graph_parents->item);
+			if (generation > max_generation)
+				max_generation = generation;
 
 			graph_parents = graph_parents->next;
 			odb_parents = odb_parents->next;
@@ -2370,10 +2384,11 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 		if (max_generation == GENERATION_NUMBER_MAX)
 			max_generation--;
 
-		if (commit_graph_generation(graph_commit) != max_generation + 1)
+		generation = commit_graph_generation(graph_commit);
+		if (generation != max_generation + 1)
 			graph_report(_("commit-graph generation for commit %s is %u != %u"),
 				     oid_to_hex(&cur_oid),
-				     commit_graph_generation(graph_commit),
+				     generation,
 				     max_generation + 1);
 
 		if (graph_commit->date != odb_commit->date)
diff --git a/commit-reach.c b/commit-reach.c
index 3b2f863f5f..f5e5c0a32b 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -58,14 +58,15 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 		struct commit *commit = prio_queue_get(&queue);
 		struct commit_list *parents;
 		int flags;
+		uint32_t generation = commit_graph_generation(commit);
 
-		if (min_generation && commit_graph_generation(commit) > last_gen)
+		if (min_generation && generation > last_gen)
 			BUG("bad generation skip %8x > %8x at %s",
-			    commit_graph_generation(commit), last_gen,
+			    generation, last_gen,
 			    oid_to_hex(&commit->object.oid));
-		last_gen = commit_graph_generation(commit);
+		last_gen = generation;
 
-		if (commit_graph_generation(commit) < min_generation)
+		if (generation < min_generation)
 			break;
 
 		flags = commit->object.flags & (PARENT1 | PARENT2 | STALE);
@@ -181,13 +182,15 @@ static int remove_redundant(struct repository *r, struct commit **array, int cnt
 		if (redundant[i])
 			continue;
 		for (j = filled = 0; j < cnt; j++) {
+			uint32_t curr_generation;
 			if (i == j || redundant[j])
 				continue;
 			filled_index[filled] = j;
 			work[filled++] = array[j];
 
-			if (commit_graph_generation(array[j]) < min_generation)
-				min_generation = commit_graph_generation(array[j]);
+			curr_generation = commit_graph_generation(array[j]);
+			if (curr_generation < min_generation)
+				min_generation = curr_generation;
 		}
 		common = paint_down_to_common(r, array[i], filled,
 					      work, min_generation);
@@ -316,23 +319,26 @@ int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
 {
 	struct commit_list *bases;
 	int ret = 0, i;
-	uint32_t min_generation = GENERATION_NUMBER_INFINITY;
+	uint32_t generation, min_generation = GENERATION_NUMBER_INFINITY;
 
 	if (repo_parse_commit(r, commit))
 		return ret;
 	for (i = 0; i < nr_reference; i++) {
 		if (repo_parse_commit(r, reference[i]))
 			return ret;
-		if (commit_graph_generation(reference[i]) < min_generation)
-			min_generation = commit_graph_generation(reference[i]);
+
+		generation = commit_graph_generation(reference[i]);
+		if (generation < min_generation)
+			min_generation = generation;
 	}
 
-	if (commit_graph_generation(commit) > min_generation)
+	generation = commit_graph_generation(commit);
+	if (generation > min_generation)
 		return ret;
 
 	bases = paint_down_to_common(r, commit,
 				     nr_reference, reference,
-				     commit_graph_generation(commit));
+				     generation);
 	if (commit->object.flags & PARENT2)
 		ret = 1;
 	clear_commit_marks(commit, all_flags);
@@ -490,10 +496,12 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 	const struct commit_list *p;
 
 	for (p = want; p; p = p->next) {
+		uint32_t generation;
 		struct commit *c = p->item;
 		load_commit_graph_info(the_repository, c);
-		if (commit_graph_generation(c) < cutoff)
-			cutoff = commit_graph_generation(c);
+		generation = commit_graph_generation(c);
+		if (generation < cutoff)
+			cutoff = generation;
 	}
 
 	result = contains_test(candidate, want, cache, cutoff);
@@ -544,9 +552,12 @@ static int compare_commits_by_gen(const void *_a, const void *_b)
 	const struct commit *a = *(const struct commit * const *)_a;
 	const struct commit *b = *(const struct commit * const *)_b;
 
-	if (commit_graph_generation(a) < commit_graph_generation(b))
+	uint32_t generation_a = commit_graph_generation(a);
+	uint32_t generation_b = commit_graph_generation(b);
+
+	if (generation_a < generation_b)
 		return -1;
-	if (commit_graph_generation(a) > commit_graph_generation(b))
+	if (generation_a > generation_b)
 		return 1;
 	return 0;
 }
@@ -662,11 +673,13 @@ int can_all_from_reach(struct commit_list *from, struct commit_list *to,
 		add_object_array(&from_iter->item->object, NULL, &from_objs);
 
 		if (!parse_commit(from_iter->item)) {
+			uint32_t generation;
 			if (from_iter->item->date < min_commit_date)
 				min_commit_date = from_iter->item->date;
 
-			if (commit_graph_generation(from_iter->item) < min_generation)
-				min_generation = commit_graph_generation(from_iter->item);
+			generation = commit_graph_generation(from_iter->item);
+			if (generation < min_generation)
+				min_generation = generation;
 		}
 
 		from_iter = from_iter->next;
@@ -674,11 +687,13 @@ int can_all_from_reach(struct commit_list *from, struct commit_list *to,
 
 	while (to_iter) {
 		if (!parse_commit(to_iter->item)) {
+			uint32_t generation;
 			if (to_iter->item->date < min_commit_date)
 				min_commit_date = to_iter->item->date;
 
-			if (commit_graph_generation(to_iter->item) < min_generation)
-				min_generation = commit_graph_generation(to_iter->item);
+			generation = commit_graph_generation(to_iter->item);
+			if (generation < min_generation)
+				min_generation = generation;
 		}
 
 		to_iter->item->object.flags |= PARENT2;
@@ -718,11 +733,13 @@ struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
 	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
 
 	for (item = to; item < to_last; item++) {
+		uint32_t generation;
 		struct commit *c = *item;
 
 		parse_commit(c);
-		if (commit_graph_generation(c) < min_generation)
-			min_generation = commit_graph_generation(c);
+		generation = commit_graph_generation(c);
+		if (generation < min_generation)
+			min_generation = generation;
 
 		if (!(c->object.flags & PARENT1)) {
 			c->object.flags |= PARENT1;
diff --git a/commit.c b/commit.c
index ad9a76dcc6..f85ade78ed 100644
--- a/commit.c
+++ b/commit.c
@@ -729,11 +729,13 @@ int compare_commits_by_author_date(const void *a_, const void *b_,
 int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void *unused)
 {
 	const struct commit *a = a_, *b = b_;
+	const uint32_t generation_a = commit_graph_generation(a),
+		       generation_b = commit_graph_generation(b);
 
 	/* newer commits first */
-	if (commit_graph_generation(a) < commit_graph_generation(b))
+	if (generation_a < generation_b)
 		return 1;
-	else if (commit_graph_generation(a) > commit_graph_generation(b))
+	else if (generation_a > generation_b)
 		return -1;
 
 	/* use date as a heuristic when generations are equal */
diff --git a/revision.c b/revision.c
index cb1b200e9f..c257089808 100644
--- a/revision.c
+++ b/revision.c
@@ -3407,6 +3407,7 @@ static void init_topo_walk(struct rev_info *revs)
 	info->min_generation = GENERATION_NUMBER_INFINITY;
 	for (list = revs->commits; list; list = list->next) {
 		struct commit *c = list->item;
+		uint32_t generation;
 
 		if (parse_commit_gently(c, 1))
 			continue;
@@ -3414,8 +3415,9 @@ static void init_topo_walk(struct rev_info *revs)
 		test_flag_and_insert(&info->explore_queue, c, TOPO_WALK_EXPLORED);
 		test_flag_and_insert(&info->indegree_queue, c, TOPO_WALK_INDEGREE);
 
-		if (commit_graph_generation(c) < info->min_generation)
-			info->min_generation = commit_graph_generation(c);
+		generation = commit_graph_generation(c);
+		if (generation < info->min_generation)
+			info->min_generation = generation;
 
 		*(indegree_slab_at(&info->indegree, c)) = 1;
 
@@ -3466,6 +3468,7 @@ static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
 	for (p = commit->parents; p; p = p->next) {
 		struct commit *parent = p->item;
 		int *pi;
+		uint32_t generation;
 
 		if (parent->object.flags & UNINTERESTING)
 			continue;
@@ -3473,8 +3476,9 @@ static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
 		if (parse_commit_gently(parent, 1) < 0)
 			continue;
 
-		if (commit_graph_generation(parent) < info->min_generation) {
-			info->min_generation = commit_graph_generation(parent);
+		generation = commit_graph_generation(parent);
+		if (generation < info->min_generation) {
+			info->min_generation = generation;
 			compute_indegrees_to_depth(revs, info->min_generation);
 		}
 
-- 
2.27.0

