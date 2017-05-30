Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BB8D2027C
	for <e@80x24.org>; Tue, 30 May 2017 17:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751163AbdE3Rbc (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:31:32 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36242 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750871AbdE3RbX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:31:23 -0400
Received: by mail-pf0-f179.google.com with SMTP id m17so78250546pfg.3
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5x6XhpecBcuxjdzPs4RD8MMZ4A3pt8ZjeNNBI/AYndA=;
        b=aNk2q1Hh6hGnWkPOKAx59cJ0lsbCRyTvmwlaYrYd6Mcncl49x64f2BriRvr7AoNAbz
         pep83QUBxWVpJ7zeKHxweijziRpeYMrrUMIFmGGGmoibgKQZkjRzC9izREF6NPaROtO2
         2z0dUQcUoH6yWtreuERDoBIcu9HGiQJEXTYa2m+GXquT8/Lcdbdj/2ar3grEBl+iGISa
         2G9mq0I9enFCaDGsJ0OorGYvKrLWThqh/bvmmniY2LLIhX5kzSOhBwyn5sF+3IndFQHM
         Paj/xbZLAFfOysp9LbXQbBx2nqfYcaFNsdCksBbGooACcS+NCWDS5SCwNZtRBtgbbcXr
         /sNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5x6XhpecBcuxjdzPs4RD8MMZ4A3pt8ZjeNNBI/AYndA=;
        b=WjSKDBnhE2EWV7sboj6rkqxMzCI9yj1YuEUzwslPONctiRYgq4Oz3uNlAXdBIHnpgJ
         WO1DubGseXaX7i6IL2gLxgT/pAIjD5whhA+P5JZpkGvAK6v7HSXH8hBr91G+cbN9z6Qm
         4zz6mg+Mris86OxalR93d9vOEd0k4uaILflca9nc/V77hiz5wfeT+um7JcYCxPhcG9aM
         E0B8hqOXJAmxVDYzSYLR0UD6s5iEL88Vh/dhb1M2g3ns/LsNah3EXAOrFl6pHG8SxUQU
         5fn4CbLNYkui6o5dmQ5Lgz1uVlJD0745m0yYYapPt/cJ1viItRQf8jEwkrbXNFeVvt7h
         dJyA==
X-Gm-Message-State: AODbwcAiS6CURYvxRhlZvmoy0t4Gj8ZeJjQyMOYZRzhJRVrUkGg6mpUH
        mjzbO7WYSAPgwbPXTwzuuw==
X-Received: by 10.98.59.2 with SMTP id i2mr24757029pfa.50.1496165481399;
        Tue, 30 May 2017 10:31:21 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t19sm24940187pfg.31.2017.05.30.10.31.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 May 2017 10:31:20 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sandals@crustytoothpaste.net,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 04/33] notes: make get_note return pointer to struct object_id
Date:   Tue, 30 May 2017 10:30:40 -0700
Message-Id: <20170530173109.54904-5-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170530173109.54904-1-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <sandals@crustytoothpaste.net>

Make get_note return a pointer to a const struct object_id.  Add a
defensive check to ensure we don't accidentally dereference a NULL
pointer.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/notes.c  | 22 +++++++++++-----------
 notes-cache.c    |  8 ++++----
 notes.c          | 18 +++++++++---------
 notes.h          |  2 +-
 remote-testsvn.c |  6 +++---
 5 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 53fe6d34d..3d9005b8f 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -351,7 +351,7 @@ static int list(int argc, const char **argv, const char *prefix)
 {
 	struct notes_tree *t;
 	unsigned char object[20];
-	const unsigned char *note;
+	const struct object_id *note;
 	int retval = -1;
 	struct option options[] = {
 		OPT_END()
@@ -372,7 +372,7 @@ static int list(int argc, const char **argv, const char *prefix)
 			die(_("failed to resolve '%s' as a valid ref."), argv[0]);
 		note = get_note(t, object);
 		if (note) {
-			puts(sha1_to_hex(note));
+			puts(oid_to_hex(note));
 			retval = 0;
 		} else
 			retval = error(_("no note found for object %s."),
@@ -392,7 +392,7 @@ static int add(int argc, const char **argv, const char *prefix)
 	const char *object_ref;
 	struct notes_tree *t;
 	unsigned char object[20], new_note[20];
-	const unsigned char *note;
+	const struct object_id *note;
 	struct note_data d = { 0, 0, NULL, STRBUF_INIT };
 	struct option options[] = {
 		{ OPTION_CALLBACK, 'm', "message", &d, N_("message"),
@@ -453,7 +453,7 @@ static int add(int argc, const char **argv, const char *prefix)
 			sha1_to_hex(object));
 	}
 
-	prepare_note_data(object, &d, note);
+	prepare_note_data(object, &d, note->hash);
 	if (d.buf.len || allow_empty) {
 		write_note_data(&d, new_note);
 		if (add_note(t, object, new_note, combine_notes_overwrite))
@@ -474,7 +474,7 @@ static int add(int argc, const char **argv, const char *prefix)
 static int copy(int argc, const char **argv, const char *prefix)
 {
 	int retval = 0, force = 0, from_stdin = 0;
-	const unsigned char *from_note, *note;
+	const struct object_id *from_note, *note;
 	const char *object_ref;
 	unsigned char object[20], from_obj[20];
 	struct notes_tree *t;
@@ -539,7 +539,7 @@ static int copy(int argc, const char **argv, const char *prefix)
 		goto out;
 	}
 
-	if (add_note(t, object, from_note, combine_notes_overwrite))
+	if (add_note(t, object, from_note->hash, combine_notes_overwrite))
 		die("BUG: combine_notes_overwrite failed");
 	commit_notes(t, "Notes added by 'git notes copy'");
 out:
@@ -553,7 +553,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 	const char *object_ref;
 	struct notes_tree *t;
 	unsigned char object[20], new_note[20];
-	const unsigned char *note;
+	const struct object_id *note;
 	char *logmsg;
 	const char * const *usage;
 	struct note_data d = { 0, 0, NULL, STRBUF_INIT };
@@ -598,13 +598,13 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 	t = init_notes_check(argv[0], NOTES_INIT_WRITABLE);
 	note = get_note(t, object);
 
-	prepare_note_data(object, &d, edit ? note : NULL);
+	prepare_note_data(object, &d, edit && note ? note->hash : NULL);
 
 	if (note && !edit) {
 		/* Append buf to previous note contents */
 		unsigned long size;
 		enum object_type type;
-		char *prev_buf = read_sha1_file(note, &type, &size);
+		char *prev_buf = read_sha1_file(note->hash, &type, &size);
 
 		strbuf_grow(&d.buf, size + 1);
 		if (d.buf.len && prev_buf && size)
@@ -638,7 +638,7 @@ static int show(int argc, const char **argv, const char *prefix)
 	const char *object_ref;
 	struct notes_tree *t;
 	unsigned char object[20];
-	const unsigned char *note;
+	const struct object_id *note;
 	int retval;
 	struct option options[] = {
 		OPT_END()
@@ -664,7 +664,7 @@ static int show(int argc, const char **argv, const char *prefix)
 		retval = error(_("no note found for object %s."),
 			       sha1_to_hex(object));
 	else {
-		const char *show_args[3] = {"show", sha1_to_hex(note), NULL};
+		const char *show_args[3] = {"show", oid_to_hex(note), NULL};
 		retval = execv_git_cmd(show_args);
 	}
 	free_notes(t);
diff --git a/notes-cache.c b/notes-cache.c
index 2843e9857..6e84a748f 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -69,15 +69,15 @@ int notes_cache_write(struct notes_cache *c)
 char *notes_cache_get(struct notes_cache *c, struct object_id *key_oid,
 		      size_t *outsize)
 {
-	const unsigned char *value_sha1;
+	const struct object_id *value_oid;
 	enum object_type type;
 	char *value;
 	unsigned long size;
 
-	value_sha1 = get_note(&c->tree, key_oid->hash);
-	if (!value_sha1)
+	value_oid = get_note(&c->tree, key_oid->hash);
+	if (!value_oid)
 		return NULL;
-	value = read_sha1_file(value_sha1, &type, &size);
+	value = read_sha1_file(value_oid->hash, &type, &size);
 
 	*outsize = size;
 	return value;
diff --git a/notes.c b/notes.c
index e881c10ee..fe4db2c1e 100644
--- a/notes.c
+++ b/notes.c
@@ -1119,7 +1119,7 @@ int remove_note(struct notes_tree *t, const unsigned char *object_sha1)
 	return 0;
 }
 
-const unsigned char *get_note(struct notes_tree *t,
+const struct object_id *get_note(struct notes_tree *t,
 		const unsigned char *object_sha1)
 {
 	struct leaf_node *found;
@@ -1128,7 +1128,7 @@ const unsigned char *get_note(struct notes_tree *t,
 		t = &default_notes_tree;
 	assert(t->initialized);
 	found = note_tree_find(t, t->root, 0, object_sha1);
-	return found ? found->val_oid.hash : NULL;
+	return found ? &found->val_oid : NULL;
 }
 
 int for_each_note(struct notes_tree *t, int flags, each_note_fn fn,
@@ -1219,7 +1219,7 @@ static void format_note(struct notes_tree *t, const unsigned char *object_sha1,
 			struct strbuf *sb, const char *output_encoding, int raw)
 {
 	static const char utf8[] = "utf-8";
-	const unsigned char *sha1;
+	const struct object_id *oid;
 	char *msg, *msg_p;
 	unsigned long linelen, msglen;
 	enum object_type type;
@@ -1229,11 +1229,11 @@ static void format_note(struct notes_tree *t, const unsigned char *object_sha1,
 	if (!t->initialized)
 		init_notes(t, NULL, NULL, 0);
 
-	sha1 = get_note(t, object_sha1);
-	if (!sha1)
+	oid = get_note(t, object_sha1);
+	if (!oid)
 		return;
 
-	if (!(msg = read_sha1_file(sha1, &type, &msglen)) || type != OBJ_BLOB) {
+	if (!(msg = read_sha1_file(oid->hash, &type, &msglen)) || type != OBJ_BLOB) {
 		free(msg);
 		return;
 	}
@@ -1291,14 +1291,14 @@ int copy_note(struct notes_tree *t,
 	      const unsigned char *from_obj, const unsigned char *to_obj,
 	      int force, combine_notes_fn combine_notes)
 {
-	const unsigned char *note = get_note(t, from_obj);
-	const unsigned char *existing_note = get_note(t, to_obj);
+	const struct object_id *note = get_note(t, from_obj);
+	const struct object_id *existing_note = get_note(t, to_obj);
 
 	if (!force && existing_note)
 		return 1;
 
 	if (note)
-		return add_note(t, to_obj, note, combine_notes);
+		return add_note(t, to_obj, note->hash, combine_notes);
 	else if (existing_note)
 		return add_note(t, to_obj, null_sha1, combine_notes);
 
diff --git a/notes.h b/notes.h
index 6651673ae..c72bb9710 100644
--- a/notes.h
+++ b/notes.h
@@ -140,7 +140,7 @@ int remove_note(struct notes_tree *t, const unsigned char *object_sha1);
  *
  * Return NULL if the given object has no notes.
  */
-const unsigned char *get_note(struct notes_tree *t,
+const struct object_id *get_note(struct notes_tree *t,
 		const unsigned char *object_sha1);
 
 /*
diff --git a/remote-testsvn.c b/remote-testsvn.c
index 793c4ad1d..017af1bd5 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -53,15 +53,15 @@ static void terminate_batch(void)
 /* NOTE: 'ref' refers to a git reference, while 'rev' refers to a svn revision. */
 static char *read_ref_note(const unsigned char sha1[20])
 {
-	const unsigned char *note_sha1;
+	const struct object_id *note_oid;
 	char *msg = NULL;
 	unsigned long msglen;
 	enum object_type type;
 
 	init_notes(NULL, notes_ref, NULL, 0);
-	if (!(note_sha1 = get_note(NULL, sha1)))
+	if (!(note_oid = get_note(NULL, sha1)))
 		return NULL;	/* note tree not found */
-	if (!(msg = read_sha1_file(note_sha1, &type, &msglen)))
+	if (!(msg = read_sha1_file(note_oid->hash, &type, &msglen)))
 		error("Empty notes tree. %s", notes_ref);
 	else if (!msglen || type != OBJ_BLOB) {
 		error("Note contains unusable content. "
-- 
2.13.0.219.gdb65acc882-goog

