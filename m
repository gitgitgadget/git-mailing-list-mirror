Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DACDA1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752180AbeBFAS6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:18:58 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36801 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752074AbeBFAS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:18:56 -0500
Received: by mail-pg0-f68.google.com with SMTP id x25so167322pge.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NK9/FvYF08BzogjB33aKuNiVgWwC4zKu4m9UQLaDcjc=;
        b=dz+16rsnaFTqIBPF4ywtoODxoHTRUO0JKtpYE8Y2IlFEG128vQrP1lbP0dLRCEQfQE
         hv+btwAeAeQoQyz+7D6oatmaRD/DlYJzSrJ9EMiRXSTa0eU1aw70sAupIQW8HOzsfjK9
         l/cg1qpMCz7eRZI2ptgAcr3T0nssk06kQ/Jn1hqrebZoskl5GluoHfuM9C+lHsUVlZ9w
         dPvZeTPyjonrcWxJLS42Y74szq4BEpajv577lq/Ew6jkVvNp0hxqfwIxuldr+toSDV3R
         bfUUDsLyJMdVbD78MZh49E7CTZgg0oaXb/hcVda62sXXZEmuwCx3huGhaWWl1pm/rsq1
         yyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NK9/FvYF08BzogjB33aKuNiVgWwC4zKu4m9UQLaDcjc=;
        b=DXrUe7cYcYykRvk1K6nFKz0QrBvtI13IaNL6FOpMt1P7dA16s9koXuOwqQXr17mimJ
         cBHWzYY0rWCgxKpZl9f6/QbLJfoaGuduaSJOWvKfLDbkEKRQurV5U3PN6x3tQ+/1nPoq
         axvsrFW6alC4h+y7JBzNEleTGhf+JSicegliIscmGfG6STpF3VLrETwVBuB0kG1CARnM
         cJFbKylKwSE7vsqNXMN1fdVqY8W4lT1Ckm36ix+jFu5kQUTYeHD75PbwOXp7AWDx/ucG
         pOLBXLuu2vYBYgKc8Edjiduf+fZNNzuuQcwOHgBTWv7fgypMDyG3FKoYJfkOEb8yYrQc
         vtHQ==
X-Gm-Message-State: APf1xPBTwjJmk7/JI3O0XGK57AHJfBt1kImdYGrFHN8BVy4KVrF0u85z
        erlnUAr8xAyR71ZtR2eWIxpu/u8NILo=
X-Google-Smtp-Source: AH8x225gZKgDYHgaT8GgtvVarF3TFTgzyUNuo2wSZ6jmDyca5XQXlrPSNDqnX8L1fhRJq+BnB02xgg==
X-Received: by 10.99.114.19 with SMTP id n19mr421506pgc.143.1517876335508;
        Mon, 05 Feb 2018 16:18:55 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id w27sm15079685pge.54.2018.02.05.16.18.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:18:54 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 105/194] repository: keep track of all open repositories
Date:   Mon,  5 Feb 2018 16:16:20 -0800
Message-Id: <20180206001749.218943-7-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When Git mmap's packfiles into memory it has to keep track of the
memory management itself to not use too much memory. Each repository
has its own set of packfiles that it keeps track of. To scan all the
packfiles that are currently mmap'ed, we need to keep track of all
repositories that are currently opened.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/grep.c     |  2 +-
 builtin/ls-files.c |  2 +-
 packfile.c         |  9 ++++++--
 repository.c       | 66 +++++++++++++++++++++++++++++++++++++-----------------
 repository.h       |  6 ++++-
 submodule.c        |  2 +-
 6 files changed, 61 insertions(+), 26 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 2c43307f02..a9a908d92a 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -465,7 +465,7 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
 		hit = grep_cache(opt, &submodule, pathspec, 1);
 	}
 
-	repo_clear(&submodule);
+	repo_free(&submodule);
 	return hit;
 }
 
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 2fc836e330..a6d824a2ba 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -215,7 +215,7 @@ static void show_submodule(struct repository *superproject,
 
 	show_files(&submodule, dir);
 
-	repo_clear(&submodule);
+	repo_free(&submodule);
 }
 
 static void show_ce(struct repository *repo, struct dir_struct *dir,
diff --git a/packfile.c b/packfile.c
index 6a8d5edf6d..f7e8a81ded 100644
--- a/packfile.c
+++ b/packfile.c
@@ -237,13 +237,18 @@ static void scan_windows(struct packed_git *p,
 
 static int unuse_one_window(struct packed_git *current)
 {
+	int i = 0;
 	struct packed_git *p, *lru_p = NULL;
 	struct pack_window *lru_w = NULL, *lru_l = NULL;
 
 	if (current)
 		scan_windows(current, &lru_p, &lru_w, &lru_l);
-	for (p = the_repository->objects.packed_git; p; p = p->next)
-		scan_windows(p, &lru_p, &lru_w, &lru_l);
+	for (i = -1; i < open_repos_nr; i++) {
+		struct repository *r = i == -1 ? the_repository : open_repos[i];
+		for (p = r->objects.packed_git; p; p = p->next)
+			scan_windows(p, &lru_p, &lru_w, &lru_l);
+	}
+
 	if (lru_p) {
 		munmap(lru_w->base, lru_w->len);
 		pack_mapped -= lru_w->len;
diff --git a/repository.c b/repository.c
index af62dfdc09..361e503824 100644
--- a/repository.c
+++ b/repository.c
@@ -126,6 +126,36 @@ static int read_and_verify_repository_format(struct repository_format *format,
 	return ret;
 }
 
+struct repository **open_repos;
+int open_repos_nr;
+static int open_repos_alloc;
+
+static void repo_clear(struct repository *repo)
+{
+	FREE_AND_NULL(repo->gitdir);
+	FREE_AND_NULL(repo->commondir);
+	FREE_AND_NULL(repo->objectdir);
+	FREE_AND_NULL(repo->graft_file);
+	FREE_AND_NULL(repo->index_file);
+	FREE_AND_NULL(repo->worktree);
+	FREE_AND_NULL(repo->submodule_prefix);
+
+	if (repo->config) {
+		git_configset_clear(repo->config);
+		FREE_AND_NULL(repo->config);
+	}
+
+	if (repo->submodule_cache) {
+		submodule_cache_free(repo->submodule_cache);
+		repo->submodule_cache = NULL;
+	}
+
+	if (repo->index) {
+		discard_index(repo->index);
+		FREE_AND_NULL(repo->index);
+	}
+}
+
 /*
  * Initialize 'repo' based on the provided 'gitdir'.
  * Return 0 upon success and a non-zero value upon failure.
@@ -148,6 +178,9 @@ int repo_init(struct repository *repo, const char *gitdir, const char *worktree)
 	if (worktree)
 		repo_set_worktree(repo, worktree);
 
+	ALLOC_GROW(open_repos, open_repos_nr + 1, open_repos_alloc);
+	open_repos[open_repos_nr++] = repo;
+
 	return 0;
 
 error:
@@ -207,30 +240,23 @@ int repo_submodule_init(struct repository *submodule,
 	return ret;
 }
 
-void repo_clear(struct repository *repo)
+void repo_free(struct repository *repo)
 {
-	FREE_AND_NULL(repo->gitdir);
-	FREE_AND_NULL(repo->commondir);
-	FREE_AND_NULL(repo->objectdir);
-	FREE_AND_NULL(repo->graft_file);
-	FREE_AND_NULL(repo->index_file);
-	FREE_AND_NULL(repo->worktree);
-	FREE_AND_NULL(repo->submodule_prefix);
-
-	if (repo->config) {
-		git_configset_clear(repo->config);
-		FREE_AND_NULL(repo->config);
+	int i;
+	for (i = 0; i < open_repos_nr; i++) {
+		if (open_repos[i] != repo)
+			continue;
+		MOVE_ARRAY(open_repos + i,
+			   open_repos + i + 1,
+			   open_repos_nr - i - 1);
+		break;
 	}
 
-	if (repo->submodule_cache) {
-		submodule_cache_free(repo->submodule_cache);
-		repo->submodule_cache = NULL;
-	}
+	if (i == open_repos_nr)
+		BUG("free'ing non-open repo?");
 
-	if (repo->index) {
-		discard_index(repo->index);
-		FREE_AND_NULL(repo->index);
-	}
+	open_repos_nr--;
+	repo_clear(repo);
 }
 
 int repo_read_index(struct repository *repo)
diff --git a/repository.h b/repository.h
index c8a34d1ac9..74b2b27986 100644
--- a/repository.h
+++ b/repository.h
@@ -110,6 +110,10 @@ struct repository {
 
 extern struct repository *the_repository;
 
+/* Any open repo except the_repository */
+extern struct repository **open_repos;
+extern int open_repos_nr;
+
 extern void repo_set_gitdir(struct repository *repo, const char *path);
 extern void repo_set_worktree(struct repository *repo, const char *path);
 extern void repo_set_hash_algo(struct repository *repo, int algo);
@@ -117,7 +121,7 @@ extern int repo_init(struct repository *repo, const char *gitdir, const char *wo
 extern int repo_submodule_init(struct repository *submodule,
 			       struct repository *superproject,
 			       const char *path);
-extern void repo_clear(struct repository *repo);
+extern void repo_free(struct repository *repo);
 
 /*
  * Populates the repository's index from its index_file, an index struct will
diff --git a/submodule.c b/submodule.c
index aec62e6c7d..9c4c01ba73 100644
--- a/submodule.c
+++ b/submodule.c
@@ -898,7 +898,7 @@ static int submodule_has_commits(const char *path, struct oid_array *commits)
 		strbuf_release(&out);
 	}
 
-	repo_clear(&sub);
+	repo_free(&sub);
 	return has_commit.result;
 }
 
-- 
2.15.1.433.g936d1b9894.dirty

