Return-Path: <SRS0=dguO=BT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFB4C433E0
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 02:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1104206DF
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 02:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ur35OWu4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgHICyF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 22:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgHICx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 22:53:57 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FED5C061A2A
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 19:53:57 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l2so5046671wrc.7
        for <git@vger.kernel.org>; Sat, 08 Aug 2020 19:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4ArW47UXhDWLACISWKffd9HxQQpBFINq7O/wlB4NeZ4=;
        b=ur35OWu4T4jqXyfZUJhi97XnRr+u//Y41J5a+Gfe61w6iHgii9UiQQk2+4UyWWaEfG
         oSLHt7xdgl+/8mXjKYCeR9rO+gj7KXH8IGi+LQHQLeOOYt51wohgyrnWmM4mLV4z4WG4
         th9/1jtV5Zg1AyfRFG2x8dTGIKvWa/klxORA0wMTDSsKlNk/lR5hGmdcf2QEsTX3NPZi
         L9SvJ9+24PSh+JBUVclwt9oSrjxD/g/FbcvLmrsYzMiVIa5AvLlkOM8Iv7n5RfMiUCMq
         XVjbHbTPA08aVWVTUYzyW1z7bTnEpiqzBMLTDPj6zogBpm3j7cZaXDvkwj92xyayVgCf
         FjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4ArW47UXhDWLACISWKffd9HxQQpBFINq7O/wlB4NeZ4=;
        b=LOWLMbW9U+tl4YMbJQRzsKmbLHFYxZKQz8SnmFISdETNGxv9Vg9RD7URDAm5LnRWW1
         PJR1FHLLw4EVyhl9ygN+nPQkP3kXL04SLvW4V/N7dcBgAQGhVcRLopqe3Tnao+5zF01O
         aTFqkgzL7cV/krGUwelNHHaVszEZk7Qu0SSQgq7qb1rGaXBMjQGu2uq8fekulT+s0fAZ
         dxKoOMJjSWT2LO2XdC4oLUA6q584EJS5ste2Nn3e6lxkXAK5AJdkGiOTfFzPuvtfF0w5
         tM96sg94DZ/ujC0XxxpYd0QZKZQLluhD0/KYVTmdUEp+3HOkpbvrKjZtcQWIZH8SO59L
         DQ+g==
X-Gm-Message-State: AOAM533odN2OLiQCmJyoqwV/0yCs0jcFirlIObqEB2RHRqDX3AVWlidB
        YRbdLtHzLu580PoFI1mYdjfoZLlc
X-Google-Smtp-Source: ABdhPJz5LCJyYtKUUV9hYf011jY26e6+0uG4DFrNywYaFW3Hw4tl73qxoUBFdaIEM1oIfJ6J+M0DIQ==
X-Received: by 2002:a5d:42c2:: with SMTP id t2mr18485749wrr.396.1596941635603;
        Sat, 08 Aug 2020 19:53:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z15sm16278690wrn.89.2020.08.08.19.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 19:53:55 -0700 (PDT)
Message-Id: <1aa2a00a7a2a0e4c884bf95261b5e308c3611fbc.1596941625.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
        <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 09 Aug 2020 02:53:40 +0000
Subject: [PATCH v2 06/10] commit-graph: return 64-bit generation number
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhishek Kumar <abhishekkumar8222@gmail.com>

In a preparatory step, let's return timestamp_t values from
commit_graph_generation(), use timestamp_t for local variables and
define GENERATION_NUMBER_INFINITY as (2 ^ 63 - 1) instead.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-graph.c | 18 +++++++++---------
 commit-graph.h |  4 ++--
 commit-reach.c | 32 ++++++++++++++++----------------
 commit-reach.h |  2 +-
 commit.h       |  3 ++-
 revision.c     | 10 +++++-----
 upload-pack.c  |  2 +-
 7 files changed, 36 insertions(+), 35 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index d5da1e8028..42f3ec5460 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -100,7 +100,7 @@ uint32_t commit_graph_position(const struct commit *c)
 	return data ? data->graph_pos : COMMIT_NOT_FROM_GRAPH;
 }
 
-uint32_t commit_graph_generation(const struct commit *c)
+timestamp_t commit_graph_generation(const struct commit *c)
 {
 	struct commit_graph_data *data =
 		commit_graph_data_slab_peek(&commit_graph_data_slab, c);
@@ -116,8 +116,8 @@ uint32_t commit_graph_generation(const struct commit *c)
 int compare_commits_by_gen(const void *_a, const void *_b)
 {
 	const struct commit *a = _a, *b = _b;
-	const uint32_t generation_a = commit_graph_generation(a);
-	const uint32_t generation_b = commit_graph_generation(b);
+	const timestamp_t generation_a = commit_graph_generation(a);
+	const timestamp_t generation_b = commit_graph_generation(b);
 
 	/* older commits first */
 	if (generation_a < generation_b)
@@ -160,8 +160,8 @@ static int commit_gen_cmp(const void *va, const void *vb)
 	const struct commit *a = *(const struct commit **)va;
 	const struct commit *b = *(const struct commit **)vb;
 
-	uint32_t generation_a = commit_graph_data_at(a)->generation;
-	uint32_t generation_b = commit_graph_data_at(b)->generation;
+	const timestamp_t generation_a = commit_graph_data_at(a)->generation;
+	const timestamp_t generation_b = commit_graph_data_at(b)->generation;
 	/* lower generation commits first */
 	if (generation_a < generation_b)
 		return -1;
@@ -1363,7 +1363,7 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 		uint32_t generation = commit_graph_data_at(ctx->commits.list[i])->generation;
 
 		display_progress(ctx->progress, i + 1);
-		if (generation != GENERATION_NUMBER_INFINITY &&
+		if (generation != GENERATION_NUMBER_V1_INFINITY &&
 		    generation != GENERATION_NUMBER_ZERO)
 			continue;
 
@@ -1377,7 +1377,7 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 			for (parent = current->parents; parent; parent = parent->next) {
 				generation = commit_graph_data_at(parent->item)->generation;
 
-				if (generation == GENERATION_NUMBER_INFINITY ||
+				if (generation == GENERATION_NUMBER_V1_INFINITY ||
 				    generation == GENERATION_NUMBER_ZERO) {
 					all_parents_computed = 0;
 					commit_list_insert(parent->item, &list);
@@ -2387,8 +2387,8 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 	for (i = 0; i < g->num_commits; i++) {
 		struct commit *graph_commit, *odb_commit;
 		struct commit_list *graph_parents, *odb_parents;
-		uint32_t max_generation = 0;
-		uint32_t generation;
+		timestamp_t max_generation = 0;
+		timestamp_t generation;
 
 		display_progress(progress, i + 1);
 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
diff --git a/commit-graph.h b/commit-graph.h
index cc232e0678..f89614ecd5 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -140,13 +140,13 @@ void disable_commit_graph(struct repository *r);
 
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
index c83cc291e7..470bc80139 100644
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
-	uint32_t generation, min_generation = GENERATION_NUMBER_INFINITY;
+	timestamp_t generation, min_generation = GENERATION_NUMBER_INFINITY;
 
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
+	timestamp_t min_generation = GENERATION_NUMBER_INFINITY;
 
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
+	timestamp_t min_generation = GENERATION_NUMBER_INFINITY;
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
index e901538909..bc0732a4fe 100644
--- a/commit.h
+++ b/commit.h
@@ -11,7 +11,8 @@
 #include "commit-slab.h"
 
 #define COMMIT_NOT_FROM_GRAPH 0xFFFFFFFF
-#define GENERATION_NUMBER_INFINITY 0xFFFFFFFF
+#define GENERATION_NUMBER_INFINITY ((1ULL << 63) - 1)
+#define GENERATION_NUMBER_V1_INFINITY 0xFFFFFFFF
 #define GENERATION_NUMBER_MAX 0x3FFFFFFF
 #define GENERATION_NUMBER_ZERO 0
 
diff --git a/revision.c b/revision.c
index 4ec82ed5ab..bd7b39c806 100644
--- a/revision.c
+++ b/revision.c
@@ -3292,7 +3292,7 @@ define_commit_slab(indegree_slab, int);
 define_commit_slab(author_date_slab, timestamp_t);
 
 struct topo_walk_info {
-	uint32_t min_generation;
+	timestamp_t min_generation;
 	struct prio_queue explore_queue;
 	struct prio_queue indegree_queue;
 	struct prio_queue topo_queue;
@@ -3338,7 +3338,7 @@ static void explore_walk_step(struct rev_info *revs)
 }
 
 static void explore_to_depth(struct rev_info *revs,
-			     uint32_t gen_cutoff)
+			     timestamp_t gen_cutoff)
 {
 	struct topo_walk_info *info = revs->topo_walk_info;
 	struct commit *c;
@@ -3381,7 +3381,7 @@ static void indegree_walk_step(struct rev_info *revs)
 }
 
 static void compute_indegrees_to_depth(struct rev_info *revs,
-				       uint32_t gen_cutoff)
+				       timestamp_t gen_cutoff)
 {
 	struct topo_walk_info *info = revs->topo_walk_info;
 	struct commit *c;
@@ -3439,7 +3439,7 @@ static void init_topo_walk(struct rev_info *revs)
 	info->min_generation = GENERATION_NUMBER_INFINITY;
 	for (list = revs->commits; list; list = list->next) {
 		struct commit *c = list->item;
-		uint32_t generation;
+		timestamp_t generation;
 
 		if (parse_commit_gently(c, 1))
 			continue;
@@ -3500,7 +3500,7 @@ static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
 	for (p = commit->parents; p; p = p->next) {
 		struct commit *parent = p->item;
 		int *pi;
-		uint32_t generation;
+		timestamp_t generation;
 
 		if (parent->object.flags & UNINTERESTING)
 			continue;
diff --git a/upload-pack.c b/upload-pack.c
index 8673741070..18ee29db67 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -490,7 +490,7 @@ static int got_oid(struct upload_pack_data *data,
 
 static int ok_to_give_up(struct upload_pack_data *data)
 {
-	uint32_t min_generation = GENERATION_NUMBER_ZERO;
+	timestamp_t min_generation = GENERATION_NUMBER_ZERO;
 
 	if (!data->have_obj.nr)
 		return 0;
-- 
gitgitgadget

