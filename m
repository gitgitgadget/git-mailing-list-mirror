Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8667A1F453
	for <e@80x24.org>; Tue, 25 Sep 2018 19:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbeIZB50 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 21:57:26 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:52317 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbeIZB50 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 21:57:26 -0400
Received: by mail-ot1-f74.google.com with SMTP id a12-v6so3557328otl.19
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 12:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FOJIYkOnYkPNIGjmy6xUMk0e00HZIIc94locFSkFtUM=;
        b=cml4ZJOaikhGDKyJOFBZdnLwGaF46U6Ajf5+7A+uBAOPPlEwgkEVYPmFMnkjQ+XwmG
         hWjivlB3fY2r+9Kwij2cPArjoIhQuC0h4URSEX90ljAEVJ/We+zoWXKwhlXwtoAG2j9c
         awGINcV4yfGOlDOMVcg7I0XTgelmRF+feyrf+KqFyRQ4auw0jDQbdXg+XGMjig4EVOW6
         GYrDK0i6aHIf2ot183xBdeXFx90IVsNNr+/5VR0YIXEZchvcidY5N6RxUd6tlCVJ9e4K
         uyGzFr2bYfzpNUHeha22FFjWBeMdpdtDk714/NByKCm6AN9RqZfzZ7bj7MO792n29bln
         Krlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FOJIYkOnYkPNIGjmy6xUMk0e00HZIIc94locFSkFtUM=;
        b=CuxA0W10YSs6w924ZUAVVhvphKlXm3Z/Ib91Y94M1PBF/6A31uuetNW3R7F88gQxr/
         DEik4IIQ2qU3lTTVmVg2xD6EcZekJn9aNI+MJpNZC1tvuDWPH9sj0kSgs9L+8TRZ4xul
         l5U0d9IDySgj5ZucUJoh1R/fF9y5ShdR3H+6hCRba0aR5tWQgJjaiywG45I3BMRAPKdR
         dk7VwmH4l/30una01O8Me8gfCbJWM9UABlWs38X33TPBrpefGnRofNRWyji2o6FgsVsy
         hsP9yHfXzW7aOVetMljVWLwdBs8YVoBDKyldsm8JTamSulefn0nvajzOuTj1gIkdqlJe
         5SSA==
X-Gm-Message-State: ABuFfoirEP+/Ads80AjDI0yjS6sst+nh4atWv5VtDbQCKyWDCJCQ+2+I
        cJkh2uSeWKTBhDNd1p1dHelPjsbHjdPr/fZF8wnVnLWZ0F6+87LegxFF8URr6hVWgAT0RIGWWm7
        kcQG2ELfaqXTDnYDtsEIP8L6IwWyx/j7ArT5hpXYQEnGV6z330T50N/Wg5WpY
X-Google-Smtp-Source: ACcGV62Gr7QOThLWw55dRatx+ylm3gNrxnStusidsJ4sK1yxiXQHEJD+nmh6jwD3cybAnCnEeylk1GhAOO/P
X-Received: by 2002:aca:ded5:: with SMTP id v204-v6mr2890433oig.7.1537904897001;
 Tue, 25 Sep 2018 12:48:17 -0700 (PDT)
Date:   Tue, 25 Sep 2018 12:47:52 -0700
In-Reply-To: <20180925194755.105578-1-sbeller@google.com>
Message-Id: <20180925194755.105578-7-sbeller@google.com>
Mime-Version: 1.0
References: <20180925194755.105578-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v4 6/9] repository: repo_submodule_init to take a submodule struct
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When constructing a struct repository for a submodule for some revision
of the superproject where the submodule is not contained in the index,
it may not be present in the working tree currently either. In that
siutation giving a 'path' argument is not useful. Upgrade the
repo_submodule_init function to take a struct submodule instead.

While we are at it, overhaul the repo_submodule_init function by renaming
the submodule repository struct, which is to be initialized, to a name
that is not confused with the struct submodule as easily.

Also move its documentation into the header file.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/grep.c              | 17 ++++++++++-------
 builtin/ls-files.c          | 12 +++++++-----
 builtin/submodule--helper.c |  2 +-
 repository.c                | 27 ++++++++++-----------------
 repository.h                | 11 +++++++++--
 5 files changed, 37 insertions(+), 32 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 601f801158f..81c53c862b1 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -418,16 +418,19 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
 			  const struct object_id *oid,
 			  const char *filename, const char *path)
 {
-	struct repository submodule;
+	struct repository subrepo;
+	const struct submodule *sub = submodule_from_path(superproject,
+							  &null_oid, path);
+
 	int hit;
 
 	if (!is_submodule_active(superproject, path))
 		return 0;
 
-	if (repo_submodule_init(&submodule, superproject, path))
+	if (repo_submodule_init(&subrepo, superproject, sub))
 		return 0;
 
-	repo_read_gitmodules(&submodule);
+	repo_read_gitmodules(&subrepo);
 
 	/*
 	 * NEEDSWORK: This adds the submodule's object directory to the list of
@@ -440,7 +443,7 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
 	 * object.
 	 */
 	grep_read_lock();
-	add_to_alternates_memory(submodule.objects->objectdir);
+	add_to_alternates_memory(subrepo.objects->objectdir);
 	grep_read_unlock();
 
 	if (oid) {
@@ -465,14 +468,14 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
 
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
index 7f9919a3623..4d1649c1b3a 100644
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
index 40844870cfb..1164e0979bd 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2037,7 +2037,7 @@ static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
 	if (!sub)
 		BUG("We could get the submodule handle before?");
 
-	if (repo_submodule_init(&subrepo, the_repository, path))
+	if (repo_submodule_init(&subrepo, the_repository, sub))
 		die(_("could not get a repository handle for submodule '%s'"), path);
 
 	if (!repo_config_get_string(&subrepo, "core.worktree", &cw)) {
diff --git a/repository.c b/repository.c
index 5dd14867181..aabe64ee5d9 100644
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
index 9f16c42c1ed..a9c7a5baa54 100644
--- a/repository.h
+++ b/repository.h
@@ -116,9 +116,16 @@ void repo_set_worktree(struct repository *repo, const char *path);
 void repo_set_hash_algo(struct repository *repo, int algo);
 void initialize_the_repository(void);
 int repo_init(struct repository *r, const char *gitdir, const char *worktree);
-int repo_submodule_init(struct repository *submodule,
+
+/*
+ * Initialize the repository 'subrepo' as the submodule given by the
+ * struct submodule 'sub' in parent repository 'superproject'.
+ * Return 0 upon success and a non-zero value upon failure.
+ */
+struct submodule;
+int repo_submodule_init(struct repository *subrepo,
 			struct repository *superproject,
-			const char *path);
+			const struct submodule *sub);
 void repo_clear(struct repository *repo);
 
 /*
-- 
2.19.0.605.g01d371f741-goog

