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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EACC433E0
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 16:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6E0164DED
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 16:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbhA1Q0A (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 11:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbhA1QZi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 11:25:38 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BD2C061574
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 08:24:58 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id c12so6011267wrc.7
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 08:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HLFpZg7uyOxrf2psQbC56MyjR+W5113nsSJjBR38XRU=;
        b=K+Hvv+Hy1isT0qWPvByOy9VvGNhY5BY0yVevfCXu9HBqy3ClQcQgmh3XQVLuGOHG45
         FtRf+BBU9bOidnr62OOeyS0zI1CTA38o1PrzsUhzb3yW/fhCGWoVp2DLMHmozCU+FBNX
         N5UYNaTAGic3rwtmGJf8jBRetKly8zS7DZQv2q5coHimea5IREsEp0WZyQJ+OoaCv9U4
         7DFxq7rTff/oJPHHCvJ2P0wYRutabEu7cZ19cswrVg7/sEIB7kcvWyJgXoM9BYqh6Ma9
         jZG/CBvUiP8qZdUt5qfQxX1SoaEaEqX6sxgK6L9AbLZH9cDr4QzCBBG9R5nm51ekqbPo
         2T6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HLFpZg7uyOxrf2psQbC56MyjR+W5113nsSJjBR38XRU=;
        b=dGXAzINvTIuV/0POiohSpRFvukU9DNv+9Ry+mBUxNKOpAFC2DEEJ4StRJPG9rx4cYJ
         ynq/rrC/BYd3DzwJKqv4ZNXbvczCQtUU2b/9JgeVPev2zd1pYH0JE47Aylf7oqturmCJ
         faDGtGb8o3DB2EYSEa7QJyadaIBQnADvQn/xKAJcZRGhbqelwUNkjcqy5MrvlAKHvsaS
         YV4iZpObqTks7zxLYck7xaPZ4Vmja5dV61YxjHRqNM8f6tY0PFaB+HwM5kVBcxPxTh3T
         Ttq+u7e84wLWbGmmgnovQZ5Uv4l/ioB2a47wNkToQRTkXfc/DrUt0kmZ8ccKkqPeb85o
         A5SA==
X-Gm-Message-State: AOAM532P7qDqsySpla2PydvVAWGCfWNdQc/uMSnlsgqu2XDm71N0YeQn
        Sci+iy7YvHASAbIvZOw9RScDs3/LAsc=
X-Google-Smtp-Source: ABdhPJwFQca6/6a0TQcspdLb5rDn8+BC7vjT8Wm58TmDuWpenfeX19aVXdfJQ1i3Oy3qiB6th49SYQ==
X-Received: by 2002:adf:a40e:: with SMTP id d14mr17201494wra.144.1611851096912;
        Thu, 28 Jan 2021 08:24:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h16sm7563721wrq.29.2021.01.28.08.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 08:24:56 -0800 (PST)
Message-Id: <3fe74e339fc5b7083398f2df51baae5a4a008060.1611851095.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.852.git.1611851095.gitgitgadget@gmail.com>
References: <pull.852.git.1611851095.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 Jan 2021 16:24:52 +0000
Subject: [PATCH 1/3] commit-reach: use one walk in remove_redundant()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, me@ttaylorr.com,
        peff@peff.net, gitster@pobox.net,
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

The basic approach is to do one commit walk instead of many. First, scan
all commits in the list and mark their _parents_ with the STALE flag.
This flag will indicate commits that are reachable from one of the
inputs, except not including themselves. Then, walk commits until
covering all commits up to the minimum generation number pushing the
STALE flag throughout.

At the end of the walk, commits in the input list that have the STALE
flag are reachable from a _different_ commit in the list. These should
be moved to the end of the array while the others are shifted to the
front.

This logic is covered by tests in t6600-test-reach.sh, so the behavior
does not change.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-reach.c | 108 +++++++++++++++++++++++++++++--------------------
 1 file changed, 65 insertions(+), 43 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index e38771ca5a1..677f6f7c3f3 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -164,58 +164,80 @@ static int remove_redundant(struct repository *r, struct commit **array, int cnt
 	 * the array, and return the number of commits that
 	 * are independent from each other.
 	 */
-	struct commit **work;
-	unsigned char *redundant;
-	int *filled_index;
-	int i, j, filled;
+	int i, count_non_stale = 0;
+	timestamp_t min_generation = GENERATION_NUMBER_INFINITY;
+	struct commit **dup;
+	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
 
-	work = xcalloc(cnt, sizeof(*work));
-	redundant = xcalloc(cnt, 1);
-	ALLOC_ARRAY(filled_index, cnt - 1);
+	/* Mark all parents of the input as STALE */
+	for (i = 0; i < cnt; i++) {
+		struct commit_list *parents;
+		timestamp_t generation;
 
-	for (i = 0; i < cnt; i++)
 		repo_parse_commit(r, array[i]);
-	for (i = 0; i < cnt; i++) {
-		struct commit_list *common;
-		timestamp_t min_generation = commit_graph_generation(array[i]);
+		parents = array[i]->parents;
+
+		while (parents) {
+			repo_parse_commit(r, parents->item);
+			if (!(parents->item->object.flags & STALE)) {
+				parents->item->object.flags |= STALE;
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
 
-		if (redundant[i])
+		if (commit_graph_generation(c) < min_generation)
 			continue;
-		for (j = filled = 0; j < cnt; j++) {
-			timestamp_t curr_generation;
-			if (i == j || redundant[j])
-				continue;
-			filled_index[filled] = j;
-			work[filled++] = array[j];
 
-			curr_generation = commit_graph_generation(array[j]);
-			if (curr_generation < min_generation)
-				min_generation = curr_generation;
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
+	dup = xcalloc(cnt, sizeof(struct commit *));
+	COPY_ARRAY(dup, array, cnt);
+	for (i = 0; i < cnt; i++) {
+		if (dup[i]->object.flags & STALE) {
+			int insert = cnt - 1 - (i - count_non_stale);
+			array[insert] = dup[i];
+		} else {
+			array[count_non_stale] = dup[i];
+			count_non_stale++;
+		}
+	}
+	free(dup);
+
+	/* clear marks */
+	for (i = 0; i < cnt; i++) {
+		struct commit_list *parents;
+		parents = array[i]->parents;
+
+		while (parents) {
+			clear_commit_marks(parents->item, STALE);
+			parents = parents->next;
 		}
-		common = paint_down_to_common(r, array[i], filled,
-					      work, min_generation);
-		if (array[i]->object.flags & PARENT2)
-			redundant[i] = 1;
-		for (j = 0; j < filled; j++)
-			if (work[j]->object.flags & PARENT1)
-				redundant[filled_index[j]] = 1;
-		clear_commit_marks(array[i], all_flags);
-		clear_commit_marks_many(filled, work, all_flags);
-		free_commit_list(common);
 	}
 
-	/* Now collect the result */
-	COPY_ARRAY(work, array, cnt);
-	for (i = filled = 0; i < cnt; i++)
-		if (!redundant[i])
-			array[filled++] = work[i];
-	for (j = filled, i = 0; i < cnt; i++)
-		if (redundant[i])
-			array[j++] = work[i];
-	free(work);
-	free(redundant);
-	free(filled_index);
-	return filled;
+	return count_non_stale;
 }
 
 static struct commit_list *get_merge_bases_many_0(struct repository *r,
-- 
gitgitgadget

