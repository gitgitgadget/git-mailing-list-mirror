Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EC401F406
	for <e@80x24.org>; Wed, 16 May 2018 22:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbeEPWVm (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:21:42 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44529 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751520AbeEPWVk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:21:40 -0400
Received: by mail-pf0-f196.google.com with SMTP id q22-v6so1038719pff.11
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lv5O6dXdH28Iwa80gf1XnXZVFgfVaGPpoUoxNbap6TY=;
        b=W88vsfTpAkVTvsWPKN1leN4ODp6wI69xyPqZXaOCBc354OoSjcOgSjZj5Sc1rDrhWE
         bmvA6Y7JA9BMZl73ZsIANeVmQSUwyqF3KKn9u+f2fWUDhuO3A7TTfY506EutZOIX9xYk
         tWg8lH3j5cxcOJSrz0sTgxuth2d7Og9YnM3FAv6EoasfH2JhblJb+kfyDWf4Mk2I4cc8
         dYVmo/yyUQ33HXsQBam6ItLy6DWBEu3wDxiO5GKmD6rQDX4grGuHIpw7jcCqjETxM5Pb
         yhKRD+7I7rQZORa0oeYhpXLlQ3kakAQRyFiM2gnv9EgMvf2UHKQLfgp6DcvL5NgWPz8P
         93cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lv5O6dXdH28Iwa80gf1XnXZVFgfVaGPpoUoxNbap6TY=;
        b=adaMePZMeKlKtkeEiCo0hEmdpmGVbezPgO7om/ZCYdBTVHVY4/Op38N65ZeR0M7m44
         wFWQAYjwcrfF/3W1bl6BTF7YmqFa4os/p8vNZ1Ic3rgUSbOVX83qpiN8NR+xyris2I+V
         8nb2B+MA0JYuuITEwSbjZvPuYD4KsvBJIg+yFwHcdKpl3VN5SZ33hMfq12I7xvcUWhg4
         fxUA6HzU50yUVwUQmhzAKxV7X7kSiE18SGjwMrX2Qu46JmT2Feqj+RNlpA7kM+M88ffm
         TDen/RC4drei1PLiNSV+0JWfbPk4ibQGognjOBruey5AMw6cyJyuA84u5fo1y0hY5T78
         7jRQ==
X-Gm-Message-State: ALKqPwelU6mCneOzl0j49yZMbFDke+gqVBm3AcN0DY4giSZAa3mCUPUp
        I6CLC7pj+vOCeQG1QmnzS9B3UQ==
X-Google-Smtp-Source: AB8JxZq28JoEp5B7T6yqemmm6DhLJhNsdtC2qRPJCl3Gu4dMspuB5s5xVxUB7DwQ6h6HLf4JRh6E2w==
X-Received: by 2002:a65:6354:: with SMTP id p20-v6mr2129463pgv.437.1526509299938;
        Wed, 16 May 2018 15:21:39 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id k186-v6sm6662289pfc.142.2018.05.16.15.21.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 May 2018 15:21:39 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     pclouds@gmail.com
Cc:     ao2@ao2.it, bmwill@google.com, git@vger.kernel.org,
        gitster@pobox.com, sbeller@google.com
Subject: [PATCH 06/11] read_cache: use repo_read_index_or_die with different error messages
Date:   Wed, 16 May 2018 15:21:13 -0700
Message-Id: <20180516222118.233868-7-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180516222118.233868-1-sbeller@google.com>
References: <CACsJy8A8WZ-Gqe2Y-whJmbADrt+gZjLZ7MTwCtdnK7JDnEdtog@mail.gmail.com>
 <20180516222118.233868-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This replaces all patterns of "if (read_cached() < 0) die(some-msg);"
with repo_read_index_or_die; this changes the output of the error message.

However as all error messages before were translated, these are for human
consumption, so a change in error message is not bad; in fact it makes Git
more consistent.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/add.c       | 4 ++--
 builtin/commit.c    | 9 +++++----
 builtin/rev-parse.c | 4 ++--
 merge.c             | 4 ++--
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index e4751c198c1..910f619b7d5 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -19,6 +19,7 @@
 #include "bulk-checkin.h"
 #include "argv-array.h"
 #include "submodule.h"
+#include "repository.h"
 
 static const char * const builtin_add_usage[] = {
 	N_("git add [<options>] [--] <pathspec>..."),
@@ -229,8 +230,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 
-	if (read_cache() < 0)
-		die(_("Could not read the index"));
+	repo_read_index_or_die(the_repository);
 
 	init_revisions(&rev, prefix);
 	rev.diffopt.context = 7;
diff --git a/builtin/commit.c b/builtin/commit.c
index 5571d4a3e2b..9ebfb4db415 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -32,6 +32,8 @@
 #include "column.h"
 #include "sequencer.h"
 #include "mailmap.h"
+#include "sigchain.h"
+#include "repository.h"
 
 static const char * const builtin_commit_usage[] = {
 	N_("git commit [<options>] [--] <pathspec>..."),
@@ -428,8 +430,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		exit(1);
 
 	discard_cache();
-	if (read_cache() < 0)
-		die(_("cannot read the index"));
+	repo_read_index_or_die(the_repository);
 
 	hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
 	add_remove_files(&partial);
@@ -853,8 +854,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		struct object_id oid;
 		const char *parent = "HEAD";
 
-		if (!active_nr && read_cache() < 0)
-			die(_("Cannot read index"));
+		if (!active_nr)
+			repo_read_index_or_die(the_repository);
 
 		if (amend)
 			parent = "HEAD^1";
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 36b20877828..37f29fd850d 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -14,6 +14,7 @@
 #include "revision.h"
 #include "split-index.h"
 #include "submodule.h"
+#include "repository.h"
 
 #define DO_REVS		1
 #define DO_NOREV	2
@@ -884,8 +885,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--shared-index-path")) {
-				if (read_cache() < 0)
-					die(_("Could not read the index"));
+				repo_read_index_or_die(the_repository);
 				if (the_index.split_index) {
 					const unsigned char *sha1 = the_index.split_index->base_sha1;
 					const char *path = git_path("sharedindex.%s", sha1_to_hex(sha1));
diff --git a/merge.c b/merge.c
index f06a4773d4f..654d049e80d 100644
--- a/merge.c
+++ b/merge.c
@@ -8,6 +8,7 @@
 #include "tree-walk.h"
 #include "unpack-trees.h"
 #include "dir.h"
+#include "repository.h"
 
 static const char *merge_argument(struct commit *commit)
 {
@@ -70,8 +71,7 @@ int try_merge_command(const char *strategy, size_t xopts_nr,
 	argv_array_clear(&args);
 
 	discard_cache();
-	if (read_cache() < 0)
-		die(_("failed to read the cache"));
+	repo_read_index_or_die(the_repository);
 	resolve_undo_clear();
 
 	return ret;
-- 
2.17.0.582.gccdcbd54c44.dirty

