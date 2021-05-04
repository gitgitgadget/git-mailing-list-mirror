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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BA8C43462
	for <git@archiver.kernel.org>; Tue,  4 May 2021 02:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14358611CB
	for <git@archiver.kernel.org>; Tue,  4 May 2021 02:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbhEDCN1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 22:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhEDCNY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 22:13:24 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B1BC061574
        for <git@vger.kernel.org>; Mon,  3 May 2021 19:12:29 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id l2so7576839wrm.9
        for <git@vger.kernel.org>; Mon, 03 May 2021 19:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KP2sE1SB6p3AhFcbQXGhLgaueKFXRAEFyG69JIqUoPU=;
        b=R5SVUb2aD1OE3U7UZ3XkWgvcLSxlMGuEBzoNoE2h3sc1nkpkcaypa8+Pu0UBHv98rn
         3bGOcU2+GK7QpPMVuc4dZWJPWx3/jucLJWo6bcOcDyRxkpImn206vfrRKr9dOf+7SkNJ
         iIY6ryQ9cdvy4E1YSXvSJ1k/6VK58hgk2o01aMoyxAsyKh3kHg2+rU8aXWb1f7uhTu5o
         ItpeyOHZb+xyzldcBXwTfxnba7B4l64kS+urtaqKMvZhYvRMB1AKfH8DllEoeYcGkqDV
         rZ/M6cXvJQ7HlOcUHJiusL/zU0lWGmZZQuOSKvDNUYQn6juIvEZ5ifqAcJDqBtaeQmkL
         DEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KP2sE1SB6p3AhFcbQXGhLgaueKFXRAEFyG69JIqUoPU=;
        b=Qefs0eA1oZ/Xm+DpcHqnKfA0YmY49NajlF0eK1i/Se1cm+AjPLQWmuY3vDnWPCovog
         odaCrmKf3HB4JqT0ov0NVqBJzwbXVe8iM/5Ld6h7iwwm/o2zJaq3JMf0v6wfsF/vjwkb
         a5atbC3UbTgSvYc/hBaZxXLpwdAQgJtuVtg7ovb3kmYtBIKcwjMIN+Qf87lKNMx+SNJE
         9sT3vYmqTWrdLpXI8rRmbpbWCavWZNtpWGcbUtyDYpLJ76wA6QI4+DYDVlzlYl7EJ3fU
         Y+um/zvajwWaM4UBuQgSeOlzrslNcrYSQj7jKZZr+dBtYkb0y3e5mB+dOi85dp2dJCAl
         YjJQ==
X-Gm-Message-State: AOAM532w7Z3zUx7L2dlx7B3kR0bn+CaXSOJULnIIvKOHDpJlB2x/P4e7
        vLFZH+zeodNSnljpHHCi3W8akKjMxdU=
X-Google-Smtp-Source: ABdhPJyG5YFkPibJA/gpggsptpxbJcqJc4J7FCdWaTG+dfI106luI2Pu1iv88n7ZZ0QItOnsnBT02w==
X-Received: by 2002:a5d:45cb:: with SMTP id b11mr28797876wrs.343.1620094347986;
        Mon, 03 May 2021 19:12:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c2sm1167876wmr.22.2021.05.03.19.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 19:12:27 -0700 (PDT)
Message-Id: <731b6bd15531fc7883a2c70275cea24ac686ab03.1620094339.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
        <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 May 2021 02:12:14 +0000
Subject: [PATCH v2 08/13] merge-ort: add code to check for whether cached
 renames can be reused
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

We need to know when renames detected in a previous merge operation can
be reused in a later merge operation.  Consider the following setup
(from the git-rebase manpage):

                     A---B---C topic
                    /
               D---E---F---G master

After rebasing, this will appear as:

                             A'--B'--C' topic
                            /
               D---E---F---G master

Further, let's say that 'oldfile' was renamed to 'newfile' between E
and G.  The rebase or cherry-pick of A onto G will involve a three-way
merge between E (as the merge base) and G and A.  After detecting the
rename between E:oldfile and G:newfile, there will be a three-way
content merge of the following:
    E:oldfile
    G:newfile
    A:oldfile
and produce a new result:
    A':newfile

Now, when we want to pick B onto A', we will need to do a three-way
merge between A (as the merge-base) and A' and B.  This will involve
a three-way content merge of
    A:oldfile
    A':newfile
    B:oldfile
but only if we can detect that A:oldfile is similar enough to A':newfile
to be used together in a three-way content merge, i.e. only if we can
detect that A:oldfile and A':newfile are a rename.  But we already know
that A:oldfile and A':newfile are similar enough to be used in a
three-way content merge, because that is precisely where A':newfile came
from in the previous merge.

Note that A & A' both appear in both merges.  That gives us the
condition under which we can reuse renames.

There are a couple important points about this optimization:

  - If the rebase or cherry-pick halts for user conflicts, these caches
    are NOT saved anywhere.  Thus, resuming a halted rebase or
    cherry-pick will result in no reused renames for the next commit.
    This is intentional, as user resolution can change files
    significantly and in ways that violate the similarity assumptions
    here.

  - Technically, in a *very* narrow case this might give slightly
    different results for rename detection.  Using the example above,
    if:
      * E:oldfile had 20 lines
      * G:newfile added 10 new lines at the beginning of the file
      * A:oldfile deleted all but the first three lines of the file
    then
      => A':newfile would have 13 lines, 3 of which matches those
         in A:oldfile.

    Consider the two cases:
      * Without this optimization:
        - the next step of the rebase operation (moving B to B')
          would not detect the rename betwen A:oldfile and A':newfile
        - we'd thus get a modify/delete conflict with the rebase
          operation halting for the user to resolve, and have both
          A':newfile and B:oldfile sitting in the working tree.
      * With this optimization:
        - the rename between A:oldfile and A':newfile would be detected
          via the cache of renames
        - a three-way merge between A:oldfile, A':newfile, and B:oldfile
          would commence and be written to A':newfile

    Now, is the difference in behavior a bug...or a bugfix?  I can't
    tell.  Given that A:oldfile and A':newfile are not very similar,
    when we three-way merge with B:oldfile it seems likely we'll hit a
    conflict for the user to resolve.  And it shouldn't be too hard for
    users to see why we did that three-way merge; oldfile and newfile
    *were* renames somewhere in the sequence.  So, most of these corner
    cases will still behave similarly -- namely, a conflict given to the
    user to resolve.  Also, consider the interesting case when commit B
    is a clean revert of commit A.  Without this optimization, a rebase
    could not both apply a weird patch like A and then immediately
    revert it; users would be forced to resolve merge conflicts.  With
    this optimization, it would successfully apply the clean revert.
    So, there is certainly at least one case that behaves better.  Even
    if it's considered a "difference in behavior", I think both behaviors
    are reasonable, and the time savings provided by this optimization
    justify using the slightly altered rename heuristics.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 5523fc9e86b3..a342cc6344fd 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -140,6 +140,30 @@ struct rename_info {
 	int callback_data_nr, callback_data_alloc;
 	char *callback_data_traverse_path;
 
+	/*
+	 * merge_trees: trees passed to the merge algorithm for the merge
+	 *
+	 * merge_trees records the trees passed to the merge algorithm.  But,
+	 * this data also is stored in merge_result->priv.  If a sequence of
+	 * merges are being done (such as when cherry-picking or rebasing),
+	 * the next merge can look at this and re-use information from
+	 * previous merges under certain cirumstances.
+	 *
+	 * See also all the cached_* variables.
+	 */
+	struct tree *merge_trees[3];
+
+	/*
+	 * cached_pairs_valid_side: which side's cached info can be reused
+	 *
+	 * See the description for merge_trees.  For repeated merges, at most
+	 * only one side's cached information can be used.  Valid values:
+	 *   MERGE_SIDE2: cached data from side2 can be reused
+	 *   MERGE_SIDE1: cached data from side1 can be reused
+	 *   0:           no cached data can be reused
+	 */
+	int cached_pairs_valid_side;
+
 	/*
 	 * cached_pairs: Caching of renames and deletions.
 	 *
@@ -462,6 +486,8 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 		strmap_func(&renames->cached_pairs[i], 1);
 		strset_func(&renames->cached_irrelevant[i]);
 	}
+	renames->cached_pairs_valid_side = 0;
+	renames->dir_rename_mask = 0;
 
 	if (!reinitialize) {
 		struct hashmap_iter iter;
@@ -484,8 +510,6 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 		strmap_clear(&opti->output, 0);
 	}
 
-	renames->dir_rename_mask = 0;
-
 	/* Clean out callback_data as well. */
 	FREE_AND_NULL(renames->callback_data);
 	renames->callback_data_nr = renames->callback_data_alloc = 0;
@@ -3802,6 +3826,35 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 	trace2_region_leave("merge", "allocate/init", opt->repo);
 }
 
+static void merge_check_renames_reusable(struct merge_options *opt,
+					 struct merge_result *result,
+					 struct tree *merge_base,
+					 struct tree *side1,
+					 struct tree *side2)
+{
+	struct rename_info *renames;
+	struct tree **merge_trees;
+	struct merge_options_internal *opti = result->priv;
+
+	if (!opti)
+		return;
+
+	renames = &opti->renames;
+	merge_trees = renames->merge_trees;
+	/* merge_trees[0..2] will only be NULL if opti is */
+	assert(merge_trees[0] && merge_trees[1] && merge_trees[2]);
+
+	/* Check if we meet a condition for re-using cached_pairs */
+	if (     oideq(&merge_base->object.oid, &merge_trees[2]->object.oid) &&
+		 oideq(     &side1->object.oid, &result->tree->object.oid))
+		renames->cached_pairs_valid_side = MERGE_SIDE1;
+	else if (oideq(&merge_base->object.oid, &merge_trees[1]->object.oid) &&
+		 oideq(     &side2->object.oid, &result->tree->object.oid))
+		renames->cached_pairs_valid_side = MERGE_SIDE2;
+	else
+		renames->cached_pairs_valid_side = 0; /* neither side valid */
+}
+
 /*** Function Grouping: merge_incore_*() and their internal variants ***/
 
 /*
@@ -3949,7 +4002,16 @@ void merge_incore_nonrecursive(struct merge_options *opt,
 
 	trace2_region_enter("merge", "merge_start", opt->repo);
 	assert(opt->ancestor != NULL);
+	merge_check_renames_reusable(opt, result, merge_base, side1, side2);
 	merge_start(opt, result);
+	/*
+	 * Record the trees used in this merge, so if there's a next merge in
+	 * a cherry-pick or rebase sequence it might be able to take advantage
+	 * of the cached_pairs in that next merge.
+	 */
+	opt->priv->renames.merge_trees[0] = merge_base;
+	opt->priv->renames.merge_trees[1] = side1;
+	opt->priv->renames.merge_trees[2] = side2;
 	trace2_region_leave("merge", "merge_start", opt->repo);
 
 	merge_ort_nonrecursive_internal(opt, merge_base, side1, side2, result);
-- 
gitgitgadget

