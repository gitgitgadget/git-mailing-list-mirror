Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7ECA1F453
	for <e@80x24.org>; Thu,  1 Nov 2018 13:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbeKAWta (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 18:49:30 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46351 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbeKAWt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 18:49:29 -0400
Received: by mail-qk1-f195.google.com with SMTP id q1so10560256qkf.13
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 06:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fc00YL8L4NYk6BchbaDvrOXOpyZ+hXlBbdStPrcooHU=;
        b=W9leqqUjxRDAEvYUZ8K4KJsTWKSVZm7udSSX+p0JB6I0WTV6RyB6Vl1LSDWt/5Lrtq
         zlKgbnZvr6lA3dEvHu7wlDXO7xAlHWqCzH3zi85vOkpwcrr83ZtSVe4jjc6M5F+oIp/h
         padu0ePyv340nua50dSMXfVULuRj+XNE2ryP52q/t83EnH7Jh90b4yHoTLpbQhtJ+KPO
         MtDJG6rKhvI3ZFxyzn+ve+w5iYP/P9sAO3g9tQJjuKJvyr3oN1YR6Ch0WHG2IlI8kkm5
         6AN2UOOvgnFsy13WeFd08GY8ADhQ1LRcWXuyug+bNWRot7QCi8zIbh5N9LMPpyML8efi
         jhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fc00YL8L4NYk6BchbaDvrOXOpyZ+hXlBbdStPrcooHU=;
        b=oeXMqiZluSn8dANiIkehDE9Y8uF9t2S65eJesiqIzsJWjyXvU6mySuFsC3cd3cOlpP
         c1cT2WEOrGUfrLhv8tuA/32WXwD2POv8r8SThcBu6trto4m2EJusWxkVBOhf/7NdCP4G
         AgYMH0nfkItHS5aCqs9rq6VmqiVA5+/VTFh7edWEg6chrWswdinzxx1rMH9i4xtF+8lM
         VQdJtZadl7ENCeoJ00KizdchoBQX0Mqo0UGTn333tj6xR6JpsextzFQ3EMh24oK8iFb6
         nTh6n6CgjK0DzDPzB58gmpj/cTEBawDDD9LpWGhJobMllDtcYcRBT71PXqyvca55AmxC
         kk4g==
X-Gm-Message-State: AGRZ1gI2FN3IPnxqsefjHyrz6rIPBbmC3U/LQ17Ffs+gva6kz5QuTg0Z
        +ghfPq2ikRIeGg7lMRzHKq+6wWFC
X-Google-Smtp-Source: AJdET5fhXOVTRmr93TtDuR1HwPy8kgZlamUH045YwBZqYmJr/3kEx8MqhtAgPf+juO41HK+xwcqZwA==
X-Received: by 2002:a37:4bd1:: with SMTP id y200-v6mr6672887qka.55.1541079986546;
        Thu, 01 Nov 2018 06:46:26 -0700 (PDT)
Received: from stolee-linux.mshome.net ([167.220.148.125])
        by smtp.gmail.com with ESMTPSA id f75sm7347357qkf.96.2018.11.01.06.46.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 06:46:25 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, szeder.dev@gmail.com,
        peff@peff.net, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 0/7] Use generation numbers for --topo-order
Date:   Thu,  1 Nov 2018 13:46:16 +0000
Message-Id: <20181101134623.84055-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.19.1.542.gc4df23f792
In-Reply-To: <pull.25.v4.git.gitgitgadget@gmail.com>
References: <pull.25.v4.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series performs a decently-sized refactoring of the
revision-walk machinery. Well, "refactoring" is probably the wrong word,
as I don't actually remove the old code. Instead, when we see certain
options in the 'rev_info' struct, we redirect the commit-walk logic to
a new set of methods that distribute the workload differently. By using
generation numbers in the commit-graph, we can significantly improve
'git log --graph' commands (and the underlying 'git rev-list --topo-order').

On the Linux repository, I got the following performance results when
comparing to the previous version with or without a commit-graph:

    Test: git rev-list --topo-order -100 HEAD
    HEAD~1, no commit-graph: 6.80 s
    HEAD~1, w/ commit-graph: 0.77 s
      HEAD, w/ commit-graph: 0.02 s

    Test: git rev-list --topo-order -100 HEAD -- tools
    HEAD~1, no commit-graph: 9.63 s
    HEAD~1, w/ commit-graph: 6.06 s
      HEAD, w/ commit-graph: 0.06 s

If you want to read this series but are unfamiliar with the commit-graph
and generation numbers, then I recommend reading
`Documentation/technical/commit-graph.txt` or a blog post [1] I wrote on
the subject. In particular, the three-part walk described in "revision.c:
refactor basic topo-order logic" is present (but underexplained) as an
animated PNG [2].

**UPDATED** Now that we have had some review and some dogfooding, I'm
removing the paragraph I had here about "RFC quality". I think this is
ready to merge!

One notable case that is not included in this series is the case of a
history comparison such as 'git rev-list --topo-order A..B'. The existing
code in limit_list() has ways to cut the walk short when all pending
commits are UNINTERESTING. Since this code depends on commit_list instead
of the prio_queue we are using here, I chose to leave it untouched for now.
We can revisit it in a separate series later. Since handle_commit() turns
on revs->limited when a commit is UNINTERESTING, we do not hit the new
code in this case. Removing this 'revs->limited = 1;' line yields correct
results, but the performance can be worse.

**UPDATED** See the discussion about Generation Number V2 [4] for more
on this topic.

Changes in V5: Thanks Jakub for feedback on the huge commit! I think
I've responded to all the code feedback. See the range-diff at the
end of this cover-page.

Thanks,
-Stolee

[1] https://blogs.msdn.microsoft.com/devops/2018/07/09/supercharging-the-git-commit-graph-iii-generations/
   Supercharging the Git Commit Graph III: Generations and Graph Algorithms

[2] https://msdnshared.blob.core.windows.net/media/2018/06/commit-graph-topo-order-b-a.png
    Animation showing three-part walk

[3] https://github.com/derrickstolee/git/tree/topo-order/test
    A branch containing this series along with commits to compute commit-graph in entire test suite.

[4] https://public-inbox.org/git/6367e30a-1b3a-4fe9-611b-d931f51effef@gmail.com/
    [RFC] Generation Number v2

Note: I'm not submitting this version via GitGitGadget because it's
currently struggling with how to handle a PR in a conflict state.
The new flags in revision.h have a conflict with recent changes in
master.

Derrick Stolee (7):
  prio-queue: add 'peek' operation
  test-reach: add run_three_modes method
  test-reach: add rev-list tests
  revision.c: begin refactoring --topo-order logic
  commit/revisions: bookkeeping before refactoring
  revision.c: generation-based topo-order algorithm
  t6012: make rev-list tests more interesting

 commit.c                     |   9 +-
 commit.h                     |   7 +
 object.h                     |   4 +-
 prio-queue.c                 |   9 ++
 prio-queue.h                 |   6 +
 revision.c                   | 243 +++++++++++++++++++++++++++++++++--
 revision.h                   |   6 +
 t/helper/test-prio-queue.c   |  26 ++--
 t/t0009-prio-queue.sh        |  14 ++
 t/t6012-rev-list-simplify.sh |  45 +++++--
 t/t6600-test-reach.sh        |  96 +++++++++++++-
 11 files changed, 426 insertions(+), 39 deletions(-)


base-commit: 2d3b1c576c85b7f5db1f418907af00ab88e0c303
-- 
2.19.1.542.gc4df23f792

-->8--

1:  2358cfd5ed = 1:  7c75a56505 prio-queue: add 'peek' operation
2:  3a4b68e479 = 2:  686c4370de test-reach: add run_three_modes method
3:  12a3f6d367 = 3:  7410c00982 test-reach: add rev-list tests
4:  cd9eef9688 = 4:  5439e11e37 revision.c: begin refactoring --topo-order logic
5:  f3e291665d ! 5:  71554deb9b commit/revisions: bookkeeping before refactoring
    @@ -9,8 +9,8 @@
            compare_commits_by_author_date() in revision.c. These are used
            currently by sort_in_topological_order() in commit.c.
     
    -    2. Moving these methods to commit.h requires adding the author_slab
    -       definition to commit.h.
    +    2. Moving these methods to commit.h requires adding an author_date_slab
    +       declaration to commit.h. Consumers will need their own implementation.
     
         3. The add_parents_to_list() method in revision.c performs logic
            around the UNINTERESTING flag and other special cases depending
    @@ -31,8 +31,7 @@
      define_commit_slab(indegree_slab, int);
      
     -/* record author-date for each commit object */
    --define_commit_slab(author_date_slab, timestamp_t);
    -+implement_shared_commit_slab(author_date_slab, timestamp_t);
    + define_commit_slab(author_date_slab, timestamp_t);
      
     -static void record_author_date(struct author_date_slab *author_date,
     -			       struct commit *commit)
    @@ -69,8 +68,7 @@
      extern int check_commit_signature(const struct commit *commit, struct signature_check *sigc);
      
     +/* record author-date for each commit object */
    -+define_shared_commit_slab(author_date_slab, timestamp_t);
    -+
    ++struct author_date_slab;
     +void record_author_date(struct author_date_slab *author_date,
     +			struct commit *commit);
     +
6:  aa0bb2221d ! 6:  84c142e0bc revision.c: generation-based topo-order algorithm
    @@ -195,6 +195,7 @@
      
     -struct topo_walk_info {};
     +define_commit_slab(indegree_slab, int);
    ++define_commit_slab(author_date_slab, timestamp_t);
     +
     +struct topo_walk_info {
     +	uint32_t min_generation;
    @@ -243,12 +244,12 @@
     +}
     +
     +static void explore_to_depth(struct rev_info *revs,
    -+			     uint32_t gen)
    ++			     uint32_t gen_cutoff)
     +{
     +	struct topo_walk_info *info = revs->topo_walk_info;
     +	struct commit *c;
     +	while ((c = prio_queue_peek(&info->explore_queue)) &&
    -+	       c->generation >= gen)
    ++	       c->generation >= gen_cutoff)
     +		explore_walk_step(revs);
     +}
     +
    @@ -266,9 +267,6 @@
     +
     +	explore_to_depth(revs, c->generation);
     +
    -+	if (parse_commit_gently(c, 1) < 0)
    -+		return;
    -+
     +	for (p = c->parents; p; p = p->next) {
     +		struct commit *parent = p->item;
     +		int *pi = indegree_slab_at(&info->indegree, parent);
    @@ -285,12 +283,13 @@
     +	}
     +}
     +
    -+static void compute_indegrees_to_depth(struct rev_info *revs)
    ++static void compute_indegrees_to_depth(struct rev_info *revs,
    ++				       uint32_t gen_cutoff)
     +{
     +	struct topo_walk_info *info = revs->topo_walk_info;
     +	struct commit *c;
     +	while ((c = prio_queue_peek(&info->indegree_queue)) &&
    -+	       c->generation >= info->min_generation)
    ++	       c->generation >= gen_cutoff)
     +		indegree_walk_step(revs);
     +}
      
    @@ -305,9 +304,9 @@
     -	limit_list(revs);
     -	sort_in_topological_order(&revs->commits, revs->sort_order);
     +	init_indegree_slab(&info->indegree);
    -+	memset(&info->explore_queue, '\0', sizeof(info->explore_queue));
    -+	memset(&info->indegree_queue, '\0', sizeof(info->indegree_queue));
    -+	memset(&info->topo_queue, '\0', sizeof(info->topo_queue));
    ++	memset(&info->explore_queue, 0, sizeof(info->explore_queue));
    ++	memset(&info->indegree_queue, 0, sizeof(info->indegree_queue));
    ++	memset(&info->topo_queue, 0, sizeof(info->topo_queue));
     +
     +	switch (revs->sort_order) {
     +	default: /* REV_SORT_IN_GRAPH_ORDER */
    @@ -329,23 +328,22 @@
     +	info->min_generation = GENERATION_NUMBER_INFINITY;
     +	for (list = revs->commits; list; list = list->next) {
     +		struct commit *c = list->item;
    -+		test_flag_and_insert(&info->explore_queue, c, TOPO_WALK_EXPLORED);
    -+		test_flag_and_insert(&info->indegree_queue, c, TOPO_WALK_INDEGREE);
     +
     +		if (parse_commit_gently(c, 1))
     +			continue;
    ++
    ++		test_flag_and_insert(&info->explore_queue, c, TOPO_WALK_EXPLORED);
    ++		test_flag_and_insert(&info->indegree_queue, c, TOPO_WALK_INDEGREE);
    ++
     +		if (c->generation < info->min_generation)
     +			info->min_generation = c->generation;
    -+	}
     +
    -+	for (list = revs->commits; list; list = list->next) {
    -+		struct commit *c = list->item;
     +		*(indegree_slab_at(&info->indegree, c)) = 1;
     +
     +		if (revs->sort_order == REV_SORT_BY_AUTHOR_DATE)
     +			record_author_date(&info->author_date, c);
     +	}
    -+	compute_indegrees_to_depth(revs);
    ++	compute_indegrees_to_depth(revs, info->min_generation);
     +
     +	for (list = revs->commits; list; list = list->next) {
     +		struct commit *c = list->item;
    @@ -385,9 +383,8 @@
     +	if (process_parents(revs, commit, NULL, NULL) < 0) {
      		if (!revs->ignore_missing_links)
      			die("Failed to traverse parents of commit %s",
    --			    oid_to_hex(&commit->object.oid));
    -+				oid_to_hex(&commit->object.oid));
    -+	}
    + 			    oid_to_hex(&commit->object.oid));
    + 	}
     +
     +	for (p = commit->parents; p; p = p->next) {
     +		struct commit *parent = p->item;
    @@ -398,7 +395,7 @@
     +
     +		if (parent->generation < info->min_generation) {
     +			info->min_generation = parent->generation;
    -+			compute_indegrees_to_depth(revs);
    ++			compute_indegrees_to_depth(revs, info->min_generation);
     +		}
     +
     +		pi = indegree_slab_at(&info->indegree, parent);
    @@ -409,9 +406,10 @@
     +
     +		if (revs->first_parent_only)
     +			return;
    - 	}
    ++	}
      }
      
    + int prepare_revision_walk(struct rev_info *revs)
     
      diff --git a/revision.h b/revision.h
      --- a/revision.h
7:  a21febe112 = 7:  5479087812 t6012: make rev-list tests more interesting
