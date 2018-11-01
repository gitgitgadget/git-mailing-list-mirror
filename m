Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C35141F453
	for <e@80x24.org>; Thu,  1 Nov 2018 13:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbeKAWti (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 18:49:38 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36066 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbeKAWth (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 18:49:37 -0400
Received: by mail-qk1-f194.google.com with SMTP id o125so9008623qkf.3
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 06:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O2sygxFRdpNLh2nFaKhC0enBudJmWRhoL/D7OHWBiQE=;
        b=RDMmnwCayyL9Cijt34LYP4ualXiSjypFegb687fs5nmOGm7MwAW7NKjasyFTmyAEKY
         O9dOKAn38Y5KSKgkKluTXJrq94hrrEBqSt8p9bsW4RpJiziX2CQiaWr9Gg5SHyzzW6t9
         SFLKNaMW06nrpsj5cd0NTVNiPe/ZjSVz7VvH5JAvs8aF5XF9eaKXi0hYN7fKXbTph4ma
         oTcGlgBy3Ot+kHn/Nm8QOe7t4uYcepyCIeg7i1gW6R22SceqLNGPOQJsCJHVizwtK8pG
         9LCUgkfc7PEVG2z8uxKYd9uj98ugoXEfH4PP58RBWm9hlvM7y4jsZPHyEtJGCLDAhQ23
         kbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O2sygxFRdpNLh2nFaKhC0enBudJmWRhoL/D7OHWBiQE=;
        b=LKxhu2fq7fM+3R2XQrRISNZs1W8uCV3XNs6/xWK612zBdzjLQHvUiXhMdLZ0bSDnfM
         WJ7M3UgVDRbD5GglFxYqA3pZGjqDHZbnj1RnyphgFHBuhXw/oIVpdzQnwcS9jZ4+UAdj
         uZLWMg6U8juvZeO+/jd/B1smzg/AOycg2EKfG+snFTLJ6zwa3pvhGL7WRbC644aWhTe5
         OXHj6KrDurCWgoX5HbiWbeK2GA+gHsbS6UfZ2GFE/1cB77WMLP59lfaX1ZG8M6RoF3QZ
         8UuPrQrnvXcQywgrSFt2n+1AwzCtQ8Wbnvz40hiFscq/Fi6Zh40DORA/WoSqASrgSRf2
         7FlQ==
X-Gm-Message-State: AGRZ1gJ2iEWyS4/br0D9qosY2KqNug6OurAUrbb4zMOxLVeV3kWacr9e
        XS92+wFZI3bY8+XW9APROuWQC/Rq
X-Google-Smtp-Source: AJdET5cSDbZ3kVzw2sLgvCyNg21QcS/dH/GX4qQvYklDilbEOV66c5GaLf3Ex/xJ9bgQYsPblCrBqw==
X-Received: by 2002:ae9:e414:: with SMTP id q20mr6433425qkc.205.1541079993377;
        Thu, 01 Nov 2018 06:46:33 -0700 (PDT)
Received: from stolee-linux.mshome.net ([167.220.148.125])
        by smtp.gmail.com with ESMTPSA id f75sm7347357qkf.96.2018.11.01.06.46.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 06:46:32 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, szeder.dev@gmail.com,
        peff@peff.net, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 6/7] revision.c: generation-based topo-order algorithm
Date:   Thu,  1 Nov 2018 13:46:22 +0000
Message-Id: <20181101134623.84055-7-dstolee@microsoft.com>
X-Mailer: git-send-email 2.19.1.542.gc4df23f792
In-Reply-To: <20181101134623.84055-1-dstolee@microsoft.com>
References: <pull.25.v4.git.gitgitgadget@gmail.com>
 <20181101134623.84055-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current --topo-order algorithm requires walking all
reachable commits up front, topo-sorting them, all before
outputting the first value. This patch introduces a new
algorithm which uses stored generation numbers to
incrementally walk in topo-order, outputting commits as
we go. This can dramatically reduce the computation time
to write a fixed number of commits, such as when limiting
with "-n <N>" or filling the first page of a pager.

When running a command like 'git rev-list --topo-order HEAD',
Git performed the following steps:

1. Run limit_list(), which parses all reachable commits,
   adds them to a linked list, and distributes UNINTERESTING
   flags. If all unprocessed commits are UNINTERESTING, then
   it may terminate without walking all reachable commits.
   This does not occur if we do not specify UNINTERESTING
   commits.

2. Run sort_in_topological_order(), which is an implementation
   of Kahn's algorithm. It first iterates through the entire
   set of important commits and computes the in-degree of each
   (plus one, as we use 'zero' as a special value here). Then,
   we walk the commits in priority order, adding them to the
   priority queue if and only if their in-degree is one. As
   we remove commits from this priority queue, we decrement the
   in-degree of their parents.

3. While we are peeling commits for output, get_revision_1()
   uses pop_commit on the full list of commits computed by
   sort_in_topological_order().

In the new algorithm, these three steps correspond to three
different commit walks. We run these walks simultaneously,
and advance each only as far as necessary to satisfy the
requirements of the 'higher order' walk. We know when we can
pause each walk by using generation numbers from the commit-
graph feature.

Recall that the generation number of a commit satisfies:

* If the commit has at least one parent, then the generation
  number is one more than the maximum generation number among
  its parents.

* If the commit has no parent, then the generation number is one.

There are two special generation numbers:

* GENERATION_NUMBER_INFINITY: this value is 0xffffffff and
  indicates that the commit is not stored in the commit-graph and
  the generation number was not previously calculated.

* GENERATION_NUMBER_ZERO: this value (0) is a special indicator
  to say that the commit-graph was generated by a version of Git
  that does not compute generation numbers (such as v2.18.0).

Since we use generation_numbers_enabled() before using the new
algorithm, we do not need to worry about GENERATION_NUMBER_ZERO.
However, the existence of GENERATION_NUMBER_INFINITY implies the
following weaker statement than the usual we expect from
generation numbers:

    If A and B are commits with generation numbers gen(A) and
    gen(B) and gen(A) < gen(B), then A cannot reach B.

Thus, we will walk in each of our stages until the "maximum
unexpanded generation number" is strictly lower than the
generation number of a commit we are about to use.

The walks are as follows:

1. EXPLORE: using the explore_queue priority queue (ordered by
   maximizing the generation number), parse each reachable
   commit until all commits in the queue have generation
   number strictly lower than needed. During this walk, update
   the UNINTERESTING flags as necessary.

2. INDEGREE: using the indegree_queue priority queue (ordered
   by maximizing the generation number), add one to the in-
   degree of each parent for each commit that is walked. Since
   we walk in order of decreasing generation number, we know
   that discovering an in-degree value of 0 means the value for
   that commit was not initialized, so should be initialized to
   two. (Recall that in-degree value "1" is what we use to say a
   commit is ready for output.) As we iterate the parents of a
   commit during this walk, ensure the EXPLORE walk has walked
   beyond their generation numbers.

3. TOPO: using the topo_queue priority queue (ordered based on
   the sort_order given, which could be commit-date, author-
   date, or typical topo-order which treats the queue as a LIFO
   stack), remove a commit from the queue and decrement the
   in-degree of each parent. If a parent has an in-degree of
   one, then we add it to the topo_queue. Before we decrement
   the in-degree, however, ensure the INDEGREE walk has walked
   beyond that generation number.

The implementations of these walks are in the following methods:

* explore_walk_step and explore_to_depth
* indegree_walk_step and compute_indegrees_to_depth
* next_topo_commit and expand_topo_walk

These methods have some patterns that may seem strange at first,
but they are probably carry-overs from their equivalents in
limit_list and sort_in_topological_order.

One thing that is missing from this implementation is a proper
way to stop walking when the entire queue is UNINTERESTING, so
this implementation is not enabled by comparisions, such as in
'git rev-list --topo-order A..B'. This can be updated in the
future.

In my local testing, I used the following Git commands on the
Linux repository in three modes: HEAD~1 with no commit-graph,
HEAD~1 with a commit-graph, and HEAD with a commit-graph. This
allows comparing the benefits we get from parsing commits from
the commit-graph and then again the benefits we get by
restricting the set of commits we walk.

Test: git rev-list --topo-order -100 HEAD
HEAD~1, no commit-graph: 6.80 s
HEAD~1, w/ commit-graph: 0.77 s
  HEAD, w/ commit-graph: 0.02 s

Test: git rev-list --topo-order -100 HEAD -- tools
HEAD~1, no commit-graph: 9.63 s
HEAD~1, w/ commit-graph: 6.06 s
  HEAD, w/ commit-graph: 0.06 s

This speedup is due to a few things. First, the new generation-
number-enabled algorithm walks commits on order of the number of
results output (subject to some branching structure expectations).
Since we limit to 100 results, we are running a query similar to
filling a single page of results. Second, when specifying a path,
we must parse the root tree object for each commit we walk. The
previous benefits from the commit-graph are entirely from reading
the commit-graph instead of parsing commits. Since we need to
parse trees for the same number of commits as before, we slow
down significantly from the non-path-based query.

For the test above, I specifically selected a path that is changed
frequently, including by merge commits. A less-frequently-changed
path (such as 'README') has similar end-to-end time since we need
to walk the same number of commits (before determining we do not
have 100 hits). However, get the benefit that the output is
presented to the user as it is discovered, much the same as a
normal 'git log' command (no '--topo-order'). This is an improved
user experience, even if the command has the same runtime.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 object.h   |   4 +-
 revision.c | 195 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 revision.h |   2 +
 3 files changed, 194 insertions(+), 7 deletions(-)

diff --git a/object.h b/object.h
index 0feb90ae61..796792cb32 100644
--- a/object.h
+++ b/object.h
@@ -59,7 +59,7 @@ struct object_array {
 
 /*
  * object flag allocation:
- * revision.h:               0---------10                              2526
+ * revision.h:               0---------10                              25----28
  * fetch-pack.c:             01
  * negotiator/default.c:       2--5
  * walker.c:                 0-2
@@ -78,7 +78,7 @@ struct object_array {
  * builtin/show-branch.c:    0-------------------------------------------26
  * builtin/unpack-objects.c:                                 2021
  */
-#define FLAG_BITS  27
+#define FLAG_BITS  29
 
 /*
  * The object type is stored in 3 bits.
diff --git a/revision.c b/revision.c
index 36458265a0..4ef47d2fb4 100644
--- a/revision.c
+++ b/revision.c
@@ -26,6 +26,7 @@
 #include "argv-array.h"
 #include "commit-reach.h"
 #include "commit-graph.h"
+#include "prio-queue.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -2895,31 +2896,215 @@ static int mark_uninteresting(const struct object_id *oid,
 	return 0;
 }
 
-struct topo_walk_info {};
+define_commit_slab(indegree_slab, int);
+define_commit_slab(author_date_slab, timestamp_t);
+
+struct topo_walk_info {
+	uint32_t min_generation;
+	struct prio_queue explore_queue;
+	struct prio_queue indegree_queue;
+	struct prio_queue topo_queue;
+	struct indegree_slab indegree;
+	struct author_date_slab author_date;
+};
+
+static inline void test_flag_and_insert(struct prio_queue *q, struct commit *c, int flag)
+{
+	if (c->object.flags & flag)
+		return;
+
+	c->object.flags |= flag;
+	prio_queue_put(q, c);
+}
+
+static void explore_walk_step(struct rev_info *revs)
+{
+	struct topo_walk_info *info = revs->topo_walk_info;
+	struct commit_list *p;
+	struct commit *c = prio_queue_get(&info->explore_queue);
+
+	if (!c)
+		return;
+
+	if (parse_commit_gently(c, 1) < 0)
+		return;
+
+	if (revs->sort_order == REV_SORT_BY_AUTHOR_DATE)
+		record_author_date(&info->author_date, c);
+
+	if (revs->max_age != -1 && (c->date < revs->max_age))
+		c->object.flags |= UNINTERESTING;
+
+	if (process_parents(revs, c, NULL, NULL) < 0)
+		return;
+
+	if (c->object.flags & UNINTERESTING)
+		mark_parents_uninteresting(c);
+
+	for (p = c->parents; p; p = p->next)
+		test_flag_and_insert(&info->explore_queue, p->item, TOPO_WALK_EXPLORED);
+}
+
+static void explore_to_depth(struct rev_info *revs,
+			     uint32_t gen_cutoff)
+{
+	struct topo_walk_info *info = revs->topo_walk_info;
+	struct commit *c;
+	while ((c = prio_queue_peek(&info->explore_queue)) &&
+	       c->generation >= gen_cutoff)
+		explore_walk_step(revs);
+}
+
+static void indegree_walk_step(struct rev_info *revs)
+{
+	struct commit_list *p;
+	struct topo_walk_info *info = revs->topo_walk_info;
+	struct commit *c = prio_queue_get(&info->indegree_queue);
+
+	if (!c)
+		return;
+
+	if (parse_commit_gently(c, 1) < 0)
+		return;
+
+	explore_to_depth(revs, c->generation);
+
+	for (p = c->parents; p; p = p->next) {
+		struct commit *parent = p->item;
+		int *pi = indegree_slab_at(&info->indegree, parent);
+
+		if (*pi)
+			(*pi)++;
+		else
+			*pi = 2;
+
+		test_flag_and_insert(&info->indegree_queue, parent, TOPO_WALK_INDEGREE);
+
+		if (revs->first_parent_only)
+			return;
+	}
+}
+
+static void compute_indegrees_to_depth(struct rev_info *revs,
+				       uint32_t gen_cutoff)
+{
+	struct topo_walk_info *info = revs->topo_walk_info;
+	struct commit *c;
+	while ((c = prio_queue_peek(&info->indegree_queue)) &&
+	       c->generation >= gen_cutoff)
+		indegree_walk_step(revs);
+}
 
 static void init_topo_walk(struct rev_info *revs)
 {
 	struct topo_walk_info *info;
+	struct commit_list *list;
 	revs->topo_walk_info = xmalloc(sizeof(struct topo_walk_info));
 	info = revs->topo_walk_info;
 	memset(info, 0, sizeof(struct topo_walk_info));
 
-	limit_list(revs);
-	sort_in_topological_order(&revs->commits, revs->sort_order);
+	init_indegree_slab(&info->indegree);
+	memset(&info->explore_queue, 0, sizeof(info->explore_queue));
+	memset(&info->indegree_queue, 0, sizeof(info->indegree_queue));
+	memset(&info->topo_queue, 0, sizeof(info->topo_queue));
+
+	switch (revs->sort_order) {
+	default: /* REV_SORT_IN_GRAPH_ORDER */
+		info->topo_queue.compare = NULL;
+		break;
+	case REV_SORT_BY_COMMIT_DATE:
+		info->topo_queue.compare = compare_commits_by_commit_date;
+		break;
+	case REV_SORT_BY_AUTHOR_DATE:
+		init_author_date_slab(&info->author_date);
+		info->topo_queue.compare = compare_commits_by_author_date;
+		info->topo_queue.cb_data = &info->author_date;
+		break;
+	}
+
+	info->explore_queue.compare = compare_commits_by_gen_then_commit_date;
+	info->indegree_queue.compare = compare_commits_by_gen_then_commit_date;
+
+	info->min_generation = GENERATION_NUMBER_INFINITY;
+	for (list = revs->commits; list; list = list->next) {
+		struct commit *c = list->item;
+
+		if (parse_commit_gently(c, 1))
+			continue;
+
+		test_flag_and_insert(&info->explore_queue, c, TOPO_WALK_EXPLORED);
+		test_flag_and_insert(&info->indegree_queue, c, TOPO_WALK_INDEGREE);
+
+		if (c->generation < info->min_generation)
+			info->min_generation = c->generation;
+
+		*(indegree_slab_at(&info->indegree, c)) = 1;
+
+		if (revs->sort_order == REV_SORT_BY_AUTHOR_DATE)
+			record_author_date(&info->author_date, c);
+	}
+	compute_indegrees_to_depth(revs, info->min_generation);
+
+	for (list = revs->commits; list; list = list->next) {
+		struct commit *c = list->item;
+
+		if (*(indegree_slab_at(&info->indegree, c)) == 1)
+			prio_queue_put(&info->topo_queue, c);
+	}
+
+	/*
+	 * This is unfortunate; the initial tips need to be shown
+	 * in the order given from the revision traversal machinery.
+	 */
+	if (revs->sort_order == REV_SORT_IN_GRAPH_ORDER)
+		prio_queue_reverse(&info->topo_queue);
 }
 
 static struct commit *next_topo_commit(struct rev_info *revs)
 {
-	return pop_commit(&revs->commits);
+	struct commit *c;
+	struct topo_walk_info *info = revs->topo_walk_info;
+
+	/* pop next off of topo_queue */
+	c = prio_queue_get(&info->topo_queue);
+
+	if (c)
+		*(indegree_slab_at(&info->indegree, c)) = 0;
+
+	return c;
 }
 
 static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
 {
-	if (process_parents(revs, commit, &revs->commits, NULL) < 0) {
+	struct commit_list *p;
+	struct topo_walk_info *info = revs->topo_walk_info;
+	if (process_parents(revs, commit, NULL, NULL) < 0) {
 		if (!revs->ignore_missing_links)
 			die("Failed to traverse parents of commit %s",
 			    oid_to_hex(&commit->object.oid));
 	}
+
+	for (p = commit->parents; p; p = p->next) {
+		struct commit *parent = p->item;
+		int *pi;
+
+		if (parse_commit_gently(parent, 1) < 0)
+			continue;
+
+		if (parent->generation < info->min_generation) {
+			info->min_generation = parent->generation;
+			compute_indegrees_to_depth(revs, info->min_generation);
+		}
+
+		pi = indegree_slab_at(&info->indegree, parent);
+
+		(*pi)--;
+		if (*pi == 1)
+			prio_queue_put(&info->topo_queue, parent);
+
+		if (revs->first_parent_only)
+			return;
+	}
 }
 
 int prepare_revision_walk(struct rev_info *revs)
diff --git a/revision.h b/revision.h
index fd4154ff75..b0b3bb8025 100644
--- a/revision.h
+++ b/revision.h
@@ -24,6 +24,8 @@
 #define USER_GIVEN	(1u<<25) /* given directly by the user */
 #define TRACK_LINEAR	(1u<<26)
 #define ALL_REV_FLAGS	(((1u<<11)-1) | USER_GIVEN | TRACK_LINEAR)
+#define TOPO_WALK_EXPLORED	(1u<<27)
+#define TOPO_WALK_INDEGREE	(1u<<28)
 
 #define DECORATE_SHORT_REFS	1
 #define DECORATE_FULL_REFS	2
-- 
2.19.1.542.gc4df23f792

