Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE8EC433B4
	for <git@archiver.kernel.org>; Sat,  8 May 2021 19:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E88FF6128C
	for <git@archiver.kernel.org>; Sat,  8 May 2021 19:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhEHUAO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 16:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhEHUAN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 May 2021 16:00:13 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CC9C061574
        for <git@vger.kernel.org>; Sat,  8 May 2021 12:59:09 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso8929983wmh.4
        for <git@vger.kernel.org>; Sat, 08 May 2021 12:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6RnEBmLtP707mDl8t3fYDFJNKtd8kt+D8i5clmpf6ZU=;
        b=uPFcfMDCM68deSUIWrcSgotJvC9gjHcQUGjGj0ipKAl+aMARGFj0SoQE+SsRLQP0bX
         Ilt8pAOvcmDZ4OIwkGzdZESkF+43l0aioTDdMN1BfEDwG/ykdH3VIU6kv6g8Qc+xFyZm
         3spbKcYkYv6HsfelsbecP56OIVVPj987VTe2zZOXP68TZtwTKfTFNRULnCf+uNxpKdIO
         zi/SxMIwhLXyp0zv5wTi/z7o1lP8yir0hhtg1IA0HNwc9+AYfyGR/u7v6pb1GmdUTrNH
         uRT3gDQeS4YLbcFByHuBs7SJRUAoCEr5ZlChvyqiv80lqnSQnViI8NwEXzn5dJzjHAAw
         oVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6RnEBmLtP707mDl8t3fYDFJNKtd8kt+D8i5clmpf6ZU=;
        b=jh5TjmzeXL1aF4ZkJ1BR2ym82yt0nA3CHwe1B4mimGiY5u9wM8cynsI6QHtGEj9V9r
         7v/nH8E+o/L40wEnz9hJpfHJ1HZ2NsBSOXcpca01fWzXrWufkc1gWLQghGRpqEwtLC1A
         HHQicJ9mUKy8DgWyS8tR8sEIo9VYtIdKiEBR6h2PC+4FxBRFFWN+4l5L/RgGvU5ChQ9p
         YsW1fQ76qFFJ7WdCSaa62KFyiIzT4pZh0/qeoEXw1dDxDGDkIFbFc5uMy1y322sp3S8N
         4aJC5KC7PR3ithTuAQ1wpoBDoxmNfwzDWE4ZRhlRaMz/wjIgYFuSlvRtuRqDPqZoa1a4
         +yrQ==
X-Gm-Message-State: AOAM533D7Eo5Bk7StdsXS4BS4PcuB4PBiCwJlp+64lgYwZJkqR20Dumy
        /DCeycRH/7Sk92hxhLHVNGqvntZYlnY=
X-Google-Smtp-Source: ABdhPJyLyfVFcdDrowN3q6sIbDFa/G56EjVUxmJN4QQoMv0BeKzDvh6B8pOB4mfrrIw80K+rr4gEAA==
X-Received: by 2002:a05:600c:22c9:: with SMTP id 9mr17702205wmg.85.1620503948618;
        Sat, 08 May 2021 12:59:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o17sm14472853wrs.48.2021.05.08.12.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 12:59:08 -0700 (PDT)
Message-Id: <9f1c0d78d739cc1da8517eea92e81a7bd162578f.1620503945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
References: <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
        <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 May 2021 19:58:57 +0000
Subject: [PATCH v3 1/8] [RFC] dir: convert trace calls to trace2 equivalents
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c                             |  34 ++++--
 t/t7063-status-untracked-cache.sh | 193 +++++++++++++++++-------------
 t/t7519-status-fsmonitor.sh       |   8 +-
 3 files changed, 135 insertions(+), 100 deletions(-)

diff --git a/dir.c b/dir.c
index 3474e67e8f3c..9f7c8debeab3 100644
--- a/dir.c
+++ b/dir.c
@@ -2760,12 +2760,29 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 	return root;
 }
 
+static void trace2_read_directory_statistics(struct dir_struct *dir,
+					     struct repository *repo)
+{
+	if (!dir->untracked)
+		return;
+	trace2_data_intmax("read_directory", repo,
+			   "node-creation", dir->untracked->dir_created);
+	trace2_data_intmax("read_directory", repo,
+			   "gitignore-invalidation",
+			   dir->untracked->gitignore_invalidated);
+	trace2_data_intmax("read_directory", repo,
+			   "directory-invalidation",
+			   dir->untracked->dir_invalidated);
+	trace2_data_intmax("read_directory", repo,
+			   "opendir", dir->untracked->dir_opened);
+}
+
 int read_directory(struct dir_struct *dir, struct index_state *istate,
 		   const char *path, int len, const struct pathspec *pathspec)
 {
 	struct untracked_cache_dir *untracked;
 
-	trace_performance_enter();
+	trace2_region_enter("dir", "read_directory", istate->repo);
 
 	if (has_symlink_leading_path(path, len)) {
 		trace_performance_leave("read directory %.*s", len, path);
@@ -2784,23 +2801,13 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
 	QSORT(dir->entries, dir->nr, cmp_dir_entry);
 	QSORT(dir->ignored, dir->ignored_nr, cmp_dir_entry);
 
-	trace_performance_leave("read directory %.*s", len, path);
+	trace2_region_leave("dir", "read_directory", istate->repo);
 	if (dir->untracked) {
 		static int force_untracked_cache = -1;
-		static struct trace_key trace_untracked_stats = TRACE_KEY_INIT(UNTRACKED_STATS);
 
 		if (force_untracked_cache < 0)
 			force_untracked_cache =
 				git_env_bool("GIT_FORCE_UNTRACKED_CACHE", 0);
-		trace_printf_key(&trace_untracked_stats,
-				 "node creation: %u\n"
-				 "gitignore invalidation: %u\n"
-				 "directory invalidation: %u\n"
-				 "opendir: %u\n",
-				 dir->untracked->dir_created,
-				 dir->untracked->gitignore_invalidated,
-				 dir->untracked->dir_invalidated,
-				 dir->untracked->dir_opened);
 		if (force_untracked_cache &&
 			dir->untracked == istate->untracked &&
 		    (dir->untracked->dir_opened ||
@@ -2811,6 +2818,9 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
 			FREE_AND_NULL(dir->untracked);
 		}
 	}
+
+	if (trace2_is_enabled())
+		trace2_read_directory_statistics(dir, istate->repo);
 	return dir->nr;
 }
 
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index accefde72fb1..6bce65b439e3 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -57,6 +57,19 @@ iuc () {
 	return $ret
 }
 
+get_relevant_traces() {
+	# From the GIT_TRACE2_PERF data of the form
+	#    $TIME $FILE:$LINE | d0 | main | data | r1 | ? | ? | read_directo | $RELEVANT_STAT
+	# extract the $RELEVANT_STAT fields.  We don't care about region_enter
+	# or region_leave, or stats for things outside read_directory.
+	INPUT_FILE=$1
+	OUTPUT_FILE=$2
+	grep data.*read_directo $INPUT_FILE \
+	    | cut -d "|" -f 9 \
+	    >$OUTPUT_FILE
+}
+
+
 test_lazy_prereq UNTRACKED_CACHE '
 	{ git update-index --test-untracked-cache; ret=$?; } &&
 	test $ret -ne 1
@@ -129,19 +142,20 @@ EOF
 
 test_expect_success 'status first time (empty cache)' '
 	avoid_racy &&
-	: >../trace &&
-	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
+	: >../trace.output &&
+	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../actual &&
 	iuc status --porcelain >../status.iuc &&
 	test_cmp ../status.expect ../status.iuc &&
 	test_cmp ../status.expect ../actual &&
+	get_relevant_traces ../trace.output ../trace.relevant &&
 	cat >../trace.expect <<EOF &&
-node creation: 3
-gitignore invalidation: 1
-directory invalidation: 0
-opendir: 4
+ ..node-creation:3
+ ..gitignore-invalidation:1
+ ..directory-invalidation:0
+ ..opendir:4
 EOF
-	test_cmp ../trace.expect ../trace
+	test_cmp ../trace.expect ../trace.relevant
 '
 
 test_expect_success 'untracked cache after first status' '
@@ -151,19 +165,20 @@ test_expect_success 'untracked cache after first status' '
 
 test_expect_success 'status second time (fully populated cache)' '
 	avoid_racy &&
-	: >../trace &&
-	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
+	: >../trace.output &&
+	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../actual &&
 	iuc status --porcelain >../status.iuc &&
 	test_cmp ../status.expect ../status.iuc &&
 	test_cmp ../status.expect ../actual &&
+	get_relevant_traces ../trace.output ../trace.relevant &&
 	cat >../trace.expect <<EOF &&
-node creation: 0
-gitignore invalidation: 0
-directory invalidation: 0
-opendir: 0
+ ..node-creation:0
+ ..gitignore-invalidation:0
+ ..directory-invalidation:0
+ ..opendir:0
 EOF
-	test_cmp ../trace.expect ../trace
+	test_cmp ../trace.expect ../trace.relevant
 '
 
 test_expect_success 'untracked cache after second status' '
@@ -174,8 +189,8 @@ test_expect_success 'untracked cache after second status' '
 test_expect_success 'modify in root directory, one dir invalidation' '
 	avoid_racy &&
 	: >four &&
-	: >../trace &&
-	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
+	: >../trace.output &&
+	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../actual &&
 	iuc status --porcelain >../status.iuc &&
 	cat >../status.expect <<EOF &&
@@ -189,13 +204,14 @@ A  two
 EOF
 	test_cmp ../status.expect ../status.iuc &&
 	test_cmp ../status.expect ../actual &&
+	get_relevant_traces ../trace.output ../trace.relevant &&
 	cat >../trace.expect <<EOF &&
-node creation: 0
-gitignore invalidation: 0
-directory invalidation: 1
-opendir: 1
+ ..node-creation:0
+ ..gitignore-invalidation:0
+ ..directory-invalidation:1
+ ..opendir:1
 EOF
-	test_cmp ../trace.expect ../trace
+	test_cmp ../trace.expect ../trace.relevant
 
 '
 
@@ -223,8 +239,8 @@ EOF
 test_expect_success 'new .gitignore invalidates recursively' '
 	avoid_racy &&
 	echo four >.gitignore &&
-	: >../trace &&
-	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
+	: >../trace.output &&
+	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../actual &&
 	iuc status --porcelain >../status.iuc &&
 	cat >../status.expect <<EOF &&
@@ -238,13 +254,14 @@ A  two
 EOF
 	test_cmp ../status.expect ../status.iuc &&
 	test_cmp ../status.expect ../actual &&
+	get_relevant_traces ../trace.output ../trace.relevant &&
 	cat >../trace.expect <<EOF &&
-node creation: 0
-gitignore invalidation: 1
-directory invalidation: 1
-opendir: 4
+ ..node-creation:0
+ ..gitignore-invalidation:1
+ ..directory-invalidation:1
+ ..opendir:4
 EOF
-	test_cmp ../trace.expect ../trace
+	test_cmp ../trace.expect ../trace.relevant
 
 '
 
@@ -272,8 +289,8 @@ EOF
 test_expect_success 'new info/exclude invalidates everything' '
 	avoid_racy &&
 	echo three >>.git/info/exclude &&
-	: >../trace &&
-	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
+	: >../trace.output &&
+	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../actual &&
 	iuc status --porcelain >../status.iuc &&
 	cat >../status.expect <<EOF &&
@@ -285,13 +302,14 @@ A  two
 EOF
 	test_cmp ../status.expect ../status.iuc &&
 	test_cmp ../status.expect ../actual &&
+	get_relevant_traces ../trace.output ../trace.relevant &&
 	cat >../trace.expect <<EOF &&
-node creation: 0
-gitignore invalidation: 1
-directory invalidation: 0
-opendir: 4
+ ..node-creation:0
+ ..gitignore-invalidation:1
+ ..directory-invalidation:0
+ ..opendir:4
 EOF
-	test_cmp ../trace.expect ../trace
+	test_cmp ../trace.expect ../trace.relevant
 '
 
 test_expect_success 'verify untracked cache dump' '
@@ -330,8 +348,8 @@ EOF
 '
 
 test_expect_success 'status after the move' '
-	: >../trace &&
-	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
+	: >../trace.output &&
+	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../actual &&
 	iuc status --porcelain >../status.iuc &&
 	cat >../status.expect <<EOF &&
@@ -343,13 +361,14 @@ A  one
 EOF
 	test_cmp ../status.expect ../status.iuc &&
 	test_cmp ../status.expect ../actual &&
+	get_relevant_traces ../trace.output ../trace.relevant &&
 	cat >../trace.expect <<EOF &&
-node creation: 0
-gitignore invalidation: 0
-directory invalidation: 0
-opendir: 1
+ ..node-creation:0
+ ..gitignore-invalidation:0
+ ..directory-invalidation:0
+ ..opendir:1
 EOF
-	test_cmp ../trace.expect ../trace
+	test_cmp ../trace.expect ../trace.relevant
 '
 
 test_expect_success 'verify untracked cache dump' '
@@ -389,8 +408,8 @@ EOF
 '
 
 test_expect_success 'status after the move' '
-	: >../trace &&
-	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
+	: >../trace.output &&
+	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../actual &&
 	iuc status --porcelain >../status.iuc &&
 	cat >../status.expect <<EOF &&
@@ -402,13 +421,14 @@ A  two
 EOF
 	test_cmp ../status.expect ../status.iuc &&
 	test_cmp ../status.expect ../actual &&
+	get_relevant_traces ../trace.output ../trace.relevant &&
 	cat >../trace.expect <<EOF &&
-node creation: 0
-gitignore invalidation: 0
-directory invalidation: 0
-opendir: 1
+ ..node-creation:0
+ ..gitignore-invalidation:0
+ ..directory-invalidation:0
+ ..opendir:1
 EOF
-	test_cmp ../trace.expect ../trace
+	test_cmp ../trace.expect ../trace.relevant
 '
 
 test_expect_success 'verify untracked cache dump' '
@@ -438,8 +458,8 @@ test_expect_success 'set up for sparse checkout testing' '
 '
 
 test_expect_success 'status after commit' '
-	: >../trace &&
-	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
+	: >../trace.output &&
+	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../actual &&
 	iuc status --porcelain >../status.iuc &&
 	cat >../status.expect <<EOF &&
@@ -448,13 +468,14 @@ test_expect_success 'status after commit' '
 EOF
 	test_cmp ../status.expect ../status.iuc &&
 	test_cmp ../status.expect ../actual &&
+	get_relevant_traces ../trace.output ../trace.relevant &&
 	cat >../trace.expect <<EOF &&
-node creation: 0
-gitignore invalidation: 0
-directory invalidation: 0
-opendir: 2
+ ..node-creation:0
+ ..gitignore-invalidation:0
+ ..directory-invalidation:0
+ ..opendir:2
 EOF
-	test_cmp ../trace.expect ../trace
+	test_cmp ../trace.expect ../trace.relevant
 '
 
 test_expect_success 'untracked cache correct after commit' '
@@ -496,9 +517,9 @@ test_expect_success 'create/modify files, some of which are gitignored' '
 '
 
 test_expect_success 'test sparse status with untracked cache' '
-	: >../trace &&
+	: >../trace.output &&
 	avoid_racy &&
-	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
+	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../status.actual &&
 	iuc status --porcelain >../status.iuc &&
 	cat >../status.expect <<EOF &&
@@ -509,13 +530,14 @@ test_expect_success 'test sparse status with untracked cache' '
 EOF
 	test_cmp ../status.expect ../status.iuc &&
 	test_cmp ../status.expect ../status.actual &&
+	get_relevant_traces ../trace.output ../trace.relevant &&
 	cat >../trace.expect <<EOF &&
-node creation: 0
-gitignore invalidation: 1
-directory invalidation: 2
-opendir: 2
+ ..node-creation:0
+ ..gitignore-invalidation:1
+ ..directory-invalidation:2
+ ..opendir:2
 EOF
-	test_cmp ../trace.expect ../trace
+	test_cmp ../trace.expect ../trace.relevant
 '
 
 test_expect_success 'untracked cache correct after status' '
@@ -539,8 +561,8 @@ EOF
 
 test_expect_success 'test sparse status again with untracked cache' '
 	avoid_racy &&
-	: >../trace &&
-	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
+	: >../trace.output &&
+	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../status.actual &&
 	iuc status --porcelain >../status.iuc &&
 	cat >../status.expect <<EOF &&
@@ -551,13 +573,14 @@ test_expect_success 'test sparse status again with untracked cache' '
 EOF
 	test_cmp ../status.expect ../status.iuc &&
 	test_cmp ../status.expect ../status.actual &&
+	get_relevant_traces ../trace.output ../trace.relevant &&
 	cat >../trace.expect <<EOF &&
-node creation: 0
-gitignore invalidation: 0
-directory invalidation: 0
-opendir: 0
+ ..node-creation:0
+ ..gitignore-invalidation:0
+ ..directory-invalidation:0
+ ..opendir:0
 EOF
-	test_cmp ../trace.expect ../trace
+	test_cmp ../trace.expect ../trace.relevant
 '
 
 test_expect_success 'set up for test of subdir and sparse checkouts' '
@@ -568,8 +591,8 @@ test_expect_success 'set up for test of subdir and sparse checkouts' '
 
 test_expect_success 'test sparse status with untracked cache and subdir' '
 	avoid_racy &&
-	: >../trace &&
-	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
+	: >../trace.output &&
+	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../status.actual &&
 	iuc status --porcelain >../status.iuc &&
 	cat >../status.expect <<EOF &&
@@ -581,13 +604,14 @@ test_expect_success 'test sparse status with untracked cache and subdir' '
 EOF
 	test_cmp ../status.expect ../status.iuc &&
 	test_cmp ../status.expect ../status.actual &&
+	get_relevant_traces ../trace.output ../trace.relevant &&
 	cat >../trace.expect <<EOF &&
-node creation: 2
-gitignore invalidation: 0
-directory invalidation: 1
-opendir: 3
+ ..node-creation:2
+ ..gitignore-invalidation:0
+ ..directory-invalidation:1
+ ..opendir:3
 EOF
-	test_cmp ../trace.expect ../trace
+	test_cmp ../trace.expect ../trace.relevant
 '
 
 test_expect_success 'verify untracked cache dump (sparse/subdirs)' '
@@ -616,19 +640,20 @@ EOF
 
 test_expect_success 'test sparse status again with untracked cache and subdir' '
 	avoid_racy &&
-	: >../trace &&
-	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
+	: >../trace.output &&
+	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../status.actual &&
 	iuc status --porcelain >../status.iuc &&
 	test_cmp ../status.expect ../status.iuc &&
 	test_cmp ../status.expect ../status.actual &&
+	get_relevant_traces ../trace.output ../trace.relevant &&
 	cat >../trace.expect <<EOF &&
-node creation: 0
-gitignore invalidation: 0
-directory invalidation: 0
-opendir: 0
+ ..node-creation:0
+ ..gitignore-invalidation:0
+ ..directory-invalidation:0
+ ..opendir:0
 EOF
-	test_cmp ../trace.expect ../trace
+	test_cmp ../trace.expect ../trace.relevant
 '
 
 test_expect_success 'move entry in subdir from untracked to cached' '
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 45d025f96010..637391c6ce46 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -334,7 +334,7 @@ test_expect_success UNTRACKED_CACHE 'ignore .git changes when invalidating UNTR'
 		git config core.fsmonitor .git/hooks/fsmonitor-test &&
 		git update-index --untracked-cache &&
 		git update-index --fsmonitor &&
-		GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace-before" \
+		GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace-before" \
 		git status &&
 		test-tool dump-untracked-cache >../before
 	) &&
@@ -346,12 +346,12 @@ test_expect_success UNTRACKED_CACHE 'ignore .git changes when invalidating UNTR'
 	EOF
 	(
 		cd dot-git &&
-		GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace-after" \
+		GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace-after" \
 		git status &&
 		test-tool dump-untracked-cache >../after
 	) &&
-	grep "directory invalidation" trace-before >>before &&
-	grep "directory invalidation" trace-after >>after &&
+	grep "directory-invalidation" trace-before | cut -d"|" -f 9 >>before &&
+	grep "directory-invalidation" trace-after  | cut -d"|" -f 9 >>after &&
 	# UNTR extension unchanged, dir invalidation count unchanged
 	test_cmp before after
 '
-- 
gitgitgadget

