Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF545CCA47F
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 14:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238875AbiGSOKj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 10:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238887AbiGSOKO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 10:10:14 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD68664C3
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 06:29:05 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id q13-20020a17090a304d00b001f1af9a18a2so7241579pjl.5
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 06:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qVA8khSqd33XdWY34IuU/S0gTQ1wMFeJ33gIBC4cFig=;
        b=RgdpHvktMRzWpWP7zPZYyT9qXq+wbWsKeNdNNKv8qdkWV4lKx3uTEmtdKHRaBG5sAr
         xRdi6QoBST3eRui+VGyhpNuQDT/qs6s7H2dYuxIBmG950fJixCRIP829TZ4aXdcQh4o3
         zg6ofkVN+29CP8FlbhZDWksqXdiJxfX4CR23Lc7MTiDaWJJwDExrc4osWNGhrRkc/KLd
         Q9vkMM1gf4a3m0R+XM7Dn1KzPV7BEdMp0vlWn3XVgGhwL7UVZSMTMriv/PwnfI4XcjeZ
         I27fUATolvgYeJEss3VUuqsbvUWZmJbRBBA9jSMJDzaDiu1ondDF4gZOcEPC4dTGrgYp
         qIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qVA8khSqd33XdWY34IuU/S0gTQ1wMFeJ33gIBC4cFig=;
        b=wS4/Nqts7jOYS4/W8RM8W79Zfv1eRwsdt91wXQwMk0eP9lYBepvVvh5j4a2VDNAB6R
         dTdlB7/QwZM6Ovg8WVhHyRQA+UY57VWJEEaeottikWOmxk9Yi4iLxnLYHRXaTbAVAJ0I
         VXDNw9+ko6Guf3tP/ZJ09+F6ds79m341POMFBGrRKlwS7t4sRFboNTTIy33pJEFAWrqK
         IgaMJuhU3D+bWDeCPzkK8p+p9Ldp9I4exQJKerdSvGWz930gG7q7efR+WjLnZhz9vk/q
         twJUFnB/3kmwNTsOuu0ybdMKB4clL+144t1A7U263E1dFDsH3/5RzVtvP9SSMbDuqw4f
         /tMg==
X-Gm-Message-State: AJIora91ITSrJHk2cRFVC4jwKPXPlO20oSgBvohyJVWIu+uef80NgeDU
        ZJNzRe1me9rv40KK6YOcMOKsLRA6TqHXiR75
X-Google-Smtp-Source: AGRyM1tbQ0TYh96VVoeGI8Z5gkeXxfqbb6a4e5uA33D1dpr52XjZPfAVfRh7xhu4vJsVeX03x4RQ4w==
X-Received: by 2002:a17:902:f60c:b0:16d:1af0:6656 with SMTP id n12-20020a170902f60c00b0016d1af06656mr237287plg.153.1658237345129;
        Tue, 19 Jul 2022 06:29:05 -0700 (PDT)
Received: from ffyuanda.localdomain ([101.206.227.243])
        by smtp.gmail.com with ESMTPSA id r9-20020a170902be0900b0016be834d544sm624424pls.237.2022.07.19.06.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 06:29:04 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com, gitster@pobox.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v1 6/7] mv: from in-cone to out-of-cone
Date:   Tue, 19 Jul 2022 21:28:08 +0800
Message-Id: <20220719132809.409247-7-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
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
Instead advise user to "git add" this path and run "git sparse-checkout
reapply" to re-sparsify that path.

Helped-by: Victoria Dye <vdye@github.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 advice.c                      | 19 +++++++++++++
 advice.h                      |  1 +
 builtin/mv.c                  | 50 ++++++++++++++++++++++++++++++-----
 t/t7002-mv-sparse-checkout.sh |  8 +++---
 4 files changed, 67 insertions(+), 11 deletions(-)

diff --git a/advice.c b/advice.c
index 6fda9edbc2..fd18968943 100644
--- a/advice.c
+++ b/advice.c
@@ -261,3 +261,22 @@ void detach_advice(const char *new_name)
 
 	fprintf(stderr, fmt, new_name);
 }
+
+void advise_on_moving_dirty_path(struct string_list *pathspec_list)
+{
+	struct string_list_item *item;
+
+	if (!pathspec_list->nr)
+		return;
+
+	fprintf(stderr, _("The following paths have been moved outside the\n"
+			  "sparse-checkout definition but are not sparse due to local\n"
+			  "modifications.\n"));
+	for_each_string_list_item(item, pathspec_list)
+		fprintf(stderr, "%s\n", item->string);
+
+	advise_if_enabled(ADVICE_UPDATE_SPARSE_PATH,
+			  _("To correct the sparsity of these paths, do the following:\n"
+			    "* Use \"git add --sparse <paths>\" to update the index\n"
+			    "* Use \"git sparse-checkout reapply\" to apply the sparsity rules"));
+}
diff --git a/advice.h b/advice.h
index 7ddc6cbc1a..07e0f76833 100644
--- a/advice.h
+++ b/advice.h
@@ -74,5 +74,6 @@ void NORETURN die_conclude_merge(void);
 void NORETURN die_ff_impossible(void);
 void advise_on_updating_sparse_paths(struct string_list *pathspec_list);
 void detach_advice(const char *new_name);
+void advise_on_moving_dirty_path(struct string_list *pathspec_list);
 
 #endif /* ADVICE_H */
diff --git a/builtin/mv.c b/builtin/mv.c
index d05914a233..d35994c443 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -184,6 +184,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	struct lock_file lock_file = LOCK_INIT;
 	struct cache_entry *ce;
 	struct string_list only_match_skip_worktree = STRING_LIST_INIT_NODUP;
+	struct string_list dirty_paths = STRING_LIST_INIT_NODUP;
 
 	git_config(git_default_config, NULL);
 
@@ -414,6 +415,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		const char *src = source[i], *dst = destination[i];
 		enum update_mode mode = modes[i];
 		int pos;
+		int up_to_date = 0;
 		struct checkout state = CHECKOUT_INIT;
 		state.istate = &the_index;
 
@@ -424,6 +426,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		if (show_only)
 			continue;
 		if (!(mode & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
+		    !(dst_mode & SKIP_WORKTREE_DIR) &&
 		    rename(src, dst) < 0) {
 			if (ignore_errors)
 				continue;
@@ -443,20 +446,52 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 
 		pos = cache_name_pos(src, strlen(src));
 		assert(pos >= 0);
+		if (!(mode & SPARSE) && !lstat(src, &st))
+			up_to_date = !ce_modified(active_cache[pos], &st, 0);
 		rename_cache_entry_at(pos, dst);
 
-		if ((mode & SPARSE) &&
-		    (path_in_sparse_checkout(dst, &the_index))) {
-			int dst_pos;
+		if (ignore_sparse &&
+		    core_apply_sparse_checkout &&
+		    core_sparse_checkout_cone) {
 
-			dst_pos = cache_name_pos(dst, strlen(dst));
-			active_cache[dst_pos]->ce_flags &= ~CE_SKIP_WORKTREE;
+			/* from out-of-cone to in-cone */
+			if ((mode & SPARSE) &&
+			    path_in_sparse_checkout(dst, &the_index)) {
+				int dst_pos = cache_name_pos(dst, strlen(dst));
+				struct cache_entry *dst_ce = active_cache[dst_pos];
 
-			if (checkout_entry(active_cache[dst_pos], &state, NULL, NULL))
-				die(_("cannot checkout %s"), active_cache[dst_pos]->name);
+				dst_ce->ce_flags &= ~CE_SKIP_WORKTREE;
+
+				if (checkout_entry(dst_ce, &state, NULL, NULL))
+					die(_("cannot checkout %s"), dst_ce->name);
+				continue;
+			}
+
+			/* from in-cone to out-of-cone */
+			if ((dst_mode & SKIP_WORKTREE_DIR) &&
+			    !(mode & SPARSE) &&
+			    !path_in_sparse_checkout(dst, &the_index)) {
+				int dst_pos = cache_name_pos(dst, strlen(dst));
+				struct cache_entry *dst_ce = active_cache[dst_pos];
+				char *src_dir = dirname(xstrdup(src));
+
+				if (up_to_date) {
+					dst_ce->ce_flags |= CE_SKIP_WORKTREE;
+					unlink_or_warn(src);
+				} else {
+					string_list_append(&dirty_paths, dst);
+					safe_create_leading_directories(xstrdup(dst));
+					rename(src, dst);
+				}
+				if ((mode & INDEX) && is_empty_dir(src_dir))
+					rmdir_or_warn(src_dir);
+			}
 		}
 	}
 
+	if (dirty_paths.nr)
+		advise_on_moving_dirty_path(&dirty_paths);
+
 	if (gitmodules_modified)
 		stage_updated_gitmodules(&the_index);
 
@@ -465,6 +500,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		die(_("Unable to write new index file"));
 
 	string_list_clear(&src_for_dst, 0);
+	string_list_clear(&dirty_paths, 0);
 	UNLEAK(source);
 	UNLEAK(dest_path);
 	free(submodule_gitfile);
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index c27fcdbfd0..dafe15b9cf 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -303,7 +303,7 @@ test_expect_success 'move sparse file to existing destination with --force and -
 	test_cmp expect sub/file1
 '
 
-test_expect_failure 'move clean path from in-cone to out-of-cone' '
+test_expect_success 'move clean path from in-cone to out-of-cone' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	setup_sparse_checkout &&
 
@@ -356,7 +356,7 @@ test_expect_failure 'move clean path from in-cone to out-of-cone overwrite' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'move dirty path from in-cone to out-of-cone' '
+test_expect_success 'move dirty path from in-cone to out-of-cone' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	setup_sparse_checkout &&
 	echo "modified" >>sub/d &&
@@ -380,7 +380,7 @@ test_expect_failure 'move dirty path from in-cone to out-of-cone' '
 	grep -x "H folder1/d" actual
 '
 
-test_expect_failure 'move dir from in-cone to out-of-cone' '
+test_expect_success 'move dir from in-cone to out-of-cone' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	setup_sparse_checkout &&
 
@@ -400,7 +400,7 @@ test_expect_failure 'move dir from in-cone to out-of-cone' '
 	grep -x "S folder1/dir/e" actual
 '
 
-test_expect_failure 'move partially-dirty dir from in-cone to out-of-cone' '
+test_expect_success 'move partially-dirty dir from in-cone to out-of-cone' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	setup_sparse_checkout &&
 	touch sub/dir/e2 sub/dir/e3 &&
-- 
2.37.0

