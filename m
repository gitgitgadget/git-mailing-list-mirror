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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C99DC433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 07:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1DD564E31
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 07:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhBAHA0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 02:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhBAHAM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 02:00:12 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF77C061786
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 22:58:56 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id p15so15280385wrq.8
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 22:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=R4qr6SbmnBm43Y/YrJpB+Jon+KbO/NPJ3MEdVUb+AD4=;
        b=ehBp+sEzydggjD6Ryg8m9z064KOAVVL8aG5Gopva7BhtSbRo3rsSXTzGj6uE+kayxo
         16IoxmEmWZ9gc/V2Sjx3rVImrzvuYBL0Gp+0+Jyu3en0m53kh/siFHedHcvdaiBnR9Tt
         x58Ho4/prlRty4nVbw4CEYeGxl4FkZLVzQBwpnyQ0ajTWsah94czuNGCyFYGmwLRTDHu
         qZsj2vRmZOH0o7PpvmVYiUDz0KanBUNR7mMt+2zUmBKEFA4tqXeipuM3wInO+YKmoZD0
         ksxiUGJs8rbCw1+zlCHbN2IO1xBONhpWJTn6O/e/jZHnde5K6lhamEEm3701+UUIuCFI
         97yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=R4qr6SbmnBm43Y/YrJpB+Jon+KbO/NPJ3MEdVUb+AD4=;
        b=hZ4ZM6TYidNjQvKE/62ab0mjCrvbcTJSPUYjOUt1/y5+vu01Abc8UOTpOssEN5oMGB
         akRajEAT072ylbtnePRMM97ab6PCOQQXqtEFkfvbyfFIFCTYMUYRGlihJ7nOQZ9bnB9L
         JsV6sZQW5jn/LeuD03ENRp2bk/wJhqy7NDcu9ZnQ/2a2mWh9zCRb/OjpPW5Zn+0meerN
         SDpu78BZq05/zYyiCMBu5T/Pv6FUw9dgwXElidJIhbWy5DPHKnphTDABxgCiCcZYwOwm
         uvvKV6aATMXilmVxEaD4JgCOwvFiyHAjAnCr3ZCvG5DN8RkMyrGXjQdlGwWgxkOKNuA2
         tPng==
X-Gm-Message-State: AOAM530GEcqzoxEufxVd/VMu6i7nyjSVuNkw9VXdithfs1JgUMxtfMh7
        vw10YkbeTUZJwS3gZzsFFXBwiSG/uFQ=
X-Google-Smtp-Source: ABdhPJyFph9aFXAv3lW406/reOT/7fW04UO8tb0DrH9uMzecBnYiq2/4BcigVPwZphdeQ6/euPBiNg==
X-Received: by 2002:adf:cd10:: with SMTP id w16mr16395910wrm.90.1612162735383;
        Sun, 31 Jan 2021 22:58:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x25sm20010092wmk.20.2021.01.31.22.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 22:58:54 -0800 (PST)
Message-Id: <ea32cba16ef8533117d583aea46cd5a254ef4e24.1612162726.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v7.git.1612162726.gitgitgadget@gmail.com>
References: <pull.676.v6.git.1610820679.gitgitgadget@gmail.com>
        <pull.676.v7.git.1612162726.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 06:58:40 +0000
Subject: [PATCH v7 06/11] commit-graph: return 64-bit generation number
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
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
index 2f344cce151..8f17815021d 100644
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
@@ -150,8 +150,8 @@ static int commit_gen_cmp(const void *va, const void *vb)
 	const struct commit *a = *(const struct commit **)va;
 	const struct commit *b = *(const struct commit **)vb;
 
-	uint32_t generation_a = commit_graph_data_at(a)->generation;
-	uint32_t generation_b = commit_graph_data_at(b)->generation;
+	const timestamp_t generation_a = commit_graph_data_at(a)->generation;
+	const timestamp_t generation_b = commit_graph_data_at(b)->generation;
 	/* lower generation commits first */
 	if (generation_a < generation_b)
 		return -1;
@@ -1370,8 +1370,8 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 			if (all_parents_computed) {
 				pop_commit(&list);
 
-				if (max_level > GENERATION_NUMBER_MAX - 1)
-					max_level = GENERATION_NUMBER_MAX - 1;
+				if (max_level > GENERATION_NUMBER_V1_MAX - 1)
+					max_level = GENERATION_NUMBER_V1_MAX - 1;
 				*topo_level_slab_at(ctx->topo_levels, current) = max_level + 1;
 			}
 		}
@@ -2367,8 +2367,8 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 	for (i = 0; i < g->num_commits; i++) {
 		struct commit *graph_commit, *odb_commit;
 		struct commit_list *graph_parents, *odb_parents;
-		uint32_t max_generation = 0;
-		uint32_t generation;
+		timestamp_t max_generation = 0;
+		timestamp_t generation;
 
 		display_progress(progress, i + 1);
 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
@@ -2432,16 +2432,16 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
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
index bab8d5ab07c..4c717329ee0 100644
--- a/commit.c
+++ b/commit.c
@@ -753,8 +753,8 @@ int compare_commits_by_author_date(const void *a_, const void *b_,
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
index f4e7b0158e2..742d96c41e8 100644
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
index 5474001331a..a54d2bd28df 100644
--- a/revision.c
+++ b/revision.c
@@ -3302,7 +3302,7 @@ define_commit_slab(indegree_slab, int);
 define_commit_slab(author_date_slab, timestamp_t);
 
 struct topo_walk_info {
-	uint32_t min_generation;
+	timestamp_t min_generation;
 	struct prio_queue explore_queue;
 	struct prio_queue indegree_queue;
 	struct prio_queue topo_queue;
@@ -3370,7 +3370,7 @@ static void explore_walk_step(struct rev_info *revs)
 }
 
 static void explore_to_depth(struct rev_info *revs,
-			     uint32_t gen_cutoff)
+			     timestamp_t gen_cutoff)
 {
 	struct topo_walk_info *info = revs->topo_walk_info;
 	struct commit *c;
@@ -3415,7 +3415,7 @@ static void indegree_walk_step(struct rev_info *revs)
 }
 
 static void compute_indegrees_to_depth(struct rev_info *revs,
-				       uint32_t gen_cutoff)
+				       timestamp_t gen_cutoff)
 {
 	struct topo_walk_info *info = revs->topo_walk_info;
 	struct commit *c;
@@ -3473,7 +3473,7 @@ static void init_topo_walk(struct rev_info *revs)
 	info->min_generation = GENERATION_NUMBER_INFINITY;
 	for (list = revs->commits; list; list = list->next) {
 		struct commit *c = list->item;
-		uint32_t generation;
+		timestamp_t generation;
 
 		if (repo_parse_commit_gently(revs->repo, c, 1))
 			continue;
@@ -3541,7 +3541,7 @@ static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
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

