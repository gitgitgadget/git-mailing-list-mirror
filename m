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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F935C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 11:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CDAF64E10
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 11:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhBILmd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 06:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhBILfw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 06:35:52 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC90C0617AA
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 03:32:11 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id n6so8347391wrv.8
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 03:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=86fSnceyhV/8DTgGkIT35jFDjF2lBabCuua7RBFVi2U=;
        b=tYsQUs6mHwwakkarqysmPvjLVis1MqQuSblPmM0Gl5a7Xs5t6kR/r8zU0pLg8L1wwa
         FOTfypSvhQw3erkMQUzW9bjQU04By1dZTxesuTcW4i+HiEIYGibJX7oGl1zv29ekzPMT
         xUgLJcnAtaXkvh6DdL81AP18+qGM+ZFq+s0EFLPHTT40V1naMBHDOdrDd7PY4RQwyVc5
         FdNg3cItcGn2YccDfBdfdsvohPahZ7QW4aKBayieo5oFYOdxv4yXp4Yz24g90dxr9t5Q
         vHN54rVQoAqIiOUWHEUZxCerTQkfViIVwGIrC1yyO/2RGJADPveMJAJfOHB5pW2htG8q
         H0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=86fSnceyhV/8DTgGkIT35jFDjF2lBabCuua7RBFVi2U=;
        b=b2b7leDcvpJXnIxWnqhyuOrxTpQs3/zDTPEybPuzo1BKmgVWB38sRGppWvkElBEbHQ
         e2Opl6slmiMYuVpZN275ZWt8lx/SkzX9Nd9i5CH2XkbnfV4KGzmFdTIVXO9G3hAvLJqo
         76jHdZSApOsw37i7kX36NppHQJAsxc4h31j85GMzwoO7NbVJ3Bsijeo+1RL3dsG4A3mX
         cKWh0P3kMw5wyFP+mz5AzW77tV4TLXMTRdpY8k4rkhe3/k15F8UkYy2yLFTTayMTItbJ
         Gd/cIHpM9a/B8NJbRxb45kkjVOqN8QFqVZ/CcBBFJiTIgg5hP4IkVCiqXwTbHU9agGKw
         GqzA==
X-Gm-Message-State: AOAM530kiTmdU2xajPy/NZ/xkvdg0DUQHCdN0sHkoBr6OsPZ3tjcB0kg
        pzX/Zz+xGeRQnUjouOJRVgOlZFf562k=
X-Google-Smtp-Source: ABdhPJwyUszkZkRay45lqkDYrb8EIW/EGkN5UpHHk/pMU4Li8pnrl7PTmSoG0lUL1U9ZHWoJhNE82g==
X-Received: by 2002:a5d:58e7:: with SMTP id f7mr2131422wrd.114.1612870330288;
        Tue, 09 Feb 2021 03:32:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o13sm4138086wmh.2.2021.02.09.03.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 03:32:09 -0800 (PST)
Message-Id: <dcd0175229aa6fba576425e78875b95385acb58d.1612870326.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
References: <pull.843.git.1612651937.gitgitgadget@gmail.com>
        <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Feb 2021 11:32:04 +0000
Subject: [PATCH v2 2/4] diffcore-rename: complete find_basename_matches()
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
 diffcore-rename.c | 94 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 91 insertions(+), 3 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 1c52077b04e5..b1dda41de9b1 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -372,10 +372,48 @@ static int find_basename_matches(struct diff_options *options,
 				 int minimum_score,
 				 int num_src)
 {
-	int i;
+	/*
+	 * When I checked, over 76% of file renames in linux just moved
+	 * files to a different directory but kept the same basename.  gcc
+	 * did that with over 64% of renames, gecko did it with over 79%,
+	 * and WebKit did it with over 89%.
+	 *
+	 * Therefore we can bypass the normal exhaustive NxM matrix
+	 * comparison of similarities between all potential rename sources
+	 * and destinations by instead using file basename as a hint, checking
+	 * for similarity between files with the same basename, and if we
+	 * find a pair that are sufficiently similar, record the rename
+	 * pair and exclude those two from the NxM matrix.
+	 *
+	 * This *might* cause us to find a less than optimal pairing (if
+	 * there is another file that we are even more similar to but has a
+	 * different basename).  Given the huge performance advantage
+	 * basename matching provides, and given the frequency with which
+	 * people use the same basename in real world projects, that's a
+	 * trade-off we are willing to accept when doing just rename
+	 * detection.  However, if someone wants copy detection that
+	 * implies they are willing to spend more cycles to find
+	 * similarities between files, so it may be less likely that this
+	 * heuristic is wanted.
+	 */
+
+	int i, renames = 0;
 	struct strintmap sources;
 	struct strintmap dests;
 
+	/*
+	 * The prefeteching stuff wants to know if it can skip prefetching blobs
+	 * that are unmodified.  unmodified blobs are only relevant when doing
+	 * copy detection.  find_basename_matches() is only used when detecting
+	 * renames, not when detecting copies, so it'll only be used when a file
+	 * only existed in the source.  Since we already know that the file
+	 * won't be unmodified, there's no point checking for it; that's just a
+	 * waste of resources.  So set skip_unmodified to 0 so that
+	 * estimate_similarity() and prefetch() won't waste resources checking
+	 * for something we already know is false.
+	 */
+	int skip_unmodified = 0;
+
 	/* Create maps of basename -> fullname(s) for sources and dests */
 	strintmap_init_with_options(&sources, -1, NULL, 0);
 	strintmap_init_with_options(&dests, -1, NULL, 0);
@@ -412,12 +450,62 @@ static int find_basename_matches(struct diff_options *options,
 			strintmap_set(&dests, base, i);
 	}
 
-	/* TODO: Make use of basenames source and destination basenames */
+	/* Now look for basename matchups and do similarity estimation */
+	for (i = 0; i < num_src; ++i) {
+		char *filename = rename_src[i].p->one->path;
+		char *base = NULL;
+		intptr_t src_index;
+		intptr_t dst_index;
+
+		/* Get the basename */
+		base = strrchr(filename, '/');
+		base = (base ? base+1 : filename);
+
+		/* Find out if this basename is unique among sources */
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

