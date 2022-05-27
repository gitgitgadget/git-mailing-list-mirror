Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA98C433EF
	for <git@archiver.kernel.org>; Fri, 27 May 2022 10:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350824AbiE0KIe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 06:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242503AbiE0KI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 06:08:29 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A9D1269B6
        for <git@vger.kernel.org>; Fri, 27 May 2022 03:08:27 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so3946827pjq.2
        for <git@vger.kernel.org>; Fri, 27 May 2022 03:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QZmjuihcNWWsGDxDuSUPfFBIdSba7nNQKjNBUFU+wsI=;
        b=cdlTVJwKmQnUa6PuWdeBckhg1MAkRvOVsC9ZI+tOyv9tHuhQ0Zfc8ZNOMY2N2pZvTF
         bwtRM1uO8PgHiD629tZ2PO4Ds4LU6y71zUMJLiLZnkzIyWB9/M/ppdMCRMbAtnX3PDSV
         1IIqoiG2auSPSL9SJ+YwYak/1bvRCX2qRBf5HCQHcD1sZNzOhm3v4wN3i6an847zv81u
         DlLC8PWw2nsaAb3jlJ1gBKGi7kh2U0TJW2FKFl0RGtfomqe+C2QPEuAYa+N/A2B7tgGu
         FebjDkeQx/+beP64l64sYw2TQINU/CnVtWS6KQgtTrVEDElq/r4BwmPXgF1Ya3kpJEJq
         Bwmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QZmjuihcNWWsGDxDuSUPfFBIdSba7nNQKjNBUFU+wsI=;
        b=eNAcZCZ6cj/VsgOuiFhCbKlk9UHAZHHoPkyZoytDSZWH2vHVHemT9gng6pHmBZNVQY
         VODNkVADmsrU6TITxAwbEC8w5pQdoPU95PSp28uEEWc7BpYCMXYLKH6EWcwSsKKwfQZl
         /B7K/QWXN76925CmLtIbaFCTajK+H4whlP7f2va4QmIf5MkSzoB52H+2k4E6XduML6P8
         7HJkM37kqtnBpZVoQ0Kb6h4NVi8sN9jcOayk09YB3BZeQtGVB5es4rXMbCMSZMKxQH7P
         tpeEn9Fo8EYRc/4T7i/ad9ErN7h/SMUlRQjTgXyolTNwtkq9Qh4qPrjN7PShPvweLAPh
         KPtA==
X-Gm-Message-State: AOAM531UT/RVvBCCzLROoskqwmGXb1E1D6lbhrwHvbWPDupPsRk9ZFHG
        g1sPXt5N8Lz5KpdfWmlqdcValBWNERJflg==
X-Google-Smtp-Source: ABdhPJwmj4Du6DPTmQ4ApjR4sHVoVUXPRiHvNwT7nquvIccc2B/MtiFek07vsuQt/SEmuJFG/0NQPw==
X-Received: by 2002:a17:902:ef45:b0:156:1858:71fc with SMTP id e5-20020a170902ef4500b00156185871fcmr41507950plx.23.1653646106860;
        Fri, 27 May 2022 03:08:26 -0700 (PDT)
Received: from ffyuanda.localdomain ([119.131.142.42])
        by smtp.gmail.com with ESMTPSA id p26-20020a056a0026da00b005184640c939sm2994262pfw.207.2022.05.27.03.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 03:08:26 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com, gitster@pobox.com,
        newren@gmail.com, Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [WIP v2 4/5] mv: add check_dir_in_index() and solve general dir check issue
Date:   Fri, 27 May 2022 18:08:03 +0800
Message-Id: <20220527100804.209890-5-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220527100804.209890-1-shaoxuan.yuan02@gmail.com>
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220527100804.209890-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Originally, moving a <source> directory which is not on-disk due
to its existence outside of sparse-checkout cone, "giv mv" command
errors out with "bad source".

Add a helper check_dir_in_index() function to see if a directory
name exists in the index. Also add a SKIP_WORKTREE_DIR bit to mark
such directories.

Change the checking logic, so that such <source> directory makes
"giv mv" command warns with "advise_on_updating_sparse_paths()"
instead of "bad source"; also user now can supply a "--sparse" flag so
this operation can be carried out successfully.

Also, as suggested by Derrick [1],
move the in-line definition of "enum update_mode" to the top
of the file and make it use "flags" mode (each state is a different
bit in the word).

[1] https://lore.kernel.org/git/22aadea2-9330-aa9e-7b6a-834585189144@github.com/

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/mv.c                  | 60 ++++++++++++++++++++++++++++++++---
 t/t7002-mv-sparse-checkout.sh |  4 +--
 2 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 62284e3f86..e64f251a69 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -19,6 +19,14 @@ static const char * const builtin_mv_usage[] = {
 	NULL
 };
 
+enum update_mode {
+	BOTH = 0,
+	WORKING_DIRECTORY = (1 << 1),
+	INDEX = (1 << 2),
+	SPARSE = (1 << 3),
+	SKIP_WORKTREE_DIR = (1 << 4),
+};
+
 #define DUP_BASENAME 1
 #define KEEP_TRAILING_SLASH 2
 
@@ -115,6 +123,37 @@ static int index_range_of_same_dir(const char *src, int length,
 	return last - first;
 }
 
+/*
+ * Check if an out-of-cone directory should be in the index. Imagine this case
+ * that all the files under a directory are marked with 'CE_SKIP_WORKTREE' bit
+ * and thus the directory is sparsified.
+ *
+ * Return 0 if such directory exist (i.e. with any of its contained files not
+ * marked with CE_SKIP_WORKTREE, the directory would be present in working tree).
+ * Return 1 otherwise.
+ */
+static int check_dir_in_index(const char *name, int namelen)
+{
+	int ret = 1;
+	const char *with_slash = add_slash(name);
+	int length = namelen + 1;
+
+	int pos = cache_name_pos(with_slash, length);
+	const struct cache_entry *ce;
+
+	if (pos < 0) {
+		pos = -pos - 1;
+		if (pos >= the_index.cache_nr)
+			return ret;
+		ce = active_cache[pos];
+		if (strncmp(with_slash, ce->name, length))
+			return ret;
+		if (ce_skip_worktree(ce))
+			return ret = 0;
+	}
+	return ret;
+}
+
 int cmd_mv(int argc, const char **argv, const char *prefix)
 {
 	int i, flags, gitmodules_modified = 0;
@@ -129,7 +168,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 	const char **source, **destination, **dest_path, **submodule_gitfile;
-	enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX, SPARSE } *modes;
+	enum update_mode *modes;
 	struct stat st;
 	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
 	struct lock_file lock_file = LOCK_INIT;
@@ -187,6 +226,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		if (lstat(src, &st) < 0) {
 
 			int pos = cache_name_pos(src, length);
+			const char *src_w_slash = add_slash(src);
+
 			if (pos >= 0) {
 				const struct cache_entry *ce = active_cache[pos];
 
@@ -208,6 +249,11 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				else
 					bad = _("bad source");
 			}
+			else if (!check_dir_in_index(src, length) &&
+					 !path_in_sparse_checkout(src_w_slash, &the_index)) {
+				modes[i] = SKIP_WORKTREE_DIR;
+				goto dir_check;
+			}
 			/* only error if existence is expected. */
 			else if (modes[i] != SPARSE)
 				bad = _("bad source");
@@ -218,7 +264,9 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				&& lstat(dst, &st) == 0)
 			bad = _("cannot move directory over file");
 		else if (src_is_dir) {
-			int first = cache_name_pos(src, length), last;
+			int first, last;
+dir_check:
+			first = cache_name_pos(src, length);
 
 			if (first >= 0)
 				prepare_move_submodule(src, first,
@@ -229,7 +277,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			else { /* last - first >= 1 */
 				int j, dst_len, n;
 
-				modes[i] = WORKING_DIRECTORY;
+				if (!modes[i])
+					modes[i] |= WORKING_DIRECTORY;
 				n = argc + last - first;
 				REALLOC_ARRAY(source, n);
 				REALLOC_ARRAY(destination, n);
@@ -331,7 +380,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			printf(_("Renaming %s to %s\n"), src, dst);
 		if (show_only)
 			continue;
-		if (mode != INDEX && mode != SPARSE && rename(src, dst) < 0) {
+		if (!(mode & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
+		 	rename(src, dst) < 0) {
 			if (ignore_errors)
 				continue;
 			die_errno(_("renaming '%s' failed"), src);
@@ -345,7 +395,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 							      1);
 		}
 
-		if (mode == WORKING_DIRECTORY)
+		if (mode & (WORKING_DIRECTORY | SKIP_WORKTREE_DIR))
 			continue;
 
 		pos = cache_name_pos(src, strlen(src));
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index 2c9008573a..cf2f5dc46f 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -206,7 +206,7 @@ test_expect_success 'refuse to move file to non-skip-worktree sparse path' '
 	test_cmp expect stderr
 '
 
-test_expect_failure 'refuse to move out-of-cone directory without --sparse' '
+test_expect_success 'refuse to move out-of-cone directory without --sparse' '
 	git sparse-checkout disable &&
 	git reset --hard &&
 	mkdir folder1 &&
@@ -222,7 +222,7 @@ test_expect_failure 'refuse to move out-of-cone directory without --sparse' '
 	test_cmp expect stderr
 '
 
-test_expect_failure 'can move out-of-cone directory with --sparse' '
+test_expect_success 'can move out-of-cone directory with --sparse' '
 	git sparse-checkout disable &&
 	git reset --hard &&
 	mkdir folder1 &&
-- 
2.35.1

