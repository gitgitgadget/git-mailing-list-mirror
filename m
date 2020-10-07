Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA55C47095
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 14:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 929A12076C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 14:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a60paE88"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgJGOKE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 10:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbgJGOKB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 10:10:01 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3848C0613D5
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 07:10:00 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id n18so2355795wrs.5
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 07:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aEiKPs+ct87ku14xOM1B4f4rXmdc7luCwwUm3MWBZCQ=;
        b=a60paE88GDJFMmUDggZbzjzU0tsa8gAeB7KVnwA+9pUYUtq0lgsGuP2f+B58rPVL+3
         MENQEdks19Pq1UZnKk/6P/9sy6kiU2oYKn2M68Neid2PPzLgMb/nWOJJ5qkNXChK8IIf
         H6nG+QQUPnN8wsbjZ+h9mHTlrmXNmy0AyKVjmXpQK9L4uvECYY3bWeM/XbpqCJRlAxlt
         /v9djHgPklT0ZzwlaKZ5bM9Gd2j9UmIlZp9F2nkRf7JEVpjRqIZ0Kcnz1mTSVeHvPUw7
         ygLEEbJsPrrFNng5OSPBJOVUYoztKjceVMKl5ER1H3cEiMZgCdUAyqAkuoWY275InGpA
         NzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aEiKPs+ct87ku14xOM1B4f4rXmdc7luCwwUm3MWBZCQ=;
        b=BDUxYD/dwplAIEGCUT3Dgytv36ZngJYCh90QQjZ8ZAwuAKklDkDv4M3vFeo60o08Bj
         M9HfRQwY2YzlSwyUZpq+rzf8ucPiDNSUMf8MKmqdxCVuBrwgZt7frnAVIvj+y3WPR9Iy
         DsHrRHGCo62w7yVnvnb/Oea4yjHQJ4UCI4KxTH0dFIhnl4cX7z1KrUw5/Oa3LXxVMDbp
         Aygk986lZ3dKnp4SFF0vhsR3FAUKKudRJECUWiFySOuwBrZOdkq2847QZGoS1n3GxyiU
         pk3PTZj36A+tXa9mUJWujFyJPxgqtTU4dxuirgEWKz4CA0Sy4xI8XqS33DPUkMQChKT1
         Yl7w==
X-Gm-Message-State: AOAM533EUjw+KQiEqD02niLCxJZPXMlkw7smoiD9DxyZPfHPvJ40Pr1i
        eQbEX+Wi04CUPoUIlg5qqz1rzxXib50=
X-Google-Smtp-Source: ABdhPJxNKBgzI1E0AWZa2/OpVRp9QdWyD+B0GkJfsh2tSTLJveLneqJ/X6EKSbpO1gWnxYC30W53XQ==
X-Received: by 2002:adf:f784:: with SMTP id q4mr3754224wrp.126.1602079799283;
        Wed, 07 Oct 2020 07:09:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m11sm2853161wmf.10.2020.10.07.07.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 07:09:58 -0700 (PDT)
Message-Id: <bb9b02af32d028fc0c26d372aa490e260c74e74d.1602079786.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Oct 2020 14:09:44 +0000
Subject: [PATCH v4 09/10] commit-reach: use corrected commit dates in
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

With corrected commit dates implemented, we no longer have to rely on
commit date as a heuristic in paint_down_to_common().

While using corrected commit dates Git walks nearly the same number of
commits as commit date, the process is slower as for each comparision we
have to access a commit-slab (for corrected committer date) instead of
accessing struct member (for committer date).

For example, the command `git merge-base v4.8 v4.9` on the linux
repository walks 167468 commits, taking 0.135s for committer date and
167496 commits, taking 0.157s for corrected committer date respectively.

t6404-recursive-merge setups a unique repository where all commits have
the same committer date without well-defined merge-base.

While running tests with GIT_TEST_COMMIT_GRAPH unset, we use committer
date as a heuristic in paint_down_to_common(). 6404.1 'combined merge
conflicts' merges commits in the order:
- Merge C with B to form a intermediate commit.
- Merge the intermediate commit with A.

With GIT_TEST_COMMIT_GRAPH=1, we write a commit-graph and subsequently
use the corrected committer date, which changes the order in which
commits are merged:
- Merge A with B to form a intermediate commit.
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
 commit-graph.h             |  8 +++++++-
 commit-reach.c             |  2 +-
 t/t6404-recursive-merge.sh |  5 ++++-
 4 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 5d15a1399b..3de1933ede 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -705,6 +705,20 @@ int generation_numbers_enabled(struct repository *r)
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
index ad52130883..d2c048dc64 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -89,13 +89,19 @@ struct commit_graph *read_commit_graph_one(struct repository *r,
 struct commit_graph *parse_commit_graph(struct repository *r,
 					void *graph_map, size_t graph_size);
 
+struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r);
+
 /*
  * Return 1 if and only if the repository has a commit-graph
  * file and generation numbers are computed in that file.
  */
 int generation_numbers_enabled(struct repository *r);
 
-struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r);
+/*
+ * Return 1 if and only if the repository has a commit-graph
+ * file and generation data chunk has been written for the file.
+ */
+int corrected_commit_dates_enabled(struct repository *r);
 
 enum commit_graph_write_flags {
 	COMMIT_GRAPH_WRITE_APPEND     = (1 << 0),
diff --git a/commit-reach.c b/commit-reach.c
index 20b48b872b..46f5a9e638 100644
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
index 332cfc53fd..7055771b62 100755
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

