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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D52C433E6
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 12:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 386E464EC0
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 12:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhBSMe7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 07:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhBSMez (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 07:34:55 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05F7C06178A
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 04:34:14 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id v62so7485116wmg.4
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 04:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xAt7oYKkKU6imCln9jYSjKatAsxBNkwtMhyYSMZ8sPw=;
        b=DNEqXPxEC35HV9J/wJm43VMruTyuXpNAEtHItblLaI1iWxxXXNzXnyEJbvcMCgMOxF
         lK4/iqdPGzSUn0BL8xs9FgWJln4r4DnLCDj5Y2hMtHYWSrPc9vKiEjx8yLWVQXhdenDW
         ynVCK2GnJ3u41iOYBcRbipW6XUnzTQECKf4s38iv8LfkUfGpOyQidXHnTYG/+6tK8e6z
         JIef2wmpc/yNS9xznUDywA62k+KseM6X7ZOlw195H4oxFLNoJnRAr3n1713dtFYhYBas
         qek6LAFCZ7s15btOAaRRoNs7LegGHu/BgQjVuafADIn/PSVBKC9cllpI+ulIin9EwrFI
         m0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xAt7oYKkKU6imCln9jYSjKatAsxBNkwtMhyYSMZ8sPw=;
        b=cpV6SJZ0enwNWyjiTD8vL9KoURXRLPeCdiHBROSnOqJNSFhIdIM+0FfKJSTO+aYTXB
         VlzRElhb36iWhxCFNiEganFQBabL7n5aaa309kSpw8xPc6NGOvrOwQtcW4ZcblF72zx/
         3Pxu7v4u1hI35R3A56VqgF0SOxGOlSR5NCs4soQJpIryxA19ltmvEKxL+M4Rwl3uia4O
         yZNYqaKnJvEytHVwsYy6tHT18QN3opOjlo2t3CPaayLtQTC/vW2H/sQJB77JdX7nI0fI
         5McKl1MKH2kBYpe6LKzZUeNVLYRl19vXVxlZ+0KW7RvsrzksWw4rZqfnQxGfKno6QpZG
         237Q==
X-Gm-Message-State: AOAM532N3DbXlzoobm1indNAT2L7+RKsq6B5FGrbh/lnL8fAupE/VliS
        8DGpusQabLlyXcgIkVwBw4fC/9OmdOY=
X-Google-Smtp-Source: ABdhPJzk+no6XVTkFJZSWkONeU1BLwzXFafKYtfpFNQ8YN8NSrZzbYEGvtwD5dEGiiPbR1kzxJ8HpQ==
X-Received: by 2002:a1c:20c3:: with SMTP id g186mr8018617wmg.59.1613738053455;
        Fri, 19 Feb 2021 04:34:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7sm13439105wre.78.2021.02.19.04.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 04:34:13 -0800 (PST)
Message-Id: <c2c08989ce60ef6892eb1c206483834d750a70c6.1613738051.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.852.v3.git.1613738051.gitgitgadget@gmail.com>
References: <pull.852.v2.git.1612183647.gitgitgadget@gmail.com>
        <pull.852.v3.git.1613738051.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Feb 2021 12:34:07 +0000
Subject: [PATCH v3 2/5] commit-reach: use one walk in remove_redundant()
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
 commit-reach.c | 104 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 96 insertions(+), 8 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 9af51fe7e078..7a3a1eb1a26e 100644
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
@@ -216,6 +210,100 @@ static int remove_redundant(struct repository *r, struct commit **array, int cnt
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
+	clear_commit_marks_many(walk_start_nr, walk_start, STALE);
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

