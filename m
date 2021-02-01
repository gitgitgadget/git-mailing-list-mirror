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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1927BC433E6
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 12:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C04B764EA5
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 12:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhBAMsQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 07:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbhBAMsM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 07:48:12 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18128C061756
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 04:47:32 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id q7so16397925wre.13
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 04:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=McEu39H+C/Qincvr1lZST/EZjVZrFbTYDM7C70uLiZE=;
        b=AWnZr0hpBDh1cJdoUJD7SMZjQJ3Noeg5HeoFhEBL78zPx50WgLk2JhFEQC1kCpGuCH
         MMiIP0JyZtqPr6pNPhjPpfD2+YlJiZAmDKLsPsKK21Xyuq28jSSx1BKxbbICiweT1Xdp
         VRRrHtaSZZ0/Bkkbw9F/kAwwyocSi/UAwBnm/38FF8iYrp9zqnEsFtq7wwNYjxQa25p1
         TdLOtqPnWrq4hrZIHdBGlTDy2hBw/ZI2YzBZrs6Ef8ZIq/RFQJc9Q09yt1U8RTJT8drT
         X7fA8eyPwYULmQh2cq4M4/vwvJ7p9vGsE59l59Zf106EcIhkdxREFDjeEHSR2Zezxvir
         /ulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=McEu39H+C/Qincvr1lZST/EZjVZrFbTYDM7C70uLiZE=;
        b=ECK2t2nKbYK0f3pIJiXPZn1AlbMWQwYaqVoBuLXcBy0x59oBjVQBUJxu22e2KlWj4p
         AlHM1EHLg3P1+xY1rDTupZeG23ymMn6M9JqSn970jBazxTArrAlQUMvf1Jw4MAMpTLyC
         ybI7ZgcmGgEQ5aQMyUxgBTj+Ryuoib7+txKp5U6GuVR104c5ua1Qc/bZGZBokgZruAQm
         cefb2UfDRkZYwHBDBB3Oz0gbh2/F/lEhXFNUOYaLljR0smRyLfVfffJKu1Lm6vjlZjxT
         pKFxlOlsY4DFegRJ316Z9PR8OTxZwCyM9Af75E06dTnnNo4TixI6ez1k3oPBZ2P3mSqR
         73OQ==
X-Gm-Message-State: AOAM533nxryqUbV8eb8DvU4upYd6bCij1Stpp0YUx3Ci3OgPWva36Jzt
        NMgEZn1h2s71qZIyXid8M/HjaTVYLkQ=
X-Google-Smtp-Source: ABdhPJwdookc+TEStyQwt8cFz33yT+SiULKnGY3fzAdJTEKmZNvYkCZGI74URPzhgkSMZ7LwdFfaVw==
X-Received: by 2002:adf:ee0d:: with SMTP id y13mr18111948wrn.228.1612183650540;
        Mon, 01 Feb 2021 04:47:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m22sm27509884wrh.66.2021.02.01.04.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 04:47:29 -0800 (PST)
Message-Id: <2f80ae5fcb00d9d5c1b0502af45921cb20ebdf94.1612183647.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.852.v2.git.1612183647.gitgitgadget@gmail.com>
References: <pull.852.git.1611851095.gitgitgadget@gmail.com>
        <pull.852.v2.git.1612183647.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 12:47:24 +0000
Subject: [PATCH v2 2/5] commit-reach: use one walk in remove_redundant()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, me@ttaylorr.com,
        peff@peff.net, gitster@pobox.com,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The current implementation of remove_redundant() uses several calls to
paint_down_to_common() to determine that commits are independent of each
other. This leads to quadratic behavior when many inputs are passed to
commands such as 'git merge-base'.

For example, in the Linux kernel repository, I tested the performance
by passing all tags:

 git merge-base --independent $(git for-each-ref refs/tags --format="$(refname)")

(Note: I had to delete the tags v2.6.11-tree and v2.6.11 as they do
not point to commits.)

Here is the performance improvement introduced by this change:

 Before: 16.4s
  After:  1.1s

This performance improvement requires the commit-graph file to be
present. We keep the old algorithm around as remove_redundant_no_gen()
and use it when generation_numbers_enabled() is false. This is similar
to other algorithms within commit-reach.c. The new algorithm is
implemented in remove_redundant_with_gen().

The basic approach is to do one commit walk instead of many. First, scan
all commits in the list and mark their _parents_ with the STALE flag.
This flag will indicate commits that are reachable from one of the
inputs, except not including themselves. Then, walk commits until
covering all commits up to the minimum generation number pushing the
STALE flag throughout.

At the end, we need to clear the STALE bit from all of the commits
we walked. We move the non-stale commits in 'array' to the beginning of
the list, and this might overwrite stale commits. However, we store an
array of commits that started the walk, and use clear_commit_marks() on
each of those starting commits. That method will walk the reachable
commits with the STALE bit and clear them all. This makes the algorithm
safe for re-entry or for other uses of those commits after this walk.

This logic is covered by tests in t6600-test-reach.sh, so the behavior
does not change. This is tested both in the case with a commit-graph and
without.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-reach.c | 108 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 100 insertions(+), 8 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 9af51fe7e07..053676e51d0 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -156,15 +156,9 @@ struct commit_list *get_octopus_merge_bases(struct commit_list *in)
 	return ret;
 }
 
-static int remove_redundant(struct repository *r, struct commit **array, int cnt)
+static int remove_redundant_no_gen(struct repository *r,
+				   struct commit **array, int cnt)
 {
-	/*
-	 * Some commit in the array may be an ancestor of
-	 * another commit.  Move the independent commits to the
-	 * beginning of 'array' and return their number. Callers
-	 * should not rely upon the contents of 'array' after
-	 * that number.
-	 */
 	struct commit **work;
 	unsigned char *redundant;
 	int *filled_index;
@@ -210,12 +204,110 @@ static int remove_redundant(struct repository *r, struct commit **array, int cnt
 	for (i = filled = 0; i < cnt; i++)
 		if (!redundant[i])
 			array[filled++] = work[i];
+	for (j = filled, i = 0; i < cnt; i++)
+		if (redundant[i])
+			array[j++] = work[i];
 	free(work);
 	free(redundant);
 	free(filled_index);
 	return filled;
 }
 
+static int remove_redundant_with_gen(struct repository *r,
+				     struct commit **array, int cnt)
+{
+	int i, count_non_stale = 0;
+	timestamp_t min_generation = GENERATION_NUMBER_INFINITY;
+	struct commit **walk_start;
+	size_t walk_start_nr = 0, walk_start_alloc = cnt;
+	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
+
+	ALLOC_ARRAY(walk_start, walk_start_alloc);
+
+	/* Mark all parents of the input as STALE */
+	for (i = 0; i < cnt; i++) {
+		struct commit_list *parents;
+		timestamp_t generation;
+
+		repo_parse_commit(r, array[i]);
+		parents = array[i]->parents;
+
+		while (parents) {
+			repo_parse_commit(r, parents->item);
+			if (!(parents->item->object.flags & STALE)) {
+				parents->item->object.flags |= STALE;
+				ALLOC_GROW(walk_start, walk_start_nr + 1, walk_start_alloc);
+				walk_start[walk_start_nr++] = parents->item;
+				prio_queue_put(&queue, parents->item);
+			}
+			parents = parents->next;
+		}
+
+		generation = commit_graph_generation(array[i]);
+
+		if (generation < min_generation)
+			min_generation = generation;
+	}
+
+	/* push the STALE bits up to min generation */
+	while (queue.nr) {
+		struct commit_list *parents;
+		struct commit *c = prio_queue_get(&queue);
+
+		repo_parse_commit(r, c);
+
+		if (commit_graph_generation(c) < min_generation)
+			continue;
+
+		parents = c->parents;
+		while (parents) {
+			if (!(parents->item->object.flags & STALE)) {
+				parents->item->object.flags |= STALE;
+				prio_queue_put(&queue, parents->item);
+			}
+			parents = parents->next;
+		}
+	}
+
+	/* rearrange array */
+	for (i = count_non_stale = 0; i < cnt; i++) {
+		if (!(array[i]->object.flags & STALE))
+			array[count_non_stale++] = array[i];
+	}
+
+	/* clear marks */
+	for (i = 0; i < walk_start_nr; i++)
+		clear_commit_marks(walk_start[i], STALE);
+	free(walk_start);
+
+	return count_non_stale;
+}
+
+static int remove_redundant(struct repository *r, struct commit **array, int cnt)
+{
+	/*
+	 * Some commit in the array may be an ancestor of
+	 * another commit.  Move the independent commits to the
+	 * beginning of 'array' and return their number. Callers
+	 * should not rely upon the contents of 'array' after
+	 * that number.
+	 */
+	if (generation_numbers_enabled(r)) {
+		int i;
+
+		/*
+		 * If we have a single commit with finite generation
+		 * number, then the _with_gen algorithm is preferred.
+		 */
+		for (i = 0; i < cnt; i++) {
+			if (commit_graph_generation(array[i]) < GENERATION_NUMBER_INFINITY)
+				return remove_redundant_with_gen(r, array, cnt);
+		}
+	}
+
+	return remove_redundant_no_gen(r, array, cnt);
+}
+
 static struct commit_list *get_merge_bases_many_0(struct repository *r,
 						  struct commit *one,
 						  int n,
-- 
gitgitgadget

