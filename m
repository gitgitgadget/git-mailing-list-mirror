Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45103C4332F
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 13:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbiKSNIF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 08:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbiKSNH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 08:07:57 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A2692B53
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 05:07:56 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id i10so19137365ejg.6
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 05:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQlaos3rneUa9QDwETVQPfjWt7Upj4N6f5RRZ0D8brE=;
        b=ASO9evO5fN1x6JULdU4/mgbfuKN005xu0NfcmE4Z577pJV/zDx4skOzFN4pM5glY30
         DkFnU/zG4psuWRMOMszXb90Ttq6d3XzsGGXOA5+MCdVx1Ghvp+PVi659mdjTJ3Y52FzZ
         LTE+1D+hpE1uIPtHEDippvewbdgRS9X1K9X8HdpQpCCTyL3RAnFKn63hPpI85Y+tJKTC
         P5F8rz8BaNfjUprQbcR0ka2uiG2eh7oSKl9dB2IQCwZOKh7K8DnNuefbQRDjrLCuHDSr
         d3AjDHLsj8BJ+lRx2WTBQBbZp2wUKTOvqpf6EpPT9CyWcPHfXm34FQ5ablHPDwkKG4xV
         ZQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQlaos3rneUa9QDwETVQPfjWt7Upj4N6f5RRZ0D8brE=;
        b=k4cN47R+xyXdYIMoE2Ejq9PxVeHCt+PuYUPGDeiwy/BZUbm9yjPfKex6uKYwL9KfyI
         LzjlxBV9yCwhOEp90u1BPr5zBbBEmET4KIZaiOZZqdzTkvNTqrDJXuZN/qGItl6icWI7
         rP12sTSKumC2JnRcTJFD+98LHofbIapMOPsfSzh4ijZ31cIvjSPRZ4HNd8qwG424ODsR
         mPuDc8kmNvKDqC7s8PEiQIoAAzb+m5+PIRYTklcpiJx8nbGQWRubyE+WAV/UvYkZ8/u+
         8sw9xyuofszc0VhE7dF5q3GNWFBsB66mMQR8ziO0q9ESz9O9sv0gPVZ1UWv43LN7Of6S
         BeSA==
X-Gm-Message-State: ANoB5plSXJtbQxWRix+XrjKnHrO0Q6Ttg5kmFV+7VYR9H8PrXWqLX/gX
        hJEVRfygg2hFfTJe3+vNI0rnaHiFjfYrhw==
X-Google-Smtp-Source: AA0mqf4z79xZpcXICwSo0ZDHPyA7HCF9at7Hnmq9IC9ya5CXBoAtKwttonttU3IdsmXU6jdlUTet3A==
X-Received: by 2002:a17:906:1146:b0:78d:9f02:5458 with SMTP id i6-20020a170906114600b0078d9f025458mr9573695eja.753.1668863274297;
        Sat, 19 Nov 2022 05:07:54 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ch28-20020a0564021bdc00b0045d74aa401fsm2923802edb.60.2022.11.19.05.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 05:07:53 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 08/11] cocci: apply "pending" index-compatibility to "t/helper/*.c"
Date:   Sat, 19 Nov 2022 14:07:35 +0100
Message-Id: <patch-v2-08.11-6d57a383623-20221119T125551Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1509.g9445af83948
In-Reply-To: <cover-v2-00.11-00000000000-20221119T125550Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20221119T125550Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply the "index-compatibility.pending.cocci" rule to the "t/helper/*"
directory, a subsequent commit will extend cache.h to further narrow
down the use of "USE_THE_INDEX_COMPATIBILITY_MACROS" in this area.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-cache-tree.c           |  2 +-
 t/helper/test-dump-cache-tree.c      |  2 +-
 t/helper/test-dump-untracked-cache.c |  2 +-
 t/helper/test-fast-rebase.c          |  2 +-
 t/helper/test-lazy-init-name-hash.c  | 20 ++++++++++----------
 t/helper/test-read-cache.c           |  4 ++--
 t/helper/test-scrap-cache-tree.c     |  4 ++--
 t/helper/test-write-cache.c          |  5 +++--
 8 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/t/helper/test-cache-tree.c b/t/helper/test-cache-tree.c
index 93051b25f56..5514afdfe7a 100644
--- a/t/helper/test-cache-tree.c
+++ b/t/helper/test-cache-tree.c
@@ -30,7 +30,7 @@ int cmd__cache_tree(int argc, const char **argv)
 
 	argc = parse_options(argc, argv, NULL, options, test_cache_tree_usage, 0);
 
-	if (read_cache() < 0)
+	if (repo_read_index(the_repository) < 0)
 		die(_("unable to read index file"));
 
 	oidcpy(&oid, &the_index.cache_tree->oid);
diff --git a/t/helper/test-dump-cache-tree.c b/t/helper/test-dump-cache-tree.c
index 8d88111b357..4bf8bc3df6e 100644
--- a/t/helper/test-dump-cache-tree.c
+++ b/t/helper/test-dump-cache-tree.c
@@ -62,7 +62,7 @@ int cmd__dump_cache_tree(int ac, const char **av)
 	int ret;
 
 	setup_git_directory();
-	if (read_cache() < 0)
+	if (repo_read_index(the_repository) < 0)
 		die("unable to read index file");
 	istate = the_index;
 	istate.cache_tree = another;
diff --git a/t/helper/test-dump-untracked-cache.c b/t/helper/test-dump-untracked-cache.c
index 99010614f6d..ffe34736e53 100644
--- a/t/helper/test-dump-untracked-cache.c
+++ b/t/helper/test-dump-untracked-cache.c
@@ -51,7 +51,7 @@ int cmd__dump_untracked_cache(int ac, const char **av)
 	xsetenv("GIT_CONFIG_VALUE_0", "keep", 1);
 
 	setup_git_directory();
-	if (read_cache() < 0)
+	if (repo_read_index(the_repository) < 0)
 		die("unable to read index file");
 	uc = the_index.untracked;
 	if (!uc) {
diff --git a/t/helper/test-fast-rebase.c b/t/helper/test-fast-rebase.c
index 45665ec19a5..9def2ba6889 100644
--- a/t/helper/test-fast-rebase.c
+++ b/t/helper/test-fast-rebase.c
@@ -123,7 +123,7 @@ int cmd__fast_rebase(int argc, const char **argv)
 		die(_("Cannot read HEAD"));
 	assert(oideq(&onto->object.oid, &head));
 
-	hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
+	repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
 	if (repo_read_index(the_repository) < 0)
 		BUG("Could not read index");
 
diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-init-name-hash.c
index cd1b4c9736e..7e8723a1900 100644
--- a/t/helper/test-lazy-init-name-hash.c
+++ b/t/helper/test-lazy-init-name-hash.c
@@ -32,7 +32,7 @@ static void dump_run(void)
 	struct dir_entry *dir;
 	struct cache_entry *ce;
 
-	read_cache();
+	repo_read_index(the_repository);
 	if (single) {
 		test_lazy_init_name_hash(&the_index, 0);
 	} else {
@@ -49,7 +49,7 @@ static void dump_run(void)
 				ent /* member name */)
 		printf("name %08x %s\n", ce->ent.hash, ce->name);
 
-	discard_cache();
+	discard_index(&the_index);
 }
 
 /*
@@ -66,7 +66,7 @@ static uint64_t time_runs(int try_threaded)
 
 	for (i = 0; i < count; i++) {
 		t0 = getnanotime();
-		read_cache();
+		repo_read_index(the_repository);
 		t1 = getnanotime();
 		nr_threads_used = test_lazy_init_name_hash(&the_index, try_threaded);
 		t2 = getnanotime();
@@ -89,7 +89,7 @@ static uint64_t time_runs(int try_threaded)
 				   the_index.cache_nr);
 		fflush(stdout);
 
-		discard_cache();
+		discard_index(&the_index);
 	}
 
 	avg = sum / count;
@@ -113,9 +113,9 @@ static void analyze_run(void)
 	int i;
 	int nr;
 
-	read_cache();
+	repo_read_index(the_repository);
 	cache_nr_limit = the_index.cache_nr;
-	discard_cache();
+	discard_index(&the_index);
 
 	nr = analyze;
 	while (1) {
@@ -128,23 +128,23 @@ static void analyze_run(void)
 			nr = cache_nr_limit;
 
 		for (i = 0; i < count; i++) {
-			read_cache();
+			repo_read_index(the_repository);
 			the_index.cache_nr = nr; /* cheap truncate of index */
 			t1s = getnanotime();
 			test_lazy_init_name_hash(&the_index, 0);
 			t2s = getnanotime();
 			sum_single += (t2s - t1s);
 			the_index.cache_nr = cache_nr_limit;
-			discard_cache();
+			discard_index(&the_index);
 
-			read_cache();
+			repo_read_index(the_repository);
 			the_index.cache_nr = nr; /* cheap truncate of index */
 			t1m = getnanotime();
 			nr_threads_used = test_lazy_init_name_hash(&the_index, 1);
 			t2m = getnanotime();
 			sum_multi += (t2m - t1m);
 			the_index.cache_nr = cache_nr_limit;
-			discard_cache();
+			discard_index(&the_index);
 
 			if (!nr_threads_used)
 				printf("    [size %8d] [single %f]   non-threaded code path used\n",
diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index b736ef16421..a089be9104c 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -20,7 +20,7 @@ int cmd__read_cache(int argc, const char **argv)
 	git_config(git_default_config, NULL);
 
 	for (i = 0; i < cnt; i++) {
-		read_cache();
+		repo_read_index(the_repository);
 		if (name) {
 			int pos;
 
@@ -33,7 +33,7 @@ int cmd__read_cache(int argc, const char **argv)
 			       ce_uptodate(the_index.cache[pos]) ? "" : " not");
 			write_file(name, "%d\n", i);
 		}
-		discard_cache();
+		discard_index(&the_index);
 	}
 	return 0;
 }
diff --git a/t/helper/test-scrap-cache-tree.c b/t/helper/test-scrap-cache-tree.c
index 20e2e31f9e2..9206dee1fd2 100644
--- a/t/helper/test-scrap-cache-tree.c
+++ b/t/helper/test-scrap-cache-tree.c
@@ -9,8 +9,8 @@ int cmd__scrap_cache_tree(int ac, const char **av)
 	struct lock_file index_lock = LOCK_INIT;
 
 	setup_git_directory();
-	hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
-	if (read_cache() < 0)
+	repo_hold_locked_index(the_repository, &index_lock, LOCK_DIE_ON_ERROR);
+	if (repo_read_index(the_repository) < 0)
 		die("unable to read index file");
 	cache_tree_free(&the_index.cache_tree);
 	the_index.cache_tree = NULL;
diff --git a/t/helper/test-write-cache.c b/t/helper/test-write-cache.c
index 8837717d36a..66287d6d47d 100644
--- a/t/helper/test-write-cache.c
+++ b/t/helper/test-write-cache.c
@@ -9,9 +9,10 @@ int cmd__write_cache(int argc, const char **argv)
 	if (argc == 2)
 		cnt = strtol(argv[1], NULL, 0);
 	setup_git_directory();
-	read_cache();
+	repo_read_index(the_repository);
 	for (i = 0; i < cnt; i++) {
-		hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
+		repo_hold_locked_index(the_repository, &index_lock,
+				       LOCK_DIE_ON_ERROR);
 		if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
 			die("unable to write index file");
 	}
-- 
2.38.0.1509.g9445af83948

