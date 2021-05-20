Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF4AC433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 06:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E94F2610CC
	for <git@archiver.kernel.org>; Thu, 20 May 2021 06:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhETGLS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 02:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbhETGLL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 02:11:11 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226EAC061763
        for <git@vger.kernel.org>; Wed, 19 May 2021 23:09:50 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id z19-20020a7bc7d30000b029017521c1fb75so4653268wmk.0
        for <git@vger.kernel.org>; Wed, 19 May 2021 23:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uBR7GSk68qC+di4aEtuOu3ZB2iFda9fDpVwlcnsuNgs=;
        b=NuVq1KvVSgIzufflGJ/xdswXUs2QN2uKXa0P/idpgoK38e5QzvSxEqN4qzqNz7dwaw
         i76vaU97k1kvsZEr9qHWV5+h3Fsal1kFcd+BzQz3bJrKoyP11EtNV3BXUdEuIhSBrIT6
         lUHLrzF5Pnr8ZtGYv46/CzXRDaUiaF79bf2RXn/8BEzf7TaIpW20dJL4AnMmfN0Mh+Xy
         bRtcwznI7hYTanTOBG8V32aTkdYByURFQbcSXw1Gdnm+1TRMs3NkGkTDJgbViVFrD2hi
         VoPbHhyKJU6VvvZ/8b5XUyy2hvtc9OHyzTyLD64Am/hRxykLnlNs2wKNSkO/ebBMcets
         KCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uBR7GSk68qC+di4aEtuOu3ZB2iFda9fDpVwlcnsuNgs=;
        b=go0k0Xiss2vZ3+gssNtQ6gfJw9rqw1GqY7rFkYLt38xy2CxB2CEtWHH08gy0/hBCsc
         6P82o23SOC6mpZunz0ChLVck0czriGCY87mNx8L+4uHbJsriL1Yp6KlMoM51N2KK3lR4
         NOhBS1BPXMEVH0F3bvcHGu8Gd4U9c1ojQ2eGizT8kweTSh6t79Xe8q9FkSxads2cr4rO
         mqQsbn3iuHT1cy/DHvO8WtyO6YdSBdrQjavkmSojo0uo8VCaqkDR/MIJuZ4Rb/7fUl2l
         sPsfnvSOPFMUhzM2R4j0TO4YU1h0RWvzJPLSeqFAPPayZ+pAWk/GBDkyd1HzKGuqf9sT
         CCxA==
X-Gm-Message-State: AOAM531ItH+mNLXadVdMrLWMjMaD+usGeeuXigEVtpFv6SJQLJtGGAxp
        0nG+br2eQRDYCfZYwHshSLeT5GHk8pc=
X-Google-Smtp-Source: ABdhPJzNwjdeQqv6hsNbUNAZMnkRmsr6vT0JFX0itS+VJNtS1qOOzrN1LE97Ty8oyxX+H/GwAEI3dQ==
X-Received: by 2002:a7b:cb04:: with SMTP id u4mr1927533wmj.146.1621490988672;
        Wed, 19 May 2021 23:09:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y2sm9143297wmq.45.2021.05.19.23.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 23:09:48 -0700 (PDT)
Message-Id: <e4a97b1b16ca4e2fe6bdbee2630b3e189fc39a67.1621490982.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.859.v3.git.1621490982.gitgitgadget@gmail.com>
References: <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
        <pull.859.v3.git.1621490982.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 May 2021 06:09:36 +0000
Subject: [PATCH v3 08/13] merge-ort: add code to check for whether cached
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
index da9026524aa5..e08b60a26d20 100644
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
+	 * previous merges under certain circumstances.
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
@@ -473,6 +497,8 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 		strmap_func(&renames->cached_pairs[i], 1);
 		strset_func(&renames->cached_irrelevant[i]);
 	}
+	renames->cached_pairs_valid_side = 0;
+	renames->dir_rename_mask = 0;
 
 	if (!reinitialize) {
 		struct hashmap_iter iter;
@@ -495,8 +521,6 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 		strmap_clear(&opti->output, 0);
 	}
 
-	renames->dir_rename_mask = 0;
-
 	/* Clean out callback_data as well. */
 	FREE_AND_NULL(renames->callback_data);
 	renames->callback_data_nr = renames->callback_data_alloc = 0;
@@ -3816,6 +3840,35 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
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
+	if (oideq(&merge_base->object.oid, &merge_trees[2]->object.oid) &&
+	    oideq(&side1->object.oid, &result->tree->object.oid))
+		renames->cached_pairs_valid_side = MERGE_SIDE1;
+	else if (oideq(&merge_base->object.oid, &merge_trees[1]->object.oid) &&
+		 oideq(&side2->object.oid, &result->tree->object.oid))
+		renames->cached_pairs_valid_side = MERGE_SIDE2;
+	else
+		renames->cached_pairs_valid_side = 0; /* neither side valid */
+}
+
 /*** Function Grouping: merge_incore_*() and their internal variants ***/
 
 /*
@@ -3963,7 +4016,16 @@ void merge_incore_nonrecursive(struct merge_options *opt,
 
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

