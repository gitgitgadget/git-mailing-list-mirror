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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B789CC433DB
	for <git@archiver.kernel.org>; Sat,  6 Feb 2021 22:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BC6D64E34
	for <git@archiver.kernel.org>; Sat,  6 Feb 2021 22:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhBFWxG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Feb 2021 17:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhBFWxF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Feb 2021 17:53:05 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6340C061788
        for <git@vger.kernel.org>; Sat,  6 Feb 2021 14:52:24 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id i5so1160269wmq.2
        for <git@vger.kernel.org>; Sat, 06 Feb 2021 14:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xVW8AYkO+CVDw+SAvP5by0Z6h9oLqD7qr93LMHFcLQk=;
        b=MmnK4QPrwlnBG4QQeOjYqYSwTMj/2jE61DbuMyZTa3Q0elqlcVdgFx5Fk8ZjxIWZfp
         3WY5jpmZzoaoH8p4Q8KSmuU0j14S/7XpIj1mx8BdVziOQf/ENV+sNAqT33gJJhtbKHWb
         F86kG54NSywpoYn0P5aihAErqHDuVffh6aRPIhUuDpU2EUFxTy2yJyxSal8yjjtQGUZ/
         JbKN7+DQnViwep7NxYcHqHK2xBS/wxQZZE8YSuoqMdCjzI04cTEzt2R8roeDwgWva0PT
         a70sJ+QniwtY/eWy0dm3EpwBvkpipNP2CaUfLBAfXdf+yoQ9HjteGS7n7Xxs6zo23I4N
         pC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xVW8AYkO+CVDw+SAvP5by0Z6h9oLqD7qr93LMHFcLQk=;
        b=i1wuo+U72ultJl/RaNWvF1g3oDwMsgaHdE4FkCfg/xLcKAQHEvGXjU5/srRZyS1575
         ePONRy2XB1Cb0ry3dDz97nCmBSntIw6lv04Sn34SA2tsUldSCztdqU2iqKBpmgUXR4gW
         kYwjWPaG9wz0RED9kMrc89JCWsn9IYeMhBPx5wwC305CWkfHCfzU1CG/291Q4wsREGCo
         hCue6UGuHKBJ28wfpN9kl4EQ5pc9KMdkxeIFFk2pSTeWAg7N7g6IAT5/Ilh3NYS8flHV
         oIqLKgkvCxgQONNu+66VbjVsoN56MDr2X19b4bNOLZXeb4PE+ja2kFfUFqfPQ2zFy0+D
         dXrw==
X-Gm-Message-State: AOAM531Y3cC4sbsOgPnD8oCFIJhHY2SyEltPWd4pRIILU1Bs10uuLO4/
        HuyQilAZE4RpyXL1cskO24jlqIPutQU=
X-Google-Smtp-Source: ABdhPJzLfevJSJkHnfvNeeBqWnYoGIXJMe0l1DAMiLn+0imAiGon3nKyjkErWkAWxuxbUYO6TnuZeg==
X-Received: by 2002:a1c:6208:: with SMTP id w8mr8730829wmb.99.1612651941084;
        Sat, 06 Feb 2021 14:52:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t7sm3128564wrv.75.2021.02.06.14.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 14:52:20 -0800 (PST)
Message-Id: <5fb4493247ff4676abd11eb47b1db3111e043fb5.1612651937.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.843.git.1612651937.gitgitgadget@gmail.com>
References: <pull.843.git.1612651937.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 06 Feb 2021 22:52:16 +0000
Subject: [PATCH 2/3] diffcore-rename: complete find_basename_matches()
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

Note that this optimization might give us different results than without
the optimization, because it's possible that despite files with the same
basename being sufficiently similar to be considered a rename, there's
an even better match between files without the same basename.  I think
that is okay for four reasons: (1) That seems somewhat unlikely in
practice, (2) it's easy to explain to the users what happened if it does
ever occur (or even for them to intuitively figure out), and (3) as the
next patch will show it provides such a large performance boost that
it's worth the tradeoff.  Reason (4) takes a full paragraph to
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

We do not use this heuristic together with either break or copy
detection.  The point of break detection is to say that filename
similarity does not imply file content similarity, and we only want to
know about file content similarity.  The point of copy detection is to
use more resources to check for additional similarities, while this is
an optimization that uses far less resources but which might also result
in finding slightly fewer similarities.  So the idea behind this
optimization goes against both of those features, and will be turned off
for both.

Note that this optimization is not yet effective in any situation, as
the function is still unused.  The next commit will hook it into the
code so that it is used when rename detection is wanted, but neither
copy nor break detection are.

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

