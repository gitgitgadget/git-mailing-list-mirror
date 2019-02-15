Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE6AB1F453
	for <e@80x24.org>; Fri, 15 Feb 2019 17:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbfBOR7c (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 12:59:32 -0500
Received: from mail-qt1-f182.google.com ([209.85.160.182]:44933 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729256AbfBOR7c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 12:59:32 -0500
Received: by mail-qt1-f182.google.com with SMTP id n32so11813394qte.11
        for <git@vger.kernel.org>; Fri, 15 Feb 2019 09:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IwCWcRnqdEJ9e1uCZZLtG8O84OWqYhfR9gygYAxiI44=;
        b=D6IQDDa9aLIMN0PY8moRA8Bwogh6wks3dDPioFFKM9SQIdOxxvsNR/y3Ea37UTOqh3
         aS67bzO10Gba2If04YH/iPdinMJRAWF+udm/atV5XQFKQtf8hmQ05Ngm+Ez/MD8pvyTe
         Ubmbuzl/JoPZ0Rrur76dkVbufCcPkWut0YOtKGVIx97kjM+45DfZb7E430FvG5CjHDwT
         GoyswssuCGLB8jBRv3f7p+6v632+lJDAOJNG+IB2hXwSnE3ZdLpIj9AZU5CjAm6d2Cy3
         I47olK4jel0O2c0TRvEWQppnwWZH4KquvY9G8rsXrvTETIQ1wiyp4mD1G33CTe7KS44X
         9A2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IwCWcRnqdEJ9e1uCZZLtG8O84OWqYhfR9gygYAxiI44=;
        b=K1s6m5/yTDFo1YZZKESnNqeVKI4rFjet6ytxGkmj7zXCWau7q8cFpHD/jnKA0ftOmW
         yvmAUoFu+cT20Nia+wz1x6gQ3R3pV2zdsHJcNgULXG0U9zUWUV8+3SqNEdBkWdiI/Tr1
         IsjTXjPaggV/iMqaxV/6imlvOHuXwuoG4AcF7hm7PJ+R/lYrRUWQXajsRP1dzQvBISjE
         oZDyuvZAYI/T3sfN0Np/sKR/wr4wqZdNgMicVi6WsRfADhmNK5T5v58gIF7gXQ4gFzDr
         ZShmNxRXFKUvPT0kyXgaGSO+nsynHRxspkCSrgBfYhvd2ebAnF5HaB3DO75D0LIjY7Bx
         exEQ==
X-Gm-Message-State: AHQUAubSr74mUni6XWsm0oU6qDb+gh3ymU2XUvijFQAMA85qid36EJB4
        vDVj9xfd7O7W9Yph7MzYLwI=
X-Google-Smtp-Source: AHgI3IYDy8q7Qf2LnImGdHILBG9uDHd0Luf0lzoGkte25yoSkvr6c0VJZ8WqZHOon+CSSz+K4HVcGw==
X-Received: by 2002:aed:3bb3:: with SMTP id r48mr8787075qte.278.1550253570408;
        Fri, 15 Feb 2019 09:59:30 -0800 (PST)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id p186sm3087612qkb.69.2019.02.15.09.59.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 09:59:29 -0800 (PST)
From:   Ben Peart <peartben@gmail.com>
To:     peartben@gmail.com
Cc:     benpeart@microsoft.com, git@vger.kernel.org, kewillf@microsoft.com,
        ramsay@ramsayjones.plus.com, gitster@pobox.com
Subject: [PATCH v3] read-cache: add post-index-change hook
Date:   Fri, 15 Feb 2019 12:59:21 -0500
Message-Id: <20190215175921.13400-1-peartben@gmail.com>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20190208195115.12156-1-peartben@gmail.com>
References: <20190208195115.12156-1-peartben@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

Add a post-index-change hook that is invoked after the index is written in
do_write_locked_index().

This hook is meant primarily for notification, and cannot affect
the outcome of git commands that trigger the index write.

The hook is passed a flag to indicate whether the working directory was
updated or not and a flag indicating if a skip-worktree bit could have
changed.  These flags enable the hook to optimize its response to the
index change notification.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---

Notes:
    Base Ref: v2.21.0-rc0
    Web-Diff: https://github.com/benpeart/git/commit/27001af8db
    Checkout: git fetch https://github.com/benpeart/git post-index-changed-v3 && git checkout 27001af8db
    
    ### Interdiff (v2..v3):
    
    diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
    index 94b4dadf30..bfb0be3659 100644
    --- a/Documentation/githooks.txt
    +++ b/Documentation/githooks.txt
    @@ -492,7 +492,7 @@ This hook is invoked by `git-p4 submit`. It takes no parameters and nothing
     from standard input. Exiting with non-zero status from this script prevent
     `git-p4 submit` from launching. Run `git-p4 submit --help` for details.
    
    -post-index-changed
    +post-index-change
     ~~~~~~~~~~~~~~~~~
    
     This hook is invoked when the index is written in read-cache.c
    diff --git a/read-cache.c b/read-cache.c
    index b6ead7bf8f..862bdf383d 100644
    --- a/read-cache.c
    +++ b/read-cache.c
    @@ -3004,7 +3004,7 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
     	else
     		ret = close_lock_file_gently(lock);
    
    -	run_hook_le(NULL, "post-index-changed",
    +	run_hook_le(NULL, "post-index-change",
     			istate->updated_workdir ? "1" : "0",
     			istate->updated_skipworktree ? "1" : "0", NULL);
     	istate->updated_workdir = 0;
    diff --git a/t/t7113-post-index-changed-hook.sh b/t/t7113-post-index-change-hook.sh
    similarity index 95%
    rename from t/t7113-post-index-changed-hook.sh
    rename to t/t7113-post-index-change-hook.sh
    index 6231b88fca..f011ad7eec 100755
    --- a/t/t7113-post-index-changed-hook.sh
    +++ b/t/t7113-post-index-change-hook.sh
    @@ -1,6 +1,6 @@
     #!/bin/sh
    
    -test_description='post index changed hook'
    +test_description='post index change hook'
    
     . ./test-lib.sh
    
    @@ -14,7 +14,7 @@ test_expect_success 'setup' '
    
     test_expect_success 'test status, add, commit, others trigger hook without flags set' '
     	mkdir -p .git/hooks &&
    -	write_script .git/hooks/post-index-changed <<-\EOF &&
    +	write_script .git/hooks/post-index-change <<-\EOF &&
     		if test "$1" -eq 1; then
     			echo "Invalid combination of flags passed to hook; updated_workdir is set." >testfailure
     			exit 1
    @@ -59,7 +59,7 @@ test_expect_success 'test status, add, commit, others trigger hook without flags
     '
    
     test_expect_success 'test checkout and reset trigger the hook' '
    -	write_script .git/hooks/post-index-changed <<-\EOF &&
    +	write_script .git/hooks/post-index-change <<-\EOF &&
     		if test "$1" -eq 1 && test "$2" -eq 1; then
     			echo "Invalid combination of flags passed to hook; updated_workdir and updated_skipworktree are both set." >testfailure
     			exit 1
    @@ -102,7 +102,7 @@ test_expect_success 'test checkout and reset trigger the hook' '
     '
    
     test_expect_success 'test reset --mixed and update-index triggers the hook' '
    -	write_script .git/hooks/post-index-changed <<-\EOF &&
    +	write_script .git/hooks/post-index-change <<-\EOF &&
     		if test "$1" -eq 1 && test "$2" -eq 1; then
     			echo "Invalid combination of flags passed to hook; updated_workdir and updated_skipworktree are both set." >testfailure
     			exit 1
    
    ### Patches

 Documentation/githooks.txt        |  18 ++++
 builtin/reset.c                   |   1 +
 builtin/update-index.c            |   2 +
 cache.h                           |   4 +-
 read-cache.c                      |  14 ++-
 t/t7113-post-index-change-hook.sh | 144 ++++++++++++++++++++++++++++++
 unpack-trees.c                    |   2 +
 7 files changed, 182 insertions(+), 3 deletions(-)
 create mode 100755 t/t7113-post-index-change-hook.sh

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 959044347e..bfb0be3659 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -492,6 +492,24 @@ This hook is invoked by `git-p4 submit`. It takes no parameters and nothing
 from standard input. Exiting with non-zero status from this script prevent
 `git-p4 submit` from launching. Run `git-p4 submit --help` for details.
 
+post-index-change
+~~~~~~~~~~~~~~~~~
+
+This hook is invoked when the index is written in read-cache.c
+do_write_locked_index.
+
+The first parameter passed to the hook is the indicator for the
+working directory being updated.  "1" meaning working directory
+was updated or "0" when the working directory was not updated.
+
+The second parameter passed to the hook is the indicator for whether
+or not the index was updated and the skip-worktree bit could have
+changed.  "1" meaning skip-worktree bits could have been updated
+and "0" meaning they were not.
+
+Only one parameter should be set to "1" when the hook runs.  The hook
+running passing "1", "1" should not be possible.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/reset.c b/builtin/reset.c
index 4d18a461fa..e173afcaac 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -380,6 +380,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			int flags = quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN;
 			if (read_from_tree(&pathspec, &oid, intent_to_add))
 				return 1;
+			the_index.updated_skipworktree = 1;
 			if (!quiet && get_git_work_tree()) {
 				uint64_t t_begin, t_delta_in_ms;
 
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 02ace602b9..cf731640fa 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1071,6 +1071,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	if (entries < 0)
 		die("cache corrupted");
 
+	the_index.updated_skipworktree = 1;
+
 	/*
 	 * Custom copy of parse_options() because we want to handle
 	 * filename arguments as they come.
diff --git a/cache.h b/cache.h
index 27fe635f62..46eb862d3e 100644
--- a/cache.h
+++ b/cache.h
@@ -338,7 +338,9 @@ struct index_state {
 	struct cache_time timestamp;
 	unsigned name_hash_initialized : 1,
 		 initialized : 1,
-		 drop_cache_tree : 1;
+		 drop_cache_tree : 1,
+		 updated_workdir : 1,
+		 updated_skipworktree : 1;
 	struct hashmap name_hash;
 	struct hashmap dir_hash;
 	struct object_id oid;
diff --git a/read-cache.c b/read-cache.c
index 0e0c93edc9..862bdf383d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -17,6 +17,7 @@
 #include "commit.h"
 #include "blob.h"
 #include "resolve-undo.h"
+#include "run-command.h"
 #include "strbuf.h"
 #include "varint.h"
 #include "split-index.h"
@@ -2999,8 +3000,17 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 	if (ret)
 		return ret;
 	if (flags & COMMIT_LOCK)
-		return commit_locked_index(lock);
-	return close_lock_file_gently(lock);
+		ret = commit_locked_index(lock);
+	else
+		ret = close_lock_file_gently(lock);
+
+	run_hook_le(NULL, "post-index-change",
+			istate->updated_workdir ? "1" : "0",
+			istate->updated_skipworktree ? "1" : "0", NULL);
+	istate->updated_workdir = 0;
+	istate->updated_skipworktree = 0;
+
+	return ret;
 }
 
 static int write_split_index(struct index_state *istate,
diff --git a/t/t7113-post-index-change-hook.sh b/t/t7113-post-index-change-hook.sh
new file mode 100755
index 0000000000..f011ad7eec
--- /dev/null
+++ b/t/t7113-post-index-change-hook.sh
@@ -0,0 +1,144 @@
+#!/bin/sh
+
+test_description='post index change hook'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir -p dir1 &&
+	touch dir1/file1.txt &&
+	echo testing >dir1/file2.txt &&
+	git add . &&
+	git commit -m "initial"
+'
+
+test_expect_success 'test status, add, commit, others trigger hook without flags set' '
+	mkdir -p .git/hooks &&
+	write_script .git/hooks/post-index-change <<-\EOF &&
+		if test "$1" -eq 1; then
+			echo "Invalid combination of flags passed to hook; updated_workdir is set." >testfailure
+			exit 1
+		fi
+		if test "$2" -eq 1; then
+			echo "Invalid combination of flags passed to hook; updated_skipworktree is set." >testfailure
+			exit 1
+		fi
+		if test -f ".git/index.lock"; then
+			echo ".git/index.lock exists" >testfailure
+			exit 3
+		fi
+		if ! test -f ".git/index"; then
+			echo ".git/index does not exist" >testfailure
+			exit 3
+		fi
+		echo "success" >testsuccess
+	EOF
+	mkdir -p dir2 &&
+	touch dir2/file1.txt &&
+	touch dir2/file2.txt &&
+	: force index to be dirty &&
+	test-tool chmtime +60 dir1/file1.txt &&
+	git status &&
+	test_path_is_file testsuccess && rm -f testsuccess &&
+	test_path_is_missing testfailure &&
+	git add . &&
+	test_path_is_file testsuccess && rm -f testsuccess &&
+	test_path_is_missing testfailure &&
+	git commit -m "second" &&
+	test_path_is_file testsuccess && rm -f testsuccess &&
+	test_path_is_missing testfailure &&
+	git checkout -- dir1/file1.txt &&
+	test_path_is_file testsuccess && rm -f testsuccess &&
+	test_path_is_missing testfailure &&
+	git update-index &&
+	test_path_is_missing testsuccess &&
+	test_path_is_missing testfailure &&
+	git reset --soft &&
+	test_path_is_missing testsuccess &&
+	test_path_is_missing testfailure
+'
+
+test_expect_success 'test checkout and reset trigger the hook' '
+	write_script .git/hooks/post-index-change <<-\EOF &&
+		if test "$1" -eq 1 && test "$2" -eq 1; then
+			echo "Invalid combination of flags passed to hook; updated_workdir and updated_skipworktree are both set." >testfailure
+			exit 1
+		fi
+		if test "$1" -eq 0 && test "$2" -eq 0; then
+			echo "Invalid combination of flags passed to hook; neither updated_workdir or updated_skipworktree are set." >testfailure
+			exit 2
+		fi
+		if test "$1" -eq 1; then
+			if test -f ".git/index.lock"; then
+				echo "updated_workdir set but .git/index.lock exists" >testfailure
+				exit 3
+			fi
+			if ! test -f ".git/index"; then
+				echo "updated_workdir set but .git/index does not exist" >testfailure
+				exit 3
+			fi
+		else
+			echo "update_workdir should be set for checkout" >testfailure
+			exit 4
+		fi
+		echo "success" >testsuccess
+	EOF
+	: force index to be dirty &&
+	test-tool chmtime +60 dir1/file1.txt &&
+	git checkout master &&
+	test_path_is_file testsuccess && rm -f testsuccess &&
+	test_path_is_missing testfailure &&
+	test-tool chmtime +60 dir1/file1.txt &&
+	git checkout HEAD &&
+	test_path_is_file testsuccess && rm -f testsuccess &&
+	test_path_is_missing testfailure &&
+	test-tool chmtime +60 dir1/file1.txt &&
+	git reset --hard &&
+	test_path_is_file testsuccess && rm -f testsuccess &&
+	test_path_is_missing testfailure &&
+	git checkout -B test &&
+	test_path_is_file testsuccess && rm -f testsuccess &&
+	test_path_is_missing testfailure
+'
+
+test_expect_success 'test reset --mixed and update-index triggers the hook' '
+	write_script .git/hooks/post-index-change <<-\EOF &&
+		if test "$1" -eq 1 && test "$2" -eq 1; then
+			echo "Invalid combination of flags passed to hook; updated_workdir and updated_skipworktree are both set." >testfailure
+			exit 1
+		fi
+		if test "$1" -eq 0 && test "$2" -eq 0; then
+			echo "Invalid combination of flags passed to hook; neither updated_workdir or updated_skipworktree are set." >testfailure
+			exit 2
+		fi
+		if test "$2" -eq 1; then
+			if test -f ".git/index.lock"; then
+				echo "updated_skipworktree set but .git/index.lock exists" >testfailure
+				exit 3
+			fi
+			if ! test -f ".git/index"; then
+				echo "updated_skipworktree set but .git/index does not exist" >testfailure
+				exit 3
+			fi
+		else
+			echo "updated_skipworktree should be set for reset --mixed and update-index" >testfailure
+			exit 4
+		fi
+		echo "success" >testsuccess
+	EOF
+	: force index to be dirty &&
+	test-tool chmtime +60 dir1/file1.txt &&
+	git reset --mixed --quiet HEAD~1 &&
+	test_path_is_file testsuccess && rm -f testsuccess &&
+	test_path_is_missing testfailure &&
+	git hash-object -w --stdin <dir1/file2.txt >expect &&
+	git update-index --cacheinfo 100644 "$(cat expect)" dir1/file1.txt &&
+	test_path_is_file testsuccess && rm -f testsuccess &&
+	test_path_is_missing testfailure &&
+	git update-index --skip-worktree dir1/file2.txt &&
+	git update-index --remove dir1/file2.txt &&
+	test_path_is_file testsuccess && rm -f testsuccess &&
+	test_path_is_missing testfailure
+'
+
+test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 3563daae1a..8665a4a7c0 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1637,6 +1637,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 						  WRITE_TREE_SILENT |
 						  WRITE_TREE_REPAIR);
 		}
+
+		o->result.updated_workdir = 1;
 		discard_index(o->dst_index);
 		*o->dst_index = o->result;
 	} else {

base-commit: d62dad7a7dca3f6a65162bf0e52cdf6927958e78
-- 
2.20.1.windows.1

