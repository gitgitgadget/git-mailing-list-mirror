Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5065C433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 21:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344840AbiCWVJn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 17:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243265AbiCWVJm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 17:09:42 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1D51EEC0
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 14:08:11 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id q11-20020a170902c9cb00b001546680ee18so1436556pld.7
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 14:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=lJX3OEeLLWhYP3mK6SpzYgAFOFOgPIFoT//1ApGQSMQ=;
        b=gY24mo9ITKIdBFefr5wRWmNNs4hyi2JUcVcmtYGqd7CNAECnzA55w55QsSRsSK7K22
         FfvEBqBBz6+7v4mUDHNDyUv5fIobN+Xti5/a2diP79l5XE+LDoBQXZbe2qlHlR4LKW9F
         PDXtGjr7MdrmnI/cWHQh/zJANfIyW3EBrPIK/koBFVrZEVb9WMCgueOuuDkbN4PiORjj
         p18JhNq1I5K5YShf9AHY29nza4+PhJHV2BcWuP0W97RRTsl1+n2+0r6f4GugiMnshaGQ
         IdybyxJMU2NF4DySlY4y79CI73gNtRxbxY1R5hvNRiTthR9fShvdWSIddtjYp7cE7EQF
         FKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=lJX3OEeLLWhYP3mK6SpzYgAFOFOgPIFoT//1ApGQSMQ=;
        b=N6788+zs0jteyioIp8AZ6RdI9rhCvtI/oTSSRXc28vl1YOjPbPdFHnmyftSZJFXlyM
         UW2i65heNPjzeFZwGGMJL7ok4bTqdd/NCLoKUyMoj2V8zlUrAjCz51GTKsfmzynEDtCc
         sOmyQqfW2jgU47FSr82AyPBw4tHI5fi/H9qTv5pnSgBnsJO0I+Z/LE2Q79Hsbb87Q0rB
         FJ4vZWkxMjjfVRQEsmcwZ8fFMt+hAF68fOxPOJtmcehsTU8P+Z27RQy6isvPF3yQt8tt
         BQW4sXWGczZHvqWReS9tqy/Xp8kgyCi18zLwzuQvHf+2sYr6Whv3xA9byFC5OWwwI1d2
         AWdQ==
X-Gm-Message-State: AOAM532Gi2VomgYQEzGwg2Yjd4KrjchB3I+3X2Z6UnFg7IdBdhEmaRVa
        YiI4xGcT+aMOZJYiPlhoJs7RllEiXKUbeNJlJOfs/aBeXUAUZH9r1J4fKAvlft0WAiscab4ab/R
        eKgY9fa7PWzvSP+u4MhJKIoNezHPeiNZ9mEA3Fuh0TVnzYyCRDQNN0YSIAykjVf/lMQbuvPOUJs
        AB
X-Google-Smtp-Source: ABdhPJwSlfsCy3YTfbjlsYkYn/SK0ksffvrSfBMt8drDkC049/PI+0R41V0+9qwM31AIMw42WqPbprv9dahGlxVxt1+L
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:e81:b0:1c6:5a9c:5afa with
 SMTP id fv1-20020a17090b0e8100b001c65a9c5afamr184646pjb.1.1648069690158; Wed,
 23 Mar 2022 14:08:10 -0700 (PDT)
Date:   Wed, 23 Mar 2022 14:08:02 -0700
Message-Id: <20220323210803.1130790-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH] commit-reach: do not parse and iterate minima
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a commit is parsed, it pretends to have a different (possibly
empty) list of parents if there is graft information for that commit.
But there is a bug that could occur when a commit is parsed, the graft
information is updated (for example, when a shallow file is rewritten),
and the same commit is subsequently used: the parents of the commit do
not conform to the updated graft information, but the information at the
time of parsing.

This is usually not an issue, as a commit is usually introduced into the
repository at the same time as its graft information. That means that
when we try to parse that commit, we already have its graft information.

However, this is not the case when fetching with --update-shallow. In
post_assign_shallow() in shallow.c, a revision walk is done that also
parses commits at the shallow boundary before updating the shallow
information (and hence, the graft information). (This revision walk
needs to be done before the update because the nature of the update
depends on the outcome of the revision walk.) If we were to
revision-walk such a commit (at the shallow boundary), we would end up
trying and failing to parse its parents because its list of parents is
not empty (since it was parsed before there was any graft information
telling us to conceal its parents). This revision walk will happen if
the client has submodules, as it will revision-walk the fetched commits
to check for new submodules, triggering this bug.

This revision walk in post_assign_shallow() actually does not need to go
beyond the shallow boundaries, so the solution is twofold: (1) do not
iterate beyond such commits, and (2) in doing so, we no longer need to
parse them, so do not parse them.

To do (1), do something similar to d7c1ec3efd ("commit: add
short-circuit to paint_down_to_common()", 2018-05-22), which taught
paint_down_to_common() the concept of "min_generation": commits older
than that generation do not need to be iterated over. Introduce yet
another parameter that indicates whether "one" is of that minimum
generation. If yes, we never need to iterate over its ancestors, so we
do not need to add it to the priority queue in the first place. And if
we reach it (because another input commit has it as an ancestor), we do
not need to add its parents to the priority queue. There are only a few
callers, so update all of them (including the one that matters for this
bug - repo_in_merge_bases_many()) to indicate whether we know that "one"
is of the minimum generation.

To do (2), just delete the code that parses it.

This solves the problem, because the commit is now only parsed during
the revision walk that checks for new submodules, which happens after
the shallow information is written.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
This is on jt/reset-grafts-when-resetting-shallow.

I tried figuring out a better reproduction recipe, but couldn't (I
couldn't figure out what the local repo should contain with respect to
the remote repo in order to reproduce this bug without just modifying an
existing test). If anyone has any suggestions, please let me know.
---
 commit-reach.c           | 25 +++++++++++++++----------
 t/t5537-fetch-shallow.sh |  8 ++++++--
 2 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index c226ee3da4..7f4f3f7424 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -47,11 +47,15 @@ static int queue_has_nonstale(struct prio_queue *queue)
 	return 0;
 }
 
-/* all input commits in one and twos[] must have been parsed! */
+/*
+ * All input commits in twos[] must have been parsed. If
+ * one_is_at_min_generation is false, one must also have be parsed.
+ */
 static struct commit_list *paint_down_to_common(struct repository *r,
 						struct commit *one, int n,
 						struct commit **twos,
-						timestamp_t min_generation)
+						timestamp_t min_generation,
+						int one_is_at_min_generation)
 {
 	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
 	struct commit_list *result = NULL;
@@ -66,7 +70,8 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 		commit_list_append(one, &result);
 		return result;
 	}
-	prio_queue_put(&queue, one);
+	if (!one_is_at_min_generation)
+		prio_queue_put(&queue, one);
 
 	for (i = 0; i < n; i++) {
 		twos[i]->object.flags |= PARENT2;
@@ -97,6 +102,10 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 			/* Mark parents of a found merge stale */
 			flags |= STALE;
 		}
+
+		if (commit == one && one_is_at_min_generation)
+			continue;
+
 		parents = commit->parents;
 		while (parents) {
 			struct commit *p = parents->item;
@@ -138,7 +147,7 @@ static struct commit_list *merge_bases_many(struct repository *r,
 			return NULL;
 	}
 
-	list = paint_down_to_common(r, one, n, twos, 0);
+	list = paint_down_to_common(r, one, n, twos, 0, 0);
 
 	while (list) {
 		struct commit *commit = pop_commit(&list);
@@ -187,8 +196,6 @@ static int remove_redundant_no_gen(struct repository *r,
 	redundant = xcalloc(cnt, 1);
 	ALLOC_ARRAY(filled_index, cnt - 1);
 
-	for (i = 0; i < cnt; i++)
-		repo_parse_commit(r, array[i]);
 	for (i = 0; i < cnt; i++) {
 		struct commit_list *common;
 		timestamp_t min_generation = commit_graph_generation(array[i]);
@@ -207,7 +214,7 @@ static int remove_redundant_no_gen(struct repository *r,
 				min_generation = curr_generation;
 		}
 		common = paint_down_to_common(r, array[i], filled,
-					      work, min_generation);
+					      work, min_generation, 1);
 		if (array[i]->object.flags & PARENT2)
 			redundant[i] = 1;
 		for (j = 0; j < filled; j++)
@@ -478,8 +485,6 @@ int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
 	int ret = 0, i;
 	timestamp_t generation, max_generation = GENERATION_NUMBER_ZERO;
 
-	if (repo_parse_commit(r, commit))
-		return ret;
 	for (i = 0; i < nr_reference; i++) {
 		if (repo_parse_commit(r, reference[i]))
 			return ret;
@@ -495,7 +500,7 @@ int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
 
 	bases = paint_down_to_common(r, commit,
 				     nr_reference, reference,
-				     generation);
+				     generation, 1);
 	if (commit->object.flags & PARENT2)
 		ret = 1;
 	clear_commit_marks(commit, all_flags);
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index 92948de7a0..f736ccf9f5 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -136,6 +136,8 @@ test_expect_success 'fetch that requires changes in .git/shallow is filtered' '
 '
 
 test_expect_success 'fetch --update-shallow' '
+	git init a-submodule &&
+	test_commit -C a-submodule foo &&
 	(
 	cd shallow &&
 	git checkout main &&
@@ -145,10 +147,13 @@ test_expect_success 'fetch --update-shallow' '
 	) &&
 	(
 	cd notshallow &&
+	git submodule add ../a-submodule a-submodule &&
+	git commit -m "added submodule" &&
 	git fetch --update-shallow ../shallow/.git refs/heads/*:refs/remotes/shallow/* &&
 	git fsck &&
 	git for-each-ref --sort=refname --format="%(refname)" >actual.refs &&
 	cat <<-\EOF >expect.refs &&
+	refs/heads/main
 	refs/remotes/shallow/main
 	refs/remotes/shallow/no-shallow
 	refs/tags/heavy-tag
@@ -162,8 +167,6 @@ test_expect_success 'fetch --update-shallow' '
 '
 
 test_expect_success 'fetch --update-shallow into a repo with submodules' '
-	git init a-submodule &&
-	test_commit -C a-submodule foo &&
 	git init repo-with-sub &&
 	git -C repo-with-sub submodule add ../a-submodule a-submodule &&
 	git -C repo-with-sub commit -m "added submodule" &&
@@ -185,6 +188,7 @@ test_expect_success 'fetch --update-shallow (with fetch.writeCommitGraph)' '
 	git fsck &&
 	git for-each-ref --sort=refname --format="%(refname)" >actual.refs &&
 	cat <<-EOF >expect.refs &&
+	refs/heads/main
 	refs/remotes/shallow/main
 	refs/remotes/shallow/no-shallow
 	refs/tags/heavy-tag
-- 
2.35.1.894.gb6a874cedc-goog

