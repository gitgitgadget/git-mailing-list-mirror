Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 202871F424
	for <e@80x24.org>; Wed,  9 May 2018 20:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965423AbeEIU4t (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 16:56:49 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44744 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935200AbeEIU4r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 16:56:47 -0400
Received: by mail-wr0-f195.google.com with SMTP id y15-v6so25110296wrg.11
        for <git@vger.kernel.org>; Wed, 09 May 2018 13:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TUmygluvmDzK8tc4Vce25x3qvCl9yKEz+enFEasK9KM=;
        b=h/Yv6TrMRjAEadmoo39qIULO1iLpbZCbmUUPSb2S0fZmeQxhjtF8+CXGCza4FYgd16
         uAmire41L6ApxpDKqF02+8ZvEmItF2zIW6qdUdGHDkaIqRzIfgqG//RnxN1dQ+tFM4lT
         4YpJ+v8OUx4FSQ5Ub7GAT0XTOrI+ozhPTFyA4COllR3r0OoSkWjTPe/VXOk+PDYF9RVK
         wMPS29f2PyQmTsZ5jroWVq2AObQSC8EKyHK68/n3krKdIahN5xxkOuZX9T0Hntv6xiMK
         CJtJFUPTOeowZkrYcFeBQFKfo1bkinzusmxKTK+YZO7bXzt7J0UldWdxSNOyRInnAb6k
         X2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TUmygluvmDzK8tc4Vce25x3qvCl9yKEz+enFEasK9KM=;
        b=rwo1XcHBNk5yZzT8vtPiekDCYdRXZ/Yk53ttqWtVTvFSd9B/Q+I65QcoEvg1aKNMWq
         f5bSC6a/Ibt7L2YLl18LXxdMN2eBExthKbAlTYXB5lQnF0gshfhJrqOp9fhQcEeM31np
         6x0o+LyocURJrRk9CUi0tgpgif03s7PDOOoILcdhyrn6WhFmXrILi39kIsXNUjYhNepT
         E5uQ6JFE2lojE3alCkArhA8VZb0JODsv01DBd1iRcQx5OjMoJeuaHAEn0Uqu63W2kqw3
         2vXTPJtwiM9aVVhCM2JiVnskr0hp9loFYAinoyTVV7dPFPcxVJFFgTkCaqvVbs3R5skj
         Us2A==
X-Gm-Message-State: ALQs6tC2fe6eAIZBPQrWHwNFaArJ5gsHrfYC1pbiU8+GcF5S0zyACaoF
        Wze++iVkbe8cBHaoX5dgKBVv6NFvVqk=
X-Google-Smtp-Source: AB8JxZpU/gQkZp4Ygh6CADeXnW+1+DEHZQxmvhOqNwlEJoaENwNS8AFHxyc9OD3rJL6UlUhgW6oLHw==
X-Received: by 2002:adf:8f72:: with SMTP id p105-v6mr39151394wrb.181.1525899405612;
        Wed, 09 May 2018 13:56:45 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id r14-v6sm40073008wra.41.2018.05.09.13.56.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 May 2018 13:56:44 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        David Turner <novalis@novalis.org>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 5/5] lock_file: move static locks into functions
Date:   Wed,  9 May 2018 22:55:39 +0200
Message-Id: <98d10821c6307394d2ed2e21e30db814bac1054e.1525898125.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.411.g9fd64c8e46
In-Reply-To: <cover.1525898125.git.martin.agren@gmail.com>
References: <20180508182548.GD7210@sigill.intra.peff.net> <cover.1525898125.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Placing `struct lock_file`s on the stack used to be a bad idea, because
the temp- and lockfile-machinery would keep a pointer into the struct.
But after 076aa2cbd (tempfile: auto-allocate tempfiles on heap,
2017-09-05), we can safely have lockfiles on the stack. (This applies
even if a user returns early, leaving a locked lock behind.)

Each of these `struct lock_file`s is used from within a single function.
Move them into the respective functions to make the scope clearer and
drop the staticness.

For good measure, I have inspected these sites and come to believe that
they always release the lock, with the possible exception of bailing out
using `die()` or `exit()` or by returning from a `cmd_foo()`.

As pointed out by Jeff King, it would be bad if someone held on to a
`struct lock_file *` for some reason. After some grepping, I agree with
his findings: no-one appears to be doing that.

After this commit, the remaining occurrences of "static struct
lock_file" are locks that are used from within different functions. That
is, they need to remain static. (Short of more intrusive changes like
passing around pointers to non-static locks.)

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

