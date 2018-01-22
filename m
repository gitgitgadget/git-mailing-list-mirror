Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79BD51F424
	for <e@80x24.org>; Mon, 22 Jan 2018 11:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751200AbeAVLFB (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 06:05:01 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39274 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751139AbeAVLEz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 06:04:55 -0500
Received: by mail-wm0-f66.google.com with SMTP id b21so15975492wme.4
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 03:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=V0ifA3oPEOS05sBUgw/zzcgOyAtZ+wqHy7M8Szjm8Fw=;
        b=Iqp70SOjBN8rC8nOIBiPgL0RHeTxiwJFAUdYVgYay/AEDWjBK9QD9u43zqsKC6IrsX
         FbBZDzoEbbJf73kTNGiyrOw/k+Vsja7CuTo9WOdtaBecpkGoO80lX0XHcc/MJPaTwims
         hz75wEKV3jFN/NJV+FJfd5aFnRqbO1wcDoz+pLnDc3sXau5dj7q0T1FLbSiKkpxs1qaS
         UMgiyJCDARZo881zf6RznW+G3IbCwQnCq1t1xykPe6/VRHr4OFarIfBejXaOrOWDARYb
         mY2nGJnAh9oamsRDeMT1Jg3CQRaZJ0VqThPBZ0vuTGKuxQjixz9T1laq+NcngKCxiOrO
         b3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=V0ifA3oPEOS05sBUgw/zzcgOyAtZ+wqHy7M8Szjm8Fw=;
        b=tDesbuE9FFUL2+JmhO2xQ/irPmp9XTLFln7its5jy2aYHvaR1LD8T80qqVdI7lPL/J
         neHETSXMFwy6XqhAI9dbdEnHHVRy1QrdE8AKpcr4t3iPXHiYRiD721hBIW8pLGcjhvGh
         Qvnl4Bbh7AhYVo29keGiRDufz655D2vsShX2JoTQnFIo/aGCiknbTv2Aw26FjV/tk7AE
         N5Nigtnl6rtakcy/o4tn5l/C8zJBb/bQqdeLJfw4uRV5CLWL0QdlvDf8MFaEE19wAJRL
         2QBeeXQFFYQ+jY66gqm454xeDQNcXPH58RSJsGX67yvyleEroIWcdxdwmOJ3A/SOzeQo
         o+VQ==
X-Gm-Message-State: AKwxytedBQpiV7u9elaNieBHNk8Qa5nJAgn7+asf7WdTWmhMHMpExgIK
        C2ZQuMHgcK9tqy10BeioQ1TSK4Sl
X-Google-Smtp-Source: AH8x224x82CXdd/FFtJ1DjKHaMl41QJnuxUZ2IUi7tNGEHLsBmAXumaXjhcCsTdDs5rQhBMC7jrB2Q==
X-Received: by 10.80.157.6 with SMTP id v6mr12710892ede.123.1516619093841;
        Mon, 22 Jan 2018 03:04:53 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id e12sm10833591edm.42.2018.01.22.03.04.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jan 2018 03:04:52 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        sandals@crustytoothpaste.ath.cx,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2 10/14] notes: convert write_notes_tree to object_id
Date:   Mon, 22 Jan 2018 12:04:33 +0100
Message-Id: <e0d8c7e8d42762f912f1ec3eb40810d18d6533d4.1516617960.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1516617960.git.patryk.obara@gmail.com>
References: <cover.1516282880.git.patryk.obara@gmail.com>
 <cover.1516617960.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1516617960.git.patryk.obara@gmail.com>
References: <cover.1516617960.git.patryk.obara@gmail.com>
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

