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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58EBC433B4
	for <git@archiver.kernel.org>; Sat,  8 May 2021 00:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 729736145E
	for <git@archiver.kernel.org>; Sat,  8 May 2021 00:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhEHAJb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 20:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhEHAJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 20:09:28 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D26C061574
        for <git@vger.kernel.org>; Fri,  7 May 2021 17:08:27 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id p14-20020a05600c358eb029015c01f207d7so15996wmq.5
        for <git@vger.kernel.org>; Fri, 07 May 2021 17:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rYNxJzdZdKYwECH2HKImBF+CpT8pMjlB0AmKWi9ihcM=;
        b=ghruqQaFTs9NysnyJjk3TBY5OwCtgCyAGgqkQAq3mMBLxa/mjvGVrpIg6EJzGqqPRR
         M5wP5oiYXAwlZ8yRhbARdcydzLft5rGaiqNrYgT/PupXtjinwVXEfBZLrHyBcObniQEA
         sq63OPGs5ULZJRmi6TWgiGqUBs9XhlDjg2Vwx2bou4cLutpeNALllmVISCd6R6Z6RbOB
         1zch9S6ENYpVUjpZEGJhgkvEgy5UKGFXYq2lZ2IjFrtK0tCgLqNBi7lY9iwOyf3JXsEu
         DoTksAgN1em0749aLfpEJs1zPlbQJysS9dRdQvarcTt8poS+C3oxIQM+wWDBD6nhpXHQ
         zZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rYNxJzdZdKYwECH2HKImBF+CpT8pMjlB0AmKWi9ihcM=;
        b=Lf5aHICrm9VqjtfkLH+O5ADQGMrCauVXSH5kUlRhdiKjTpramT2MTnmwxQbLOwvnQZ
         FQ1b9ZrU+oTsiNMm6du9nsHZ3/NCbh1Pg782On5HA/VYpAE22MUW1XezCoUlRSVFr8Z3
         8//Kpcb8qC7RMo3VTbi1KFPFq5SncWgcAxLgQWvkmAYKiVbUMv/xldL1K/RSyltl5t57
         CEEN/a3ezYrRx2eITwvUdj3QqQ+0DKEVECZtwpgdMOYRWcEJVFPEeFjyZFzU37oYPoBv
         F3Y/vB/G1JnnSyjwnpKg7j7JGwE4JPYjKxAdWMh1BxGe8Sn7Rx76pb70n9F+Q59F1UrT
         6fcg==
X-Gm-Message-State: AOAM533rYFSZ4ZEXwGQUXsRDZUEX/eT/7TWUiUwwbv30wCjHJymwY+Xq
        XkzRekthNzdXkIC8jqwxIbW1aWsoY4k=
X-Google-Smtp-Source: ABdhPJxo56ap8+kU8NINGcGrGzWDkW9KsZB1dTyUUdbifQMH3Y6c08oVWEHZtlUWynqdy2ixYDN0dQ==
X-Received: by 2002:a05:600c:4f8b:: with SMTP id n11mr12870689wmq.180.1620432505817;
        Fri, 07 May 2021 17:08:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n5sm10453341wrx.31.2021.05.07.17.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 17:08:25 -0700 (PDT)
Message-Id: <3a2394506a536707788744a8b082077a017f8c8c.1620432501.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
References: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com>
        <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 May 2021 00:08:19 +0000
Subject: [PATCH v2 7/8] [RFC] dir: convert trace calls to trace2 equivalents
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
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
index 0a0138bc1aa6..23c71ab7e9a1 100644
--- a/dir.c
+++ b/dir.c
@@ -2775,12 +2775,29 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
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
@@ -2799,23 +2816,13 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
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
@@ -2826,6 +2833,9 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
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

