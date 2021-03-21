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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC41C433F7
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DF9B61936
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhCUACU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 20:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhCUABi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 20:01:38 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9951BC061574
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:38 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id a132-20020a1c668a0000b029010f141fe7c2so7059794wmc.0
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vAgDRhhEA7Hx/tW2GL68h1c/JliDD3jfia5a3m3IN6Y=;
        b=TRv/1v8r2TOS8/vQH0mrjwXSHpzsbMU/n+gXfAYKvGJKcTjqU+lhM+VSGacrzaA6Cw
         tuqFP7RNE4IJwic3FgY26/2Kn+E56cPyJNN8/3tN3YjgAK+mOgVLG9CoCT2BO97qeFl0
         SY9SOxp0nvW0rCPDDHL+PhJMNKHgmM5Xh+9zzfFa7FXzMqqr2Nq29x/sIUJFdsz6T/dB
         axW3qYMgnE/3KQ//jrQNp0qI/7E8Eoem2E/NPQROUyfBWnaJ4/eQD4ElwvE8aFjg/0Nq
         5JA7sI7u27YLiY0GA/Rimph1/j6WUzrp0nuQGqQHvcltwNH9Wpda7uRRKzfeBwuMDLE2
         ToZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vAgDRhhEA7Hx/tW2GL68h1c/JliDD3jfia5a3m3IN6Y=;
        b=FLhmULRG0005l3nEjGGfN9Ida8dg9a6hIoZe6Zt+OvPUwNoFkyor0louDK131cCtO/
         MkOkfUL9whBvtrsqBBpgEgd6EAhS0mANoXihe3+yCoLchNEkgAqeTFlguHrasbKB/sla
         jvsP7SJmcXrcYWvZ/tjUfGZuNA7vn/ji1JECw1EI0DylxaX1TZ1uIWPDWhUZHCFalrVl
         9iexFS4UgT/pLLgGIrdHVDzAux6evKwy1wSp+2TWNz25BwpiHLgHI9fbYjZRz/zBQwRm
         0i9pfG1POBof4+N52odM1BGU4G//epxk8n8MZuG23k44MeLBHxjRKvkPVRMdbJyw2H9n
         /44Q==
X-Gm-Message-State: AOAM533o1oO8ntcXmr6LmWlaA04Fy66Ud8slxTv8O4aJb1v2CfloQBXz
        uTcIL5SQ7SuRCrNcuDWMdhpazdBQqIPRDg==
X-Google-Smtp-Source: ABdhPJwbB2GrRAiWIqMyhuGHLwqR7+JualVRartFA7UG00TbKbncPFkCi4kE054yG0pwwVwNJ01d6w==
X-Received: by 2002:a1c:1f4c:: with SMTP id f73mr9359441wmf.25.1616284897050;
        Sat, 20 Mar 2021 17:01:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g5sm15304834wrq.30.2021.03.20.17.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 17:01:36 -0700 (PDT)
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
Subject: [PATCH v4 14/29] tree-walk.h users: migrate miscellaneous "mode" to "object_type"
Date:   Sun, 21 Mar 2021 01:00:47 +0100
Message-Id: <21df7c668bedcd6e6008e783c2c6c1eb7cd13431.1616282534.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.282.gcc1ec606501
In-Reply-To: <cover.1616282533.git.avarab@gmail.com>
References: <20210316155829.31242-1-avarab@gmail.com> <cover.1616282533.git.avarab@gmail.com>
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
index ccd8d08f3dd..6349bbf59ee 100644
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
index 12fcbb3b8d4..6079d1d7935 100644
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
index add1f077131..c15a6829585 100644
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
index e2fec12a39e..8b03ace52bf 100644
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
index e6cb505fcb0..72b2cf5a741 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1300,7 +1300,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 	if (dirmask) {
 		/* special case: "diff-index --cached" looking at a tree */
 		if (o->diff_index_cached &&
-		    n == 1 && dirmask == 1 && S_ISDIR(names->mode)) {
+		    n == 1 && dirmask == 1 && names->object_type == OBJ_TREE) {
 			int matches;
 			matches = cache_tree_matches_traversal(o->src_index->cache_tree,
 							       names, info);
-- 
2.31.0.286.gc175f2cb894

