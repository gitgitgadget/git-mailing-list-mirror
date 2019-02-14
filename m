Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A16F91F453
	for <e@80x24.org>; Thu, 14 Feb 2019 14:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394859AbfBNOmy (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 09:42:54 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34588 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390360AbfBNOmx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 09:42:53 -0500
Received: by mail-qt1-f196.google.com with SMTP id w4so7113858qtc.1
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 06:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VY7NIVyqbqh2ug1dvkdQNI9RBa3XHIVM/AMco703nok=;
        b=LkQZbspS25CWFcUe0iWz8bjtcQB85lWkRrQ4+fG54bB3ZC2MtoEEMQW2EVcyWlBKrs
         R4XiZcQX3dx8dPtEkKbTPd9jcUr27FxuDbo2J+TZwUxQi97TUi8cZ9NYtpRJBToIEp/h
         I+lK321exILEwxkH2/8Rw1PCL6r4GDC9B9tlxERSHM3qywr1BBZYc/mgPGlPk4t70USp
         sW5HXVDqc76EZ7ygH5a9aGPS+nU/FDALa/ujDsynKnTjBweDy1He92JvtpsxldfU7SEu
         EyNvwp1YsgOYRQxt2TTYVriuGxnetEPAzesn81wZj0zOLvoL3BlzUpdxTnnbMzn2Truo
         BchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VY7NIVyqbqh2ug1dvkdQNI9RBa3XHIVM/AMco703nok=;
        b=fC65/HFcLO88ldwLFnvxvK2LysSzx1iuEnhTTXJhcQqKC7Qn0KUAyiywCbfghpInQS
         H2r0m95ja0cGb3dwcmDskLNETJvGll3nQ0Gwh8k0EYXlJosjK7Llhwa8ocySoXYndhs5
         GMmaPG5Gz8LlmAadrmJvZoscnANbqFdb5Q2BS3a/X0GS2uE3okxX6qig58kgdAWmpPN4
         jfQlrP5xMh3JdEfjVnfHTQEdRKGg6nSVvlXcgY7YwJmt/FCI4g3qO9Klx/+N5vbCswTP
         2lVTxT8QG35hGARp7OAqZajN8Ov0OBnUviddt4OuD61kNbDJDU3TEHMvQcJ9kkOahmFk
         vjrA==
X-Gm-Message-State: AHQUAuY6fZlg7feLa+5wR6DSxW4FYFwUQ4DcOS++xLKlTo+L5UA+ikF2
        u394wa5vxqmrjZGdwcc/H3hiRdnC
X-Google-Smtp-Source: AHgI3Ia7uQDp0HFIkiYlEQjOTu6RfOspmheOf7GLhOrtD5Bm/fpc9ShLyuHAbMgTi4ewixGi/8RbRQ==
X-Received: by 2002:ac8:445a:: with SMTP id m26mr3295252qtn.212.1550155371610;
        Thu, 14 Feb 2019 06:42:51 -0800 (PST)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id a15sm1381162qtj.96.2019.02.14.06.42.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:42:50 -0800 (PST)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org, peartben@gmail.com
Cc:     benpeart@microsoft.com, kewillf@microsoft.com,
        sandals@crustytoothpaste.net
Subject: [PATCH v2] read-cache: add post-indexchanged hook
Date:   Thu, 14 Feb 2019 09:42:41 -0500
Message-Id: <20190214144241.11240-1-peartben@gmail.com>
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

Add a post-indexchanged hook that is invoked after the index is written in
do_write_locked_index().

This hook is meant primarily for notification, and cannot affect
the outcome of git commands that trigger the index write.

The hook is passed a flag to indicate whether the working directory was
updated or not and a flag indicating if a skip-worktree bit could have
changed.  These flags enable the hook to optmize its response to the
index changed notification.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---

Notes:
    Base Ref: v2.21.0-rc0
    Web-Diff: https://github.com/benpeart/git/commit/03b96ccbd5
    Checkout: git fetch https://github.com/benpeart/git post-index-changed-v2 && git checkout 03b96ccbd5
    
    ### Interdiff (v1..v2):
    
    diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
    index 9349cd8900..94b4dadf30 100644
    --- a/Documentation/githooks.txt
    +++ b/Documentation/githooks.txt
    @@ -492,7 +492,7 @@ This hook is invoked by `git-p4 submit`. It takes no parameters and nothing
     from standard input. Exiting with non-zero status from this script prevent
     `git-p4 submit` from launching. Run `git-p4 submit --help` for details.
    
    -post-indexchanged
    +post-index-changed
     ~~~~~~~~~~~~~~~~~
    
     This hook is invoked when the index is written in read-cache.c
    diff --git a/read-cache.c b/read-cache.c
    index 0fcfa8a075..b6ead7bf8f 100644
    --- a/read-cache.c
    +++ b/read-cache.c
    @@ -3004,7 +3004,7 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
     	else
     		ret = close_lock_file_gently(lock);
    
    -	run_hook_le(NULL, "post-indexchanged",
    +	run_hook_le(NULL, "post-index-changed",
     			istate->updated_workdir ? "1" : "0",
     			istate->updated_skipworktree ? "1" : "0", NULL);
     	istate->updated_workdir = 0;
    diff --git a/t/t7113-post-index-changed-hook.sh b/t/t7113-post-index-changed-hook.sh
    index 5aeb726e37..6231b88fca 100755
    --- a/t/t7113-post-index-changed-hook.sh
    +++ b/t/t7113-post-index-changed-hook.sh
    @@ -14,7 +14,7 @@ test_expect_success 'setup' '
    
     test_expect_success 'test status, add, commit, others trigger hook without flags set' '
     	mkdir -p .git/hooks &&
    -	write_script .git/hooks/post-indexchanged <<-\EOF &&
    +	write_script .git/hooks/post-index-changed <<-\EOF &&
     		if test "$1" -eq 1; then
     			echo "Invalid combination of flags passed to hook; updated_workdir is set." >testfailure
     			exit 1
    @@ -59,7 +59,7 @@ test_expect_success 'test status, add, commit, others trigger hook without flags
     '
    
     test_expect_success 'test checkout and reset trigger the hook' '
    -	write_script .git/hooks/post-indexchanged <<-\EOF &&
    +	write_script .git/hooks/post-index-changed <<-\EOF &&
     		if test "$1" -eq 1 && test "$2" -eq 1; then
     			echo "Invalid combination of flags passed to hook; updated_workdir and updated_skipworktree are both set." >testfailure
     			exit 1
    @@ -102,7 +102,7 @@ test_expect_success 'test checkout and reset trigger the hook' '
     '
    
     test_expect_success 'test reset --mixed and update-index triggers the hook' '
    -	write_script .git/hooks/post-indexchanged <<-\EOF &&
    +	write_script .git/hooks/post-index-changed <<-\EOF &&
     		if test "$1" -eq 1 && test "$2" -eq 1; then
     			echo "Invalid combination of flags passed to hook; updated_workdir and updated_skipworktree are both set." >testfailure
     			exit 1
    
    ### Patches

 Documentation/githooks.txt         |  18 ++++
 builtin/reset.c                    |   1 +
 builtin/update-index.c             |   2 +
 cache.h                            |   4 +-
 read-cache.c                       |  14 ++-
 t/t7113-post-index-changed-hook.sh | 144 +++++++++++++++++++++++++++++
 unpack-trees.c                     |   2 +
 7 files changed, 182 insertions(+), 3 deletions(-)
 create mode 100755 t/t7113-post-index-changed-hook.sh

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 959044347e..94b4dadf30 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -492,6 +492,24 @@ This hook is invoked by `git-p4 submit`. It takes no parameters and nothing
 from standard input. Exiting with non-zero status from this script prevent
 `git-p4 submit` from launching. Run `git-p4 submit --help` for details.
 
+post-index-changed
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
index 0e0c93edc9..b6ead7bf8f 100644
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
+	run_hook_le(NULL, "post-index-changed",
+			istate->updated_workdir ? "1" : "0",
+			istate->updated_skipworktree ? "1" : "0", NULL);
+	istate->updated_workdir = 0;
+	istate->updated_skipworktree = 0;
+
+	return ret;
 }
 
 static int write_split_index(struct index_state *istate,
diff --git a/t/t7113-post-index-changed-hook.sh b/t/t7113-post-index-changed-hook.sh
new file mode 100755
index 0000000000..6231b88fca
--- /dev/null
+++ b/t/t7113-post-index-changed-hook.sh
@@ -0,0 +1,144 @@
+#!/bin/sh
+
+test_description='post index changed hook'
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
+	write_script .git/hooks/post-index-changed <<-\EOF &&
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
+	write_script .git/hooks/post-index-changed <<-\EOF &&
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
+	write_script .git/hooks/post-index-changed <<-\EOF &&
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

