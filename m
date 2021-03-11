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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC7DC433DB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 00:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1EA564FBF
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 00:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhCKAiu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 19:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhCKAif (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 19:38:35 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5997C061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 16:38:34 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l19so264573wmh.1
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 16:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OnN/B9G0iQPf8qsCwAjIg6HB7RrPcPM8hs2LL4tvh7M=;
        b=eZNNMQr8YsaGfBCkY+B+fYFD2BMPKs1fWiBYpGQfllRADPO/zFNVLgHEUhzBIHuw7a
         I76d+y12P9/pT28eyjeNuQ1He4zzU11dscZu4Wn9pvmvrx4x7yA/sRLzHXYQrSBjeBvw
         Lv3UTx08CXWsAqCMsuHpQej9CJ3gjk2h4COqLH/hmsMj8gEob6/7o1Qg8PAWhxOe40ti
         Gfa+Oz7HXNBToQUdUmKrUwRwW7gPR0b9FmGpTp/eJfEpIgaPabn8iKhgLEaqNSJBJ10A
         aWvdffRCrHZ8W94mEay8swz8qymY20naKEqIwF/g3WIFewtUivYOL5fXWghtDFZqPTdn
         PN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OnN/B9G0iQPf8qsCwAjIg6HB7RrPcPM8hs2LL4tvh7M=;
        b=Nc0C3d7G+S/320+CUENBvkx2NpASdkKNvg4ejSv5SzReUWFft4DycUR+DGfGE5ITS+
         W4RcHQ3f1kC3ZPfiHzZciovd/HJ4QEuC/5vfgt6DRXLkZVNJ30/7/xMnz4rJVde/fMRJ
         zWol/dk6vaSW/tRBwX9F3Q0f1o9L5D4vxHB7C4lHMxtRCm31q1koZg8nQxfDYKIOw0/H
         34PBOFNRDdayHLV+zk5Sx3VPO9QPfSfJf4CRlep8hnA4Kh7OT5ZOICVDoqstzGiQR7Rv
         IoIAFLuYk5DExJtmkzYgXXdvv12jrb+A1M3oOneXByiyJ747tjnuxbndgW/J6BixATIw
         EvAg==
X-Gm-Message-State: AOAM5319tbrkKq1y3QBd5rplE0PVrrFAD5lIX/1n5K30mK+wCZTVU2qg
        F4b3f+4d0AqrglKzRWNjMBBwURcPi74=
X-Google-Smtp-Source: ABdhPJyaWn+wkkaz1+doBrw89wOq59/GcxvWsupKam2SqH/XyOJuNoE+xWg/fFJ/uNV9ZddIQ96gqw==
X-Received: by 2002:a7b:c195:: with SMTP id y21mr5619088wmi.178.1615423113495;
        Wed, 10 Mar 2021 16:38:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l15sm1030343wru.38.2021.03.10.16.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 16:38:33 -0800 (PST)
Message-Id: <3b253f5a63edfac5d4d2f4f60f5c824bcfafead0.1615423111.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.845.v3.git.1615423111.gitgitgadget@gmail.com>
References: <pull.845.v2.git.1615248599.gitgitgadget@gmail.com>
        <pull.845.v3.git.1615423111.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 Mar 2021 00:38:24 +0000
Subject: [PATCH v3 1/8] diffcore-rename: enable filtering possible rename
 sources
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

A note about filtering order:

Some may be curious why we don't filter out irrelevant sources at the
same time we filter out exact renames.  While that technically could be
done at this point, there are two reasons to defer it:

First, was to reinforce a lesson that was too easy to forget.  As I
mentioned above, in the past I filtered irrelevant sources out before
exact rename checking, and then discovered that exact renames' ability
to remove both sources and destinations was an important consideration
and thus doing the filtering after exact rename checking would speed
things up.  Then at some point I realized that basename matching could
also remove both sources and destinations, and decided to put irrelevant
source filtering after basename filtering.  That slowed things down a
lot.  But, despite learning about this important ordering, in later
restructuring I forgot and made the same mistake of putting the
filtering after basename guided rename detection again.  So, I have this
series of patches structured to do the irrelevant filtering last to
start to show how much extra it costs, and then add relevant filtering
in to find_basename_matches() to show how much it speeds things up.
Basically, it's a way to reinforce something that apparently was too
easy to forget, and make sure the commit messages record this lesson.

Second, the items in the "relevant_sources" in this patch series will
include all sources that *might be* relevant.  It has to be conservative
and catch anything that might need a rename, but in the patch series
after this one we'll find ways to weed out more of the *might be*
relevant ones.  Unfortunately, merge-ort does not have sufficient
information to weed those ones out, and there isn't enough information
at the time of filtering exact renames out to remove the extra ones
either.  It has to be deferred.  So the deferral is in part to simplify
some later additions.

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

