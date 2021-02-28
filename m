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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661F5C433E6
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 03:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3016C64E21
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 03:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhB1D70 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Feb 2021 22:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhB1D7L (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Feb 2021 22:59:11 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5C5C061786
        for <git@vger.kernel.org>; Sat, 27 Feb 2021 19:58:30 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id e10so12270435wro.12
        for <git@vger.kernel.org>; Sat, 27 Feb 2021 19:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=epK0IZOqPbqDp9yCjCsz0W5BjBwKPxEN87dSlW9uDUY=;
        b=EDSuLkjv7p7sABhyGb+afWCNj9GmuJ8nUeU09gHu/JcB+9LTVxsh8xtPDGlr3v2qOY
         NPuSKtxJCD9kUNLqCg2hn7crzYKPM9DctMyBd9/QJMJys7XKpQm/AulVBDV/iLlxHI2W
         EQUQZ+j7iiCBlUJdqKAV5evg9yIun5zQfaWl9zg8ECuXi8kRVoZh0YCD0Y0AVTvrpsE8
         neCW9a0lxO8qzkwEegoCL5NQVEInTOp4CrP9xt+nagcpBd5ybPitmwbW16n+WDp215dn
         hfvmB2Dg4wsF736peVXceI/TiYyZCLdsyS4l5QQe8n5zV7LeCQi5p6rtRnes2NkUbMQ7
         FxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=epK0IZOqPbqDp9yCjCsz0W5BjBwKPxEN87dSlW9uDUY=;
        b=kIwkuAJXqThb2A2rRKvZNxv1D5INnj+2/wpmOv7b8Zp20Nv6jcdeYw0Wxld1CnQJqk
         85cZU5M42e2JsNlecXfZIVAhuSlP2sIVOyOocgzEhVstbPjXmu7XYdPIMe8GAB7kpPQG
         1WB9JmYWlE8X76ecENDyRLhesa/VytECdMDYsWJJSMInLKcAQSmyyUDfyqTPekKxYagU
         hYsfu2tmyx5Oc0nWR4XYYJHsnKgMPIYG2+sCN5ADcASkuctEysly1ocgLdE8gUyYgSVG
         SYwme9gebbW1vmH1FpfRHu39Mf2RugaUb2b3dLExMUmNOrpg7ZTNZhR/P56ikSzzBPCi
         wf2g==
X-Gm-Message-State: AOAM5335VyIbk/gDbW7FvQZL7s74sVE3qJAadsWIVTbtV0542GIUmxit
        Y699FF9Ta+ZcR2kfQBvWarThqsQXrXU=
X-Google-Smtp-Source: ABdhPJxKhTT5W2JYhV1KxeyRbeTRQEaosZ9DJNq4zQs0+L9q6ynAvCql8KelVHaIoV+Uu7noEZZKpA==
X-Received: by 2002:adf:b313:: with SMTP id j19mr10009489wrd.188.1614484709360;
        Sat, 27 Feb 2021 19:58:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o9sm18007926wmc.8.2021.02.27.19.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 19:58:29 -0800 (PST)
Message-Id: <69b42a41e83a006408b6f875dd17a0714be5b9ad.1614484707.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.845.git.1614484707.gitgitgadget@gmail.com>
References: <pull.845.git.1614484707.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 28 Feb 2021 03:58:20 +0000
Subject: [PATCH 2/8] merge-ort: precompute subset of sources for which we need
 rename detection
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

rename detection works by trying to pair all file deletions (or
"sources") with all file additions (or "destinations"), checking
similarity, and then marking the sufficiently similar ones as renames.
This can be expensive if there are many sources and destinations on a
given side of history as it results in an N x M comparison matrix.
However, there are many cases where we can compute in advance that
detecting renames for some of the sources provides no useful information
and thus that we can exclude those sources from the matrix.

To see why, first note that the merge machinery uses detected renames in
two ways:

   * directory rename detection: when one side of history renames a
       directory, and the other side of history adds new files to that
       directory, we want to be able to warn the user about the need to
       chose whether those new files stay in the old directory or move
       to the new one.

   * three-way content merging: in order to do three-way content merging
       of files, we need three different file versions.  If one side of
       history renamed a file, then some of the content for the file is
       found under a different path than in the merge base or on the
       other side of history.

This commit concentrates just on the three-way content merging; it will
punt and mark all sources as needed for directory rename detection, and
leave it to future commits to narrow that down more.

The point of three-way content merging is to reconcile changes made on
*both* sides of history.  What if the file wasn't modified on both
sides?  There are two possibilities:

   * If it wasn't modified on the renamed side:
       -> then we get to do exact rename detection, which is cheap.

   * If it wasn't modified on the unrenamed side:
       -> then detection of a rename for that source file is irrelevant

That latter claim might be surprising at first, so let's walk through a
case to show why rename detection for that source file is irrelevant.
Let's use two filenames, old.c & new.c, with the following abbreviated
object ids (and where the value '000000' is used to denote that the file
is missing in that commit):

                 old.c     new.c
   MERGE_BASE:   01d01d    000000
   MERGE_SIDE1:  01d01d    000000
   MERGE_SIDE2:  000000    5e1ec7

If the rename *isn't* detected:
   then old.c looks like it was unmodified on one side and deleted on
   the other and should thus be removed.  new.c looks like a new file we
   should keep as-is.

If the rename *is* detected:
   then a three-way content merge is done.  Since the version of the
   file in MERGE_BASE and MERGE_SIDE1 are identical, the three-way merge
   will produce exactly the version of the file whose abbreviated
   object id is 5e1ec7.  It will record that file at the path new.c,
   while removing old.c from the directory.

Note that these two results are identical -- a single file named 'new.c'
with object id 5e1ec7.  In other words, it doesn't matter if the rename
is detected in the case where the file is unmodified on the unrenamed
side.

Use this information to compute whether we need rename detection for
each source created in add_pair().

It's probably worth noting that there used to be a few other edge or
corner cases besides three-way content merges and directory rename
detection where lack of rename detection could have affected the result,
but those cases actually highlighted where conflict resolution methods
were not consistent with each other.  Fixing those inconsistencies were
thus critically important to enabling this optimization.  That work
involved the following:

 * bringing consistency to add/add, rename/add, and rename/rename
    conflict types, as done back in the topic merged at commit
    ac193e0e0a ("Merge branch 'en/merge-path-collision'", 2019-01-04),
    and further extended in commits 2a7c16c980 ("t6422, t6426: be more
    flexible for add/add conflicts involving renames", 2020-08-10) and
    e8eb99d4a6 ("t642[23]: be more flexible for add/add conflicts
    involving pair renames", 2020-08-10)

  * making rename/delete more consistent with modify/delete
    as done in commits 1f3c9ba707 ("t6425: be more flexible with
    rename/delete conflict messages", 2020-08-10) and 727c75b23f
    ("t6404, t6423: expect improved rename/delete handling in ort
    backend", 2020-10-26)

Since the set of relevant_sources we compute has not yet been narrowed
down for directory rename detection, we do not pass it to
diffcore_rename_extended() yet.  That will be done after subsequent
commits narrow down the list of relevant_sources needed for directory
rename detection reasons.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index aba0b9fa54c3..83aa4c08121f 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -88,6 +88,20 @@ struct rename_info {
 	 */
 	struct strmap dir_renames[3];
 
+	/*
+	 * relevant_sources: deleted paths for which we need rename detection
+	 *
+	 * relevant_sources is a set of deleted paths on each side of
+	 * history for which we need rename detection.  If a path is deleted
+	 * on one side of history, we need to detect if it is part of a
+	 * rename if either
+	 *    * we need to detect renames for an ancestor directory
+	 *    * the file is modified/deleted on the other side of history
+	 * If neither of those are true, we can skip rename detection for
+	 * that path.
+	 */
+	struct strset relevant_sources[3];
+
 	/*
 	 * needed_limit: value needed for inexact rename detection to run
 	 *
@@ -358,6 +372,8 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 			strmap_clear(&renames->dir_rename_count[i], 1);
 
 		strmap_func(&renames->dir_renames[i], 0);
+
+		strset_func(&renames->relevant_sources[i]);
 	}
 
 	if (!reinitialize) {
@@ -533,12 +549,21 @@ static void add_pair(struct merge_options *opt,
 		     struct name_entry *names,
 		     const char *pathname,
 		     unsigned side,
-		     unsigned is_add /* if false, is_delete */)
+		     unsigned is_add /* if false, is_delete */,
+		     unsigned match_mask)
 {
 	struct diff_filespec *one, *two;
 	struct rename_info *renames = &opt->priv->renames;
 	int names_idx = is_add ? side : 0;
 
+	if (!is_add) {
+		unsigned content_relevant = (match_mask == 0);
+		unsigned location_relevant = 1; /* FIXME: compute this */
+
+		if (content_relevant || location_relevant)
+			strset_add(&renames->relevant_sources[side], pathname);
+	}
+
 	one = alloc_filespec(pathname);
 	two = alloc_filespec(pathname);
 	fill_filespec(is_add ? two : one,
@@ -575,11 +600,13 @@ static void collect_rename_info(struct merge_options *opt,
 
 		/* Check for deletion on side */
 		if ((filemask & 1) && !(filemask & side_mask))
-			add_pair(opt, names, fullname, side, 0 /* delete */);
+			add_pair(opt, names, fullname, side, 0 /* delete */,
+				 match_mask & filemask);
 
 		/* Check for addition on side */
 		if (!(filemask & 1) && (filemask & side_mask))
-			add_pair(opt, names, fullname, side, 1 /* add */);
+			add_pair(opt, names, fullname, side, 1 /* add */,
+				 match_mask & filemask);
 	}
 }
 
@@ -3228,6 +3255,8 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 					 NULL, 1);
 		strmap_init_with_options(&renames->dir_renames[i],
 					 NULL, 0);
+		strset_init_with_options(&renames->relevant_sources[i],
+					 NULL, 0);
 	}
 
 	/*
-- 
gitgitgadget

