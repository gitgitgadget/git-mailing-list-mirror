Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDC7C4363C
	for <git@archiver.kernel.org>; Wed, 12 May 2021 17:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B64961418
	for <git@archiver.kernel.org>; Wed, 12 May 2021 17:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237660AbhELRnt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 13:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347742AbhELR3g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 13:29:36 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7048DC06174A
        for <git@vger.kernel.org>; Wed, 12 May 2021 10:28:27 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o26-20020a1c4d1a0000b0290146e1feccdaso341697wmh.0
        for <git@vger.kernel.org>; Wed, 12 May 2021 10:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dm8sgUAbByH21XfkXMiORzWivUxVG7D9c7/7YP9peOs=;
        b=t0Zqrp0kbQXYqL3MowhGPIRs/TbDgcQT9HOyzN/bHG7gXHyF6qMPBu7BsBUyCGezZz
         ZqcheTQVbk5VZTkW6hszR1yPi+z0v6vtcCBI0yLv7ZrE5hqGPOHA1isY1MdU7auyJz/f
         PHkw0SNDSboQpoG5gGqagbVeE73amz/4uwEFRmrSWph0A9HXZYk3wQnyhP1+zgZSYR60
         4OdcDfYY4ZUfPrH8ff8ntYE5VonayxRfcI0tG3m58cKim2NfNgprM/W+cB/bF+aSSlmX
         G34u1aS6UmdwOlfBMkO79jah7xU37exuJumSVCelay2mNFbkn7+P36lOO8Ubiaab7ENN
         620g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dm8sgUAbByH21XfkXMiORzWivUxVG7D9c7/7YP9peOs=;
        b=hpc8WAI5Thbf9omA9as+hBI5HPHcxaLaxJaSCUdfEIkJLx7omHd6y89ptYgIiVUI+/
         kdTG9sU4+Lb85LiC451VrGQiMuIaFKPJl0CAgqhHeGEXl2NpDQT9/gePUh2XkXtTSZvX
         n1rGhyAMlJLgkuc5je4w0tGFxXC+P8jqCTXTjXmu6Gsu16oKfByaHrIFtmGWpyCCDuXc
         xXQPWXdJcyIOpvhSezCxQv4/nRNljg4k8jvagGq5HbEmbtO1Lep5pf4n3Ur9CxLlyKTu
         fBLX69J/jOU9P0N9vhTJb+MEANmjLoc/mjYfqZDbgOsUZqVZGETWbBDYB8S5mVruE3HG
         +5LQ==
X-Gm-Message-State: AOAM5337RPkU4qvemxGGSzLPEMPN+s5ob7hi5fkMmmkhOFFzkSr0DaqV
        Q+Tjswm9H8eKSqU4HXgPKpKHiFB0I/M=
X-Google-Smtp-Source: ABdhPJypTS7Ds6EotjNXASCxjsBcY30rYl+EIOtBewx/47R4QKbYBdeIq3SRTL7bzT3Ssl31+pMU5A==
X-Received: by 2002:a1c:bd8a:: with SMTP id n132mr7489904wmf.106.1620840506177;
        Wed, 12 May 2021 10:28:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l22sm6395572wmq.28.2021.05.12.10.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 10:28:25 -0700 (PDT)
Message-Id: <6b1b4820dd20ed0911e049f0edadc2adcc391e9d.1620840502.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.v5.git.git.1620840502.gitgitgadget@gmail.com>
References: <pull.1020.v4.git.git.1620758049.gitgitgadget@gmail.com>
        <pull.1020.v5.git.git.1620840502.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 May 2021 17:28:14 +0000
Subject: [PATCH v5 1/9] dir: convert trace calls to trace2 equivalents
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
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c                             |  50 ++++++--
 t/t7063-status-untracked-cache.sh | 205 ++++++++++++++++++------------
 t/t7519-status-fsmonitor.sh       |   8 +-
 3 files changed, 162 insertions(+), 101 deletions(-)

diff --git a/dir.c b/dir.c
index 3474e67e8f3c..cf19a83d3e2c 100644
--- a/dir.c
+++ b/dir.c
@@ -2760,15 +2760,46 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 	return root;
 }
 
+static void emit_traversal_statistics(struct dir_struct *dir,
+				      struct repository *repo,
+				      const char *path,
+				      int path_len)
+{
+	if (!trace2_is_enabled())
+		return;
+
+	if (!path_len) {
+		trace2_data_string("read_directory", repo, "path", "");
+	} else {
+		struct strbuf tmp = STRBUF_INIT;
+		strbuf_add(&tmp, path, path_len);
+		trace2_data_string("read_directory", repo, "path", tmp.buf);
+		strbuf_release(&tmp);
+	}
+
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
-		trace_performance_leave("read directory %.*s", len, path);
+		trace2_region_leave("dir", "read_directory", istate->repo);
 		return dir->nr;
 	}
 
@@ -2784,23 +2815,15 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
 	QSORT(dir->entries, dir->nr, cmp_dir_entry);
 	QSORT(dir->ignored, dir->ignored_nr, cmp_dir_entry);
 
-	trace_performance_leave("read directory %.*s", len, path);
+	emit_traversal_statistics(dir, istate->repo, path, len);
+
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
@@ -2811,6 +2834,7 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
 			FREE_AND_NULL(dir->untracked);
 		}
 	}
+
 	return dir->nr;
 }
 
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index accefde72fb1..9710d33b3cd6 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -57,6 +57,19 @@ iuc () {
 	return $ret
 }
 
+get_relevant_traces () {
+	# From the GIT_TRACE2_PERF data of the form
+	#    $TIME $FILE:$LINE | d0 | main | data | r1 | ? | ? | read_directo | $RELEVANT_STAT
+	# extract the $RELEVANT_STAT fields.  We don't care about region_enter
+	# or region_leave, or stats for things outside read_directory.
+	INPUT_FILE=$1
+	OUTPUT_FILE=$2
+	grep data.*read_directo $INPUT_FILE |
+	    cut -d "|" -f 9 \
+	    >"$OUTPUT_FILE"
+}
+
+
 test_lazy_prereq UNTRACKED_CACHE '
 	{ git update-index --test-untracked-cache; ret=$?; } &&
 	test $ret -ne 1
@@ -129,19 +142,21 @@ EOF
 
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
+ ....path:
+ ....node-creation:3
+ ....gitignore-invalidation:1
+ ....directory-invalidation:0
+ ....opendir:4
 EOF
-	test_cmp ../trace.expect ../trace
+	test_cmp ../trace.expect ../trace.relevant
 '
 
 test_expect_success 'untracked cache after first status' '
@@ -151,19 +166,21 @@ test_expect_success 'untracked cache after first status' '
 
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
+ ....path:
+ ....node-creation:0
+ ....gitignore-invalidation:0
+ ....directory-invalidation:0
+ ....opendir:0
 EOF
-	test_cmp ../trace.expect ../trace
+	test_cmp ../trace.expect ../trace.relevant
 '
 
 test_expect_success 'untracked cache after second status' '
@@ -174,8 +191,8 @@ test_expect_success 'untracked cache after second status' '
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
@@ -189,13 +206,15 @@ A  two
 EOF
 	test_cmp ../status.expect ../status.iuc &&
 	test_cmp ../status.expect ../actual &&
+	get_relevant_traces ../trace.output ../trace.relevant &&
 	cat >../trace.expect <<EOF &&
-node creation: 0
-gitignore invalidation: 0
-directory invalidation: 1
-opendir: 1
+ ....path:
+ ....node-creation:0
+ ....gitignore-invalidation:0
+ ....directory-invalidation:1
+ ....opendir:1
 EOF
-	test_cmp ../trace.expect ../trace
+	test_cmp ../trace.expect ../trace.relevant
 
 '
 
@@ -223,8 +242,8 @@ EOF
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
@@ -238,13 +257,15 @@ A  two
 EOF
 	test_cmp ../status.expect ../status.iuc &&
 	test_cmp ../status.expect ../actual &&
+	get_relevant_traces ../trace.output ../trace.relevant &&
 	cat >../trace.expect <<EOF &&
-node creation: 0
-gitignore invalidation: 1
-directory invalidation: 1
-opendir: 4
+ ....path:
+ ....node-creation:0
+ ....gitignore-invalidation:1
+ ....directory-invalidation:1
+ ....opendir:4
 EOF
-	test_cmp ../trace.expect ../trace
+	test_cmp ../trace.expect ../trace.relevant
 
 '
 
@@ -272,8 +293,8 @@ EOF
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
@@ -285,13 +306,15 @@ A  two
 EOF
 	test_cmp ../status.expect ../status.iuc &&
 	test_cmp ../status.expect ../actual &&
+	get_relevant_traces ../trace.output ../trace.relevant &&
 	cat >../trace.expect <<EOF &&
-node creation: 0
-gitignore invalidation: 1
-directory invalidation: 0
-opendir: 4
+ ....path:
+ ....node-creation:0
+ ....gitignore-invalidation:1
+ ....directory-invalidation:0
+ ....opendir:4
 EOF
-	test_cmp ../trace.expect ../trace
+	test_cmp ../trace.expect ../trace.relevant
 '
 
 test_expect_success 'verify untracked cache dump' '
@@ -330,8 +353,8 @@ EOF
 '
 
 test_expect_success 'status after the move' '
-	: >../trace &&
-	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
+	: >../trace.output &&
+	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../actual &&
 	iuc status --porcelain >../status.iuc &&
 	cat >../status.expect <<EOF &&
@@ -343,13 +366,15 @@ A  one
 EOF
 	test_cmp ../status.expect ../status.iuc &&
 	test_cmp ../status.expect ../actual &&
+	get_relevant_traces ../trace.output ../trace.relevant &&
 	cat >../trace.expect <<EOF &&
-node creation: 0
-gitignore invalidation: 0
-directory invalidation: 0
-opendir: 1
+ ....path:
+ ....node-creation:0
+ ....gitignore-invalidation:0
+ ....directory-invalidation:0
+ ....opendir:1
 EOF
-	test_cmp ../trace.expect ../trace
+	test_cmp ../trace.expect ../trace.relevant
 '
 
 test_expect_success 'verify untracked cache dump' '
@@ -389,8 +414,8 @@ EOF
 '
 
 test_expect_success 'status after the move' '
-	: >../trace &&
-	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
+	: >../trace.output &&
+	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../actual &&
 	iuc status --porcelain >../status.iuc &&
 	cat >../status.expect <<EOF &&
@@ -402,13 +427,15 @@ A  two
 EOF
 	test_cmp ../status.expect ../status.iuc &&
 	test_cmp ../status.expect ../actual &&
+	get_relevant_traces ../trace.output ../trace.relevant &&
 	cat >../trace.expect <<EOF &&
-node creation: 0
-gitignore invalidation: 0
-directory invalidation: 0
-opendir: 1
+ ....path:
+ ....node-creation:0
+ ....gitignore-invalidation:0
+ ....directory-invalidation:0
+ ....opendir:1
 EOF
-	test_cmp ../trace.expect ../trace
+	test_cmp ../trace.expect ../trace.relevant
 '
 
 test_expect_success 'verify untracked cache dump' '
@@ -438,8 +465,8 @@ test_expect_success 'set up for sparse checkout testing' '
 '
 
 test_expect_success 'status after commit' '
-	: >../trace &&
-	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
+	: >../trace.output &&
+	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../actual &&
 	iuc status --porcelain >../status.iuc &&
 	cat >../status.expect <<EOF &&
@@ -448,13 +475,15 @@ test_expect_success 'status after commit' '
 EOF
 	test_cmp ../status.expect ../status.iuc &&
 	test_cmp ../status.expect ../actual &&
+	get_relevant_traces ../trace.output ../trace.relevant &&
 	cat >../trace.expect <<EOF &&
-node creation: 0
-gitignore invalidation: 0
-directory invalidation: 0
-opendir: 2
+ ....path:
+ ....node-creation:0
+ ....gitignore-invalidation:0
+ ....directory-invalidation:0
+ ....opendir:2
 EOF
-	test_cmp ../trace.expect ../trace
+	test_cmp ../trace.expect ../trace.relevant
 '
 
 test_expect_success 'untracked cache correct after commit' '
@@ -496,9 +525,9 @@ test_expect_success 'create/modify files, some of which are gitignored' '
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
@@ -509,13 +538,15 @@ test_expect_success 'test sparse status with untracked cache' '
 EOF
 	test_cmp ../status.expect ../status.iuc &&
 	test_cmp ../status.expect ../status.actual &&
+	get_relevant_traces ../trace.output ../trace.relevant &&
 	cat >../trace.expect <<EOF &&
-node creation: 0
-gitignore invalidation: 1
-directory invalidation: 2
-opendir: 2
+ ....path:
+ ....node-creation:0
+ ....gitignore-invalidation:1
+ ....directory-invalidation:2
+ ....opendir:2
 EOF
-	test_cmp ../trace.expect ../trace
+	test_cmp ../trace.expect ../trace.relevant
 '
 
 test_expect_success 'untracked cache correct after status' '
@@ -539,8 +570,8 @@ EOF
 
 test_expect_success 'test sparse status again with untracked cache' '
 	avoid_racy &&
-	: >../trace &&
-	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
+	: >../trace.output &&
+	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../status.actual &&
 	iuc status --porcelain >../status.iuc &&
 	cat >../status.expect <<EOF &&
@@ -551,13 +582,15 @@ test_expect_success 'test sparse status again with untracked cache' '
 EOF
 	test_cmp ../status.expect ../status.iuc &&
 	test_cmp ../status.expect ../status.actual &&
+	get_relevant_traces ../trace.output ../trace.relevant &&
 	cat >../trace.expect <<EOF &&
-node creation: 0
-gitignore invalidation: 0
-directory invalidation: 0
-opendir: 0
+ ....path:
+ ....node-creation:0
+ ....gitignore-invalidation:0
+ ....directory-invalidation:0
+ ....opendir:0
 EOF
-	test_cmp ../trace.expect ../trace
+	test_cmp ../trace.expect ../trace.relevant
 '
 
 test_expect_success 'set up for test of subdir and sparse checkouts' '
@@ -568,8 +601,8 @@ test_expect_success 'set up for test of subdir and sparse checkouts' '
 
 test_expect_success 'test sparse status with untracked cache and subdir' '
 	avoid_racy &&
-	: >../trace &&
-	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
+	: >../trace.output &&
+	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../status.actual &&
 	iuc status --porcelain >../status.iuc &&
 	cat >../status.expect <<EOF &&
@@ -581,13 +614,15 @@ test_expect_success 'test sparse status with untracked cache and subdir' '
 EOF
 	test_cmp ../status.expect ../status.iuc &&
 	test_cmp ../status.expect ../status.actual &&
+	get_relevant_traces ../trace.output ../trace.relevant &&
 	cat >../trace.expect <<EOF &&
-node creation: 2
-gitignore invalidation: 0
-directory invalidation: 1
-opendir: 3
+ ....path:
+ ....node-creation:2
+ ....gitignore-invalidation:0
+ ....directory-invalidation:1
+ ....opendir:3
 EOF
-	test_cmp ../trace.expect ../trace
+	test_cmp ../trace.expect ../trace.relevant
 '
 
 test_expect_success 'verify untracked cache dump (sparse/subdirs)' '
@@ -616,19 +651,21 @@ EOF
 
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
+ ....path:
+ ....node-creation:0
+ ....gitignore-invalidation:0
+ ....directory-invalidation:0
+ ....opendir:0
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

