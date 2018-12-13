Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_MIXED_ES shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D480720A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 19:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbeLMTlT (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 14:41:19 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40053 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbeLMTlT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 14:41:19 -0500
Received: by mail-qt1-f193.google.com with SMTP id k12so3530716qtf.7
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 11:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9CcUL19jbjQ8PcTOb1MNNa5Hhq3i8zCKdiDsJ2wc15A=;
        b=U/RHNpiZT4Vt1cdssBUg6D/E6pP4+DAh7Rll1UilTbp19VzDrWebo/7j57bik/XscL
         6ZV3g/qVUpvN0qE+xhzNqDoDt4FR9rbSdtS4Rbe6xzlPESh+gt8OOnwnH3K11WcxZXMz
         Io8fGjwzXr10y6xuMLaDr8mMFO77gkaL003EGUmbL2Ws/n/fTUJDYrkWwzjkxBgVYrmt
         3cE2M5A0uAcADv/CMOJLnREpKld4ACwCJs+/Z5U6NQm/+RSLqtah4UBCugh+gtQlB8OI
         J7IWY7op1eYSAUHQPfRL20zybLdftqGovRY2k66rlFiMEteUsevWbwzYIbr6xjkHE7ZJ
         bamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9CcUL19jbjQ8PcTOb1MNNa5Hhq3i8zCKdiDsJ2wc15A=;
        b=PKwVB4jd0S+iYvc+gsnVqc7FoDopnh4yhxUGbB/NWGjG8c5jGcnEZasZ2PB7i29eXQ
         wDgJGvVWkb/EjcH2rtQRZ/Kz9LYXF6dsuLuewvH9N7emVDkgdwN9pSUshV9XtyEBe1U5
         Zuv3tmdkhjyHjg26KIgJ+q4VSR4Cil874WvZ9UYgIQ686wX5STseUfGtErYx1kSG9wF7
         0ynud0FUgI4u4s3yzZy9mOL0qwXGz3/Scaqp2irXS8VvYLwFDcj8fmtTbX2NdhL8+32w
         mqSYjS8M98/enqnXdtTSOeDqtBMBoDTp+E2p93HAefeWfXv/JrdNgdyHaaMe7tOS0CIn
         wv+A==
X-Gm-Message-State: AA+aEWZ4UzqLoubvb1kPXKVT45/UTNuJYkY7szAWiWN/lznTi8WLdMcH
        6DiXgW1PwonKfNGk/dw0BDmt9Ad/
X-Google-Smtp-Source: AFSGD/WnWnL31hCkzdYwZsZDX0t9aRy+DpmjfBmBtfwsEe7y4VqLn5b0lBCsUC+F5B6+UPehkpeH6g==
X-Received: by 2002:ac8:42c1:: with SMTP id g1mr124296qtm.118.1544730077292;
        Thu, 13 Dec 2018 11:41:17 -0800 (PST)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id e89sm1645085qtb.78.2018.12.13.11.41.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 11:41:16 -0800 (PST)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     benpeart@microsoft.com, pclouds@gmail.com,
        sandals@crustytoothpaste.net, avarab@gmail.com,
        Johannes.Schindelin@gmx.de, szeder.dev@gmail.com
Subject: [PATCH v2] teach git to support a virtual (partially populated) work directory
Date:   Thu, 13 Dec 2018 14:41:07 -0500
Message-Id: <20181213194107.31572-1-peartben@gmail.com>
X-Mailer: git-send-email 2.19.1.gvfs.1.16.g9d1374d
In-Reply-To: <20181030191608.18716-1-peartben@gmail.com>
References: <20181030191608.18716-1-peartben@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

To make git perform well on the very largest repos, we must make git
operations O(modified) instead of O(size of repo).  This takes advantage of
the fact that the number of files a developer has modified (especially
in very large repos) is typically a tiny fraction of the overall repo size.

We accomplished this by utilizing the existing internal logic for the skip
worktree bit and excludes to tell git to ignore all files and folders other
than those that have been modified.  This logic is driven by an external
process that monitors writes to the repo and communicates the list of files
and folders with changes to git via the virtual work directory hook in this
patch.

The external process maintains a list of files and folders that have been
modified.  When git runs, it requests the list of files and folders that
have been modified via the virtual work directory hook.  Git then sets/clears
the skip-worktree bit on the cache entries and builds a hashmap of the
modified files/folders that is used by the excludes logic to avoid scanning
the entire repo looking for changes and untracked files.

With this system, we have been able to make local git command performance on
extremely large repos (millions of files, 1/2 million folders) entirely
manageable (30 second checkout, 3.5 seconds status, 4 second add, 7 second
commit, etc).

On index load, clear/set the skip worktree bits based on the virtual
work directory data. Use virtual work directory data to update skip-worktree
bit in unpack-trees. Use virtual work directory data to exclude files and
folders not explicitly requested.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---

Notes:
    Base Ref: v2.20.0
    Web-Diff: https://github.com/benpeart/git/commit/acc00a41af
    Checkout: git fetch https://github.com/benpeart/git virtual-workdir-v2 && git checkout acc00a41af
    
    ### Patches

 Documentation/config/core.txt |   9 +
 Documentation/githooks.txt    |  23 ++
 Makefile                      |   1 +
 cache.h                       |   1 +
 config.c                      |  32 ++-
 config.h                      |   1 +
 dir.c                         |  26 ++-
 environment.c                 |   1 +
 read-cache.c                  |   2 +
 t/t1092-virtualworkdir.sh     | 390 ++++++++++++++++++++++++++++++++++
 unpack-trees.c                |  23 +-
 virtualworkdir.c              | 314 +++++++++++++++++++++++++++
 virtualworkdir.h              |  25 +++
 13 files changed, 840 insertions(+), 8 deletions(-)
 create mode 100755 t/t1092-virtualworkdir.sh
 create mode 100644 virtualworkdir.c
 create mode 100644 virtualworkdir.h

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index d0e6635fe0..49b7699a4e 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -68,6 +68,15 @@ core.fsmonitor::
 	avoiding unnecessary processing of files that have not changed.
 	See the "fsmonitor-watchman" section of linkgit:githooks[5].
 
+core.virtualWorkDir::
+	Please regard this as an experimental feature.
+	If set to true, utilize the virtual-work-dir hook to identify all
+	files and directories that are present in the working directory.
+	Git will only track and update files listed in the virtual work
+	directory.  Using the virtual work directory will supersede the
+	sparse-checkout settings which will be ignored.
+	See the "virtual-work-dir" section of linkgit:githooks[6].
+
 core.trustctime::
 	If false, the ctime differences between the index and the
 	working tree are ignored; useful when the inode change time
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 959044347e..9888d504b4 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -485,6 +485,29 @@ The exit status determines whether git will use the data from the
 hook to limit its search.  On error, it will fall back to verifying
 all files and folders.
 
+virtual-work-dir
+~~~~~~~~~~~~~~~~
+
+Please regard this as an experimental feature.
+
+The "Virtual Work Directory" hook allows populating the working directory
+sparsely. The virtual work directory data is typically automatically
+generated by an external process.  Git will limit what files it checks for
+changes as well as which directories are checked for untracked files based
+on the path names given. Git will also only update those files listed in the
+virtual work directory.
+
+The hook is invoked when the configuration option core.virtualWorkDir is
+set to true.  The hook takes one argument, a version (currently 1).
+
+The hook should output to stdout the list of all files in the working
+directory that git should track.  The paths are relative to the root
+of the working directory and are separated by a single NUL.  Full paths
+('dir1/a.txt') as well as directories are supported (ie 'dir1/').
+
+The exit status determines whether git will use the data from the
+hook.  On error, git will abort the command with an error message.
+
 p4-pre-submit
 ~~~~~~~~~~~~~
 
diff --git a/Makefile b/Makefile
index 1a44c811aa..061f1ab954 100644
--- a/Makefile
+++ b/Makefile
@@ -1012,6 +1012,7 @@ LIB_OBJS += utf8.o
 LIB_OBJS += varint.o
 LIB_OBJS += version.o
 LIB_OBJS += versioncmp.o
+LIB_OBJS += virtualworkdir.o
 LIB_OBJS += walker.o
 LIB_OBJS += wildmatch.o
 LIB_OBJS += worktree.o
diff --git a/cache.h b/cache.h
index ca36b44ee0..39650e6efd 100644
--- a/cache.h
+++ b/cache.h
@@ -886,6 +886,7 @@ extern char *git_replace_ref_base;
 extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
+extern int core_virtualworkdir;
 extern int precomposed_unicode;
 extern int protect_hfs;
 extern int protect_ntfs;
diff --git a/config.c b/config.c
index ff521eb27a..fc0d51aa69 100644
--- a/config.c
+++ b/config.c
@@ -1325,7 +1325,11 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 	}
 
 	if (!strcmp(var, "core.sparsecheckout")) {
-		core_apply_sparse_checkout = git_config_bool(var, value);
+		/* virtual working directory relies on the sparse checkout logic so force it on */
+		if (core_virtualworkdir)
+			core_apply_sparse_checkout = 1;
+		else
+			core_apply_sparse_checkout = git_config_bool(var, value);
 		return 0;
 	}
 
@@ -2315,6 +2319,32 @@ int git_config_get_index_threads(int *dest)
 	return 1;
 }
 
+int git_config_get_virtualworkdir(void)
+{
+	git_config_get_bool("core.virtualworkdir", &core_virtualworkdir);
+	if (core_virtualworkdir) {
+		/*
+		 * Some git commands spawn helpers and redirect the index to a different
+		 * location.  These include "difftool -d" and the sequencer
+		 * (i.e. `git rebase -i`, `git cherry-pick` and `git revert`) and others.
+		 * In those instances we don't want to update their temporary index with
+		 * our virtualization data.
+		 */
+		char *default_index_file = xstrfmt("%s/%s", the_repository->gitdir, "index");
+		int should_run_hook = !strcmp(default_index_file, the_repository->index_file);
+
+		free(default_index_file);
+		if (should_run_hook) {
+			/* virtual working directory relies on the sparse checkout logic so force it on */
+			core_apply_sparse_checkout = 1;
+			return core_virtualworkdir;
+		}
+		core_virtualworkdir = 0;
+	}
+
+	return core_virtualworkdir;
+}
+
 NORETURN
 void git_die_config_linenr(const char *key, const char *filename, int linenr)
 {
diff --git a/config.h b/config.h
index ee5d3fa7b4..e89590603c 100644
--- a/config.h
+++ b/config.h
@@ -251,6 +251,7 @@ extern int git_config_get_untracked_cache(void);
 extern int git_config_get_split_index(void);
 extern int git_config_get_max_percent_split_change(void);
 extern int git_config_get_fsmonitor(void);
+extern int git_config_get_virtualworkdir(void);
 
 /* This dies if the configured or default date is in the future */
 extern int git_config_get_expiry(const char *key, const char **output);
diff --git a/dir.c b/dir.c
index ab6477d777..987a3eb17f 100644
--- a/dir.c
+++ b/dir.c
@@ -21,6 +21,7 @@
 #include "ewah/ewok.h"
 #include "fsmonitor.h"
 #include "submodule-config.h"
+#include "virtualworkdir.h"
 
 /*
  * Tells read_directory_recursive how a file or directory should be treated.
@@ -1116,6 +1117,14 @@ int is_excluded_from_list(const char *pathname,
 			  struct exclude_list *el, struct index_state *istate)
 {
 	struct exclude *exclude;
+
+	if (core_virtualworkdir) {
+		if (*dtype == DT_UNKNOWN)
+			*dtype = get_dtype(NULL, istate, pathname, pathlen);
+		if (is_excluded_from_virtualworkdir(pathname, pathlen, *dtype) > 0)
+			return 1;
+	}
+
 	exclude = last_exclude_matching_from_list(pathname, pathlen, basename,
 						  dtype, el, istate);
 	if (exclude)
@@ -1331,8 +1340,16 @@ struct exclude *last_exclude_matching(struct dir_struct *dir,
 int is_excluded(struct dir_struct *dir, struct index_state *istate,
 		const char *pathname, int *dtype_p)
 {
-	struct exclude *exclude =
-		last_exclude_matching(dir, istate, pathname, dtype_p);
+	struct exclude *exclude;
+
+	if (core_virtualworkdir) {
+		if (*dtype_p == DT_UNKNOWN)
+			*dtype_p = get_dtype(NULL, istate, pathname, strlen(pathname));
+		if (is_excluded_from_virtualworkdir(pathname, strlen(pathname), *dtype_p) > 0)
+			return 1;
+	}
+
+	exclude = last_exclude_matching(dir, istate, pathname, dtype_p);
 	if (exclude)
 		return exclude->flags & EXC_FLAG_NEGATIVE ? 0 : 1;
 	return 0;
@@ -1685,6 +1702,9 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 	if (dtype != DT_DIR && has_path_in_index)
 		return path_none;
 
+	if (is_excluded_from_virtualworkdir(path->buf, path->len, dtype) > 0)
+		return path_excluded;
+
 	/*
 	 * When we are looking at a directory P in the working tree,
 	 * there are three cases:
@@ -2025,6 +2045,8 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 		/* add the path to the appropriate result list */
 		switch (state) {
 		case path_excluded:
+			if (is_excluded_from_virtualworkdir(path.buf, path.len, DT_DIR) > 0)
+				break;
 			if (dir->flags & DIR_SHOW_IGNORED)
 				dir_add_name(dir, istate, path.buf, path.len);
 			else if ((dir->flags & DIR_SHOW_IGNORED_TOO) ||
diff --git a/environment.c b/environment.c
index 3465597707..bc0cef4506 100644
--- a/environment.c
+++ b/environment.c
@@ -69,6 +69,7 @@ enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 char *notes_ref_name;
 int grafts_replace_parents = 1;
 int core_apply_sparse_checkout;
+int core_virtualworkdir;
 int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 unsigned long pack_size_limit_cfg;
diff --git a/read-cache.c b/read-cache.c
index bd45dc3e24..a2c8027977 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -25,6 +25,7 @@
 #include "fsmonitor.h"
 #include "thread-utils.h"
 #include "progress.h"
+#include "virtualworkdir.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -1894,6 +1895,7 @@ static void post_read_index_from(struct index_state *istate)
 	tweak_untracked_cache(istate);
 	tweak_split_index(istate);
 	tweak_fsmonitor(istate);
+	apply_virtualworkdir(istate);
 }
 
 static size_t estimate_cache_size_from_compressed(unsigned int entries)
diff --git a/t/t1092-virtualworkdir.sh b/t/t1092-virtualworkdir.sh
new file mode 100755
index 0000000000..752049fbe3
--- /dev/null
+++ b/t/t1092-virtualworkdir.sh
@@ -0,0 +1,390 @@
+#!/bin/sh
+
+test_description='virtual work directory tests'
+
+. ./test-lib.sh
+
+reset_repo () {
+	rm .git/index &&
+	git -c core.virtualworkdir=false reset --hard HEAD &&
+	git -c core.virtualworkdir=false clean -fd &&
+	>untracked.txt &&
+	>dir1/untracked.txt &&
+	>dir2/untracked.txt
+}
+
+test_expect_success 'setup' '
+	mkdir -p .git/hooks/ &&
+	cat >.gitignore <<-\EOF &&
+		.gitignore
+		expect*
+		actual*
+	EOF
+	>file1.txt &&
+	>file2.txt &&
+	mkdir -p dir1 &&
+	>dir1/file1.txt &&
+	>dir1/file2.txt &&
+	mkdir -p dir2 &&
+	>dir2/file1.txt &&
+	>dir2/file2.txt &&
+	git add . &&
+	git commit -m "initial" &&
+	git config --local core.virtualworkdir true
+'
+
+test_expect_success 'test hook parameters and version' '
+	reset_repo &&
+	write_script .git/hooks/virtual-work-dir <<-\EOF &&
+		if test "$#" -ne 1
+		then
+			echo "$0: Exactly 1 argument expected" >&2
+			exit 2
+		fi
+
+		if test "$1" != 1
+		then
+			echo "$0: Unsupported hook version." >&2
+			exit 1
+		fi
+	EOF
+	git status &&
+	write_script .git/hooks/virtual-work-dir <<-\EOF &&
+		exit 3
+	EOF
+	test_must_fail git status
+'
+
+test_expect_success 'verify status is clean' '
+	reset_repo &&
+	write_script .git/hooks/virtual-work-dir <<-\EOF &&
+		printf "dir2/file1.txt\0"
+	EOF
+	rm -f .git/index &&
+	git checkout -f &&
+	write_script .git/hooks/virtual-work-dir <<-\EOF &&
+		printf "dir2/file1.txt\0"
+		printf "dir1/file1.txt\0"
+		printf "dir1/file2.txt\0"
+	EOF
+	git status >actual &&
+	cat >expected <<-\EOF &&
+		On branch master
+		nothing to commit, working tree clean
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'verify skip-worktree bit is set for absolute path' '
+	reset_repo &&
+	write_script .git/hooks/virtual-work-dir <<-\EOF &&
+		printf "dir1/file1.txt\0"
+	EOF
+	git ls-files -v >actual &&
+	cat >expected <<-\EOF &&
+		H dir1/file1.txt
+		S dir1/file2.txt
+		S dir2/file1.txt
+		S dir2/file2.txt
+		S file1.txt
+		S file2.txt
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'verify skip-worktree bit is cleared for absolute path' '
+	reset_repo &&
+	write_script .git/hooks/virtual-work-dir <<-\EOF &&
+		printf "dir1/file2.txt\0"
+	EOF
+	git ls-files -v >actual &&
+	cat >expected <<-\EOF &&
+		S dir1/file1.txt
+		H dir1/file2.txt
+		S dir2/file1.txt
+		S dir2/file2.txt
+		S file1.txt
+		S file2.txt
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'verify folder wild cards' '
+	reset_repo &&
+	write_script .git/hooks/virtual-work-dir <<-\EOF &&
+		printf "dir1/\0"
+	EOF
+	git ls-files -v >actual &&
+	cat >expected <<-\EOF &&
+		H dir1/file1.txt
+		H dir1/file2.txt
+		S dir2/file1.txt
+		S dir2/file2.txt
+		S file1.txt
+		S file2.txt
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'verify folders not included are ignored' '
+	reset_repo &&
+	write_script .git/hooks/virtual-work-dir <<-\EOF &&
+		printf "dir1/file1.txt\0"
+		printf "dir1/file2.txt\0"
+	EOF
+	mkdir -p dir1/dir2 &&
+	>dir1/a &&
+	>dir1/b &&
+	>dir1/dir2/a &&
+	>dir1/dir2/b &&
+	git add . &&
+	git ls-files -v >actual &&
+	cat >expected <<-\EOF &&
+		H dir1/file1.txt
+		H dir1/file2.txt
+		S dir2/file1.txt
+		S dir2/file2.txt
+		S file1.txt
+		S file2.txt
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'verify including one file doesnt include the rest' '
+	reset_repo &&
+	write_script .git/hooks/virtual-work-dir <<-\EOF &&
+		printf "dir1/file1.txt\0"
+		printf "dir1/file2.txt\0"
+		printf "dir1/dir2/a\0"
+	EOF
+	mkdir -p dir1/dir2 &&
+	>dir1/a &&
+	>dir1/b &&
+	>dir1/dir2/a &&
+	>dir1/dir2/b &&
+	git add . &&
+	git ls-files -v >actual &&
+	cat >expected <<-\EOF &&
+		H dir1/dir2/a
+		H dir1/file1.txt
+		H dir1/file2.txt
+		S dir2/file1.txt
+		S dir2/file2.txt
+		S file1.txt
+		S file2.txt
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'verify files not listed are ignored by git clean -f -x' '
+	reset_repo &&
+	write_script .git/hooks/virtual-work-dir <<-\EOF &&
+		printf "untracked.txt\0"
+		printf "dir1/\0"
+	EOF
+	mkdir -p dir3 &&
+	>dir3/untracked.txt &&
+	git clean -f -x &&
+	test_path_is_file file1.txt &&
+	test_path_is_file file2.txt &&
+	test_path_is_missing untracked.txt &&
+	test_path_is_dir dir1 &&
+	test_path_is_file dir1/file1.txt &&
+	test_path_is_file dir1/file2.txt &&
+	test_path_is_missing dir1/untracked.txt &&
+	test_path_is_file dir2/file1.txt &&
+	test_path_is_file dir2/file2.txt &&
+	test_path_is_file dir2/untracked.txt &&
+	test_path_is_dir dir3 &&
+	test_path_is_file dir3/untracked.txt
+'
+
+test_expect_success 'verify files not listed are ignored by git clean -f -d -x' '
+	reset_repo &&
+	write_script .git/hooks/virtual-work-dir <<-\EOF &&
+		printf "untracked.txt\0"
+		printf "dir1/\0"
+		printf "dir3/\0"
+	EOF
+	mkdir -p dir3 &&
+	>dir3/untracked.txt &&
+	git clean -f -d -x &&
+	test_path_is_file file1.txt &&
+	test_path_is_file file2.txt &&
+	test_path_is_missing untracked.txt &&
+	test_path_is_dir dir1 &&
+	test_path_is_file dir1/file1.txt &&
+	test_path_is_file dir1/file2.txt &&
+	test_path_is_missing dir1/untracked.txt &&
+	test_path_is_file dir2/file1.txt &&
+	test_path_is_file dir2/file2.txt &&
+	test_path_is_file dir2/untracked.txt &&
+	test ! -d dir3 &&
+	test_path_is_missing dir3/untracked.txt
+'
+
+test_expect_success 'verify folder entries include all files' '
+	reset_repo &&
+	write_script .git/hooks/virtual-work-dir <<-\EOF &&
+		printf "dir1/\0"
+	EOF
+	mkdir -p dir1/dir2 &&
+	>dir1/a &&
+	>dir1/b &&
+	>dir1/dir2/a &&
+	>dir1/dir2/b &&
+	git status -su >actual &&
+	cat >expected <<-\EOF &&
+		?? dir1/a
+		?? dir1/b
+		?? dir1/dir2/a
+		?? dir1/dir2/b
+		?? dir1/untracked.txt
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'verify case insensitivity of virtual work directory entries' '
+	reset_repo &&
+	write_script .git/hooks/virtual-work-dir <<-\EOF &&
+		printf "dir1/a\0"
+		printf "Dir1/Dir2/a\0"
+		printf "DIR2/\0"
+	EOF
+	mkdir -p dir1/dir2 &&
+	>dir1/a &&
+	>dir1/b &&
+	>dir1/dir2/a &&
+	>dir1/dir2/b &&
+	git -c core.ignorecase=false status -su >actual &&
+	cat >expected <<-\EOF &&
+		?? dir1/a
+	EOF
+	test_cmp expected actual &&
+	git -c core.ignorecase=true status -su >actual &&
+	cat >expected <<-\EOF &&
+		?? dir1/a
+		?? dir1/dir2/a
+		?? dir2/untracked.txt
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'on file created' '
+	reset_repo &&
+	write_script .git/hooks/virtual-work-dir <<-\EOF &&
+		printf "dir1/file3.txt\0"
+	EOF
+	>dir1/file3.txt &&
+	git add . &&
+	git ls-files -v >actual &&
+	cat >expected <<-\EOF &&
+		S dir1/file1.txt
+		S dir1/file2.txt
+		H dir1/file3.txt
+		S dir2/file1.txt
+		S dir2/file2.txt
+		S file1.txt
+		S file2.txt
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'on file renamed' '
+	reset_repo &&
+	write_script .git/hooks/virtual-work-dir <<-\EOF &&
+		printf "dir1/file1.txt\0"
+		printf "dir1/file3.txt\0"
+	EOF
+	mv dir1/file1.txt dir1/file3.txt &&
+	git status -su >actual &&
+	cat >expected <<-\EOF &&
+		 D dir1/file1.txt
+		?? dir1/file3.txt
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'on file deleted' '
+	reset_repo &&
+	write_script .git/hooks/virtual-work-dir <<-\EOF &&
+		printf "dir1/file1.txt\0"
+	EOF
+	rm dir1/file1.txt &&
+	git status -su >actual &&
+	cat >expected <<-\EOF &&
+		 D dir1/file1.txt
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'on file overwritten' '
+	reset_repo &&
+	write_script .git/hooks/virtual-work-dir <<-\EOF &&
+		printf "dir1/file1.txt\0"
+	EOF
+	echo "overwritten" >dir1/file1.txt &&
+	git status -su >actual &&
+	cat >expected <<-\EOF &&
+		 M dir1/file1.txt
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'on folder created' '
+	reset_repo &&
+	write_script .git/hooks/virtual-work-dir <<-\EOF &&
+		printf "dir1/dir1/\0"
+	EOF
+	mkdir -p dir1/dir1 &&
+	git status -su >actual &&
+	cat >expected <<-\EOF &&
+	EOF
+	test_cmp expected actual &&
+	git clean -fd &&
+	test ! -d "/dir1/dir1"
+'
+
+test_expect_success 'on folder renamed' '
+	reset_repo &&
+	write_script .git/hooks/virtual-work-dir <<-\EOF &&
+		printf "dir3/\0"
+		printf "dir1/file1.txt\0"
+		printf "dir1/file2.txt\0"
+		printf "dir3/file1.txt\0"
+		printf "dir3/file2.txt\0"
+	EOF
+	mv dir1 dir3 &&
+	git status -su >actual &&
+	cat >expected <<-\EOF &&
+		 D dir1/file1.txt
+		 D dir1/file2.txt
+		?? dir3/file1.txt
+		?? dir3/file2.txt
+		?? dir3/untracked.txt
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'folder with same prefix as file' '
+	reset_repo &&
+	>dir1.sln &&
+	write_script .git/hooks/virtual-work-dir <<-\EOF &&
+		printf "dir1/\0"
+		printf "dir1.sln\0"
+	EOF
+	git add dir1.sln &&
+	git ls-files -v >actual &&
+	cat >expected <<-\EOF &&
+		H dir1.sln
+		H dir1/file1.txt
+		H dir1/file2.txt
+		S dir2/file1.txt
+		S dir2/file2.txt
+		S file1.txt
+		S file2.txt
+	EOF
+	test_cmp expected actual
+'
+
+test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 7570df481b..c6c20c9b61 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -18,6 +18,7 @@
 #include "fsmonitor.h"
 #include "object-store.h"
 #include "fetch-object.h"
+#include "virtualworkdir.h"
 
 /*
  * Error messages expected by scripts out of plumbing commands such as
@@ -1363,6 +1364,14 @@ static int clear_ce_flags_1(struct index_state *istate,
 			continue;
 		}
 
+		/* if it's not in the virtual working directory, exit early */
+		if (core_virtualworkdir) {
+			if (is_included_in_virtualworkdir(ce->name, ce->ce_namelen) > 0)
+				ce->ce_flags &= ~clear_mask;
+			cache++;
+			continue;
+		}
+
 		if (prefix->len && strncmp(ce->name, prefix->buf, prefix->len))
 			break;
 
@@ -1481,12 +1490,16 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	if (!core_apply_sparse_checkout || !o->update)
 		o->skip_sparse_checkout = 1;
 	if (!o->skip_sparse_checkout) {
-		char *sparse = git_pathdup("info/sparse-checkout");
-		if (add_excludes_from_file_to_list(sparse, "", 0, &el, NULL) < 0)
-			o->skip_sparse_checkout = 1;
-		else
+		if (core_virtualworkdir) {
 			o->el = &el;
-		free(sparse);
+		} else {
+			char *sparse = git_pathdup("info/sparse-checkout");
+			if (add_excludes_from_file_to_list(sparse, "", 0, &el, NULL) < 0)
+				o->skip_sparse_checkout = 1;
+			else
+				o->el = &el;
+			free(sparse);
+		}
 	}
 
 	memset(&o->result, 0, sizeof(o->result));
diff --git a/virtualworkdir.c b/virtualworkdir.c
new file mode 100644
index 0000000000..f2c8025bf5
--- /dev/null
+++ b/virtualworkdir.c
@@ -0,0 +1,314 @@
+#include "cache.h"
+#include "config.h"
+#include "dir.h"
+#include "hashmap.h"
+#include "run-command.h"
+#include "virtualworkdir.h"
+
+#define HOOK_INTERFACE_VERSION	(1)
+
+static struct strbuf virtual_workdir_data = STRBUF_INIT;
+static struct hashmap virtual_workdir_hashmap;
+static struct hashmap parent_directory_hashmap;
+
+struct virtualworkdir {
+	struct hashmap_entry ent; /* must be the first member! */
+	const char *pattern;
+	int patternlen;
+};
+
+static unsigned int(*vwdhash)(const void *buf, size_t len);
+static int(*vwdcmp)(const char *a, const char *b, size_t len);
+
+static int vwd_hashmap_cmp(const void *unused_cmp_data,
+	const void *a, const void *b, const void *key)
+{
+	const struct virtualworkdir *vwd1 = a;
+	const struct virtualworkdir *vwd2 = b;
+
+	return vwdcmp(vwd1->pattern, vwd2->pattern, vwd1->patternlen);
+}
+
+static void get_virtual_workdir_data(struct strbuf *vwd_data)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	const char *p;
+	int err;
+
+	strbuf_init(vwd_data, 0);
+
+	p = find_hook("virtual-work-dir");
+	if (!p)
+		die("unable to find virtual-work-dir hook");
+
+	argv_array_push(&cp.args, p);
+	argv_array_pushf(&cp.args, "%d", HOOK_INTERFACE_VERSION);
+	cp.use_shell = 1;
+	cp.dir = get_git_work_tree();
+
+	err = capture_command(&cp, vwd_data, 1024);
+	if (err)
+		die("unable to load virtual working directory");
+}
+
+static int check_includes_hashmap(struct hashmap *map, const char *pattern, int patternlen)
+{
+	struct strbuf sb = STRBUF_INIT;
+	struct virtualworkdir vwd;
+	char *slash;
+
+	/* Check straight mapping */
+	strbuf_reset(&sb);
+	strbuf_add(&sb, pattern, patternlen);
+	vwd.pattern = sb.buf;
+	vwd.patternlen = sb.len;
+	hashmap_entry_init(&vwd, vwdhash(vwd.pattern, vwd.patternlen));
+	if (hashmap_get(map, &vwd, NULL)) {
+		strbuf_release(&sb);
+		return 1;
+	}
+
+	/*
+	 * Check to see if it matches a directory or any path
+	 * underneath it.  In other words, 'a/b/foo.txt' will match
+	 * '/', 'a/', and 'a/b/'.
+	 */
+	slash = strchr(sb.buf, '/');
+	while (slash) {
+		vwd.pattern = sb.buf;
+		vwd.patternlen = slash - sb.buf + 1;
+		hashmap_entry_init(&vwd, vwdhash(vwd.pattern, vwd.patternlen));
+		if (hashmap_get(map, &vwd, NULL)) {
+			strbuf_release(&sb);
+			return 1;
+		}
+		slash = strchr(slash + 1, '/');
+	}
+
+	strbuf_release(&sb);
+	return 0;
+}
+
+static void includes_hashmap_add(struct hashmap *map, const char *pattern, const int patternlen)
+{
+	struct virtualworkdir *vwd;
+
+	vwd = xmalloc(sizeof(struct virtualworkdir));
+	vwd->pattern = pattern;
+	vwd->patternlen = patternlen;
+	hashmap_entry_init(vwd, vwdhash(vwd->pattern, vwd->patternlen));
+	hashmap_add(map, vwd);
+}
+
+static void initialize_includes_hashmap(struct hashmap *map, struct strbuf *vwd_data)
+{
+	char *buf, *entry;
+	size_t len;
+	int i;
+
+	/*
+	 * Build a hashmap of the virtual working directory data we can use to look
+	 * for cache entry matches quickly
+	 */
+	vwdhash = ignore_case ? memihash : memhash;
+	vwdcmp = ignore_case ? strncasecmp : strncmp;
+	hashmap_init(map, vwd_hashmap_cmp, NULL, 0);
+
+	entry = buf = vwd_data->buf;
+	len = vwd_data->len;
+	for (i = 0; i < len; i++) {
+		if (buf[i] == '\0') {
+			includes_hashmap_add(map, entry, buf + i - entry);
+			entry = buf + i + 1;
+		}
+	}
+}
+
+/*
+ * Return 1 if the requested item is found in the virtual working directory,
+ * 0 for not found and -1 for undecided.
+ */
+int is_included_in_virtualworkdir(const char *pathname, int pathlen)
+{
+	if (!core_virtualworkdir)
+		return -1;
+
+	if (!virtual_workdir_hashmap.tablesize && virtual_workdir_data.len)
+		initialize_includes_hashmap(&virtual_workdir_hashmap, &virtual_workdir_data);
+	if (!virtual_workdir_hashmap.tablesize)
+		return -1;
+
+	return check_includes_hashmap(&virtual_workdir_hashmap, pathname, pathlen);
+}
+
+static void parent_directory_hashmap_add(struct hashmap *map, const char *pattern, const int patternlen)
+{
+	char *slash;
+	struct virtualworkdir *vwd;
+
+	/*
+	 * Add any directories leading up to the file as the excludes logic
+	 * needs to match directories leading up to the files as well. Detect
+	 * and prevent unnecessary duplicate entries which will be common.
+	 */
+	if (patternlen > 1) {
+		slash = strchr(pattern + 1, '/');
+		while (slash) {
+			vwd = xmalloc(sizeof(struct virtualworkdir));
+			vwd->pattern = pattern;
+			vwd->patternlen = slash - pattern + 1;
+			hashmap_entry_init(vwd, vwdhash(vwd->pattern, vwd->patternlen));
+			if (hashmap_get(map, vwd, NULL))
+				free(vwd);
+			else
+				hashmap_add(map, vwd);
+			slash = strchr(slash + 1, '/');
+		}
+	}
+}
+
+static void initialize_parent_directory_hashmap(struct hashmap *map, struct strbuf *vwd_data)
+{
+	char *buf, *entry;
+	size_t len;
+	int i;
+
+	/*
+	 * Build a hashmap of the parent directories contained in the virtual
+	 * file system data we can use to look for matches quickly
+	 */
+	vwdhash = ignore_case ? memihash : memhash;
+	vwdcmp = ignore_case ? strncasecmp : strncmp;
+	hashmap_init(map, vwd_hashmap_cmp, NULL, 0);
+
+	entry = buf = vwd_data->buf;
+	len = vwd_data->len;
+	for (i = 0; i < len; i++) {
+		if (buf[i] == '\0') {
+			parent_directory_hashmap_add(map, entry, buf + i - entry);
+			entry = buf + i + 1;
+		}
+	}
+}
+
+static int check_directory_hashmap(struct hashmap *map, const char *pathname, int pathlen)
+{
+	struct strbuf sb = STRBUF_INIT;
+	struct virtualworkdir vwd;
+
+	/* Check for directory */
+	strbuf_reset(&sb);
+	strbuf_add(&sb, pathname, pathlen);
+	strbuf_addch(&sb, '/');
+	vwd.pattern = sb.buf;
+	vwd.patternlen = sb.len;
+	hashmap_entry_init(&vwd, vwdhash(vwd.pattern, vwd.patternlen));
+	if (hashmap_get(map, &vwd, NULL)) {
+		strbuf_release(&sb);
+		return 0;
+	}
+
+	strbuf_release(&sb);
+	return 1;
+}
+
+/*
+ * Return 1 for exclude, 0 for include and -1 for undecided.
+ */
+int is_excluded_from_virtualworkdir(const char *pathname, int pathlen, int dtype)
+{
+	if (!core_virtualworkdir)
+		return -1;
+
+	if (dtype != DT_REG && dtype != DT_DIR && dtype != DT_LNK)
+		die(_("is_excluded_from_virtualworkdir passed unhandled dtype"));
+
+	if (dtype == DT_REG || dtype == DT_LNK) {
+		int ret = is_included_in_virtualworkdir(pathname, pathlen);
+		if (ret > 0)
+			return 0;
+		if (ret == 0)
+			return 1;
+		return ret;
+	}
+
+	if (dtype == DT_DIR) {
+		int ret = is_included_in_virtualworkdir(pathname, pathlen);
+		if (ret > 0)
+			return 0;
+
+		if (!parent_directory_hashmap.tablesize && virtual_workdir_data.len)
+			initialize_parent_directory_hashmap(&parent_directory_hashmap, &virtual_workdir_data);
+		if (!parent_directory_hashmap.tablesize)
+			return -1;
+
+		return check_directory_hashmap(&parent_directory_hashmap, pathname, pathlen);
+	}
+
+	return -1;
+}
+
+/*
+ * Update the CE_SKIP_WORKTREE bits based on the virtual working directory.
+ */
+void apply_virtualworkdir(struct index_state *istate)
+{
+	char *buf, *entry;
+	int i;
+
+	if (!git_config_get_virtualworkdir())
+		return;
+
+	if (!virtual_workdir_data.len)
+		get_virtual_workdir_data(&virtual_workdir_data);
+
+	/* set CE_SKIP_WORKTREE bit on all entries */
+	for (i = 0; i < istate->cache_nr; i++)
+		istate->cache[i]->ce_flags |= CE_SKIP_WORKTREE;
+
+	/* clear CE_SKIP_WORKTREE bit for everything in the virtual working directory */
+	entry = buf = virtual_workdir_data.buf;
+	for (i = 0; i < virtual_workdir_data.len; i++) {
+		if (buf[i] == '\0') {
+			int pos, len;
+
+			len = buf + i - entry;
+
+			/* look for a directory wild card (ie "dir1/") */
+			if (buf[i - 1] == '/') {
+				if (ignore_case)
+					adjust_dirname_case(istate, entry);
+
+				pos = index_name_pos(istate, entry, len);
+				if (pos < 0) {
+					pos = -pos - 1;
+					while (pos < istate->cache_nr && !fspathncmp(istate->cache[pos]->name, entry, len)) {
+						istate->cache[pos]->ce_flags &= ~CE_SKIP_WORKTREE;
+						pos++;
+					}
+				}
+			} else {
+				if (ignore_case) {
+					struct cache_entry *ce = index_file_exists(istate, entry, len, ignore_case);
+					if (ce)
+						ce->ce_flags &= ~CE_SKIP_WORKTREE;
+				} else {
+					int pos = index_name_pos(istate, entry, len);
+					if (pos >= 0)
+						istate->cache[pos]->ce_flags &= ~CE_SKIP_WORKTREE;
+				}
+			}
+
+			entry += len + 1;
+		}
+	}
+}
+
+/*
+ * Free the virtual working directory data structures.
+ */
+void free_virtualworkdir(void) {
+	hashmap_free(&virtual_workdir_hashmap, 1);
+	hashmap_free(&parent_directory_hashmap, 1);
+	strbuf_release(&virtual_workdir_data);
+}
diff --git a/virtualworkdir.h b/virtualworkdir.h
new file mode 100644
index 0000000000..139d019d44
--- /dev/null
+++ b/virtualworkdir.h
@@ -0,0 +1,25 @@
+#ifndef VIRTUALWORKDIR_H
+#define VIRTUALWORKDIR_H
+
+/*
+ * Update the CE_SKIP_WORKTREE bits based on the virtual working directory.
+ */
+void apply_virtualworkdir(struct index_state *istate);
+
+/*
+ * Return 1 if the requested item is found in the virtual working directory,
+ * 0 for not found and -1 for undecided.
+ */
+int is_included_in_virtualworkdir(const char *pathname, int pathlen);
+
+/*
+ * Return 1 for exclude, 0 for include and -1 for undecided.
+ */
+int is_excluded_from_virtualworkdir(const char *pathname, int pathlen, int dtype);
+
+/*
+ * Free the virtual working directory data structures.
+ */
+void free_virtualworkdir(void);
+
+#endif

base-commit: 5d826e972970a784bd7a7bdf587512510097b8c7
-- 
2.19.1.gvfs.1.16.g9d1374d

