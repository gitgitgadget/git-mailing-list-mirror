Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A77581F404
	for <e@80x24.org>; Wed, 28 Mar 2018 17:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752659AbeC1RZI (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 13:25:08 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33690 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752349AbeC1RY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 13:24:59 -0400
Received: by mail-pf0-f196.google.com with SMTP id f15so1254473pfn.0
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 10:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2QUii/FxmZLSBtKuistq0BOEPnIOIlLzliNNuemoGys=;
        b=CPmsbusFxzx/LxbjUNPGa6vpd27ANKfTSoO9cUQLDbzeD44ZPs8aMNUPlnQ8sX7u69
         QEfpWOk04NV5ktvbkIRlAx9ntrFr5wJUA24wA49Ef4jVVgPlz16rlQID3eX08R6mOTkE
         UN3nXbcofWiJoEoKsFWUP19v1kbi6el5WJoUH5HskSuPFdSSXWemU9cV/Ko671UCV1+a
         5OxGgaIxvuQZijS9jouyrJ4xo9uIwIwIKtajfGdIlsrErlX4ZA2sEJe4IIIupWYtPI7x
         WGxQKiduhRymgh+obrN8S9fpB/tF9iNoOQaWumwqrNnNTLwXjkpxeROz7CWNmpR7fM8S
         4DVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2QUii/FxmZLSBtKuistq0BOEPnIOIlLzliNNuemoGys=;
        b=nNtheXgQcBNrPLSWafwvpQ/xIea4OKoxd5VgYBkplq6iiKfzkWc00XClt8olXv5fuw
         EvDmfhSdLgquMqOx5ENWrjOfs8GXPLWgUIse/EoZwIJnt9rl9Wnd/rFG31o1Smw64uPW
         rt71OuxphdfNlIeSpSYqy2w0e6Iv4hqcWOu/YdCP+9VtEYOd3EJD912KQDT60edqmEmk
         R5J3iOBTtnyY8rk3xQhS1wCMN2oqTYL7GueruxpI/MyANyK6fG3JnQ5gkgLiX0A+do/2
         QS/EbDPVDfeZoJ0ReEhf26SINAcZVcISoauarheFyHisrXGxV30jud0zRq/pt3B8dTpe
         7sRA==
X-Gm-Message-State: AElRT7HPHqS6ooVLLcHdmpaCZNP8asEOhn+uvwubnDFkkrFcqsXMPwF/
        vMWk1u5I1DnsXhnbFHh9L1gFcA==
X-Google-Smtp-Source: AIpwx48+vJzJaisTs8kDpaecLA/w9hXiD6q4jt/TPCozxUz0iWvUR3fsVKB72fMO1EJl6ODALGuqSg==
X-Received: by 2002:a17:902:8602:: with SMTP id f2-v6mr4574161plo.73.1522257898685;
        Wed, 28 Mar 2018 10:24:58 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id i127sm8177516pgc.12.2018.03.28.10.24.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Mar 2018 10:24:57 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     bmwill@google.com, git@vger.kernel.org, hvoigt@hvoigt.net,
        jonathantanmy@google.com, seanwbehan@riseup.net
Subject: [PATCH 3/6] submodule-config: add repository argument to submodule_from_{name, path}
Date:   Wed, 28 Mar 2018 10:24:46 -0700
Message-Id: <20180328172449.27012-4-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565-goog
In-Reply-To: <20180328172449.27012-1-sbeller@google.com>
References: <CAGZ79kaQYjepND8EdgB73meBsShOc5aBporiK2Bo40fqcar0gg@mail.gmail.com>
 <20180328172449.27012-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This enables submodule_from_{name, path} to handle arbitrary repositories.
All callers just pass in the_repository, a later patch will pass in other
repos.

While at it remove the extern key word from the declarations.

Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c      | 14 +++++++-------
 submodule-config.c               | 14 ++++++++------
 submodule-config.h               | 10 ++++++----
 submodule.c                      | 30 ++++++++++++++++--------------
 t/helper/test-submodule-config.c |  6 ++++--
 5 files changed, 41 insertions(+), 33 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ee020d4749..a921fbbf56 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -454,7 +454,7 @@ static void init_submodule(const char *path, const char *prefix,
 
 	displaypath = get_submodule_displaypath(path, prefix);
 
-	sub = submodule_from_path(&null_oid, path);
+	sub = submodule_from_path(the_repository, &null_oid, path);
 
 	if (!sub)
 		die(_("No url found for submodule path '%s' in .gitmodules"),
@@ -621,7 +621,7 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 	struct rev_info rev;
 	int diff_files_result;
 
-	if (!submodule_from_path(&null_oid, path))
+	if (!submodule_from_path(the_repository, &null_oid, path))
 		die(_("no submodule mapping found in .gitmodules for path '%s'"),
 		      path);
 
@@ -741,7 +741,7 @@ static int module_name(int argc, const char **argv, const char *prefix)
 	if (argc != 2)
 		usage(_("git submodule--helper name <path>"));
 
-	sub = submodule_from_path(&null_oid, argv[1]);
+	sub = submodule_from_path(the_repository, &null_oid, argv[1]);
 
 	if (!sub)
 		die(_("no submodule mapping found in .gitmodules for path '%s'"),
@@ -772,7 +772,7 @@ static void sync_submodule(const char *path, const char *prefix,
 	if (!is_submodule_active(the_repository, path))
 		return;
 
-	sub = submodule_from_path(&null_oid, path);
+	sub = submodule_from_path(the_repository, &null_oid, path);
 
 	if (sub && sub->url) {
 		if (starts_with_dot_dot_slash(sub->url) ||
@@ -925,7 +925,7 @@ static void deinit_submodule(const char *path, const char *prefix,
 	struct strbuf sb_config = STRBUF_INIT;
 	char *sub_git_dir = xstrfmt("%s/.git", path);
 
-	sub = submodule_from_path(&null_oid, path);
+	sub = submodule_from_path(the_repository, &null_oid, path);
 
 	if (!sub || !sub->name)
 		goto cleanup;
@@ -1367,7 +1367,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		goto cleanup;
 	}
 
-	sub = submodule_from_path(&null_oid, ce->name);
+	sub = submodule_from_path(the_repository, &null_oid, ce->name);
 
 	if (suc->recursive_prefix)
 		displaypath = relative_path(suc->recursive_prefix,
@@ -1650,7 +1650,7 @@ static const char *remote_submodule_branch(const char *path)
 	const char *branch = NULL;
 	char *key;
 
-	sub = submodule_from_path(&null_oid, path);
+	sub = submodule_from_path(the_repository, &null_oid, path);
 	if (!sub)
 		return NULL;
 
diff --git a/submodule-config.c b/submodule-config.c
index a3efff1a34..4b7803e6ed 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -619,18 +619,20 @@ static void gitmodules_read_check(struct repository *repo)
 		repo_read_gitmodules(repo);
 }
 
-const struct submodule *submodule_from_name(const struct object_id *treeish_name,
+const struct submodule *submodule_from_name(struct repository *r,
+					    const struct object_id *treeish_name,
 		const char *name)
 {
-	gitmodules_read_check(the_repository);
-	return config_from(the_repository->submodule_cache, treeish_name, name, lookup_name);
+	gitmodules_read_check(r);
+	return config_from(r->submodule_cache, treeish_name, name, lookup_name);
 }
 
-const struct submodule *submodule_from_path(const struct object_id *treeish_name,
+const struct submodule *submodule_from_path(struct repository *r,
+					    const struct object_id *treeish_name,
 		const char *path)
 {
-	gitmodules_read_check(the_repository);
-	return config_from(the_repository->submodule_cache, treeish_name, path, lookup_path);
+	gitmodules_read_check(r);
+	return config_from(r->submodule_cache, treeish_name, path, lookup_path);
 }
 
 const struct submodule *submodule_from_cache(struct repository *repo,
diff --git a/submodule-config.h b/submodule-config.h
index 6b71a8cd30..43dfe7dec0 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -39,10 +39,12 @@ extern int parse_update_recurse_submodules_arg(const char *opt, const char *arg)
 extern int parse_push_recurse_submodules_arg(const char *opt, const char *arg);
 extern void repo_read_gitmodules(struct repository *repo);
 extern void gitmodules_config_oid(const struct object_id *commit_oid);
-extern const struct submodule *submodule_from_name(
-		const struct object_id *commit_or_tree, const char *name);
-extern const struct submodule *submodule_from_path(
-		const struct object_id *commit_or_tree, const char *path);
+const struct submodule *submodule_from_name(struct repository *r,
+					    const struct object_id *commit_or_tree,
+					    const char *name);
+const struct submodule *submodule_from_path(struct repository *r,
+					    const struct object_id *commit_or_tree,
+					    const char *path);
 extern const struct submodule *submodule_from_cache(struct repository *repo,
 						    const struct object_id *treeish_name,
 						    const char *key);
diff --git a/submodule.c b/submodule.c
index 12a2503fda..e94b7f9acd 100644
--- a/submodule.c
+++ b/submodule.c
@@ -95,7 +95,7 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 	if (is_gitmodules_unmerged(&the_index))
 		die(_("Cannot change unmerged .gitmodules, resolve merge conflicts first"));
 
-	submodule = submodule_from_path(&null_oid, oldpath);
+	submodule = submodule_from_path(the_repository, &null_oid, oldpath);
 	if (!submodule || !submodule->name) {
 		warning(_("Could not find section in .gitmodules where path=%s"), oldpath);
 		return -1;
@@ -129,7 +129,7 @@ int remove_path_from_gitmodules(const char *path)
 	if (is_gitmodules_unmerged(&the_index))
 		die(_("Cannot change unmerged .gitmodules, resolve merge conflicts first"));
 
-	submodule = submodule_from_path(&null_oid, path);
+	submodule = submodule_from_path(the_repository, &null_oid, path);
 	if (!submodule || !submodule->name) {
 		warning(_("Could not find section in .gitmodules where path=%s"), path);
 		return -1;
@@ -173,7 +173,8 @@ static int add_submodule_odb(const char *path)
 void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 					     const char *path)
 {
-	const struct submodule *submodule = submodule_from_path(&null_oid, path);
+	const struct submodule *submodule = submodule_from_path(the_repository,
+								&null_oid, path);
 	if (submodule) {
 		const char *ignore;
 		char *key;
@@ -673,7 +674,7 @@ const struct submodule *submodule_from_ce(const struct cache_entry *ce)
 	if (!should_update_submodules())
 		return NULL;
 
-	return submodule_from_path(&null_oid, ce->name);
+	return submodule_from_path(the_repository, &null_oid, ce->name);
 }
 
 static struct oid_array *submodule_commits(struct string_list *submodules,
@@ -730,13 +731,14 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
 		if (!S_ISGITLINK(p->two->mode))
 			continue;
 
-		submodule = submodule_from_path(commit_oid, p->two->path);
+		submodule = submodule_from_path(the_repository,
+						commit_oid, p->two->path);
 		if (submodule)
 			name = submodule->name;
 		else {
 			name = default_name_or_path(p->two->path);
 			/* make sure name does not collide with existing one */
-			submodule = submodule_from_name(commit_oid, name);
+			submodule = submodule_from_name(the_repository, commit_oid, name);
 			if (submodule) {
 				warning("Submodule in commit %s at path: "
 					"'%s' collides with a submodule named "
@@ -944,7 +946,7 @@ int find_unpushed_submodules(struct oid_array *commits,
 		const struct submodule *submodule;
 		const char *path = NULL;
 
-		submodule = submodule_from_name(&null_oid, name->string);
+		submodule = submodule_from_name(the_repository, &null_oid, name->string);
 		if (submodule)
 			path = submodule->path;
 		else
@@ -1112,7 +1114,7 @@ static void calculate_changed_submodule_paths(void)
 	const struct string_list_item *name;
 
 	/* No need to check if there are no submodules configured */
-	if (!submodule_from_path(NULL, NULL))
+	if (!submodule_from_path(the_repository, NULL, NULL))
 		return;
 
 	argv_array_push(&argv, "--"); /* argv[0] program name */
@@ -1133,7 +1135,7 @@ static void calculate_changed_submodule_paths(void)
 		const struct submodule *submodule;
 		const char *path = NULL;
 
-		submodule = submodule_from_name(&null_oid, name->string);
+		submodule = submodule_from_name(the_repository, &null_oid, name->string);
 		if (submodule)
 			path = submodule->path;
 		else
@@ -1161,7 +1163,7 @@ int submodule_touches_in_range(struct object_id *excl_oid,
 	int ret;
 
 	/* No need to check if there are no submodules configured */
-	if (!submodule_from_path(NULL, NULL))
+	if (!submodule_from_path(the_repository, NULL, NULL))
 		return 0;
 
 	argv_array_push(&args, "--"); /* args[0] program name */
@@ -1603,7 +1605,7 @@ int submodule_move_head(const char *path,
 	if (old_head && !is_submodule_populated_gently(path, error_code_ptr))
 		return 0;
 
-	sub = submodule_from_path(&null_oid, path);
+	sub = submodule_from_path(the_repository, &null_oid, path);
 
 	if (!sub)
 		die("BUG: could not get submodule information for '%s'", path);
@@ -1885,7 +1887,7 @@ static void relocate_single_git_dir_into_superproject(const char *prefix,
 
 	real_old_git_dir = real_pathdup(old_git_dir, 1);
 
-	sub = submodule_from_path(&null_oid, path);
+	sub = submodule_from_path(the_repository, &null_oid, path);
 	if (!sub)
 		die(_("could not lookup name for submodule '%s'"), path);
 
@@ -1941,7 +1943,7 @@ void absorb_git_dir_into_superproject(const char *prefix,
 		* superproject did not rewrite the git file links yet,
 		* fix it now.
 		*/
-		sub = submodule_from_path(&null_oid, path);
+		sub = submodule_from_path(the_repository, &null_oid, path);
 		if (!sub)
 			die(_("could not lookup name for submodule '%s'"), path);
 		connect_work_tree_and_git_dir(path,
@@ -2087,7 +2089,7 @@ int submodule_to_gitdir(struct strbuf *buf, const char *submodule)
 		strbuf_addstr(buf, git_dir);
 	}
 	if (!is_git_directory(buf->buf)) {
-		sub = submodule_from_path(&null_oid, submodule);
+		sub = submodule_from_path(the_repository, &null_oid, submodule);
 		if (!sub) {
 			ret = -1;
 			goto cleanup;
diff --git a/t/helper/test-submodule-config.c b/t/helper/test-submodule-config.c
index 9971c5e9dd..e044871cee 100644
--- a/t/helper/test-submodule-config.c
+++ b/t/helper/test-submodule-config.c
@@ -48,9 +48,11 @@ int cmd_main(int argc, const char **argv)
 			die_usage(argc, argv, "Commit not found.");
 
 		if (lookup_name) {
-			submodule = submodule_from_name(&commit_oid, path_or_name);
+			submodule = submodule_from_name(the_repository,
+							&commit_oid, path_or_name);
 		} else
-			submodule = submodule_from_path(&commit_oid, path_or_name);
+			submodule = submodule_from_path(the_repository,
+							&commit_oid, path_or_name);
 		if (!submodule)
 			die_usage(argc, argv, "Submodule not found.");
 
-- 
2.17.0.rc1.321.gba9d0f2565-goog

