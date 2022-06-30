Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628E9C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 02:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiF3CiJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 22:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbiF3CiB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 22:38:01 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBBB220F2
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 19:38:00 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id x1-20020a17090abc8100b001ec7f8a51f5so1441229pjr.0
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 19:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AhFqx2XWT2gzTkJUZnII+Ia+WoUDmYZrj/ggRcgtrVs=;
        b=KLkqxIr8Er+avEg8Jc2yonf/1fmeMRWMQ8M1Q4Fe6rTS0x/egh4IABwoeUj9qOvOh0
         hdX4j9rnRAU0P58InTgqNgJqKOh+KQ0tRx/btA6ZZ8AvkYFMuezV26Fm3ur9asVfBz4n
         GZHL4RVBGUd9nIgGiJ6hMZd9l/zonfuOrZgOcfOYT9fq1qlJk9qxFMpHwIGQ8Bam4W89
         cABc41MTFbd7Ud66X3xBn6J/Q4KXuOYyfAr52e9TJZFURpb/ggak1YJQ6Sn47oM+3wd2
         Bbvc7Ow2tmPvZ5l7MrJfq+9vjcAh/5wTDAnWfQGbIlk3twwdf7DKMTQqQjI3adqQWkSZ
         wKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AhFqx2XWT2gzTkJUZnII+Ia+WoUDmYZrj/ggRcgtrVs=;
        b=xlKcsBRUgpTw5y9npcbuSg0FsPZpRS8lc55508KaB0yTMlVlNkk24ijvDYl12jj+ZJ
         L3Qz7NJSuYVCC//MGYZbnOhi5NOvQIP4PgZbu651lIHTbDYpCV3nHGLdD8GPaETl8GLD
         Xlkl8IGLHr+YJ7CTbiqrSK1K5VSnEnVgM8QjMf9XKJK6ZSK+iQvG58MzRz61b8SdGrSL
         Q9mGcgKAY4bEMiiO2PBwWHEQ04xlLwf96wJGPVmr0VpsL8x9ru+wpgIuwvgow4lZaXhj
         iNjtQ4t/qgGcuMLb2gwzinHfKQRnsAg7RGZhT3LdAgEVFTuGdUQ0GZUCpGWUFyuYpGz9
         aJGw==
X-Gm-Message-State: AJIora9svv3gHstSO/MdJ+o7Qo58zv8AP6lqRnYty0foREcn+l4ukv7+
        R7CBXI9C80Eu3KvXuzgYKBcC12ROJiM=
X-Google-Smtp-Source: AGRyM1uRAVyleKAKqOzQ/4Ysu/MIsZ3EgVmm0M9gL7dpbF5bm3TS6RYPWepyfUR1swx7HUc2IdTW7g==
X-Received: by 2002:a17:902:db0c:b0:16a:52c3:9f72 with SMTP id m12-20020a170902db0c00b0016a52c39f72mr12329822plx.96.1656556679835;
        Wed, 29 Jun 2022 19:37:59 -0700 (PDT)
Received: from ffyuanda.localdomain ([101.206.226.29])
        by smtp.gmail.com with ESMTPSA id c16-20020a170902b69000b001678dcb4c5asm12157509pls.100.2022.06.29.19.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 19:37:58 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, vdye@github.com, gitster@pobox.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v5 4/8] mv: decouple if/else-if checks using goto
Date:   Thu, 30 Jun 2022 10:37:33 +0800
Message-Id: <20220630023737.473690-5-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220630023737.473690-1-shaoxuan.yuan02@gmail.com>
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220630023737.473690-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previous if/else-if chain are highly nested and hard to develop/extend.

Refactor to decouple this if/else-if chain by using goto to jump ahead.

Suggested-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/mv.c | 139 +++++++++++++++++++++++++++++----------------------
 1 file changed, 80 insertions(+), 59 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 5f4eeadd5d..e800da3ab8 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -187,53 +187,68 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		length = strlen(src);
 		if (lstat(src, &st) < 0) {
 			/* only error if existence is expected. */
-			if (modes[i] != SPARSE)
+			if (modes[i] != SPARSE) {
 				bad = _("bad source");
-		} else if (!strncmp(src, dst, length) &&
-				(dst[length] == 0 || dst[length] == '/')) {
+				goto act_on_entry;
+			}
+		}
+		if (!strncmp(src, dst, length) &&
+		    (dst[length] == 0 || dst[length] == '/')) {
 			bad = _("can not move directory into itself");
-		} else if ((src_is_dir = S_ISDIR(st.st_mode))
-				&& lstat(dst, &st) == 0)
+			goto act_on_entry;
+		}
+		if ((src_is_dir = S_ISDIR(st.st_mode))
+		    && lstat(dst, &st) == 0) {
 			bad = _("cannot move directory over file");
-		else if (src_is_dir) {
+			goto act_on_entry;
+		}
+		if (src_is_dir) {
+			int j, dst_len, n;
 			int first = cache_name_pos(src, length), last;
 
-			if (first >= 0)
+			if (first >= 0) {
 				prepare_move_submodule(src, first,
 						       submodule_gitfile + i);
-			else if (index_range_of_same_dir(src, length,
-							 &first, &last) < 1)
+				goto act_on_entry;
+			} else if (index_range_of_same_dir(src, length,
+							   &first, &last) < 1) {
 				bad = _("source directory is empty");
-			else { /* last - first >= 1 */
-				int j, dst_len, n;
-
-				modes[i] = WORKING_DIRECTORY;
-				n = argc + last - first;
-				REALLOC_ARRAY(source, n);
-				REALLOC_ARRAY(destination, n);
-				REALLOC_ARRAY(modes, n);
-				REALLOC_ARRAY(submodule_gitfile, n);
-
-				dst = add_slash(dst);
-				dst_len = strlen(dst);
-
-				for (j = 0; j < last - first; j++) {
-					const struct cache_entry *ce = active_cache[first + j];
-					const char *path = ce->name;
-					source[argc + j] = path;
-					destination[argc + j] =
-						prefix_path(dst, dst_len, path + length + 1);
-					modes[argc + j] = ce_skip_worktree(ce) ? SPARSE : INDEX;
-					submodule_gitfile[argc + j] = NULL;
-				}
-				argc += last - first;
+				goto act_on_entry;
 			}
-		} else if (!(ce = cache_file_exists(src, length, 0))) {
+
+			/* last - first >= 1 */
+			modes[i] = WORKING_DIRECTORY;
+			n = argc + last - first;
+			REALLOC_ARRAY(source, n);
+			REALLOC_ARRAY(destination, n);
+			REALLOC_ARRAY(modes, n);
+			REALLOC_ARRAY(submodule_gitfile, n);
+
+			dst = add_slash(dst);
+			dst_len = strlen(dst);
+
+			for (j = 0; j < last - first; j++) {
+				const struct cache_entry *ce = active_cache[first + j];
+				const char *path = ce->name;
+				source[argc + j] = path;
+				destination[argc + j] =
+					prefix_path(dst, dst_len, path + length + 1);
+				modes[argc + j] = ce_skip_worktree(ce) ? SPARSE : INDEX;
+				submodule_gitfile[argc + j] = NULL;
+			}
+			argc += last - first;
+			goto act_on_entry;
+		}
+		if (!(ce = cache_file_exists(src, length, 0))) {
 			bad = _("not under version control");
-		} else if (ce_stage(ce)) {
+			goto act_on_entry;
+		}
+		if (ce_stage(ce)) {
 			bad = _("conflicted");
-		} else if (lstat(dst, &st) == 0 &&
-			 (!ignore_case || strcasecmp(src, dst))) {
+			goto act_on_entry;
+		}
+		if (lstat(dst, &st) == 0 &&
+		    (!ignore_case || strcasecmp(src, dst))) {
 			bad = _("destination exists");
 			if (force) {
 				/*
@@ -247,34 +262,40 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				} else
 					bad = _("Cannot overwrite");
 			}
-		} else if (string_list_has_string(&src_for_dst, dst))
+			goto act_on_entry;
+		}
+		if (string_list_has_string(&src_for_dst, dst)) {
 			bad = _("multiple sources for the same target");
-		else if (is_dir_sep(dst[strlen(dst) - 1]))
+			goto act_on_entry;
+		}
+		if (is_dir_sep(dst[strlen(dst) - 1])) {
 			bad = _("destination directory does not exist");
-		else {
-			/*
-			 * We check if the paths are in the sparse-checkout
-			 * definition as a very final check, since that
-			 * allows us to point the user to the --sparse
-			 * option as a way to have a successful run.
-			 */
-			if (!ignore_sparse &&
-			    !path_in_sparse_checkout(src, &the_index)) {
-				string_list_append(&only_match_skip_worktree, src);
-				skip_sparse = 1;
-			}
-			if (!ignore_sparse &&
-			    !path_in_sparse_checkout(dst, &the_index)) {
-				string_list_append(&only_match_skip_worktree, dst);
-				skip_sparse = 1;
-			}
-
-			if (skip_sparse)
-				goto remove_entry;
+			goto act_on_entry;
+		}
 
-			string_list_insert(&src_for_dst, dst);
+		/*
+		 * We check if the paths are in the sparse-checkout
+		 * definition as a very final check, since that
+		 * allows us to point the user to the --sparse
+		 * option as a way to have a successful run.
+		 */
+		if (!ignore_sparse &&
+		    !path_in_sparse_checkout(src, &the_index)) {
+			string_list_append(&only_match_skip_worktree, src);
+			skip_sparse = 1;
+		}
+		if (!ignore_sparse &&
+		    !path_in_sparse_checkout(dst, &the_index)) {
+			string_list_append(&only_match_skip_worktree, dst);
+			skip_sparse = 1;
 		}
 
+		if (skip_sparse)
+			goto remove_entry;
+
+		string_list_insert(&src_for_dst, dst);
+
+act_on_entry:
 		if (!bad)
 			continue;
 		if (!ignore_errors)
-- 
2.35.1

