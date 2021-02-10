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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD59C433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 15:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC9E564E7C
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 15:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbhBJPRK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 10:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbhBJPQa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 10:16:30 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFE1C0613D6
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 07:15:49 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id t142so2123158wmt.1
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 07:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mj5Y7AlVUBbet8Wcga40zNKhfgQmVARKb2P7Xr/sYP4=;
        b=WmW/TkkphzpEIZYFvSJuL5TMiwkBc6GuBcwj9Szkaa8wlPGOfOmz4Tm0yqgC3+EWva
         KGe584jKc+ADYmv67DRijherfPr+nOhn5e+SpyLalhBmKq8sfbFLt23G/gJ06w6C/4sK
         8Dj8x6+Cqm+1rCYqRIF3fWmuAuKQEvcW6vGMIofCF6lWsV8wFiY7TzPfbTvhezR6Y+VG
         WTDawsDqQb7du1sIvGZClYHQA5GyaMeBOs42fdfF6mHiC3x3YzSnrse93bAEKiX/7QMt
         y7le5m97NtYDiToMFJbAsh7PzlEAaMk3iQYh9GHqvKHt2lcmBg7L1jozs6b8fpwLX1i9
         w0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mj5Y7AlVUBbet8Wcga40zNKhfgQmVARKb2P7Xr/sYP4=;
        b=Xc1wFPHiqc50GUQFe0StDhkcEt/4EdkDT0ZoPACLJ1E1hOPkChNQeex2T9+3YCJHP1
         PlkznTpm515ozPPa7fH/WUr1kkNuyz1voI+TblIir0w3vMvqdtOMjXLXU51OqRAPmJfo
         HgMxX2y7c7l6lyD46OoSJFWB0DtjH+aGFGkabOxVWDriK0zMcVTP6QaoCR3um6LL5irW
         E+ycnPdz550Xuesc88rUwQ0LouJXeGP40q6IBF2rQ2tczsQJwVX0x4TRzu3pOvL5+b6y
         MFQ/nfwLHXhvrsOgAfCIb0zBFxar12RZFChwnQAH5WvtiNYuti84T2bHuQkj9WglI9/e
         iyHQ==
X-Gm-Message-State: AOAM5323HSyhs2LhqnGsZEtXFYPwd7DFO2tjQhIl6yKW6BsUdcaDITJg
        P5nsITbYTqVOaMB+BMI3wh4UR3/bUsA=
X-Google-Smtp-Source: ABdhPJw1rLIIHv2+7eb02usQBqEtzdjjqV+5AMGWUxuy2TgHaq2lWI2WkocFpAyl0x/pdOvwVRpL+Q==
X-Received: by 2002:a7b:c2aa:: with SMTP id c10mr3336234wmk.101.1612970147907;
        Wed, 10 Feb 2021 07:15:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v6sm3683617wrx.32.2021.02.10.07.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 07:15:47 -0800 (PST)
Message-Id: <dc26881e4ed3447c6efdcd492463be294f99b8c4.1612970140.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.843.v3.git.1612970140.gitgitgadget@gmail.com>
References: <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
        <pull.843.v3.git.1612970140.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Feb 2021 15:15:38 +0000
Subject: [PATCH v3 3/5] diffcore-rename: complete find_basename_matches()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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

It is not uncommon in real world repositories for the majority of file
renames to not change the basename of the file; i.e. most "renames" are
just a move of files into different directories.  We can make use of
this to avoid comparing all rename source candidates with all rename
destination candidates, by first comparing sources to destinations with
the same basenames.  If two files with the same basename are
sufficiently similar, we record the rename; if not, we include those
files in the more exhaustive matrix comparison.

This means we are adding a set of preliminary additional comparisons,
but for each file we only compare it with at most one other file.  For
example, if there was a include/media/device.h that was deleted and a
src/module/media/device.h that was added, and there were no other
device.h files added or deleted between the commits being compared,
then these two files would be compared in the preliminary step.

This commit does not yet actually employ this new optimization, it
merely adds a function which can be used for this purpose.  The next
commit will do the necessary plumbing to make use of it.

Note that this optimization might give us different results than without
the optimization, because it's possible that despite files with the same
basename being sufficiently similar to be considered a rename, there's
an even better match between files without the same basename.  I think
that is okay for four reasons: (1) it's easy to explain to the users
what happened if it does ever occur (or even for them to intuitively
figure out), (2) as the next patch will show it provides such a large
performance boost that it's worth the tradeoff, and (3) it's somewhat
unlikely that despite having unique matching basenames that other files
serve as better matches.  Reason (4) takes a full paragraph to
explain...

If the previous three reasons aren't enough, consider what rename
detection already does.  Break detection is not the default, meaning
that if files have the same _fullname_, then they are considered related
even if they are 0% similar.  In fact, in such a case, we don't even
bother comparing the files to see if they are similar let alone
comparing them to all other files to see what they are most similar to.
Basically, we override content similarity based on sufficient filename
similarity.  Without the filename similarity (currently implemented as
an exact match of filename), we swing the pendulum the opposite
direction and say that filename similarity is irrelevant and compare a
full N x M matrix of sources and destinations to find out which have the
most similar contents.  This optimization just adds another form of
filename similarity comparison, but augments it with a file content
similarity check as well.  Basically, if two files have the same
basename and are sufficiently similar to be considered a rename, mark
them as such without comparing the two to all other rename candidates.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 95 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 3 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 3eb49a098adf..001645624e71 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -384,10 +384,52 @@ static int find_basename_matches(struct diff_options *options,
 				 int minimum_score,
 				 int num_src)
 {
-	int i;
+	/*
+	 * When I checked in early 2020, over 76% of file renames in linux
+	 * just moved files to a different directory but kept the same
+	 * basename.  gcc did that with over 64% of renames, gecko did it
+	 * with over 79%, and WebKit did it with over 89%.
+	 *
+	 * Therefore we can bypass the normal exhaustive NxM matrix
+	 * comparison of similarities between all potential rename sources
+	 * and destinations by instead using file basename as a hint (i.e.
+	 * the portion of the filename after the last '/'), checking for
+	 * similarity between files with the same basename, and if we find
+	 * a pair that are sufficiently similar, record the rename pair and
+	 * exclude those two from the NxM matrix.
+	 *
+	 * This *might* cause us to find a less than optimal pairing (if
+	 * there is another file that we are even more similar to but has a
+	 * different basename).  Given the huge performance advantage
+	 * basename matching provides, and given the frequency with which
+	 * people use the same basename in real world projects, that's a
+	 * trade-off we are willing to accept when doing just rename
+	 * detection.
+	 *
+	 * If someone wants copy detection that implies they are willing to
+	 * spend more cycles to find similarities between files, so it may
+	 * be less likely that this heuristic is wanted.  If someone is
+	 * doing break detection, that means they do not want filename
+	 * similarity to imply any form of content similiarity, and thus
+	 * this heuristic would definitely be incompatible.
+	 */
+
+	int i, renames = 0;
 	struct strintmap sources;
 	struct strintmap dests;
 
+	/*
+	 * The prefeteching stuff wants to know if it can skip prefetching
+	 * blobs that are unmodified...and will then do a little extra work
+	 * to verify that the oids are indeed different before prefetching.
+	 * Unmodified blobs are only relevant when doing copy detection;
+	 * when limiting to rename detection, diffcore_rename[_extended]()
+	 * will never be called with unmodified source paths fed to us, so
+	 * the extra work necessary to check if rename_src entries are
+	 * unmodified would be a small waste.
+	 */
+	int skip_unmodified = 0;
+
 	/* Create maps of basename -> fullname(s) for sources and dests */
 	strintmap_init_with_options(&sources, -1, NULL, 0);
 	strintmap_init_with_options(&dests, -1, NULL, 0);
@@ -420,12 +462,59 @@ static int find_basename_matches(struct diff_options *options,
 			strintmap_set(&dests, base, i);
 	}
 
-	/* TODO: Make use of basenames source and destination basenames */
+	/* Now look for basename matchups and do similarity estimation */
+	for (i = 0; i < num_src; ++i) {
+		char *filename = rename_src[i].p->one->path;
+		const char *base = NULL;
+		intptr_t src_index;
+		intptr_t dst_index;
+
+		/* Find out if this basename is unique among sources */
+		base = get_basename(filename);
+		src_index = strintmap_get(&sources, base);
+		if (src_index == -1)
+			continue; /* not a unique basename; skip it */
+		assert(src_index == i);
+
+		if (strintmap_contains(&dests, base)) {
+			struct diff_filespec *one, *two;
+			int score;
+
+			/* Find out if this basename is unique among dests */
+			dst_index = strintmap_get(&dests, base);
+			if (dst_index == -1)
+				continue; /* not a unique basename; skip it */
+
+			/* Ignore this dest if already used in a rename */
+			if (rename_dst[dst_index].is_rename)
+				continue; /* already used previously */
+
+			/* Estimate the similarity */
+			one = rename_src[src_index].p->one;
+			two = rename_dst[dst_index].p->two;
+			score = estimate_similarity(options->repo, one, two,
+						    minimum_score, skip_unmodified);
+
+			/* If sufficiently similar, record as rename pair */
+			if (score < minimum_score)
+				continue;
+			record_rename_pair(dst_index, src_index, score);
+			renames++;
+
+			/*
+			 * Found a rename so don't need text anymore; if we
+			 * didn't find a rename, the filespec_blob would get
+			 * re-used when doing the matrix of comparisons.
+			 */
+			diff_free_filespec_blob(one);
+			diff_free_filespec_blob(two);
+		}
+	}
 
 	strintmap_clear(&sources);
 	strintmap_clear(&dests);
 
-	return 0;
+	return renames;
 }
 
 #define NUM_CANDIDATE_PER_DST 4
-- 
gitgitgadget

