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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E2EC1550E
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C69B65239
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhCHPHz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 10:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhCHPHd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 10:07:33 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C22C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 07:07:32 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h98so11773468wrh.11
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 07:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gj0D29LoGXgZ+tn506ngmF7+nhvhhWboLN/+rqA0wBM=;
        b=JOEIC9/8MUY9eh5Ye5Lr5UdzsJpV/ofeMca5ij08z+jvTcj8Xfwa6Mph5FHTHgQJw4
         ZddI9sfd4g066pLiEGanrl5nYlV9ls97UNq6CMwluEFlJaPXc0tyVbEaFECUVbIg+m9T
         m70i1wEQS+uycT48JNQNsypYjGwh1Q/FkzGTH7gXF+EXzSjmzP3ahOzY1yKl6V6FDsk3
         bsUR3WryWpu315MkD1Q4huKy15UiQ7VNtqs10jTMFU37Dze8h8m6wD6dmpBz6kJ0ZcmA
         Epzjrt0r7zWNyvTcUWbunrX9Gzl0Qbvsewg9CVch6JC3Vz88fCksAD4To6XRxYqPetAO
         5gnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gj0D29LoGXgZ+tn506ngmF7+nhvhhWboLN/+rqA0wBM=;
        b=q99v5p6Le1S+Tqs0aYYEWK4yAVxheFDfWfvF0GGH1lrF7dwM3/iKF7RbbaMqbYtPgL
         FLoUEeN3Y4a3o01z52fITCqaauDZ9l270ZBtTTw8zIrEcIai1bdpwasenPRU7CEKsiOi
         HbRG0VsvnYf7nPEjce7MSnkFfiCaN7x6z8k8K6ipNuHEIbTJZqN6Kf3K9gVzkhaMhvdL
         3J0AGY8BGMkwqCy0hQaP40/cyY1++6qWQdzWwcNqG+izYehIrwmW0zd32VgK2EA8JnkL
         1bdUrWf9G4mSNUf+fANT0au37GDRz9eXdkOH6A0A+UgtPn0Uu76W56XyWDP8wM6BItJu
         pU1g==
X-Gm-Message-State: AOAM530F0PG04j99oR9JZHIPZHa+yHeNptpgRJF77uO+6IDFnh1po4Tk
        CIYyh+17yg90oX/SO0sgm1cj9p6t7o3KNA==
X-Google-Smtp-Source: ABdhPJxvDYt4JxkOS1QqdRm23d49cRJaaXnJcuIm3RNweHgUJbzq/b99x9D9mBA4SeNE7QoibWACGA==
X-Received: by 2002:a5d:64ac:: with SMTP id m12mr23016121wrp.138.1615216051471;
        Mon, 08 Mar 2021 07:07:31 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j13sm3820488wrt.29.2021.03.08.07.07.30
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
Subject: [PATCH 26/30] tree-walk.h API: add a tree_entry_extract_all() function
Date:   Mon,  8 Mar 2021 16:06:46 +0100
Message-Id: <20210308150650.18626-27-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
References: <20210308022138.28166-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a tree_entry_extract_all() sibling function to the existing
tree_entry_extract_mode().

Having the OBJ_{BLOB,TREE,COMMIT} when you have the "mode" is strictly
speaking redundant, but hopefully makes it easier to read the
code. We'll now see which parts of the code are checking the types,
v.s. those that care about the mode specifically.

Only the first use of tree_entry_extract_mode() in emit_path() is
converted here, the other branch will use a new
get_tree_entry_mode_type() introduced in a subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/update-index.c |  6 ++++--
 tree-diff.c            |  5 +++--
 tree-walk.c            |  3 ++-
 tree-walk.h            | 12 ++++++++++++
 4 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 070510d6a88..b489a876392 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -599,16 +599,18 @@ static struct cache_entry *read_one_ent(const char *which,
 					struct object_id *ent, const char *path,
 					int namelen, int stage)
 {
+	enum object_type object_type;
 	unsigned short mode;
 	struct object_id oid;
 	struct cache_entry *ce;
 
-	if (get_tree_entry_mode(the_repository, ent, path, &oid, &mode)) {
+	if (get_tree_entry_all(the_repository, ent, path, &oid,
+			       &mode, &object_type)) {
 		if (which)
 			error("%s: not in %s branch.", path, which);
 		return NULL;
 	}
-	if (mode == S_IFDIR) {
+	if (object_type == OBJ_TREE) {
 		if (which)
 			error("%s: not a blob in %s branch.", path, which);
 		return NULL;
diff --git a/tree-diff.c b/tree-diff.c
index b37348b7908..b25095c1164 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -195,10 +195,11 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 	assert(t || tp);
 
 	if (t) {
+		enum object_type object_type;
 		/* path present in resulting tree */
-		oid = tree_entry_extract_mode(t, &path, &mode);
+		oid = tree_entry_extract_all(t, &path, &mode, &object_type);
 		pathlen = tree_entry_len(&t->entry);
-		isdir = S_ISDIR(mode);
+		isdir = object_type == OBJ_TREE;
 	} else {
 		/*
 		 * a path was removed - take path from imin parent. Also take
diff --git a/tree-walk.c b/tree-walk.c
index e613f273767..12e0ed4e250 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -570,7 +570,8 @@ static int find_tree_entry(struct repository *r, struct tree_desc *t,
 		struct object_id oid;
 		int entrylen, cmp;
 
-		oidcpy(&oid, tree_entry_extract_mode(t, &entry, mode));
+		oidcpy(&oid, tree_entry_extract_all(t, &entry, mode, object_type));
+
 		entrylen = tree_entry_len(&t->entry);
 		update_tree_entry(t);
 		if (entrylen > namelen)
diff --git a/tree-walk.h b/tree-walk.h
index 892e77eda23..06ad40ab2f1 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -47,6 +47,7 @@ struct tree_desc {
  * appropriate variable to fill in (NULL won't do!):
  *
  * tree_entry_extract_mode(): const char *path, unsigned int mode
+ * tree_entry_extract_all(): const char *path, unsigned int mode, enum object_type
  */
 static inline const struct object_id *tree_entry_extract_mode(struct tree_desc *desc,
 							      const char **pathp,
@@ -57,6 +58,17 @@ static inline const struct object_id *tree_entry_extract_mode(struct tree_desc *
 	return &desc->entry.oid;
 }
 
+static inline const struct object_id *tree_entry_extract_all(struct tree_desc *desc,
+							     const char **pathp,
+							     unsigned short *modep,
+							     enum object_type *object_typep)
+{
+	*pathp = desc->entry.path;
+	*modep = desc->entry.mode;
+	*object_typep = desc->entry.object_type;
+	return &desc->entry.oid;
+}
+
 /**
  * Calculate the length of a tree entry's pathname. This utilizes the
  * memory structure of a tree entry to avoid the overhead of using a
-- 
2.31.0.rc0.126.g04f22c5b82

