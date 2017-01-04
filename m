Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE32120756
	for <e@80x24.org>; Wed,  4 Jan 2017 22:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968470AbdADWBr (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 17:01:47 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33545 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968473AbdADWBl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 17:01:41 -0500
Received: by mail-pg0-f50.google.com with SMTP id g1so192584105pgn.0
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 14:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c0cHqTTLhEmz8qW+Z8j2pbx20SDGjVnFAZaAQpDzucU=;
        b=u2D9sF0JjH+UBwoXNyxFm9L7KUwHNy5WmuKkJF9LxY6Exl4sPpsqUxPJvejjrgMFES
         hv4y5oKnHQiVU8mGs3XS0QOpUj9SPA2n+YJtPaVFjS+0cq5HaxUVhXOWlqE73LgM9OGO
         7RFi+OLxZ9waBlcuDnguPQtNxzv4SMwSckGoZEizkgOM0WjDKf/mCc3BfME+CNRqR4/I
         RgjVF/qfCB13XDPxgYNuZJzQsiNKK+EIbFP/OgY+59BAHQo5wvuHEOaPFxzsw3H9PFJq
         zV6Z+iVMGBZt6ZMnCl1pxXR3H1TrJzvjBu4NwTWUt+QDnqfxcKp1/yF9p1hAnkd97pwb
         xatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c0cHqTTLhEmz8qW+Z8j2pbx20SDGjVnFAZaAQpDzucU=;
        b=phx+xGNtI/3M3GJyNFt3CAw2GeG+BujKNfzoo5r2oMd1Ldu2wH2KbmeDyQ69ZTufon
         WjPiAXo9IDZfvFRxF7gjsKZ2ocadr5Ep/Nbkybb/Fr+deU6ZIP55vjVlf8A60q61X1u/
         5GkO5gp74Z0HXDkXvBJuaEPdGmZZxCmyCqiOnQPz2sOs7zmJWk0sMaYNNWeHUVAfNoAJ
         z7Vjg0fmvqVOY+TZ/R+8fQ7YyGmNpjX03s/VrG5R4dAC8fTtC2TAXqgDtW1yQfGrkbxS
         Kdv1wKr+nvy1qmOLpzjTmamVJ866z9CNDl2zuXSJjk6XNOaUP4bG7M8ZEz/icuToT2Xd
         sH/A==
X-Gm-Message-State: AIkVDXL+QY9n3C/QKxz8n5V/hL+eF0uSybUlGcRPz1cg4o3bhpDV8GF4/uaDBXiPHlxnYhUR
X-Received: by 10.84.139.129 with SMTP id 1mr151210240plr.178.1483567298542;
        Wed, 04 Jan 2017 14:01:38 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id n29sm550351pfg.80.2017.01.04.14.01.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jan 2017 14:01:37 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        peff@peff.net, jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, tboegi@web.de, j6t@kdbg.org,
        pclouds@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v5 4/5] real_path: have callers use real_pathdup and strbuf_realpath
Date:   Wed,  4 Jan 2017 14:01:23 -0800
Message-Id: <20170104220124.145808-5-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170104220124.145808-1-bmwill@google.com>
References: <20170103190923.11882-1-bmwill@google.com>
 <20170104220124.145808-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Migrate callers of real_path() who duplicate the return value to use
real_pathdup or strbuf_realpath.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/init-db.c |  6 +++---
 environment.c     |  2 +-
 setup.c           | 13 ++++++++-----
 sha1_file.c       |  2 +-
 submodule.c       |  2 +-
 transport.c       |  2 +-
 worktree.c        |  2 +-
 7 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 2399b97d9..76d68fad0 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -338,7 +338,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 {
 	int reinit;
 	int exist_ok = flags & INIT_DB_EXIST_OK;
-	char *original_git_dir = xstrdup(real_path(git_dir));
+	char *original_git_dir = real_pathdup(git_dir);
 
 	if (real_git_dir) {
 		struct stat st;
@@ -489,7 +489,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, init_db_options, init_db_usage, 0);
 
 	if (real_git_dir && !is_absolute_path(real_git_dir))
-		real_git_dir = xstrdup(real_path(real_git_dir));
+		real_git_dir = real_pathdup(real_git_dir);
 
 	if (argc == 1) {
 		int mkdir_tried = 0;
@@ -560,7 +560,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 		const char *git_dir_parent = strrchr(git_dir, '/');
 		if (git_dir_parent) {
 			char *rel = xstrndup(git_dir, git_dir_parent - git_dir);
-			git_work_tree_cfg = xstrdup(real_path(rel));
+			git_work_tree_cfg = real_pathdup(rel);
 			free(rel);
 		}
 		if (!git_work_tree_cfg)
diff --git a/environment.c b/environment.c
index 0935ec696..9b943d2d5 100644
--- a/environment.c
+++ b/environment.c
@@ -259,7 +259,7 @@ void set_git_work_tree(const char *new_work_tree)
 		return;
 	}
 	git_work_tree_initialized = 1;
-	work_tree = xstrdup(real_path(new_work_tree));
+	work_tree = real_pathdup(new_work_tree);
 }
 
 const char *get_git_work_tree(void)
diff --git a/setup.c b/setup.c
index fe572b82c..1b534a750 100644
--- a/setup.c
+++ b/setup.c
@@ -256,8 +256,10 @@ int get_common_dir_noenv(struct strbuf *sb, const char *gitdir)
 		strbuf_addbuf(&path, &data);
 		strbuf_addstr(sb, real_path(path.buf));
 		ret = 1;
-	} else
+	} else {
 		strbuf_addstr(sb, gitdir);
+	}
+
 	strbuf_release(&data);
 	strbuf_release(&path);
 	return ret;
@@ -692,7 +694,7 @@ static const char *setup_discovered_git_dir(const char *gitdir,
 	/* --work-tree is set without --git-dir; use discovered one */
 	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
 		if (offset != cwd->len && !is_absolute_path(gitdir))
-			gitdir = xstrdup(real_path(gitdir));
+			gitdir = real_pathdup(gitdir);
 		if (chdir(cwd->buf))
 			die_errno("Could not come back to cwd");
 		return setup_explicit_git_dir(gitdir, cwd, nongit_ok);
@@ -800,11 +802,12 @@ static int canonicalize_ceiling_entry(struct string_list_item *item,
 		/* Keep entry but do not canonicalize it */
 		return 1;
 	} else {
-		const char *real_path = real_path_if_valid(ceil);
-		if (!real_path)
+		char *real_path = real_pathdup(ceil);
+		if (!real_path) {
 			return 0;
+		}
 		free(item->string);
-		item->string = xstrdup(real_path);
+		item->string = real_path;
 		return 1;
 	}
 }
diff --git a/sha1_file.c b/sha1_file.c
index 9c86d1924..6a03cc393 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -291,7 +291,7 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base,
 	struct strbuf pathbuf = STRBUF_INIT;
 
 	if (!is_absolute_path(entry) && relative_base) {
-		strbuf_addstr(&pathbuf, real_path(relative_base));
+		strbuf_realpath(&pathbuf, relative_base, 1);
 		strbuf_addch(&pathbuf, '/');
 	}
 	strbuf_addstr(&pathbuf, entry);
diff --git a/submodule.c b/submodule.c
index ece17315d..55819ba9c 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1301,7 +1301,7 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
 {
 	struct strbuf file_name = STRBUF_INIT;
 	struct strbuf rel_path = STRBUF_INIT;
-	const char *real_work_tree = xstrdup(real_path(work_tree));
+	const char *real_work_tree = real_pathdup(work_tree);
 
 	/* Update gitfile */
 	strbuf_addf(&file_name, "%s/.git", work_tree);
diff --git a/transport.c b/transport.c
index 04e5d6623..a3b98f198 100644
--- a/transport.c
+++ b/transport.c
@@ -1146,7 +1146,7 @@ static int refs_from_alternate_cb(struct alternate_object_database *e,
 	const struct ref *extra;
 	struct alternate_refs_data *cb = data;
 
-	other = xstrdup(real_path(e->path));
+	other = real_pathdup(e->path);
 	len = strlen(other);
 
 	while (other[len-1] == '/')
diff --git a/worktree.c b/worktree.c
index eb6121263..edf14daf9 100644
--- a/worktree.c
+++ b/worktree.c
@@ -255,7 +255,7 @@ struct worktree *find_worktree(struct worktree **list,
 		return wt;
 
 	arg = prefix_filename(prefix, strlen(prefix), arg);
-	path = xstrdup(real_path(arg));
+	path = real_pathdup(arg);
 	for (; *list; list++)
 		if (!fspathcmp(path, real_path((*list)->path)))
 			break;
-- 
2.11.0.390.gc69c2f50cf-goog

