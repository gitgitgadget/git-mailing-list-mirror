Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5965FC433E1
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 09:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E8A62082F
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 09:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fE2D8xN6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgFQJQf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 05:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgFQJQe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 05:16:34 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5443BC061573
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 02:16:34 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a45so2139657pje.1
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 02:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r6DQq0kpT8OmkRGrs5JJITy/igOnhgeKSaIO2OwPGKA=;
        b=fE2D8xN6Zcec2ypkJLN8HGatxAbYUpwH2z6X33egXYD0jQk9hr7yKKsBg9SOrS9d9S
         Cz7fjp9IRh7JLBGBrqlcB0RU/CyMC21GzqdzyN4eZRsn8h6cB90d/kOmRlPYozPW3+St
         Vvqbi2XLSCpZKi64dQUN5ybMwtjJFQUuEVvadn/FD2E4IZ4ODa0kW1Aq5aV3PfqTqujB
         VfixU8iXHad0qTV0Wrle8KFyPTOBFgK1MQq0z/WezlLqjsQDjAMLxVywg03/CQ9Df6KF
         ZsibOlWx3j4GKe5NayDm/xLal1EDN9sOFJ70DV/smVZSP27Q/b0TghQEnggla3V43p0y
         qNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r6DQq0kpT8OmkRGrs5JJITy/igOnhgeKSaIO2OwPGKA=;
        b=M7JYYFWO31fOjuuDHQI32kk7/KLcj6vEYp5Ht6byCpBi1syvsu13VLL77dWVrUyqIX
         EWJ/em1HV1JByhUOLBgCJAPjxrmIx5rYaKTF4O9CGGARrLCYqlx6QLeO1aurGmImVhBV
         jI/PEL8tsfWY/nwYa6Zlr4rE7/JsD04fBKrRRFC0bYmzXB++aRZWf3JNAU5pZ7hRJWV4
         IHFzOv7TzTjVPC2q8DZPD06fRs1ZavOlZi03X2sMaRZN+Tz+JK7oBzynCZR+32vAo5TN
         VeXJRy1GAc2mF1o4iOX07/Oq23RLR1LUA6bWl+sgKu15uqC/yYilZ+TOcRt4pw0pENLv
         TIPg==
X-Gm-Message-State: AOAM533myGHVp5SjDDuvhRejcy9VI/sysJPiXr5Td3fMf6+jbndnf6Oa
        yvbNIpFCg4Jzeke2qlSPpUfWyz+x
X-Google-Smtp-Source: ABdhPJyGG0ZEtH80YkPhIRr3yEyk4MsarWB6d3Hf26gouR2SaujlADf/+pLw951Wc2fnMuZCHUczXw==
X-Received: by 2002:a17:902:b78a:: with SMTP id e10mr5829650pls.201.1592385393153;
        Wed, 17 Jun 2020 02:16:33 -0700 (PDT)
Received: from localhost.localdomain ([2409:4064:40b:ccca:8c2b:e6b:e670:4483])
        by smtp.gmail.com with ESMTPSA id r8sm17162110pgn.19.2020.06.17.02.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 02:16:32 -0700 (PDT)
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Cc:     jnareb@gmail.com, stolee@gmail.com
Subject: [GSOC Patch v4 4/4] commit-graph: minimize commit_graph_data_slab access
Date:   Wed, 17 Jun 2020 14:44:11 +0530
Message-Id: <20200617091411.14650-5-abhishekkumar8222@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200617091411.14650-1-abhishekkumar8222@gmail.com>
References: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
 <20200617091411.14650-1-abhishekkumar8222@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In an earlier patch, multiple struct acccesses to `graph_pos` and
`generation` were auto-converted to multiple method calls.

Since the values are fixed and commit-slab access costly, we would be
better off with storing the values as a local variable and reusing it.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 bloom.c        |  5 +++--
 commit-graph.c | 40 ++++++++++++++++++++++------------
 commit-reach.c | 59 ++++++++++++++++++++++++++++++++------------------
 commit.c       |  6 +++--
 revision.c     | 12 ++++++----
 5 files changed, 79 insertions(+), 43 deletions(-)

diff --git a/bloom.c b/bloom.c
index 3062aafaba..6a7f2f2bdc 100644
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
index 14cc7e931c..fdd1c4fa7c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -144,10 +144,12 @@ static int commit_gen_cmp(const void *va, const void *vb)
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
@@ -729,6 +731,7 @@ static struct commit_list **insert_parent_or_die(struct repository *r,
 static void fill_commit_graph_info(struct commit *item, struct commit_graph *g, uint32_t pos)
 {
 	const unsigned char *commit_data;
+	struct commit_graph_data *graph_data;
 	uint32_t lex_index;
 
 	while (pos < g->num_commits_in_base)
@@ -736,8 +739,10 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 
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
@@ -753,6 +758,7 @@ static int fill_commit_in_graph(struct repository *r,
 	uint32_t *parent_data_ptr;
 	uint64_t date_low, date_high;
 	struct commit_list **pptr;
+	struct commit_graph_data *graph_data;
 	const unsigned char *commit_data;
 	uint32_t lex_index;
 
@@ -766,7 +772,8 @@ static int fill_commit_in_graph(struct repository *r,
 	 * Store the "full" position, but then use the
 	 * "local" position for the rest of the calculation.
 	 */
-	commit_graph_data_at(item)->graph_pos = pos;
+	graph_data = commit_graph_data_at(item);
+	graph_data->graph_pos = pos;
 	lex_index = pos - g->num_commits_in_base;
 
 	commit_data = g->chunk_commit_data + (g->hash_len + 16) * lex_index;
@@ -779,7 +786,7 @@ static int fill_commit_in_graph(struct repository *r,
 	date_low = get_be32(commit_data + g->hash_len + 12);
 	item->date = (timestamp_t)((date_high << 32) | date_low);
 
-	commit_graph_data_at(item)->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
+	graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
 
 	pptr = &item->parents;
 
@@ -811,8 +818,9 @@ static int fill_commit_in_graph(struct repository *r,
 
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
@@ -867,12 +875,13 @@ static struct tree *load_tree_for_commit(struct repository *r,
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
@@ -2299,6 +2308,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 		struct commit *graph_commit, *odb_commit;
 		struct commit_list *graph_parents, *odb_parents;
 		uint32_t max_generation = 0;
+		uint32_t generation;
 
 		display_progress(progress, i + 1);
 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
@@ -2337,8 +2347,9 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 					     oid_to_hex(&graph_parents->item->object.oid),
 					     oid_to_hex(&odb_parents->item->object.oid));
 
-			if (commit_graph_generation(graph_parents->item) > max_generation)
-				max_generation = commit_graph_generation(graph_parents->item);
+			generation = commit_graph_generation(graph_parents->item);
+			if (generation > max_generation)
+				max_generation = generation;
 
 			graph_parents = graph_parents->next;
 			odb_parents = odb_parents->next;
@@ -2368,10 +2379,11 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
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
index ed0917a2c7..43d29a800d 100644
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
index 8648d7c43c..32be93f404 100644
--- a/revision.c
+++ b/revision.c
@@ -3413,6 +3413,7 @@ static void init_topo_walk(struct rev_info *revs)
 	info->min_generation = GENERATION_NUMBER_INFINITY;
 	for (list = revs->commits; list; list = list->next) {
 		struct commit *c = list->item;
+		uint32_t generation;
 
 		if (parse_commit_gently(c, 1))
 			continue;
@@ -3420,8 +3421,9 @@ static void init_topo_walk(struct rev_info *revs)
 		test_flag_and_insert(&info->explore_queue, c, TOPO_WALK_EXPLORED);
 		test_flag_and_insert(&info->indegree_queue, c, TOPO_WALK_INDEGREE);
 
-		if (commit_graph_generation(c) < info->min_generation)
-			info->min_generation = commit_graph_generation(c);
+		generation = commit_graph_generation(c);
+		if (generation < info->min_generation)
+			info->min_generation = generation;
 
 		*(indegree_slab_at(&info->indegree, c)) = 1;
 
@@ -3472,6 +3474,7 @@ static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
 	for (p = commit->parents; p; p = p->next) {
 		struct commit *parent = p->item;
 		int *pi;
+		uint32_t generation;
 
 		if (parent->object.flags & UNINTERESTING)
 			continue;
@@ -3479,8 +3482,9 @@ static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
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

