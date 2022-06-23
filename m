Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B09FC43334
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 11:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiFWLl6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 07:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiFWLlx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 07:41:53 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F087F4BFF6
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 04:41:49 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so2308494pjz.1
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 04:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ftgkv7iHtsvvAMKFX/nkifg/+bFRjLAh4IzF23ubEqk=;
        b=MY/RrkajiXvvxdIT38bpAc8sVM8nwiZ0MaUJSvmUv+XHyCI9BqFr/2ZWbSe2JBDNbw
         ACVPco35eP2pP7MrLmHkNMUESeO9z/hnnkv1JAPzJ/+xCanOUTk9bE3d5JataCPGhBh9
         y0eaVBdRrFbOx5yNwBGaFMB9585Pw5q9lY8lvFE8IF9hCw1VKcGozogK22r3K2eWcgYb
         1yoG1Vvzd+wx+UxqinEctKquDCnw33aZSVGcW3aO2AwANeL7AU27Rj8xctMfsC9nYCN6
         p0lGQ6yLf+PxvCsczFRWBIucTgutqH6iBiYAbOeEIEe0ibiTSedtVS14qgHA/Vh1Qjua
         bJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ftgkv7iHtsvvAMKFX/nkifg/+bFRjLAh4IzF23ubEqk=;
        b=MvHJbawZejIQUEPSvUZXentB/O1F/9KOm5l16iXmwe9N+lmI/WZSyd0x4TIb4H8J/p
         ruNv2d1DP1gCuk+jtdwzfhqWdcb3hxrsgyqJnF0acPUKFZPE9kKMNLpBsVK58KFMtoBs
         a2lzbkwvx87GNeNU79ifALyvrcuw9BtyCOI0xP6MEfknE3VIUZo6Y6x0u2nmmeZ95xXl
         oSF+RPrygcJ1Q8xeDF7DAFJAlnVC/jL2C9lbQuZ0IpPwoXtW+nD/QgVzBvMu48xG2cWt
         p6W8F6unNYQEc5mB/wiuJnyc0QVW4AjgMY0kGOg26nF7Q9/UqLbGp5PNppmNcgv3vZfk
         dYuw==
X-Gm-Message-State: AJIora+uAKF0e7oy0FhScho5El8hZqHpDkkXN7afmLsPrnw5ki9meDzT
        CUGHKCYQ0LDPnTm+Tme5/Bs=
X-Google-Smtp-Source: AGRyM1sH3QNCiwzT0VcpTmBRvJKc2TL51cwlgwYdetT5tNoRqSG9QjEaTQ76+FLU6vqxhyyYy0QANg==
X-Received: by 2002:a17:90a:c244:b0:1ec:d65f:e1c7 with SMTP id d4-20020a17090ac24400b001ecd65fe1c7mr3636792pjx.15.1655984509437;
        Thu, 23 Jun 2022 04:41:49 -0700 (PDT)
Received: from ffyuanda.localdomain ([112.195.146.236])
        by smtp.gmail.com with ESMTPSA id j7-20020a17090a7e8700b001ec4f258028sm1629299pjl.55.2022.06.23.04.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 04:41:49 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     shaoxuan.yuan02@gmail.com
Cc:     derrickstolee@github.com, git@vger.kernel.org, gitster@pobox.com,
        vdye@github.com
Subject: [PATCH v4 3/7] mv: decouple if/else-if checks using goto
Date:   Thu, 23 Jun 2022 19:41:16 +0800
Message-Id: <20220623114120.12768-4-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220623114120.12768-1-shaoxuan.yuan02@gmail.com>
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220623114120.12768-1-shaoxuan.yuan02@gmail.com>
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
index 0c0c2b4914..7f8d658028 100644
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

