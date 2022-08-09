Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308C7C25B07
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 12:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243060AbiHIMJ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 08:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241782AbiHIMJv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 08:09:51 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4BF24BF0
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 05:09:43 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id g13so4215193plo.6
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 05:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FkyLMkgFG7+YesADqT58437Z/k5esB11WQ4TQgdcZLI=;
        b=F7MK1XMNkEpIvl5fVU6uYYMo95Vt2bUJQL8w3+jEn3URH+fJokjdcn/YpYoX7RYMyV
         vkj93Y0+Xuluo2P7KUTcKA/2TW7l+7LMm6mpiJ+or3dg6CR5d4IbrDUo/xaIzLNoipqo
         QfPjQSFvCVgs5ItMeYnGESc9VxQZokSONqNcZcPeEbcLnPjcGranrf7qYIdyp9VS5HRO
         tJ3fj0PcJebCoJxLryme06f8a132DZnccUncCdVxOC/3c3KJA6hIjKgMrOwu3DcdPwUD
         Vj+ahtuTwQopJeyOQXg4eHEU06LwFJQWdlOJQVk/NofNJbhY0tUEHrrblXrGHUqD42iz
         C3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FkyLMkgFG7+YesADqT58437Z/k5esB11WQ4TQgdcZLI=;
        b=dACgLzw2992JAMMA9np1KoTly2J58UYlrbzbcYNQ1vzyiDM2D5oLZtju7pdYVuMgbD
         CP1+2VDniF6Tf594NuTWoVYMv/5qWSkepWw/apTrwHpJn3lhpCKCo8OoZ5eBKEwiB1Uc
         0wBpL5AH71bbUxsSZYxvGRwC1wVe7YmJEF7h4Gu+q7xOqmLR55smS5h6gep2Kbiyi5lT
         uP09xQQyKb+XGyT6LQtS8KSR+5mp6F07WErC0Y69gxNZJ+uaFA4GhF0Gl5ycDVGpBvHS
         BljhH3fl3PdOPQfXoIOD+U0ghunL2Q9JEYsFuq/5ddnWaAmZibAT6/X/bdjxtA7Jw1of
         Y/dw==
X-Gm-Message-State: ACgBeo2OFt04sPX/uz0K+olK0kZR7f1loMmCWWvQvvdO/nlW1xBFmoz4
        JcRjaKUBzjgZY8eutI10ab0Ev1pAms6Q0Q==
X-Google-Smtp-Source: AA6agR4o36tCal4L2fP4pTD+wtdUnweGTJ72WiccEECNUS30crbJYcOUIMYx1g/cq7kzQccy/4ocKw==
X-Received: by 2002:a17:90b:4d12:b0:1f5:59e1:994f with SMTP id mw18-20020a17090b4d1200b001f559e1994fmr25637175pjb.217.1660046983148;
        Tue, 09 Aug 2022 05:09:43 -0700 (PDT)
Received: from ffyuanda.localdomain ([120.239.67.140])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902780300b0016d10267927sm10511485pll.203.2022.08.09.05.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 05:09:42 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com, gitster@pobox.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v3 6/9] mv: from in-cone to out-of-cone
Date:   Tue,  9 Aug 2022 20:09:07 +0800
Message-Id: <20220809120910.2021413-7-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220809120910.2021413-1-shaoxuan.yuan02@gmail.com>
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220809120910.2021413-1-shaoxuan.yuan02@gmail.com>
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

Notice that <destination> can also be an out-of-cone file path, rather
than a directory.

Such <source> can be either clean or dirty, and moving it results in
different behaviors:

A clean move should move <source> to <destination> in the index (do
*not* create <destination> in the worktree), then delete <source> from
the worktree.

A dirty move should move the <source> to the <destination>, both in the
working tree and the index, but should *not* remove the resulted path
from the working tree and should *not* turn on its CE_SKIP_WORKTREE bit.

Optional reading
================

We are strict about cone mode when <destination> is a file path.
The reason is that some of the previous tests that use no-cone mode in
t7002 are keep breaking, mainly because the `dst_mode = SPARSE;` line
added in this patch.

Most features developed in both "from-out-to-in" and "from-in-to-out"
only care about cone mode situation, as no-cone mode is becoming
irrelevant. And because assigning `SPARSE` to `dst_mode` when the
repo is in no-cone mode causes miscellaneous bugs, we should just leave
this new functionality to be exclusive cone mode and save some time.

Helped-by: Derrick Stolee <derrickstolee@github.com>
Helped-by: Victoria Dye <vdye@github.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/mv.c                  | 71 ++++++++++++++++++++++++++++++-----
 t/t7002-mv-sparse-checkout.sh |  8 ++--
 2 files changed, 66 insertions(+), 13 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 1dc55153ed..6a6420c984 100644
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
 
@@ -214,10 +215,21 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		if (!path_in_sparse_checkout(dst_w_slash, &the_index) &&
 		    empty_dir_has_sparse_contents(dst_w_slash)) {
 			destination = internal_prefix_pathspec(dst_w_slash, argv, argc, DUP_BASENAME);
+			dst_mode = SKIP_WORKTREE_DIR;
 		} else if (argc != 1) {
 			die(_("destination '%s' is not a directory"), dest_path[0]);
 		} else {
 			destination = dest_path;
+			/*
+			 * <destination> is a file outside of sparse-checkout
+			 * cone. Insist on cone mode here for backward
+			 * compatibility. We don't want dst_mode to be assigned
+			 * for a file when the repo is using no-cone mode (which
+			 * is deprecated at this point) sparse-checkout. As
+			 * SPARSE here is only considering cone-mode situation.
+			 */
+			if (!path_in_cone_mode_sparse_checkout(destination[0], &the_index))
+				dst_mode = SPARSE;
 		}
 	}
 	if (dst_w_slash != dest_path[0]) {
@@ -408,6 +420,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		const char *src = source[i], *dst = destination[i];
 		enum update_mode mode = modes[i];
 		int pos;
+		int sparse_and_dirty = 0;
 		struct checkout state = CHECKOUT_INIT;
 		state.istate = &the_index;
 
@@ -418,6 +431,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		if (show_only)
 			continue;
 		if (!(mode & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
+		    !(dst_mode & (SKIP_WORKTREE_DIR | SPARSE)) &&
 		    rename(src, dst) < 0) {
 			if (ignore_errors)
 				continue;
@@ -437,17 +451,55 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 
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
+			/*
+			 * NEEDSWORK: we are *not* paying attention to
+			 * "out-to-out" move (<source> is out-of-cone and
+			 * <destination> is out-of-cone) at this point. It
+			 * should be added in a future patch.
+			 */
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
+			} else if ((dst_mode & (SKIP_WORKTREE_DIR | SPARSE)) &&
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
 
@@ -459,6 +511,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		die(_("Unable to write new index file"));
 
 	string_list_clear(&src_for_dst, 0);
+	string_list_clear(&dirty_paths, 0);
 	UNLEAK(source);
 	UNLEAK(dest_path);
 	free(submodule_gitfile);
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index 1ac78edde6..d875f492dd 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -290,7 +290,7 @@ test_expect_success 'move sparse file to existing destination with --force and -
 	test_cmp expect sub/file1
 '
 
-test_expect_failure 'move clean path from in-cone to out-of-cone' '
+test_expect_success 'move clean path from in-cone to out-of-cone' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	setup_sparse_checkout &&
 
@@ -419,7 +419,7 @@ test_expect_failure 'move directory with one of the files overwrite' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'move dirty path from in-cone to out-of-cone' '
+test_expect_success 'move dirty path from in-cone to out-of-cone' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	setup_sparse_checkout &&
 	echo "modified" >>sub/d &&
@@ -439,7 +439,7 @@ test_expect_failure 'move dirty path from in-cone to out-of-cone' '
 	grep "H folder1/d" actual
 '
 
-test_expect_failure 'move dir from in-cone to out-of-cone' '
+test_expect_success 'move dir from in-cone to out-of-cone' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	setup_sparse_checkout &&
 
@@ -458,7 +458,7 @@ test_expect_failure 'move dir from in-cone to out-of-cone' '
 	grep "S folder1/dir/e" actual
 '
 
-test_expect_failure 'move partially-dirty dir from in-cone to out-of-cone' '
+test_expect_success 'move partially-dirty dir from in-cone to out-of-cone' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	setup_sparse_checkout &&
 	touch sub/dir/e2 sub/dir/e3 &&
-- 
2.37.0

