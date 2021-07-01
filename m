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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699C6C11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 03:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B2186144D
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 03:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbhGADs7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 23:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbhGADsy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 23:48:54 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642F8C061756
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 20:46:23 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id g8-20020a1c9d080000b02901f13dd1672aso3467859wme.0
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 20:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=D/PkCpEbGyhmPUstaGyLqY15IvUcrT8iiGfUOWLjl1M=;
        b=V+lElWpIGTH/ZVG0aePn/NhjUrVwdcGGnnEtdgMc5crdzbilGrLbhVv4E/lA94Tnrg
         auWcbP8a6tH2oZDgqQxw6Uh+OP7oYUVmZr27OAbwMg49jHnJq2edV2qF9Sk/ju/CBaWG
         OA14uhmCRZQ74f+fZP2hP5gBuNSx0b2mfxXeQp+kUE+Sl5RuLybz4nBwQ6Gr2UdWMv+1
         GF9sHBtMpQuJ+C9rBsP/W2pt2YgQqnjJnHm3pJcU2Z3iutMb0RLzAs6SDEY/iVydeR6P
         H9KvYUCwclqzAfNOC0JAbRDRNB2SvhOiwo6caTuGw37Rsf0zXAiiij5K6DuitegTu4RD
         2eNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=D/PkCpEbGyhmPUstaGyLqY15IvUcrT8iiGfUOWLjl1M=;
        b=WlPXUK+gPCEfC3XESMmqpoaR++NvmogKnCFzFTmpUCCgX4WT6YQNxlBDKe2nRZEMx3
         H71qkEQjRHzNDYBLp1o5VWNT5VELq+BPcS9YdWvOAJxP0EWxktqfbypVPDn1x64XldqE
         +f6RVGHMOOeIBfVO7VTuyMQGC6zKFk9RlydAkrEu3wWa3FBk9RnutWfozwdotRjX7XPb
         h2A+f0NYLA6jSpACjhlHsafTFBcsnu02k0qe5YjzDWnP+p8FrJcxfIMtmQiHU8cBGJVU
         XuinpB29G0uLJaVvx4vDtHCEwcCKD2j9+PVlF1IAjfpOBO64SeYns3WeNI8XrkaCLsPO
         SdPQ==
X-Gm-Message-State: AOAM532yQYf/MGpiQOkS4nNEYq1BuPqv3rRUsusummNYJ9M4zToWv4cT
        s1MpNAGOQMaVaCWBiXVfB1os+b1z3Vc=
X-Google-Smtp-Source: ABdhPJzcC2wNrCkm0gcX7TpBG6VjD2jusWq6Nz71642zwyhAXS8GDtNe7tRl6nalNUXj8jgWU3+tSg==
X-Received: by 2002:a05:600c:4111:: with SMTP id j17mr824987wmi.187.1625111182018;
        Wed, 30 Jun 2021 20:46:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l9sm8049636wrp.14.2021.06.30.20.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 20:46:21 -0700 (PDT)
Message-Id: <3409a6cd631deb361d3ecb94491c0c297c52fb53.1625111177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.988.git.1625111177.gitgitgadget@gmail.com>
References: <pull.988.git.1625111177.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 03:46:16 +0000
Subject: [PATCH 6/7] merge-ort: avoid recursing into directories when we don't
 need to
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This combines the work of the last several patches, and implements the
conditions when we don't need to recurse into directories.  It's perhaps
easiest to see the logic by separating the fact that a directory might
have both rename sources and rename destinations:

  * rename sources: only files present in the merge base can serve as
    rename sources, and only when one side deletes that file.  When the
    tree on one side matches the merge base, that means every file
    within the subtree matches the merge base.  This means that the
    skip-irrelevant-rename-detection optimization from before kicks in
    and we don't need any of these files as rename sources.

  * rename destinations: the tree that does not match the merge base
    might have newly added and hence unmatched destination files.
    This is what usually prevents us from doing trivial directory
    resolutions in the merge machinery.  However, the fact that we have
    deferred recursing into this directory until the end means we know
    whether there are any unmatched relevant potential rename sources
    elsewhere in this merge.  If there are no unmatched such relevant
    sources anywhere, then there is no need to look for unmatched
    potential rename destinations to match them with.

This informs our algorithm:
  * Search through relevant_sources; if we have entries, they better all
    be reflected in cached_pairs or cached_irrelevant, otherwise they
    represent an unmatched potential rename source (causing the
    optimization to be disallowed).
  * For any relevant_source represented in cached_pairs, we do need to
    to make sure to get the destination for each source, meaning we need
    to recurse into any ancestor directories of those destinations.
  * Once we've recursed into all the rename destinations for any
    relevant_sources in cached_pairs, we can then do the trivial
    directory resolution for the remaining directories.

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28),
this change improves the performance as follows:

                            Before                  After
    no-renames:        5.235 s ±  0.042 s   205.1  ms ±  3.8  ms
    mega-renames:      9.419 s ±  0.107 s     1.564 s ±  0.010 s
    just-one-mega:   480.1  ms ±  3.9  ms   479.5  ms ±  3.9  ms

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 98 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index bf0712d18a0..c9cf7a158c8 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1223,6 +1223,18 @@ static int collect_merge_info_callback(int n,
 	return mask;
 }
 
+static void resolve_trivial_directory_merge(struct conflict_info *ci, int side)
+{
+	VERIFY_CI(ci);
+	assert((side == 1 && ci->match_mask == 5) ||
+	       (side == 2 && ci->match_mask == 3));
+	oidcpy(&ci->merged.result.oid, &ci->stages[side].oid);
+	ci->merged.result.mode = ci->stages[side].mode;
+	ci->merged.is_null = is_null_oid(&ci->stages[side].oid);
+	ci->match_mask = 0;
+	ci->merged.clean = 1; /* (ci->filemask == 0); */
+}
+
 static int handle_deferred_entries(struct merge_options *opt,
 				   struct traverse_info *info)
 {
@@ -1232,9 +1244,71 @@ static int handle_deferred_entries(struct merge_options *opt,
 	int side, ret = 0;
 
 	for (side = MERGE_SIDE1; side <= MERGE_SIDE2; side++) {
-		renames->trivial_merges_okay[side] = 0;
-		strintmap_for_each_entry(&renames->possible_trivial_merges[side],
-					 &iter, entry) {
+		unsigned optimization_okay = 1;
+		struct strintmap copy;
+
+		/* Loop over the set of paths we need to know rename info for */
+		strset_for_each_entry(&renames->relevant_sources[side],
+				      &iter, entry) {
+			char *rename_target, *dir, *dir_marker;
+			struct strmap_entry *e;
+
+			/*
+			 * if we don't know delete/rename info for this path,
+			 * then we need to recurse into all trees to get all
+			 * adds to make sure we have it.
+			 */
+			if (strset_contains(&renames->cached_irrelevant[side],
+					    entry->key))
+				continue;
+			e = strmap_get_entry(&renames->cached_pairs[side],
+					     entry->key);
+			if (!e) {
+				optimization_okay = 0;
+				break;
+			}
+
+			/* If this is a delete, we have enough info already */
+			rename_target = e->value;
+			if (!rename_target)
+				continue;
+
+			/* If we already walked the rename target, we're good */
+			if (strmap_contains(&opt->priv->paths, rename_target))
+				continue;
+
+			/*
+			 * Otherwise, we need to get a list of directories that
+			 * will need to be recursed into to get this
+			 * rename_target.
+			 */
+			dir = xstrdup(rename_target);
+			while ((dir_marker = strrchr(dir, '/'))) {
+				*dir_marker = '\0';
+				if (strset_contains(&renames->target_dirs[side],
+						    dir))
+					break;
+				strset_add(&renames->target_dirs[side], dir);
+			}
+			free(dir);
+		}
+		renames->trivial_merges_okay[side] = optimization_okay;
+		/*
+		 * We need to recurse into any directories in
+		 * possible_trivial_merges[side] found in target_dirs[side].
+		 * But when we recurse, we may need to queue up some of the
+		 * subdirectories for possible_trivial_merges[side].  Since
+		 * we can't safely iterate through a hashmap while also adding
+		 * entries, move the entries into 'copy', iterate over 'copy',
+		 * and then we'll also iterate anything added into
+		 * possible_trivial_merges[side] once this loop is done.
+		 */
+		copy = renames->possible_trivial_merges[side];
+		strintmap_init_with_options(&renames->possible_trivial_merges[side],
+					    0,
+					    NULL,
+					    0);
+		strintmap_for_each_entry(&copy, &iter, entry) {
 			const char *path = entry->key;
 			unsigned dir_rename_mask = (intptr_t)entry->value;
 			struct conflict_info *ci;
@@ -1247,6 +1321,13 @@ static int handle_deferred_entries(struct merge_options *opt,
 			VERIFY_CI(ci);
 			dirmask = ci->dirmask;
 
+			if (optimization_okay &&
+			    !strset_contains(&renames->target_dirs[side],
+					     path)) {
+				resolve_trivial_directory_merge(ci, side);
+				continue;
+			}
+
 			info->name = path;
 			info->namelen = strlen(path);
 			info->pathlen = info->namelen + 1;
@@ -1282,6 +1363,20 @@ static int handle_deferred_entries(struct merge_options *opt,
 			if (ret < 0)
 				return ret;
 		}
+		strintmap_clear(&copy);
+		strintmap_for_each_entry(&renames->possible_trivial_merges[side],
+					 &iter, entry) {
+			const char *path = entry->key;
+			struct conflict_info *ci;
+
+			ci = strmap_get(&opt->priv->paths, path);
+			VERIFY_CI(ci);
+
+			assert(renames->trivial_merges_okay[side] &&
+			       !strset_contains(&renames->target_dirs[side],
+						path));
+			resolve_trivial_directory_merge(ci, side);
+		}
 	}
 	return ret;
 }
-- 
gitgitgadget

