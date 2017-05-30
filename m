Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E5572027C
	for <e@80x24.org>; Tue, 30 May 2017 17:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750999AbdE3RbX (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:31:23 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:32845 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750965AbdE3RbV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:31:21 -0400
Received: by mail-pf0-f182.google.com with SMTP id e193so78458017pfh.0
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zUsaVArJ9TWi2ph9QVdppRKXxv7hTXUdGUm5Em9mtos=;
        b=D7fsXFph2WixbqpluIr7eZZK3eWaamVPGEFrnRFSxg+6kl6dILJFSTLxAKBN+tZzyG
         amPkk4A4y/A+rN3f+yPgRVwMrAXNJj2ng/OBfKzeSpTILW4cpqK4jZHvQTgJU5lfifaK
         Q3+1l6Z6ysRRoa/aVuwMN4JW6j2fOLD0Fje7Y1S522jGUL/H041B+/qYujlRi4pbfI1Y
         RJk4hqghk0EXMkdgc8poGkp0XQq3/PNQOE02ABL0ecAnDyvmehEe/hMeQceMFJktetJ9
         tFLU1YctbS6JpmFMt21yGoeeCqKQ5a9ubFasH53fsZb3YiwIHQxLF2SCRf1an6KKAuGb
         hgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zUsaVArJ9TWi2ph9QVdppRKXxv7hTXUdGUm5Em9mtos=;
        b=M4pSTiLFHKyTYnw1yXQMGDXG1rgZdj6yx6Pqgp6+E61qC78e5nS4ONeuiyvojVAM0Q
         Wq3Ufnen1wuctRu+ww3xoyX7hLBkjrx+sNw6Cj993dF4YVGqP5tInv0HfDi7DW2i7PrD
         ocJw4RpYJSjn3AF10BxsatvQJxewfm3CRoROcD+8rXt9LaK/gtcuOUQeJXHeXeZGmZiK
         9Vzbz1HHVS0rSx/0j4ImXyEEDARDNcyoutSGFWVEeX3C13/ed9Ya/DJrMyfMr8iQXB8b
         f4YJHLMva+07hMC97cRpLtqmcSDAG4c8dXs1FMQ4BytkJCSYhYEl0eU9uScg/G0XMo3i
         fGxw==
X-Gm-Message-State: AODbwcBWNo6gAgEpMvVl1hoGM6Wx9kuGUKnea3Gao1YEzHTOjS47U7N9
        El/oBLdWnXpJBO0KXyWO6g==
X-Received: by 10.98.24.200 with SMTP id 191mr24969348pfy.207.1496165479658;
        Tue, 30 May 2017 10:31:19 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t19sm24940187pfg.31.2017.05.30.10.31.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 May 2017 10:31:18 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sandals@crustytoothpaste.net,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 03/33] notes: convert for_each_note to struct object_id
Date:   Tue, 30 May 2017 10:30:39 -0700
Message-Id: <20170530173109.54904-4-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170530173109.54904-1-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <sandals@crustytoothpaste.net>

Convert for_each_note and each of the callbacks to use struct object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/notes.c  |  6 +++---
 notes.c          | 24 ++++++++++++------------
 notes.h          |  4 ++--
 remote-testsvn.c |  8 ++++----
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index f2847c41e..53fe6d34d 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -109,11 +109,11 @@ static void free_note_data(struct note_data *d)
 	strbuf_release(&d->buf);
 }
 
-static int list_each_note(const unsigned char *object_sha1,
-		const unsigned char *note_sha1, char *note_path,
+static int list_each_note(const struct object_id *object_oid,
+		const struct object_id *note_oid, char *note_path,
 		void *cb_data)
 {
-	printf("%s %s\n", sha1_to_hex(note_sha1), sha1_to_hex(object_sha1));
+	printf("%s %s\n", oid_to_hex(note_oid), oid_to_hex(object_oid));
 	return 0;
 }
 
diff --git a/notes.c b/notes.c
index babe0c0eb..e881c10ee 100644
--- a/notes.c
+++ b/notes.c
@@ -610,7 +610,7 @@ static int for_each_note_helper(struct notes_tree *t, struct int_node *tree,
 				if (path[path_len - 1] != '/')
 					path[path_len++] = '/';
 				path[path_len] = '\0';
-				ret = fn(l->key_oid.hash, l->val_oid.hash,
+				ret = fn(&l->key_oid, &l->val_oid,
 					 path,
 					 cb_data);
 			}
@@ -627,7 +627,7 @@ static int for_each_note_helper(struct notes_tree *t, struct int_node *tree,
 			l = (struct leaf_node *) CLR_PTR_TYPE(p);
 			construct_path_with_fanout(l->key_oid.hash, fanout,
 						   path);
-			ret = fn(l->key_oid.hash, l->val_oid.hash, path,
+			ret = fn(&l->key_oid, &l->val_oid, path,
 				 cb_data);
 			break;
 		}
@@ -698,7 +698,7 @@ static int tree_write_stack_finish_subtree(struct tree_write_stack *tws)
 
 static int write_each_note_helper(struct tree_write_stack *tws,
 		const char *path, unsigned int mode,
-		const unsigned char *sha1)
+		const struct object_id *oid)
 {
 	size_t path_len = strlen(path);
 	unsigned int n = 0;
@@ -728,7 +728,7 @@ static int write_each_note_helper(struct tree_write_stack *tws,
 
 	/* Finally add given entry to the current tree object */
 	write_tree_entry(&tws->buf, mode, path + 3 * n, path_len - (3 * n),
-			 sha1);
+			 oid->hash);
 
 	return 0;
 }
@@ -748,7 +748,7 @@ static int write_each_non_note_until(const char *note_path,
 			; /* do nothing, prefer note to non-note */
 		else {
 			ret = write_each_note_helper(d->root, n->path, n->mode,
-						     n->oid.hash);
+						     &n->oid);
 			if (ret)
 				return ret;
 		}
@@ -758,8 +758,8 @@ static int write_each_non_note_until(const char *note_path,
 	return 0;
 }
 
-static int write_each_note(const unsigned char *object_sha1,
-		const unsigned char *note_sha1, char *note_path,
+static int write_each_note(const struct object_id *object_oid,
+		const struct object_id *note_oid, char *note_path,
 		void *cb_data)
 {
 	struct write_each_note_data *d =
@@ -777,7 +777,7 @@ static int write_each_note(const unsigned char *object_sha1,
 
 	/* Weave non-note entries into note entries */
 	return  write_each_non_note_until(note_path, d) ||
-		write_each_note_helper(d->root, note_path, mode, note_sha1);
+		write_each_note_helper(d->root, note_path, mode, note_oid);
 }
 
 struct note_delete_list {
@@ -785,20 +785,20 @@ struct note_delete_list {
 	const unsigned char *sha1;
 };
 
-static int prune_notes_helper(const unsigned char *object_sha1,
-		const unsigned char *note_sha1, char *note_path,
+static int prune_notes_helper(const struct object_id *object_oid,
+		const struct object_id *note_oid, char *note_path,
 		void *cb_data)
 {
 	struct note_delete_list **l = (struct note_delete_list **) cb_data;
 	struct note_delete_list *n;
 
-	if (has_sha1_file(object_sha1))
+	if (has_object_file(object_oid))
 		return 0; /* nothing to do for this note */
 
 	/* failed to find object => prune this note */
 	n = (struct note_delete_list *) xmalloc(sizeof(*n));
 	n->next = *l;
-	n->sha1 = object_sha1;
+	n->sha1 = object_oid->hash;
 	*l = n;
 	return 0;
 }
diff --git a/notes.h b/notes.h
index 5345642cf..6651673ae 100644
--- a/notes.h
+++ b/notes.h
@@ -202,8 +202,8 @@ int copy_note(struct notes_tree *t,
  * - copy_note()
  * - free_notes()
  */
-typedef int each_note_fn(const unsigned char *object_sha1,
-		const unsigned char *note_sha1, char *note_path,
+typedef int each_note_fn(const struct object_id *object_oid,
+		const struct object_id *note_oid, char *note_path,
 		void *cb_data);
 int for_each_note(struct notes_tree *t, int flags, each_note_fn fn,
 		void *cb_data);
diff --git a/remote-testsvn.c b/remote-testsvn.c
index f87bf851b..793c4ad1d 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -99,8 +99,8 @@ static int parse_rev_note(const char *msg, struct rev_note *res)
 	return -1;
 }
 
-static int note2mark_cb(const unsigned char *object_sha1,
-		const unsigned char *note_sha1, char *note_path,
+static int note2mark_cb(const struct object_id *object_oid,
+		const struct object_id *note_oid, char *note_path,
 		void *cb_data)
 {
 	FILE *file = (FILE *)cb_data;
@@ -109,14 +109,14 @@ static int note2mark_cb(const unsigned char *object_sha1,
 	enum object_type type;
 	struct rev_note note;
 
-	if (!(msg = read_sha1_file(note_sha1, &type, &msglen)) ||
+	if (!(msg = read_sha1_file(note_oid->hash, &type, &msglen)) ||
 			!msglen || type != OBJ_BLOB) {
 		free(msg);
 		return 1;
 	}
 	if (parse_rev_note(msg, &note))
 		return 2;
-	if (fprintf(file, ":%d %s\n", note.rev_nr, sha1_to_hex(object_sha1)) < 1)
+	if (fprintf(file, ":%d %s\n", note.rev_nr, oid_to_hex(object_oid)) < 1)
 		return 3;
 	return 0;
 }
-- 
2.13.0.219.gdb65acc882-goog

