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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882ADC432C3
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 656F664FEA
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238247AbhCPP7V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 11:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbhCPP6v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 11:58:51 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A893C0613D9
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:47 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u16so10753748wrt.1
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UGly1PyfdY7NZkxrnN/w6B08c0BUdqmdUcZ1EchtmxQ=;
        b=V6JrZu15POl2a8+72R1BTkIA15U1XW/RnOZnvmR2kK4k9SOgOHWeL2n9tYfoRux6pt
         n2sonW4N6mtTK+vl03eD0RM3nT+ahGQixa7zblQp8exJWcapiDNWtjnl6Wzu6zoX3hzC
         mK82XF209Wwu2vQXfPAW4s/Jw+JIknw6wOSpvPYgbEu/QgxSEkwPI1/JWNBdyi1MzOV/
         cw9v3W8XLFjtDIxemFyeOx4so/G+uBZLFY13CyZaBf/6xXBJ6adjoVPtgfBW1UCwzeJh
         1b5GF9t6kUDvHSUA7T0FEWjhun6vWRe5oNA77Armp79sd89zrazwiVa4XR1bMU9O57gS
         Ul2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UGly1PyfdY7NZkxrnN/w6B08c0BUdqmdUcZ1EchtmxQ=;
        b=NM7PNKmAot8Dg20vOSsU+SO23sJCHy8Jqib68pFtTBFc4WVuWepJEuHiOK4C6Qv9Qj
         dYSFsgrGHlLH9lKL5x4d1oZ87/rPj7DL+9lKH2uLYN34zgVTmhNJyvqt4KDi1aDQ2UYP
         W6M9KxNsv+ztdKwiTTzkXLenNfWBjiu42zW3iTH6PVChx9dsXXRdWw7Ety51g8t2F/fA
         K8W6Z+SrePkmhIJMcVsM+wm/HcIbb65zhh5L6hi/6yEps1OReN5fYIgDDNXEpcTlR2NV
         XuVVv64Q9Z6IdVDc4qo372xZgO25UtVq1hfEYa1ZVkSViKqApEw7oH/bUQ2KSFfScVXW
         tgSw==
X-Gm-Message-State: AOAM531mhVjssdbaYOHtyYF3BaFuxuTQZtfa2TRXb+LFudpOWOYKEGlq
        b2z/Djb3JJ6Padk1T3S5j98vZX3QoNDQkw==
X-Google-Smtp-Source: ABdhPJxkGU3twNY/hbNMGD7RaKaGVHII5IVXkK6jwKho0Rl6oQeBHKwe/3/kqzBsdOv5yes8ZPgUBw==
X-Received: by 2002:a5d:5256:: with SMTP id k22mr5841123wrc.162.1615910325608;
        Tue, 16 Mar 2021 08:58:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m132sm3439060wmf.45.2021.03.16.08.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:58:44 -0700 (PDT)
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
Subject: [PATCH v3 09/32] cache.h: have base_name_compare() take "is tree?", not "mode"
Date:   Tue, 16 Mar 2021 16:58:06 +0100
Message-Id: <20210316155829.31242-10-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.256.gf0ddda3145
In-Reply-To: <20210316021312.13927-1-avarab@gmail.com>
References: <20210316021312.13927-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the base_name_compare() API and the related df_name_compare()
function to take a boolean argument indicating whether the entry is a
tree or not, instead of having them call S_ISDIR(mode) on their own.

This makes use of the new "object_type" field in the "name_entry".

The API being modified here was originally added way back in
958ba6c96eb (Introduce "base_name_compare()" helper function,
2005-05-20).

None of these comparison functions used to have tests, but with
preceding commits some of them now do. I thought the remainder was
trivial enough to review without tests, and didn't want to spend more
time on them.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fast-import.c | 12 ++++++++----
 builtin/mktree.c      |  4 ++--
 cache.h               |  4 ++--
 combine-diff.c        |  8 +++++---
 match-trees.c         |  6 ++++--
 merge-ort.c           |  4 ++--
 merge-recursive.c     |  6 +++---
 read-cache.c          | 16 ++++++++--------
 tree-diff.c           |  7 +++++--
 unpack-trees.c        | 15 ++++++++-------
 10 files changed, 47 insertions(+), 35 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index dd4d09cece..7a89510059 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1287,18 +1287,22 @@ static int tecmp0 (const void *_a, const void *_b)
 {
 	struct tree_entry *a = *((struct tree_entry**)_a);
 	struct tree_entry *b = *((struct tree_entry**)_b);
+	int istree_a = S_ISDIR(a->versions[0].mode);
+	int istree_b = S_ISDIR(b->versions[0].mode);
 	return base_name_compare(
-		a->name->str_dat, a->name->str_len, a->versions[0].mode,
-		b->name->str_dat, b->name->str_len, b->versions[0].mode);
+		a->name->str_dat, a->name->str_len, istree_a,
+		b->name->str_dat, b->name->str_len, istree_b);
 }
 
 static int tecmp1 (const void *_a, const void *_b)
 {
 	struct tree_entry *a = *((struct tree_entry**)_a);
 	struct tree_entry *b = *((struct tree_entry**)_b);
+	int istree_a = S_ISDIR(a->versions[1].mode);
+	int istree_b = S_ISDIR(b->versions[1].mode);
 	return base_name_compare(
-		a->name->str_dat, a->name->str_len, a->versions[1].mode,
-		b->name->str_dat, b->name->str_len, b->versions[1].mode);
+		a->name->str_dat, a->name->str_len, istree_a,
+		b->name->str_dat, b->name->str_len, istree_b);
 }
 
 static void mktree(struct tree_content *t, int v, struct strbuf *b)
diff --git a/builtin/mktree.c b/builtin/mktree.c
index 891991b00d..2c1973229a 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -37,8 +37,8 @@ static int ent_compare(const void *a_, const void *b_)
 {
 	struct treeent *a = *(struct treeent **)a_;
 	struct treeent *b = *(struct treeent **)b_;
-	return base_name_compare(a->name, a->len, a->mode,
-				 b->name, b->len, b->mode);
+	return base_name_compare(a->name, a->len, S_ISDIR(a->mode),
+				 b->name, b->len, S_ISDIR(b->mode));
 }
 
 static void write_tree(struct object_id *oid)
diff --git a/cache.h b/cache.h
index ae0c0bef5c..e38b1e1688 100644
--- a/cache.h
+++ b/cache.h
@@ -1506,8 +1506,8 @@ int repo_interpret_branch_name(struct repository *r,
 
 int validate_headref(const char *ref);
 
-int base_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
-int df_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
+int base_name_compare(const char *name1, int len1, int istree1, const char *name2, int len2, int istree2);
+int df_name_compare(const char *name1, int len1, int istree1, const char *name2, int len2, int istree2);
 int name_compare(const char *name1, size_t len1, const char *name2, size_t len2);
 int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2);
 
diff --git a/combine-diff.c b/combine-diff.c
index 9228aebc16..ad7058a6f5 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -16,11 +16,13 @@
 static int compare_paths(const struct combine_diff_path *one,
 			  const struct diff_filespec *two)
 {
-	if (!S_ISDIR(one->mode) && !S_ISDIR(two->mode))
+	int istree_one = S_ISDIR(one->mode);
+	int istree_two = S_ISDIR(two->mode);
+	if (!istree_one && !istree_two)
 		return strcmp(one->path, two->path);
 
-	return base_name_compare(one->path, strlen(one->path), one->mode,
-				 two->path, strlen(two->path), two->mode);
+	return base_name_compare(one->path, strlen(one->path), istree_one,
+				 two->path, strlen(two->path), istree_two);
 }
 
 static int filename_changed(char status)
diff --git a/match-trees.c b/match-trees.c
index 1011357ad0..a28c19a62a 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -67,8 +67,10 @@ static void *fill_tree_desc_strict(struct tree_desc *desc,
 static int base_name_entries_compare(const struct name_entry *a,
 				     const struct name_entry *b)
 {
-	return base_name_compare(a->path, tree_entry_len(a), a->mode,
-				 b->path, tree_entry_len(b), b->mode);
+	int istree_a = (a->object_type == OBJ_TREE);
+	int istree_b = (b->object_type == OBJ_TREE);
+	return base_name_compare(a->path, tree_entry_len(a), istree_a,
+				 b->path, tree_entry_len(b), istree_b);
 }
 
 /*
diff --git a/merge-ort.c b/merge-ort.c
index 603d30c521..4075d13aaa 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2390,8 +2390,8 @@ static int tree_entry_order(const void *a_, const void *b_)
 
 	const struct merged_info *ami = a->util;
 	const struct merged_info *bmi = b->util;
-	return base_name_compare(a->string, strlen(a->string), ami->result.mode,
-				 b->string, strlen(b->string), bmi->result.mode);
+	return base_name_compare(a->string, strlen(a->string), S_ISDIR(ami->result.mode),
+				 b->string, strlen(b->string), S_ISDIR(bmi->result.mode));
 }
 
 static void write_tree(struct object_id *result_oid,
diff --git a/merge-recursive.c b/merge-recursive.c
index 3d9207455b..1c9b08695a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -554,12 +554,12 @@ static int string_list_df_name_compare(const char *one, const char *two)
 	 *
 	 * To achieve this, we sort with df_name_compare and provide
 	 * the mode S_IFDIR so that D/F conflicts will sort correctly.
-	 * We use the mode S_IFDIR for everything else for simplicity,
+	 * We say we have a directory for everything else for simplicity,
 	 * since in other cases any changes in their order due to
 	 * sorting cause no problems for us.
 	 */
-	int cmp = df_name_compare(one, onelen, S_IFDIR,
-				  two, twolen, S_IFDIR);
+	int cmp = df_name_compare(one, onelen, 1, two, twolen, 1);
+
 	/*
 	 * Now that 'foo' and 'foo/bar' compare equal, we have to make sure
 	 * that 'foo' comes before 'foo/bar'.
diff --git a/read-cache.c b/read-cache.c
index 1e9a50c6c7..4257fbd8a0 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -462,8 +462,8 @@ int ie_modified(struct index_state *istate,
 	return 0;
 }
 
-int base_name_compare(const char *name1, int len1, int mode1,
-		      const char *name2, int len2, int mode2)
+int base_name_compare(const char *name1, int len1, int istree1,
+		      const char *name2, int len2, int istree2)
 {
 	unsigned char c1, c2;
 	int len = len1 < len2 ? len1 : len2;
@@ -474,9 +474,9 @@ int base_name_compare(const char *name1, int len1, int mode1,
 		return cmp;
 	c1 = name1[len];
 	c2 = name2[len];
-	if (!c1 && S_ISDIR(mode1))
+	if (!c1 && istree1)
 		c1 = '/';
-	if (!c2 && S_ISDIR(mode2))
+	if (!c2 && istree2)
 		c2 = '/';
 	return (c1 < c2) ? -1 : (c1 > c2) ? 1 : 0;
 }
@@ -491,8 +491,8 @@ int base_name_compare(const char *name1, int len1, int mode1,
  * This is used by routines that want to traverse the git namespace
  * but then handle conflicting entries together when possible.
  */
-int df_name_compare(const char *name1, int len1, int mode1,
-		    const char *name2, int len2, int mode2)
+int df_name_compare(const char *name1, int len1, int istree1,
+		    const char *name2, int len2, int istree2)
 {
 	int len = len1 < len2 ? len1 : len2, cmp;
 	unsigned char c1, c2;
@@ -504,10 +504,10 @@ int df_name_compare(const char *name1, int len1, int mode1,
 	if (len1 == len2)
 		return 0;
 	c1 = name1[len];
-	if (!c1 && S_ISDIR(mode1))
+	if (!c1 && istree1)
 		c1 = '/';
 	c2 = name2[len];
-	if (!c2 && S_ISDIR(mode2))
+	if (!c2 && istree2)
 		c2 = '/';
 	if (c1 == '/' && !c2)
 		return 0;
diff --git a/tree-diff.c b/tree-diff.c
index 7cebbb327e..6ec180331f 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -50,6 +50,7 @@ static int tree_entry_pathcmp(struct tree_desc *t1, struct tree_desc *t2)
 {
 	struct name_entry *e1, *e2;
 	int cmp;
+	int istree_e1, istree_e2;
 
 	/* empty descriptors sort after valid tree entries */
 	if (!t1->size)
@@ -58,9 +59,11 @@ static int tree_entry_pathcmp(struct tree_desc *t1, struct tree_desc *t2)
 		return -1;
 
 	e1 = &t1->entry;
+	istree_e1 = (e1->object_type == OBJ_TREE);
 	e2 = &t2->entry;
-	cmp = base_name_compare(e1->path, tree_entry_len(e1), e1->mode,
-				e2->path, tree_entry_len(e2), e2->mode);
+	istree_e2 = (e2->object_type == OBJ_TREE);
+	cmp = base_name_compare(e1->path, tree_entry_len(e1), istree_e1,
+				e2->path, tree_entry_len(e2), istree_e2);
 	return cmp;
 }
 
diff --git a/unpack-trees.c b/unpack-trees.c
index eb8fcda31b..d9d573df98 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -925,7 +925,7 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
 static int do_compare_entry_piecewise(const struct cache_entry *ce,
 				      const struct traverse_info *info,
 				      const char *name, size_t namelen,
-				      unsigned mode)
+				      unsigned istree)
 {
 	int pathlen, ce_len;
 	const char *ce_name;
@@ -933,7 +933,7 @@ static int do_compare_entry_piecewise(const struct cache_entry *ce,
 	if (info->prev) {
 		int cmp = do_compare_entry_piecewise(ce, info->prev,
 						     info->name, info->namelen,
-						     info->mode);
+						     S_ISDIR(info->mode));
 		if (cmp)
 			return cmp;
 	}
@@ -947,13 +947,13 @@ static int do_compare_entry_piecewise(const struct cache_entry *ce,
 	ce_len -= pathlen;
 	ce_name = ce->name + pathlen;
 
-	return df_name_compare(ce_name, ce_len, S_IFREG, name, namelen, mode);
+	return df_name_compare(ce_name, ce_len, 0, name, namelen, istree);
 }
 
 static int do_compare_entry(const struct cache_entry *ce,
 			    const struct traverse_info *info,
 			    const char *name, size_t namelen,
-			    unsigned mode)
+			    unsigned istree)
 {
 	int pathlen, ce_len;
 	const char *ce_name;
@@ -965,7 +965,7 @@ static int do_compare_entry(const struct cache_entry *ce,
 	 * it is quicker to use the precomputed version.
 	 */
 	if (!info->traverse_path)
-		return do_compare_entry_piecewise(ce, info, name, namelen, mode);
+		return do_compare_entry_piecewise(ce, info, name, namelen, istree);
 
 	cmp = strncmp(ce->name, info->traverse_path, info->pathlen);
 	if (cmp)
@@ -980,12 +980,13 @@ static int do_compare_entry(const struct cache_entry *ce,
 	ce_len -= pathlen;
 	ce_name = ce->name + pathlen;
 
-	return df_name_compare(ce_name, ce_len, S_IFREG, name, namelen, mode);
+	return df_name_compare(ce_name, ce_len, 0, name, namelen, istree);
 }
 
 static int compare_entry(const struct cache_entry *ce, const struct traverse_info *info, const struct name_entry *n)
 {
-	int cmp = do_compare_entry(ce, info, n->path, n->pathlen, n->mode);
+	int istree = (n->object_type == OBJ_TREE);
+	int cmp = do_compare_entry(ce, info, n->path, n->pathlen, istree);
 	if (cmp)
 		return cmp;
 
-- 
2.31.0.256.gf0ddda3145

