Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96C0F1FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 23:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932796AbcLHX6l (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 18:58:41 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35743 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932547AbcLHX6i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 18:58:38 -0500
Received: by mail-pg0-f54.google.com with SMTP id p66so835446pga.2
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 15:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yFanEsC+P7JRbDaP/1s7ULQAN7yr6u+nmhh3QiMAn6g=;
        b=DriLUiauxfvNHrJ7UZMBMQ4qIkC2JI11Ah4u4dRhEvzERXG2ung6/8WrqcSvbwDT8S
         NyoDRgeUuDxJbdK0yN3BG01al/HP0JH+9jzLCTJke+qQwhzfWESuV6S2OhM73z6rzB15
         v1tW8TvYztI42rkQdksip52Nt9OtXFCqGcQvub4eM7jaqOXVtIkZqE7TYJhWflswN/EF
         r8gM998VKhEzLm6IRbfGv53hnUVCQvU5vIz+jidoYkCnVokGRyxzMDZ+jYuCStYi4Wo1
         2u76gQPxzCOgUzb5YgLauj46IklDXn4q3hKFUHwXFZSXPiw83pv0SrC4BvdG5a1MISdu
         2LFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yFanEsC+P7JRbDaP/1s7ULQAN7yr6u+nmhh3QiMAn6g=;
        b=jQyWIfMZTa7eFwTacdgnC7Do4ihXGlDtcLqiZgCLRO2EeiUjbXqrUe1m2rLC+xdwLP
         hV4vOzeRQO2Ed/lZd8m4E2hJzN/bhXMzdBllEqnS+NQUXqeGfpheMYQy/BPqIlTOtWoS
         MDAx9DeH5m6f+9FXIFDDohoGCvFK9rgEN3T05P+94tYJXx8XT5En6RDCCkmnQCptbOc4
         FpYn5ST+v4gbdpVNywiMMpyUr2aiGF5887vEmGhww4lpdIIe4JOO8PBlNeEbe2Ahdnjb
         CTGqWJ1C3A5MW4+fST3NLdSCoX6ZMibWfcgyqdpONV6dhES0nybGreJaqyBVIGTpd1dT
         RsUg==
X-Gm-Message-State: AKaTC03nFA1fZh4IWWK/V+eQujh6i38JuTNq44BosA9e+fzoL81EUFNMwHIsCPTxqKfDvZTf
X-Received: by 10.99.60.11 with SMTP id j11mr137630873pga.26.1481241517172;
        Thu, 08 Dec 2016 15:58:37 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id a7sm52505499pfl.87.2016.12.08.15.58.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 15:58:36 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        peff@peff.net, jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, tboegi@web.de, j6t@kdbg.org,
        pclouds@gmail.com
Subject: [PATCH v2 4/4] real_path: have callers use real_pathdup and strbuf_realpath
Date:   Thu,  8 Dec 2016 15:58:14 -0800
Message-Id: <1481241494-6861-5-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481241494-6861-1-git-send-email-bmwill@google.com>
References: <1480964316-99305-1-git-send-email-bmwill@google.com>
 <1481241494-6861-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Migrate callers of real_path() who duplicate the retern value to use
real_pathdup or strbuf_realpath.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/init-db.c |  6 +++---
 environment.c     |  2 +-
 setup.c           | 15 +++++++++------
 sha1_file.c       |  2 +-
 submodule.c       |  2 +-
 transport.c       |  2 +-
 worktree.c        |  2 +-
 7 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 2399b97..76d68fa 100644
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
index 0935ec6..9b943d2 100644
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
index fe572b8..0d9fdd0 100644
--- a/setup.c
+++ b/setup.c
@@ -254,10 +254,12 @@ int get_common_dir_noenv(struct strbuf *sb, const char *gitdir)
 		if (!is_absolute_path(data.buf))
 			strbuf_addf(&path, "%s/", gitdir);
 		strbuf_addbuf(&path, &data);
-		strbuf_addstr(sb, real_path(path.buf));
+		strbuf_realpath(sb, path.buf, 1);
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
index 9c86d19..6a03cc3 100644
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
index 6f7d883..c85ba50 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1227,7 +1227,7 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
 {
 	struct strbuf file_name = STRBUF_INIT;
 	struct strbuf rel_path = STRBUF_INIT;
-	const char *real_work_tree = xstrdup(real_path(work_tree));
+	const char *real_work_tree = real_pathdup(work_tree);
 
 	/* Update gitfile */
 	strbuf_addf(&file_name, "%s/.git", work_tree);
diff --git a/transport.c b/transport.c
index d57e8de..236c6f6 100644
--- a/transport.c
+++ b/transport.c
@@ -1130,7 +1130,7 @@ static int refs_from_alternate_cb(struct alternate_object_database *e,
 	const struct ref *extra;
 	struct alternate_refs_data *cb = data;
 
-	other = xstrdup(real_path(e->path));
+	other = real_pathdup(e->path);
 	len = strlen(other);
 
 	while (other[len-1] == '/')
diff --git a/worktree.c b/worktree.c
index f7869f8..c90e013 100644
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
2.8.0.rc3.226.g39d4020

