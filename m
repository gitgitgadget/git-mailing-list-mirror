Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B884C43217
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 11:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241176AbiKRLbg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 06:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241212AbiKRLbY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 06:31:24 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE597C02A
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:31:17 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id f27so12385987eje.1
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+9Nspmd66ugILcMxDqSgFP/o3WZjBKUlATW6WFyrgM=;
        b=QKGo/iM7MprypyiVAwAMkG35qD1OLb6oOVWqkWJ4HsRxqqz/bv9D2pL1vx2Ho8jq91
         2/xQEGUDM0S2+m6NUl3gmst9XZa+IB+Ct4Uvk7kjOC/WxhNR3Nd3tBvZqXM5/lpiefO+
         3hBtZGHSRu0JoY6iJKnstwnMlUwbhrlgtennq/Rr5K/litZBs6Sn9DrlkV7saVe4IgJo
         CJdyoYC4CDP3UBCq4fzVh+a77lNnYbT535sBhtWqNu5+NAMJOYYE47TCM/USpCWDzzRm
         8k9SdaNwF9KzrJYVO12+pvbx/q0TIQMS6VITgJ9dOfy2qf/BCPVt6sa8rGh7sTjoEj1V
         5jhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+9Nspmd66ugILcMxDqSgFP/o3WZjBKUlATW6WFyrgM=;
        b=oMSCL4TfQtQdgAatnXuxsnjBuoPrwou3vEezv9L5wUWBtDstyXwVuKspWVQNU7wRe4
         2kuO/WhKqpgTwrl2+MmbrCWM7XDoufxoPMSZfBO4w/VgEZBqhKEdu/kHALZ4kUaMumVi
         syS7r6uwWg3RQx5wPv5gd0+BXnKyzhEc1B3mji50EGcxSEN3SRN4B2knXKGm10pnQA5D
         Q8KjPxaHeOWMN0CgeAv/NgaM009MM4ccXOWrYePLMdgIy0wGjeu+/qF6EFsRShw82WGR
         jdo1fjSuAodsTbjC6hE77702NtG2tFFw8dzsQ/JEyc5Bs7lNI2AVt5Ab+TyK7yoX7ogu
         Kz8A==
X-Gm-Message-State: ANoB5pnFtlx2kfT7apbgbXoh2Xg+4sURHqQuUtriZXEXX0BPKwNWNNYw
        6asUGEa3oRewhxwzru+BdAwGNmc+s0CSEw==
X-Google-Smtp-Source: AA0mqf42tblriT/bn2aRYZBBVwtDBYyHCSNAMVkph7zfxhl/F/6+kl3j0Pf3Lhvwarx8SpTVsAEGmw==
X-Received: by 2002:a17:906:f02:b0:799:a731:b44d with SMTP id z2-20020a1709060f0200b00799a731b44dmr5636601eji.405.1668771075774;
        Fri, 18 Nov 2022 03:31:15 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id cw24-20020a056402229800b0046730154ccbsm1713302edb.42.2022.11.18.03.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:31:15 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/12] cocci: apply "pending" index-compatibility to "t/helper/*.c"
Date:   Fri, 18 Nov 2022 12:31:02 +0100
Message-Id: <patch-08.12-f3e265e6edb-20221118T112205Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1511.gcdcff1f1dc2
In-Reply-To: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com>
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
 t/helper/test-dump-cache-tree.c      |  2 +-
 t/helper/test-dump-untracked-cache.c |  2 +-
 t/helper/test-fast-rebase.c          |  2 +-
 t/helper/test-lazy-init-name-hash.c  | 20 ++++++++++----------
 t/helper/test-read-cache.c           |  4 ++--
 t/helper/test-scrap-cache-tree.c     |  4 ++--
 t/helper/test-write-cache.c          |  5 +++--
 7 files changed, 20 insertions(+), 19 deletions(-)

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
2.38.0.1511.gcdcff1f1dc2

