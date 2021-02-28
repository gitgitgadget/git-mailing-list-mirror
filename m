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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FD2C433DB
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 03:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 170A664E38
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 03:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhB1D7S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Feb 2021 22:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhB1D7K (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Feb 2021 22:59:10 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A996C061756
        for <git@vger.kernel.org>; Sat, 27 Feb 2021 19:58:30 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id e23so437473wmh.3
        for <git@vger.kernel.org>; Sat, 27 Feb 2021 19:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HfxVlplU/cnoYrBNq0JnG8uKRsCkGyRl+116KdStR84=;
        b=lZkayiStyDXsIkyggVTQbCm0yCpU/rqNcp9g73y7tDPxtnl6lSl+sGa3gqJ8zsGm54
         u6AwmJM1KAiCIkmhKxAzhd38dU3qcIrXhqVWT/sWJrEcX0Kpki9YTjbv+Dk/YMnfKg16
         5NjO25aP4k5nJTM4jNH+R1HF+oKa1GydGYp8tWvlAToei+HQnLWT2p/bwv1UcG9kHblg
         HCmtHzG11AUN7C1U53DXJ2zG3BaGGiWTnKt5LgDp4Q475hYeDWJj+2/y1mwNML6/wJzU
         Nvgf28SIj0zgWJq3xHjeD6i9ulCAm6W7ncakSZkhE2Z+Y78B/q0Mrfqc4KgFoa99SIq4
         ZoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HfxVlplU/cnoYrBNq0JnG8uKRsCkGyRl+116KdStR84=;
        b=AODj1a/LYA9o7RGOqrQMxkkM0/pJ8FhuiMRzx4xqlTfjTO6INqDtWTtcOYSvKBAPnl
         mLnBRDNlqmaQkmZUJeeXMrKFZFMcKrChtWHmNDkX6UAdSlbNqct3Ly/9x9ILHqRW4nex
         aIR7nLOxjbXZ84x9zkuuHi3n5EaMm0dNLX/vVTY5a5P13s8YuEbHt4Pxjb6qErqm8B0R
         OWoYKds459+TeJSfU70FtgWDcP0VToIgxyMOqN5KU5r0TLEAfE37AsOZPO6LxWpUpRT6
         fup2woobrgKwAK7bVXI6YHszJwdXnw7osWPqdvFzXhQYZM4Fhe+2AkHP9E6Pk1evZaL4
         6cTg==
X-Gm-Message-State: AOAM533wIIl+Pi5DFoii4CSVt2wu/8d2Y7SppyaoDrhgI/FEGcYfB562
        kNQ41ScrSI1PYQAjM9TkfUN+gWAbrpU=
X-Google-Smtp-Source: ABdhPJzBb7Tl+2P8vykufuCgM4okGNGJfwCxcWX+3hZWGciLGJ1rSVfVXlkjqH3/iaAXE3ANS7riTw==
X-Received: by 2002:a1c:7301:: with SMTP id d1mr9525798wmb.33.1614484708805;
        Sat, 27 Feb 2021 19:58:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u12sm15754606wmq.38.2021.02.27.19.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 19:58:28 -0800 (PST)
Message-Id: <064fa5de1e20ada3d9b2225d8561f4f6429bdf02.1614484707.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.845.git.1614484707.gitgitgadget@gmail.com>
References: <pull.845.git.1614484707.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 28 Feb 2021 03:58:19 +0000
Subject: [PATCH 1/8] diffcore-rename: enable filtering possible rename sources
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

Add the ability to diffcore_rename_extended() to allow external callers
to declare that they only need renames detected for a subset of source
files, and use that information to skip detecting renames for them.

There are two important pieces to this optimization that may not be
obvious at first glance:

  * We do not require callers to just filter the filepairs out
    to remove the non-relevant sources, because exact rename detection
    is fast and when it finds a match it can remove both a source and a
    destination whereas the relevant_sources filter can only remove a
    source.

  * We need to filter out the source pairs in a preliminary pass instead
    of adding a
       strset_contains(relevant_sources, one->path)
    check within the nested matrix loop.  The reason for that is if we
    have 30k renames, doing 30k * 30k = 900M strset_contains() calls
    becomes extraordinarily expensive and defeats the performance gains
    from this change; we only want to do 30k such calls instead.

If callers pass NULL for relevant_sources, that is special cases to
treat all sources as relevant.  Since all callers currently pass NULL,
this optimization does not yet have any effect.  Subsequent commits will
have merge-ort compute a set of relevant_sources to restrict which
sources we detect renames for, and have merge-ort pass that set of
relevant_sources to diffcore_rename_extended().

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 26 +++++++++++++++++++-------
 diffcore.h        |  1 +
 merge-ort.c       |  1 +
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 1fe902ed2af0..7f6115fd9018 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -991,11 +991,12 @@ static int find_renames(struct diff_score *mx,
 	return count;
 }
 
-static void remove_unneeded_paths_from_src(int detecting_copies)
+static void remove_unneeded_paths_from_src(int detecting_copies,
+					   struct strset *interesting)
 {
 	int i, new_num_src;
 
-	if (detecting_copies)
+	if (detecting_copies && !interesting)
 		return; /* nothing to remove */
 	if (break_idx)
 		return; /* culling incompatible with break detection */
@@ -1022,12 +1023,18 @@ static void remove_unneeded_paths_from_src(int detecting_copies)
 	 *      from rename_src here.
 	 */
 	for (i = 0, new_num_src = 0; i < rename_src_nr; i++) {
+		struct diff_filespec *one = rename_src[i].p->one;
+
 		/*
 		 * renames are stored in rename_dst, so if a rename has
 		 * already been detected using this source, we can just
 		 * remove the source knowing rename_dst has its info.
 		 */
-		if (rename_src[i].p->one->rename_used)
+		if (!detecting_copies && one->rename_used)
+			continue;
+
+		/* If we don't care about the source path, skip it */
+		if (interesting && !strset_contains(interesting, one->path))
 			continue;
 
 		if (new_num_src < i)
@@ -1040,6 +1047,7 @@ static void remove_unneeded_paths_from_src(int detecting_copies)
 }
 
 void diffcore_rename_extended(struct diff_options *options,
+			      struct strset *relevant_sources,
 			      struct strset *dirs_removed,
 			      struct strmap *dir_rename_count)
 {
@@ -1060,6 +1068,8 @@ void diffcore_rename_extended(struct diff_options *options,
 	want_copies = (detect_rename == DIFF_DETECT_COPY);
 	if (dirs_removed && (break_idx || want_copies))
 		BUG("dirs_removed incompatible with break/copy detection");
+	if (break_idx && relevant_sources)
+		BUG("break detection incompatible with source specification");
 	if (!minimum_score)
 		minimum_score = DEFAULT_RENAME_SCORE;
 
@@ -1127,9 +1137,10 @@ void diffcore_rename_extended(struct diff_options *options,
 		/*
 		 * Cull sources:
 		 *   - remove ones corresponding to exact renames
+		 *   - remove ones not found in relevant_sources
 		 */
 		trace2_region_enter("diff", "cull after exact", options->repo);
-		remove_unneeded_paths_from_src(want_copies);
+		remove_unneeded_paths_from_src(want_copies, relevant_sources);
 		trace2_region_leave("diff", "cull after exact", options->repo);
 	} else {
 		/* Determine minimum score to match basenames */
@@ -1148,7 +1159,7 @@ void diffcore_rename_extended(struct diff_options *options,
 		 *   - remove ones involved in renames (found via exact match)
 		 */
 		trace2_region_enter("diff", "cull after exact", options->repo);
-		remove_unneeded_paths_from_src(want_copies);
+		remove_unneeded_paths_from_src(want_copies, NULL);
 		trace2_region_leave("diff", "cull after exact", options->repo);
 
 		/* Preparation for basename-driven matching. */
@@ -1167,9 +1178,10 @@ void diffcore_rename_extended(struct diff_options *options,
 		/*
 		 * Cull sources, again:
 		 *   - remove ones involved in renames (found via basenames)
+		 *   - remove ones not found in relevant_sources
 		 */
 		trace2_region_enter("diff", "cull basename", options->repo);
-		remove_unneeded_paths_from_src(want_copies);
+		remove_unneeded_paths_from_src(want_copies, relevant_sources);
 		trace2_region_leave("diff", "cull basename", options->repo);
 	}
 
@@ -1342,5 +1354,5 @@ void diffcore_rename_extended(struct diff_options *options,
 
 void diffcore_rename(struct diff_options *options)
 {
-	diffcore_rename_extended(options, NULL, NULL);
+	diffcore_rename_extended(options, NULL, NULL, NULL);
 }
diff --git a/diffcore.h b/diffcore.h
index c6ba64abd198..737c93a6cc79 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -166,6 +166,7 @@ void partial_clear_dir_rename_count(struct strmap *dir_rename_count);
 void diffcore_break(struct repository *, int);
 void diffcore_rename(struct diff_options *);
 void diffcore_rename_extended(struct diff_options *options,
+			      struct strset *relevant_sources,
 			      struct strset *dirs_removed,
 			      struct strmap *dir_rename_count);
 void diffcore_merge_broken(void);
diff --git a/merge-ort.c b/merge-ort.c
index 467404cc0a35..aba0b9fa54c3 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2029,6 +2029,7 @@ static void detect_regular_renames(struct merge_options *opt,
 	diff_queued_diff = renames->pairs[side_index];
 	trace2_region_enter("diff", "diffcore_rename", opt->repo);
 	diffcore_rename_extended(&diff_opts,
+				 NULL,
 				 &renames->dirs_removed[side_index],
 				 &renames->dir_rename_count[side_index]);
 	trace2_region_leave("diff", "diffcore_rename", opt->repo);
-- 
gitgitgadget

