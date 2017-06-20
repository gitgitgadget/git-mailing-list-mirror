Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F0AF20D19
	for <e@80x24.org>; Tue, 20 Jun 2017 19:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbdFTTUV (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 15:20:21 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34132 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751036AbdFTTUU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 15:20:20 -0400
Received: by mail-pg0-f43.google.com with SMTP id e187so14376738pgc.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 12:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P/o6Br3GqIhuSKMY/eHGXQCLlepN9kc0nYIzqemF6lI=;
        b=ORgVkpGoNkG9jtruA3oyOgXXNh5Pm7brZCcqaGDF93bovkLcQYfGTG07Ukuy71lSNd
         ehJJsQjxmOwXXj7EQP9YeV+ceBuDLI2XDawszWIqxGUSml0wXwlf8bk3dfaMGzHuiOHk
         vplCgD9lH82Kbw8ZHYPV+BptH3i5b07U3/6BFz6RzARikH+Hf6HLzWWqdrJ8Dh7c8AgJ
         wKJwtqBZ0di24HAvVgLhuIwc6s/Nu9ctQozjsumPYRpbdIYO+A2J46H5GI5/miBOtY+B
         opCtBiauE19Whn4pioUCkAyvVOyg8SgJsaaaKEVErH2hoE+WYBP9oxRf4E4lK4cN/hUP
         thgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P/o6Br3GqIhuSKMY/eHGXQCLlepN9kc0nYIzqemF6lI=;
        b=JvH5CeUYii7QPGZieZ1b/u7EuQf8oiuTVxUmOwGGFMcGsaux8J7e1Cl7q0YH5/Yjrr
         FuZA4GOcqvE8E1OJYhwLdrEGAMNHnZEXP1MT0U0NtzpNFbDkrphZlPTk08wO/jgBLfT5
         uFXenGFi2Kors2CBrYkdrRWDHPC8IU7d4dq+6Wz65cksb5VoKhbAnJKr00ayh55g45KV
         DhHJ9eEq9kbBhS4gsfPUGAG1DU5ljELImeCVPpYJNQpiEMUvacfNkAqcPw4QWd6sR8us
         2F2btdD+mDotLM/7d2j0eegJZwGjWSbEtFEqHVpzqFVg2mGtFIt7TLLu5adFTgVKdzWX
         BlIw==
X-Gm-Message-State: AKS2vOwuV4939Ae8gd/taDOIm6bx5+/FfTt4RIKeuOZkroHrBjaFgbwq
        sS/n0cZx6lC/sYRq89bAlQ==
X-Received: by 10.98.150.157 with SMTP id s29mr32138049pfk.172.1497986418829;
        Tue, 20 Jun 2017 12:20:18 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t6sm18680500pgs.33.2017.06.20.12.20.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 12:20:17 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 05/20] environment: place key repository state in the_repository
Date:   Tue, 20 Jun 2017 12:19:36 -0700
Message-Id: <20170620191951.84791-6-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1-goog
In-Reply-To: <20170620191951.84791-1-bmwill@google.com>
References: <20170608234100.188529-1-bmwill@google.com>
 <20170620191951.84791-1-bmwill@google.com>
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
2.13.1.611.g7e3b11ae1-goog

