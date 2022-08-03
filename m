Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF73C19F2A
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 04:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbiHCEvr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 00:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbiHCEvq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 00:51:46 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F774A46D
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 21:51:44 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id f28so7218894pfk.1
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 21:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HLZKNiQZYFGGfDNhVw+EdBECChnMLUM6J/sEvCwyLBQ=;
        b=nzXD06BjryX6PQtJjq96PhPNl2VSAVfz/K74NGMODmZcXWlvHjv+RN9CcPAK2c6lDm
         imk55nNMM4QYp95Z6+bK9COfXqN46uAX1hLOysYf7oDsb5eu8WKFECmfSeJgY3expjTI
         h8lvg5dbN6HPUuhod61L5symSHGkfdl0YyKLq7AgFhB5a/0c6dh/Q+8QhWf4MY4H0fxa
         zpr6vsfK6QfSPaTAohg7Jsi/7l9vCH5cCWLzZi2RW/m6nH4t6qk73jJdfvpqpaaE7wX1
         Lnln014C7+ZrWfHa+JtS9AkCroRjifekojxf3cK+kZj7ATsB6kIUWZDlGrXeoZC9DRxL
         WOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HLZKNiQZYFGGfDNhVw+EdBECChnMLUM6J/sEvCwyLBQ=;
        b=tPgfa0Pq2D4I766/C95yEPLsEfMZuV9bM2JJ4Gs4Tp1iHn7e5AJ1KnJBQq6AATgJq5
         x/iDg46iWhjhwXObYkJzCaiZEIm4q+nBikns+OfVCCUrLhoSNb2xmq8/vOkpVltlMbxw
         s3Kj7PmVcShh27mbEfPs5h4v/MEwJN4WN9K6OgOLq+rwtQHw5v8uQbhs/Ik+3RHeE/zp
         x3k911g4veYaQ+CdrdSadoSW5GzM4zLfuLdsT1KU/ZFBtnRWXw/t9DhXrdVrCNL62lF5
         z+jdgVm0G81Dfu1FWYOYaDrkwbItm9j011E+rKC4Gvrp5AbJuDb2j7zLa5lEvTvMrLM5
         Y0Iw==
X-Gm-Message-State: AJIora+e9zj6fv5XtwyYGX5hIodvXYp5CP0QtN9UoQk/zx17s7pmChad
        og51V0msr2i32H1v7i6yEFWbDEf8vWOxPo16
X-Google-Smtp-Source: AGRyM1tHZA6NKaXFHEyFZYf1xiyIfbLMo1VTyiB3K56mKIGkix/dnySrmHyILychRDA/UUWRv5a6IQ==
X-Received: by 2002:a65:6d19:0:b0:41a:625e:7d7a with SMTP id bf25-20020a656d19000000b0041a625e7d7amr19159661pgb.506.1659502303657;
        Tue, 02 Aug 2022 21:51:43 -0700 (PDT)
Received: from ffyuanda.localdomain ([113.65.228.71])
        by smtp.gmail.com with ESMTPSA id f131-20020a623889000000b0052e2a1edab8sm470211pfa.24.2022.08.02.21.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 21:51:43 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v1 2/4] pathspec.h: move pathspec_needs_expanded_index() from reset.c to here
Date:   Wed,  3 Aug 2022 12:51:16 +0800
Message-Id: <20220803045118.1243087-3-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220803045118.1243087-1-shaoxuan.yuan02@gmail.com>
References: <20220803045118.1243087-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Method pathspec_needs_expanded_index() in reset.c from 4d1cfc1351
(reset: make --mixed sparse-aware, 2021-11-29) is reusable when we
need to verify if the index needs to be expanded when the command
is utilizing a pathspec rather than a literal path.

Move it to pathspec.h for reusability.

Add a few items to the function so it can better serve its purpose as
a standalone public function:

* Add a check in front so if the index is not sparse, return early since
  no expansion is needed.

* Add documentation to the function.

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/reset.c | 84 +---------------------------------------------
 pathspec.c      | 89 +++++++++++++++++++++++++++++++++++++++++++++++++
 pathspec.h      | 12 +++++++
 3 files changed, 102 insertions(+), 83 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 344fff8f3a..fdce6f8c85 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -174,88 +174,6 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 	}
 }
 
-static int pathspec_needs_expanded_index(const struct pathspec *pathspec)
-{
-	unsigned int i, pos;
-	int res = 0;
-	char *skip_worktree_seen = NULL;
-
-	/*
-	 * When using a magic pathspec, assume for the sake of simplicity that
-	 * the index needs to be expanded to match all matchable files.
-	 */
-	if (pathspec->magic)
-		return 1;
-
-	for (i = 0; i < pathspec->nr; i++) {
-		struct pathspec_item item = pathspec->items[i];
-
-		/*
-		 * If the pathspec item has a wildcard, the index should be expanded
-		 * if the pathspec has the possibility of matching a subset of entries inside
-		 * of a sparse directory (but not the entire directory).
-		 *
-		 * If the pathspec item is a literal path, the index only needs to be expanded
-		 * if a) the pathspec isn't in the sparse checkout cone (to make sure we don't
-		 * expand for in-cone files) and b) it doesn't match any sparse directories
-		 * (since we can reset whole sparse directories without expanding them).
-		 */
-		if (item.nowildcard_len < item.len) {
-			/*
-			 * Special case: if the pattern is a path inside the cone
-			 * followed by only wildcards, the pattern cannot match
-			 * partial sparse directories, so we know we don't need to
-			 * expand the index.
-			 *
-			 * Examples:
-			 * - in-cone/foo***: doesn't need expanded index
-			 * - not-in-cone/bar*: may need expanded index
-			 * - **.c: may need expanded index
-			 */
-			if (strspn(item.original + item.nowildcard_len, "*") == item.len - item.nowildcard_len &&
-			    path_in_cone_mode_sparse_checkout(item.original, &the_index))
-				continue;
-
-			for (pos = 0; pos < active_nr; pos++) {
-				struct cache_entry *ce = active_cache[pos];
-
-				if (!S_ISSPARSEDIR(ce->ce_mode))
-					continue;
-
-				/*
-				 * If the pre-wildcard length is longer than the sparse
-				 * directory name and the sparse directory is the first
-				 * component of the pathspec, need to expand the index.
-				 */
-				if (item.nowildcard_len > ce_namelen(ce) &&
-				    !strncmp(item.original, ce->name, ce_namelen(ce))) {
-					res = 1;
-					break;
-				}
-
-				/*
-				 * If the pre-wildcard length is shorter than the sparse
-				 * directory and the pathspec does not match the whole
-				 * directory, need to expand the index.
-				 */
-				if (!strncmp(item.original, ce->name, item.nowildcard_len) &&
-				    wildmatch(item.original, ce->name, 0)) {
-					res = 1;
-					break;
-				}
-			}
-		} else if (!path_in_cone_mode_sparse_checkout(item.original, &the_index) &&
-			   !matches_skip_worktree(pathspec, i, &skip_worktree_seen))
-			res = 1;
-
-		if (res > 0)
-			break;
-	}
-
-	free(skip_worktree_seen);
-	return res;
-}
-
 static int read_from_tree(const struct pathspec *pathspec,
 			  struct object_id *tree_oid,
 			  int intent_to_add)
@@ -273,7 +191,7 @@ static int read_from_tree(const struct pathspec *pathspec,
 	opt.change = diff_change;
 	opt.add_remove = diff_addremove;
 
-	if (pathspec->nr && the_index.sparse_index && pathspec_needs_expanded_index(pathspec))
+	if (pathspec->nr && pathspec_needs_expanded_index(&the_index, pathspec))
 		ensure_full_index(&the_index);
 
 	if (do_diff_cache(tree_oid, &opt))
diff --git a/pathspec.c b/pathspec.c
index 84ad9c73cf..46e77a85fe 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -759,3 +759,92 @@ int match_pathspec_attrs(struct index_state *istate,
 
 	return 1;
 }
+
+int pathspec_needs_expanded_index(struct index_state *istate,
+				  const struct pathspec *pathspec)
+{
+	unsigned int i, pos;
+	int res = 0;
+	char *skip_worktree_seen = NULL;
+
+	/*
+	 * If index is not sparse, no index expansion is needed.
+	 */
+	if (!istate->sparse_index)
+		return 0;
+
+	/*
+	 * When using a magic pathspec, assume for the sake of simplicity that
+	 * the index needs to be expanded to match all matchable files.
+	 */
+	if (pathspec->magic)
+		return 1;
+
+	for (i = 0; i < pathspec->nr; i++) {
+		struct pathspec_item item = pathspec->items[i];
+
+		/*
+		 * If the pathspec item has a wildcard, the index should be expanded
+		 * if the pathspec has the possibility of matching a subset of entries inside
+		 * of a sparse directory (but not the entire directory).
+		 *
+		 * If the pathspec item is a literal path, the index only needs to be expanded
+		 * if a) the pathspec isn't in the sparse checkout cone (to make sure we don't
+		 * expand for in-cone files) and b) it doesn't match any sparse directories
+		 * (since we can reset whole sparse directories without expanding them).
+		 */
+		if (item.nowildcard_len < item.len) {
+			/*
+			 * Special case: if the pattern is a path inside the cone
+			 * followed by only wildcards, the pattern cannot match
+			 * partial sparse directories, so we know we don't need to
+			 * expand the index.
+			 *
+			 * Examples:
+			 * - in-cone/foo***: doesn't need expanded index
+			 * - not-in-cone/bar*: may need expanded index
+			 * - **.c: may need expanded index
+			 */
+			if (strspn(item.original + item.nowildcard_len, "*") == item.len - item.nowildcard_len &&
+			    path_in_cone_mode_sparse_checkout(item.original, istate))
+				continue;
+
+			for (pos = 0; pos < istate->cache_nr; pos++) {
+				struct cache_entry *ce = istate->cache[pos];
+
+				if (!S_ISSPARSEDIR(ce->ce_mode))
+					continue;
+
+				/*
+				 * If the pre-wildcard length is longer than the sparse
+				 * directory name and the sparse directory is the first
+				 * component of the pathspec, need to expand the index.
+				 */
+				if (item.nowildcard_len > ce_namelen(ce) &&
+				    !strncmp(item.original, ce->name, ce_namelen(ce))) {
+					res = 1;
+					break;
+				}
+
+				/*
+				 * If the pre-wildcard length is shorter than the sparse
+				 * directory and the pathspec does not match the whole
+				 * directory, need to expand the index.
+				 */
+				if (!strncmp(item.original, ce->name, item.nowildcard_len) &&
+				    wildmatch(item.original, ce->name, 0)) {
+					res = 1;
+					break;
+				}
+			}
+		} else if (!path_in_cone_mode_sparse_checkout(item.original, istate) &&
+			   !matches_skip_worktree(pathspec, i, &skip_worktree_seen))
+			res = 1;
+
+		if (res > 0)
+			break;
+	}
+
+	free(skip_worktree_seen);
+	return res;
+}
diff --git a/pathspec.h b/pathspec.h
index 402ebb8080..41f6adfbb4 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -171,4 +171,16 @@ int match_pathspec_attrs(struct index_state *istate,
 			 const char *name, int namelen,
 			 const struct pathspec_item *item);
 
+/*
+ * Determine whether a pathspec will match only entire index entries (non-sparse
+ * files and/or entire sparse directories). If the pathspec has the potential to
+ * match partial contents of a sparse directory, return 1 to indicate the index
+ * should be expanded to match the  appropriate index entries.
+ *
+ * For the sake of simplicity, always return 1 if using a more complex "magic"
+ * pathspec.
+ */
+int pathspec_needs_expanded_index(struct index_state *istate,
+				  const struct pathspec *pathspec);
+
 #endif /* PATHSPEC_H */
-- 
2.37.0

