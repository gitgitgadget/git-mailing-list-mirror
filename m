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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8191C433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 12:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 862C164E9C
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 12:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhBAMsz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 07:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbhBAMsw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 07:48:52 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D12C061786
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 04:47:35 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id q7so16398128wre.13
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 04:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xm/UiSpbTXoKk2g5inAlTT9sD+QpBzXhqkyj6DUNqBY=;
        b=YA6vKY0xcGko+hut4mPgyiHFVDeejDyKprDxzokgkS7SAwOD1zGRqagiia6mVpNyS0
         bpogd4SouCN9TaTCxvdMKz3q1b3E5YJEXnxZ6qN87weamPz9hwCUArwmkWd8Ayp70JZI
         gWIq41ESbmZDhZSmzshhkvCVyziMpH328ocPh/zrQ1VGcbbnFsf0pESFJzgbOUa6EPWc
         eYp5QS5VGFelHRhC7YtyxBI7zUJd1wjNivX2X/mdtNAoaIythpsIi9P2ztpJTbbohtas
         yGbYfjBYgBN7T5wW79HcrOkiddS6h6c+jP6626oUW6Kv0nlEkVB6PJPsju8pGZDZ+LIC
         BDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xm/UiSpbTXoKk2g5inAlTT9sD+QpBzXhqkyj6DUNqBY=;
        b=czgg0HTtdiRYcI+1IKGrR1IBUpvyUyXdWtJEFHJzj9x84MNeHX4t4O5BV9uh86XZI+
         ZX4sSlrL1+JWMyzPNUYgR8T6I1aR+EJ4iX2od911Oa1pnClNBSg4v5qHCxxeDKSK+8zK
         tD/W0nRkzZJ/3L1wcWr2XkvSsMJ4GqcapXUgtsE5uPlNRt4E7B+PiEfpkA13d3om3wG+
         1iCny1sGpTVGYmOkceq1Fr4nGPdyohAWVXFM5Tl/FMPT7GCxY/1bekHlMPCOhD3aeEXt
         1RnUKDjYyeoXFFLXJ/cshITb7r74tgAnbKApBOCAlWtBl2OOKSNMZlyQGXfQ6TgWQN6j
         V18w==
X-Gm-Message-State: AOAM5327gPVv1TkDP9Cg70DfjjKbwwaBIc8lmnlYiDfE9/LNkpgTQ6HI
        udPnIa6zVue2MbiFj6uhDFS/j1/nHpc=
X-Google-Smtp-Source: ABdhPJzrhr2+l6uGKpNAGKKojn8G494nuxsr3Bi+tNHuQ5Xo1sAAwHaqXsbjJVVFVpjMuuo9jAO9pA==
X-Received: by 2002:adf:f4c1:: with SMTP id h1mr18091723wrp.102.1612183654248;
        Mon, 01 Feb 2021 04:47:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i6sm27554404wrs.71.2021.02.01.04.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 04:47:33 -0800 (PST)
Message-Id: <14f0974c987215bd36e91450c1a6ebc6d5732121.1612183647.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.852.v2.git.1612183647.gitgitgadget@gmail.com>
References: <pull.852.git.1611851095.gitgitgadget@gmail.com>
        <pull.852.v2.git.1612183647.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 12:47:27 +0000
Subject: [PATCH v2 5/5] commit-reach: stale commits may prune generation
 further
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

The remove_redundant_with_gen() algorithm performs a depth-first-search
to find commits in the 'array' list, starting at the parents of each
commit in 'array'. The result is that commits in 'array' are marked
STALE when they are reachable from another commit in 'array'.

This depth-first-search is fast when commits lie on or near the
first-parent history of the higher commits. The search terminates early
if all but one commit becomes marked STALE.

However, it is possible that there are two independent commits with high
generation number. In that case, the depth-first-search might languish
by searching in lower generations due to the fixed min_generation used
throughout the method.

With the expectation that commits with lower generation are expected to
become STALE more often, we can optimize further by increasing that
min_generation boundary upon discovery of the commit with minimum
generation.

We must first sort the commits in 'array' by generation. We cannot sort
'array' itself since it must preserve relative order among the returned
results (see revision.c:mark_redundant_parents() for an example).

This simplifies the initialization of min_generation, but it also allows
us to increase the new min_generation when we find the commit with
smallest generation remaining.

This requires more than two commits in order to test, so I used the
Linux kernel repository with a few commits that are slightly off of the
first-parent history. I timed the following command:

  git merge-base --independent 2ecedd756908 d2360a398f0b \
	1253935ad801 160bab43419e 0e2209629fec 1d0e16ac1a9e

The first two commits have similar generation and are near the v5.10
tag. Commit 160bab43419e is off of the first-parent history behind v5.5,
while the others are scattered somewhere reachable from v5.9. This is
designed to demonstrate the optimization, as that commit within v5.5
would normally cause a lot of extra commit walking.

Since remove_redundant_with_alg() is called only when at least one of
the input commits has a finite generation number, this algorithm is
tested with a commit-graph generated starting at a number of different
tags, the earliest being v5.5.

commit-graph at v5.5:

 | Method                | Time  |
 |-----------------------+-------|
 | *_no_gen()            | 864ms |
 | *_with_gen() (before) | 858ms |
 | *_with_gen() (after)  | 810ms |

commit-graph at v5.7:

 | Method                | Time  |
 |-----------------------+-------|
 | *_no_gen()            | 625ms |
 | *_with_gen() (before) | 572ms |
 | *_with_gen() (after)  | 517ms |

commit-graph at v5.9:

 | Method                | Time  |
 |-----------------------+-------|
 | *_no_gen()            | 268ms |
 | *_with_gen() (before) | 224ms |
 | *_with_gen() (after)  | 202ms |

commit-graph at v5.10:

 | Method                | Time  |
 |-----------------------+-------|
 | *_no_gen()            |  72ms |
 | *_with_gen() (before) |  37ms |
 | *_with_gen() (after)  |   9ms |

Note that these are only modest improvements for the case where the two
independent commits are not in the commit-graph (not until v5.10). All
algorithms get faster as more commits are indexed, which is not a
surprise. However, the cost of walking extra commits is more and more
prevalent in relative terms as more commits are indexed. Finally, the
last case allows us to jump to the minimum generation between the last
two commits (that are actually independent) so we greatly reduce the
cost in that case.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-reach.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index d3a6e2bdd04..c2e0747fea4 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -237,15 +237,27 @@ static int remove_redundant_with_gen(struct repository *r,
 {
 	int i, count_non_stale = 0, count_still_independent = cnt;
 	timestamp_t min_generation = GENERATION_NUMBER_INFINITY;
-	struct commit **walk_start;
+	struct commit **walk_start, **sorted;
 	size_t walk_start_nr = 0, walk_start_alloc = cnt;
+	int min_gen_pos = 0;
+
+	/*
+	 * Sort the input by generation number, ascending. This allows
+	 * us to increase the "min_generation" limit when we discover
+	 * the commit with lowest generation is STALE. The index
+	 * min_gen_pos points to the current position within 'array'
+	 * that is not yet known to be STALE.
+	 */
+	ALLOC_ARRAY(sorted, cnt);
+	COPY_ARRAY(sorted, array, cnt);
+	QSORT(sorted, cnt, compare_commits_by_gen);
+	min_generation = commit_graph_generation(sorted[0]);
 
 	ALLOC_ARRAY(walk_start, walk_start_alloc);
 
 	/* Mark all parents of the input as STALE */
 	for (i = 0; i < cnt; i++) {
 		struct commit_list *parents;
-		timestamp_t generation;
 
 		repo_parse_commit(r, array[i]);
 		array[i]->object.flags |= RESULT;
@@ -260,11 +272,6 @@ static int remove_redundant_with_gen(struct repository *r,
 			}
 			parents = parents->next;
 		}
-
-		generation = commit_graph_generation(array[i]);
-
-		if (generation < min_generation)
-			min_generation = generation;
 	}
 
 	QSORT(walk_start, walk_start_nr, compare_commits_by_gen);
@@ -296,6 +303,12 @@ static int remove_redundant_with_gen(struct repository *r,
 				c->object.flags &= ~RESULT;
 				if (--count_still_independent <= 1)
 					break;
+				if (oideq(&c->object.oid, &sorted[min_gen_pos]->object.oid)) {
+					while (min_gen_pos < cnt - 1 &&
+					       (sorted[min_gen_pos]->object.flags & STALE))
+						min_gen_pos++;
+					min_generation = commit_graph_generation(sorted[min_gen_pos]);
+				}
 			}
 
 			if (commit_graph_generation(c) < min_generation) {
@@ -319,6 +332,7 @@ static int remove_redundant_with_gen(struct repository *r,
 		}
 		free_commit_list(stack);
 	}
+	free(sorted);
 
 	/* clear result */
 	for (i = 0; i < cnt; i++)
-- 
gitgitgadget
