Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F10C433EB
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 09:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5820120786
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 09:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFUkHBpD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgG1JOF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbgG1JOE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 05:14:04 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F44C061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 02:14:03 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id f14so4036840ejb.2
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 02:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lXy8OcRedLF4T4FMt2eLZyM4PAHRZUHBX9qp/tT3IaY=;
        b=LFUkHBpDyQR8EM1R9j2Eim9gKyRoCekBPzW51jF2LUXwEXv/JDjuvz01TjkOdiRXM1
         xZg4Id/n3g6jco1ccEMJyN621M8aAuzi7IsTBOE3NgDK3NXjJcfGWz7rE7XAWVKKzDAz
         Yao8yst6ZnSRgQffRe45qkhHOj7GBZOaaPrhjezZ+rlF15frU5SCSYYp6jMJ1PHTD5M7
         sytYY9MKDf0HDKMs1KiRvrCFOjzaTv3NDV1+TjR4DhtpuTJaMf6ooq7gOtvXnUnZRg6X
         Lw3ktAL5ecGWtFb4lqN7Hzn9pswn4G2ysMLNa4Un8YpKDm7/cziqkCdIuPx2+M5DRGUp
         yKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lXy8OcRedLF4T4FMt2eLZyM4PAHRZUHBX9qp/tT3IaY=;
        b=lqb1B9e3TOjAQaz15uSCh7FEdJ+gbQpSH66+21BlEykUbM8NiOPDDqR3JceMeUnTYu
         bgGfdb5ynI8FpBJWRxiaym4ef6xtsYunbKoom4U0bB95Gjid6fUBF01wvBueemRXVhCx
         OR4zmmfpLlpiYk7SL/yi0dInGM23UkQ/RlGYsm2IF+7M2ko7weyOM0BwR/xLFVj0YRCw
         cUfV27fYfkx4tyBJZVZLCuDCGzN+9VAUWtR5L3dq7WeuAZJoC7kGsvS+GuEKCX+GRSDm
         siVEP0LuNndAddRnhPrRfJmYsmF7k3wr+z23fabjoT3ThLmIbUaiD5FA/iUPZ2Ueg4II
         hgMQ==
X-Gm-Message-State: AOAM532g0kgwrnOs4/pMGYpyXaXbi2leTwuJ9z8Co+isUY/xR1UujtmR
        Nv9EalFkvw87cd9Z616dzd6NBd6o
X-Google-Smtp-Source: ABdhPJzdVPPk3hkHauLzN5UkhL8hcwNoGNLEDyGWWR1h+L6XnG94Sk6XAttF6qJ8dr1iy/YAeXk7nQ==
X-Received: by 2002:a17:906:4e14:: with SMTP id z20mr19443717eju.541.1595927641852;
        Tue, 28 Jul 2020 02:14:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id dh16sm9221192edb.3.2020.07.28.02.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 02:13:58 -0700 (PDT)
Message-Id: <647290d0368e385227614dd1822aa9083b0dba5e.1595927632.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.git.1595927632.gitgitgadget@gmail.com>
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Jul 2020 09:13:51 +0000
Subject: [PATCH 6/6] commit-graph: implement corrected commit date offset
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhishek Kumar <abhishekkumar8222@gmail.com>

With preparations done, let's implement corrected commit date offset.
We add a new commit-slab to store topological levels while writing
commit graph and upgrade number of struct commit_graph_data to 64-bits.

We have to touch many files, upgrading generation number from uint32_t
to timestamp_t.

We drop 'detect incorrect generation number' from t5318-commit-graph.sh,
which tests if verify can detect if a commit graph have
GENERATION_NUMBER_ZERO for a commit, followed by a non-zero generation.
With corrected commit dates, GENERATION_NUMBER_ZERO is possible only if
one of dates is Unix epoch zero.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 blame.c                 |   2 +-
 commit-graph.c          | 109 ++++++++++++++++++++++------------------
 commit-graph.h          |   4 +-
 commit-reach.c          |  32 ++++++------
 commit-reach.h          |   2 +-
 commit.h                |   3 ++
 revision.c              |  14 +++---
 t/t5318-commit-graph.sh |   2 +-
 upload-pack.c           |   2 +-
 9 files changed, 93 insertions(+), 77 deletions(-)

diff --git a/blame.c b/blame.c
index 82fa16d658..48aa632461 100644
--- a/blame.c
+++ b/blame.c
@@ -1272,7 +1272,7 @@ static int maybe_changed_path(struct repository *r,
 	if (!bd)
 		return 1;
 
-	if (commit_graph_generation(origin->commit) == GENERATION_NUMBER_INFINITY)
+	if (commit_graph_generation(origin->commit) == GENERATION_NUMBER_V2_INFINITY)
 		return 1;
 
 	filter = get_bloom_filter(r, origin->commit, 0);
diff --git a/commit-graph.c b/commit-graph.c
index ab714f4a76..9647d9f0df 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -65,6 +65,8 @@ void git_test_write_commit_graph_or_die(void)
 /* Remember to update object flag allocation in object.h */
 #define REACHABLE       (1u<<15)
 
+define_commit_slab(topo_level_slab, uint32_t);
+
 /* Keep track of the order in which commits are added to our list. */
 define_commit_slab(commit_pos, int);
 static struct commit_pos commit_pos = COMMIT_SLAB_INIT(1, commit_pos);
@@ -100,15 +102,15 @@ uint32_t commit_graph_position(const struct commit *c)
 	return data ? data->graph_pos : COMMIT_NOT_FROM_GRAPH;
 }
 
-uint32_t commit_graph_generation(const struct commit *c)
+timestamp_t commit_graph_generation(const struct commit *c)
 {
 	struct commit_graph_data *data =
 		commit_graph_data_slab_peek(&commit_graph_data_slab, c);
 
 	if (!data)
-		return GENERATION_NUMBER_INFINITY;
+		return GENERATION_NUMBER_V2_INFINITY;
 	else if (data->graph_pos == COMMIT_NOT_FROM_GRAPH)
-		return GENERATION_NUMBER_INFINITY;
+		return GENERATION_NUMBER_V2_INFINITY;
 
 	return data->generation;
 }
@@ -116,8 +118,8 @@ uint32_t commit_graph_generation(const struct commit *c)
 int compare_commits_by_gen(const void *_a, const void *_b)
 {
 	const struct commit *a = _a, *b = _b;
-	const uint32_t generation_a = commit_graph_generation(a);
-	const uint32_t generation_b = commit_graph_generation(b);
+	const timestamp_t generation_a = commit_graph_generation(a);
+	const timestamp_t generation_b = commit_graph_generation(b);
 
 	/* older commits first */
 	if (generation_a < generation_b)
@@ -160,8 +162,8 @@ static int commit_gen_cmp(const void *va, const void *vb)
 	const struct commit *a = *(const struct commit **)va;
 	const struct commit *b = *(const struct commit **)vb;
 
-	uint32_t generation_a = commit_graph_data_at(a)->generation;
-	uint32_t generation_b = commit_graph_data_at(b)->generation;
+	timestamp_t generation_a = commit_graph_data_at(a)->generation;
+	timestamp_t generation_b = commit_graph_data_at(b)->generation;
 
 	/* lower generation commits first */
 	if (generation_a < generation_b)
@@ -169,11 +171,6 @@ static int commit_gen_cmp(const void *va, const void *vb)
 	else if (generation_a > generation_b)
 		return 1;
 
-	/* use date as a heuristic when generations are equal */
-	if (a->date < b->date)
-		return -1;
-	else if (a->date > b->date)
-		return 1;
 	return 0;
 }
 
@@ -777,8 +774,13 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 	item->date = (timestamp_t)((date_high << 32) | date_low);
 
 	if (g->chunk_generation_data)
-		graph_data->generation = get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
+	{
+		/* Read corrected commit date offset from GDAT */
+		graph_data->generation = item->date +
+			(timestamp_t) get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
+	}
 	else
+		/* Read topological level from CDAT */
 		graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
 }
 
@@ -950,6 +952,7 @@ struct write_commit_graph_context {
 	struct progress *progress;
 	int progress_done;
 	uint64_t progress_cnt;
+	struct topo_level_slab *topo_levels;
 
 	char *base_graph_name;
 	int num_commit_graphs_before;
@@ -1102,7 +1105,7 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 		else
 			packedDate[0] = 0;
 
-		packedDate[0] |= htonl(commit_graph_data_at(*list)->generation << 2);
+		packedDate[0] |= htonl(*topo_level_slab_at(ctx->topo_levels, *list) << 2);
 
 		packedDate[1] = htonl((*list)->date);
 		hashwrite(f, packedDate, 8);
@@ -1117,8 +1120,13 @@ static void write_graph_chunk_generation_data(struct hashfile *f,
 	struct commit **list = ctx->commits.list;
 	int count;
 	for (count = 0; count < ctx->commits.nr; count++, list++) {
+		timestamp_t offset = commit_graph_data_at(*list)->generation - (*list)->date;
 		display_progress(ctx->progress, ++ctx->progress_cnt);
-		hashwrite_be32(f, commit_graph_data_at(*list)->generation);
+
+		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX)
+			offset = GENERATION_NUMBER_V2_OFFSET_MAX;
+
+		hashwrite_be32(f, offset);
 	}
 }
 
@@ -1316,7 +1324,7 @@ static void close_reachable(struct write_commit_graph_context *ctx)
 	stop_progress(&ctx->progress);
 }
 
-static void compute_generation_numbers(struct write_commit_graph_context *ctx)
+static void compute_corrected_commit_date_offsets(struct write_commit_graph_context *ctx)
 {
 	int i;
 	struct commit_list *list = NULL;
@@ -1326,11 +1334,11 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 					_("Computing commit graph generation numbers"),
 					ctx->commits.nr);
 	for (i = 0; i < ctx->commits.nr; i++) {
-		uint32_t generation = commit_graph_data_at(ctx->commits.list[i])->generation;
+		uint32_t topo_level = *topo_level_slab_at(ctx->topo_levels, ctx->commits.list[i]);
 
 		display_progress(ctx->progress, i + 1);
-		if (generation != GENERATION_NUMBER_INFINITY &&
-		    generation != GENERATION_NUMBER_ZERO)
+		if (topo_level != GENERATION_NUMBER_INFINITY &&
+		    topo_level != GENERATION_NUMBER_ZERO)
 			continue;
 
 		commit_list_insert(ctx->commits.list[i], &list);
@@ -1338,29 +1346,38 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 			struct commit *current = list->item;
 			struct commit_list *parent;
 			int all_parents_computed = 1;
-			uint32_t max_generation = 0;
+			uint32_t max_level = 0;
+			timestamp_t max_corrected_commit_date = current->date;
 
 			for (parent = current->parents; parent; parent = parent->next) {
-				generation = commit_graph_data_at(parent->item)->generation;
+				topo_level = *topo_level_slab_at(ctx->topo_levels, parent->item);
 
-				if (generation == GENERATION_NUMBER_INFINITY ||
-				    generation == GENERATION_NUMBER_ZERO) {
+				if (topo_level == GENERATION_NUMBER_INFINITY ||
+				    topo_level == GENERATION_NUMBER_ZERO) {
 					all_parents_computed = 0;
 					commit_list_insert(parent->item, &list);
 					break;
-				} else if (generation > max_generation) {
-					max_generation = generation;
+				} else {
+					struct commit_graph_data *data = commit_graph_data_at(parent->item);
+
+					if (topo_level > max_level)
+						max_level = topo_level;
+
+					if (data->generation > max_corrected_commit_date)
+						max_corrected_commit_date = data->generation;
 				}
 			}
 
 			if (all_parents_computed) {
 				struct commit_graph_data *data = commit_graph_data_at(current);
 
-				data->generation = max_generation + 1;
-				pop_commit(&list);
+				if (max_level > GENERATION_NUMBER_MAX - 1)
+					max_level = GENERATION_NUMBER_MAX - 1;
+
+				*topo_level_slab_at(ctx->topo_levels, current) = max_level + 1;
+				data->generation = max_corrected_commit_date + 1;
 
-				if (data->generation > GENERATION_NUMBER_MAX)
-					data->generation = GENERATION_NUMBER_MAX;
+				pop_commit(&list);
 			}
 		}
 	}
@@ -2085,6 +2102,7 @@ int write_commit_graph(struct object_directory *odb,
 	uint32_t i, count_distinct = 0;
 	int res = 0;
 	int replace = 0;
+	struct topo_level_slab topo_levels;
 
 	if (!commit_graph_compatible(the_repository))
 		return 0;
@@ -2099,6 +2117,9 @@ int write_commit_graph(struct object_directory *odb,
 	ctx->changed_paths = flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS ? 1 : 0;
 	ctx->total_bloom_filter_data_size = 0;
 
+	init_topo_level_slab(&topo_levels);
+	ctx->topo_levels = &topo_levels;
+
 	if (ctx->split) {
 		struct commit_graph *g;
 		prepare_commit_graph(ctx->r);
@@ -2197,7 +2218,7 @@ int write_commit_graph(struct object_directory *odb,
 	} else
 		ctx->num_commit_graphs_after = 1;
 
-	compute_generation_numbers(ctx);
+	compute_corrected_commit_date_offsets(ctx);
 
 	if (ctx->changed_paths)
 		compute_bloom_filters(ctx);
@@ -2325,8 +2346,8 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 	for (i = 0; i < g->num_commits; i++) {
 		struct commit *graph_commit, *odb_commit;
 		struct commit_list *graph_parents, *odb_parents;
-		uint32_t max_generation = 0;
-		uint32_t generation;
+		timestamp_t max_parent_corrected_commit_date = 0;
+		timestamp_t corrected_commit_date;
 
 		display_progress(progress, i + 1);
 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
@@ -2365,9 +2386,9 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 					     oid_to_hex(&graph_parents->item->object.oid),
 					     oid_to_hex(&odb_parents->item->object.oid));
 
-			generation = commit_graph_generation(graph_parents->item);
-			if (generation > max_generation)
-				max_generation = generation;
+			corrected_commit_date = commit_graph_generation(graph_parents->item);
+			if (corrected_commit_date > max_parent_corrected_commit_date)
+				max_parent_corrected_commit_date = corrected_commit_date;
 
 			graph_parents = graph_parents->next;
 			odb_parents = odb_parents->next;
@@ -2389,20 +2410,12 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 		if (generation_zero == GENERATION_ZERO_EXISTS)
 			continue;
 
-		/*
-		 * If one of our parents has generation GENERATION_NUMBER_MAX, then
-		 * our generation is also GENERATION_NUMBER_MAX. Decrement to avoid
-		 * extra logic in the following condition.
-		 */
-		if (max_generation == GENERATION_NUMBER_MAX)
-			max_generation--;
-
-		generation = commit_graph_generation(graph_commit);
-		if (generation != max_generation + 1)
-			graph_report(_("commit-graph generation for commit %s is %u != %u"),
+		corrected_commit_date = commit_graph_generation(graph_commit);
+		if (corrected_commit_date < max_parent_corrected_commit_date + 1)
+			graph_report(_("commit-graph generation for commit %s is %"PRItime" < %"PRItime),
 				     oid_to_hex(&cur_oid),
-				     generation,
-				     max_generation + 1);
+				     corrected_commit_date,
+				     max_parent_corrected_commit_date + 1);
 
 		if (graph_commit->date != odb_commit->date)
 			graph_report(_("commit date for commit %s in commit-graph is %"PRItime" != %"PRItime),
diff --git a/commit-graph.h b/commit-graph.h
index e3d4ba96f4..20c5848587 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -138,13 +138,13 @@ void disable_commit_graph(struct repository *r);
 
 struct commit_graph_data {
 	uint32_t graph_pos;
-	uint32_t generation;
+	timestamp_t generation;
 };
 
 /*
  * Commits should be parsed before accessing generation, graph positions.
  */
-uint32_t commit_graph_generation(const struct commit *);
+timestamp_t commit_graph_generation(const struct commit *);
 uint32_t commit_graph_position(const struct commit *);
 
 int compare_commits_by_gen(const void *_a, const void *_b);
diff --git a/commit-reach.c b/commit-reach.c
index c83cc291e7..2ce9867ff3 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -32,12 +32,12 @@ static int queue_has_nonstale(struct prio_queue *queue)
 static struct commit_list *paint_down_to_common(struct repository *r,
 						struct commit *one, int n,
 						struct commit **twos,
-						int min_generation)
+						timestamp_t min_generation)
 {
 	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
 	struct commit_list *result = NULL;
 	int i;
-	uint32_t last_gen = GENERATION_NUMBER_INFINITY;
+	timestamp_t last_gen = GENERATION_NUMBER_V2_INFINITY;
 
 	if (!min_generation)
 		queue.compare = compare_commits_by_commit_date;
@@ -58,10 +58,10 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 		struct commit *commit = prio_queue_get(&queue);
 		struct commit_list *parents;
 		int flags;
-		uint32_t generation = commit_graph_generation(commit);
+		timestamp_t generation = commit_graph_generation(commit);
 
 		if (min_generation && generation > last_gen)
-			BUG("bad generation skip %8x > %8x at %s",
+			BUG("bad generation skip %"PRItime" > %"PRItime" at %s",
 			    generation, last_gen,
 			    oid_to_hex(&commit->object.oid));
 		last_gen = generation;
@@ -177,12 +177,12 @@ static int remove_redundant(struct repository *r, struct commit **array, int cnt
 		repo_parse_commit(r, array[i]);
 	for (i = 0; i < cnt; i++) {
 		struct commit_list *common;
-		uint32_t min_generation = commit_graph_generation(array[i]);
+		timestamp_t min_generation = commit_graph_generation(array[i]);
 
 		if (redundant[i])
 			continue;
 		for (j = filled = 0; j < cnt; j++) {
-			uint32_t curr_generation;
+			timestamp_t curr_generation;
 			if (i == j || redundant[j])
 				continue;
 			filled_index[filled] = j;
@@ -321,7 +321,7 @@ int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
 {
 	struct commit_list *bases;
 	int ret = 0, i;
-	uint32_t generation, min_generation = GENERATION_NUMBER_INFINITY;
+	timestamp_t generation, min_generation = GENERATION_NUMBER_V2_INFINITY;
 
 	if (repo_parse_commit(r, commit))
 		return ret;
@@ -470,7 +470,7 @@ static int in_commit_list(const struct commit_list *want, struct commit *c)
 static enum contains_result contains_test(struct commit *candidate,
 					  const struct commit_list *want,
 					  struct contains_cache *cache,
-					  uint32_t cutoff)
+					  timestamp_t cutoff)
 {
 	enum contains_result *cached = contains_cache_at(cache, candidate);
 
@@ -506,11 +506,11 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 {
 	struct contains_stack contains_stack = { 0, 0, NULL };
 	enum contains_result result;
-	uint32_t cutoff = GENERATION_NUMBER_INFINITY;
+	timestamp_t cutoff = GENERATION_NUMBER_V2_INFINITY;
 	const struct commit_list *p;
 
 	for (p = want; p; p = p->next) {
-		uint32_t generation;
+		timestamp_t generation;
 		struct commit *c = p->item;
 		load_commit_graph_info(the_repository, c);
 		generation = commit_graph_generation(c);
@@ -565,7 +565,7 @@ int can_all_from_reach_with_flag(struct object_array *from,
 				 unsigned int with_flag,
 				 unsigned int assign_flag,
 				 time_t min_commit_date,
-				 uint32_t min_generation)
+				 timestamp_t min_generation)
 {
 	struct commit **list = NULL;
 	int i;
@@ -666,13 +666,13 @@ int can_all_from_reach(struct commit_list *from, struct commit_list *to,
 	time_t min_commit_date = cutoff_by_min_date ? from->item->date : 0;
 	struct commit_list *from_iter = from, *to_iter = to;
 	int result;
-	uint32_t min_generation = GENERATION_NUMBER_INFINITY;
+	timestamp_t min_generation = GENERATION_NUMBER_V2_INFINITY;
 
 	while (from_iter) {
 		add_object_array(&from_iter->item->object, NULL, &from_objs);
 
 		if (!parse_commit(from_iter->item)) {
-			uint32_t generation;
+			timestamp_t generation;
 			if (from_iter->item->date < min_commit_date)
 				min_commit_date = from_iter->item->date;
 
@@ -686,7 +686,7 @@ int can_all_from_reach(struct commit_list *from, struct commit_list *to,
 
 	while (to_iter) {
 		if (!parse_commit(to_iter->item)) {
-			uint32_t generation;
+			timestamp_t generation;
 			if (to_iter->item->date < min_commit_date)
 				min_commit_date = to_iter->item->date;
 
@@ -726,13 +726,13 @@ struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
 	struct commit_list *found_commits = NULL;
 	struct commit **to_last = to + nr_to;
 	struct commit **from_last = from + nr_from;
-	uint32_t min_generation = GENERATION_NUMBER_INFINITY;
+	timestamp_t min_generation = GENERATION_NUMBER_V2_INFINITY;
 	int num_to_find = 0;
 
 	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
 
 	for (item = to; item < to_last; item++) {
-		uint32_t generation;
+		timestamp_t generation;
 		struct commit *c = *item;
 
 		parse_commit(c);
diff --git a/commit-reach.h b/commit-reach.h
index b49ad71a31..148b56fea5 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -87,7 +87,7 @@ int can_all_from_reach_with_flag(struct object_array *from,
 				 unsigned int with_flag,
 				 unsigned int assign_flag,
 				 time_t min_commit_date,
-				 uint32_t min_generation);
+				 timestamp_t min_generation);
 int can_all_from_reach(struct commit_list *from, struct commit_list *to,
 		       int commit_date_cutoff);
 
diff --git a/commit.h b/commit.h
index e901538909..dd17a81672 100644
--- a/commit.h
+++ b/commit.h
@@ -15,6 +15,9 @@
 #define GENERATION_NUMBER_MAX 0x3FFFFFFF
 #define GENERATION_NUMBER_ZERO 0
 
+#define GENERATION_NUMBER_V2_INFINITY ((1ULL << 63) - 1)
+#define GENERATION_NUMBER_V2_OFFSET_MAX 0xFFFFFFFF
+
 struct commit_list {
 	struct commit *item;
 	struct commit_list *next;
diff --git a/revision.c b/revision.c
index 23287d26c3..b978e79601 100644
--- a/revision.c
+++ b/revision.c
@@ -725,7 +725,7 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 	if (!revs->repo->objects->commit_graph)
 		return -1;
 
-	if (commit_graph_generation(commit) == GENERATION_NUMBER_INFINITY)
+	if (commit_graph_generation(commit) == GENERATION_NUMBER_V2_INFINITY)
 		return -1;
 
 	filter = get_bloom_filter(revs->repo, commit, 0);
@@ -3270,7 +3270,7 @@ define_commit_slab(indegree_slab, int);
 define_commit_slab(author_date_slab, timestamp_t);
 
 struct topo_walk_info {
-	uint32_t min_generation;
+	timestamp_t min_generation;
 	struct prio_queue explore_queue;
 	struct prio_queue indegree_queue;
 	struct prio_queue topo_queue;
@@ -3316,7 +3316,7 @@ static void explore_walk_step(struct rev_info *revs)
 }
 
 static void explore_to_depth(struct rev_info *revs,
-			     uint32_t gen_cutoff)
+			     timestamp_t gen_cutoff)
 {
 	struct topo_walk_info *info = revs->topo_walk_info;
 	struct commit *c;
@@ -3359,7 +3359,7 @@ static void indegree_walk_step(struct rev_info *revs)
 }
 
 static void compute_indegrees_to_depth(struct rev_info *revs,
-				       uint32_t gen_cutoff)
+				       timestamp_t gen_cutoff)
 {
 	struct topo_walk_info *info = revs->topo_walk_info;
 	struct commit *c;
@@ -3414,10 +3414,10 @@ static void init_topo_walk(struct rev_info *revs)
 	info->explore_queue.compare = compare_commits_by_gen_then_commit_date;
 	info->indegree_queue.compare = compare_commits_by_gen_then_commit_date;
 
-	info->min_generation = GENERATION_NUMBER_INFINITY;
+	info->min_generation = GENERATION_NUMBER_V2_INFINITY;
 	for (list = revs->commits; list; list = list->next) {
 		struct commit *c = list->item;
-		uint32_t generation;
+		timestamp_t generation;
 
 		if (parse_commit_gently(c, 1))
 			continue;
@@ -3478,7 +3478,7 @@ static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
 	for (p = commit->parents; p; p = p->next) {
 		struct commit *parent = p->item;
 		int *pi;
-		uint32_t generation;
+		timestamp_t generation;
 
 		if (parent->object.flags & UNINTERESTING)
 			continue;
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 3ec5248d70..43801f07a5 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -596,7 +596,7 @@ test_expect_success 'detect incorrect generation number' '
 		"generation for commit"
 '
 
-test_expect_success 'detect incorrect generation number' '
+test_expect_failure 'detect incorrect generation number' '
 	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_GENERATION "\00" \
 		"non-zero generation number"
 '
diff --git a/upload-pack.c b/upload-pack.c
index 951a2b23aa..db2332e687 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -489,7 +489,7 @@ static int got_oid(struct upload_pack_data *data,
 
 static int ok_to_give_up(struct upload_pack_data *data)
 {
-	uint32_t min_generation = GENERATION_NUMBER_ZERO;
+	timestamp_t min_generation = GENERATION_NUMBER_ZERO;
 
 	if (!data->have_obj.nr)
 		return 0;
-- 
gitgitgadget
