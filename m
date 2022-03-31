Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30E8C433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 09:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbiCaJWM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 05:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbiCaJWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 05:22:09 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D8B149259
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 02:20:21 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id a16so5929435plh.13
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 02:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q0DaNskYbGCYt5zZU2NfxjM8erbDZCJr4CRuiuaPP4o=;
        b=oGrWmFlVbKbtxO+jSFzYJTaIPcVNw1bb8tqP8mN58JiTh2DDxjeWesvWCEJ/yFS3+2
         vETJzIDpNLggcOmgvEKnKcF4rdusHjcBVm8l2O00LdpEEhawD2Gtunyxe93nc3FIE0WG
         6rCK6yAQCygB/TDWRpwoet3LcIp6DegfKAQCHYLZeQlMnR14uVsmKhscccSXIJ2NK6uW
         oou1wEU9Boszjve2T/vrDjf7Vh4V7lVhnsvDR+CLcMN4Yd00V56mmuvRX1PkGHQ/VSJ3
         BasAg0i8C+Qy1BCGJlrTjjvObqwWwfE+IsKXyp5ayU+y0sWqwY/9j06gK/X+Dg5O/z+n
         VeSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q0DaNskYbGCYt5zZU2NfxjM8erbDZCJr4CRuiuaPP4o=;
        b=oT30ZJtEZ5xIK+CVjlndD53UVp/baL8xFab0gC3QMZd7Z+QcwGkTe3whUM9/HiPUzV
         2/kjvjQ/ZoU/TH2knvhdGPxS5cxLTtxyu0G12gAW69nDO3dqtyrbeCrPt9gybBHudJwt
         m7bcdbNqTb1KTFCi24+fAxLxw68g/nXu7MYSFNt3jLmuT+4fAu3suWTf85HEYg8OO1RN
         GrUSLM8/888l4c690JfWBvc65uVk5qMGEL2rKcYb/9ejZ9ZipepI2YUVu/W7nMDpcKYT
         SYlljYolYfGwRNSebnelpB+hcRo1rII4Lzr90fSu0vzF59LjjlLsh7qw+OP9n5ptHt+F
         NoIQ==
X-Gm-Message-State: AOAM530BcsHpnVu94QWcRQd5gDHT4sfQVjarKvIKh8pLOiI9L0exFhWf
        rd7RJLkg//2YhHXaIGRIH+0PApylYq0=
X-Google-Smtp-Source: ABdhPJz7LIg9Vs6NgYBnNM2Sr0aPGy8tJaFMMj2XGSq//M5/8LQ9glFhb5chHgZ8NHyB2+ZUzL3y2g==
X-Received: by 2002:a17:902:7c17:b0:154:a51a:d285 with SMTP id x23-20020a1709027c1700b00154a51ad285mr4362343pll.158.1648718421165;
        Thu, 31 Mar 2022 02:20:21 -0700 (PDT)
Received: from ffyuanda.localdomain ([119.131.153.75])
        by smtp.gmail.com with ESMTPSA id s3-20020a056a00194300b004f6664d26eesm27225931pfk.88.2022.03.31.02.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 02:20:20 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com, gitster@pobox.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [WIP v1 2/4] mv: add check_dir_in_index() and solve general dir check issue
Date:   Thu, 31 Mar 2022 17:17:53 +0800
Message-Id: <20220331091755.385961-3-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Originally, moving a <source> directory which is not on-disk due
to its existence outside of sparse-checkout cone, "giv mv" command
errors out with "bad source".

Add a helper check_dir_in_index() function to see if a directory
name exists in the index. Also add a SPARSE_DIRECTORY bit to mark
such directories.

Change the checking logic, so that such <source> directory makes
"giv mv" command warns with "advise_on_updating_sparse_paths()"
instead of "bad source"; also user now can supply a "--sparse" flag so
this operation can be carried out successfully.

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
Since I'm so new to C language (not an acquaintance until this patch), 
the "check_dir_in_index()" function I added might not be ideal (in terms of 
safety and correctness?). I have digging into the APIs provided in the codebase 
but I haven't found anything to do this very job: find out if a directory is 
in the index (am I missing something?). 
Probably because contents are stored in the index as blobs and 
they all represent regular files. So I came up with this dull solution...

 builtin/mv.c | 41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 32ad4d5682..9da9205e01 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -115,6 +115,25 @@ static int index_range_of_same_dir(const char *src, int length,
 	return last - first;
 }
 
+static int check_dir_in_index(const char *dir)
+{
+	int ret = 0;
+	int length = sizeof(dir) + 1;
+	char *substr = malloc(length);
+
+	for (int i = 0; i < the_index.cache_nr; i++) {
+		memcpy(substr, the_index.cache[i]->name, length);
+		memset(substr + length - 1, 0, 1);
+
+		if (strcmp(dir, substr) == 0) {
+			ret = 1;
+			return ret;
+		}
+	}
+	free(substr);
+	return ret;
+}
+
 int cmd_mv(int argc, const char **argv, const char *prefix)
 {
 	int i, flags, gitmodules_modified = 0;
@@ -129,7 +148,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 	const char **source, **destination, **dest_path, **submodule_gitfile;
-	enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX, SPARSE } *modes;
+	enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX, SPARSE,
+	SPARSE_DIRECTORY } *modes;
 	struct stat st;
 	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
 	struct lock_file lock_file = LOCK_INIT;
@@ -197,6 +217,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			 */
 
 			int pos = cache_name_pos(src, length);
+			const char *src_w_slash = add_slash(src);
+
 			if (pos >= 0) {
 				const struct cache_entry *ce = active_cache[pos];
 
@@ -209,6 +231,11 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				else
 					bad = _("bad source");
 			}
+			else if (check_dir_in_index(src_w_slash) &&
+			!path_in_sparse_checkout(src_w_slash, &the_index)) {
+				modes[i] = SPARSE_DIRECTORY;
+				goto dir_check;
+			}
 			/* only error if existence is expected. */
 			else if (modes[i] != SPARSE)
 				bad = _("bad source");
@@ -219,7 +246,9 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				&& lstat(dst, &st) == 0)
 			bad = _("cannot move directory over file");
 		else if (src_is_dir) {
-			int first = cache_name_pos(src, length), last;
+			int first, last;
+dir_check:
+			first = cache_name_pos(src, length);
 
 			if (first >= 0)
 				prepare_move_submodule(src, first,
@@ -230,7 +259,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			else { /* last - first >= 1 */
 				int j, dst_len, n;
 
-				modes[i] = WORKING_DIRECTORY;
+				if (!modes[i])
+					modes[i] = WORKING_DIRECTORY;
 				n = argc + last - first;
 				REALLOC_ARRAY(source, n);
 				REALLOC_ARRAY(destination, n);
@@ -332,7 +362,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			printf(_("Renaming %s to %s\n"), src, dst);
 		if (show_only)
 			continue;
-		if (mode != INDEX && mode != SPARSE && rename(src, dst) < 0) {
+		if (mode != INDEX && mode != SPARSE && mode != SPARSE_DIRECTORY &&
+		 rename(src, dst) < 0) {
 			if (ignore_errors)
 				continue;
 			die_errno(_("renaming '%s' failed"), src);
@@ -346,7 +377,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 							      1);
 		}
 
-		if (mode == WORKING_DIRECTORY)
+		if (mode == WORKING_DIRECTORY || mode == SPARSE_DIRECTORY)
 			continue;
 
 		pos = cache_name_pos(src, strlen(src));
-- 
2.35.1

