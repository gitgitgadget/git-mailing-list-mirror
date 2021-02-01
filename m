Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0F8C433E9
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 07:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F5EC64E31
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 07:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhBAHAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 02:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbhBAHAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 02:00:25 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EECC061793
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 22:59:02 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id c12so15327985wrc.7
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 22:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lO2RGMGn6+dE/uMeW4xdGVD2u0Be20h8cfPlJwPnzmA=;
        b=YveFPG1N5S6lBNp92br9LnzVByp+A+zUEADU8HYGRBPR1UVbhuSYKIhsu8LjlVRH8v
         MYcSZy07t3i18uem5TtMLigS0JrdReRQJoQcTLRUfyTnAZlzectTUZGBCUcwgo1VCjsV
         /kt6OlgmP+vI6gFvro1u3SBDHNSxJtvt+stE2dgVSzjvW77Kp2SPuH1KUFnQBhN5MYvb
         WSnCj5tTh3jGKSGPaLD0SEJktlTy9NLqX53joefJcb09nHPNYb0JTSb8CfBdsiun/LMk
         wq6nKkkQT3ICDhSzrEr8SvXZw1jyi/LMxHp18dREthCFqy0RDl3iDIJGbDZB/YExYQBu
         mmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lO2RGMGn6+dE/uMeW4xdGVD2u0Be20h8cfPlJwPnzmA=;
        b=gLQYys8+/Rj5wLc/ZYcK5DnAOqqUJTyzJ1ef0UP3oa6t9zDv5/XR9c97cl+wx2B9BC
         EndUphGQVqdh0LiHLA8BJzTmWSXbtyb3tsz2WSDQ03BCejdrIsunpFt/Y0xOlH4cs6e7
         OP68+SOKducxZ+L85vut32yPSFckOn9fjS6on3fqeyAosG4FMoHEED5YjJ32TthXVwyy
         O/yYMSuFLhOVocWI0yonvM43S1fyikxxbvQlbR8fsaKc0NPRi9WyKof4hyYzvLnimj0g
         VNhak6qxn+6CpmgaAmsx+bOPdhatJ//2avtnpp4RcAv/pv1Ae7EBcjSdjOO+pUbqHJ/N
         cgZg==
X-Gm-Message-State: AOAM533uF4Ysjjfnu0NhkCBY+0FdllNb6zHVWDsdwyk3HeKPo/59u7d2
        OGbNIFYHtkewllNoU75Kjg6r/rjegfA=
X-Google-Smtp-Source: ABdhPJwm0551lM4qCqDRVztypvD7JIhyjVN6tMc6T0n0gsr8OdtqFEaJdSobSU1DztJb8/12F41c8g==
X-Received: by 2002:a5d:55c6:: with SMTP id i6mr17050910wrw.145.1612162740534;
        Sun, 31 Jan 2021 22:59:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d17sm15473445wma.2.2021.01.31.22.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 22:58:59 -0800 (PST)
Message-Id: <523e2d4a902b22fb7e0234bf9c207f7b071b7187.1612162726.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v7.git.1612162726.gitgitgadget@gmail.com>
References: <pull.676.v6.git.1610820679.gitgitgadget@gmail.com>
        <pull.676.v7.git.1612162726.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 06:58:45 +0000
Subject: [PATCH v7 11/11] commit-reach: use corrected commit dates in
 paint_down_to_common()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhishek Kumar <abhishekkumar8222@gmail.com>

091f4cf (commit: don't use generation numbers if not needed,
2018-08-30) changed paint_down_to_common() to use commit dates instead
of generation numbers v1 (topological levels) as the performance
regressed on certain topologies. With generation number v2 (corrected
commit dates) implemented, we no longer have to rely on commit dates and
can use generation numbers.

For example, the command `git merge-base v4.8 v4.9` on the Linux
repository walks 167468 commits, taking 0.135s for committer date and
167496 commits, taking 0.157s for corrected committer date respectively.

While using corrected commit dates, Git walks nearly the same number of
commits as commit date, the process is slower as for each comparision we
have to access a commit-slab (for corrected committer date) instead of
accessing struct member (for committer date).

This change incidentally broke the fragile t6404-recursive-merge test.
t6404-recursive-merge sets up a unique repository where all commits have
the same committer date without a well-defined merge-base.

While running tests with GIT_TEST_COMMIT_GRAPH unset, we use committer
date as a heuristic in paint_down_to_common(). 6404.1 'combined merge
conflicts' merges commits in the order:
- Merge C with B to form an intermediate commit.
- Merge the intermediate commit with A.

With GIT_TEST_COMMIT_GRAPH=1, we write a commit-graph and subsequently
use the corrected committer date, which changes the order in which
commits are merged:
- Merge A with B to form an intermediate commit.
- Merge the intermediate commit with C.

While resulting repositories are equivalent, 6404.4 'virtual trees were
processed' fails with GIT_TEST_COMMIT_GRAPH=1 as we are selecting
different merge-bases and thus have different object ids for the
intermediate commits.

As this has already causes problems (as noted in 859fdc0 (commit-graph:
define GIT_TEST_COMMIT_GRAPH, 2018-08-29)), we disable commit graph
within t6404-recursive-merge.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-graph.c             | 14 ++++++++++++++
 commit-graph.h             |  6 ++++++
 commit-reach.c             |  2 +-
 t/t6404-recursive-merge.sh |  5 ++++-
 4 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 77fef5a240e..bf735fac4ea 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -714,6 +714,20 @@ int generation_numbers_enabled(struct repository *r)
 	return !!first_generation;
 }
 
+int corrected_commit_dates_enabled(struct repository *r)
+{
+	struct commit_graph *g;
+	if (!prepare_commit_graph(r))
+		return 0;
+
+	g = r->objects->commit_graph;
+
+	if (!g->num_commits)
+		return 0;
+
+	return g->read_generation_data;
+}
+
 struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r)
 {
 	struct commit_graph *g = r->objects->commit_graph;
diff --git a/commit-graph.h b/commit-graph.h
index ad52130883b..97f3497c279 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -95,6 +95,12 @@ struct commit_graph *parse_commit_graph(struct repository *r,
  */
 int generation_numbers_enabled(struct repository *r);
 
+/*
+ * Return 1 if and only if the repository has a commit-graph
+ * file and generation data chunk has been written for the file.
+ */
+int corrected_commit_dates_enabled(struct repository *r);
+
 struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r);
 
 enum commit_graph_write_flags {
diff --git a/commit-reach.c b/commit-reach.c
index 9b24b0378d5..e38771ca5a1 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -39,7 +39,7 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 	int i;
 	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
 
-	if (!min_generation)
+	if (!min_generation && !corrected_commit_dates_enabled(r))
 		queue.compare = compare_commits_by_commit_date;
 
 	one->object.flags |= PARENT1;
diff --git a/t/t6404-recursive-merge.sh b/t/t6404-recursive-merge.sh
index c7ab7048f58..eaf48e941e2 100755
--- a/t/t6404-recursive-merge.sh
+++ b/t/t6404-recursive-merge.sh
@@ -18,6 +18,8 @@ GIT_COMMITTER_DATE="2006-12-12 23:28:00 +0100"
 export GIT_COMMITTER_DATE
 
 test_expect_success 'setup tests' '
+	GIT_TEST_COMMIT_GRAPH=0 &&
+	export GIT_TEST_COMMIT_GRAPH &&
 	echo 1 >a1 &&
 	git add a1 &&
 	GIT_AUTHOR_DATE="2006-12-12 23:00:00" git commit -m 1 a1 &&
@@ -69,7 +71,7 @@ test_expect_success 'setup tests' '
 '
 
 test_expect_success 'combined merge conflicts' '
-	test_must_fail env GIT_TEST_COMMIT_GRAPH=0 git merge -m final G
+	test_must_fail git merge -m final G
 '
 
 test_expect_success 'result contains a conflict' '
@@ -85,6 +87,7 @@ test_expect_success 'result contains a conflict' '
 '
 
 test_expect_success 'virtual trees were processed' '
+	# TODO: fragile test, relies on ambigious merge-base resolution
 	git ls-files --stage >out &&
 
 	cat >expect <<-EOF &&
-- 
gitgitgadget
