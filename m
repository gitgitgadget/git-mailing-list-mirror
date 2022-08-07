Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12305C19F2A
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 04:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbiHGEOL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Aug 2022 00:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiHGEN7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Aug 2022 00:13:59 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECF4EE18
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 21:13:58 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so6397070pjl.0
        for <git@vger.kernel.org>; Sat, 06 Aug 2022 21:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M80OBkqBbPP5TxkPa4NVySG9d6BNEtfyUuRLa0Heys8=;
        b=pGzhxYGB0tvpPU9Aovb3XWECig6B5rva68U9Gqz9BS1DrUpS8E7MxGOAscKZ9xOTRg
         AYkoi/6c/BLIdoAcih4TGJqz6QemJzdUWloN+peDI95jDEAqmV06dgXkLFTDyK4kpVxD
         FhBWYTC4p+USFJ/q6mMce+ozmvkjA5rUzVbrbdVjF23JLOJwCi58LLPZ1az/+GFssqXD
         P4D6KbSu/Qrd1Skk1KesOgNEO4cqwPCpPMeZLMPHEtaslZXGZocJYzgrfWPctCquD2lu
         LYwltsZwUsXPCcL3zJ8gDf8KlHHbc6E/i8VLY9xxb3atU9fqbAR6MbpXGO2wTv5K4vWA
         qmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M80OBkqBbPP5TxkPa4NVySG9d6BNEtfyUuRLa0Heys8=;
        b=Pwi+wpP97Nct2Rm2TcELZq0HSXIj7HwHCSqUGwk4/ACtGSuJvdZILWB55epv9y8MLu
         hS6Ryanr2D+fQSn9NnP4t5j/XCEbkGAjfdmSvBv0Ql1It6mCSLobFbxrf8esVkf0s+im
         /Zp1tds8u6il8r2t4VPeQDepoeGPSe+15TgGszLLe0/sAIjc1FWePTlnlty514fKppeo
         YTNn6L9rXzl/Fv7A1Y2EbI/IymZOKuZwOuWI+taU2go9RdY6hBzGdUBtJcxEOacnfHo6
         k0oqwzybmjVKb0wy4xL+vztVCQX7AdercnrmzWXMYk36G/Sa+XgVlb1t6QZqvA+sQWES
         1HkA==
X-Gm-Message-State: ACgBeo27UNEHZzdkHTyObYY8UZp39EZPy/6ffCTSnZzyCLXOEfR4pqlx
        NGPuwCfoX38kQxgb479RmN2ZwXx0W4cMyQ==
X-Google-Smtp-Source: AA6agR4HCimskbT0xBv0jlejjtAlZYb7N+rp0tYwvtOEAVMpKaCMMFV2t0jxFACu5jt0RDzVhM51aQ==
X-Received: by 2002:a17:903:120e:b0:16f:2e9:8c41 with SMTP id l14-20020a170903120e00b0016f02e98c41mr13560134plh.55.1659845637352;
        Sat, 06 Aug 2022 21:13:57 -0700 (PDT)
Received: from ffyuanda.localdomain ([113.65.209.111])
        by smtp.gmail.com with ESMTPSA id v22-20020a17090a0e1600b001f333fab3d6sm8057027pje.18.2022.08.06.21.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 21:13:57 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v2 2/4] pathspec.h: move pathspec_needs_expanded_index() from reset.c to here
Date:   Sun,  7 Aug 2022 12:13:33 +0800
Message-Id: <20220807041335.1790658-3-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220807041335.1790658-1-shaoxuan.yuan02@gmail.com>
References: <20220803045118.1243087-1-shaoxuan.yuan02@gmail.com>
 <20220807041335.1790658-1-shaoxuan.yuan02@gmail.com>
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

* It now takes an arbitrary 'struct index_state' pointer instead of
  using `the_index` and `active_cache`.

* Add documentation to the function.

Helped-by: Victoria Dye <vdye@github.com>
Helped-by: Derrick Stolee <derrickstolee@github.com>
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

