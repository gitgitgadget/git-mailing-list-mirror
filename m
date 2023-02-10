Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90877C05027
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 10:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjBJK3M (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 05:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjBJK25 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 05:28:57 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4403C7094C
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 02:28:56 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id o18so4598065wrj.3
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 02:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHT04WDN1A7+bbNgqH1hA/NFn/q3snf/tEgR+WZQmsY=;
        b=YyvRYrQjgMIOD24XeekeoT4r0WnavrJnUMvs0OGCeHGwt5CYDgdUzJbJCZmehzefVD
         Kiog8wSLb+mHOpvMfu3S8M9KaMhMAMU1rgv7cu3GyqMwzkASePzSUKFw6CHqXTljV3c9
         SJwgzYN2vabm+zhZNv6jzQiBhu9o547Dk6yvhgAn78Xswu5aX88Ux84/7hSARS2Gg8rS
         juXS04y2Z5iYwOGIdfWdN/dZSQq3PxLBUumjXP8F2Mrr52V9depr/Ge6GrUV2hEs4VB3
         dNzwYXxtejWjFoEy8tm8PdeKpCpgEC6ABsMe2jNsgtLxzRaIaoyrh0rqW7kJzQr21ci1
         +8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHT04WDN1A7+bbNgqH1hA/NFn/q3snf/tEgR+WZQmsY=;
        b=jHET8bTgEepVBd1lWrveBPk/f3lUf4XvRaXYKDT2DQ0/fBTHRra6M2X5msZrGioqBj
         njQFQKL/bqXCC+VKf6jQwBZj/vXot1rXMKQJwRTM/kGDTaS8g5NIb6rykoC+Hc+wMCgQ
         Q/CeTL6geQkbi4BiCHHWc7Nb4E8LgUaH+sultaZrVQY+x68YU2Epmb+XNYr1p5amsSqt
         yWVGAg7GFYRBnFl2llF6EOYuE8/wYrnXMSoALtgD3jzDGNE1wnXqEGuL9Hhz2EW3MWmN
         PK9cmc3IUiLmf8Gdvc+hVmGEzvWgl1hJs7sSXJ8Ux4ggZMfWecnxZELytCGsbpCuq3+P
         nPxw==
X-Gm-Message-State: AO0yUKWNQKjuMihr71vf/1t5QsVQeG5xRzqY7KignDOTwe0k7uKQbap5
        DGQtK3mIKYWIuqpW7FC+FPdRaUyNFSMdOZGM
X-Google-Smtp-Source: AK7set+3p1a6h8zQnZ/lSDjNGlDaNVpkmN+FtnsUvTV7Rwu1GgkGyuZqS3TIzQDsx2DAlQxWGadcHg==
X-Received: by 2002:adf:edce:0:b0:2c3:f11b:a9ea with SMTP id v14-20020adfedce000000b002c3f11ba9eamr4461699wro.25.1676024934461;
        Fri, 10 Feb 2023 02:28:54 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d514d000000b002c3f50228afsm3244792wrt.3.2023.02.10.02.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 02:28:53 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/6] cache-tree API: remove redundant update_main_cache_tree()
Date:   Fri, 10 Feb 2023 11:28:38 +0100
Message-Id: <patch-v2-5.6-ab8794da29c-20230210T102114Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1475.gc2542cdc5ef
In-Reply-To: <cover-v2-0.6-00000000000-20230210T102114Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20221215T095335Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20230210T102114Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the redundant update_main_cache_tree() function, and make its
users use cache_tree_update() instead.

The behavior of populating the "the_index.cache_tree" if it wasn't
present already was needed when this function was introduced in [1],
but it hasn't been needed since [2]; The "cache_tree_update()" will
now lazy-allocate, so there's no need for the wrapper.

1. 996277c5206 (Refactor cache_tree_update idiom from commit,
   2011-12-06)
2. fb0882648e0 (cache-tree: clean up cache_tree_update(), 2021-01-23)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit.c                             | 10 +++++-----
 cache-tree.h                                 | 10 ----------
 contrib/coccinelle/index-compatibility.cocci |  3 +++
 3 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 57a95123dff..31fbbd73d16 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -414,7 +414,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 		discard_index(&the_index);
 		read_index_from(&the_index, get_lock_file_path(&index_lock),
 				get_git_dir());
-		if (update_main_cache_tree(WRITE_TREE_SILENT) == 0) {
+		if (cache_tree_update(&the_index, WRITE_TREE_SILENT) == 0) {
 			if (reopen_lock_file(&index_lock) < 0)
 				die(_("unable to write index file"));
 			if (write_locked_index(&the_index, &index_lock, 0))
@@ -444,7 +444,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 				       LOCK_DIE_ON_ERROR);
 		add_files_to_cache(also ? prefix : NULL, &pathspec, 0);
 		refresh_cache_or_die(refresh_flags);
-		update_main_cache_tree(WRITE_TREE_SILENT);
+		cache_tree_update(&the_index, WRITE_TREE_SILENT);
 		if (write_locked_index(&the_index, &index_lock, 0))
 			die(_("unable to write new_index file"));
 		commit_style = COMMIT_NORMAL;
@@ -467,7 +467,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 		refresh_cache_or_die(refresh_flags);
 		if (the_index.cache_changed
 		    || !cache_tree_fully_valid(the_index.cache_tree))
-			update_main_cache_tree(WRITE_TREE_SILENT);
+			cache_tree_update(&the_index, WRITE_TREE_SILENT);
 		if (write_locked_index(&the_index, &index_lock,
 				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 			die(_("unable to write new_index file"));
@@ -516,7 +516,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 	repo_hold_locked_index(the_repository, &index_lock, LOCK_DIE_ON_ERROR);
 	add_remove_files(&partial);
 	refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
-	update_main_cache_tree(WRITE_TREE_SILENT);
+	cache_tree_update(&the_index, WRITE_TREE_SILENT);
 	if (write_locked_index(&the_index, &index_lock, 0))
 		die(_("unable to write new_index file"));
 
@@ -1079,7 +1079,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	}
 	read_index_from(&the_index, index_file, get_git_dir());
 
-	if (update_main_cache_tree(0)) {
+	if (cache_tree_update(&the_index, 0)) {
 		error(_("Error building trees"));
 		return 0;
 	}
diff --git a/cache-tree.h b/cache-tree.h
index 84890c9ff32..bd97caa07b0 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -53,14 +53,4 @@ int write_index_as_tree(struct object_id *oid, struct index_state *index_state,
 void prime_cache_tree(struct repository *, struct index_state *, struct tree *);
 
 int cache_tree_matches_traversal(struct cache_tree *, struct name_entry *ent, struct traverse_info *info);
-
-#ifdef USE_THE_INDEX_COMPATIBILITY_MACROS
-static inline int update_main_cache_tree(int flags)
-{
-	if (!the_index.cache_tree)
-		the_index.cache_tree = cache_tree();
-	return cache_tree_update(&the_index, flags);
-}
-#endif
-
 #endif
diff --git a/contrib/coccinelle/index-compatibility.cocci b/contrib/coccinelle/index-compatibility.cocci
index e245d805dcd..9fca870162d 100644
--- a/contrib/coccinelle/index-compatibility.cocci
+++ b/contrib/coccinelle/index-compatibility.cocci
@@ -94,6 +94,9 @@ identifier ACT = active_cache_tree;
 |
 - cache_name_pos
 + index_name_pos
+|
+- update_main_cache_tree
++ cache_tree_update
 )
   (
 + &the_index,
-- 
2.39.1.1475.gc2542cdc5ef

