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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8856C4160E
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2BB065239
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhCHPHx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 10:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbhCHPH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 10:07:29 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBC4C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 07:07:28 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id l12so11813138wry.2
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 07:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a5OeElF/8X9lUyQkP6jxwNcmAHpV4bwil/IYKEq2SJ8=;
        b=pRiRdsTS8DkNAKnhua1A+ZhfdfkBy0GaISBuT6qJCJ7GUcQEjG96LWO/HK5a3EZYHN
         ipUnlWHU3rQnqmLjNyZUotmc86SD9caCHmb6/XaCfaYV33gAkRBzYKBkT5K5OmmTSU5S
         czm56lMuBtXKafGGIEIdYh8g/XIOo5O+FbI8j29Jld5ziI5anqLXaM3B9JWsu8zEGBad
         jtPHk9uFMVvQiuwknmxk8UgNAqOoTBf+I8roVcs+pKry8thkODcA+6GHLlQLfXVO3TRB
         Pj/LyrGlt1zqwhPiuPhdw30ug0mX8H1YTxdNhTUQvxxYHehDWylaFZb2MdolU7eUFKDm
         j1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a5OeElF/8X9lUyQkP6jxwNcmAHpV4bwil/IYKEq2SJ8=;
        b=b/Bn3s/mQ3xzrLzA2QsA+WL5RTTJZwXHvbg1s3LBlTrqk/5H2KoncvPwuqc0UAdo7L
         y60Fxo+4sJBvTV1cMOQZj427UZtKqQmtfiNBwizId884Tu6Q6YUlLCG1OXWIazmORaJb
         glP6q8A/fbjBUw0niv8IhKkV+0nro2sdxgs4rJImJOjMrg5uq4m/SiPB1n253qeIET0U
         QS2izkK+OdeBWoZ/xTc8RS6hdLSQipuCMSL1HEbXHdRBdy0t2hbb3LfPCQ73Dydz1mxd
         nhF7OmI8+lt6uCcHhbhPOAkOAMz/Vr8rkFfSjGCjg+lkZpEqC1QinhHlBDjFAEmjR87z
         j/4g==
X-Gm-Message-State: AOAM533FX7ne+N9Y4OBtv3NIokcF2nh3hvfuD6xdyjyb8HRFp6zJms1Q
        fV/jdoQBu69Ir6FCS2Q5uIYyzgaFFl7GwQ==
X-Google-Smtp-Source: ABdhPJzju3Wu5Kr/ch2Za/GfI8x8ZYmfTpcWdX5l6qGQjgjG7CA9/zCCyGMj/2p02UoQR6cxsJlxtQ==
X-Received: by 2002:adf:b1c9:: with SMTP id r9mr23815888wra.51.1615216047340;
        Mon, 08 Mar 2021 07:07:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j13sm3820488wrt.29.2021.03.08.07.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 07:07:26 -0800 (PST)
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
Subject: [PATCH 22/30] tree-walk.h API: Add get_tree_entry_type()
Date:   Mon,  8 Mar 2021 16:06:42 +0100
Message-Id: <20210308150650.18626-23-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
References: <20210308022138.28166-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a get_tree_entry_type() helper function to compliment the existing
get_tree_entry(). Move those users of get_tree_entry_type() who didn't
care about the mode specifically, but just want to know whether the
tree entry is one of OBJ_{BLOB,COMMIT,TREE} over to it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 archive.c     |  8 ++++----
 blame.c       |  8 ++++----
 match-trees.c | 10 +++++-----
 tree-walk.c   | 47 ++++++++++++++++++++++++++++++++++++-----------
 tree-walk.h   | 15 +++++++++++++--
 5 files changed, 62 insertions(+), 26 deletions(-)

diff --git a/archive.c b/archive.c
index 95fa759e1fb..bc8f1c7546f 100644
--- a/archive.c
+++ b/archive.c
@@ -479,14 +479,14 @@ static void parse_treeish_arg(const char **argv,
 
 	if (prefix) {
 		struct object_id tree_oid;
-		unsigned short mode;
+		enum object_type object_type;
 		int err;
 
-		err = get_tree_entry_mode(ar_args->repo,
+		err = get_tree_entry_type(ar_args->repo,
 					  &tree->object.oid,
 					  prefix, &tree_oid,
-					  &mode);
-		if (err || !S_ISDIR(mode))
+					  &object_type);
+		if (err || object_type != OBJ_TREE)
 			die(_("current working directory is untracked"));
 
 		tree = parse_tree_indirect(&tree_oid);
diff --git a/blame.c b/blame.c
index 9e0543e13d4..4944582dc3c 100644
--- a/blame.c
+++ b/blame.c
@@ -101,11 +101,11 @@ static void verify_working_tree_path(struct repository *r,
 	for (parents = work_tree->parents; parents; parents = parents->next) {
 		const struct object_id *commit_oid = &parents->item->object.oid;
 		struct object_id blob_oid;
-		unsigned short mode;
-		int ret = get_tree_entry_mode(r, commit_oid, path, &blob_oid,
-					      &mode);
+		enum object_type object_type;
+		int ret = get_tree_entry_type(r, commit_oid, path, &blob_oid,
+					      &object_type);
 
-		if (!ret && oid_object_info(r, &blob_oid, NULL) == OBJ_BLOB)
+		if (!ret && object_type == OBJ_BLOB)
 			return;
 	}
 
diff --git a/match-trees.c b/match-trees.c
index 4f02768c01e..ce3f811ec04 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -317,17 +317,17 @@ void shift_tree_by(struct repository *r,
 		   const char *shift_prefix)
 {
 	struct object_id sub1, sub2;
-	unsigned short tmp;
+	enum object_type tmp;
 	unsigned candidate = 0;
 
 	/* Can hash2 be a tree at shift_prefix in tree hash1? */
-	if (!get_tree_entry_mode(r, hash1, shift_prefix, &sub1, &tmp) &&
-	    S_ISDIR(tmp))
+	if (!get_tree_entry_type(r, hash1, shift_prefix, &sub1, &tmp) &&
+	    tmp == OBJ_TREE)
 		candidate |= 1;
 
 	/* Can hash1 be a tree at shift_prefix in tree hash2? */
-	if (!get_tree_entry_mode(r, hash2, shift_prefix, &sub2, &tmp) &&
-	    S_ISDIR(tmp))
+	if (!get_tree_entry_type(r, hash2, shift_prefix, &sub2, &tmp) &&
+	    tmp == OBJ_TREE)
 		candidate |= 2;
 
 	if (candidate == 3) {
diff --git a/tree-walk.c b/tree-walk.c
index 7819ff3e0ec..0ad3d80593e 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -561,7 +561,8 @@ struct dir_state {
 
 static int find_tree_entry(struct repository *r, struct tree_desc *t,
 			   const char *name, struct object_id *result,
-			   unsigned short *mode)
+			   unsigned short *mode,
+			   enum object_type *object_type)
 {
 	int namelen = strlen(name);
 	while (t->size) {
@@ -585,23 +586,24 @@ static int find_tree_entry(struct repository *r, struct tree_desc *t,
 		}
 		if (name[entrylen] != '/')
 			continue;
-		if (!S_ISDIR(*mode))
+		if (*object_type != OBJ_TREE)
 			break;
 		if (++entrylen == namelen) {
 			oidcpy(result, &oid);
 			return 0;
 		}
-		return get_tree_entry_mode(r, &oid, name + entrylen, result,
-					   mode);
+		return get_tree_entry_all(r, &oid, name + entrylen, result,
+					  mode, object_type);
 	}
 	return -1;
 }
 
-int get_tree_entry_mode(struct repository *r,
-			const struct object_id *tree_oid,
-			const char *name,
-			struct object_id *oid,
-			unsigned short *mode)
+int get_tree_entry_all(struct repository *r,
+		       const struct object_id *tree_oid,
+		       const char *name,
+		       struct object_id *oid,
+		       unsigned short *mode,
+		       enum object_type *object_type)
 {
 	int retval;
 	void *tree;
@@ -624,12 +626,34 @@ int get_tree_entry_mode(struct repository *r,
 		struct tree_desc t;
 		init_tree_desc(&t, tree, size);
 		retval = find_tree_entry(r, &t, name, oid,
-					 mode);
+					 mode, object_type);
 	}
 	free(tree);
 	return retval;
 }
 
+int get_tree_entry_mode(struct repository *r,
+			const struct object_id *tree_oid,
+			const char *name,
+			struct object_id *oid,
+			unsigned short *mode)
+{
+	enum object_type object_type;
+	return get_tree_entry_all(r, tree_oid, name, oid,
+				  mode, &object_type);
+}
+
+int get_tree_entry_type(struct repository *r,
+			const struct object_id *tree_oid,
+			const char *name,
+			struct object_id *oid,
+			enum object_type *object_type)
+{
+	unsigned short mode;
+	return get_tree_entry_all(r, tree_oid, name, oid,
+				  &mode, object_type);
+}
+
 /*
  * This is Linux's built-in max for the number of symlinks to follow.
  * That limit, of course, does not affect git, but it's a reasonable
@@ -674,6 +698,7 @@ enum get_oid_result get_tree_entry_follow_symlinks(struct repository *r,
 		int find_result;
 		char *first_slash;
 		char *remainder = NULL;
+		enum object_type object_type;
 
 		if (!t.buffer) {
 			void *tree;
@@ -751,7 +776,7 @@ enum get_oid_result get_tree_entry_follow_symlinks(struct repository *r,
 		/* Look up the first (or only) path component in the tree. */
 		find_result = find_tree_entry(r, &t, namebuf.buf,
 					      &current_tree_oid,
-					      mode);
+					      mode, &object_type);
 		if (find_result) {
 			goto done;
 		}
diff --git a/tree-walk.h b/tree-walk.h
index eb9b9de6ccc..5db38fcb575 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -171,12 +171,23 @@ struct traverse_info {
  * Find an entry in a tree given a pathname and the sha1 of a tree to
  * search. Returns 0 if the entry is found and -1 otherwise.
  *
- * The third and fourth parameters are set to the entry's sha1 and
- * mode respectively.
+ * There are variants of this function depending on what fields in the
+ * "struct name_entry" you'd like. You always need to pointer to an
+ * appropriate variable to fill in (NULL won't do!):
+ *
+ * get_tree_entry_mode(): unsigned int mode
+ * get_tree_entry_type(): enum object_type
+ * get_tree_entry_all(): unsigned int mode, enum object_type
  */
 int get_tree_entry_mode(struct repository *, const struct object_id *, const char *,
 			struct object_id *,
 			unsigned short *);
+int get_tree_entry_type(struct repository *, const struct object_id *, const char *,
+			struct object_id *,
+			enum object_type *);
+int get_tree_entry_all(struct repository *, const struct object_id *, const char *,
+		       struct object_id *,
+		       unsigned short *, enum object_type *);
 
 /**
  * Generate the full pathname of a tree entry based from the root of the
-- 
2.31.0.rc0.126.g04f22c5b82

