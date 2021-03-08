Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B7DC4361A
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3821E6522D
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhCHPHu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 10:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbhCHPHV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 10:07:21 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6432BC06175F
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 07:07:21 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id j2so11800266wrx.9
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 07:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FvEwz2r/CLCKi13PL9PYfULIdNAqi1HXN58Jits22SI=;
        b=o1LFb9MOYe6oGIy6fW9zkTN2it6a5PnoHhVYw9Gfn93LygV/n2XeexMO7vDFGgjsF6
         Hx1sshegjd/qAgAefS30fvE4SD/hTt8pZSoomRxaPr3YW2TitIh2/bVL0gh+vFQ1wzD3
         pqkxS2G07XUjN2kg1rDXjAIiiABD1fZKk+T8DufeG3wGEaHLFaEci6ALLyRF+izWDmOf
         xkCAfiqDHcFNZUNrQgIwsRaloAywLR+LbspK8mfh/qZgKt/qSMFuOURdDYov90ndUkKf
         m6YO8rV3s1Cj+vyUhABL+21+iAFR6dd2O2tRFeQXLYcaUH+YRcglYHJx+T/ZXKCREbnV
         FZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FvEwz2r/CLCKi13PL9PYfULIdNAqi1HXN58Jits22SI=;
        b=Vw90OUuv4EFPe6z2SR0xrJRM1pwTDhBKpuX571TNnCwoc4/UfUn8qfhtj400k/HtKD
         DQc6Uq06MG7AdJJKqvzX3fp4LpxDzwgEAUEuOdanirtk5XUM310VtUgnzzGmyP9OEOW/
         PM8ndXZvyoiqgIHeHF6snOPLJXVMykkzEeuRWEHQPRId7YISoORuZi5dkCEoHaj65S6N
         BnW6zMFn/IBeu66xkPh8mBhqnBSCljetmE64sHpazVbuEL6hww4j/NAUKYVJKHqEvFaS
         qWwG4nEHwVoQWm/bc/4aLrPiz/Li5zJD3h/p/zbSuQuJvdYySii633ZK44vNt5ufPACU
         eRkA==
X-Gm-Message-State: AOAM5312JbV4zCzKGiPJriybsW/rxUhnRtz44kD/rr0ovEKXu8zjebFK
        UrWnZOkkmPjN1z2LHC8fMK9HFW5oiMpaRQ==
X-Google-Smtp-Source: ABdhPJz2H2Lugpb9PGayn1AGfauLWQ1qlw0xc5hiJZFejYPN4fGLX2bQcxArcQcaKJvHDdevRJNwzA==
X-Received: by 2002:a05:6000:11c1:: with SMTP id i1mr13216781wrx.215.1615216039801;
        Mon, 08 Mar 2021 07:07:19 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j13sm3820488wrt.29.2021.03.08.07.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 07:07:19 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 14/30] tree-walk.h users: migrate miscellaneous "mode" to "object_type"
Date:   Mon,  8 Mar 2021 16:06:34 +0100
Message-Id: <20210308150650.18626-15-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
References: <20210308022138.28166-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor more users of the "entry.mode" field to use the new
"entry.object_type" field.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c         | 6 +++---
 builtin/merge-tree.c   | 9 +++++----
 builtin/pack-objects.c | 4 ++--
 builtin/reflog.c       | 3 ++-
 cache-tree.c           | 2 +-
 delta-islands.c        | 2 +-
 notes.c                | 4 ++--
 unpack-trees.c         | 2 +-
 8 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 4e91a253ac3..5a317cdd2f4 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -587,10 +587,10 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 
 		strbuf_add(base, entry.path, te_len);
 
-		if (S_ISREG(entry.mode)) {
+		if (entry.object_type == OBJ_BLOB) {
 			hit |= grep_oid(opt, &entry.oid, base->buf, tn_len,
 					 check_attr ? base->buf + tn_len : NULL);
-		} else if (S_ISDIR(entry.mode)) {
+		} else if (entry.object_type == OBJ_TREE) {
 			enum object_type type;
 			struct tree_desc sub;
 			void *data;
@@ -606,7 +606,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 			hit |= grep_tree(opt, pathspec, &sub, base, tn_len,
 					 check_attr);
 			free(data);
-		} else if (recurse_submodules && S_ISGITLINK(entry.mode)) {
+		} else if (recurse_submodules && entry.object_type == OBJ_COMMIT) {
 			hit |= grep_submodule(opt, pathspec, &entry.oid,
 					      base->buf, base->buf + tn_len,
 					      1); /* ignored */
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 2de34c2d485..12cb317c1ba 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -275,11 +275,11 @@ static void unresolved(const struct traverse_info *info, struct name_entry n[3])
 	if (dirmask == mask)
 		return;
 
-	if (n[2].mode && !S_ISDIR(n[2].mode))
+	if (n[2].object_type != OBJ_TREE)
 		entry = link_entry(3, info, n + 2, entry);
-	if (n[1].mode && !S_ISDIR(n[1].mode))
+	if (n[1].object_type != OBJ_TREE)
 		entry = link_entry(2, info, n + 1, entry);
-	if (n[0].mode && !S_ISDIR(n[0].mode))
+	if (n[0].object_type != OBJ_TREE)
 		entry = link_entry(1, info, n + 0, entry);
 
 	add_merge_entry(entry);
@@ -324,7 +324,8 @@ static int threeway_callback(int n, unsigned long mask, unsigned long dirmask, s
 	}
 
 	if (same_entry(entry+0, entry+1)) {
-		if (!is_null_oid(&entry[2].oid) && !S_ISDIR(entry[2].mode)) {
+		if (!is_null_oid(&entry[2].oid) &&
+		    entry[2].object_type != OBJ_TREE) {
 			/* We did not touch, they modified -- take theirs */
 			resolve(info, entry+1, entry+2);
 			return mask;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d3ba1d4a4a6..f92722c12d4 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1524,7 +1524,7 @@ static void add_pbase_object(struct tree_desc *tree,
 	int cmp;
 
 	while (tree_entry(tree,&entry)) {
-		if (S_ISGITLINK(entry.mode))
+		if (entry.object_type == OBJ_COMMIT)
 			continue;
 		cmp = tree_entry_len(&entry) != cmplen ? 1 :
 		      memcmp(name, entry.path, cmplen);
@@ -1538,7 +1538,7 @@ static void add_pbase_object(struct tree_desc *tree,
 					 fullname, 1);
 			return;
 		}
-		if (S_ISDIR(entry.mode)) {
+		if (entry.object_type == OBJ_TREE) {
 			struct tree_desc sub;
 			struct pbase_tree_cache *tree;
 			const char *down = name+cmplen+1;
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 09541d1c804..bcbca82aa90 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -95,7 +95,8 @@ static int tree_is_complete(const struct object_id *oid)
 	complete = 1;
 	while (tree_entry(&desc, &entry)) {
 		if (!has_object_file(&entry.oid) ||
-		    (S_ISDIR(entry.mode) && !tree_is_complete(&entry.oid))) {
+		    (entry.object_type == OBJ_TREE &&
+		     !tree_is_complete(&entry.oid))) {
 			tree->object.flags |= INCOMPLETE;
 			complete = 0;
 		}
diff --git a/cache-tree.c b/cache-tree.c
index 2fb483d3c08..fbe93dd2a5f 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -726,7 +726,7 @@ static void prime_cache_tree_rec(struct repository *r,
 	init_tree_desc(&desc, tree->buffer, tree->size);
 	cnt = 0;
 	while (tree_entry(&desc, &entry)) {
-		if (!S_ISDIR(entry.mode))
+		if (entry.object_type != OBJ_TREE)
 			cnt++;
 		else {
 			struct cache_tree_sub *sub;
diff --git a/delta-islands.c b/delta-islands.c
index aa98b2e5414..e7cf93acbe3 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -293,7 +293,7 @@ void resolve_tree_islands(struct repository *r,
 		while (tree_entry(&desc, &entry)) {
 			struct object *obj;
 
-			if (S_ISGITLINK(entry.mode))
+			if (entry.object_type == OBJ_COMMIT)
 				continue;
 
 			obj = lookup_object(r, &entry.oid);
diff --git a/notes.c b/notes.c
index 0a5b4fa1dbb..d631dc5623e 100644
--- a/notes.c
+++ b/notes.c
@@ -418,7 +418,7 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 		if (path_len == 2 * (hashsz - prefix_len)) {
 			/* This is potentially the remainder of the SHA-1 */
 
-			if (!S_ISREG(entry.mode))
+			if (entry.object_type != OBJ_BLOB)
 				/* notes must be blobs */
 				goto handle_non_note;
 
@@ -431,7 +431,7 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 			/* This is potentially an internal node */
 			size_t len = prefix_len;
 
-			if (!S_ISDIR(entry.mode))
+			if (entry.object_type != OBJ_TREE)
 				/* internal nodes must be trees */
 				goto handle_non_note;
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 92105135522..e24302f45ba 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1297,7 +1297,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 	if (dirmask) {
 		/* special case: "diff-index --cached" looking at a tree */
 		if (o->diff_index_cached &&
-		    n == 1 && dirmask == 1 && S_ISDIR(names->mode)) {
+		    n == 1 && dirmask == 1 && names->object_type == OBJ_TREE) {
 			int matches;
 			matches = cache_tree_matches_traversal(o->src_index->cache_tree,
 							       names, info);
-- 
2.31.0.rc0.126.g04f22c5b82

