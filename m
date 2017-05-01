Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E1DD1F78F
	for <e@80x24.org>; Mon,  1 May 2017 19:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbdEATIh (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 15:08:37 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36076 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbdEATIg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 15:08:36 -0400
Received: by mail-pg0-f41.google.com with SMTP id t7so48752591pgt.3
        for <git@vger.kernel.org>; Mon, 01 May 2017 12:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xr2zD1dEBM7VOo9CYsHR7iIz83sIg08Gf485UEKOO0w=;
        b=ScgArvfwImslqmNDQmyDKVWepM2ujt5PLeNRo388zbGASx3uYkLUrMUIDJDcJT7xKa
         OmuGz5HKMFodj1nDrW/tC0aLbYErqVw4CBaKqb9Lb6P4K2jjWfmg/y7UTLY0lMzUVKhn
         hczJ3vLkAxBu8J6iIWmJNt3EnG7HqjsAGdaxLQgxQ4WOK3Sjq3xzcFNu4vUNFAcpgAGl
         EWkiKjMEQpmEU/SsKHJnrwDkdxUC8bHWnGMZnbgkLLNAXxKGxtXkIT2QNR9km4NysWYE
         46s6qupYTvAkJ1BqlVMIk8DSUMcLxFXcUEYV4ODPQ1JgWzJ06bMBqoaEdptDv+pEp+Im
         os0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xr2zD1dEBM7VOo9CYsHR7iIz83sIg08Gf485UEKOO0w=;
        b=h6MPM4TsQov5PAq7luP1tejI6pA1hzDbZSivV6zfqp+z57nKcCbZqazA3/JmcdP7Bo
         xI7R1zdUMxL0JW5w6XfkENJj9zQLcrA6Bpt3PLMOMfXk3Au4zz9dotdjLMxPtxiJMgz6
         P5jAS3lEHhgZf2lKn8UFPL2PQ4t1oDqNz9rRqPJlaHyY1t6nUDbGUU+WZu4XMBJdHuvz
         61qyqHDJAIuBfc6dIhFRJRR3nIUzgpUFqxlPdgxHsOOq1vpzJm7tksr4T+YyUJw34vrz
         8Dgf8hCAH2njAxgWgSTW3YdrAvT5V52peRZ8n5llaKSiBBRMWaWuJ22KOl7UHmDx/I5N
         cE0w==
X-Gm-Message-State: AN3rC/4dRsmKF93AI1wRmJuCvGyWSw15MGt7ZJfMZARIv+BinMiPRzO7
        VaAbhVkdAmH1s/85
X-Received: by 10.98.223.200 with SMTP id d69mr28783595pfl.100.1493665715541;
        Mon, 01 May 2017 12:08:35 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c4be:9746:6a14:c7a4])
        by smtp.gmail.com with ESMTPSA id u15sm10901667pgc.66.2017.05.01.12.08.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 12:08:31 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/5] cache.h: drop read_cache_preload(pathspec)
Date:   Mon,  1 May 2017 12:07:18 -0700
Message-Id: <20170501190719.10669-5-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.1.gbc33f0f778
In-Reply-To: <20170501190719.10669-1-sbeller@google.com>
References: <20170501190719.10669-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

coccinelle patch:
@@ expression E; @@
-read_cache_preload(E)
+read_index_preload(&the_index, E)

Additionally manual editing:
* drop the define from cache.h.
* builtin/{commit,describe}.c were not picked up as we have NULL and
  the address of an expression. Converted them manually.
* builtin/diff{-files,-index}.c error messages converted as well.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/checkout.c     | 4 ++--
 builtin/commit.c       | 4 ++--
 builtin/describe.c     | 2 +-
 builtin/diff-files.c   | 4 ++--
 builtin/diff-index.c   | 4 ++--
 builtin/diff.c         | 8 ++++----
 builtin/update-index.c | 2 +-
 cache.h                | 1 -
 8 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0aac616ad6..2328a475ea 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -295,7 +295,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 	lock_file = xcalloc(1, sizeof(struct lock_file));
 
 	hold_locked_index(lock_file, LOCK_DIE_ON_ERROR);
-	if (read_cache_preload(&opts->pathspec) < 0)
+	if (read_index_preload(&the_index, &opts->pathspec) < 0)
 		return error(_("index file corrupt"));
 
 	if (opts->source_tree)
@@ -488,7 +488,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
 
 	hold_locked_index(lock_file, LOCK_DIE_ON_ERROR);
-	if (read_cache_preload(NULL) < 0)
+	if (read_index_preload(&the_index, NULL) < 0)
 		return error(_("index file corrupt"));
 
 	resolve_undo_clear();
diff --git a/builtin/commit.c b/builtin/commit.c
index 65a04ac199..687e7c8a3a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -346,7 +346,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		       PATHSPEC_PREFER_FULL,
 		       prefix, argv);
 
-	if (read_cache_preload(&pathspec) < 0)
+	if (read_index_preload(&the_index, &pathspec) < 0)
 		die(_("index file corrupt"));
 
 	if (interactive) {
@@ -1377,7 +1377,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		       PATHSPEC_PREFER_FULL,
 		       prefix, argv);
 
-	read_cache_preload(&s.pathspec);
+	read_index_preload(&the_index, &s.pathspec);
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, &s.pathspec, NULL, NULL);
 
 	fd = hold_locked_index(&index_lock, 0);
diff --git a/builtin/describe.c b/builtin/describe.c
index a5cd8c513f..0229458ac6 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -531,7 +531,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			static struct lock_file index_lock;
 			int fd;
 
-			read_cache_preload(NULL);
+			read_index_preload(&the_index, NULL);
 			refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED,
 				      NULL, NULL, NULL);
 			fd = hold_locked_index(&index_lock, 0);
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 15c61fd8d1..d400d8c1fc 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -62,8 +62,8 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 	    (rev.diffopt.output_format & DIFF_FORMAT_PATCH))
 		rev.combine_merges = rev.dense_combined_merges = 1;
 
-	if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
-		perror("read_cache_preload");
+	if (read_index_preload(&the_index, &rev.diffopt.pathspec) < 0) {
+		perror("read_index_preload");
 		return -1;
 	}
 	result = run_diff_files(&rev, options);
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 49fd64d4ce..3fbe33a90a 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -44,8 +44,8 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 		usage(diff_cache_usage);
 	if (!cached) {
 		setup_work_tree();
-		if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
-			perror("read_cache_preload");
+		if (read_index_preload(&the_index, &rev.diffopt.pathspec) < 0) {
+			perror("read_index_preload");
 			return -1;
 		}
 	} else if (read_index(&the_index) < 0) {
diff --git a/builtin/diff.c b/builtin/diff.c
index ed9edb2d0c..0ae33bce2b 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -144,8 +144,8 @@ static int builtin_diff_index(struct rev_info *revs,
 		usage(builtin_diff_usage);
 	if (!cached) {
 		setup_work_tree();
-		if (read_cache_preload(&revs->diffopt.pathspec) < 0) {
-			perror("read_cache_preload");
+		if (read_index_preload(&the_index, &revs->diffopt.pathspec) < 0) {
+			perror("read_index_preload");
 			return -1;
 		}
 	} else if (read_index(&the_index) < 0) {
@@ -246,8 +246,8 @@ static int builtin_diff_files(struct rev_info *revs, int argc, const char **argv
 		revs->combine_merges = revs->dense_combined_merges = 1;
 
 	setup_work_tree();
-	if (read_cache_preload(&revs->diffopt.pathspec) < 0) {
-		perror("read_cache_preload");
+	if (read_index_preload(&the_index, &revs->diffopt.pathspec) < 0) {
+		perror("read_index_preload");
 		return -1;
 	}
 	return run_diff_files(revs, options);
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 9b93e09765..8667c48446 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -766,7 +766,7 @@ struct refresh_params {
 static int refresh(struct refresh_params *o, unsigned int flag)
 {
 	setup_work_tree();
-	read_cache_preload(NULL);
+	read_index_preload(&the_index, NULL);
 	*o->has_errors |= refresh_cache(o->flags | flag);
 	return 0;
 }
diff --git a/cache.h b/cache.h
index 6abf48dcc3..a66ae97fb7 100644
--- a/cache.h
+++ b/cache.h
@@ -354,7 +354,6 @@ extern void free_name_hash(struct index_state *istate);
 
 
 #ifndef NO_THE_INDEX_COMPATIBILITY_MACROS
-#define read_cache_preload(pathspec) read_index_preload(&the_index, (pathspec))
 #define is_cache_unborn() is_index_unborn(&the_index)
 #define read_cache_unmerged() read_index_unmerged(&the_index)
 #define discard_cache() discard_index(&the_index)
-- 
2.13.0.rc1.1.gbc33f0f778

