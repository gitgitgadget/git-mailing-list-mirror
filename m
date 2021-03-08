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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553A2C433E0
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BCDB6521F
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhCHPHz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 10:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbhCHPHe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 10:07:34 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87A6C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 07:07:33 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 124-20020a1c00820000b029010b871409cfso3998865wma.4
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 07:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KFeEOmsFZJPbSy/QcU7L4jdMb/+AWwLbq9RwsyCQvX8=;
        b=FP9YDo7DqMuAa6e5YRPnuUgbLZX2SA0KLoCPqoRB711eWpI2Cqy2RH2Vh9F2iyustH
         xNtg/s7A4Ulo6SVLyfM7W6XqaRcKINv9ESr4NgEx8LbI8Rzhg9s9TgFchC0/xQsc7pgF
         LrFREml+Pq3i6iMNlxhjXnJBWHp2LJdMBY8ZdOFD/42jGZ9mohfYGSMp8meDRcEJMay8
         Shk/H2mUgQsJHWB7Aco1NywxuJBjePR+jX0Ha5hCC3FhM09hLIotirUUSt4GAC6nk2eE
         43C29xhSKz1Vs8fYrxDbLhl1yd8cd0tReMzUznSy55kPf/mvsbEGzpE2HnAjDueqQBlt
         TNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KFeEOmsFZJPbSy/QcU7L4jdMb/+AWwLbq9RwsyCQvX8=;
        b=oa+EcCBTu11VRMIS/iCMqh4XYj8SoUfyL6v28/cBr5Mo9KOa9EUgLVQ1YEiyHe/v9R
         NDQTwk14SFTVN+P8RRSVNnOAJOmJDsUVwGLQEeLUYS0514RGRIpHTgUvCaeOBf9YjF9O
         bi4eM+GuP6HrTLCnpmt184vdUyN9I3boZ0WZsNWAyHdUNXqLTvM/JdgNkxVRixSUMFkQ
         cmgL0py53wZw82PDQL+bhAakA2YNyMkmNkpgQ0ndcszTFXdMNXm36xDb956ucnbntt1D
         6BilFlA9vwu1eSVhAJSfXMvW7R1IYNRcAJXo1nt9HrwLMN2UW8kCC+US504+1P37Hw09
         0CaA==
X-Gm-Message-State: AOAM532nK8pSI3ZBG2gRWnHDvJZL6ntQrQ0WLDEwf2V4ZD8xQj+hgwtK
        cdpSthPtHfFJI45IZNZF7qov86pf1g8N9A==
X-Google-Smtp-Source: ABdhPJx8jytEdIs+Qpsx2wue+KvFsAvH+xoMjCrzcmU59ZxQzOA5Hxap2zXthyibXY7Dle7T34cyFw==
X-Received: by 2002:a05:600c:2301:: with SMTP id 1mr23253533wmo.36.1615216052331;
        Mon, 08 Mar 2021 07:07:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j13sm3820488wrt.29.2021.03.08.07.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 07:07:31 -0800 (PST)
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
Subject: [PATCH 27/30] tree-walk.h API: add a tree_entry_extract_type() function
Date:   Mon,  8 Mar 2021 16:06:47 +0100
Message-Id: <20210308150650.18626-28-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
References: <20210308022138.28166-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add and use a tree_entry_extract_type() function. There were callers
of tree_entry_extract() which didn't care about the mode, but just the
type in the tree entry.

In emit_path() the "mode" variable was not used after the "isdir"
assignment, as can be seen in the diff with it being set to 0.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 match-trees.c | 12 ++++++------
 tree-diff.c   |  5 +++--
 tree-walk.h   | 11 +++++++++++
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/match-trees.c b/match-trees.c
index 3d2c74a44ac..0636f6e58e9 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -143,11 +143,11 @@ static void match_trees(const struct object_id *hash1,
 	while (one.size) {
 		const char *path;
 		const struct object_id *elem;
-		unsigned short mode;
+		enum object_type object_type;
 		int score;
 
-		elem = tree_entry_extract_mode(&one, &path, &mode);
-		if (!S_ISDIR(mode))
+		elem = tree_entry_extract_type(&one, &path, &object_type);
+		if (object_type != OBJ_TREE)
 			goto next;
 		score = score_trees(elem, hash2);
 		if (*best_score < score) {
@@ -198,14 +198,14 @@ static int splice_tree(const struct object_id *oid1, const char *prefix,
 
 	rewrite_here = NULL;
 	while (desc.size) {
+		enum object_type object_type;
 		const char *name;
-		unsigned short mode;
 		int len = tree_entry_len(&desc.entry);
 
-		tree_entry_extract_mode(&desc, &name, &mode);
+		tree_entry_extract_type(&desc, &name, &object_type);
 		if (len == toplen &&
 		    !memcmp(name, prefix, toplen)) {
-			if (!S_ISDIR(mode))
+			if (object_type != OBJ_TREE)
 				die("entry %s in tree %s is not a tree", name,
 				    oid_to_hex(oid1));
 
diff --git a/tree-diff.c b/tree-diff.c
index b25095c1164..10c92d39c42 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -208,10 +208,11 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 		 * 1) all modes for tp[i]=tp[imin] should be the same wrt
 		 *    S_ISDIR, thanks to base_name_compare().
 		 */
-		tree_entry_extract_mode(&tp[imin], &path, &mode);
+		enum object_type object_type;
+		tree_entry_extract_type(&tp[imin], &path, &object_type);
 		pathlen = tree_entry_len(&tp[imin].entry);
 
-		isdir = S_ISDIR(mode);
+		isdir = object_type == OBJ_TREE;
 		oid = NULL;
 		mode = 0;
 	}
diff --git a/tree-walk.h b/tree-walk.h
index 06ad40ab2f1..1f69e57db4c 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -47,6 +47,7 @@ struct tree_desc {
  * appropriate variable to fill in (NULL won't do!):
  *
  * tree_entry_extract_mode(): const char *path, unsigned int mode
+ * tree_entry_extract_type(): const char *path, enum object_type
  * tree_entry_extract_all(): const char *path, unsigned int mode, enum object_type
  */
 static inline const struct object_id *tree_entry_extract_mode(struct tree_desc *desc,
@@ -58,6 +59,16 @@ static inline const struct object_id *tree_entry_extract_mode(struct tree_desc *
 	return &desc->entry.oid;
 }
 
+static inline const struct object_id *tree_entry_extract_type(struct tree_desc *desc,
+							      const char **pathp,
+							      enum object_type *object_typep)
+{
+	*pathp = desc->entry.path;
+	*object_typep = desc->entry.object_type;
+	return &desc->entry.oid;
+}
+
+
 static inline const struct object_id *tree_entry_extract_all(struct tree_desc *desc,
 							     const char **pathp,
 							     unsigned short *modep,
-- 
2.31.0.rc0.126.g04f22c5b82

