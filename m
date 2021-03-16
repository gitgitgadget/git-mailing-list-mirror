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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45C0C43331
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAC5F6502F
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbhCPCOY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 22:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbhCPCNw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 22:13:52 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FABDC06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:52 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so554815wmj.2
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=La7V05DB2vWNftwWY/zBzHh6GCUqGYH9OzhvmBmJZJw=;
        b=ORn8uvij7MDLgWQXPzVslbjeipqrWJTwA2raPGCahIcN61q9mX2iuVhLdZMPLnXcLD
         0+aa9MjaQs72xV+RyGDWl76WRl6VVQZ3OLy6MpJWdNhIohb+SUWz6VJRRfFSlxgLoAgH
         JzY9TgQ/fY6h4IUjvWJsnbiARzXatYZXA8ZDAaf6E8nBjsPlHvJjH4EBhj6c/NtpvXcN
         U/HrpTsVT2VqACHpqEbkVIID/m9a80gfAvSnUh1Fa09vYIMdIUK5t3ue/GZ4lxOEw58I
         5G6Op1jtIlrZQ3KLN6aCa2GaVEdXahT0vnyjYY7rO6YoejnncrypJe4TqZxRPHGlXm5T
         ++9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=La7V05DB2vWNftwWY/zBzHh6GCUqGYH9OzhvmBmJZJw=;
        b=Qk4BepagYbNfU31NVvWmw7aE8l/WzjHpA3/OTgJDEbhxosy/M0Fjyn3icEWSP8RVt5
         UcsmUQPl1wnKLgubrei2HQiau9xSV9GoiK+ezZHa2Aki2EQtowW8Qd7BvlnRgAygod68
         yg32TwjZTbminwopQJziuZWrdD4/9xDr7JOzoew2dTWt55U1nk0D5TW0q8Gabb5Lndug
         QIUpDKrHUq9uDJb6Ga1LFw3JVeLKUacq/G8W4RRbnwlWGGZJ7pWSMuWKekIo3+snMOpg
         px1z5DxN8ePCW+Ppcyfm4VjZX6Wo6dHMLfISWHCy3vellVVrYPbJReimXrrr5e/Nuw9h
         LOyw==
X-Gm-Message-State: AOAM530Pb1cWfN72RPT2n/3HpvmGEjzie/ZW6cUW/Xra2ZAzQsl09etb
        a9FxqBczJU/OawhDt/U9uHKtcpoo2PgGsg==
X-Google-Smtp-Source: ABdhPJykG80U4/Q2j4WjvpMxIBTihVhcppGGKIL+9tW1Eg/JghrB/kGyxjdEbzulQUYzv7YPfrZcxQ==
X-Received: by 2002:a05:600c:22c7:: with SMTP id 7mr2274052wmg.85.1615860830294;
        Mon, 15 Mar 2021 19:13:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i8sm21092494wrx.43.2021.03.15.19.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 19:13:49 -0700 (PDT)
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
Subject: [PATCH v2 22/29] tree-walk.h API: add get_tree_entry_type()
Date:   Tue, 16 Mar 2021 03:13:05 +0100
Message-Id: <20210316021312.13927-23-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.211.g1d0b8788b3
In-Reply-To: <20210308150650.18626-1-avarab@gmail.com>
References: <20210308150650.18626-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a get_tree_entry_type() helper function to compliment the existing
get_tree_entry(), and a static get_tree_entry_all() which it uses internally.

Move those users of get_tree_entry_type() who didn't care about the
mode specifically, but just want to know whether the tree entry is one
of OBJ_{BLOB,COMMIT,TREE} over to the new get_tree_entry_type().

The get_tree_entry_all() function itself will be made non-static in a
subsequent commit. I'm leaving its argument list indented accordingly
to reduce churn when I do so.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 archive.c     |  8 ++++----
 match-trees.c | 10 +++++-----
 tree-walk.c   | 54 ++++++++++++++++++++++++++++++++++++++++-----------
 tree-walk.h   | 11 +++++++++--
 4 files changed, 61 insertions(+), 22 deletions(-)

diff --git a/archive.c b/archive.c
index ab031079580..d6aef83b692 100644
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
diff --git a/match-trees.c b/match-trees.c
index e84f993a460..3177558313e 100644
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
index 7819ff3e0ec..46ce1ba8069 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -559,9 +559,17 @@ struct dir_state {
 	struct object_id oid;
 };
 
+static int get_tree_entry_all(struct repository *r,
+			      const struct object_id *tree_oid,
+			      const char *name,
+			      struct object_id *oid,
+			      unsigned short *mode,
+			      enum object_type *object_type);
+
 static int find_tree_entry(struct repository *r, struct tree_desc *t,
 			   const char *name, struct object_id *result,
-			   unsigned short *mode)
+			   unsigned short *mode,
+			   enum object_type *object_type)
 {
 	int namelen = strlen(name);
 	while (t->size) {
@@ -585,23 +593,24 @@ static int find_tree_entry(struct repository *r, struct tree_desc *t,
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
+static int get_tree_entry_all(struct repository *r,
+		       const struct object_id *tree_oid,
+		       const char *name,
+		       struct object_id *oid,
+		       unsigned short *mode,
+		       enum object_type *object_type)
 {
 	int retval;
 	void *tree;
@@ -624,12 +633,34 @@ int get_tree_entry_mode(struct repository *r,
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
@@ -674,6 +705,7 @@ enum get_oid_result get_tree_entry_follow_symlinks(struct repository *r,
 		int find_result;
 		char *first_slash;
 		char *remainder = NULL;
+		enum object_type object_type;
 
 		if (!t.buffer) {
 			void *tree;
@@ -751,7 +783,7 @@ enum get_oid_result get_tree_entry_follow_symlinks(struct repository *r,
 		/* Look up the first (or only) path component in the tree. */
 		find_result = find_tree_entry(r, &t, namebuf.buf,
 					      &current_tree_oid,
-					      mode);
+					      mode, &object_type);
 		if (find_result) {
 			goto done;
 		}
diff --git a/tree-walk.h b/tree-walk.h
index eb9b9de6ccc..f569960c6fb 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -171,12 +171,19 @@ struct traverse_info {
  * Find an entry in a tree given a pathname and the sha1 of a tree to
  * search. Returns 0 if the entry is found and -1 otherwise.
  *
- * The third and fourth parameters are set to the entry's sha1 and
- * mode respectively.
+ * There are variants of this function depending on what fields in the
+ * "struct name_entry" you'd like. You always need a pointer to an
+ * appropriate variable to fill in (NULL won't do!):
+ *
+ * get_tree_entry_mode(): unsigned int mode
+ * get_tree_entry_type(): enum object_type
  */
 int get_tree_entry_mode(struct repository *, const struct object_id *, const char *,
 			struct object_id *,
 			unsigned short *);
+int get_tree_entry_type(struct repository *, const struct object_id *, const char *,
+			struct object_id *,
+			enum object_type *);
 
 /**
  * Generate the full pathname of a tree entry based from the root of the
-- 
2.31.0.rc2.211.g1d0b8788b3

