Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8A9C19F2A
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 03:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240131AbiHEDGf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 23:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237584AbiHEDG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 23:06:27 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAE1DEDB
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 20:06:00 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id c139so1172506pfc.2
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 20:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OFrpYOlgu3kMh4AxM1QhObGRwdasE+EoQmJpcSdwcnw=;
        b=bbb45L6R2M1uPczE47jlR19DzHcR9zp7MVgfTZxsJgjESyzyvfSdEq8aBK7afuQM1v
         2lVTgqbTNtCrPCO58M8E41zq+R4IANfKpZP6o+oPy/SHipf4bLUb4e8QifqDrBn2k7JT
         FZ68vRMLEmchGtsy/O3ZF7MXy0OQ8+AJ3RXHb5r6VSXRNtjPQwbZ/LV5oRAwGJkyHLxV
         flCQWcXxtsGYBKM2sW83oVgu+OL+nVzAL/bneS6SZeQboibVfgtiKAHN/aajyzm++W+N
         fwtK3og6pHAkkBsqj3G5NnKL9SaGRw+PEq5y2qKB9faCm7/7fmFLgYLct3rqG2wpeXo6
         nqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OFrpYOlgu3kMh4AxM1QhObGRwdasE+EoQmJpcSdwcnw=;
        b=wKWLRyqjWXJKaQVwIy9Dx1erRQ2nFJOCuIBwXhfmfqB8WSfJTNdpwefOKoHkkcBVfJ
         HftbwaW2TZd5jp+Cg1vPwbnJdaWKcabfxYspuZwhSgr42SKhcrXC3AZj7/QGnld8SwNN
         pQ7e/WP9PwDC+nHbwVhe7pYuR/5jLxDmHW1sJLeSH1urQObFGicw5ATYF8i0GC5gn4qy
         l8AQ9A/iGO1bJMutgnGEHHUrZ064e2WDgRCsXFDUAU2Jl0ttX0OdPnfvDv0KQ0PQ1g8x
         /urBSIzm+MVWZ9MUWvlrUm3sXAkP925n+2t7o3HsYPF+gx+5fFQcXShjzj2p/arDpDL2
         qgyA==
X-Gm-Message-State: ACgBeo28MrrIJYtJUJyILLcjJW1UqU5lJd0b7D0OkjktW5p6R0K3GYrF
        eTgEIrsJLlnRQl3hudmtzdOr/hibg1zVo21z
X-Google-Smtp-Source: AA6agR764fs7FpJwoIjC9r8lvSZK1gQ6GaY9YNS1XvL24HYg0r6U/LWWXezLNskR+CLoO4Ndi/EDcQ==
X-Received: by 2002:a05:6a00:13a2:b0:52e:128a:23dd with SMTP id t34-20020a056a0013a200b0052e128a23ddmr4750711pfg.54.1659668759222;
        Thu, 04 Aug 2022 20:05:59 -0700 (PDT)
Received: from ffyuanda.localdomain ([113.65.229.239])
        by smtp.gmail.com with ESMTPSA id i6-20020a654d06000000b0040df0c9a1aasm570234pgt.14.2022.08.04.20.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 20:05:58 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v2 6/9] mv: from in-cone to out-of-cone
Date:   Fri,  5 Aug 2022 11:05:25 +0800
Message-Id: <20220805030528.1535376-7-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220805030528.1535376-1-shaoxuan.yuan02@gmail.com>
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220805030528.1535376-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Originally, moving an in-cone <source> to an out-of-cone <destination>
was not possible, mainly because such <destination> is a directory that
is not present in the working tree.

Change the behavior so that we can move an in-cone <source> to
out-of-cone <destination> when --sparse is supplied.

Such <source> can be either clean or dirty, and moving it results in
different behaviors:

A clean move should move the <source> to the <destination>, both in the
working tree and the index, then remove the resulted path from the
working tree, and turn on its CE_SKIP_WORKTREE bit.

A dirty move should move the <source> to the <destination>, both in the
working tree and the index, but should *not* remove the resulted path
from the working tree and should *not* turn on its CE_SKIP_WORKTREE bit.

Helped-by: Derrick Stolee <derrickstolee@github.com>
Helped-by: Victoria Dye <vdye@github.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/mv.c                  | 55 +++++++++++++++++++++++++++++------
 t/t7002-mv-sparse-checkout.sh |  8 ++---
 2 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 1dc55153ed..e4a14aea2d 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -171,12 +171,13 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	};
 	const char **source, **destination, **dest_path, **submodule_gitfile;
 	const char *dst_w_slash;
-	enum update_mode *modes;
+	enum update_mode *modes, dst_mode = 0;
 	struct stat st;
 	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
 	struct lock_file lock_file = LOCK_INIT;
 	struct cache_entry *ce;
 	struct string_list only_match_skip_worktree = STRING_LIST_INIT_NODUP;
+	struct string_list dirty_paths = STRING_LIST_INIT_NODUP;
 
 	git_config(git_default_config, NULL);
 
@@ -214,6 +215,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		if (!path_in_sparse_checkout(dst_w_slash, &the_index) &&
 		    empty_dir_has_sparse_contents(dst_w_slash)) {
 			destination = internal_prefix_pathspec(dst_w_slash, argv, argc, DUP_BASENAME);
+			dst_mode = SKIP_WORKTREE_DIR;
 		} else if (argc != 1) {
 			die(_("destination '%s' is not a directory"), dest_path[0]);
 		} else {
@@ -408,6 +410,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		const char *src = source[i], *dst = destination[i];
 		enum update_mode mode = modes[i];
 		int pos;
+		int sparse_and_dirty = 0;
 		struct checkout state = CHECKOUT_INIT;
 		state.istate = &the_index;
 
@@ -418,6 +421,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		if (show_only)
 			continue;
 		if (!(mode & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
+		    !(dst_mode & SKIP_WORKTREE_DIR) &&
 		    rename(src, dst) < 0) {
 			if (ignore_errors)
 				continue;
@@ -437,17 +441,49 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 
 		pos = cache_name_pos(src, strlen(src));
 		assert(pos >= 0);
+		if (!(mode & SPARSE) && !lstat(src, &st))
+			sparse_and_dirty = ce_modified(active_cache[pos], &st, 0);
 		rename_cache_entry_at(pos, dst);
 
-		if ((mode & SPARSE) &&
-		    (path_in_sparse_checkout(dst, &the_index))) {
-			int dst_pos;
+		if (ignore_sparse &&
+		    core_apply_sparse_checkout &&
+		    core_sparse_checkout_cone) {
+			if ((mode & SPARSE) &&
+			    path_in_sparse_checkout(dst, &the_index)) {
+				/* from out-of-cone to in-cone */
+				int dst_pos = cache_name_pos(dst, strlen(dst));
+				struct cache_entry *dst_ce = active_cache[dst_pos];
+
+				dst_ce->ce_flags &= ~CE_SKIP_WORKTREE;
+
+				if (checkout_entry(dst_ce, &state, NULL, NULL))
+					die(_("cannot checkout %s"), dst_ce->name);
+			} else if ((dst_mode & SKIP_WORKTREE_DIR) &&
+				   !(mode & SPARSE) &&
+				   !path_in_sparse_checkout(dst, &the_index)) {
+				/* from in-cone to out-of-cone */
+				int dst_pos = cache_name_pos(dst, strlen(dst));
+				struct cache_entry *dst_ce = active_cache[dst_pos];
 
-			dst_pos = cache_name_pos(dst, strlen(dst));
-			active_cache[dst_pos]->ce_flags &= ~CE_SKIP_WORKTREE;
-
-			if (checkout_entry(active_cache[dst_pos], &state, NULL, NULL))
-				die(_("cannot checkout %s"), active_cache[dst_pos]->name);
+				/*
+				 * if src is clean, it will suffice to remove it
+				 */
+				if (!sparse_and_dirty) {
+					dst_ce->ce_flags |= CE_SKIP_WORKTREE;
+					unlink_or_warn(src);
+				} else {
+					/*
+					 * if src is dirty, move it to the
+					 * destination and create leading
+					 * dirs if necessary
+					 */
+					char *dst_dup = xstrdup(dst);
+					string_list_append(&dirty_paths, dst);
+					safe_create_leading_directories(dst_dup);
+					FREE_AND_NULL(dst_dup);
+					rename(src, dst);
+				}
+			}
 		}
 	}
 
@@ -459,6 +495,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		die(_("Unable to write new index file"));
 
 	string_list_clear(&src_for_dst, 0);
+	string_list_clear(&dirty_paths, 0);
 	UNLEAK(source);
 	UNLEAK(dest_path);
 	free(submodule_gitfile);
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index 9b3a9ab4c3..fc9577b2a6 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -290,7 +290,7 @@ test_expect_success 'move sparse file to existing destination with --force and -
 	test_cmp expect sub/file1
 '
 
-test_expect_failure 'move clean path from in-cone to out-of-cone' '
+test_expect_success 'move clean path from in-cone to out-of-cone' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	setup_sparse_checkout &&
 
@@ -343,7 +343,7 @@ test_expect_failure 'move clean path from in-cone to out-of-cone overwrite' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'move dirty path from in-cone to out-of-cone' '
+test_expect_success 'move dirty path from in-cone to out-of-cone' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	setup_sparse_checkout &&
 	echo "modified" >>sub/d &&
@@ -363,7 +363,7 @@ test_expect_failure 'move dirty path from in-cone to out-of-cone' '
 	grep "H folder1/d" actual
 '
 
-test_expect_failure 'move dir from in-cone to out-of-cone' '
+test_expect_success 'move dir from in-cone to out-of-cone' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	setup_sparse_checkout &&
 
@@ -382,7 +382,7 @@ test_expect_failure 'move dir from in-cone to out-of-cone' '
 	grep "S folder1/dir/e" actual
 '
 
-test_expect_failure 'move partially-dirty dir from in-cone to out-of-cone' '
+test_expect_success 'move partially-dirty dir from in-cone to out-of-cone' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	setup_sparse_checkout &&
 	touch sub/dir/e2 sub/dir/e3 &&
-- 
2.37.0

