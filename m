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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D1AC433E9
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 11:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5319A22AAD
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 11:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbgL1LRi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 06:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbgL1LRf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 06:17:35 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457F8C0617A0
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 03:16:22 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d13so10983543wrc.13
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 03:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GflQn4+6J6LwmIi+iXcJTd4ibHu5n98QXxTJISdMLMU=;
        b=Jb4/4h8v5UZ8fDv/MVr+NIa6gCEq5AP5afoayijXzm2u+6yypsWvm2VRbcWXSPd+Te
         BO6Qj3eOpCtGFJghoZNFswKDvjosZH7YxINB1ebjKgUC15Tbnjdl13o+ZjtR53MjA+VR
         s092vJ8qmV+4uA+2BGc8bw7le+KVKYzxGwZEpG3jDLka608TRULly6A7kQm688rmLk+1
         pinFLG4QUs63p+hr3W3s5tKmYOqD+/oVQ1EQPst96SA9R5rw1o+mes6y3bAWJiFwwRLT
         BkTqR4kJeCEKNfMTkwpUtTUlcGWeyDEHmw2ZVKyvWR2RvJn5Nv8GYdVBdl3+CYxzhunT
         3/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GflQn4+6J6LwmIi+iXcJTd4ibHu5n98QXxTJISdMLMU=;
        b=bZygFp3CW6XdMNE6YQqLt/7yp3PTCIgIpGWyEKoH3uxlpL/qpjQggDntmmeYApQOlN
         1QG0AESfzr8RfrfaS/bPMivYtqxfJqqoJtS7Ezl2JO6echdx5WfexzvHZ0bwQQTxkw3j
         tPtgbcVkLRhRdkd0XlrZCntBXm+4o/xDcj/5ZJovXen/OcRu1QtAQn3zijjUuyZECfZh
         JWtDmhLBIjC1aLFWrAvZpyeBmaGPZvVP2zFD5eEzR1WWdXGCib/tcIo4r9SHTvrVO0uU
         nUPxL30Qqlwep+o4hP9gaqW9/kH1nV5U1iYsDAMqJoQcA53POWOrmvl2uREl/X3tLgbg
         116w==
X-Gm-Message-State: AOAM533P/j68eAnU5H3uhTjnjm/Xea80P6KC3uA/BGbeAz7FZITfsPyE
        CyZOgxEUeR2NknVSOX67F1o0Y9Gt0y4=
X-Google-Smtp-Source: ABdhPJwhdBjQ1xqoBs5txs7K1T4jg9Ph+7k0cRcekWh2VeIhMZV6Kbho4PTUOSNMRguhgGdhkFbjhw==
X-Received: by 2002:adf:d20b:: with SMTP id j11mr19240548wrh.318.1609154180792;
        Mon, 28 Dec 2020 03:16:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g184sm19202224wma.16.2020.12.28.03.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 03:16:20 -0800 (PST)
Message-Id: <093101f908b166099af41d99250cf8e79d921740.1609154169.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
References: <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
        <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Dec 2020 11:16:07 +0000
Subject: [PATCH v5 10/11] commit-reach: use corrected commit dates in
 paint_down_to_common()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
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
index 41a65d98738..c8d7ed13302 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -710,6 +710,20 @@ int generation_numbers_enabled(struct repository *r)
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
index b1c3d4dda49..86f74ae5847 100755
--- a/t/t6404-recursive-merge.sh
+++ b/t/t6404-recursive-merge.sh
@@ -15,6 +15,8 @@ GIT_COMMITTER_DATE="2006-12-12 23:28:00 +0100"
 export GIT_COMMITTER_DATE
 
 test_expect_success 'setup tests' '
+	GIT_TEST_COMMIT_GRAPH=0 &&
+	export GIT_TEST_COMMIT_GRAPH &&
 	echo 1 >a1 &&
 	git add a1 &&
 	GIT_AUTHOR_DATE="2006-12-12 23:00:00" git commit -m 1 a1 &&
@@ -66,7 +68,7 @@ test_expect_success 'setup tests' '
 '
 
 test_expect_success 'combined merge conflicts' '
-	test_must_fail env GIT_TEST_COMMIT_GRAPH=0 git merge -m final G
+	test_must_fail git merge -m final G
 '
 
 test_expect_success 'result contains a conflict' '
@@ -82,6 +84,7 @@ test_expect_success 'result contains a conflict' '
 '
 
 test_expect_success 'virtual trees were processed' '
+	# TODO: fragile test, relies on ambigious merge-base resolution
 	git ls-files --stage >out &&
 
 	cat >expect <<-EOF &&
-- 
gitgitgadget

