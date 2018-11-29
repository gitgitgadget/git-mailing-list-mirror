Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 544E81F609
	for <e@80x24.org>; Thu, 29 Nov 2018 00:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbeK2Lbm (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 06:31:42 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:35961 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbeK2Lbm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 06:31:42 -0500
Received: by mail-qk1-f201.google.com with SMTP id h68so198181qke.3
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 16:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sotDYs7AyfhRYz1Gvn6FZfFqz6BJGgbwgPkk5yCvNEI=;
        b=VPtCuNj9ZKXSZFCJRC/uBtCmvV8TIQNep/3gtCo3ZwfvO/tESK1KYae0MC5bBpFVp4
         PCeXhLYXlwnbN90JfmPvU/ru1z3rkRRuiCnhb76jWfd6fyhZ7b92J4P6+5ZcB+PL5DLL
         aRtqeD0tw1GryOXQaZpnVmWoNdXl0oyxy+AZ9Wqy5lV4pG3d1pgVi++QOof3JKbiRvuR
         Zn/JVQVl9R5+Gi7S/f4Mh3m301gpZnZP5ugX09aDxP539K/F+Df1opEaJ45jf3iCw81N
         hu80O4i3sxx+VzC42FPmsXbZivlnofKkzil2hAnNrHUWpVZSPsQAHo35vdrlR+ZMrIDe
         hWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sotDYs7AyfhRYz1Gvn6FZfFqz6BJGgbwgPkk5yCvNEI=;
        b=tKpvCXI6Khpyw/KGxbmVTPfrJhGrqoLJsa7M24cQVXlhjR5DWsIpZboG3/k7Ydm2bW
         M7lqFywzRNVNo5Iwmzg/tZEqipYAnaQ9skmY/FwhtvSqqwCDOPv7HSIx69BGe6W3OWNg
         EIC863FjJyGDiq5EaqR9/HZq2CNKhp1Uu/FC4hT1VDEhmaPtx2ihtm6vxN2Vt2M88jEm
         lCYtaDp6NyaK2jGfSj1vWjECnx0D+1uWbGK8RCl4Yy1urwXpUePcCkrPrN/Bnw68HYJr
         3qCrvlSK5A3lGTUESDbIjqDOOxWBfBHoCogs/RLwH9idWUPlO7M08qiSGjZFO0elsBnd
         QoFA==
X-Gm-Message-State: AA+aEWY8Dew7EM0fsqxfW8adJg4WuQBoP4RIG/KCsjjxZvzrVwLBJrY1
        BmO4JL0mVhlHEGoNqRqV2/yzzUu7gTzoDTLA3cwDgfQpdqJrDPvMriSWBXQH7m3AYl0kE7xI0hy
        HurkES+2T7SbhLmqjaOtRlY9i+kSjD5ddTv3PIjeijXHL52BLpEA5MzVEh0Jb
X-Google-Smtp-Source: AFSGD/X2THiJmd8dDx7h1nLk9JPGHWMRPlesIFAO9MG5D2ex1ZnxAFiiSALMcWzGQl2qddeJaghXbl3xMyNL
X-Received: by 2002:a0c:9901:: with SMTP id h1mr5402242qvd.14.1543451294903;
 Wed, 28 Nov 2018 16:28:14 -0800 (PST)
Date:   Wed, 28 Nov 2018 16:27:53 -0800
In-Reply-To: <20181129002756.167615-1-sbeller@google.com>
Message-Id: <20181129002756.167615-7-sbeller@google.com>
Mime-Version: 1.0
References: <20181129002756.167615-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
Subject: [PATCH 6/9] repository: repo_submodule_init to take a submodule struct
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When constructing a struct repository for a submodule for some revision
of the superproject where the submodule is not contained in the index,
it may not be present in the working tree currently either. In that
situation giving a 'path' argument is not useful. Upgrade the
repo_submodule_init function to take a struct submodule instead.
The submodule struct can be obtained via submodule_from_{path, name} or
an artificial submodule struct can be passed in.

While we are at it, rename the repository struct in the repo_submodule_init
function, which is to be initialized, to a name that is not confused with
the struct submodule as easily. Perform such renames in similar functions
as well.

Also move its documentation into the header file.

Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/grep.c                               | 17 +++++++-----
 builtin/ls-files.c                           | 12 +++++----
 builtin/submodule--helper.c                  |  2 +-
 repository.c                                 | 27 ++++++++------------
 repository.h                                 | 12 +++++++--
 t/helper/test-submodule-nested-repo-config.c |  8 +++---
 6 files changed, 43 insertions(+), 35 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 71df52a333..d6bd887b2d 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -404,7 +404,10 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
 			  const struct object_id *oid,
 			  const char *filename, const char *path)
 {
-	struct repository submodule;
+	struct repository subrepo;
+	const struct submodule *sub = submodule_from_path(superproject,
+							  &null_oid, path);
+
 	int hit;
 
 	/*
@@ -420,12 +423,12 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
 		return 0;
 	}
 
-	if (repo_submodule_init(&submodule, superproject, path)) {
+	if (repo_submodule_init(&subrepo, superproject, sub)) {
 		grep_read_unlock();
 		return 0;
 	}
 
-	repo_read_gitmodules(&submodule);
+	repo_read_gitmodules(&subrepo);
 
 	/*
 	 * NEEDSWORK: This adds the submodule's object directory to the list of
@@ -437,7 +440,7 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
 	 * store is no longer global and instead is a member of the repository
 	 * object.
 	 */
-	add_to_alternates_memory(submodule.objects->objectdir);
+	add_to_alternates_memory(subrepo.objects->objectdir);
 	grep_read_unlock();
 
 	if (oid) {
@@ -462,14 +465,14 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
 
 		init_tree_desc(&tree, data, size);
 		hit = grep_tree(opt, pathspec, &tree, &base, base.len,
-				object->type == OBJ_COMMIT, &submodule);
+				object->type == OBJ_COMMIT, &subrepo);
 		strbuf_release(&base);
 		free(data);
 	} else {
-		hit = grep_cache(opt, &submodule, pathspec, 1);
+		hit = grep_cache(opt, &subrepo, pathspec, 1);
 	}
 
-	repo_clear(&submodule);
+	repo_clear(&subrepo);
 	return hit;
 }
 
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index c70a9c7158..583a0e1ca2 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -206,17 +206,19 @@ static void show_files(struct repository *repo, struct dir_struct *dir);
 static void show_submodule(struct repository *superproject,
 			   struct dir_struct *dir, const char *path)
 {
-	struct repository submodule;
+	struct repository subrepo;
+	const struct submodule *sub = submodule_from_path(superproject,
+							  &null_oid, path);
 
-	if (repo_submodule_init(&submodule, superproject, path))
+	if (repo_submodule_init(&subrepo, superproject, sub))
 		return;
 
-	if (repo_read_index(&submodule) < 0)
+	if (repo_read_index(&subrepo) < 0)
 		die("index file corrupt");
 
-	show_files(&submodule, dir);
+	show_files(&subrepo, dir);
 
-	repo_clear(&submodule);
+	repo_clear(&subrepo);
 }
 
 static void show_ce(struct repository *repo, struct dir_struct *dir,
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d38113a31a..4eceb8f040 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2053,7 +2053,7 @@ static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
 	if (!sub)
 		BUG("We could get the submodule handle before?");
 
-	if (repo_submodule_init(&subrepo, the_repository, path))
+	if (repo_submodule_init(&subrepo, the_repository, sub))
 		die(_("could not get a repository handle for submodule '%s'"), path);
 
 	if (!repo_config_get_string(&subrepo, "core.worktree", &cw)) {
diff --git a/repository.c b/repository.c
index 5dd1486718..aabe64ee5d 100644
--- a/repository.c
+++ b/repository.c
@@ -166,30 +166,23 @@ int repo_init(struct repository *repo,
 	return -1;
 }
 
-/*
- * Initialize 'submodule' as the submodule given by 'path' in parent repository
- * 'superproject'.
- * Return 0 upon success and a non-zero value upon failure.
- */
-int repo_submodule_init(struct repository *submodule,
+int repo_submodule_init(struct repository *subrepo,
 			struct repository *superproject,
-			const char *path)
+			const struct submodule *sub)
 {
-	const struct submodule *sub;
 	struct strbuf gitdir = STRBUF_INIT;
 	struct strbuf worktree = STRBUF_INIT;
 	int ret = 0;
 
-	sub = submodule_from_path(superproject, &null_oid, path);
 	if (!sub) {
 		ret = -1;
 		goto out;
 	}
 
-	strbuf_repo_worktree_path(&gitdir, superproject, "%s/.git", path);
-	strbuf_repo_worktree_path(&worktree, superproject, "%s", path);
+	strbuf_repo_worktree_path(&gitdir, superproject, "%s/.git", sub->path);
+	strbuf_repo_worktree_path(&worktree, superproject, "%s", sub->path);
 
-	if (repo_init(submodule, gitdir.buf, worktree.buf)) {
+	if (repo_init(subrepo, gitdir.buf, worktree.buf)) {
 		/*
 		 * If initilization fails then it may be due to the submodule
 		 * not being populated in the superproject's worktree.  Instead
@@ -201,16 +194,16 @@ int repo_submodule_init(struct repository *submodule,
 		strbuf_repo_git_path(&gitdir, superproject,
 				     "modules/%s", sub->name);
 
-		if (repo_init(submodule, gitdir.buf, NULL)) {
+		if (repo_init(subrepo, gitdir.buf, NULL)) {
 			ret = -1;
 			goto out;
 		}
 	}
 
-	submodule->submodule_prefix = xstrfmt("%s%s/",
-					      superproject->submodule_prefix ?
-					      superproject->submodule_prefix :
-					      "", path);
+	subrepo->submodule_prefix = xstrfmt("%s%s/",
+					    superproject->submodule_prefix ?
+					    superproject->submodule_prefix :
+					    "", sub->path);
 
 out:
 	strbuf_release(&gitdir);
diff --git a/repository.h b/repository.h
index 9f16c42c1e..0e482b7d49 100644
--- a/repository.h
+++ b/repository.h
@@ -116,9 +116,17 @@ void repo_set_worktree(struct repository *repo, const char *path);
 void repo_set_hash_algo(struct repository *repo, int algo);
 void initialize_the_repository(void);
 int repo_init(struct repository *r, const char *gitdir, const char *worktree);
-int repo_submodule_init(struct repository *submodule,
+
+/*
+ * Initialize the repository 'subrepo' as the submodule given by the
+ * struct submodule 'sub' in parent repository 'superproject'.
+ * Return 0 upon success and a non-zero value upon failure, which may happen
+ * if the submodule is not found, or 'sub' is NULL.
+ */
+struct submodule;
+int repo_submodule_init(struct repository *subrepo,
 			struct repository *superproject,
-			const char *path);
+			const struct submodule *sub);
 void repo_clear(struct repository *repo);
 
 /*
diff --git a/t/helper/test-submodule-nested-repo-config.c b/t/helper/test-submodule-nested-repo-config.c
index a31e2a9bea..bc97929bbc 100644
--- a/t/helper/test-submodule-nested-repo-config.c
+++ b/t/helper/test-submodule-nested-repo-config.c
@@ -10,19 +10,21 @@ static void die_usage(int argc, const char **argv, const char *msg)
 
 int cmd__submodule_nested_repo_config(int argc, const char **argv)
 {
-	struct repository submodule;
+	struct repository subrepo;
+	const struct submodule *sub;
 
 	if (argc < 3)
 		die_usage(argc, argv, "Wrong number of arguments.");
 
 	setup_git_directory();
 
-	if (repo_submodule_init(&submodule, the_repository, argv[1])) {
+	sub = submodule_from_path(the_repository, &null_oid, argv[1]);
+	if (repo_submodule_init(&subrepo, the_repository, sub)) {
 		die_usage(argc, argv, "Submodule not found.");
 	}
 
 	/* Read the config of _child_ submodules. */
-	print_config_from_gitmodules(&submodule, argv[2]);
+	print_config_from_gitmodules(&subrepo, argv[2]);
 
 	submodule_free(the_repository);
 
-- 
2.20.0.rc1.387.gf8505762e3-goog

