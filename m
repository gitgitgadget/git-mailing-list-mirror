Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EDD21FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 14:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932532AbeAROvk (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 09:51:40 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46398 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932438AbeAROvY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 09:51:24 -0500
Received: by mail-lf0-f67.google.com with SMTP id q194so15529876lfe.13
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 06:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=V0ifA3oPEOS05sBUgw/zzcgOyAtZ+wqHy7M8Szjm8Fw=;
        b=SPmpNV51Fdq/7eRyHFF0buJN7Rgrp4yGlgFZPw/uUb93XYqQu4Dlz+CwDGr5ZrViU+
         yFeCyH1jYjkBRiKl/Ysk9R59jAkcOvl4VGqimNdee9M1axgul7rP518WN1jStdU9b+ZL
         KMS43lTYCIuZLdRTUt5hDqm5Tc8ldOFZjrqiZEAf7J95gtbUDfrIx+Bmonyo0aPRh9ah
         ZsRnk8l6RaHvDRThd6NaZfpBLvO1+yKn+UeD5HyMFjaIJoOpRHAemNRgcIemlmguDZNh
         WovaDXSFlOpmT7kCiDYfuNS2BRtgR/Wm/63HsFvmx5s/4en3ksxWD2/SFTyNZtHpzDnv
         uw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=V0ifA3oPEOS05sBUgw/zzcgOyAtZ+wqHy7M8Szjm8Fw=;
        b=PXKWLhXLKbkFh1jnYWQsBxUCHOUVlhbJEeB8C7WMXa+B1XSuA2l59f80Tsw18mzkPn
         zp/kiF0GxbuLZm6dxl5dhKuD8x6Pv7X8LiDJ3ANVNZIyE812h5UmrrIMffL+B0avMfPx
         NgmxzWpgsFpxVBxRqE3apV1MGoHVEyvZUplPpzQcDkUsa1zPhxppEm9ReVK11reLLwG/
         29M4XbT+wguV4ifa8bcol34I35ZTG6YmJaeA7dXt7KDzkFKzdQk2JY2S/FawQ2Q9K/jV
         IHhV2nGmuc1SwK25pbUxfXBvp96thOzgc3g4PFv15zfzMpMnyoS7i+nFs/uo/95y4fo7
         KjxQ==
X-Gm-Message-State: AKwxytdVTMmqv31tDNqyUv8FqXNL85Ab65/L2EWHhzYG3icwUpG+JDnA
        xFLjw7aDQStsnfLE3hx5K0EqiGifR3I=
X-Google-Smtp-Source: ACJfBoutNpAwuP/aQyXlzaAt9maUd1guxhUwkqGwEwiRoYXLARxfFAblw+YBVSjG1yTf3BNaSOo/Vg==
X-Received: by 10.46.108.5 with SMTP id h5mr12558117ljc.48.1516287082570;
        Thu, 18 Jan 2018 06:51:22 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id 23sm560988lju.28.2018.01.18.06.51.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jan 2018 06:51:21 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.ath.cx>
Subject: [PATCH 10/11] notes: convert write_notes_tree to object_id
Date:   Thu, 18 Jan 2018 15:51:02 +0100
Message-Id: <3f8480d2f3e4311418ca775046f73e045678f39c.1516282880.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1516282880.git.patryk.obara@gmail.com>
References: <cover.1516282880.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1516282880.git.patryk.obara@gmail.com>
References: <cover.1516282880.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the definition and declaration of write_notes_tree to
struct object_id and adjust usage of this function.

Additionally, improve style of small part of this function, as old
formatting made it hard to understand at glance what this part of
code is doing.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 notes-cache.c |  2 +-
 notes-utils.c |  2 +-
 notes.c       | 16 +++++++++-------
 notes.h       |  4 ++--
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/notes-cache.c b/notes-cache.c
index d2f87147cc..010ad236cb 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -54,7 +54,7 @@ int notes_cache_write(struct notes_cache *c)
 	if (!c->tree.dirty)
 		return 0;
 
-	if (write_notes_tree(&c->tree, tree_oid.hash))
+	if (write_notes_tree(&c->tree, &tree_oid))
 		return -1;
 	if (commit_tree(c->validity, strlen(c->validity), &tree_oid, NULL,
 			&commit_oid, NULL, NULL) < 0)
diff --git a/notes-utils.c b/notes-utils.c
index 058c642dac..02407fe2a7 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -12,7 +12,7 @@ void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
 
 	assert(t->initialized);
 
-	if (write_notes_tree(t, tree_oid.hash))
+	if (write_notes_tree(t, &tree_oid))
 		die("Failed to write notes tree to database");
 
 	if (!parents) {
diff --git a/notes.c b/notes.c
index 3f4f94507a..09ef1ce33a 100644
--- a/notes.c
+++ b/notes.c
@@ -1123,11 +1123,12 @@ int for_each_note(struct notes_tree *t, int flags, each_note_fn fn,
 	return for_each_note_helper(t, t->root, 0, 0, flags, fn, cb_data);
 }
 
-int write_notes_tree(struct notes_tree *t, unsigned char *result)
+int write_notes_tree(struct notes_tree *t, struct object_id *result)
 {
 	struct tree_write_stack root;
 	struct write_each_note_data cb_data;
 	int ret;
+	int flags;
 
 	if (!t)
 		t = &default_notes_tree;
@@ -1141,12 +1142,13 @@ int write_notes_tree(struct notes_tree *t, unsigned char *result)
 	cb_data.next_non_note = t->first_non_note;
 
 	/* Write tree objects representing current notes tree */
-	ret = for_each_note(t, FOR_EACH_NOTE_DONT_UNPACK_SUBTREES |
-				FOR_EACH_NOTE_YIELD_SUBTREES,
-			write_each_note, &cb_data) ||
-		write_each_non_note_until(NULL, &cb_data) ||
-		tree_write_stack_finish_subtree(&root) ||
-		write_sha1_file(root.buf.buf, root.buf.len, tree_type, result);
+	flags = FOR_EACH_NOTE_DONT_UNPACK_SUBTREES |
+		FOR_EACH_NOTE_YIELD_SUBTREES;
+	ret = for_each_note(t, flags, write_each_note, &cb_data) ||
+	      write_each_non_note_until(NULL, &cb_data) ||
+	      tree_write_stack_finish_subtree(&root) ||
+	      write_sha1_file(root.buf.buf, root.buf.len, tree_type,
+			      result->hash);
 	strbuf_release(&root.buf);
 	return ret;
 }
diff --git a/notes.h b/notes.h
index 88da38b5f4..0433f45db5 100644
--- a/notes.h
+++ b/notes.h
@@ -217,7 +217,7 @@ int for_each_note(struct notes_tree *t, int flags, each_note_fn fn,
  * Write the given notes_tree structure to the object database
  *
  * Creates a new tree object encapsulating the current state of the given
- * notes_tree, and stores its SHA1 into the 'result' argument.
+ * notes_tree, and stores its object id into the 'result' argument.
  *
  * Returns zero on success, non-zero on failure.
  *
@@ -225,7 +225,7 @@ int for_each_note(struct notes_tree *t, int flags, each_note_fn fn,
  * this function has returned zero. Please also remember to create a
  * corresponding commit object, and update the appropriate notes ref.
  */
-int write_notes_tree(struct notes_tree *t, unsigned char *result);
+int write_notes_tree(struct notes_tree *t, struct object_id *result);
 
 /* Flags controlling the operation of prune */
 #define NOTES_PRUNE_VERBOSE 1
-- 
2.14.3

