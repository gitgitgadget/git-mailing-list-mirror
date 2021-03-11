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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FABEC433E6
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 00:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0CF464FCA
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 00:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhCKAit (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 19:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhCKAif (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 19:38:35 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF86C061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 16:38:35 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v15so25364491wrx.4
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 16:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OoGVy7XI/LiOyejMW1pDhlCHg7nAygWY1bt1LdPodSI=;
        b=WPCXryaoz24sN84gxp3fUMWP5D2jAsnUfUGWOtRek7/sJKl4hQjRVxnLAZPtc+IEWw
         sEaWy//YqP08FMooXiaj5T29FL2dny8yKYZCeNkDQEn5zTL7kuV6KtO50zYfmpeS4h1c
         n+LV5gRyu4oQRPoy3kfL9Qd5gm7UjvmZXCIQs8155qlfvsZGgpweaqMvpR3d98f36ZQW
         Y6Oc640yZ7lQbbWovArIKqyR1lbGK1TA97nMiElzd4GLDIAQPQqf2duwiG5yVZnj3mHO
         4LbYNhJ1PzD0Z8mKkIA52jOv+d34Hp7Htnj7FomWnQd3c/LtvGbSG/LRmB52NqMWLLJe
         oF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OoGVy7XI/LiOyejMW1pDhlCHg7nAygWY1bt1LdPodSI=;
        b=Cjm/DdpMeELCmfHBBI9PcqnhAWIZCB2WSSsOYtkAjLcgBqf9f/56NT7ytHNq05aX4Q
         fqPn4tYoSWToBatDMutj6hJDuZytJmnRrzsK+MM/a8qikw+uxhubRD/ZzAJPgJvhkKu6
         vGMGWrvOOXJ14pLvlskyP5aottb8e22ykyWcNNkD9PMQF7NjgvGCzmJFDHuUdHMY+hQQ
         j1zt7/mc2dwUpysRGhGFVjT0NnPLkOwwYsFeRc45/l137RM1QVgoP7j5Q+489uL4HqYZ
         7dWEy48bitLyghne4lzdl0O2ylGVfKRb3UUeFavzWPl6tlQ5jORl5FbzO5v/B01Hsj1w
         DQkw==
X-Gm-Message-State: AOAM531yeHzaVnM0Ez+26RVeHC7QRUyW7aSNHClR+3N966Doc802daUH
        WfNA/iG39bgtBU4d9eD4Q6pUqjtiebI=
X-Google-Smtp-Source: ABdhPJxCppzrLv/X5jLneV8b8TzuY1l0B5XR045390Lh5mHYMs81z4+t/1UG2AO1IwxnuAQGCm3PAQ==
X-Received: by 2002:adf:b1c9:: with SMTP id r9mr6154312wra.51.1615423114039;
        Wed, 10 Mar 2021 16:38:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y1sm1044591wmq.29.2021.03.10.16.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 16:38:33 -0800 (PST)
Message-Id: <d8378b3dde6c28e70f24c689bbfac6abe731f9cf.1615423111.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.845.v3.git.1615423111.gitgitgadget@gmail.com>
References: <pull.845.v2.git.1615248599.gitgitgadget@gmail.com>
        <pull.845.v3.git.1615423111.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 Mar 2021 00:38:25 +0000
Subject: [PATCH v3 2/8] merge-ort: precompute subset of sources for which we
 need rename detection
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
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

Add a simple testcase showing the two kinds of reasons renames are
relevant; it's a testcase that will only pass if we detect both kinds of
needed renames.

Other than the testcase added above, this commit concentrates just on
the three-way content merging; it will punt and mark all sources as
needed for directory rename detection, and leave it to future commits to
narrow that down more.

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
 merge-ort.c                         | 35 ++++++++++++--
 t/t6423-merge-rename-directories.sh | 71 +++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+), 3 deletions(-)

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
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 4ab133f489ca..4c568050dd27 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -4895,6 +4895,77 @@ test_expect_merge_algorithm failure success '12f: Trivial directory resolve, cac
 	)
 '
 
+# Testcase 12g, Testcase with two kinds of "relevant" renames
+#   Commit O: somefile_O, subdir/{a_O,b_O}
+#   Commit A: somefile_A, subdir/{a_O,b_O,c_A}
+#   Commit B: newfile_B,  newdir/{a_B,b_B}
+#   Expected: newfile_{merged}, newdir/{a_B,b_B,c_A}
+
+test_setup_12g () {
+	test_create_repo 12g &&
+	(
+		cd 12g &&
+
+		mkdir -p subdir &&
+		test_write_lines upon a time there was a >somefile &&
+		test_write_lines 1 2 3 4 5 6 7 8 9 10 >subdir/a &&
+		test_write_lines one two three four five six >subdir/b &&
+		git add . &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git switch A &&
+		test_write_lines once upon a time there was a >somefile &&
+		> subdir/c &&
+		git add somefile subdir/c &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv somefile newfile &&
+		git mv subdir newdir &&
+		echo repo >>newfile &&
+		test_write_lines 1 2 3 4 5 6 7 8 9 10 11 >newdir/a &&
+		test_write_lines one two three four five six seven >newdir/b &&
+		git add newfile newdir &&
+		test_tick &&
+		git commit -m "B"
+	)
+}
+
+test_expect_success '12g: Testcase with two kinds of "relevant" renames' '
+	test_setup_12g &&
+	(
+		cd 12g &&
+
+		git checkout A^0 &&
+
+		git -c merge.directoryRenames=true merge -s recursive B^0 &&
+
+		test_write_lines once upon a time there was a repo >expect &&
+		test_cmp expect newfile &&
+
+		git ls-files -s >out &&
+		test_line_count = 4 out &&
+
+		git rev-parse >actual \
+			HEAD:newdir/a  HEAD:newdir/b   HEAD:newdir/c &&
+		git rev-parse >expect \
+			B:newdir/a     B:newdir/b      A:subdir/c &&
+		test_cmp expect actual &&
+
+		test_must_fail git rev-parse HEAD:subdir/a &&
+		test_must_fail git rev-parse HEAD:subdir/b &&
+		test_must_fail git rev-parse HEAD:subdir/c &&
+		test_path_is_missing subdir/ &&
+		test_path_is_file newdir/c
+	)
+'
+
 ###########################################################################
 # SECTION 13: Checking informational and conflict messages
 #
-- 
gitgitgadget

