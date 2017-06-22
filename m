Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D308D1FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 18:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753598AbdFVSoP (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 14:44:15 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35921 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753529AbdFVSoK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 14:44:10 -0400
Received: by mail-pf0-f177.google.com with SMTP id q86so12531965pfl.3
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 11:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5JFPvVX43K2MGOX84TWAEAC7RGaeMzNXOyDwrkZYABE=;
        b=BwRXgk2B5E6pHqJlihSYLG7R4oI5lh81cEmQt9EZpf1WbYN1b156Fi40ACSXtutWRu
         xMxiCsWSsLue8paJwx3Hzxm2RNJ0diriYfnwGBmrm/bvFiGR3nRDJGOiagORl4dzOuRQ
         5ZASEm20a+vx9sze7F3EBiw2Bugq6BaeXY9uCmE3Qk5oIVCuirqhZ1i5OEkCk2s1piu4
         UhjkQM0gPDYjfZ6Ah2V1BZa5LqLU3rgtARu9rj/xJqSHiaMzwrdi0/ndbXAgTK9d/owF
         bzVJXNQx+j7TyrOdh0LFG5PPSNyGjRvVIlzU+VIZlDCRVwCzwMSIqVpKLW7NkDula/9I
         00QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5JFPvVX43K2MGOX84TWAEAC7RGaeMzNXOyDwrkZYABE=;
        b=L8CwhPG1rzC1KEAgr7AF4bcZboxEH/ftwmBer5I/Se0zEo1W9v/bg/DBJukxpD+/7P
         P3yPQY1c76TwwhqgEKTiqqpkzOavIfqsWqvmFVpxNeI36w078juhVpTQrcUT0j01fJ2B
         SyaNF2Aj1J6GBMgJxjxBLpHUo07YG3Z6+1/AVzfgd0/8GolLO64hQNoSUk7pHobdRdEH
         FLcRz9ppMnsyKowNW/kbvGHNsZ9lND8K6k4wLytadxPjzHEpwW35MYYefntF1m0/3E6+
         227hvKWSoO4Tuw6fCi++4o+tqqAjd9EidDQ3vZ+oZbxy8XYw2n8PFoSKG13CVt0ft63b
         e5LA==
X-Gm-Message-State: AKS2vOzV+pllxZ68USqxpVc+wfdnb1X6GE+r222pF0LfdaJfy2DIBMup
        YgylU1R9jPtsdQe6IxP5zA==
X-Received: by 10.99.181.13 with SMTP id y13mr4021759pge.83.1498157049491;
        Thu, 22 Jun 2017 11:44:09 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id g78sm5222211pfb.122.2017.06.22.11.44.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 11:44:08 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 05/20] environment: place key repository state in the_repository
Date:   Thu, 22 Jun 2017 11:43:33 -0700
Message-Id: <20170622184348.56497-6-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.704.gde00cce3c-goog
In-Reply-To: <20170622184348.56497-1-bmwill@google.com>
References: <20170620191951.84791-1-bmwill@google.com>
 <20170622184348.56497-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Migrate 'git_dir', 'git_common_dir', 'git_object_dir', 'git_index_file',
'git_graft_file', and 'namespace' to be stored in 'the_repository'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 cache.h       |  1 -
 environment.c | 58 +++++++++++++---------------------------------------------
 path.c        | 11 ++++++-----
 setup.c       | 17 +++++++++++++++--
 4 files changed, 34 insertions(+), 53 deletions(-)

diff --git a/cache.h b/cache.h
index 7c81749a9..cd64cbc81 100644
--- a/cache.h
+++ b/cache.h
@@ -771,7 +771,6 @@ extern int core_apply_sparse_checkout;
 extern int precomposed_unicode;
 extern int protect_hfs;
 extern int protect_ntfs;
-extern int git_db_env, git_index_env, git_graft_env, git_common_dir_env;
 
 /*
  * Include broken refs in all ref iterations, which will
diff --git a/environment.c b/environment.c
index e035f6372..aa79ef83e 100644
--- a/environment.c
+++ b/environment.c
@@ -8,6 +8,7 @@
  * are.
  */
 #include "cache.h"
+#include "repository.h"
 #include "config.h"
 #include "refs.h"
 #include "fmt-merge-msg.h"
@@ -101,10 +102,6 @@ static const char *namespace;
 
 static const char *super_prefix;
 
-static const char *git_dir, *git_common_dir;
-static char *git_object_dir, *git_index_file, *git_graft_file;
-int git_db_env, git_index_env, git_graft_env, git_common_dir_env;
-
 /*
  * Repository-local GIT_* environment variables; see cache.h for details.
  */
@@ -148,41 +145,11 @@ static char *expand_namespace(const char *raw_namespace)
 	return strbuf_detach(&buf, NULL);
 }
 
-static char *git_path_from_env(const char *envvar, const char *git_dir,
-			       const char *path, int *fromenv)
-{
-	const char *value = getenv(envvar);
-	if (!value)
-		return xstrfmt("%s/%s", git_dir, path);
-	if (fromenv)
-		*fromenv = 1;
-	return xstrdup(value);
-}
-
 void setup_git_env(void)
 {
-	struct strbuf sb = STRBUF_INIT;
-	const char *gitfile;
 	const char *shallow_file;
 	const char *replace_ref_base;
 
-	git_dir = getenv(GIT_DIR_ENVIRONMENT);
-	if (!git_dir) {
-		if (!startup_info->have_repository)
-			BUG("setup_git_env called without repository");
-		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
-	}
-	gitfile = read_gitfile(git_dir);
-	git_dir = xstrdup(gitfile ? gitfile : git_dir);
-	if (get_common_dir(&sb, git_dir))
-		git_common_dir_env = 1;
-	git_common_dir = strbuf_detach(&sb, NULL);
-	git_object_dir = git_path_from_env(DB_ENVIRONMENT, git_common_dir,
-					   "objects", &git_db_env);
-	git_index_file = git_path_from_env(INDEX_ENVIRONMENT, git_dir,
-					   "index", &git_index_env);
-	git_graft_file = git_path_from_env(GRAFT_ENVIRONMENT, git_common_dir,
-					   "info/grafts", &git_graft_env);
 	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
 		check_replace_refs = 0;
 	replace_ref_base = getenv(GIT_REPLACE_REF_BASE_ENVIRONMENT);
@@ -203,21 +170,21 @@ int is_bare_repository(void)
 int have_git_dir(void)
 {
 	return startup_info->have_repository
-		|| git_dir;
+		|| the_repository->gitdir;
 }
 
 const char *get_git_dir(void)
 {
-	if (!git_dir)
+	if (!the_repository->gitdir)
 		BUG("git environment hasn't been setup");
-	return git_dir;
+	return the_repository->gitdir;
 }
 
 const char *get_git_common_dir(void)
 {
-	if (!git_dir)
+	if (!the_repository->commondir)
 		BUG("git environment hasn't been setup");
-	return git_common_dir;
+	return the_repository->commondir;
 }
 
 const char *get_git_namespace(void)
@@ -273,9 +240,9 @@ const char *get_git_work_tree(void)
 
 char *get_object_directory(void)
 {
-	if (!git_object_dir)
+	if (!the_repository->objectdir)
 		BUG("git environment hasn't been setup");
-	return git_object_dir;
+	return the_repository->objectdir;
 }
 
 int odb_mkstemp(struct strbuf *template, const char *pattern)
@@ -313,22 +280,23 @@ int odb_pack_keep(const char *name)
 
 char *get_index_file(void)
 {
-	if (!git_index_file)
+	if (!the_repository->index_file)
 		BUG("git environment hasn't been setup");
-	return git_index_file;
+	return the_repository->index_file;
 }
 
 char *get_graft_file(void)
 {
-	if (!git_graft_file)
+	if (!the_repository->graft_file)
 		BUG("git environment hasn't been setup");
-	return git_graft_file;
+	return the_repository->graft_file;
 }
 
 int set_git_dir(const char *path)
 {
 	if (setenv(GIT_DIR_ENVIRONMENT, path, 1))
 		return error("Could not set GIT_DIR to '%s'", path);
+	repo_set_gitdir(the_repository, path);
 	setup_git_env();
 	return 0;
 }
diff --git a/path.c b/path.c
index c1cb1cf62..e4abea083 100644
--- a/path.c
+++ b/path.c
@@ -2,6 +2,7 @@
  * Utilities for paths and pathnames
  */
 #include "cache.h"
+#include "repository.h"
 #include "strbuf.h"
 #include "string-list.h"
 #include "dir.h"
@@ -355,7 +356,7 @@ void report_linked_checkout_garbage(void)
 	const struct common_dir *p;
 	int len;
 
-	if (!git_common_dir_env)
+	if (!the_repository->different_commondir)
 		return;
 	strbuf_addf(&sb, "%s/", get_git_dir());
 	len = sb.len;
@@ -374,17 +375,17 @@ void report_linked_checkout_garbage(void)
 static void adjust_git_path(struct strbuf *buf, int git_dir_len)
 {
 	const char *base = buf->buf + git_dir_len;
-	if (git_graft_env && is_dir_file(base, "info", "grafts"))
+	if (is_dir_file(base, "info", "grafts"))
 		strbuf_splice(buf, 0, buf->len,
 			      get_graft_file(), strlen(get_graft_file()));
-	else if (git_index_env && !strcmp(base, "index"))
+	else if (!strcmp(base, "index"))
 		strbuf_splice(buf, 0, buf->len,
 			      get_index_file(), strlen(get_index_file()));
-	else if (git_db_env && dir_prefix(base, "objects"))
+	else if (dir_prefix(base, "objects"))
 		replace_dir(buf, git_dir_len + 7, get_object_directory());
 	else if (git_hooks_path && dir_prefix(base, "hooks"))
 		replace_dir(buf, git_dir_len + 5, git_hooks_path);
-	else if (git_common_dir_env)
+	else if (the_repository->different_commondir)
 		update_common_dir(buf, git_dir_len, NULL);
 }
 
diff --git a/setup.c b/setup.c
index b477faa44..860507e1f 100644
--- a/setup.c
+++ b/setup.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "repository.h"
 #include "config.h"
 #include "dir.h"
 #include "string-list.h"
@@ -398,6 +399,11 @@ void setup_work_tree(void)
 	if (getenv(GIT_WORK_TREE_ENVIRONMENT))
 		setenv(GIT_WORK_TREE_ENVIRONMENT, ".", 1);
 
+	/*
+	 * NEEDSWORK: this call can essentially be set_git_dir(get_git_dir())
+	 * which can cause some problems when trying to free the old value of
+	 * gitdir.
+	 */
 	set_git_dir(remove_leading_path(git_dir, work_tree));
 	initialized = 1;
 }
@@ -1108,8 +1114,15 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	 * the user has set GIT_DIR.  It may be beneficial to disallow bogus
 	 * GIT_DIR values at some point in the future.
 	 */
-	if (startup_info->have_repository || getenv(GIT_DIR_ENVIRONMENT))
-		setup_git_env();
+	if (startup_info->have_repository || getenv(GIT_DIR_ENVIRONMENT)) {
+		if (!the_repository->gitdir) {
+			const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
+			if (!gitdir)
+				gitdir = DEFAULT_GIT_DIR_ENVIRONMENT;
+			repo_set_gitdir(the_repository, gitdir);
+			setup_git_env();
+		}
+	}
 
 	strbuf_release(&dir);
 	strbuf_release(&gitdir);
-- 
2.13.1.704.gde00cce3c-goog

