Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B77E61F576
	for <e@80x24.org>; Wed, 24 Jan 2018 11:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933242AbeAXLMc (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 06:12:32 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41999 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933129AbeAXLMX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 06:12:23 -0500
Received: by mail-lf0-f66.google.com with SMTP id q17so4708363lfa.9
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 03:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=V0ifA3oPEOS05sBUgw/zzcgOyAtZ+wqHy7M8Szjm8Fw=;
        b=LSDsqZc92Zb0ViynMPvmKG59jwYtSUxIeRLdgjeQS2c+/LcAoi0g2Hgviu5Mmw0GB+
         1Vjpj9Tl94nKxe/EPDjmRL+/WUWnSNblOhZIN/yrWipCpmICUCX3/WwRqVpd0cpDy6eX
         tdgOogtLrr4gNPYKwgy9lvC4aBx7VzXefQ2udtQmJq+xa4kkL1Wa7ovhIj1AGTUFCqfG
         GtUjorv5aLXNff9j2O84UX0weWBipDMKxybUOQfVfjTqAI8Uqx/sjZYEIebYp/4lItOx
         ue0KvNTgCVm6GjT+HzvXEqOpAjVHZ+TQpKKFWaJxsRBPQVW6itG/dX0nN7nbUBQP5XGl
         SVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=V0ifA3oPEOS05sBUgw/zzcgOyAtZ+wqHy7M8Szjm8Fw=;
        b=CX899ES8XtlWqxrODHFh1E6fyJsM6DzRnZ6xAsRWv3Y05TAx5sGD+C7AcrHwudGT0n
         QnHK72qMScG9aqbHV4VOPDK2NzPeJ8Ya7MwUYqo2Ajahldfa1UipgBXFfkpp0r/fjKdh
         U70Kaa+zzqgeVTjilfwVk5GfWFMA7QLYiQmL7w8tsfspGRbC3oVXSgGNLGUUgUD27lvZ
         O9rBlrIRjaf+1CZ2TngxTCvKozbJn6GP7y4GGmX/KGKfgeCEMtVIPvEgjQSPUUaMZzxV
         B+bU1LP/YIP4Rm+l+FPdxAHZnS9IRope91FAwWMEzvtvIOBMY/rESDL4hHoMMPnHz/CH
         aMow==
X-Gm-Message-State: AKwxytcBDc85+OKY11KRzgOxDR5XKb14x749IP1aAdoL5fllmSqoIgfg
        3lBMIdcFg8KrdSJll7157/EAUOkh
X-Google-Smtp-Source: AH8x224Ep42ySiNNmhBMqqWo/rqRkYA4ILkeN7OYZifOsgdIt5WtDa8tpQ7v5mo8qmwYKFSiFgYZLg==
X-Received: by 10.25.90.81 with SMTP id o78mr2913647lfb.123.1516792341755;
        Wed, 24 Jan 2018 03:12:21 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id i18sm14426ljd.27.2018.01.24.03.12.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jan 2018 03:12:20 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v3 10/14] notes: convert write_notes_tree to object_id
Date:   Wed, 24 Jan 2018 12:12:02 +0100
Message-Id: <e915a13f9a7e29ebf5fd45fd719d9e5f59c89f15.1516790478.git.patryk.obara@gmail.com>
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

