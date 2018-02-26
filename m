Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SORTED_RECIPS,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF3FD1F576
	for <e@80x24.org>; Mon, 26 Feb 2018 10:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbeBZKav (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 05:30:51 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36457 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751745AbeBZKau (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 05:30:50 -0500
Received: by mail-pl0-f67.google.com with SMTP id v3so9020537plg.3
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 02:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=75FBXAx6nVBvgBvaKfz628c+oiZrsPhtFPsZYdBkhas=;
        b=j4140yw7wuCx+sxGIshP9U9yVk2y1rsZnfbR9BzjW3C/P4r2+iXqQcOM2N5goP2LPl
         7XHu42vomPzJLcaH8o4pFE27F6DHpunEm2hd85ztms7BlN6w3NP+9LFNVPpP7i9WyZxj
         8I9HABa+IcgIaQlMqEmtHoUbmU7RPppA9PYdc4VkzjJB2gDpzIyydQcNAecipJZSqY9X
         4+eg9k1NELM4momP28GtN4lGcfqXQCn0hNwXjOGNSBNoWLiuG22zG4z1iU9E7Gc8Md3O
         7SzYiM/2+6m2uYllJHaHEkE4iEHcHRxe1EMBbg5MA20SGbeupMBatJOr2NtKsPJxj04l
         YxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=75FBXAx6nVBvgBvaKfz628c+oiZrsPhtFPsZYdBkhas=;
        b=U6nUOq+SaYVHcOmwvslo3Eb4gsBU6CDpeRaEKEB02up/SXH+wtwz75rwZpMtgr39sy
         iomLBIJRMpvnzeIsW8DOUlVAsmIW453X0ZsTz/X8Vkr0B5mKpRfzEVOMjuJkf5PyUuA/
         ryGuOWn+K7k5jGo8jsQo+0P9Y8bBVAE+tbtrb24joIsXM75jPnH3HLPPikdzSJLPnkmL
         4ZiPCpKIjnTDIDg3opM+SSQSp6Hen3OYDio/+zfOK8pox1YvUUdD/pZxQz41ZZyAE2VD
         bSs5c1eawiJ5mffnbhHIoAh0LtYMdo+0CqXn1UZn4PpAjYaeFBA5gUlNOyA+exRkd/M9
         7txg==
X-Gm-Message-State: APf1xPDZARULpcaldfsQ2KwfQof0OQw0bb0oH/200zXoFIUvsFeCXmG2
        UQNaK/0M218lCU6CQ51RLAM=
X-Google-Smtp-Source: AH8x224+8xjk0jGJOTda4gY7rW5kRhAf4WC+EszKcC+mS41dZpxOImOmIJz8Jd0jOQqm9+e7Ck+Jhw==
X-Received: by 2002:a17:902:e83:: with SMTP id 3-v6mr10125465plx.158.1519641050123;
        Mon, 26 Feb 2018 02:30:50 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id z15sm13470833pgr.68.2018.02.26.02.30.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Feb 2018 02:30:49 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 26 Feb 2018 17:30:44 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sbeller@google.com, sunshine@sunshineco.com
Subject: [PATCH 1/4] repository.c: move env-related setup code back to environment.c
Date:   Mon, 26 Feb 2018 17:30:27 +0700
Message-Id: <20180226103030.26900-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180226103030.26900-1-pclouds@gmail.com>
References: <20180214180814.GA139458@google.com>
 <20180226103030.26900-1-pclouds@gmail.com>
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
 environment.c | 12 +++++++++---
 repository.c  | 48 ++++++++++++++++++++++++++++++++++++++++++------
 repository.h  | 11 ++++++++++-
 setup.c       |  3 +--
 5 files changed, 63 insertions(+), 13 deletions(-)

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
index ec10b062e6..2905042b16 100644
--- a/environment.c
+++ b/environment.c
@@ -148,10 +148,17 @@ static char *expand_namespace(const char *raw_namespace)
 	return strbuf_detach(&buf, NULL);
 }
 
-void setup_git_env(void)
+void setup_git_env(const char *git_dir)
 {
 	const char *shallow_file;
 	const char *replace_ref_base;
+	struct set_gitdir_args args = { NULL };
+
+	args.shared_root = getenv(GIT_COMMON_DIR_ENVIRONMENT);
+	args.object_dir = getenv(DB_ENVIRONMENT);
+	args.graft_file = getenv(GRAFT_ENVIRONMENT);
+	args.index_file = getenv(INDEX_ENVIRONMENT);
+	repo_set_gitdir(the_repository, git_dir, &args);
 
 	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
 		check_replace_refs = 0;
@@ -301,8 +308,7 @@ int set_git_dir(const char *path)
 {
 	if (setenv(GIT_DIR_ENVIRONMENT, path, 1))
 		return error("Could not set GIT_DIR to '%s'", path);
-	repo_set_gitdir(the_repository, path);
-	setup_git_env();
+	setup_git_env(path);
 	return 0;
 }
 
diff --git a/repository.c b/repository.c
index a069b1b640..70dc8dc661 100644
--- a/repository.c
+++ b/repository.c
@@ -61,15 +61,50 @@ static void repo_setup_env(struct repository *repo)
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
@@ -87,6 +122,7 @@ static int repo_init_gitdir(struct repository *repo, const char *gitdir)
 	int error = 0;
 	char *abspath = NULL;
 	const char *resolved_gitdir;
+	struct set_gitdir_args args = { NULL };
 
 	abspath = real_pathdup(gitdir, 0);
 	if (!abspath) {
@@ -101,7 +137,7 @@ static int repo_init_gitdir(struct repository *repo, const char *gitdir)
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

