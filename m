Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C224F2027C
	for <e@80x24.org>; Tue, 30 May 2017 17:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751198AbdE3Rbh (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:31:37 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:32895 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751063AbdE3Rbb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:31:31 -0400
Received: by mail-pf0-f182.google.com with SMTP id e193so78460164pfh.0
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jZeFVNx5vtyfs517tGJJFnfLyo28MEJaBXXriF2l+6w=;
        b=Bq+ideWnSlAH0UHbPI9M6x5On1VJhkifTVD3mEeXz1keNyncRMQarEezXkKzquLTy4
         5bbUwYYTmmyGz43Vaypd753fNwiE77odVm+9jO/O9k4mi24AdwNNFnRBfx7CqGYbYFHU
         nb2xRFpCKZK/HENKIH4BFgrJvNJAqTwqA26muoiNuwcFen331xn2Cs9KKnbWHv18A8MM
         H5yZVsGVo/IMzWv7bzbTiUU0Js5fuR+jyog36Da3VHfwSWEx2aoY8+eVM8dTM5tjuwU+
         mYrIy/7WrdE6HK5Sg+obKFK9PKlp9U61inTMCjCAwQD8osZVeRE4gRrA/RlxIRLzgn0p
         6Xeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jZeFVNx5vtyfs517tGJJFnfLyo28MEJaBXXriF2l+6w=;
        b=J499MGUfNgwSw9wcBw8NWpmwwX/lmuv1NdXXMVqg4gfYfQgDjIx88Uq+4IWhBsHUlm
         mPnbOQPeWBsg470ucKIYC2ZvHdrlTFAnTwv5l0k8ULeHmMbA8kffZDpLIfPU/z1EG0iJ
         VwLsQhaSgyJB9IPYogL9WU6Sp1OaoPyXnaLGYTEzPkFW1XfD4g1dAEDOSNhlpWL0r7sT
         x6gIjQ9Zx3xbamqSuvp/LkwJJEme4Nc3oKu/lB2AUTeriJK6Jdy7L75b1waSvxBdu6Kn
         ydU8jXcpZUvi35mNVnZqbpZ+4ggk21WWWUPPhTRGBQor8dHrZNuRiiIJ+EGVefwcjRHK
         FkYw==
X-Gm-Message-State: AODbwcDUbct5X/7N0hMUi9UY6fDhWGZtqowyTetYPSruasPvi9R1OaVB
        cSK6eSl+3zuYU3V4
X-Received: by 10.84.241.206 with SMTP id t14mr84814618plm.48.1496165485930;
        Tue, 30 May 2017 10:31:25 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t19sm24940187pfg.31.2017.05.30.10.31.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 May 2017 10:31:24 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sandals@crustytoothpaste.net,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 07/33] notes: convert some accessor functions to struct object_id
Date:   Tue, 30 May 2017 10:30:43 -0700
Message-Id: <20170530173109.54904-8-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170530173109.54904-1-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <sandals@crustytoothpaste.net>

Convert add_note, get_note, and copy_note to take struct object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/notes.c  | 20 ++++++++++----------
 notes-cache.c    |  4 ++--
 notes-merge.c    | 18 +++++++++---------
 notes-utils.c    |  2 +-
 notes.c          | 20 ++++++++++----------
 notes.h          |  8 ++++----
 remote-testsvn.c | 10 +++++-----
 7 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 7947a16ed..b13fc8789 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -309,7 +309,7 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 		if (rewrite_cmd)
 			err = copy_note_for_rewrite(c, &from_obj, &to_obj);
 		else
-			err = copy_note(t, from_obj.hash, to_obj.hash, force,
+			err = copy_note(t, &from_obj, &to_obj, force,
 					combine_notes_overwrite);
 
 		if (err) {
@@ -370,7 +370,7 @@ static int list(int argc, const char **argv, const char *prefix)
 	if (argc) {
 		if (get_oid(argv[0], &object))
 			die(_("failed to resolve '%s' as a valid ref."), argv[0]);
-		note = get_note(t, object.hash);
+		note = get_note(t, &object);
 		if (note) {
 			puts(oid_to_hex(note));
 			retval = 0;
@@ -427,7 +427,7 @@ static int add(int argc, const char **argv, const char *prefix)
 		die(_("failed to resolve '%s' as a valid ref."), object_ref);
 
 	t = init_notes_check("add", NOTES_INIT_WRITABLE);
-	note = get_note(t, object.hash);
+	note = get_note(t, &object);
 
 	if (note) {
 		if (!force) {
@@ -456,7 +456,7 @@ static int add(int argc, const char **argv, const char *prefix)
 	prepare_note_data(&object, &d, note->hash);
 	if (d.buf.len || allow_empty) {
 		write_note_data(&d, new_note.hash);
-		if (add_note(t, object.hash, new_note.hash, combine_notes_overwrite))
+		if (add_note(t, &object, &new_note, combine_notes_overwrite))
 			die("BUG: combine_notes_overwrite failed");
 		commit_notes(t, "Notes added by 'git notes add'");
 	} else {
@@ -518,7 +518,7 @@ static int copy(int argc, const char **argv, const char *prefix)
 		die(_("failed to resolve '%s' as a valid ref."), object_ref);
 
 	t = init_notes_check("copy", NOTES_INIT_WRITABLE);
-	note = get_note(t, object.hash);
+	note = get_note(t, &object);
 
 	if (note) {
 		if (!force) {
@@ -532,14 +532,14 @@ static int copy(int argc, const char **argv, const char *prefix)
 			oid_to_hex(&object));
 	}
 
-	from_note = get_note(t, from_obj.hash);
+	from_note = get_note(t, &from_obj);
 	if (!from_note) {
 		retval = error(_("missing notes on source object %s. Cannot "
 			       "copy."), oid_to_hex(&from_obj));
 		goto out;
 	}
 
-	if (add_note(t, object.hash, from_note->hash, combine_notes_overwrite))
+	if (add_note(t, &object, from_note, combine_notes_overwrite))
 		die("BUG: combine_notes_overwrite failed");
 	commit_notes(t, "Notes added by 'git notes copy'");
 out:
@@ -596,7 +596,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		die(_("failed to resolve '%s' as a valid ref."), object_ref);
 
 	t = init_notes_check(argv[0], NOTES_INIT_WRITABLE);
-	note = get_note(t, object.hash);
+	note = get_note(t, &object);
 
 	prepare_note_data(&object, &d, edit && note ? note->hash : NULL);
 
@@ -616,7 +616,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 
 	if (d.buf.len || allow_empty) {
 		write_note_data(&d, new_note.hash);
-		if (add_note(t, object.hash, new_note.hash, combine_notes_overwrite))
+		if (add_note(t, &object, &new_note, combine_notes_overwrite))
 			die("BUG: combine_notes_overwrite failed");
 		logmsg = xstrfmt("Notes added by 'git notes %s'", argv[0]);
 	} else {
@@ -658,7 +658,7 @@ static int show(int argc, const char **argv, const char *prefix)
 		die(_("failed to resolve '%s' as a valid ref."), object_ref);
 
 	t = init_notes_check("show", 0);
-	note = get_note(t, object.hash);
+	note = get_note(t, &object);
 
 	if (!note)
 		retval = error(_("no note found for object %s."),
diff --git a/notes-cache.c b/notes-cache.c
index 6e84a748f..29b4cede5 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -74,7 +74,7 @@ char *notes_cache_get(struct notes_cache *c, struct object_id *key_oid,
 	char *value;
 	unsigned long size;
 
-	value_oid = get_note(&c->tree, key_oid->hash);
+	value_oid = get_note(&c->tree, key_oid);
 	if (!value_oid)
 		return NULL;
 	value = read_sha1_file(value_oid->hash, &type, &size);
@@ -90,5 +90,5 @@ int notes_cache_put(struct notes_cache *c, struct object_id *key_oid,
 
 	if (write_sha1_file(data, size, "blob", value_oid.hash) < 0)
 		return -1;
-	return add_note(&c->tree, key_oid->hash, value_oid.hash, NULL);
+	return add_note(&c->tree, key_oid, &value_oid, NULL);
 }
diff --git a/notes-merge.c b/notes-merge.c
index 6244f6af9..9a1a49506 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -444,14 +444,14 @@ static int merge_one_change(struct notes_merge_options *o,
 		if (o->verbosity >= 2)
 			printf("Using remote notes for %s\n",
 						oid_to_hex(&p->obj));
-		if (add_note(t, p->obj.hash, p->remote.hash, combine_notes_overwrite))
+		if (add_note(t, &p->obj, &p->remote, combine_notes_overwrite))
 			die("BUG: combine_notes_overwrite failed");
 		return 0;
 	case NOTES_MERGE_RESOLVE_UNION:
 		if (o->verbosity >= 2)
 			printf("Concatenating local and remote notes for %s\n",
 							oid_to_hex(&p->obj));
-		if (add_note(t, p->obj.hash, p->remote.hash, combine_notes_concatenate))
+		if (add_note(t, &p->obj, &p->remote, combine_notes_concatenate))
 			die("failed to concatenate notes "
 			    "(combine_notes_concatenate)");
 		return 0;
@@ -459,7 +459,7 @@ static int merge_one_change(struct notes_merge_options *o,
 		if (o->verbosity >= 2)
 			printf("Concatenating unique lines in local and remote "
 				"notes for %s\n", oid_to_hex(&p->obj));
-		if (add_note(t, p->obj.hash, p->remote.hash, combine_notes_cat_sort_uniq))
+		if (add_note(t, &p->obj, &p->remote, combine_notes_cat_sort_uniq))
 			die("failed to concatenate notes "
 			    "(combine_notes_cat_sort_uniq)");
 		return 0;
@@ -491,7 +491,7 @@ static int merge_changes(struct notes_merge_options *o,
 			   !oidcmp(&p->local, &p->base)) {
 			/* no local change; adopt remote change */
 			trace_printf("\t\t\tno local change, adopted remote\n");
-			if (add_note(t, p->obj.hash, p->remote.hash,
+			if (add_note(t, &p->obj, &p->remote,
 				     combine_notes_overwrite))
 				die("BUG: combine_notes_overwrite failed");
 		} else {
@@ -693,12 +693,12 @@ int notes_merge_commit(struct notes_merge_options *o,
 	baselen = path.len;
 	while ((e = readdir(dir)) != NULL) {
 		struct stat st;
-		unsigned char obj_sha1[20], blob_sha1[20];
+		struct object_id obj_oid, blob_oid;
 
 		if (is_dot_or_dotdot(e->d_name))
 			continue;
 
-		if (strlen(e->d_name) != 40 || get_sha1_hex(e->d_name, obj_sha1)) {
+		if (get_oid_hex(e->d_name, &obj_oid)) {
 			if (o->verbosity >= 3)
 				printf("Skipping non-SHA1 entry '%s%s'\n",
 					path.buf, e->d_name);
@@ -709,14 +709,14 @@ int notes_merge_commit(struct notes_merge_options *o,
 		/* write file as blob, and add to partial_tree */
 		if (stat(path.buf, &st))
 			die_errno("Failed to stat '%s'", path.buf);
-		if (index_path(blob_sha1, path.buf, &st, HASH_WRITE_OBJECT))
+		if (index_path(blob_oid.hash, path.buf, &st, HASH_WRITE_OBJECT))
 			die("Failed to write blob object from '%s'", path.buf);
-		if (add_note(partial_tree, obj_sha1, blob_sha1, NULL))
+		if (add_note(partial_tree, &obj_oid, &blob_oid, NULL))
 			die("Failed to add resolved note '%s' to notes tree",
 			    path.buf);
 		if (o->verbosity >= 4)
 			printf("Added resolved note for object %s: %s\n",
-				sha1_to_hex(obj_sha1), sha1_to_hex(blob_sha1));
+				oid_to_hex(&obj_oid), oid_to_hex(&blob_oid));
 		strbuf_setlen(&path, baselen);
 	}
 
diff --git a/notes-utils.c b/notes-utils.c
index 7d7c22b43..b2aada90a 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -160,7 +160,7 @@ int copy_note_for_rewrite(struct notes_rewrite_cfg *c,
 	int ret = 0;
 	int i;
 	for (i = 0; c->trees[i]; i++)
-		ret = copy_note(c->trees[i], from_obj->hash, to_obj->hash, 1, c->combine) || ret;
+		ret = copy_note(c->trees[i], from_obj, to_obj, 1, c->combine) || ret;
 	return ret;
 }
 
diff --git a/notes.c b/notes.c
index b5cabafde..4b3a1adda 100644
--- a/notes.c
+++ b/notes.c
@@ -1086,8 +1086,8 @@ void init_display_notes(struct display_notes_opt *opt)
 	string_list_clear(&display_notes_refs, 0);
 }
 
-int add_note(struct notes_tree *t, const unsigned char *object_sha1,
-		const unsigned char *note_sha1, combine_notes_fn combine_notes)
+int add_note(struct notes_tree *t, const struct object_id *object_oid,
+		const struct object_id *note_oid, combine_notes_fn combine_notes)
 {
 	struct leaf_node *l;
 
@@ -1098,8 +1098,8 @@ int add_note(struct notes_tree *t, const unsigned char *object_sha1,
 	if (!combine_notes)
 		combine_notes = t->combine_notes;
 	l = (struct leaf_node *) xmalloc(sizeof(struct leaf_node));
-	hashcpy(l->key_oid.hash, object_sha1);
-	hashcpy(l->val_oid.hash, note_sha1);
+	oidcpy(&l->key_oid, object_oid);
+	oidcpy(&l->val_oid, note_oid);
 	return note_tree_insert(t, t->root, 0, l, PTR_TYPE_NOTE, combine_notes);
 }
 
@@ -1120,14 +1120,14 @@ int remove_note(struct notes_tree *t, const unsigned char *object_sha1)
 }
 
 const struct object_id *get_note(struct notes_tree *t,
-		const unsigned char *object_sha1)
+		const struct object_id *oid)
 {
 	struct leaf_node *found;
 
 	if (!t)
 		t = &default_notes_tree;
 	assert(t->initialized);
-	found = note_tree_find(t, t->root, 0, object_sha1);
+	found = note_tree_find(t, t->root, 0, oid->hash);
 	return found ? &found->val_oid : NULL;
 }
 
@@ -1229,7 +1229,7 @@ static void format_note(struct notes_tree *t, const struct object_id *object_oid
 	if (!t->initialized)
 		init_notes(t, NULL, NULL, 0);
 
-	oid = get_note(t, object_oid->hash);
+	oid = get_note(t, object_oid);
 	if (!oid)
 		return;
 
@@ -1288,7 +1288,7 @@ void format_display_notes(const struct object_id *object_oid,
 }
 
 int copy_note(struct notes_tree *t,
-	      const unsigned char *from_obj, const unsigned char *to_obj,
+	      const struct object_id *from_obj, const struct object_id *to_obj,
 	      int force, combine_notes_fn combine_notes)
 {
 	const struct object_id *note = get_note(t, from_obj);
@@ -1298,9 +1298,9 @@ int copy_note(struct notes_tree *t,
 		return 1;
 
 	if (note)
-		return add_note(t, to_obj, note->hash, combine_notes);
+		return add_note(t, to_obj, note, combine_notes);
 	else if (existing_note)
-		return add_note(t, to_obj, null_sha1, combine_notes);
+		return add_note(t, to_obj, &null_oid, combine_notes);
 
 	return 0;
 }
diff --git a/notes.h b/notes.h
index a66532103..3848c2fb3 100644
--- a/notes.h
+++ b/notes.h
@@ -121,8 +121,8 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
  * are not persistent until a subsequent call to write_notes_tree() returns
  * zero.
  */
-int add_note(struct notes_tree *t, const unsigned char *object_sha1,
-		const unsigned char *note_sha1, combine_notes_fn combine_notes);
+int add_note(struct notes_tree *t, const struct object_id *object_oid,
+		const struct object_id *note_oid, combine_notes_fn combine_notes);
 
 /*
  * Remove the given note object from the given notes_tree structure
@@ -141,7 +141,7 @@ int remove_note(struct notes_tree *t, const unsigned char *object_sha1);
  * Return NULL if the given object has no notes.
  */
 const struct object_id *get_note(struct notes_tree *t,
-		const unsigned char *object_sha1);
+		const struct object_id *object_oid);
 
 /*
  * Copy a note from one object to another in the given notes_tree.
@@ -156,7 +156,7 @@ const struct object_id *get_note(struct notes_tree *t,
  * zero.
  */
 int copy_note(struct notes_tree *t,
-	      const unsigned char *from_obj, const unsigned char *to_obj,
+	      const struct object_id *from_obj, const struct object_id *to_obj,
 	      int force, combine_notes_fn combine_notes);
 
 /*
diff --git a/remote-testsvn.c b/remote-testsvn.c
index 017af1bd5..8e8d5c794 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -51,7 +51,7 @@ static void terminate_batch(void)
 }
 
 /* NOTE: 'ref' refers to a git reference, while 'rev' refers to a svn revision. */
-static char *read_ref_note(const unsigned char sha1[20])
+static char *read_ref_note(const struct object_id *oid)
 {
 	const struct object_id *note_oid;
 	char *msg = NULL;
@@ -59,7 +59,7 @@ static char *read_ref_note(const unsigned char sha1[20])
 	enum object_type type;
 
 	init_notes(NULL, notes_ref, NULL, 0);
-	if (!(note_oid = get_note(NULL, sha1)))
+	if (!(note_oid = get_note(NULL, oid)))
 		return NULL;	/* note tree not found */
 	if (!(msg = read_sha1_file(note_oid->hash, &type, &msglen)))
 		error("Empty notes tree. %s", notes_ref);
@@ -174,15 +174,15 @@ static int cmd_import(const char *line)
 	int code;
 	int dumpin_fd;
 	char *note_msg;
-	unsigned char head_sha1[20];
+	struct object_id head_oid;
 	unsigned int startrev;
 	struct child_process svndump_proc = CHILD_PROCESS_INIT;
 	const char *command = "svnrdump";
 
-	if (read_ref(private_ref, head_sha1))
+	if (read_ref(private_ref, head_oid.hash))
 		startrev = 0;
 	else {
-		note_msg = read_ref_note(head_sha1);
+		note_msg = read_ref_note(&head_oid);
 		if(note_msg == NULL) {
 			warning("No note found for %s.", private_ref);
 			startrev = 0;
-- 
2.13.0.219.gdb65acc882-goog

