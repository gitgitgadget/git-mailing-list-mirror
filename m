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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B4DC433E9
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 00:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A05E64FCD
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 00:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhCKAiv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 19:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhCKAih (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 19:38:37 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C9FC061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 16:38:37 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u16so25338544wrt.1
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 16:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XMmTPgcNN7fjlnFPTnl/MMazJMOaP5Kcor5uUNPOJEM=;
        b=W+qA/dzaN0ZxI5LNQ+uy8zVmbiA1sHL2wwXVFBVRwStbP7N5GUQimpRBK6Vu+4K/GM
         ntmPNXvM42Y5XeP2TZ6ELDnwBoEbCbnlfmQi75hSlcnq8vJuRhg/rLsyc3Lz4nuOa8FQ
         0YO+CZwu94QjrIcfAiFYZ1hasytHbJZaZ7nj1wxz5ovXDmS/J/4fGDUo75QPvqepqdPf
         BsXudSUbP3mjV7uewI0WlPq2Jiqevi02GCcx4+S74/Vv3cl8+5of+AXQ+Vf9dEHWEY9N
         5HqfTwwfG1Y0hbdxMqbRYgdCQ4LLjBIqJMgIBg8c7JqtcSv2kVKL5+jk0Ja7lzWAMSO9
         cnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XMmTPgcNN7fjlnFPTnl/MMazJMOaP5Kcor5uUNPOJEM=;
        b=q2ba9tKFYxDF/5aLQ/YbcMEFpKMBmit8vZYaklcy4iwyRInCqJG74S6hp6eL4FzdOc
         RgMpfVKREnBuAwU5hUe+JqLI79E9vnbe/md0RZP05ZZfcE8w6PextMNhOhYWh34Tzvl8
         ptlrc1Kf1Rmg29TluB4PzChiI1Iy/prr8doRUrVn1yGsCoklSIacnPzqiJ4EWyqztxOt
         nkf/stqzTByyzkSVmM6VFr02XP/idopEiyEmRtmGV0mg0hPKZhw+2B0xPpTzb1oNE21J
         /D1EVGGZ95/1m36yl/Ov2DKfDmN4ccZRLsLNZCYmuue04MCOy+F4yXnXMBcT7bcq9TAE
         7HKA==
X-Gm-Message-State: AOAM532arSaenpmKM6kBzaXcj62UdDvAkJ/o3EFFhxxVMAumv0GroGO/
        NGQtfcxV6+uI0jBFkYii3uWra4iFUcw=
X-Google-Smtp-Source: ABdhPJyePovR+kbJPH6SdbTn75Uj1sAr7SxpL2JLgUzBXi3o6CX8QZYtcZ7NWZhv97dDfX2Yin5fuw==
X-Received: by 2002:a05:6000:1a8c:: with SMTP id f12mr5929214wry.173.1615423115812;
        Wed, 10 Mar 2021 16:38:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m17sm1004329wrx.92.2021.03.10.16.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 16:38:35 -0800 (PST)
Message-Id: <dc146a867b16cefeee71104f1967c5d325f5ffee.1615423112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.845.v3.git.1615423111.gitgitgadget@gmail.com>
References: <pull.845.v2.git.1615248599.gitgitgadget@gmail.com>
        <pull.845.v3.git.1615423111.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 Mar 2021 00:38:28 +0000
Subject: [PATCH v3 5/8] merge-ort: precompute whether directory rename
 detection is needed
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
index f8f7d06d481a..5840832cf3ed 100644
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
@@ -647,7 +662,8 @@ static void add_pair(struct merge_options *opt,
 		     const char *pathname,
 		     unsigned side,
 		     unsigned is_add /* if false, is_delete */,
-		     unsigned match_mask)
+		     unsigned match_mask,
+		     unsigned dir_rename_mask)
 {
 	struct diff_filespec *one, *two;
 	struct rename_info *renames = &opt->priv->renames;
@@ -655,7 +671,7 @@ static void add_pair(struct merge_options *opt,
 
 	if (!is_add) {
 		unsigned content_relevant = (match_mask == 0);
-		unsigned location_relevant = 1; /* FIXME: compute this */
+		unsigned location_relevant = (dir_rename_mask == 0x07);
 
 		if (content_relevant || location_relevant)
 			strset_add(&renames->relevant_sources[side], pathname);
@@ -679,6 +695,36 @@ static void collect_rename_info(struct merge_options *opt,
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
@@ -698,12 +744,14 @@ static void collect_rename_info(struct merge_options *opt,
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
 
@@ -721,12 +769,14 @@ static int collect_merge_info_callback(int n,
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
@@ -867,8 +917,13 @@ static int collect_merge_info_callback(int n,
 
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

