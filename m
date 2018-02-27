Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87B611F576
	for <e@80x24.org>; Tue, 27 Feb 2018 09:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752444AbeB0J7B (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 04:59:01 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:43438 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752384AbeB0J67 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 04:58:59 -0500
Received: by mail-pg0-f65.google.com with SMTP id e9so2996989pgs.10
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 01:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DwoOiK/ox631BejnaHpc9yWQuOONNcQp6w2Wlf3p5KI=;
        b=qerT2/ubuNRh/61dGgBfPiCMLjb9aQVpFunq+/UAmp+iqAFRROC6eVlM3LAiGMAeN8
         aPsot81/NM3gwuRkHp+6YAGCSSarX/2P47jfi/4wlWha7I5B0SKa7uDsi2MoPd7/vRjM
         XxbOZ3CS5cATufdDPnjG3MajIvlKCk7XTywlw9zkhdYaFPIayJXRcUKTiMPbDbakO3HB
         jOJ77+b6X4IvFT+ii3CmeBdC2ZtWftnjpeuxLQMRCdEaby3C2/woe1+NYsInM4HaPpnC
         J9+ev1ovenenjUh/CTqVLVxg7ITuCXuz2LZv+zBTCL8tddmYQDO+9uzjAhk0nq1C9Yn/
         yMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DwoOiK/ox631BejnaHpc9yWQuOONNcQp6w2Wlf3p5KI=;
        b=FZpTAobxh5FV5/KZkE0gmotx8Wxwfn/OJkV1KCN6qtgFDe58h/NhiwDFvp4h9b0E5k
         2xSdT6NoOsf9dqkjhX1Un5rndXjuOcFTF+oqJu7kUzKk49azT85XHC21UCMhBXOSXz1E
         axkUHpj+/J07kE+KsC5sfTaIx+r9NmvpkL/jD8tN5m8xRxii515KI12Y0yZLC1CIrBQ3
         xWGA96ZW7PB4pd1vRkBu2pU1tcDqC3lTdAfuM/tLLZqFgMdceDKCaVF+iwf1KCmijpfs
         SBbD7CUSlEyf4nPgk3ix+aUpWumP9uOkIf9pbaHWXvDcOXXRh7Jq2vCRjlcdFdTIW9mu
         QGbw==
X-Gm-Message-State: APf1xPArNk75YhAyrEn+Gs27cAQ7j84yoitHm4wr0al/Sj4HwPkUpMyQ
        cFWgaUHk+pUKTgUc6ueyoxs=
X-Google-Smtp-Source: AH8x224eR3EkBGiNrHU9XpB4txtVVty0lSb37G8lTSmeDigVP4o6dgpl/aUvrXI2LiyfpQDcs3wKWg==
X-Received: by 10.98.58.129 with SMTP id v1mr13570827pfj.203.1519725539409;
        Tue, 27 Feb 2018 01:58:59 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id r80sm22986686pfe.170.2018.02.27.01.58.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Feb 2018 01:58:58 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 27 Feb 2018 16:58:54 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, sbeller@google.com,
        sunshine@sunshineco.com
Subject: [PATCH v2 1/4] repository.c: move env-related setup code back to environment.c
Date:   Tue, 27 Feb 2018 16:58:43 +0700
Message-Id: <20180227095846.9238-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180227095846.9238-1-pclouds@gmail.com>
References: <20180226103030.26900-1-pclouds@gmail.com>
 <20180227095846.9238-1-pclouds@gmail.com>
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
 environment.c | 29 +++++++++++++++++++++++++---
 repository.c  | 53 +++++++++++++++++++++++++++++++++++++++++++++------
 repository.h  | 11 ++++++++++-
 setup.c       |  3 +--
 5 files changed, 85 insertions(+), 13 deletions(-)

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
index ec10b062e6..74a2900ddf 100644
--- a/environment.c
+++ b/environment.c
@@ -14,6 +14,7 @@
 #include "fmt-merge-msg.h"
 #include "commit.h"
 #include "object-store.h"
+#include "argv-array.h"
 
 int trust_executable_bit = 1;
 int trust_ctime = 1;
@@ -148,10 +149,33 @@ static char *expand_namespace(const char *raw_namespace)
 	return strbuf_detach(&buf, NULL);
 }
 
-void setup_git_env(void)
+/* Wrapper of getenv() that returns a strdup value. This value is kept
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
+	args.shared_root = getenv_safe(&to_free, GIT_COMMON_DIR_ENVIRONMENT);
+	args.object_dir = getenv_safe(&to_free, DB_ENVIRONMENT);
+	args.graft_file = getenv_safe(&to_free, GRAFT_ENVIRONMENT);
+	args.index_file = getenv_safe(&to_free, INDEX_ENVIRONMENT);
+	repo_set_gitdir(the_repository, git_dir, &args);
+	argv_array_clear(&to_free);
 
 	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
 		check_replace_refs = 0;
@@ -301,8 +325,7 @@ int set_git_dir(const char *path)
 {
 	if (setenv(GIT_DIR_ENVIRONMENT, path, 1))
 		return error("Could not set GIT_DIR to '%s'", path);
-	repo_set_gitdir(the_repository, path);
-	setup_git_env();
+	setup_git_env(path);
 	return 0;
 }
 
diff --git a/repository.c b/repository.c
index a069b1b640..343efe7282 100644
--- a/repository.c
+++ b/repository.c
@@ -61,15 +61,55 @@ static void repo_setup_env(struct repository *repo)
 					     "index", !repo->ignore_env);
 }
 
-void repo_set_gitdir(struct repository *repo, const char *path)
+static void expand_base_dir(char **out, const char *in,
+			    const char *base_dir, const char *def_in)
 {
-	const char *gitfile = read_gitfile(path);
-	char *old_gitdir = repo->gitdir;
+	free(*out);
+	if (in)
+		*out = xstrdup(in);
+	else
+		*out = xstrfmt("%s/%s", base_dir, def_in);
+}
+
+static void repo_set_commondir(struct repository *repo,
+			       const char *shared_root)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	free(repo->commondir);
 
-	repo->gitdir = xstrdup(gitfile ? gitfile : path);
-	repo_setup_env(repo);
+	if (shared_root) {
+		repo->different_commondir = 1;
+		repo->commondir = xstrdup(shared_root);
+		return;
+	}
 
+	repo->different_commondir = get_common_dir_noenv(&sb, repo->gitdir);
+	repo->commondir = strbuf_detach(&sb, NULL);
+}
+
+void repo_set_gitdir(struct repository *repo,
+		     const char *root,
+		     const struct set_gitdir_args *o)
+{
+	const char *gitfile = read_gitfile(root);
+	/*
+	 * repo->gitdir is saved because the caller could pass "root"
+	 * that also points to repo->gitdir. We want to keep it alive
+	 * until after xstrdup(root). Then we can free it.
+	 */
+	char *old_gitdir = repo->gitdir;
+
+	repo->gitdir = xstrdup(gitfile ? gitfile : root);
 	free(old_gitdir);
+
+	repo_set_commondir(repo, o->shared_root);
+	expand_base_dir(&repo->objects.objectdir, o->object_dir,
+			repo->commondir, "objects");
+	expand_base_dir(&repo->graft_file, o->graft_file,
+			repo->commondir, "info/grafts");
+	expand_base_dir(&repo->index_file, o->index_file,
+			repo->gitdir, "index");
 }
 
 void repo_set_hash_algo(struct repository *repo, int hash_algo)
@@ -87,6 +127,7 @@ static int repo_init_gitdir(struct repository *repo, const char *gitdir)
 	int error = 0;
 	char *abspath = NULL;
 	const char *resolved_gitdir;
+	struct set_gitdir_args args = { NULL };
 
 	abspath = real_pathdup(gitdir, 0);
 	if (!abspath) {
@@ -101,7 +142,7 @@ static int repo_init_gitdir(struct repository *repo, const char *gitdir)
 		goto out;
 	}
 
-	repo_set_gitdir(repo, resolved_gitdir);
+	repo_set_gitdir(repo, resolved_gitdir, &args);
 
 out:
 	free(abspath);
diff --git a/repository.h b/repository.h
index fa73ab8e93..b5b5d138aa 100644
--- a/repository.h
+++ b/repository.h
@@ -89,7 +89,16 @@ struct repository {
 
 extern struct repository *the_repository;
 
-extern void repo_set_gitdir(struct repository *repo, const char *path);
+struct set_gitdir_args {
+	const char *shared_root;
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
2.16.1.435.g8f24da2e1a

