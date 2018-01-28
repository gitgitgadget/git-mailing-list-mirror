Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FD0A1F404
	for <e@80x24.org>; Sun, 28 Jan 2018 00:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753241AbeA1ANr (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jan 2018 19:13:47 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34412 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752878AbeA1ANf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jan 2018 19:13:35 -0500
Received: by mail-lf0-f66.google.com with SMTP id k19so5062027lfj.1
        for <git@vger.kernel.org>; Sat, 27 Jan 2018 16:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=66NSRlPsXci4wHFv/dWXrjaICU+bcYQXBJquavTqGxk=;
        b=mAzlXZfk/wUGGeIxfsi9hOwI2J818dgdVDYVmSLCMIcBLNY77+bUVH1x4tcZ7A+iH6
         eMANriIYTQgZOeDgsVfsahA+2zlkUIPD4/Fk6GU9Kndr2I69ASzV4Eu/bBZ/9e47d6AH
         cE6CwwZ/Sm8f028easHwCsbJKIm+UlQU/9oPYiNtQNiosw5NPP83CApm3U6b/nLB8N/R
         wME6Pe/0jUakRRnpU5JdwEe65JUgAr18Z5kzKR2XzgJGAnXdD0XJlFpfnO1QywPG14gA
         AkgySxOKS7652qHR8FsWjiBUwiotcvILMLYuMa6U4VG3du0Ms3A0AI87ok39K0chVUr6
         bCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=66NSRlPsXci4wHFv/dWXrjaICU+bcYQXBJquavTqGxk=;
        b=Czl0csnxg54ajK4+bThQccNDHJ00YavzlnwR/9KM+kUiEcNRib0t4GsO6Z8WuG3mV+
         ssIBooaJkiiUQ3HDcrOu7ZkbRxz6bSDiV0iIrzff2rxHB+QO1eIHYdLmONhjySChDCNe
         z5CWMS92OhofFmiB6AajFXX2J+ppGx/e5BhEuN6q+1GM7uJ2JY79gnJM54EhQvtQFGJN
         7pR2Q84qflbVLSQyyEFtC5Qh7S16ENA4TT8/rDm9FRH/9ktZp3r/XkdAuRh8QsfHG+hq
         l4xEqM0X3ti/GKJkuj5qSctJjXKOIkKnT8/Lkwmlnegu9Lc70NXaOCLyzO4bb6ojoMOr
         2Kcg==
X-Gm-Message-State: AKwxytfdkqk41JSZSm2nqfgsgLCVpnpCR0UURplUB/dGndC4740c+tKT
        ug7+89qSyE5+0xu4HX42OLJFq413
X-Google-Smtp-Source: AH8x227dJ/+tvEady4vdzhJVpfdYLr9HMWShPonGcZwvzvt9dtgo51f6qpidHKDbNVxzTaCgHUYr1Q==
X-Received: by 10.25.28.82 with SMTP id c79mr10283115lfc.44.1517098413694;
        Sat, 27 Jan 2018 16:13:33 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id y26sm2144695lfk.30.2018.01.27.16.13.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Jan 2018 16:13:32 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 07/12] notes: convert combine_notes_* to object_id
Date:   Sun, 28 Jan 2018 01:13:17 +0100
Message-Id: <3840cc87d45e774603a98f3789a96070b8001b1f.1517097306.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1517097306.git.patryk.obara@gmail.com>
References: <cover.1516790478.git.patryk.obara@gmail.com>
 <cover.1517097306.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1517097306.git.patryk.obara@gmail.com>
References: <cover.1517097306.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the definition and declarations of combine_notes_* functions
to struct object_id and adjust usage of these functions.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 notes.c | 46 +++++++++++++++++++++++-----------------------
 notes.h | 25 +++++++++++++++----------
 2 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/notes.c b/notes.c
index c7f21fae44..3f4f94507a 100644
--- a/notes.c
+++ b/notes.c
@@ -270,8 +270,8 @@ static int note_tree_insert(struct notes_tree *t, struct int_node *tree,
 				if (!oidcmp(&l->val_oid, &entry->val_oid))
 					return 0;
 
-				ret = combine_notes(l->val_oid.hash,
-						    entry->val_oid.hash);
+				ret = combine_notes(&l->val_oid,
+						    &entry->val_oid);
 				if (!ret && is_null_oid(&l->val_oid))
 					note_tree_remove(t, tree, n, entry);
 				free(entry);
@@ -786,8 +786,8 @@ static int prune_notes_helper(const struct object_id *object_oid,
 	return 0;
 }
 
-int combine_notes_concatenate(unsigned char *cur_sha1,
-		const unsigned char *new_sha1)
+int combine_notes_concatenate(struct object_id *cur_oid,
+			      const struct object_id *new_oid)
 {
 	char *cur_msg = NULL, *new_msg = NULL, *buf;
 	unsigned long cur_len, new_len, buf_len;
@@ -795,18 +795,18 @@ int combine_notes_concatenate(unsigned char *cur_sha1,
 	int ret;
 
 	/* read in both note blob objects */
-	if (!is_null_sha1(new_sha1))
-		new_msg = read_sha1_file(new_sha1, &new_type, &new_len);
+	if (!is_null_oid(new_oid))
+		new_msg = read_sha1_file(new_oid->hash, &new_type, &new_len);
 	if (!new_msg || !new_len || new_type != OBJ_BLOB) {
 		free(new_msg);
 		return 0;
 	}
-	if (!is_null_sha1(cur_sha1))
-		cur_msg = read_sha1_file(cur_sha1, &cur_type, &cur_len);
+	if (!is_null_oid(cur_oid))
+		cur_msg = read_sha1_file(cur_oid->hash, &cur_type, &cur_len);
 	if (!cur_msg || !cur_len || cur_type != OBJ_BLOB) {
 		free(cur_msg);
 		free(new_msg);
-		hashcpy(cur_sha1, new_sha1);
+		oidcpy(cur_oid, new_oid);
 		return 0;
 	}
 
@@ -825,20 +825,20 @@ int combine_notes_concatenate(unsigned char *cur_sha1,
 	free(new_msg);
 
 	/* create a new blob object from buf */
-	ret = write_sha1_file(buf, buf_len, blob_type, cur_sha1);
+	ret = write_sha1_file(buf, buf_len, blob_type, cur_oid->hash);
 	free(buf);
 	return ret;
 }
 
-int combine_notes_overwrite(unsigned char *cur_sha1,
-		const unsigned char *new_sha1)
+int combine_notes_overwrite(struct object_id *cur_oid,
+			    const struct object_id *new_oid)
 {
-	hashcpy(cur_sha1, new_sha1);
+	oidcpy(cur_oid, new_oid);
 	return 0;
 }
 
-int combine_notes_ignore(unsigned char *cur_sha1,
-		const unsigned char *new_sha1)
+int combine_notes_ignore(struct object_id *cur_oid,
+			 const struct object_id *new_oid)
 {
 	return 0;
 }
@@ -848,17 +848,17 @@ int combine_notes_ignore(unsigned char *cur_sha1,
  * newlines removed.
  */
 static int string_list_add_note_lines(struct string_list *list,
-				      const unsigned char *sha1)
+				      const struct object_id *oid)
 {
 	char *data;
 	unsigned long len;
 	enum object_type t;
 
-	if (is_null_sha1(sha1))
+	if (is_null_oid(oid))
 		return 0;
 
 	/* read_sha1_file NUL-terminates */
-	data = read_sha1_file(sha1, &t, &len);
+	data = read_sha1_file(oid->hash, &t, &len);
 	if (t != OBJ_BLOB || !data || !len) {
 		free(data);
 		return t != OBJ_BLOB || !data;
@@ -884,17 +884,17 @@ static int string_list_join_lines_helper(struct string_list_item *item,
 	return 0;
 }
 
-int combine_notes_cat_sort_uniq(unsigned char *cur_sha1,
-		const unsigned char *new_sha1)
+int combine_notes_cat_sort_uniq(struct object_id *cur_oid,
+				const struct object_id *new_oid)
 {
 	struct string_list sort_uniq_list = STRING_LIST_INIT_DUP;
 	struct strbuf buf = STRBUF_INIT;
 	int ret = 1;
 
 	/* read both note blob objects into unique_lines */
-	if (string_list_add_note_lines(&sort_uniq_list, cur_sha1))
+	if (string_list_add_note_lines(&sort_uniq_list, cur_oid))
 		goto out;
-	if (string_list_add_note_lines(&sort_uniq_list, new_sha1))
+	if (string_list_add_note_lines(&sort_uniq_list, new_oid))
 		goto out;
 	string_list_remove_empty_items(&sort_uniq_list, 0);
 	string_list_sort(&sort_uniq_list);
@@ -905,7 +905,7 @@ int combine_notes_cat_sort_uniq(unsigned char *cur_sha1,
 				 string_list_join_lines_helper, &buf))
 		goto out;
 
-	ret = write_sha1_file(buf.buf, buf.len, blob_type, cur_sha1);
+	ret = write_sha1_file(buf.buf, buf.len, blob_type, cur_oid->hash);
 
 out:
 	strbuf_release(&buf);
diff --git a/notes.h b/notes.h
index 3848c2fb3f..88da38b5f4 100644
--- a/notes.h
+++ b/notes.h
@@ -9,27 +9,32 @@
  * When adding a new note annotating the same object as an existing note, it is
  * up to the caller to decide how to combine the two notes. The decision is
  * made by passing in a function of the following form. The function accepts
- * two SHA1s -- of the existing note and the new note, respectively. The
+ * two object_ids -- of the existing note and the new note, respectively. The
  * function then combines the notes in whatever way it sees fit, and writes the
- * resulting SHA1 into the first SHA1 argument (cur_sha1). A non-zero return
+ * resulting oid into the first argument (cur_oid). A non-zero return
  * value indicates failure.
  *
- * The two given SHA1s shall both be non-NULL and different from each other.
- * Either of them (but not both) may be == null_sha1, which indicates an
- * empty/non-existent note. If the resulting SHA1 (cur_sha1) is == null_sha1,
+ * The two given object_ids shall both be non-NULL and different from each
+ * other. Either of them (but not both) may be == null_oid, which indicates an
+ * empty/non-existent note. If the resulting oid (cur_oid) is == null_oid,
  * the note will be removed from the notes tree.
  *
  * The default combine_notes function (you get this when passing NULL) is
  * combine_notes_concatenate(), which appends the contents of the new note to
  * the contents of the existing note.
  */
-typedef int (*combine_notes_fn)(unsigned char *cur_sha1, const unsigned char *new_sha1);
+typedef int (*combine_notes_fn)(struct object_id *cur_oid,
+				const struct object_id *new_oid);
 
 /* Common notes combinators */
-int combine_notes_concatenate(unsigned char *cur_sha1, const unsigned char *new_sha1);
-int combine_notes_overwrite(unsigned char *cur_sha1, const unsigned char *new_sha1);
-int combine_notes_ignore(unsigned char *cur_sha1, const unsigned char *new_sha1);
-int combine_notes_cat_sort_uniq(unsigned char *cur_sha1, const unsigned char *new_sha1);
+int combine_notes_concatenate(struct object_id *cur_oid,
+			      const struct object_id *new_oid);
+int combine_notes_overwrite(struct object_id *cur_oid,
+			    const struct object_id *new_oid);
+int combine_notes_ignore(struct object_id *cur_oid,
+			 const struct object_id *new_oid);
+int combine_notes_cat_sort_uniq(struct object_id *cur_oid,
+				const struct object_id *new_oid);
 
 /*
  * Notes tree object
-- 
2.14.3

