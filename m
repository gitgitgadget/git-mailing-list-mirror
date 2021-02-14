Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,BIGNUM_EMAILS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63CBC433E0
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 07:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D5AE64E26
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 07:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhBNHzL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 02:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhBNHwx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 02:52:53 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF21C0617AA
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:51:57 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id o10so2811227wmc.1
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=MeEArXXMflp+URAUCekXIHJ/+BfExcgxrDq0SnIySvs=;
        b=OikMBAR1AuQ0Bf0UJIqaPkV0unDl+wNQ0+KTy7NjS1InP7FG+WpOo69AcDu69qsDhR
         mQrGQUGDQXaWcI0Tqar8YnPD2viMbrwdrhJQT3wmHLmTKbZ4B6LkBOFpXbq+oClKO+jz
         I+ORabW2AObVmLO8+bhp+89NnkKF2zJqNcmYVkHrqSozmopgIdnUYUY4Knm3pqvbpIAP
         96+3xgfob3F9aTQQGDZkIN4w3LOCKqFJGkDeOp7qSVgO3KpvXVLP2NxhrRk3dGF8YpW0
         j6FLHM8AsRe4qMS3N41COmn2k77GLCEt8Qz0dJaJ13NbuD7Ruq+Nx64seCnGM1A1drCY
         KlAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=MeEArXXMflp+URAUCekXIHJ/+BfExcgxrDq0SnIySvs=;
        b=WAIRbUVuKk8DdLD89Z7aA2UccxOjE0Ow4mPWxSazZaGGHereyQTWDugMVJ6H2HLlFY
         q5unaTJdn5r19NHAh0wgSdqnwHiwlU+/5Toi5r4clt40wBL7t8NYnT8FMa6/qMwZY0RK
         MlJKzboDy1TfQTUWXqO/Ar3nSDUEsotOXtx++GEBDaZqdKiiT9DGrtvEQ7TS7MPP8ofe
         BAYH7s2QAJLY05V8z7Uc2bGqKL4RsgIydKku+xMigjm9JfJn17b8x3zxAfRjODV4ZYkm
         CZsJ6Gnou5XPpzpWWFM+F20ZAWO0EfKdL24mxFXyUFXsvpVc164EIvCnv7GWvqRb6bG0
         mVmQ==
X-Gm-Message-State: AOAM533uldWZAJk2G7dja53DkjF0GaAsbPXIS0fOt4C8subtLiglVyNg
        +fDReBzGHHKeA5pGbhcHSINssC8Vwps=
X-Google-Smtp-Source: ABdhPJzsPBuBiEo7GjMwsNMMjBu1iVz8sxfIhFcT1zNV+mhGcn0P2SqBWevDruoj1PGK1TwjW+bRNw==
X-Received: by 2002:a05:600c:4f14:: with SMTP id l20mr9395732wmq.155.1613289116618;
        Sat, 13 Feb 2021 23:51:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w2sm23707832wmg.27.2021.02.13.23.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 23:51:56 -0800 (PST)
Message-Id: <aeca14f748afc7fb5b65bca56ea2ebd970729814.1613289112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.843.v5.git.1613289112.gitgitgadget@gmail.com>
References: <pull.843.v4.git.1613031350.gitgitgadget@gmail.com>
        <pull.843.v5.git.1613289112.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Feb 2021 07:51:51 +0000
Subject: [PATCH v5 6/6] merge-ort: call diffcore_rename() directly
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

We want to pass additional information to diffcore_rename() (or some
variant thereof) without plumbing that extra information through
diff_tree_oid() and diffcore_std().  Further, since we will need to
gather additional special information related to diffs and are walking
the trees anyway in collect_merge_info(), it seems odd to have
diff_tree_oid()/diffcore_std() repeat those tree walks.  And there may
be times where we can avoid traversing into a subtree in
collect_merge_info() (based on additional information at our disposal),
that the basic diff logic would be unable to take advantage of.  For all
these reasons, just create the add and delete pairs ourself and then
call diffcore_rename() directly.

This change is primarily about enabling future optimizations; the
advantage of avoiding extra tree traversals is small compared to the
cost of rename detection, and the advantage of avoiding the extra tree
traversals is somewhat offset by the extra time spent in
collect_merge_info() collecting the additional data anyway.  However...

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28),
this change improves the performance as follows:

                            Before                  After
    no-renames:       13.294 s ±  0.103 s    12.775 s ±  0.062 s
    mega-renames:    187.248 s ±  0.882 s   188.754 s ±  0.284 s
    just-one-mega:     5.557 s ±  0.017 s     5.599 s ±  0.019 s

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 59 insertions(+), 7 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 931b91438cf1..603d30c52170 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -535,6 +535,23 @@ static void setup_path_info(struct merge_options *opt,
 	result->util = mi;
 }
 
+static void add_pair(struct merge_options *opt,
+		     struct name_entry *names,
+		     const char *pathname,
+		     unsigned side,
+		     unsigned is_add /* if false, is_delete */)
+{
+	struct diff_filespec *one, *two;
+	struct rename_info *renames = &opt->priv->renames;
+	int names_idx = is_add ? side : 0;
+
+	one = alloc_filespec(pathname);
+	two = alloc_filespec(pathname);
+	fill_filespec(is_add ? two : one,
+		      &names[names_idx].oid, 1, names[names_idx].mode);
+	diff_queue(&renames->pairs[side], one, two);
+}
+
 static void collect_rename_info(struct merge_options *opt,
 				struct name_entry *names,
 				const char *dirname,
@@ -544,6 +561,7 @@ static void collect_rename_info(struct merge_options *opt,
 				unsigned match_mask)
 {
 	struct rename_info *renames = &opt->priv->renames;
+	unsigned side;
 
 	/* Update dirs_removed, as needed */
 	if (dirmask == 1 || dirmask == 3 || dirmask == 5) {
@@ -554,6 +572,21 @@ static void collect_rename_info(struct merge_options *opt,
 		if (sides & 2)
 			strset_add(&renames->dirs_removed[2], fullname);
 	}
+
+	if (filemask == 0 || filemask == 7)
+		return;
+
+	for (side = MERGE_SIDE1; side <= MERGE_SIDE2; ++side) {
+		unsigned side_mask = (1 << side);
+
+		/* Check for deletion on side */
+		if ((filemask & 1) && !(filemask & side_mask))
+			add_pair(opt, names, fullname, side, 0 /* delete */);
+
+		/* Check for addition on side */
+		if (!(filemask & 1) && (filemask & side_mask))
+			add_pair(opt, names, fullname, side, 1 /* add */);
+	}
 }
 
 static int collect_merge_info_callback(int n,
@@ -2079,6 +2112,27 @@ static int process_renames(struct merge_options *opt,
 	return clean_merge;
 }
 
+static void resolve_diffpair_statuses(struct diff_queue_struct *q)
+{
+	/*
+	 * A simplified version of diff_resolve_rename_copy(); would probably
+	 * just use that function but it's static...
+	 */
+	int i;
+	struct diff_filepair *p;
+
+	for (i = 0; i < q->nr; ++i) {
+		p = q->queue[i];
+		p->status = 0; /* undecided */
+		if (!DIFF_FILE_VALID(p->one))
+			p->status = DIFF_STATUS_ADDED;
+		else if (!DIFF_FILE_VALID(p->two))
+			p->status = DIFF_STATUS_DELETED;
+		else if (DIFF_PAIR_RENAME(p))
+			p->status = DIFF_STATUS_RENAMED;
+	}
+}
+
 static int compare_pairs(const void *a_, const void *b_)
 {
 	const struct diff_filepair *a = *((const struct diff_filepair **)a_);
@@ -2089,8 +2143,6 @@ static int compare_pairs(const void *a_, const void *b_)
 
 /* Call diffcore_rename() to compute which files have changed on given side */
 static void detect_regular_renames(struct merge_options *opt,
-				   struct tree *merge_base,
-				   struct tree *side,
 				   unsigned side_index)
 {
 	struct diff_options diff_opts;
@@ -2108,11 +2160,11 @@ static void detect_regular_renames(struct merge_options *opt,
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_setup_done(&diff_opts);
 
+	diff_queued_diff = renames->pairs[side_index];
 	trace2_region_enter("diff", "diffcore_rename", opt->repo);
-	diff_tree_oid(&merge_base->object.oid, &side->object.oid, "",
-		      &diff_opts);
-	diffcore_std(&diff_opts);
+	diffcore_rename(&diff_opts);
 	trace2_region_leave("diff", "diffcore_rename", opt->repo);
+	resolve_diffpair_statuses(&diff_queued_diff);
 
 	if (diff_opts.needed_rename_limit > renames->needed_limit)
 		renames->needed_limit = diff_opts.needed_rename_limit;
@@ -2212,8 +2264,8 @@ static int detect_and_process_renames(struct merge_options *opt,
 	memset(&combined, 0, sizeof(combined));
 
 	trace2_region_enter("merge", "regular renames", opt->repo);
-	detect_regular_renames(opt, merge_base, side1, MERGE_SIDE1);
-	detect_regular_renames(opt, merge_base, side2, MERGE_SIDE2);
+	detect_regular_renames(opt, MERGE_SIDE1);
+	detect_regular_renames(opt, MERGE_SIDE2);
 	trace2_region_leave("merge", "regular renames", opt->repo);
 
 	trace2_region_enter("merge", "directory renames", opt->repo);
-- 
gitgitgadget
