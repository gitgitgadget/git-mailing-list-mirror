Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 978B62027C
	for <e@80x24.org>; Tue, 30 May 2017 17:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750938AbdE3RbS (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:31:18 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35181 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750871AbdE3RbS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:31:18 -0400
Received: by mail-pf0-f179.google.com with SMTP id n23so78327799pfb.2
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YfUF5xax6eQhZXvLY97D4daMzL46jgUIEeSmCVwVnlg=;
        b=q6a/46xtd9NIb2l1J2M45gsfF4nbkwEMUDl8eCuVU/f16VNEe2JOwwqouPkzGZIJuI
         OKxCQnXnc0+Etk4cTMohanrRpN95qI6SDlOSCLLuocUCYy5F7RBvkdRzFd68SJJ98Y00
         EM3+33IHXDSTzadHm6OuzKSJ1wDizMCJeHl1J20pRzS5LzYLSIVbY9yh1Nh1pwn7lwQR
         62CGL+j1t5hfGwfo+//I3Sr/KigDDPxXRoZ8YBM/C8orv/b5s9jQ2uGyTmdXZGLA+g4B
         EgTSMerM1pX8mIx5eiYHRaLCSavhd97iIZ9CCG1ewfa4twhoi066kQ14mbhQVu33sN3/
         AmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YfUF5xax6eQhZXvLY97D4daMzL46jgUIEeSmCVwVnlg=;
        b=Dg3HBUT8TE932qKtd/U0cXWVUlzcQQQGVSKvwPcv6JkfpxxqJ0qb4d8QfQti9Ubvrl
         ng3DkGEK2YE4RVFJrgtpIvcBB2A4/PwVibCBAFhIsQa8pLtlpiFV9lRlARW11NUCBOMH
         ycBVHsFhLYABM10tEIi7QGH5I1UifLdcadmQF5Yhnuzvu42QLu/8CZSewmOcbdUkcHgX
         G9L5wouWHrBrkixQldzUKv/M6jXrJbaf+yL/ZYeH8hU8qIp/Z5TULLxtCZQAs+OiwJdG
         B5V+rq18FELJaq03nWt+MuMg2k2Ic0ZlL3kp4v9Bvs5Woo5eVmP0FQ7CBv7EA+lg3our
         lgNQ==
X-Gm-Message-State: AODbwcCMkKbeaf76FrcNnit6mLPMlXoNFZogEmpgNNZh6InAZcoD8zL2
        KmB7nIGV3kIcY/ghW2YVFg==
X-Received: by 10.99.116.28 with SMTP id p28mr26630392pgc.8.1496165476458;
        Tue, 30 May 2017 10:31:16 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t19sm24940187pfg.31.2017.05.30.10.31.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 May 2017 10:31:15 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sandals@crustytoothpaste.net,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 01/33] notes: convert internal structures to struct object_id
Date:   Tue, 30 May 2017 10:30:37 -0700
Message-Id: <20170530173109.54904-2-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170530173109.54904-1-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <sandals@crustytoothpaste.net>

Convert the internal structures using unsigned char [20] to take
struct object_id using the following semantic patch and the standard
object_id transforms:

@@
struct leaf_node E1;
@@
- E1.key_sha1
+ E1.key_oid.hash

@@
struct leaf_node *E1;
@@
- E1->key_sha1
+ E1->key_oid.hash

@@
struct leaf_node E1;
@@
- E1.key_sha1
+ E1.key_oid.hash

@@
struct leaf_node *E1;
@@
- E1->key_sha1
+ E1->key_oid.hash

@@
struct non_note E1;
@@
- E1.sha1
+ E1.oid.hash

@@
struct non_note *E1;
@@
- E1->sha1
+ E1->oid.hash

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 notes.c | 98 ++++++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 51 insertions(+), 47 deletions(-)

diff --git a/notes.c b/notes.c
index 542563b28..251cf11c9 100644
--- a/notes.c
+++ b/notes.c
@@ -35,8 +35,8 @@ struct int_node {
  * subtree.
  */
 struct leaf_node {
-	unsigned char key_sha1[20];
-	unsigned char val_sha1[20];
+	struct object_id key_oid;
+	struct object_id val_oid;
 };
 
 /*
@@ -51,7 +51,7 @@ struct non_note {
 	struct non_note *next; /* grounded (last->next == NULL) */
 	char *path;
 	unsigned int mode;
-	unsigned char sha1[20];
+	struct object_id oid;
 };
 
 #define PTR_TYPE_NULL     0
@@ -100,7 +100,7 @@ static void **note_tree_search(struct notes_tree *t, struct int_node **tree,
 
 	if (GET_PTR_TYPE(p) == PTR_TYPE_SUBTREE) {
 		l = (struct leaf_node *) CLR_PTR_TYPE(p);
-		if (!SUBTREE_SHA1_PREFIXCMP(key_sha1, l->key_sha1)) {
+		if (!SUBTREE_SHA1_PREFIXCMP(key_sha1, l->key_oid.hash)) {
 			/* unpack tree and resume search */
 			(*tree)->a[0] = NULL;
 			load_subtree(t, l, *tree, *n);
@@ -118,7 +118,7 @@ static void **note_tree_search(struct notes_tree *t, struct int_node **tree,
 		return note_tree_search(t, tree, n, key_sha1);
 	case PTR_TYPE_SUBTREE:
 		l = (struct leaf_node *) CLR_PTR_TYPE(p);
-		if (!SUBTREE_SHA1_PREFIXCMP(key_sha1, l->key_sha1)) {
+		if (!SUBTREE_SHA1_PREFIXCMP(key_sha1, l->key_oid.hash)) {
 			/* unpack tree and resume search */
 			(*tree)->a[i] = NULL;
 			load_subtree(t, l, *tree, *n);
@@ -143,7 +143,7 @@ static struct leaf_node *note_tree_find(struct notes_tree *t,
 	void **p = note_tree_search(t, &tree, &n, key_sha1);
 	if (GET_PTR_TYPE(*p) == PTR_TYPE_NOTE) {
 		struct leaf_node *l = (struct leaf_node *) CLR_PTR_TYPE(*p);
-		if (!hashcmp(key_sha1, l->key_sha1))
+		if (!hashcmp(key_sha1, l->key_oid.hash))
 			return l;
 	}
 	return NULL;
@@ -196,17 +196,17 @@ static void note_tree_remove(struct notes_tree *t,
 	struct leaf_node *l;
 	struct int_node *parent_stack[20];
 	unsigned char i, j;
-	void **p = note_tree_search(t, &tree, &n, entry->key_sha1);
+	void **p = note_tree_search(t, &tree, &n, entry->key_oid.hash);
 
 	assert(GET_PTR_TYPE(entry) == 0); /* no type bits set */
 	if (GET_PTR_TYPE(*p) != PTR_TYPE_NOTE)
 		return; /* type mismatch, nothing to remove */
 	l = (struct leaf_node *) CLR_PTR_TYPE(*p);
-	if (hashcmp(l->key_sha1, entry->key_sha1))
+	if (oidcmp(&l->key_oid, &entry->key_oid))
 		return; /* key mismatch, nothing to remove */
 
 	/* we have found a matching entry */
-	hashcpy(entry->val_sha1, l->val_sha1);
+	oidcpy(&entry->val_oid, &l->val_oid);
 	free(l);
 	*p = SET_PTR_TYPE(NULL, PTR_TYPE_NULL);
 
@@ -216,14 +216,14 @@ static void note_tree_remove(struct notes_tree *t,
 	/* first, build stack of ancestors between root and current node */
 	parent_stack[0] = t->root;
 	for (i = 0; i < n; i++) {
-		j = GET_NIBBLE(i, entry->key_sha1);
+		j = GET_NIBBLE(i, entry->key_oid.hash);
 		parent_stack[i + 1] = CLR_PTR_TYPE(parent_stack[i]->a[j]);
 	}
 	assert(i == n && parent_stack[i] == tree);
 	/* next, unwind stack until note_tree_consolidate() is done */
 	while (i > 0 &&
 	       !note_tree_consolidate(parent_stack[i], parent_stack[i - 1],
-				      GET_NIBBLE(i - 1, entry->key_sha1)))
+				      GET_NIBBLE(i - 1, entry->key_oid.hash)))
 		i--;
 }
 
@@ -246,7 +246,7 @@ static int note_tree_insert(struct notes_tree *t, struct int_node *tree,
 {
 	struct int_node *new_node;
 	struct leaf_node *l;
-	void **p = note_tree_search(t, &tree, &n, entry->key_sha1);
+	void **p = note_tree_search(t, &tree, &n, entry->key_oid.hash);
 	int ret = 0;
 
 	assert(GET_PTR_TYPE(entry) == 0); /* no type bits set */
@@ -254,7 +254,7 @@ static int note_tree_insert(struct notes_tree *t, struct int_node *tree,
 	switch (GET_PTR_TYPE(*p)) {
 	case PTR_TYPE_NULL:
 		assert(!*p);
-		if (is_null_sha1(entry->val_sha1))
+		if (is_null_oid(&entry->val_oid))
 			free(entry);
 		else
 			*p = SET_PTR_TYPE(entry, type);
@@ -262,22 +262,22 @@ static int note_tree_insert(struct notes_tree *t, struct int_node *tree,
 	case PTR_TYPE_NOTE:
 		switch (type) {
 		case PTR_TYPE_NOTE:
-			if (!hashcmp(l->key_sha1, entry->key_sha1)) {
+			if (!oidcmp(&l->key_oid, &entry->key_oid)) {
 				/* skip concatenation if l == entry */
-				if (!hashcmp(l->val_sha1, entry->val_sha1))
+				if (!oidcmp(&l->val_oid, &entry->val_oid))
 					return 0;
 
-				ret = combine_notes(l->val_sha1,
-						    entry->val_sha1);
-				if (!ret && is_null_sha1(l->val_sha1))
+				ret = combine_notes(l->val_oid.hash,
+						    entry->val_oid.hash);
+				if (!ret && is_null_oid(&l->val_oid))
 					note_tree_remove(t, tree, n, entry);
 				free(entry);
 				return ret;
 			}
 			break;
 		case PTR_TYPE_SUBTREE:
-			if (!SUBTREE_SHA1_PREFIXCMP(l->key_sha1,
-						    entry->key_sha1)) {
+			if (!SUBTREE_SHA1_PREFIXCMP(l->key_oid.hash,
+						    entry->key_oid.hash)) {
 				/* unpack 'entry' */
 				load_subtree(t, entry, tree, n);
 				free(entry);
@@ -287,7 +287,7 @@ static int note_tree_insert(struct notes_tree *t, struct int_node *tree,
 		}
 		break;
 	case PTR_TYPE_SUBTREE:
-		if (!SUBTREE_SHA1_PREFIXCMP(entry->key_sha1, l->key_sha1)) {
+		if (!SUBTREE_SHA1_PREFIXCMP(entry->key_oid.hash, l->key_oid.hash)) {
 			/* unpack 'l' and restart insert */
 			*p = NULL;
 			load_subtree(t, l, tree, n);
@@ -301,7 +301,7 @@ static int note_tree_insert(struct notes_tree *t, struct int_node *tree,
 	/* non-matching leaf_node */
 	assert(GET_PTR_TYPE(*p) == PTR_TYPE_NOTE ||
 	       GET_PTR_TYPE(*p) == PTR_TYPE_SUBTREE);
-	if (is_null_sha1(entry->val_sha1)) { /* skip insertion of empty note */
+	if (is_null_oid(&entry->val_oid)) { /* skip insertion of empty note */
 		free(entry);
 		return 0;
 	}
@@ -373,7 +373,7 @@ static void add_non_note(struct notes_tree *t, char *path,
 	n->next = NULL;
 	n->path = path;
 	n->mode = mode;
-	hashcpy(n->sha1, sha1);
+	hashcpy(n->oid.hash, sha1);
 	t->prev_non_note = n;
 
 	if (!t->first_non_note) {
@@ -399,7 +399,7 @@ static void add_non_note(struct notes_tree *t, char *path,
 	if (non_note_cmp(p, n) == 0) { /* n ~= p; overwrite p with n */
 		assert(strcmp(p->path, n->path) == 0);
 		p->mode = n->mode;
-		hashcpy(p->sha1, n->sha1);
+		oidcpy(&p->oid, &n->oid);
 		free(n);
 		t->prev_non_note = p;
 		return;
@@ -422,14 +422,14 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 	unsigned char type;
 	struct leaf_node *l;
 
-	buf = fill_tree_descriptor(&desc, subtree->val_sha1);
+	buf = fill_tree_descriptor(&desc, subtree->val_oid.hash);
 	if (!buf)
 		die("Could not read %s for notes-index",
-		     sha1_to_hex(subtree->val_sha1));
+		     oid_to_hex(&subtree->val_oid));
 
-	prefix_len = subtree->key_sha1[19];
+	prefix_len = subtree->key_oid.hash[19];
 	assert(prefix_len * 2 >= n);
-	memcpy(object_sha1, subtree->key_sha1, prefix_len);
+	memcpy(object_sha1, subtree->key_oid.hash, prefix_len);
 	while (tree_entry(&desc, &entry)) {
 		path_len = strlen(entry.path);
 		len = get_sha1_hex_segment(entry.path, path_len,
@@ -447,12 +447,12 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 			type = PTR_TYPE_NOTE;
 			l = (struct leaf_node *)
 				xcalloc(1, sizeof(struct leaf_node));
-			hashcpy(l->key_sha1, object_sha1);
-			hashcpy(l->val_sha1, entry.oid->hash);
+			hashcpy(l->key_oid.hash, object_sha1);
+			oidcpy(&l->val_oid, entry.oid);
 			if (len < 20) {
 				if (!S_ISDIR(entry.mode) || path_len != 2)
 					goto handle_non_note; /* not subtree */
-				l->key_sha1[19] = (unsigned char) len;
+				l->key_oid.hash[19] = (unsigned char) len;
 				type = PTR_TYPE_SUBTREE;
 			}
 			if (note_tree_insert(t, node, n, l, type,
@@ -460,7 +460,7 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 				die("Failed to load %s %s into notes tree "
 				    "from %s",
 				    type == PTR_TYPE_NOTE ? "note" : "subtree",
-				    sha1_to_hex(l->key_sha1), t->ref);
+				    oid_to_hex(&l->key_oid), t->ref);
 		}
 		continue;
 
@@ -486,7 +486,7 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 		 */
 		{
 			struct strbuf non_note_path = STRBUF_INIT;
-			const char *q = sha1_to_hex(subtree->key_sha1);
+			const char *q = oid_to_hex(&subtree->key_oid);
 			int i;
 			for (i = 0; i < prefix_len; i++) {
 				strbuf_addch(&non_note_path, *q++);
@@ -599,15 +599,17 @@ static int for_each_note_helper(struct notes_tree *t, struct int_node *tree,
 			    flags & FOR_EACH_NOTE_YIELD_SUBTREES) {
 				/* invoke callback with subtree */
 				unsigned int path_len =
-					l->key_sha1[19] * 2 + fanout;
+					l->key_oid.hash[19] * 2 + fanout;
 				assert(path_len < FANOUT_PATH_MAX - 1);
-				construct_path_with_fanout(l->key_sha1, fanout,
+				construct_path_with_fanout(l->key_oid.hash,
+							   fanout,
 							   path);
 				/* Create trailing slash, if needed */
 				if (path[path_len - 1] != '/')
 					path[path_len++] = '/';
 				path[path_len] = '\0';
-				ret = fn(l->key_sha1, l->val_sha1, path,
+				ret = fn(l->key_oid.hash, l->val_oid.hash,
+					 path,
 					 cb_data);
 			}
 			if (n > fanout * 2 ||
@@ -621,8 +623,10 @@ static int for_each_note_helper(struct notes_tree *t, struct int_node *tree,
 			break;
 		case PTR_TYPE_NOTE:
 			l = (struct leaf_node *) CLR_PTR_TYPE(p);
-			construct_path_with_fanout(l->key_sha1, fanout, path);
-			ret = fn(l->key_sha1, l->val_sha1, path, cb_data);
+			construct_path_with_fanout(l->key_oid.hash, fanout,
+						   path);
+			ret = fn(l->key_oid.hash, l->val_oid.hash, path,
+				 cb_data);
 			break;
 		}
 		if (ret)
@@ -742,7 +746,7 @@ static int write_each_non_note_until(const char *note_path,
 			; /* do nothing, prefer note to non-note */
 		else {
 			ret = write_each_note_helper(d->root, n->path, n->mode,
-						     n->sha1);
+						     n->oid.hash);
 			if (ret)
 				return ret;
 		}
@@ -1027,8 +1031,8 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 		die("Failed to read notes tree referenced by %s (%s)",
 		    notes_ref, oid_to_hex(&object_oid));
 
-	hashclr(root_tree.key_sha1);
-	hashcpy(root_tree.val_sha1, oid.hash);
+	oidclr(&root_tree.key_oid);
+	oidcpy(&root_tree.val_oid, &oid);
 	load_subtree(t, &root_tree, t->root, 0);
 }
 
@@ -1092,8 +1096,8 @@ int add_note(struct notes_tree *t, const unsigned char *object_sha1,
 	if (!combine_notes)
 		combine_notes = t->combine_notes;
 	l = (struct leaf_node *) xmalloc(sizeof(struct leaf_node));
-	hashcpy(l->key_sha1, object_sha1);
-	hashcpy(l->val_sha1, note_sha1);
+	hashcpy(l->key_oid.hash, object_sha1);
+	hashcpy(l->val_oid.hash, note_sha1);
 	return note_tree_insert(t, t->root, 0, l, PTR_TYPE_NOTE, combine_notes);
 }
 
@@ -1104,10 +1108,10 @@ int remove_note(struct notes_tree *t, const unsigned char *object_sha1)
 	if (!t)
 		t = &default_notes_tree;
 	assert(t->initialized);
-	hashcpy(l.key_sha1, object_sha1);
-	hashclr(l.val_sha1);
+	hashcpy(l.key_oid.hash, object_sha1);
+	oidclr(&l.val_oid);
 	note_tree_remove(t, t->root, 0, &l);
-	if (is_null_sha1(l.val_sha1)) /* no note was removed */
+	if (is_null_oid(&l.val_oid)) /* no note was removed */
 		return 1;
 	t->dirty = 1;
 	return 0;
@@ -1122,7 +1126,7 @@ const unsigned char *get_note(struct notes_tree *t,
 		t = &default_notes_tree;
 	assert(t->initialized);
 	found = note_tree_find(t, t->root, 0, object_sha1);
-	return found ? found->val_sha1 : NULL;
+	return found ? found->val_oid.hash : NULL;
 }
 
 int for_each_note(struct notes_tree *t, int flags, each_note_fn fn,
-- 
2.13.0.219.gdb65acc882-goog

