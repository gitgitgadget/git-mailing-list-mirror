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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB428C4332B
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BD5D65025
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbhCPCNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 22:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhCPCNi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 22:13:38 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D654CC06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:37 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v15so9672728wrx.4
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+pRDdvQFgzHS7T+Ez5Q7zJSAOGevmUdSxWo3J7grkwU=;
        b=OAcYt1v/tUPYxeFWPsJKgrZnpkcciaVv7sxoAZGVjElyya6+rxcFLu0SRjJUM6Gg78
         zYqqDKDVp2aUm8ok4iBoy8HAnlwUVFcE9LUJnLMY2iMIJjqDez42AVLCzdeoVWNnMLbK
         TX6AI/iUU52dWO5mZLFnBj7Y7Utgt5e72bKRbp5gsuzcHqqN2P8WywWsPDnIjAFbVKcj
         2papGeZSgTnCJsdzR3n73+pRdX2QhYsrdaCAY9ip4EJ7dGVpFIR2vPniVE7E8H0pcCg+
         tE/oce9jMjSnbvTrbOdlojgOF4Lkx7EEDFluVzaBOvv9f4AcxZBngFdq8ir2IR7C9B2y
         eVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+pRDdvQFgzHS7T+Ez5Q7zJSAOGevmUdSxWo3J7grkwU=;
        b=jtF1p4h7/fjqpN79rLrIewR9GYFjNgEXhUSQ44IphjSm0eqonCAEoPLwYYREh2TKrh
         PDuYNxoH/cZ034Xqa/2SNOemHy/dpxPWuDM3QEr0xEKXs5LRAbeW0JDN1BiaQPkE8iEL
         EEIW5LQTl3zAgRc0rtW7QjBV4YYBJH0Ltp0IbEn3tzMxfdGNnsRfjDvKZiqmiEsa1KYn
         QwrBhPs0lXw8Cb1x2zT4rEBUN2kaIwBo/PtpkFDz/mqyE6uJXHUHUFcip29gATlCYIK3
         s0Bh5zkqrTXeNgFxGl0kb3SVULKoIks6vYo2n/+T39D3crs82/XIxe+q0mWrvQzRbXtI
         d5Kw==
X-Gm-Message-State: AOAM533o2i8nYTosbwGq9WGP7d3xgZ7frGfFLSKsS8vwh2BfuyJwK33t
        nqc5jTh7aVX5WnB5CGyU2Aqb8Cc3AIvG2Q==
X-Google-Smtp-Source: ABdhPJwpF4dYo00KETKjHJjnEJZ8KsQN/EDzqUj/xDxy7NFa2Z9YhO0auc1o3aQCqv6XpiNG+Eiwjg==
X-Received: by 2002:adf:ea8b:: with SMTP id s11mr2338009wrm.413.1615860816255;
        Mon, 15 Mar 2021 19:13:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i8sm21092494wrx.43.2021.03.15.19.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 19:13:35 -0700 (PDT)
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
Subject: [PATCH v2 06/29] cache.h: have base_name_compare() take "is tree?", not "mode"
Date:   Tue, 16 Mar 2021 03:12:49 +0100
Message-Id: <20210316021312.13927-7-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.211.g1d0b8788b3
In-Reply-To: <20210308150650.18626-1-avarab@gmail.com>
References: <20210308150650.18626-1-avarab@gmail.com>
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

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fast-import.c |  8 ++++----
 builtin/mktree.c      |  4 ++--
 cache.h               |  4 ++--
 combine-diff.c        |  8 +++++---
 match-trees.c         |  6 ++++--
 merge-ort.c           |  4 ++--
 merge-recursive.c     |  6 +++---
 read-cache.c          | 16 ++++++++--------
 tree-diff.c           |  7 +++++--
 unpack-trees.c        | 15 ++++++++-------
 10 files changed, 43 insertions(+), 35 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index dd4d09ceceb..ce4613c1595 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1288,8 +1288,8 @@ static int tecmp0 (const void *_a, const void *_b)
 	struct tree_entry *a = *((struct tree_entry**)_a);
 	struct tree_entry *b = *((struct tree_entry**)_b);
 	return base_name_compare(
-		a->name->str_dat, a->name->str_len, a->versions[0].mode,
-		b->name->str_dat, b->name->str_len, b->versions[0].mode);
+		a->name->str_dat, a->name->str_len, 1,
+		b->name->str_dat, b->name->str_len, 1);
 }
 
 static int tecmp1 (const void *_a, const void *_b)
@@ -1297,8 +1297,8 @@ static int tecmp1 (const void *_a, const void *_b)
 	struct tree_entry *a = *((struct tree_entry**)_a);
 	struct tree_entry *b = *((struct tree_entry**)_b);
 	return base_name_compare(
-		a->name->str_dat, a->name->str_len, a->versions[1].mode,
-		b->name->str_dat, b->name->str_len, b->versions[1].mode);
+		a->name->str_dat, a->name->str_len, 1,
+		b->name->str_dat, b->name->str_len, 1);
 }
 
 static void mktree(struct tree_content *t, int v, struct strbuf *b)
diff --git a/builtin/mktree.c b/builtin/mktree.c
index 891991b00d6..2c1973229ac 100644
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
index ae0c0bef5c2..e38b1e1688c 100644
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
index 9228aebc16b..ad7058a6f5d 100644
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
index 1011357ad0c..a28c19a62a5 100644
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
index 603d30c5217..4075d13aaab 100644
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
index 3d9207455b3..1c9b08695a3 100644
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
index 1e9a50c6c73..4257fbd8a08 100644
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
index 7cebbb327e2..6ec180331fb 100644
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
index eb8fcda31ba..d9d573df986 100644
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
2.31.0.rc2.211.g1d0b8788b3

