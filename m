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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417C8C11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 03:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FFF86144F
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 03:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbhGADs5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 23:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbhGADsx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 23:48:53 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F4CC0617AE
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 20:46:22 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id j34so3446211wms.5
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 20:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pR0h5LFWhviNFphByFwqYkm2jiu1RUK/t+Oni4vKV4Y=;
        b=gFeS1pLzvRrN02xqEuB4/oKRicgcVw1Y7Vi5vJK55qGyZSqAANY8oXDZr/rOJ0pd0v
         +KmawxzAQstgIdrADUGidhCk35Eow4O0BUiLA5G+byBkFBctcWjZEpOquSFuNPXzbu6B
         br+XlZGcLfyA+Gu9Np66ZgO/kGJgLNSpwe8obcGe9UXZ9+5hOmadYXivElM2gWWCh1oQ
         dglgakn2TtLxmqPr32IBd4t5h9EplD2VeMHN4zXMuvgH5DTh8HZfH2+3LqSTxXeYjsAT
         GMSZ35MhHErlHVn1bbhpAn3B7QggviDHYDgJDgoUeXhuWaUPC1qnV7VVXCLwkMTjz4KT
         Y4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pR0h5LFWhviNFphByFwqYkm2jiu1RUK/t+Oni4vKV4Y=;
        b=tIkPiAVV8zi5GBRHPnleq9Ryagkp8d7cFvXg7JFMTnAxmK1vBhuUsuafeYkN7ez4dD
         XsmZKB6vAbUbh84aRmCQyN2k617Qk22+cDDaIGewjDdLYIQTOOwQ3D0lMZ/qsPfDknS5
         pT2vSiRTFjSFdqIZo82ZK5+sGmtt04yV+JbL2VbRkgkvO5mX0+5b7K0sVAyZFzj1Dqdg
         OQnR/4wLFSxur6aATjJGmtPQY5bzpbzAXY6It8PGT9OAFAHEf86vd1B+dGOyHu0kA6e8
         g9h7Nwo35HQJ9pXwMlFFJ/zjxdCyq7oNd+mCwGq3rYUISfnAshmv1e7rhy4baZvL/px3
         46CA==
X-Gm-Message-State: AOAM533KmOEW0uN61wyzSCT7HeKYMv76Q6rhVyiwucrz4lEYIifnVCte
        XY/s3ei4zvd6KyMf4pbz9Fzj/xENuqw=
X-Google-Smtp-Source: ABdhPJwsDzXh04DiKagtjpN/TBY5J7b3ISL/hn2asoJBcYpF57EPhL5+px/0hkXDiE+Iksh190LAVg==
X-Received: by 2002:a05:600c:296:: with SMTP id 22mr7790983wmk.17.1625111180511;
        Wed, 30 Jun 2021 20:46:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s1sm8029216wmj.8.2021.06.30.20.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 20:46:20 -0700 (PDT)
Message-Id: <f7ac01055d9d2e9e2dfdfd780ff7f10fbfd05d5b.1625111177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.988.git.1625111177.gitgitgadget@gmail.com>
References: <pull.988.git.1625111177.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 03:46:13 +0000
Subject: [PATCH 3/7] merge-ort: add data structures for allowable trivial
 directory resolves
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

As noted a few commits ago, we can resolve individual files early if all
three sides of the merge have a file at the path and two of the three
sides match.  We would really like to do the same thing with
directories, because being able to do a trivial directory resolve means
we don't have to recurse into the directory, potentially saving us a
huge amount of time in both collect_merge_info() and process_entries().
Unfortunately, resolving directories early would mean missing any
renames whose source or destination is underneath that directory.

If we somehow knew there weren't any renames under the directory in
question, then we could resolve it early.  Sadly, it is impossible to
determine whether there are renames under the directory in question
without recursing into it, and this has traditionally kept us from ever
implementing such an optimization.

In commit f89b4f2bee ("merge-ort: skip rename detection entirely if
possible", 2021-03-11), we added an additional reason that rename
detection could be skipped entirely -- namely, if no *relevant* sources
were present.  Without completing collect_merge_info_callback(), we do
not yet know if there are no relevant sources.  However, we do know that
if the current directory on one side matches the merge base, then every
source file within that directory will not be RELEVANT_CONTENT, and a
few simple checks can often let us rule out RELEVANT_LOCATION as well.
This suggests we can just defer recursing into such directories until
the end of collect_merge_info.

Since the deferred directories are known to not add any relevant sources
due to the above properties, then if there are no relevant sources after
we've traversed all paths other than the deferred ones, then we know
there are not any relevant sources.  Under those conditions, rename
detection is unnecessary, and that means we can resolve the deferred
directories without recursing into them.

Note that the logic for skipping rename detection was also modified
further in commit 76e253793c ("merge-ort, diffcore-rename: employ cached
renames when possible", 2021-01-30); in particular rename detection can
be skipped if we already have cached renames for each relevant source.
We can take advantage of this information as well with our deferral of
recursing into directories where one side matches the merge base.

Add some data structures that we will use to do these deferrals, with
some lengthy comments explaining their purpose.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 843fa693145..3d3f00b3b45 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -119,6 +119,51 @@ struct rename_info {
 	 */
 	struct strintmap relevant_sources[3];
 
+	/*
+	 * possible_trivial_merges: directories we defer recursing into
+	 *
+	 * possible_trivial_merges is a map of directory names to
+	 * dir_rename_mask.  When we detect that a directory is unchanged on
+	 * one side, we can sometimes resolve the directory without recursing
+	 * into it.  Renames are the only things that can prevent such an
+	 * optimization.  However, for rename sources:
+	 *   - If no parent directory needed directory rename detection, then
+	 *     no path under such a directory can be a relevant_source.
+	 * and for rename destinations:
+	 *   - If no cached rename has a target path under the directory AND
+	 *   - If there are no unpaired relevant_sources elsewhere in the
+	 *     repository
+	 * then we don't need any path under this directory for a rename
+	 * destination.  The only way to know the last item above is to defer
+	 * handling such directories until the end of collect_merge_info(),
+	 * in handle_deferred_entries().
+	 *
+	 * For each we store dir_rename_mask, since that's the only bit of
+	 * information we need, other than the path, to resume the recursive
+	 * traversal.
+	 */
+	struct strintmap possible_trivial_merges[3];
+
+	/*
+	 * trivial_merges_okay: if trivial directory merges are okay
+	 *
+	 * See possible_trivial_merges above.  The "no unpaired
+	 * relevant_sources elsewhere in the repository" is a single boolean
+	 * per merge side, which we store here.  Note that while 0 means no,
+	 * 1 only means "maybe" rather than "yes"; we optimistically set it
+	 * to 1 initially and only clear when we determine it is unsafe to
+	 * do trivial directory merges.
+	 */
+	unsigned trivial_merges_okay[3];
+
+	/*
+	 * target_dirs: ancestor directories of rename targets
+	 *
+	 * target_dirs contains all directory names that are an ancestor of
+	 * any rename destination.
+	 */
+	struct strset target_dirs[3];
+
 	/*
 	 * dir_rename_mask:
 	 *   0: optimization removing unmodified potential rename source okay
@@ -490,6 +535,9 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 		strintmap_func(&renames->dirs_removed[i]);
 		strmap_func(&renames->dir_renames[i], 0);
 		strintmap_func(&renames->relevant_sources[i]);
+		strintmap_func(&renames->possible_trivial_merges[i]);
+		strset_func(&renames->target_dirs[i]);
+		renames->trivial_merges_okay[i] = 1; /* 1 == maybe */
 		if (!reinitialize)
 			assert(renames->cached_pairs_valid_side == 0);
 		if (i != renames->cached_pairs_valid_side) {
@@ -4045,12 +4093,17 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 		strintmap_init_with_options(&renames->relevant_sources[i],
 					    -1 /* explicitly invalid */,
 					    NULL, 0);
+		strintmap_init_with_options(&renames->possible_trivial_merges[i],
+					    0, NULL, 0);
+		strset_init_with_options(&renames->target_dirs[i],
+					 NULL, 1);
 		strmap_init_with_options(&renames->cached_pairs[i],
 					 NULL, 1);
 		strset_init_with_options(&renames->cached_irrelevant[i],
 					 NULL, 1);
 		strset_init_with_options(&renames->cached_target_names[i],
 					 NULL, 0);
+		renames->trivial_merges_okay[i] = 1; /* 1 == maybe */
 	}
 
 	/*
-- 
gitgitgadget

