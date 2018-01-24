Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 567E21F576
	for <e@80x24.org>; Wed, 24 Jan 2018 11:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933248AbeAXLMd (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 06:12:33 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:39610 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933187AbeAXLMW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 06:12:22 -0500
Received: by mail-lf0-f66.google.com with SMTP id w27so3455657lfd.6
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 03:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=66NSRlPsXci4wHFv/dWXrjaICU+bcYQXBJquavTqGxk=;
        b=osgRGI3hS3HZTDuoKERBHInhpLjN9Lg9jSvqrqICtIMEULD7Ar+tBoxiDsjrk6tCIl
         CW9VqCsutxqzXwCMgoLzziYh6ZfFwKDpVY08cfDyiwHREJ7M6zRg7beOxeMTd9szl03g
         tsLVjUjz0/VVB5VnJ4qvw2qBAkb4cNKp0hbjmFRCICX79NrDNzwjLPQSmmQ0IkvrUuqC
         SAttkh2V2XBSXILaYbYJXnUHj1eZRCKX3u3V+TE7h3E+P33yAe5oTdI3g6PsjumQvVX0
         LN+v6a8AoDZpPob03u2oHLtA/q5fgL83KxCrnsZXhLNg6Z6szsm7usIuYxOpTdAd4Yx1
         dKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=66NSRlPsXci4wHFv/dWXrjaICU+bcYQXBJquavTqGxk=;
        b=GrYe+ptB/ZPAnrbT1YnidQBspznhAFLMniBr6XuyRylFO79dWobc/iFmchSB+5ijrx
         jLjRmv7VRx30j1pu3EIJeaiGW6Tc50pL4fyJSriJzJSvoJqEIWHG0+rGiFZrj7WfVKGY
         ymLANdbvLCssdyBMO849/dQTsOG5RKRIXxVp/cTx6mT55tIXC8bjhQK/s0OxVJyLdsbz
         j4jw8LzFhf56gWtTaPoGnwDiLmQWuUuy0eWVSPl3r/6gkvd4mODHNTVLz5ZPXKSr7KfK
         5NHpycIzXmyIXxd1t2zaPi0KV3+aUwpuPuXXNzxw6EXZ/+lHFyqY6P+c/WI3iB+h7knJ
         x6Tw==
X-Gm-Message-State: AKwxytcRGS7DH3CUgQgG+2dK1KI/eBBSeNpr5FaX9wVMLJgCrp9SVehd
        UIrbGztBJcWWTaPmHzC/gRWvno+o
X-Google-Smtp-Source: AH8x224o3m+ojnskTS64Y6a4fD6t4WEB0DXKmji8ocuSOQOgNswi+RzlF/36Ibh3G1P3nCB2x5zfWA==
X-Received: by 10.25.149.143 with SMTP id x137mr3427606lfd.119.1516792340271;
        Wed, 24 Jan 2018 03:12:20 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id i18sm14426ljd.27.2018.01.24.03.12.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jan 2018 03:12:19 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v3 09/14] notes: convert combine_notes_* to object_id
Date:   Wed, 24 Jan 2018 12:12:01 +0100
Message-Id: <861d8a3c8f8ffd4a252965429d85e8343a8723a1.1516790478.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1516790478.git.patryk.obara@gmail.com>
References: <cover.1516617960.git.patryk.obara@gmail.com>
 <cover.1516790478.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1516790478.git.patryk.obara@gmail.com>
References: <cover.1516790478.git.patryk.obara@gmail.com>
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

