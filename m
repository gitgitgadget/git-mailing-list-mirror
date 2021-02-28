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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9C7C433E0
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 03:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ABCE64E38
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 03:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhB1D74 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Feb 2021 22:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhB1D7v (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Feb 2021 22:59:51 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0FCC06178B
        for <git@vger.kernel.org>; Sat, 27 Feb 2021 19:58:32 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id f12so8703653wrx.8
        for <git@vger.kernel.org>; Sat, 27 Feb 2021 19:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eExpm0932XIGGpgZpJYMwF54JEpa10NnV/4dpF0C2CM=;
        b=Rg9S9M3oNkEWTE34iW8nAgZM3qF+tI+cb2kWcxzs9iySytifXc44MPSTGQ+h1d/gm1
         KlAf3yC0yht2GYAB/fIV8d3OaeY6kqB0zh4GIWuO/nppvSPLAU/OnoA7iW6WChPEqEtI
         ZuAGv9X+wKN4IGrunKhdAcpPi1srwRg4X1g8Kq6kRMsDInB1UTnNJdm5TWWKsFKYu0qm
         cecazncip3TCalNrzYf0Xx++88zkc+a7UdMlSTJsHXdl2DhfQ+JFfhE/8MU9FXaQaXHR
         n637e5kQCuBtXSALD8WU97QZLaqhMUNrVyWkRmrLRudKIm0m77hiBO0wWXiHm+VyKByv
         L+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eExpm0932XIGGpgZpJYMwF54JEpa10NnV/4dpF0C2CM=;
        b=fwyPs8Z0dHX5ee6C4XUc0NF6rSrgmUiKwVgudTsdLkGPHW8hr7tUsl60wz4lmqcUZC
         BMcQ/uOW0iiePfEJD85//2eAqU95GcmlMU8+5yU6PVPtHM2F8GxmYiEqUPLs2Jls8Q0e
         NgVnrEL0AZoRkYVZ9ORyHRfNx9GT9KsMDlIqUSO3QPxX//4f8639oofetsMCKZMB5jo6
         FI1l04W0Q41BuCce5PxwLlCVJyzBM34C5xuiqWr493wqzq0Y1UJco98XsKFJLBPn7fXB
         2bNKMwPtqbD+msCO20x1lS3O0R81d0qSN8zIuu/C2sBz5rBgS+KI3iM/GP9Wb0EQ+BL0
         tc3Q==
X-Gm-Message-State: AOAM532wM5Dmrt4C9TVNee5uuvN/ry/CAw/4zgD6s7SOPBimaWq6Nli8
        fp8GNvhbDc58Bz+tW7k3VG3Y3nkUVgs=
X-Google-Smtp-Source: ABdhPJytKAy4CwiwGFNOPdJfATz51VfLUO+HG8zpOY2vfFqL5K9EerIlWpOksvIjOQQiWfT8InzBmQ==
X-Received: by 2002:a5d:620d:: with SMTP id y13mr10232246wru.88.1614484710837;
        Sat, 27 Feb 2021 19:58:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 6sm21092582wra.63.2021.02.27.19.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 19:58:30 -0800 (PST)
Message-Id: <8dbf0a4525453078cf87ee9149d89227d18c96f0.1614484707.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.845.git.1614484707.gitgitgadget@gmail.com>
References: <pull.845.git.1614484707.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 28 Feb 2021 03:58:23 +0000
Subject: [PATCH 5/8] merge-ort: precompute whether directory rename detection
 is needed
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

The point of directory rename detection is that if one side of history
renames a directory, and the other side adds new files under the old
directory, then the merge can move those new files into the new
directory.  This leads to the following important observation:

  * If the other side does not add any new files under the old
    directory, we do not need to detect any renames for that directory.

Similarly, directory rename detection had an important requirement:

  * If a directory still exists on one side of history, it has not been
    renamed on that side of history.  (See section 4 of t6423 or
    Documentation/technical/directory-rename-detection.txt for more
    details).

Using these two bits of information, we note that directory rename
detection is only needed in cases where (1) directories exist in the
merge base and on one side of history (i.e. dirmask == 3 or dirmask ==
5), and (2) where there is some new file added to that directory on the
side where it still exists (thus where the file has filemask == 2 or
filemask == 4, respectively).  This has to be done in two steps, because
we have the dirmask when we are first considering the directory, and
won't get the filemasks for the files within it until we recurse into
that directory.  So, we save
  dir_rename_mask = dirmask - 1
when we hit a directory that is missing on one side, and then later look
for cases of
  filemask == dir_rename_mask

One final note is that as soon as we hit a directory that needs
directory rename detection, we will need to detect renames in all
subdirectories of that directory as well due to the "majority rules"
decision when files are renamed into different directory hierarchies.
We arbitrarily use the special value of 0x07 to record when we've hit
such a directory.

The combination of all the above mean that we introduce a variable
named dir_rename_mask (couldn't think of a better name) which has one
of the following values as we traverse into a directory:
   * 0x00: directory rename detection not needed
   * 0x02 or 0x04: directory rename detection only needed if files added
   * 0x07: directory rename detection definitely needed

We then pass this value through to add_pairs() so that it can mark
location_relevant as true only when dir_rename_mask is 0x07.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 61 insertions(+), 6 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index bd2b93a31141..27acaa7380be 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -108,6 +108,14 @@ struct rename_info {
 	 */
 	struct strset relevant_sources[3];
 
+	/*
+	 * dir_rename_mask:
+	 *   0: optimization removing unmodified potential rename source okay
+	 *   2 or 4: optimization okay, but must check for files added to dir
+	 *   7: optimization forbidden; need rename source in case of dir rename
+	 */
+	unsigned dir_rename_mask:3;
+
 	/*
 	 * callback_data_*: supporting data structures for alternate traversal
 	 *
@@ -419,6 +427,8 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 		strmap_clear(&opti->output, 0);
 	}
 
+	renames->dir_rename_mask = 0;
+
 	/* Clean out callback_data as well. */
 	FREE_AND_NULL(renames->callback_data);
 	renames->callback_data_nr = renames->callback_data_alloc = 0;
@@ -520,12 +530,16 @@ static int traverse_trees_wrapper_callback(int n,
 {
 	struct merge_options *opt = info->data;
 	struct rename_info *renames = &opt->priv->renames;
+	unsigned filemask = mask & ~dirmask;
 
 	assert(n==3);
 
 	if (!renames->callback_data_traverse_path)
 		renames->callback_data_traverse_path = xstrdup(info->traverse_path);
 
+	if (filemask && filemask == renames->dir_rename_mask)
+		renames->dir_rename_mask = 0x07;
+
 	ALLOC_GROW(renames->callback_data, renames->callback_data_nr + 1,
 		   renames->callback_data_alloc);
 	renames->callback_data[renames->callback_data_nr].mask = mask;
@@ -544,7 +558,6 @@ static int traverse_trees_wrapper_callback(int n,
  *     additional details before the "real" traversal
  *   - loop through the saved entries and call the original callback on them
  */
-MAYBE_UNUSED
 static int traverse_trees_wrapper(struct index_state *istate,
 				  int n,
 				  struct tree_desc *t,
@@ -556,6 +569,8 @@ static int traverse_trees_wrapper(struct index_state *istate,
 	struct merge_options *opt = info->data;
 	struct rename_info *renames = &opt->priv->renames;
 
+	assert(renames->dir_rename_mask == 2 || renames->dir_rename_mask == 4);
+
 	old_callback_data_traverse_path = renames->callback_data_traverse_path;
 	old_fn = info->fn;
 	old_offset = renames->callback_data_nr;
@@ -648,7 +663,8 @@ static void add_pair(struct merge_options *opt,
 		     const char *pathname,
 		     unsigned side,
 		     unsigned is_add /* if false, is_delete */,
-		     unsigned match_mask)
+		     unsigned match_mask,
+		     unsigned dir_rename_mask)
 {
 	struct diff_filespec *one, *two;
 	struct rename_info *renames = &opt->priv->renames;
@@ -656,7 +672,7 @@ static void add_pair(struct merge_options *opt,
 
 	if (!is_add) {
 		unsigned content_relevant = (match_mask == 0);
-		unsigned location_relevant = 1; /* FIXME: compute this */
+		unsigned location_relevant = (dir_rename_mask == 0x07);
 
 		if (content_relevant || location_relevant)
 			strset_add(&renames->relevant_sources[side], pathname);
@@ -680,6 +696,36 @@ static void collect_rename_info(struct merge_options *opt,
 	struct rename_info *renames = &opt->priv->renames;
 	unsigned side;
 
+	/*
+	 * Update dir_rename_mask (determines ignore-rename-source validity)
+	 *
+	 * dir_rename_mask helps us keep track of when directory rename
+	 * detection may be relevant.  Basically, whenver a directory is
+	 * removed on one side of history, and a file is added to that
+	 * directory on the other side of history, directory rename
+	 * detection is relevant (meaning we have to detect renames for all
+	 * files within that directory to deduce where the directory
+	 * moved).  Also, whenever a directory needs directory rename
+	 * detection, due to the "majority rules" choice for where to move
+	 * it (see t6423 testcase 1f), we also need to detect renames for
+	 * all files within subdirectories of that directory as well.
+	 *
+	 * Here we haven't looked at files within the directory yet, we are
+	 * just looking at the directory itself.  So, if we aren't yet in
+	 * a case where a parent directory needed directory rename detection
+	 * (i.e. dir_rename_mask != 0x07), and if the directory was removed
+	 * on one side of history, record the mask of the other side of
+	 * history in dir_rename_mask.
+	 */
+	if (renames->dir_rename_mask != 0x07 &&
+	    (dirmask == 3 || dirmask == 5)) {
+		/* simple sanity check */
+		assert(renames->dir_rename_mask == 0 ||
+		       renames->dir_rename_mask == (dirmask & ~1));
+		/* update dir_rename_mask; have it record mask of new side */
+		renames->dir_rename_mask = (dirmask & ~1);
+	}
+
 	/* Update dirs_removed, as needed */
 	if (dirmask == 1 || dirmask == 3 || dirmask == 5) {
 		/* absent_mask = 0x07 - dirmask; sides = absent_mask/2 */
@@ -699,12 +745,14 @@ static void collect_rename_info(struct merge_options *opt,
 		/* Check for deletion on side */
 		if ((filemask & 1) && !(filemask & side_mask))
 			add_pair(opt, names, fullname, side, 0 /* delete */,
-				 match_mask & filemask);
+				 match_mask & filemask,
+				 renames->dir_rename_mask);
 
 		/* Check for addition on side */
 		if (!(filemask & 1) && (filemask & side_mask))
 			add_pair(opt, names, fullname, side, 1 /* add */,
-				 match_mask & filemask);
+				 match_mask & filemask,
+				 renames->dir_rename_mask);
 	}
 }
 
@@ -722,12 +770,14 @@ static int collect_merge_info_callback(int n,
 	 */
 	struct merge_options *opt = info->data;
 	struct merge_options_internal *opti = opt->priv;
+	struct rename_info *renames = &opt->priv->renames;
 	struct string_list_item pi;  /* Path Info */
 	struct conflict_info *ci; /* typed alias to pi.util (which is void*) */
 	struct name_entry *p;
 	size_t len;
 	char *fullpath;
 	const char *dirname = opti->current_dir_name;
+	unsigned prev_dir_rename_mask = renames->dir_rename_mask;
 	unsigned filemask = mask & ~dirmask;
 	unsigned match_mask = 0; /* will be updated below */
 	unsigned mbase_null = !(mask & 1);
@@ -868,8 +918,13 @@ static int collect_merge_info_callback(int n,
 
 		original_dir_name = opti->current_dir_name;
 		opti->current_dir_name = pi.string;
-		ret = traverse_trees(NULL, 3, t, &newinfo);
+		if (renames->dir_rename_mask == 0 ||
+		    renames->dir_rename_mask == 0x07)
+			ret = traverse_trees(NULL, 3, t, &newinfo);
+		else
+			ret = traverse_trees_wrapper(NULL, 3, t, &newinfo);
 		opti->current_dir_name = original_dir_name;
+		renames->dir_rename_mask = prev_dir_rename_mask;
 
 		for (i = MERGE_BASE; i <= MERGE_SIDE2; i++)
 			free(buf[i]);
-- 
gitgitgadget

