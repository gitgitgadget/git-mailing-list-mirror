Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB4B51F404
	for <e@80x24.org>; Wed, 28 Feb 2018 01:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751856AbeB1Bhu (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 20:37:50 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44186 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751811AbeB1Bht (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 20:37:49 -0500
Received: by mail-pl0-f65.google.com with SMTP id w21-v6so542927plp.11
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 17:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fLcxjgeKY4CIPlFn0lHqSdWS+pAyKqq1goDaZ/fwPGo=;
        b=XrcdvB3HSymucGwzcUubzbx8RDfZobrvBuCnwzklo7pS3IdzrEWQNW8bTY503EgfpG
         ipk+uD6YvfMqlS2ROS5CDMDFkytIoRGrRRf9FIELSLI53hU2G7HUcsL5KySQzilLlsMD
         eSPUeSygaIDnCv9byCU7NQDAANCzUtJIS3W0w6Np+MQLVFjYApj/oHXT5TtbsDAsxTFi
         q+xomZH6ijYh49S99wIe2xP2rxJMn5q47slhdssaAIkBy04oH3Bvui7UZbMPxBiVHE2J
         oT1nrCYhV5PWfb3ffd8N/LBwTtgg+wasRhzZvldeL6hYs+3Cv/D+6AKdYOOAn4k5NlvX
         cUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fLcxjgeKY4CIPlFn0lHqSdWS+pAyKqq1goDaZ/fwPGo=;
        b=IVZ/8oYv29l4VmtFDPjsJhclMsnFOn3glekC7ioY8xT56W/f/M13DXs1PfRWnOexW+
         3nAW/PwwVnLpZuUPH9wnp0/s2tBca8CWr4P079pR8UA/fBqciw1oDr6VvLoW8TOgVSAw
         fbXeorKATv2MwrwezUcAZvuXNpIf4LOF6JeQSE8gfdR9uqg+NMvR8PFITYVNlRRfHCT4
         WLzCPU4X7JvmVYOe3qLHlqRIpFCoIyj6kukpRHUNyiJUcPnoD9ZDb4iY2RtKpWARB7d5
         Il/qeT8RgdAkmCHyqsoBTomFGl3miQOFbzRXp+vbuZS4aCLv2h2EeVg3niQQ9hMDPngH
         zH0g==
X-Gm-Message-State: APf1xPBf4uwpsqOZDQQPsyFeM8Dh6jzTZBVB5lLmwsSwxpAX2TCAJWjj
        j3XjaelWU1Rl4nnNbkbKcp8=
X-Google-Smtp-Source: AH8x227sjbQYZyvlxr5evVhtm44IXaBVsPRkizCcu4zDq2ig5DL2JCIMi/Hh+RDoVkB3IzoHXWhZew==
X-Received: by 2002:a17:902:9693:: with SMTP id n19-v6mr16006538plp.69.1519781868706;
        Tue, 27 Feb 2018 17:37:48 -0800 (PST)
Received: from duynguyen.dek-tpc.internal ([14.161.14.188])
        by smtp.gmail.com with ESMTPSA id n13sm573588pfg.45.2018.02.27.17.37.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Feb 2018 17:37:48 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, sbeller@google.com,
        sunshine@sunshineco.com
Subject: [PATCH v3 1/4] repository.c: move env-related setup code back to environment.c
Date:   Wed, 28 Feb 2018 08:37:24 +0700
Message-Id: <20180228013727.13815-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.399.g632f88eed1
In-Reply-To: <20180228013727.13815-1-pclouds@gmail.com>
References: <20180227095846.9238-1-pclouds@gmail.com>
 <20180228013727.13815-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It does not make sense that generic repository code contains handling
of environment variables, which are specific for the main repository
only. Refactor repo_set_gitdir() function to take $GIT_DIR and
optionally _all_ other customizable paths. These optional paths can be
NULL and will be calculated according to the default directory layout.

Note that some dead functions are left behind to reduce diff
noise. They will be deleted in the next patch.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 cache.h       |  2 +-
 environment.c | 30 +++++++++++++++++++++++---
 repository.c  | 59 ++++++++++++++++++++++++++++++++++-----------------
 repository.h  | 11 +++++++++-
 setup.c       |  3 +--
 5 files changed, 79 insertions(+), 26 deletions(-)

diff --git a/cache.h b/cache.h
index 5717399183..b164a407eb 100644
--- a/cache.h
+++ b/cache.h
@@ -459,7 +459,7 @@ static inline enum object_type object_type(unsigned int mode)
  */
 extern const char * const local_repo_env[];
 
-extern void setup_git_env(void);
+extern void setup_git_env(const char *git_dir);
 
 /*
  * Returns true iff we have a configured git repository (either via
diff --git a/environment.c b/environment.c
index ec10b062e6..454e435bed 100644
--- a/environment.c
+++ b/environment.c
@@ -14,6 +14,7 @@
 #include "fmt-merge-msg.h"
 #include "commit.h"
 #include "object-store.h"
+#include "argv-array.h"
 
 int trust_executable_bit = 1;
 int trust_ctime = 1;
@@ -148,10 +149,34 @@ static char *expand_namespace(const char *raw_namespace)
 	return strbuf_detach(&buf, NULL);
 }
 
-void setup_git_env(void)
+/*
+ * Wrapper of getenv() that returns a strdup value. This value is kept
+ * in argv to be freed later.
+ */
+static const char *getenv_safe(struct argv_array *argv, const char *name)
+{
+	const char *value = getenv(name);
+
+	if (!value)
+		return NULL;
+
+	argv_array_push(argv, value);
+	return argv->argv[argv->argc - 1];
+}
+
+void setup_git_env(const char *git_dir)
 {
 	const char *shallow_file;
 	const char *replace_ref_base;
+	struct set_gitdir_args args = { NULL };
+	struct argv_array to_free = ARGV_ARRAY_INIT;
+
+	args.commondir = getenv_safe(&to_free, GIT_COMMON_DIR_ENVIRONMENT);
+	args.object_dir = getenv_safe(&to_free, DB_ENVIRONMENT);
+	args.graft_file = getenv_safe(&to_free, GRAFT_ENVIRONMENT);
+	args.index_file = getenv_safe(&to_free, INDEX_ENVIRONMENT);
+	repo_set_gitdir(the_repository, git_dir, &args);
+	argv_array_clear(&to_free);
 
 	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
 		check_replace_refs = 0;
@@ -301,8 +326,7 @@ int set_git_dir(const char *path)
 {
 	if (setenv(GIT_DIR_ENVIRONMENT, path, 1))
 		return error("Could not set GIT_DIR to '%s'", path);
-	repo_set_gitdir(the_repository, path);
-	setup_git_env();
+	setup_git_env(path);
 	return 0;
 }
 
diff --git a/repository.c b/repository.c
index a069b1b640..ae117efbf0 100644
--- a/repository.c
+++ b/repository.c
@@ -41,35 +41,55 @@ static int find_common_dir(struct strbuf *sb, const char *gitdir, int fromenv)
 	return get_common_dir_noenv(sb, gitdir);
 }
 
-static void repo_setup_env(struct repository *repo)
+static void expand_base_dir(char **out, const char *in,
+			    const char *base_dir, const char *def_in)
+{
+	free(*out);
+	if (in)
+		*out = xstrdup(in);
+	else
+		*out = xstrfmt("%s/%s", base_dir, def_in);
+}
+
+static void repo_set_commondir(struct repository *repo,
+			       const char *commondir)
 {
 	struct strbuf sb = STRBUF_INIT;
 
-	repo->different_commondir = find_common_dir(&sb, repo->gitdir,
-						    !repo->ignore_env);
 	free(repo->commondir);
+
+	if (commondir) {
+		repo->different_commondir = 1;
+		repo->commondir = xstrdup(commondir);
+		return;
+	}
+
+	repo->different_commondir = get_common_dir_noenv(&sb, repo->gitdir);
 	repo->commondir = strbuf_detach(&sb, NULL);
-	raw_object_store_clear(&repo->objects);
-	repo->objects.objectdir =
-		git_path_from_env(DB_ENVIRONMENT, repo->commondir,
-				  "objects", !repo->ignore_env);
-	free(repo->graft_file);
-	repo->graft_file = git_path_from_env(GRAFT_ENVIRONMENT, repo->commondir,
-					     "info/grafts", !repo->ignore_env);
-	free(repo->index_file);
-	repo->index_file = git_path_from_env(INDEX_ENVIRONMENT, repo->gitdir,
-					     "index", !repo->ignore_env);
 }
 
-void repo_set_gitdir(struct repository *repo, const char *path)
+void repo_set_gitdir(struct repository *repo,
+		     const char *root,
+		     const struct set_gitdir_args *o)
 {
-	const char *gitfile = read_gitfile(path);
+	const char *gitfile = read_gitfile(root);
+	/*
+	 * repo->gitdir is saved because the caller could pass "root"
+	 * that also points to repo->gitdir. We want to keep it alive
+	 * until after xstrdup(root). Then we can free it.
+	 */
 	char *old_gitdir = repo->gitdir;
 
-	repo->gitdir = xstrdup(gitfile ? gitfile : path);
-	repo_setup_env(repo);
-
+	repo->gitdir = xstrdup(gitfile ? gitfile : root);
 	free(old_gitdir);
+
+	repo_set_commondir(repo, o->commondir);
+	expand_base_dir(&repo->objects.objectdir, o->object_dir,
+			repo->commondir, "objects");
+	expand_base_dir(&repo->graft_file, o->graft_file,
+			repo->commondir, "info/grafts");
+	expand_base_dir(&repo->index_file, o->index_file,
+			repo->gitdir, "index");
 }
 
 void repo_set_hash_algo(struct repository *repo, int hash_algo)
@@ -87,6 +107,7 @@ static int repo_init_gitdir(struct repository *repo, const char *gitdir)
 	int error = 0;
 	char *abspath = NULL;
 	const char *resolved_gitdir;
+	struct set_gitdir_args args = { NULL };
 
 	abspath = real_pathdup(gitdir, 0);
 	if (!abspath) {
@@ -101,7 +122,7 @@ static int repo_init_gitdir(struct repository *repo, const char *gitdir)
 		goto out;
 	}
 
-	repo_set_gitdir(repo, resolved_gitdir);
+	repo_set_gitdir(repo, resolved_gitdir, &args);
 
 out:
 	free(abspath);
diff --git a/repository.h b/repository.h
index fa73ab8e93..f917baa584 100644
--- a/repository.h
+++ b/repository.h
@@ -89,7 +89,16 @@ struct repository {
 
 extern struct repository *the_repository;
 
-extern void repo_set_gitdir(struct repository *repo, const char *path);
+struct set_gitdir_args {
+	const char *commondir;
+	const char *object_dir;
+	const char *graft_file;
+	const char *index_file;
+};
+
+extern void repo_set_gitdir(struct repository *repo,
+			    const char *root,
+			    const struct set_gitdir_args *optional);
 extern void repo_set_worktree(struct repository *repo, const char *path);
 extern void repo_set_hash_algo(struct repository *repo, int algo);
 extern int repo_init(struct repository *repo, const char *gitdir, const char *worktree);
diff --git a/setup.c b/setup.c
index c5d55dcee4..6fac1bb58a 100644
--- a/setup.c
+++ b/setup.c
@@ -1116,8 +1116,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
 			if (!gitdir)
 				gitdir = DEFAULT_GIT_DIR_ENVIRONMENT;
-			repo_set_gitdir(the_repository, gitdir);
-			setup_git_env();
+			setup_git_env(gitdir);
 		}
 		if (startup_info->have_repository)
 			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
-- 
2.16.1.399.g632f88eed1

