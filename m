Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169A5C433FE
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 08:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3ABA22D6F
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 08:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390544AbgLMIFL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Dec 2020 03:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgLMIFL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Dec 2020 03:05:11 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A889BC0613CF
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 00:04:30 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id y23so12433147wmi.1
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 00:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=n+pc8f3Hj7BD19OG3d/N/ELQR2mLXFVIqDHEZ8uj+z4=;
        b=HQJGzJ4PyjIK55bctIiX1XAp5iFQys9+Z9FlqE7hTWfP0wN+A4O8NSwNvVgEe18hoZ
         J8zbCpl1WfWhnrod/O24ogc+ou/xfyKJPyacv9ipch+G65v93YSn7Qbx1MU3svq8yeJh
         o4rhd3lntkAq75YDFTdZRR1KjUuBbqdDUv87zouhomldx/c9PW6Z6fBWO/TROpPIwExy
         Wkmwr0hzf1XQhFQINPn+48kIFOfK2mJ+TrYJaSL/C6az6KMGDf00Wr4MB7Bkeji5AoOo
         U1j3OZjsMlwKBZdcHnwmFW7ZHxx4b825dN1q5JcVjMaDmJQsEfAP2QS/36lBEh41i13b
         8fCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=n+pc8f3Hj7BD19OG3d/N/ELQR2mLXFVIqDHEZ8uj+z4=;
        b=ieZmJ9dUXq7fNRjZ6XqYQF7vyWQ0bpugpEuPLye+77CksF8xUCNGRSGDn1k3DsoKmE
         JokRR6jVV3Vh3uEC7VvqPavAHdgKWca9YEwn1LsnEfdPtwVHi29LBbXaPvYUbA9O1pik
         OYXGRFN9FcBrE3RINL1td1vAGfmBoVV9ISRxR7oxLGdFooqyBMP2n3WUKh6H4xOQmvpf
         OqSIiVtsnRzLhib5/Vb8Pw8sas6D+GQsZ3X6dlfNuVMCh8TGqCGcE0iyDUidHYLBhiK7
         2Mi8Bsj0wpqawTsqsgWIrAKrdbgEYRacTuTMBPUxVf9/6aOImwqxuuQjTnGBlk/yw6TE
         5vjg==
X-Gm-Message-State: AOAM533Ne2itn73TRhBz8bkBL0WgVJr5vXJL4w5TlKhlRvXiUdIhaXOF
        uK6KdUAoWgE3oOqHd2bIdEm8Z+JvPIE=
X-Google-Smtp-Source: ABdhPJxkWap33h96P+3HG22nNsKU7WPBM7TKyt9SUN2B2aTIPRgQ1bhkYfXtBoijzWqh2JpkOuRu1Q==
X-Received: by 2002:a05:600c:255:: with SMTP id 21mr21774146wmj.69.1607846668949;
        Sun, 13 Dec 2020 00:04:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o17sm25626319wrg.32.2020.12.13.00.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 00:04:28 -0800 (PST)
Message-Id: <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
References: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 13 Dec 2020 08:04:07 +0000
Subject: [PATCH v3 00/20] fundamentals of merge-ort implementation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, dstolee@microsoft.com,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is actually v5 of this series, and is being sent due to review comments
from a different series, namely en/merge-ort-3[1].

I have rerolls of en/merge-ort-2 and en/merge-ort-3 already prepared, but
since gitgitgadget will not allow me to send a series dependent on a
not-published-by-Junio series, I cannot yet send them. You will need to
temporarily drop them, and I'll resend after you publish the updated version
of this series. I do not like this solution, and I was tempted to just push
the updates into en/merge-ort-3, but since this series was still hanging in
'seen' awaiting feedback and a lot of the suggestions were for things from
this series, I decided to go this route anyway...

[1]
https://lore.kernel.org/git/CABPp-BHa0zehQd-axmb4bF6fR4PTWwGu9uLjOzgTW8_Gu12iZA@mail.gmail.com/

Changes since v4:

 * Improved documentation of filemask and dirmask
 * Improved documentation of merge_result.clean
 * Added new enum merge_side and documentation with it to try to make the
   code a bit more self-documenting.

Elijah Newren (20):
  merge-ort: setup basic internal data structures
  merge-ort: add some high-level algorithm structure
  merge-ort: port merge_start() from merge-recursive
  merge-ort: use histogram diff
  merge-ort: add an err() function similar to one from merge-recursive
  merge-ort: implement a very basic collect_merge_info()
  merge-ort: avoid repeating fill_tree_descriptor() on the same tree
  merge-ort: compute a few more useful fields for collect_merge_info
  merge-ort: record stage and auxiliary info for every path
  merge-ort: avoid recursing into identical trees
  merge-ort: add a preliminary simple process_entries() implementation
  merge-ort: have process_entries operate in a defined order
  merge-ort: step 1 of tree writing -- record basenames, modes, and oids
  merge-ort: step 2 of tree writing -- function to create tree object
  merge-ort: step 3 of tree writing -- handling subdirectories as we go
  merge-ort: basic outline for merge_switch_to_result()
  merge-ort: add implementation of checkout()
  tree: enable cmp_cache_name_compare() to be used elsewhere
  merge-ort: add implementation of record_conflicted_index_entries()
  merge-ort: free data structures in merge_finalize()

 merge-ort.c | 1248 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 merge-ort.h |    9 +-
 tree.c      |    2 +-
 tree.h      |    2 +
 4 files changed, 1256 insertions(+), 5 deletions(-)


base-commit: 3cf59784d42c4152a0b3de7bb7a75d0071e5f878
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-923%2Fnewren%2Fort-basics-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-923/newren/ort-basics-v3
Pull-Request: https://github.com/git/git/pull/923

Range-diff vs v2:

  1:  2568ec92c6d !  1:  518dde86966 merge-ort: setup basic internal data structures
     @@ merge-ort.c
      +	unsigned df_conflict:1;
      +
      +	/*
     -+	 * For filemask and dirmask, see tree-walk.h's struct traverse_info,
     -+	 * particularly the documentation above the "fn" member.  Note that
     -+	 * filemask = mask & ~dirmask from that documentation.
     ++	 * For filemask and dirmask, the ith bit corresponds to whether the
     ++	 * ith entry is a file (filemask) or a directory (dirmask).  Thus,
     ++	 * filemask & dirmask is always zero, and filemask | dirmask is at
     ++	 * most 7 but can be less when a path does not appear as either a
     ++	 * file or a directory on at least one side of history.
     ++	 *
     ++	 * Note that these masks are related to enum merge_side, as the ith
     ++	 * entry corresponds to side i.
     ++	 *
     ++	 * These values come from a traverse_trees() call; more info may be
     ++	 * found looking at tree-walk.h's struct traverse_info,
     ++	 * particularly the documentation above the "fn" member (note that
     ++	 * filemask = mask & ~dirmask from that documentation).
      +	 */
      +	unsigned filemask:3;
      +	unsigned dirmask:3;
  2:  b658536f59d =  2:  5827ec7f3eb merge-ort: add some high-level algorithm structure
  3:  acb40f5c165 =  3:  8295591ee13 merge-ort: port merge_start() from merge-recursive
  4:  22fecf6ccd1 =  4:  38b4f9cf78c merge-ort: use histogram diff
  5:  6c4c0c15b3d !  5:  95143bebf09 merge-ort: add an err() function similar to one from merge-recursive
     @@ Commit message
          for when we detect problems returned from collect_merge_info()'s
          traverse_trees() call, which we will be adding next.
      
     +    While we are at it, also add more documentation for the "clean" field
     +    from struct merge_result, particularly since the name suggests a boolean
     +    but it is not quite one and this is our first non-boolean usage.
     +
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## merge-ort.c ##
     @@ merge-ort.c: static void merge_ort_nonrecursive_internal(struct merge_options *o
       	result->clean = detect_and_process_renames(opt, merge_base,
       						   side1, side2);
       	process_entries(opt, &working_tree_oid);
     +
     + ## merge-ort.h ##
     +@@ merge-ort.h: struct commit;
     + struct tree;
     + 
     + struct merge_result {
     +-	/* Whether the merge is clean */
     ++	/*
     ++	 * Whether the merge is clean; possible values:
     ++	 *    1: clean
     ++	 *    0: not clean (merge conflicts)
     ++	 *   <0: operation aborted prematurely.  (object database
     ++	 *       unreadable, disk full, etc.)  Worktree may be left in an
     ++	 *       inconsistent state if operation failed near the end.
     ++	 */
     + 	int clean;
     + 
     + 	/*
  6:  27268ef8a3c !  6:  242f6462ebb merge-ort: implement a very basic collect_merge_info()
     @@ Commit message
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## merge-ort.c ##
     +@@
     + #include "tree.h"
     + #include "xdiff-interface.h"
     + 
     ++/*
     ++ * We have many arrays of size 3.  Whenever we have such an array, the
     ++ * indices refer to one of the sides of the three-way merge.  This is so
     ++ * pervasive that the constants 0, 1, and 2 are used in many places in the
     ++ * code (especially in arithmetic operations to find the other side's index
     ++ * or to compute a relevant mask), but sometimes these enum names are used
     ++ * to aid code clarity.
     ++ *
     ++ * See also 'filemask' and 'dirmask' in struct conflict_info; the "ith side"
     ++ * referred to there is one of these three sides.
     ++ */
     ++enum merge_side {
     ++	MERGE_BASE = 0,
     ++	MERGE_SIDE1 = 1,
     ++	MERGE_SIDE2 = 2
     ++};
     ++
     + struct merge_options_internal {
     + 	/*
     + 	 * paths: primary data structure in all of merge ort.
      @@ merge-ort.c: static int err(struct merge_options *opt, const char *err, ...)
       	return -1;
       }
     @@ merge-ort.c: static int err(struct merge_options *opt, const char *err, ...)
      +		newinfo.namelen = p->pathlen;
      +		newinfo.pathlen = st_add3(newinfo.pathlen, p->pathlen, 1);
      +
     -+		for (i = 0; i < 3; i++) {
     ++		for (i = MERGE_BASE; i <= MERGE_SIDE2; i++) {
      +			const struct object_id *oid = NULL;
      +			if (dirmask & 1)
      +				oid = &names[i].oid;
     @@ merge-ort.c: static int err(struct merge_options *opt, const char *err, ...)
      +		ret = traverse_trees(NULL, 3, t, &newinfo);
      +		opti->current_dir_name = original_dir_name;
      +
     -+		for (i = 0; i < 3; i++)
     ++		for (i = MERGE_BASE; i <= MERGE_SIDE2; i++)
      +			free(buf[i]);
      +
      +		if (ret < 0)
  7:  c6e5621c210 !  7:  c18bdc1b052 merge-ort: avoid repeating fill_tree_descriptor() on the same tree
     @@ merge-ort.c: static int collect_merge_info_callback(int n,
      @@ merge-ort.c: static int collect_merge_info_callback(int n,
       		newinfo.pathlen = st_add3(newinfo.pathlen, p->pathlen, 1);
       
     - 		for (i = 0; i < 3; i++) {
     + 		for (i = MERGE_BASE; i <= MERGE_SIDE2; i++) {
      -			const struct object_id *oid = NULL;
      -			if (dirmask & 1)
      -				oid = &names[i].oid;
  8:  93fd69fa3c6 !  8:  be5708dc628 merge-ort: compute a few more useful fields for collect_merge_info
     @@ merge-ort.c: static int collect_merge_info_callback(int n,
      +		 * the beginning of this function).
      +		 */
       
     - 		for (i = 0; i < 3; i++) {
     + 		for (i = MERGE_BASE; i <= MERGE_SIDE2; i++) {
       			if (i == 1 && side1_matches_mbase)
  9:  decff4b3754 !  9:  be4bdfac876 merge-ort: record stage and auxiliary info for every path
     @@ merge-ort.c: static int err(struct merge_options *opt, const char *err, ...)
      +		struct conflict_info *ci;
      +
      +		ASSIGN_AND_VERIFY_CI(ci, mi);
     -+		for (i = 0; i < 3; i++) {
     ++		for (i = MERGE_BASE; i <= MERGE_SIDE2; i++) {
      +			ci->pathnames[i] = fullpath;
      +			ci->stages[i].mode = names[i].mode;
      +			oidcpy(&ci->stages[i].oid, &names[i].oid);
 10:  86c661fe1ee = 10:  6fdf85c8f1a merge-ort: avoid recursing into identical trees
 11:  aa3b13ffd87 = 11:  8b001ae643a merge-ort: add a preliminary simple process_entries() implementation
 12:  b54306fd0e6 = 12:  260b12290fb merge-ort: have process_entries operate in a defined order
 13:  8ee8561d7a3 = 13:  092e77bbb15 merge-ort: step 1 of tree writing -- record basenames, modes, and oids
 14:  6ff56824c33 = 14:  b5d9ba10f8c merge-ort: step 2 of tree writing -- function to create tree object
 15:  da4fe900496 = 15:  81374cbf205 merge-ort: step 3 of tree writing -- handling subdirectories as we go
 16:  8e90d211c5d = 16:  3198efe3188 merge-ort: basic outline for merge_switch_to_result()
 17:  61fada146cf ! 17:  119f40c77f8 merge-ort: add implementation of checkout()
     @@ merge-ort.c
      +#include "unpack-trees.h"
       #include "xdiff-interface.h"
       
     - struct merge_options_internal {
     + /*
      @@ merge-ort.c: static int checkout(struct merge_options *opt,
       		    struct tree *prev,
       		    struct tree *next)
 18:  f5a13a0b084 = 18:  b4c400051ad tree: enable cmp_cache_name_compare() to be used elsewhere
 19:  4efac38116d ! 19:  ee831c8cece merge-ort: add implementation of record_conflicted_index_entries()
     @@ merge-ort.c: static int record_conflicted_index_entries(struct merge_options *op
      +			ce->ce_flags |= CE_REMOVE;
      +		}
      +
     -+		for (i = 0; i < 3; i++) {
     ++		for (i = MERGE_BASE; i <= MERGE_SIDE2; i++) {
      +			struct version_info *vi;
      +			if (!(ci->filemask & (1ul << i)))
      +				continue;
 20:  fbeb527d671 = 20:  55451a79eec merge-ort: free data structures in merge_finalize()

-- 
gitgitgadget
