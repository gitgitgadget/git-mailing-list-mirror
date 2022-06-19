Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D59CC433EF
	for <git@archiver.kernel.org>; Sun, 19 Jun 2022 03:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbiFSD0Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jun 2022 23:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiFSD0N (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jun 2022 23:26:13 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF93B851
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 20:26:12 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id d14so3901495pjs.3
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 20:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=std8deXcUT2GcoWGie8OWc1yk48JfUU1UEQGV78jO/U=;
        b=mXh+6PIhcHEO12vrKBv/85O0bjo7g9QMEgpiBwJB+arNvEt+fzlsBTok16umflrvT4
         RRvQhi2HzkUhh/OLNP9NaYdEa3OzOXgZPsh69me/arx3Q68ebPaCJO0JDPLvSKl6ooa3
         WBn1phGXynwfe0tEEA9MxM35xaC2bQfvx79vgIqRD6JfoJkUGP4I3gxnfoekF8V+XdCB
         rAzNrChfaF7YZI4WhzoGSdsvplkXe6MI3WyshCmY8Emv8cl6yy+ExsX5YuLj6lwQhbZs
         PxE6NkGBUEbigNHlH7WHfsCSlNye+WKZSuy4WCGDlhjRnW1ssFuhXW/fMJ185RPchJ+4
         75yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=std8deXcUT2GcoWGie8OWc1yk48JfUU1UEQGV78jO/U=;
        b=cDyqTvBThfnP0ufHxhsnwc2XzxvN2tVGfI3eXT6IbacnMxd1Ii/sFZWn9YZsXhV1ec
         A68aCjuRpztSCnUsS2pNDy9Zf1m5rXsgHJHgf0dhkvvWfOyEdzTZx+GCVfG54qg0sfCU
         s91gXC6G7jd1DqsY87R7PU91K92XYcy0KLVZav/KgC9/x/Y5NpVvcW/iN2eqw14f+eXo
         SzIK5Mn+BrvVAi2GYQSPmzIQv7MMqU818XCsx+rbGWCG9LoEPATyDzbT5ir3duofwqwx
         HHFUmIh4VHKC0/SddB3n2kyfr0RWF/qYNnM41v+ifKxMH84myrVPeOug4uotWog9IlOW
         1caw==
X-Gm-Message-State: AJIora+J7miLLGxREhao/7AXxtGgYFSBVaUauvTiBEAocLLRF/B2P8/d
        fkS/7VyROuB362GQZCpHSYs=
X-Google-Smtp-Source: AGRyM1sPmblCWmOo6LrSZ8DG/a8yflv7hoRVRkGfagi9MZgmtqyiFxoJoo+aguzJAzY98n6OEdYXLQ==
X-Received: by 2002:a17:902:8f87:b0:166:3cf5:335f with SMTP id z7-20020a1709028f8700b001663cf5335fmr17110691plo.119.1655609171565;
        Sat, 18 Jun 2022 20:26:11 -0700 (PDT)
Received: from ffyuanda.localdomain ([112.195.147.33])
        by smtp.gmail.com with ESMTPSA id u1-20020a170903124100b0016188a4005asm5990650plh.122.2022.06.18.20.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 20:26:11 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     shaoxuan.yuan02@gmail.com
Cc:     derrickstolee@github.com, git@vger.kernel.org, gitster@pobox.com,
        vdye@github.com, newren@gmail.com
Subject: [WIP v3 2/7] mv: decouple if/else-if checks using goto
Date:   Sun, 19 Jun 2022 11:25:44 +0800
Message-Id: <20220619032549.156335-3-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220619032549.156335-1-shaoxuan.yuan02@gmail.com>
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220619032549.156335-1-shaoxuan.yuan02@gmail.com>
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
index 83a465ba83..1ca2c21da8 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -186,53 +186,68 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
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
@@ -246,34 +261,40 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
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

