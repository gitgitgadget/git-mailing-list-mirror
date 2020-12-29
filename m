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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7915C433E6
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 20:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A209021D1B
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 20:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgL2UG2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 15:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgL2UGY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 15:06:24 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0098AC06179E
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 12:05:38 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 190so3368352wmz.0
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 12:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WaJHuUi1VRAEs4Q9bzkYu+RL2+OdKIl0dfAFTIDEIMU=;
        b=b2hG4l3OgfyrMtPCf5Ba9k/PWHDDjTP4a0H/Zqwnnn4ebeLCs0k5bnYxdZSmQiZvoT
         5i5a8zSGFftft8lBUerMfgUKwMBgOUIreCs/qXcDIomoFfFdwf5KsIOmMtn8vSVBU7lU
         +JV2R/kqpHpjfpUmIl8RhCCekwXuWd4QGummzlrTjtDBtXXd2A2WNYfZZp08dmyD93Ee
         WbgbvnLtpnDK5rq36MwVxTudEkfWw5Kz0sRFk+6X2csvYZCI3L/52C5MdZQxf5HM3lRf
         l8SwMtsk52vST1S3iNXjHa2FWfLRLAx4qfOeQx/kEVn5cymN9RJwI3c5NbUgtVVcIAPQ
         dplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WaJHuUi1VRAEs4Q9bzkYu+RL2+OdKIl0dfAFTIDEIMU=;
        b=tOUxqHsDFLldYhrFJxUZcygQQ5x6N9CiqpK0hwf42t7TzAOINrs9yPmk9gPUdinnuk
         ejy/GD20A9U+8O3cPscOxIJK3RWwuhGN7BcTvdH/lSxOfsB7KD8YlyO5y/eTnUNG0m1G
         8a0YjejqggfEUN6JhAmiagaA8c2XHicznRSiuyOrQz1YV6fDb+piS9Maxfz5jtM7nCz+
         vSi3DF7ErWVsx7KMWKmsiD5+lT0a6SwSw4mJgyak3Hp0LCZCpetWqcJJMHhBL8nhejXD
         iqrN/HIow2pwv8gSNLGYJDiOrMFSbBHKq2XyqgvhUYbyIF1UFhThiAMsZ0/jNoTaopX/
         A0Yg==
X-Gm-Message-State: AOAM5333SANEbDFIOBUYSQS7zMUThNZqIizPb7M9gu6C5fDiIXWcrLKL
        /r33EIYLbHLv6SwMABK1jYHUoTP4LMs=
X-Google-Smtp-Source: ABdhPJyrBJd83CayPx+JkKVBO2kxs7O/qQwbfHavEoRderdO1x/+sAAzaMhSxyDPAllR4bbiEuWjLg==
X-Received: by 2002:a7b:cf0d:: with SMTP id l13mr4862220wmg.168.1609272337193;
        Tue, 29 Dec 2020 12:05:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r13sm62606310wrt.10.2020.12.29.12.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 12:05:36 -0800 (PST)
Message-Id: <85714e1583d8c47858e6efd2d5c63bdcca748a25.1609272328.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.v3.git.git.1609272328.gitgitgadget@gmail.com>
References: <pull.929.v2.git.git.1607677728.gitgitgadget@gmail.com>
        <pull.929.v3.git.git.1609272328.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Dec 2020 20:05:27 +0000
Subject: [PATCH v3 8/9] diffcore-rename: accelerate rename_dst setup
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

register_rename_src() simply references the passed pair inside
rename_src.  In contrast, add_rename_dst() did something entirely
different for rename_dst.  Instead of copying the passed pair, it made a
copy of the second diff_filespec from the passed pair, referenced it,
and then set the diff_rename_dst.pair field to NULL.  Later, when a
pairing is found, record_rename_pair() allocated a full diff_filepair
via diff_queue() and pointed its src and dst fields at the appropriate
diff_filespecs.  This contrast between register_rename_src() for the
rename_src data structure and add_rename_dst() for the rename_dst data
structure is oddly inconsistent and requires more memory and work than
necessary.  Let's just reference the original diff_filepair in
rename_dst as-is, just as we do with rename_src.  Add a new
rename_dst.is_rename field, since the rename_dst.p field is never NULL
unlike the old rename_dst.pair field.

Taking advantage of this change and the fact that same-named paths will
be adjacent, we can get rid of the sorting of the array and most of the
lookups on it, allowing us to instead just append as we go.  However,
there is one remaining reason to still keep locate_rename_dst():
handling broken pairs (i.e. when break detection is on).  Those are
somewhat rare, but we can set up a simple strintmap to get the map
between the source and the index.  Doing that allows us to still have a
fast lookup without sorting the rename_dst array.  Since the sorting had
been done in a weakly quadratic manner, when many renames are involved
this time could add up.

There is still a strcmp() in add_rename_dst() that I have left in place
to make it easier to verify that the algorithm has the same results.
This strcmp() is there to check for duplicate destination entries (which
was the easiest way at the time to avoid segfaults in the
diffcore-rename code when trees had multiple entries at a given path).
The underlying double free()s are no longer an issue with the new
algorithm, but that can be addressed in a subsequent commit.

This patch is being submitted in a different order than its original
development, but in a large rebase of many commits with lots of renames
and with several optimizations to inexact rename detection, both setup
time and write back to output queue time from diffcore_rename() were
sizeable chunks of overall runtime.  This patch accelerated the setup
time by about 65%, and final write back to the output queue time by
about 50%, resulting in an overall drop of 3.5% on the execution time of
rebasing a few dozen patches.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 148 ++++++++++++++++++++--------------------------
 1 file changed, 65 insertions(+), 83 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index a215421a9cb..2a8fcd52928 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -9,63 +9,48 @@
 #include "hashmap.h"
 #include "progress.h"
 #include "promisor-remote.h"
+#include "strmap.h"
 
 /* Table of rename/copy destinations */
 
 static struct diff_rename_dst {
-	struct diff_filespec *two;
-	struct diff_filepair *pair;
+	struct diff_filepair *p;
+	struct diff_filespec *filespec_to_free;
+	int is_rename; /* false -> just a create; true -> rename or copy */
 } *rename_dst;
 static int rename_dst_nr, rename_dst_alloc;
+/* Mapping from break source pathname to break destination index */
+static struct strintmap *break_idx = NULL;
 
-static int find_rename_dst(struct diff_filespec *two)
-{
-	int first, last;
-
-	first = 0;
-	last = rename_dst_nr;
-	while (last > first) {
-		int next = first + ((last - first) >> 1);
-		struct diff_rename_dst *dst = &(rename_dst[next]);
-		int cmp = strcmp(two->path, dst->two->path);
-		if (!cmp)
-			return next;
-		if (cmp < 0) {
-			last = next;
-			continue;
-		}
-		first = next+1;
-	}
-	return -first - 1;
-}
-
-static struct diff_rename_dst *locate_rename_dst(struct diff_filespec *two)
+static struct diff_rename_dst *locate_rename_dst(struct diff_filepair *p)
 {
-	int ofs = find_rename_dst(two);
-	return ofs < 0 ? NULL : &rename_dst[ofs];
+	/* Lookup by p->ONE->path */
+	int idx = break_idx ? strintmap_get(break_idx, p->one->path) : -1;
+	return (idx == -1) ? NULL : &rename_dst[idx];
 }
 
 /*
  * Returns 0 on success, -1 if we found a duplicate.
  */
-static int add_rename_dst(struct diff_filespec *two)
+static int add_rename_dst(struct diff_filepair *p)
 {
-	int first = find_rename_dst(two);
-
-	if (first >= 0)
+	/*
+	 * If we have multiple entries at the same path in the destination
+	 * tree (an invalid tree, to be sure), turn off rename detection
+	 * entirely.  Once upon a time, diffcore-rename had double free()
+	 * issues due to such duplicate paths, resulting in segfaults.  See
+	 * commit 4d6be03b95 ("diffcore-rename: avoid processing duplicate
+	 * destinations", 2015-02-26).
+	 */
+	if (rename_dst_nr > 0 &&
+	    !strcmp(rename_dst[rename_dst_nr-1].p->two->path, p->two->path))
 		return -1;
-	first = -first - 1;
 
-	/* insert to make it at "first" */
 	ALLOC_GROW(rename_dst, rename_dst_nr + 1, rename_dst_alloc);
+	rename_dst[rename_dst_nr].p = p;
+	rename_dst[rename_dst_nr].filespec_to_free = NULL;
+	rename_dst[rename_dst_nr].is_rename = 0;
 	rename_dst_nr++;
-	if (first < rename_dst_nr)
-		MOVE_ARRAY(rename_dst + first + 1, rename_dst + first,
-			   rename_dst_nr - first - 1);
-	rename_dst[first].two = alloc_filespec(two->path);
-	fill_filespec(rename_dst[first].two, &two->oid, two->oid_valid,
-		      two->mode);
-	rename_dst[first].pair = NULL;
 	return 0;
 }
 
@@ -89,6 +74,14 @@ static void register_rename_src(struct diff_filepair *p)
 	    !strcmp(rename_src[rename_src_nr-1].p->one->path, p->one->path))
 		return;
 
+	if (p->broken_pair) {
+		if (!break_idx) {
+			break_idx = xmalloc(sizeof(*break_idx));
+			strintmap_init(break_idx, -1);
+		}
+		strintmap_set(break_idx, p->one->path, rename_dst_nr);
+	}
+
 	ALLOC_GROW(rename_src, rename_src_nr + 1, rename_src_alloc);
 	rename_src[rename_src_nr].p = p;
 	rename_src[rename_src_nr].score = p->score;
@@ -128,14 +121,14 @@ static void prefetch(void *prefetch_options)
 	struct oid_array to_fetch = OID_ARRAY_INIT;
 
 	for (i = 0; i < rename_dst_nr; i++) {
-		if (rename_dst[i].pair)
+		if (rename_dst[i].p->renamed_pair)
 			/*
 			 * The loop in diffcore_rename() will not need these
 			 * blobs, so skip prefetching.
 			 */
 			continue; /* already found exact match */
 		diff_add_if_missing(options->repo, &to_fetch,
-				    rename_dst[i].two);
+				    rename_dst[i].p->two);
 	}
 	for (i = 0; i < rename_src_nr; i++) {
 		if (options->skip_unmodified &&
@@ -245,26 +238,24 @@ static int estimate_similarity(struct repository *r,
 
 static void record_rename_pair(int dst_index, int src_index, int score)
 {
-	struct diff_filespec *src, *dst;
-	struct diff_filepair *dp;
+	struct diff_filepair *src = rename_src[src_index].p;
+	struct diff_filepair *dst = rename_dst[dst_index].p;
 
-	if (rename_dst[dst_index].pair)
+	if (dst->renamed_pair)
 		die("internal error: dst already matched.");
 
-	src = rename_src[src_index].p->one;
-	src->rename_used++;
-	src->count++;
+	src->one->rename_used++;
+	src->one->count++;
 
-	dst = rename_dst[dst_index].two;
-	dst->count++;
+	rename_dst[dst_index].filespec_to_free = dst->one;
+	rename_dst[dst_index].is_rename = 1;
 
-	dp = diff_queue(NULL, src, dst);
-	dp->renamed_pair = 1;
-	if (!strcmp(src->path, dst->path))
-		dp->score = rename_src[src_index].score;
+	dst->one = src->one;
+	dst->renamed_pair = 1;
+	if (!strcmp(dst->one->path, dst->two->path))
+		dst->score = rename_src[src_index].score;
 	else
-		dp->score = score;
-	rename_dst[dst_index].pair = dp;
+		dst->score = score;
 }
 
 /*
@@ -310,7 +301,7 @@ static int find_identical_files(struct hashmap *srcs,
 				struct diff_options *options)
 {
 	int renames = 0;
-	struct diff_filespec *target = rename_dst[dst_index].two;
+	struct diff_filespec *target = rename_dst[dst_index].p->two;
 	struct file_similarity *p, *best = NULL;
 	int i = 100, best_score = -1;
 	unsigned int hash = hash_filespec(options->repo, target);
@@ -476,7 +467,7 @@ static int find_renames(struct diff_score *mx, int dst_cnt, int minimum_score, i
 		    (mx[i].score < minimum_score))
 			break; /* there is no more usable pair. */
 		dst = &rename_dst[mx[i].dst];
-		if (dst->pair)
+		if (dst->is_rename)
 			continue; /* already done, either exact or fuzzy. */
 		if (!copies && rename_src[mx[i].src].p->one->rename_used)
 			continue;
@@ -511,7 +502,7 @@ void diffcore_rename(struct diff_options *options)
 			else if (!options->flags.rename_empty &&
 				 is_empty_blob_oid(&p->two->oid))
 				continue;
-			else if (add_rename_dst(p->two) < 0) {
+			else if (add_rename_dst(p) < 0) {
 				warning("skipping rename detection, detected"
 					" duplicate destination '%s'",
 					p->two->path);
@@ -586,10 +577,10 @@ void diffcore_rename(struct diff_options *options)
 	mx = xcalloc(st_mult(NUM_CANDIDATE_PER_DST, num_destinations),
 		     sizeof(*mx));
 	for (dst_cnt = i = 0; i < rename_dst_nr; i++) {
-		struct diff_filespec *two = rename_dst[i].two;
+		struct diff_filespec *two = rename_dst[i].p->two;
 		struct diff_score *m;
 
-		if (rename_dst[i].pair)
+		if (rename_dst[i].is_rename)
 			continue; /* dealt with exact match already. */
 
 		m = &mx[dst_cnt * NUM_CANDIDATE_PER_DST];
@@ -646,22 +637,8 @@ void diffcore_rename(struct diff_options *options)
 			diff_q(&outq, p);
 		}
 		else if (!DIFF_FILE_VALID(p->one) && DIFF_FILE_VALID(p->two)) {
-			/*
-			 * Creation
-			 *
-			 * We would output this create record if it has
-			 * not been turned into a rename/copy already.
-			 */
-			struct diff_rename_dst *dst = locate_rename_dst(p->two);
-			if (dst && dst->pair) {
-				diff_q(&outq, dst->pair);
-				pair_to_free = p;
-			}
-			else
-				/* no matching rename/copy source, so
-				 * record this as a creation.
-				 */
-				diff_q(&outq, p);
+			/* Creation */
+			diff_q(&outq, p);
 		}
 		else if (DIFF_FILE_VALID(p->one) && !DIFF_FILE_VALID(p->two)) {
 			/*
@@ -682,8 +659,10 @@ void diffcore_rename(struct diff_options *options)
 			 */
 			if (DIFF_PAIR_BROKEN(p)) {
 				/* broken delete */
-				struct diff_rename_dst *dst = locate_rename_dst(p->one);
-				if (dst && dst->pair)
+				struct diff_rename_dst *dst = locate_rename_dst(p);
+				if (!dst)
+					BUG("tracking failed somehow; failed to find associated dst for broken pair");
+				if (dst->is_rename)
 					/* counterpart is now rename/copy */
 					pair_to_free = p;
 			}
@@ -693,16 +672,14 @@ void diffcore_rename(struct diff_options *options)
 					pair_to_free = p;
 			}
 
-			if (pair_to_free)
-				;
-			else
+			if (!pair_to_free)
 				diff_q(&outq, p);
 		}
 		else if (!diff_unmodified_pair(p))
 			/* all the usual ones need to be kept */
 			diff_q(&outq, p);
 		else
-			/* no need to keep unmodified pairs */
+			/* no need to keep unmodified pairs; FIXME: remove earlier? */
 			pair_to_free = p;
 
 		if (pair_to_free)
@@ -715,11 +692,16 @@ void diffcore_rename(struct diff_options *options)
 	diff_debug_queue("done collapsing", q);
 
 	for (i = 0; i < rename_dst_nr; i++)
-		free_filespec(rename_dst[i].two);
+		if (rename_dst[i].filespec_to_free)
+			free_filespec(rename_dst[i].filespec_to_free);
 
 	FREE_AND_NULL(rename_dst);
 	rename_dst_nr = rename_dst_alloc = 0;
 	FREE_AND_NULL(rename_src);
 	rename_src_nr = rename_src_alloc = 0;
+	if (break_idx) {
+		strintmap_clear(break_idx);
+		FREE_AND_NULL(break_idx);
+	}
 	return;
 }
-- 
gitgitgadget

