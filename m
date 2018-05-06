Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 054D9200B9
	for <e@80x24.org>; Sun,  6 May 2018 14:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751714AbeEFOL3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 10:11:29 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41891 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751684AbeEFOL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 10:11:27 -0400
Received: by mail-wr0-f194.google.com with SMTP id g21-v6so25356643wrb.8
        for <git@vger.kernel.org>; Sun, 06 May 2018 07:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nYy8k1PMyLGllS+0hpmBQe92jJ7Uqd75rbMXEK88yFs=;
        b=Ou5FiB5iQQZxy26oMr8SYlOMj7dO0AeMnhJR4cD6gf3r0vara4Y6pzfVSDmR55HaNc
         9ukdGQGpYGjjVT/dU/AeBAguwFCyjZiq7MSkIQZ6g43nLrLQ039Im5pp3Og9mhUcnt3O
         37JFg1q+o4EfFYOYrHtjhWLSdE2/zZeIILWgAv4JaXpNf4bynnAxVLYotMNsKeaGwX+B
         tE5HZBnxnQoZDjJer8MW8crGS2ALVCpKJ1A7HMF405pH0l/mFi45CnH1noMQJPVsT6s5
         8ZT9fDiKVvCujr/idmIRbsbLqggtZW08VvuwrS8i3n4bGRK0aViLxtKXYiOWc/iQG3Op
         7nTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nYy8k1PMyLGllS+0hpmBQe92jJ7Uqd75rbMXEK88yFs=;
        b=lqZu729jv8zPo5+RCPttXmZsuSvqmeop6uD9tJHd9/BabHwk5xvjB8t19bt2Gb2GSd
         Fs1zFfZSfqpf8weZ/GLDCnJDTZPM1+6jS+IQ4hRVfm9YOsth6a+9/yAyhPQwqvmKvOE0
         eQDoaXMLCAEWinfXF1n2CWtGNbjwcYMjzzQIziXL4tE6fAj+Owzn9AZsfQABQTkfoydc
         Lz5EqQ2LhXx++HBs+pAS8CdazMo4vNH+Y3XlDeHp3Ek5yN/rFugYchIs2QoUXCQMs7Qy
         /4xACQ7oX0vb2u5OhvVyV5d6iQQMIRJ+6vxPYeIwlyXLoEHwfFh3mLyUomaY4VPVJ59u
         Ak9A==
X-Gm-Message-State: ALQs6tD1LclFCB+RhMPKl0zl/uAC3NloQwjbRatjxKo9h3aNrE8P22LR
        oYPrL+Pd+vGoX5v3XbCYm+y/8ixn
X-Google-Smtp-Source: AB8JxZqZVxt31qBylczP5nOBN3aBEq6lPAJR0vX2DFK9cEPBqTFpA/+nlU+M02IEansTXOZZ322oog==
X-Received: by 2002:adf:9d8c:: with SMTP id p12-v6mr25608916wre.14.1525615885858;
        Sun, 06 May 2018 07:11:25 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id p17sm4914857wmc.17.2018.05.06.07.11.24
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 May 2018 07:11:24 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 5/5] lock_file: move static locks into functions
Date:   Sun,  6 May 2018 16:10:31 +0200
Message-Id: <20180506141031.30204-6-martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.411.g9fd64c8e46
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Each of these `struct lock_file`s is used from within a single function.
Move them into the respective functions to make the scope clearer. While
doing so, we can drop the staticness.

After this commit, the remaing occurences of "static struct lock_file"
are locks that are used from within different functions. That is, they
need to remain static. (Short of more intrusive changes like passing
around pointers to non-static locks.)

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 t/helper/test-scrap-cache-tree.c | 4 ++--
 builtin/add.c                    | 3 +--
 builtin/mv.c                     | 2 +-
 builtin/read-tree.c              | 3 +--
 builtin/rm.c                     | 3 +--
 rerere.c                         | 3 +--
 6 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/t/helper/test-scrap-cache-tree.c b/t/helper/test-scrap-cache-tree.c
index d26d3e7c8b..393f1604ff 100644
--- a/t/helper/test-scrap-cache-tree.c
+++ b/t/helper/test-scrap-cache-tree.c
@@ -4,10 +4,10 @@
 #include "tree.h"
 #include "cache-tree.h"
 
-static struct lock_file index_lock;
-
 int cmd__scrap_cache_tree(int ac, const char **av)
 {
+	struct lock_file index_lock = LOCK_INIT;
+
 	setup_git_directory();
 	hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
 	if (read_cache() < 0)
diff --git a/builtin/add.c b/builtin/add.c
index c9e2619a9a..8a155dd41e 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -265,8 +265,6 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static struct lock_file lock_file;
-
 static const char ignore_error[] =
 N_("The following paths are ignored by one of your .gitignore files:\n");
 
@@ -393,6 +391,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	int add_new_files;
 	int require_pathspec;
 	char *seen = NULL;
+	struct lock_file lock_file = LOCK_INIT;
 
 	git_config(add_config, NULL);
 
diff --git a/builtin/mv.c b/builtin/mv.c
index 6d141f7a53..b4692409e3 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -72,7 +72,6 @@ static const char *add_slash(const char *path)
 	return path;
 }
 
-static struct lock_file lock_file;
 #define SUBMODULE_WITH_GITDIR ((const char *)1)
 
 static void prepare_move_submodule(const char *src, int first,
@@ -131,6 +130,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX } *modes;
 	struct stat st;
 	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
+	struct lock_file lock_file = LOCK_INIT;
 
 	git_config(git_default_config, NULL);
 
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index bf87a2710b..ebc43eb805 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -107,8 +107,6 @@ static int git_read_tree_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
-static struct lock_file lock_file;
-
 int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 {
 	int i, stage = 0;
@@ -116,6 +114,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	struct tree_desc t[MAX_UNPACK_TREES];
 	struct unpack_trees_options opts;
 	int prefix_set = 0;
+	struct lock_file lock_file = LOCK_INIT;
 	const struct option read_tree_options[] = {
 		{ OPTION_CALLBACK, 0, "index-output", NULL, N_("file"),
 		  N_("write resulting index to <file>"),
diff --git a/builtin/rm.c b/builtin/rm.c
index 5b6fc7ee81..65b448ef8e 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -233,8 +233,6 @@ static int check_local_mod(struct object_id *head, int index_only)
 	return errs;
 }
 
-static struct lock_file lock_file;
-
 static int show_only = 0, force = 0, index_only = 0, recursive = 0, quiet = 0;
 static int ignore_unmatch = 0;
 
@@ -251,6 +249,7 @@ static struct option builtin_rm_options[] = {
 
 int cmd_rm(int argc, const char **argv, const char *prefix)
 {
+	struct lock_file lock_file = LOCK_INIT;
 	int i;
 	struct pathspec pathspec;
 	char *seen;
diff --git a/rerere.c b/rerere.c
index 18cae2d11c..e0862e2778 100644
--- a/rerere.c
+++ b/rerere.c
@@ -703,10 +703,9 @@ static int merge(const struct rerere_id *id, const char *path)
 	return ret;
 }
 
-static struct lock_file index_lock;
-
 static void update_paths(struct string_list *update)
 {
+	struct lock_file index_lock = LOCK_INIT;
 	int i;
 
 	hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
-- 
2.17.0.411.g9fd64c8e46

