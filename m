Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5163C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 09:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiLOJ7a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 04:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiLOJ7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 04:59:16 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A09C2C118
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:59:15 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id co23so2479999wrb.4
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOeJygt9Hlxa3hm9n6OxMSt1rLNYevxtuwPO1P8L/Yo=;
        b=WZwrPvxB0oIrAp12b9xkUM0PPEdoUVh0lPfp9rZUkcvcpva177RZLhE/v2LKf3QCky
         zuxqRYm7dIKSDxyTu2DGB14KjYPCG3w9Vcm+5RN/4zngnUkeC/nKunCD2Sr1ETGpUJKw
         iIdub4uLOWtyu7f9g1ARQEtLT5g3S3uteZlOq6fQg3YFwau1EkI9g1S3HtOBwKUsjnMG
         n3hXp61eu6d1gax4lFsuIuiVyjmB+HKyFmnaRfUGaH6ZvItgUDZurPGTYT0CxW0qaEQ7
         fyVxFhFbHjtT0gorWK0ccOwGqaEIeDlXSbtpLdooA3QCCWlfyn31SPzfpmQ1WNUBTOoA
         Kbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOeJygt9Hlxa3hm9n6OxMSt1rLNYevxtuwPO1P8L/Yo=;
        b=YFWu3shGGHQ1oYlJE4pCkH/uvapBMeD9BMyUp3lcWzJ4mqKgKsnZAsMsfICk8xSOZK
         0Pfk0eDD+DsUFiwnBqh9VkMfRsSoJLjSXaYJnEsDb3e1B3VbAeGlkmuO8O1U82ErYpDE
         zQjDHyMH1Uqz6XYCMfiPfjX+Timiy1hY2VDaOh94bG+/8NWbbr6IrzZHpSJuNs3EUVpK
         NneDJpVx/u1JXBrlQ5p5/iWfhf2TKbyIMPU35U8VRWEF/33PwmpeqFPmCd2d4RSNFEVX
         oWHMJufeJtkSl/8r4EytSQu2j8+CY9CIpi8ALs9eY16k/xU9N72LSqQz6S5QPF2qaiDn
         ZiQg==
X-Gm-Message-State: ANoB5pmW5LPwZv3cSN0Gc2ZayRrMT4tgmmodrLOQJZRWBX9QQtArqKrh
        r9wGf+TRyTwjvhDYSo6tR9V8DbjM/IG7Mg==
X-Google-Smtp-Source: AA0mqf6IDgSZ1FXriun1kNSRwGtX9c959Meyb459NgCVRnlFnF/qUiOcSqFR5SiAPWXQ3SAz7ats3Q==
X-Received: by 2002:adf:f407:0:b0:242:fdb0:3eaa with SMTP id g7-20020adff407000000b00242fdb03eaamr23158049wro.30.1671098353357;
        Thu, 15 Dec 2022 01:59:13 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a13-20020adfe5cd000000b00228cbac7a25sm5495948wrn.64.2022.12.15.01.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:59:12 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/6] cache-tree API: remove redundant update_main_cache_tree()
Date:   Thu, 15 Dec 2022 10:59:04 +0100
Message-Id: <patch-5.6-7f956fd8b75-20221215T095335Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
In-Reply-To: <cover-0.6-00000000000-20221215T095335Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20221215T095335Z-avarab@gmail.com>
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
2.39.0.rc2.1048.g0e5493b8d5b

