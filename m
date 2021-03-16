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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405D7C4332E
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2569665101
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238417AbhCPQAZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236842AbhCPP7J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 11:59:09 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1C8C061764
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:59:07 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id c76-20020a1c9a4f0000b029010c94499aedso1780243wme.0
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eeEFiBh5xL1C6rQuAtyHEhaYP3o7rbvIu1GaZvOlh5M=;
        b=tS1Ufu9pk/mtES8qOVdDNAdvra8l1rjDy/4+REYRIQzsrOBp7wXIM/kv6u987YhFSN
         DeE+1jC3h+kDvVbAlBKIMnQLyZwuzksI7eRgAPvF4qVFZCITayOLBDeFVo6Uo367J57C
         6VeDsqAZfDY+ByPR0rw/nWDmkXxAhlCaZ1UdqCdMuE3bxMURSXGkK6tlb67cBhVj7HO2
         0MqxNHuQZKPJwdhsm+UKYXCH7AYUHC8QeYyDCefeiTAnJJh5sc94kL0815Kx77RNgIAj
         SmvAmp6mnqKcvF/wr+rMQbYmXdtEM4sdPSG2v1PQnJuvuEH9N05cACTzP2nJMo1pjLVO
         TiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eeEFiBh5xL1C6rQuAtyHEhaYP3o7rbvIu1GaZvOlh5M=;
        b=j0x01ad3ml6xblP4nLaEifofsDTwGcFwghnFazLrjEjtnaj+XAtOtQCa7DDieQwdpQ
         HGa9zSfG4J9dm1lFryaippPdWQ82tqpvUvNV1eiuKYfRxD14FnaOaqfHLkjlwTe0CdjF
         1SiKJwxZeq9GUMX+nk5lzjQsfwKTutHSQBIcnq9nFlV/PAoTqMQqQn738Tb2U5uK8yGq
         OUpLe46yjacpJZLoj9bOMqgvq0myNGKrXEDvKY4XKf1K6VahqAQwpzcqGN7N/Kw6ftZp
         qRhfd7OU8dsnxfV4em6Nbg7PyCzjfoPSxkzfZt0+gX4Ty5wXqYM/DvtEsxZfF8sdar2I
         Ehtg==
X-Gm-Message-State: AOAM5308nIHlR8zWrySj3e3VRrl9pzovbb1nZxVAk4Fw1ZgkKxrLBXjl
        DXHEv3hXVXgISx11ldTHqhzeC5wqjd/now==
X-Google-Smtp-Source: ABdhPJyffIP+3z25+Lz/jw0czLkqBQ1V5NBgtBQU30pIacKttZkhTOMvm+TTviCBnFM9ApDe2SYcVw==
X-Received: by 2002:a05:600c:2204:: with SMTP id z4mr313192wml.31.1615910346267;
        Tue, 16 Mar 2021 08:59:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m132sm3439060wmf.45.2021.03.16.08.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:59:05 -0700 (PDT)
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
Subject: [PATCH v3 32/32] tree-walk.h API: add a tree_entry_extract_type() function
Date:   Tue, 16 Mar 2021 16:58:29 +0100
Message-Id: <20210316155829.31242-33-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.256.gf0ddda3145
In-Reply-To: <20210316021312.13927-1-avarab@gmail.com>
References: <20210316021312.13927-1-avarab@gmail.com>
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
index 25bfb46fb0..89109659aa 100644
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
index 918ad95fa6..8409374f0b 100644
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
index efcd7ccd10..f5102ed542 100644
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
2.31.0.256.gf0ddda3145

