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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE1BC433E6
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 11:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CDAC229C6
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 11:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbgL1LRf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 06:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbgL1LRe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 06:17:34 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF10C06179B
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 03:16:18 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 3so9532499wmg.4
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 03:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zbyEcLxXymMRNtykZi/9U3zxzfVEp9oLGbTgro/5XhA=;
        b=qBtO6KDgh5QlNrGiOp7guMu43kChMViziAX2xPB0dP94hJ3o7bUlYBZ67YKglbfCX/
         MCvo4of5bUx4wIqsifJT/NlMURbsyiXD2Q7ieW2oopdb+KrQQmSq6uN1ZIxEwzGE7I7v
         sMaoJReBkJxqygHfZgvKaUspFT8gBoNaNJIGIWJZNvmnbVIiyhYf6E4LsMwHOsQpLETz
         k7od1L5Qaq+QYWdjDhiypeJnEDfxawFnmY/GvibkMaml+f3t+fwTh6StyOZ0PkW528Wv
         1SZtbtlVS11893kFmMA5A6V2ElvAP4kYrMStX5vbaTolxCGh4C84kIyb4bIzObb2SRol
         QDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zbyEcLxXymMRNtykZi/9U3zxzfVEp9oLGbTgro/5XhA=;
        b=BfJ9eZT5Aepd+R7O7OsDP2VrDxwLZL/a9lPmSMMm39BxjtSt1r0UWnQKAJ2HL+usYN
         MwtioRzsgPoJkJMQ1zVrWNtQAZb2lxTKvtCZKOxdckvxkv1ou/Ijxg8fwt/h9UZE74h9
         I2ciJFXwwPS/vTpsIG0ouRDfZLPSnGXL8KXGXE7YAP/zjWZZ/AjH2C6bsiCiyzJlgHx2
         XCHLPITwYOFyYKt+eCNr/FNIjldmukU1xV+ct0zDs4oJnvZz2Nz3eC+3EYhgIq220BF6
         d/yYDzTRYZ/Cld5Z5Ea/1fuWDSP0erSXrMxBj9zrsTEcibTesDI0BWpR2iRZkkRgOvSh
         jyKg==
X-Gm-Message-State: AOAM5326SmZCgjwBH5FkW237Wc+UkhlNd8LkFtgMI3FarJpJUIx4YCjb
        DzCQM59IabS7h/wp2BWebyy44SyAn3c=
X-Google-Smtp-Source: ABdhPJxytqWKLT1Z5JvLbYj2YG9wtf7mJGKTgnFHMuBZhRO9/2xJ0m7nfEj/nbbtbIvwGfJ8dtNrmA==
X-Received: by 2002:a1c:4156:: with SMTP id o83mr20034079wma.178.1609154177103;
        Mon, 28 Dec 2020 03:16:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k10sm52780361wrq.38.2020.12.28.03.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 03:16:16 -0800 (PST)
Message-Id: <26bd6f4910059a0900a9ce48b2d6b668da6e34e7.1609154168.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
References: <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
        <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Dec 2020 11:16:03 +0000
Subject: [PATCH v5 06/11] commit-graph: return 64-bit generation number
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

In a preparatory step for introducing corrected commit dates, let's
return timestamp_t values from commit_graph_generation(), use
timestamp_t for local variables and define GENERATION_NUMBER_INFINITY
as (2 ^ 63 - 1) instead.

We rename GENERATION_NUMBER_MAX to GENERATION_NUMBER_V1_MAX to
represent the largest topological level we can store in the commit data
chunk.

With corrected commit dates implemented, we will have two such *_MAX
variables to denote the largest offset and largest topological level
that can be stored.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-graph.c | 22 +++++++++++-----------
 commit-graph.h |  4 ++--
 commit-reach.c | 36 ++++++++++++++++++------------------
 commit-reach.h |  2 +-
 commit.c       |  4 ++--
 commit.h       |  4 ++--
 revision.c     | 10 +++++-----
 upload-pack.c  |  2 +-
 8 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index c98e8910fe2..1b2a015f92f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -101,7 +101,7 @@ uint32_t commit_graph_position(const struct commit *c)
 	return data ? data->graph_pos : COMMIT_NOT_FROM_GRAPH;
 }
 
-uint32_t commit_graph_generation(const struct commit *c)
+timestamp_t commit_graph_generation(const struct commit *c)
 {
 	struct commit_graph_data *data =
 		commit_graph_data_slab_peek(&commit_graph_data_slab, c);
@@ -146,8 +146,8 @@ static int commit_gen_cmp(const void *va, const void *vb)
 	const struct commit *a = *(const struct commit **)va;
 	const struct commit *b = *(const struct commit **)vb;
 
-	uint32_t generation_a = commit_graph_data_at(a)->generation;
-	uint32_t generation_b = commit_graph_data_at(b)->generation;
+	const timestamp_t generation_a = commit_graph_data_at(a)->generation;
+	const timestamp_t generation_b = commit_graph_data_at(b)->generation;
 	/* lower generation commits first */
 	if (generation_a < generation_b)
 		return -1;
@@ -1366,8 +1366,8 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 			if (all_parents_computed) {
 				pop_commit(&list);
 
-				if (max_level > GENERATION_NUMBER_MAX - 1)
-					max_level = GENERATION_NUMBER_MAX - 1;
+				if (max_level > GENERATION_NUMBER_V1_MAX - 1)
+					max_level = GENERATION_NUMBER_V1_MAX - 1;
 				*topo_level_slab_at(ctx->topo_levels, current) = max_level + 1;
 			}
 		}
@@ -2363,8 +2363,8 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 	for (i = 0; i < g->num_commits; i++) {
 		struct commit *graph_commit, *odb_commit;
 		struct commit_list *graph_parents, *odb_parents;
-		uint32_t max_generation = 0;
-		uint32_t generation;
+		timestamp_t max_generation = 0;
+		timestamp_t generation;
 
 		display_progress(progress, i + 1);
 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
@@ -2428,16 +2428,16 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 			continue;
 
 		/*
-		 * If one of our parents has generation GENERATION_NUMBER_MAX, then
-		 * our generation is also GENERATION_NUMBER_MAX. Decrement to avoid
+		 * If one of our parents has generation GENERATION_NUMBER_V1_MAX, then
+		 * our generation is also GENERATION_NUMBER_V1_MAX. Decrement to avoid
 		 * extra logic in the following condition.
 		 */
-		if (max_generation == GENERATION_NUMBER_MAX)
+		if (max_generation == GENERATION_NUMBER_V1_MAX)
 			max_generation--;
 
 		generation = commit_graph_generation(graph_commit);
 		if (generation != max_generation + 1)
-			graph_report(_("commit-graph generation for commit %s is %u != %u"),
+			graph_report(_("commit-graph generation for commit %s is %"PRItime" != %"PRItime),
 				     oid_to_hex(&cur_oid),
 				     generation,
 				     max_generation + 1);
diff --git a/commit-graph.h b/commit-graph.h
index 00f00745b79..2e9aa7824ee 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -145,12 +145,12 @@ void disable_commit_graph(struct repository *r);
 
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
 #endif
diff --git a/commit-reach.c b/commit-reach.c
index 50175b159e7..9b24b0378d5 100644
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
+	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
 
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
-	uint32_t generation, max_generation = GENERATION_NUMBER_ZERO;
+	timestamp_t generation, max_generation = GENERATION_NUMBER_ZERO;
 
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
+	timestamp_t cutoff = GENERATION_NUMBER_INFINITY;
 	const struct commit_list *p;
 
 	for (p = want; p; p = p->next) {
-		uint32_t generation;
+		timestamp_t generation;
 		struct commit *c = p->item;
 		load_commit_graph_info(the_repository, c);
 		generation = commit_graph_generation(c);
@@ -566,8 +566,8 @@ static int compare_commits_by_gen(const void *_a, const void *_b)
 	const struct commit *a = *(const struct commit * const *)_a;
 	const struct commit *b = *(const struct commit * const *)_b;
 
-	uint32_t generation_a = commit_graph_generation(a);
-	uint32_t generation_b = commit_graph_generation(b);
+	timestamp_t generation_a = commit_graph_generation(a);
+	timestamp_t generation_b = commit_graph_generation(b);
 
 	if (generation_a < generation_b)
 		return -1;
@@ -580,7 +580,7 @@ int can_all_from_reach_with_flag(struct object_array *from,
 				 unsigned int with_flag,
 				 unsigned int assign_flag,
 				 time_t min_commit_date,
-				 uint32_t min_generation)
+				 timestamp_t min_generation)
 {
 	struct commit **list = NULL;
 	int i;
@@ -681,13 +681,13 @@ int can_all_from_reach(struct commit_list *from, struct commit_list *to,
 	time_t min_commit_date = cutoff_by_min_date ? from->item->date : 0;
 	struct commit_list *from_iter = from, *to_iter = to;
 	int result;
-	uint32_t min_generation = GENERATION_NUMBER_INFINITY;
+	timestamp_t min_generation = GENERATION_NUMBER_INFINITY;
 
 	while (from_iter) {
 		add_object_array(&from_iter->item->object, NULL, &from_objs);
 
 		if (!parse_commit(from_iter->item)) {
-			uint32_t generation;
+			timestamp_t generation;
 			if (from_iter->item->date < min_commit_date)
 				min_commit_date = from_iter->item->date;
 
@@ -701,7 +701,7 @@ int can_all_from_reach(struct commit_list *from, struct commit_list *to,
 
 	while (to_iter) {
 		if (!parse_commit(to_iter->item)) {
-			uint32_t generation;
+			timestamp_t generation;
 			if (to_iter->item->date < min_commit_date)
 				min_commit_date = to_iter->item->date;
 
@@ -741,13 +741,13 @@ struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
 	struct commit_list *found_commits = NULL;
 	struct commit **to_last = to + nr_to;
 	struct commit **from_last = from + nr_from;
-	uint32_t min_generation = GENERATION_NUMBER_INFINITY;
+	timestamp_t min_generation = GENERATION_NUMBER_INFINITY;
 	int num_to_find = 0;
 
 	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
 
 	for (item = to; item < to_last; item++) {
-		uint32_t generation;
+		timestamp_t generation;
 		struct commit *c = *item;
 
 		parse_commit(c);
diff --git a/commit-reach.h b/commit-reach.h
index b49ad71a317..148b56fea50 100644
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
 
diff --git a/commit.c b/commit.c
index fe1fa3dc41f..17abf92a2d2 100644
--- a/commit.c
+++ b/commit.c
@@ -731,8 +731,8 @@ int compare_commits_by_author_date(const void *a_, const void *b_,
 int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void *unused)
 {
 	const struct commit *a = a_, *b = b_;
-	const uint32_t generation_a = commit_graph_generation(a),
-		       generation_b = commit_graph_generation(b);
+	const timestamp_t generation_a = commit_graph_generation(a),
+			  generation_b = commit_graph_generation(b);
 
 	/* newer commits first */
 	if (generation_a < generation_b)
diff --git a/commit.h b/commit.h
index 5467786c7be..33c66b2177c 100644
--- a/commit.h
+++ b/commit.h
@@ -11,8 +11,8 @@
 #include "commit-slab.h"
 
 #define COMMIT_NOT_FROM_GRAPH 0xFFFFFFFF
-#define GENERATION_NUMBER_INFINITY 0xFFFFFFFF
-#define GENERATION_NUMBER_MAX 0x3FFFFFFF
+#define GENERATION_NUMBER_INFINITY ((1ULL << 63) - 1)
+#define GENERATION_NUMBER_V1_MAX 0x3FFFFFFF
 #define GENERATION_NUMBER_ZERO 0
 
 struct commit_list {
diff --git a/revision.c b/revision.c
index de8e45f462f..d55c2e4d566 100644
--- a/revision.c
+++ b/revision.c
@@ -3300,7 +3300,7 @@ define_commit_slab(indegree_slab, int);
 define_commit_slab(author_date_slab, timestamp_t);
 
 struct topo_walk_info {
-	uint32_t min_generation;
+	timestamp_t min_generation;
 	struct prio_queue explore_queue;
 	struct prio_queue indegree_queue;
 	struct prio_queue topo_queue;
@@ -3346,7 +3346,7 @@ static void explore_walk_step(struct rev_info *revs)
 }
 
 static void explore_to_depth(struct rev_info *revs,
-			     uint32_t gen_cutoff)
+			     timestamp_t gen_cutoff)
 {
 	struct topo_walk_info *info = revs->topo_walk_info;
 	struct commit *c;
@@ -3389,7 +3389,7 @@ static void indegree_walk_step(struct rev_info *revs)
 }
 
 static void compute_indegrees_to_depth(struct rev_info *revs,
-				       uint32_t gen_cutoff)
+				       timestamp_t gen_cutoff)
 {
 	struct topo_walk_info *info = revs->topo_walk_info;
 	struct commit *c;
@@ -3447,7 +3447,7 @@ static void init_topo_walk(struct rev_info *revs)
 	info->min_generation = GENERATION_NUMBER_INFINITY;
 	for (list = revs->commits; list; list = list->next) {
 		struct commit *c = list->item;
-		uint32_t generation;
+		timestamp_t generation;
 
 		if (repo_parse_commit_gently(revs->repo, c, 1))
 			continue;
@@ -3508,7 +3508,7 @@ static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
 	for (p = commit->parents; p; p = p->next) {
 		struct commit *parent = p->item;
 		int *pi;
-		uint32_t generation;
+		timestamp_t generation;
 
 		if (parent->object.flags & UNINTERESTING)
 			continue;
diff --git a/upload-pack.c b/upload-pack.c
index 3b66bf92ba8..b87607e0dd4 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -500,7 +500,7 @@ static int got_oid(struct upload_pack_data *data,
 
 static int ok_to_give_up(struct upload_pack_data *data)
 {
-	uint32_t min_generation = GENERATION_NUMBER_ZERO;
+	timestamp_t min_generation = GENERATION_NUMBER_ZERO;
 
 	if (!data->have_obj.nr)
 		return 0;
-- 
gitgitgadget

