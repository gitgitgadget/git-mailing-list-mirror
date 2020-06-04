Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D45C433E1
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 07:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2168D2077D
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 07:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5Ecx3T4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgFDHaD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 03:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbgFDH37 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 03:29:59 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30675C05BD1E
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 00:29:59 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 64so2887321pfg.8
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 00:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ancEd3vOSQRZq9RdwjLktYexJ9kMToKV3T19WGteVYs=;
        b=l5Ecx3T4QQC0jwNsq+qCo7zBg3H1xCeLQFewF0dviaRzix87YapzMGxbHMzExEhz1h
         w9e4nFzSPFHOok134SKbXNrPpmfEJFEzlaRqlUpcV+++UnEB+ak3R+jdFdtqROunqvyP
         zOroWc+yQzjKJn940QJfJ+jeYyeEiVErOf0ZA+o9JotlH3kfBykcmCnST4twWC+FzI0+
         cdjVO2Ik2mGlBZoOcDmYMkD8Lh1ozhT7nRT6m+wglk6FaKV+/oc5pg/gdQ1b5/2TiM6y
         jp0PJv3qxxa3DPJyNLkS/5vwAd8b1aLIflHZIIWWuWvry/XAnIfi3UcWNZXFtzo5RkQc
         6kNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ancEd3vOSQRZq9RdwjLktYexJ9kMToKV3T19WGteVYs=;
        b=seAwhQt8VfZOvhAKK5Y74hyPnMuYVyZrsXAewpi1x+8A/aSaC6WQ+MPqaHSNqFuvg4
         J8FnuBC27DFDo34Z/Ew/6a3lt/X2OKO6D1vz6xjwHaoNUUaSsJvhEmMwqQGBi4AX0CjE
         tJbiFroox+mUtlanBlXRmWZYKSYkkqoq/mtYO3GIqQaE67ccr5ieOMZ2tQ+B9KKCtSLg
         lpLciwg3xsZWCwtH3+UEEurf0xCrqf+yn4/xCMPoM93S73MtsQS/F2o3+v7dNOdvmilo
         SWTjnXVkV5q5ETxVr4VrFviq1R7oBTMNAWm+nnIFkcJCQGbVyDRIxQQyRzpvu5QOFbzV
         1tMw==
X-Gm-Message-State: AOAM533Gka2s3zm2VnJNut0sEwx4/RJ9qpI2bBhvMr+anu+UYweXccZx
        vkk2IPukeXTnwsJCAgNcHQm1c0kk
X-Google-Smtp-Source: ABdhPJzc3x5zRUXRI4+cupqT4CB4nOvHpLEQkf4k5O+U0th2dL3fo/4cLEwJMNcvmfNwWWGWlLHQEg==
X-Received: by 2002:a05:6a00:14ce:: with SMTP id w14mr3059854pfu.121.1591255797863;
        Thu, 04 Jun 2020 00:29:57 -0700 (PDT)
Received: from localhost.localdomain ([2409:4064:2480:9552:2003:1696:484d:e269])
        by smtp.gmail.com with ESMTPSA id c12sm3335108pgt.91.2020.06.04.00.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 00:29:57 -0700 (PDT)
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, jnareb@gmail.com
Subject: [GSoC Patch 2/3] commit: convert commit->generation to a slab
Date:   Thu,  4 Jun 2020 12:57:58 +0530
Message-Id: <20200604072759.19142-3-abhishekkumar8222@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
References: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this commit, we will use the generation slab helpers introduced in
last commit and replace existing uses of commit->generation using
'contrib/coccinelle/generation.cocci'

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 alloc.c                             |  1 -
 blame.c                             |  2 +-
 commit-graph.c                      | 39 +++++++++++-----------
 commit-reach.c                      | 50 ++++++++++++++---------------
 commit.c                            |  4 +--
 commit.h                            |  1 -
 contrib/coccinelle/generation.cocci | 12 +++++++
 revision.c                          | 16 ++++-----
 8 files changed, 68 insertions(+), 57 deletions(-)
 create mode 100644 contrib/coccinelle/generation.cocci

diff --git a/alloc.c b/alloc.c
index 1c64c4dd16..cbed187094 100644
--- a/alloc.c
+++ b/alloc.c
@@ -109,7 +109,6 @@ void init_commit_node(struct repository *r, struct commit *c)
 	c->object.type = OBJ_COMMIT;
 	c->index = alloc_commit_index(r);
 	c->graph_pos = COMMIT_NOT_FROM_GRAPH;
-	c->generation = GENERATION_NUMBER_INFINITY;
 }
 
 void *alloc_commit_node(struct repository *r)
diff --git a/blame.c b/blame.c
index da7e28800e..50e6316076 100644
--- a/blame.c
+++ b/blame.c
@@ -1272,7 +1272,7 @@ static int maybe_changed_path(struct repository *r,
 	if (!bd)
 		return 1;
 
-	if (origin->commit->generation == GENERATION_NUMBER_INFINITY)
+	if (generation(origin->commit) == GENERATION_NUMBER_INFINITY)
 		return 1;
 
 	filter = get_bloom_filter(r, origin->commit, 0);
diff --git a/commit-graph.c b/commit-graph.c
index 63f419048d..9ce7d4acb1 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -120,9 +120,9 @@ static int commit_gen_cmp(const void *va, const void *vb)
 	const struct commit *b = *(const struct commit **)vb;
 
 	/* lower generation commits first */
-	if (a->generation < b->generation)
+	if (generation(a) < generation(b))
 		return -1;
-	else if (a->generation > b->generation)
+	else if (generation(a) > generation(b))
 		return 1;
 
 	/* use date as a heuristic when generations are equal */
@@ -712,7 +712,7 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 	lex_index = pos - g->num_commits_in_base;
 	commit_data = g->chunk_commit_data + GRAPH_DATA_WIDTH * lex_index;
 	item->graph_pos = pos;
-	item->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
+	set_generation(item, get_be32(commit_data + g->hash_len + 8) >> 2);
 }
 
 static inline void set_commit_tree(struct commit *c, struct tree *t)
@@ -754,7 +754,7 @@ static int fill_commit_in_graph(struct repository *r,
 	date_low = get_be32(commit_data + g->hash_len + 12);
 	item->date = (timestamp_t)((date_high << 32) | date_low);
 
-	item->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
+	set_generation(item, get_be32(commit_data + g->hash_len + 8) >> 2);
 
 	pptr = &item->parents;
 
@@ -1048,7 +1048,7 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 		else
 			packedDate[0] = 0;
 
-		packedDate[0] |= htonl((*list)->generation << 2);
+		packedDate[0] |= htonl(generation((*list)) << 2);
 
 		packedDate[1] = htonl((*list)->date);
 		hashwrite(f, packedDate, 8);
@@ -1280,8 +1280,8 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 					ctx->commits.nr);
 	for (i = 0; i < ctx->commits.nr; i++) {
 		display_progress(ctx->progress, i + 1);
-		if (ctx->commits.list[i]->generation != GENERATION_NUMBER_INFINITY &&
-		    ctx->commits.list[i]->generation != GENERATION_NUMBER_ZERO)
+		if (generation(ctx->commits.list[i]) != GENERATION_NUMBER_INFINITY &&
+		    generation(ctx->commits.list[i]) != GENERATION_NUMBER_ZERO)
 			continue;
 
 		commit_list_insert(ctx->commits.list[i], &list);
@@ -1292,22 +1292,23 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 			uint32_t max_generation = 0;
 
 			for (parent = current->parents; parent; parent = parent->next) {
-				if (parent->item->generation == GENERATION_NUMBER_INFINITY ||
-				    parent->item->generation == GENERATION_NUMBER_ZERO) {
+				if (generation(parent->item) == GENERATION_NUMBER_INFINITY ||
+				    generation(parent->item) == GENERATION_NUMBER_ZERO) {
 					all_parents_computed = 0;
 					commit_list_insert(parent->item, &list);
 					break;
-				} else if (parent->item->generation > max_generation) {
-					max_generation = parent->item->generation;
+				} else if (generation(parent->item) > max_generation) {
+					max_generation = generation(parent->item);
 				}
 			}
 
 			if (all_parents_computed) {
-				current->generation = max_generation + 1;
+				set_generation(current, max_generation + 1);
 				pop_commit(&list);
 
-				if (current->generation > GENERATION_NUMBER_MAX)
-					current->generation = GENERATION_NUMBER_MAX;
+				if (generation(current) > GENERATION_NUMBER_MAX)
+					set_generation(current,
+						       GENERATION_NUMBER_MAX);
 			}
 		}
 	}
@@ -2314,8 +2315,8 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 					     oid_to_hex(&graph_parents->item->object.oid),
 					     oid_to_hex(&odb_parents->item->object.oid));
 
-			if (graph_parents->item->generation > max_generation)
-				max_generation = graph_parents->item->generation;
+			if (generation(graph_parents->item) > max_generation)
+				max_generation = generation(graph_parents->item);
 
 			graph_parents = graph_parents->next;
 			odb_parents = odb_parents->next;
@@ -2325,7 +2326,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 			graph_report(_("commit-graph parent list for commit %s terminates early"),
 				     oid_to_hex(&cur_oid));
 
-		if (!graph_commit->generation) {
+		if (!generation(graph_commit)) {
 			if (generation_zero == GENERATION_NUMBER_EXISTS)
 				graph_report(_("commit-graph has generation number zero for commit %s, but non-zero elsewhere"),
 					     oid_to_hex(&cur_oid));
@@ -2345,10 +2346,10 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 		if (max_generation == GENERATION_NUMBER_MAX)
 			max_generation--;
 
-		if (graph_commit->generation != max_generation + 1)
+		if (generation(graph_commit) != max_generation + 1)
 			graph_report(_("commit-graph generation for commit %s is %u != %u"),
 				     oid_to_hex(&cur_oid),
-				     graph_commit->generation,
+				     generation(graph_commit),
 				     max_generation + 1);
 
 		if (graph_commit->date != odb_commit->date)
diff --git a/commit-reach.c b/commit-reach.c
index 4ca7e706a1..77c980054a 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -59,13 +59,13 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 		struct commit_list *parents;
 		int flags;
 
-		if (min_generation && commit->generation > last_gen)
+		if (min_generation && generation(commit) > last_gen)
 			BUG("bad generation skip %8x > %8x at %s",
-			    commit->generation, last_gen,
+			    generation(commit), last_gen,
 			    oid_to_hex(&commit->object.oid));
-		last_gen = commit->generation;
+		last_gen = generation(commit);
 
-		if (commit->generation < min_generation)
+		if (generation(commit) < min_generation)
 			break;
 
 		flags = commit->object.flags & (PARENT1 | PARENT2 | STALE);
@@ -176,7 +176,7 @@ static int remove_redundant(struct repository *r, struct commit **array, int cnt
 		repo_parse_commit(r, array[i]);
 	for (i = 0; i < cnt; i++) {
 		struct commit_list *common;
-		uint32_t min_generation = array[i]->generation;
+		uint32_t min_generation = generation(array[i]);
 
 		if (redundant[i])
 			continue;
@@ -186,8 +186,8 @@ static int remove_redundant(struct repository *r, struct commit **array, int cnt
 			filled_index[filled] = j;
 			work[filled++] = array[j];
 
-			if (array[j]->generation < min_generation)
-				min_generation = array[j]->generation;
+			if (generation(array[j]) < min_generation)
+				min_generation = generation(array[j]);
 		}
 		common = paint_down_to_common(r, array[i], filled,
 					      work, min_generation);
@@ -323,16 +323,16 @@ int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
 	for (i = 0; i < nr_reference; i++) {
 		if (repo_parse_commit(r, reference[i]))
 			return ret;
-		if (reference[i]->generation < min_generation)
-			min_generation = reference[i]->generation;
+		if (generation(reference[i]) < min_generation)
+			min_generation = generation(reference[i]);
 	}
 
-	if (commit->generation > min_generation)
+	if (generation(commit) > min_generation)
 		return ret;
 
 	bases = paint_down_to_common(r, commit,
 				     nr_reference, reference,
-				     commit->generation);
+				     generation(commit));
 	if (commit->object.flags & PARENT2)
 		ret = 1;
 	clear_commit_marks(commit, all_flags);
@@ -467,7 +467,7 @@ static enum contains_result contains_test(struct commit *candidate,
 	/* Otherwise, we don't know; prepare to recurse */
 	parse_commit_or_die(candidate);
 
-	if (candidate->generation < cutoff)
+	if (generation(candidate) < cutoff)
 		return CONTAINS_NO;
 
 	return CONTAINS_UNKNOWN;
@@ -492,8 +492,8 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 	for (p = want; p; p = p->next) {
 		struct commit *c = p->item;
 		load_commit_graph_info(the_repository, c);
-		if (c->generation < cutoff)
-			cutoff = c->generation;
+		if (generation(c) < cutoff)
+			cutoff = generation(c);
 	}
 
 	result = contains_test(candidate, want, cache, cutoff);
@@ -544,9 +544,9 @@ static int compare_commits_by_gen(const void *_a, const void *_b)
 	const struct commit *a = *(const struct commit * const *)_a;
 	const struct commit *b = *(const struct commit * const *)_b;
 
-	if (a->generation < b->generation)
+	if (generation(a) < generation(b))
 		return -1;
-	if (a->generation > b->generation)
+	if (generation(a) > generation(b))
 		return 1;
 	return 0;
 }
@@ -585,7 +585,7 @@ int can_all_from_reach_with_flag(struct object_array *from,
 
 		list[nr_commits] = (struct commit *)from_one;
 		if (parse_commit(list[nr_commits]) ||
-		    list[nr_commits]->generation < min_generation) {
+		    generation(list[nr_commits]) < min_generation) {
 			result = 0;
 			goto cleanup;
 		}
@@ -621,7 +621,7 @@ int can_all_from_reach_with_flag(struct object_array *from,
 
 					if (parse_commit(parent->item) ||
 					    parent->item->date < min_commit_date ||
-					    parent->item->generation < min_generation)
+					    generation(parent->item) < min_generation)
 						continue;
 
 					commit_list_insert(parent->item, &stack);
@@ -665,8 +665,8 @@ int can_all_from_reach(struct commit_list *from, struct commit_list *to,
 			if (from_iter->item->date < min_commit_date)
 				min_commit_date = from_iter->item->date;
 
-			if (from_iter->item->generation < min_generation)
-				min_generation = from_iter->item->generation;
+			if (generation(from_iter->item) < min_generation)
+				min_generation = generation(from_iter->item);
 		}
 
 		from_iter = from_iter->next;
@@ -677,8 +677,8 @@ int can_all_from_reach(struct commit_list *from, struct commit_list *to,
 			if (to_iter->item->date < min_commit_date)
 				min_commit_date = to_iter->item->date;
 
-			if (to_iter->item->generation < min_generation)
-				min_generation = to_iter->item->generation;
+			if (generation(to_iter->item) < min_generation)
+				min_generation = generation(to_iter->item);
 		}
 
 		to_iter->item->object.flags |= PARENT2;
@@ -721,8 +721,8 @@ struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
 		struct commit *c = *item;
 
 		parse_commit(c);
-		if (c->generation < min_generation)
-			min_generation = c->generation;
+		if (generation(c) < min_generation)
+			min_generation = generation(c);
 
 		if (!(c->object.flags & PARENT1)) {
 			c->object.flags |= PARENT1;
@@ -755,7 +755,7 @@ struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
 
 			parse_commit(p);
 
-			if (p->generation < min_generation)
+			if (generation(p) < min_generation)
 				continue;
 
 			if (p->object.flags & PARENT2)
diff --git a/commit.c b/commit.c
index 87686a7055..8dad0f8446 100644
--- a/commit.c
+++ b/commit.c
@@ -731,9 +731,9 @@ int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void
 	const struct commit *a = a_, *b = b_;
 
 	/* newer commits first */
-	if (a->generation < b->generation)
+	if (generation(a) < generation(b))
 		return 1;
-	else if (a->generation > b->generation)
+	else if (generation(a) > generation(b))
 		return -1;
 
 	/* use date as a heuristic when generations are equal */
diff --git a/commit.h b/commit.h
index cc610400d5..01e1c4c3eb 100644
--- a/commit.h
+++ b/commit.h
@@ -34,7 +34,6 @@ struct commit {
 	 */
 	struct tree *maybe_tree;
 	uint32_t graph_pos;
-	uint32_t generation;
 	unsigned int index;
 };
 
diff --git a/contrib/coccinelle/generation.cocci b/contrib/coccinelle/generation.cocci
new file mode 100644
index 0000000000..da13c44856
--- /dev/null
+++ b/contrib/coccinelle/generation.cocci
@@ -0,0 +1,12 @@
+@@
+struct commit *c;
+expression E;
+@@
+- c->generation = E
++ set_generation(c, E)
+
+@@
+struct commit *c;
+@@
+- c->generation
++ generation(c)
diff --git a/revision.c b/revision.c
index 60cca8c0b9..d76382007c 100644
--- a/revision.c
+++ b/revision.c
@@ -720,7 +720,7 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 	if (!revs->repo->objects->commit_graph)
 		return -1;
 
-	if (commit->generation == GENERATION_NUMBER_INFINITY)
+	if (generation(commit) == GENERATION_NUMBER_INFINITY)
 		return -1;
 
 	filter = get_bloom_filter(revs->repo, commit, 0);
@@ -3314,7 +3314,7 @@ static void explore_to_depth(struct rev_info *revs,
 	struct topo_walk_info *info = revs->topo_walk_info;
 	struct commit *c;
 	while ((c = prio_queue_peek(&info->explore_queue)) &&
-	       c->generation >= gen_cutoff)
+	       generation(c) >= gen_cutoff)
 		explore_walk_step(revs);
 }
 
@@ -3330,7 +3330,7 @@ static void indegree_walk_step(struct rev_info *revs)
 	if (parse_commit_gently(c, 1) < 0)
 		return;
 
-	explore_to_depth(revs, c->generation);
+	explore_to_depth(revs, generation(c));
 
 	for (p = c->parents; p; p = p->next) {
 		struct commit *parent = p->item;
@@ -3354,7 +3354,7 @@ static void compute_indegrees_to_depth(struct rev_info *revs,
 	struct topo_walk_info *info = revs->topo_walk_info;
 	struct commit *c;
 	while ((c = prio_queue_peek(&info->indegree_queue)) &&
-	       c->generation >= gen_cutoff)
+	       generation(c) >= gen_cutoff)
 		indegree_walk_step(revs);
 }
 
@@ -3414,8 +3414,8 @@ static void init_topo_walk(struct rev_info *revs)
 		test_flag_and_insert(&info->explore_queue, c, TOPO_WALK_EXPLORED);
 		test_flag_and_insert(&info->indegree_queue, c, TOPO_WALK_INDEGREE);
 
-		if (c->generation < info->min_generation)
-			info->min_generation = c->generation;
+		if (generation(c) < info->min_generation)
+			info->min_generation = generation(c);
 
 		*(indegree_slab_at(&info->indegree, c)) = 1;
 
@@ -3473,8 +3473,8 @@ static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
 		if (parse_commit_gently(parent, 1) < 0)
 			continue;
 
-		if (parent->generation < info->min_generation) {
-			info->min_generation = parent->generation;
+		if (generation(parent) < info->min_generation) {
+			info->min_generation = generation(parent);
 			compute_indegrees_to_depth(revs, info->min_generation);
 		}
 
-- 
2.27.0

