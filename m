Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A98682027C
	for <e@80x24.org>; Tue, 30 May 2017 17:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751085AbdE3Rb2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:31:28 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34405 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbdE3RbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:31:25 -0400
Received: by mail-pf0-f172.google.com with SMTP id 9so78318120pfj.1
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OPhC5x4u8Jma5Ux8fH8j0Wy+PNSmaf3wqjHFJ4/vwKY=;
        b=cPy7qeYNwdKws4MTjKKxIdqzE8ZR6h0lTI0mg4h87W7zJXG6LLXn9J9yewSUUiZ6gA
         oayFr4D7Ygg0Vajid7I518Ur4/uxJpPDbXrTUumjhM6+18PYYlyu8Lcc2dX1FYDbmgOA
         mRE6ow8d09lDgspwOxn3rexwn4hlhgyMUvaRo/2y3aJbJXfbbzCBsqNQo17XU93tq19z
         tdx27BatqCP0OERL8TRBXrqef7iwfMCCN4PJO37yz+71YJ0ID1EmTnlP9DEBLdMJJRLV
         MOhwBskgpnFrw9mkVyGZOBDHeHoM7MnJxw0Ow7Pof97twOOM32+OA+4X3KV1j3bpweEU
         2vnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OPhC5x4u8Jma5Ux8fH8j0Wy+PNSmaf3wqjHFJ4/vwKY=;
        b=mmaAT/0F+1QK17m9VAdHvTQ/2tLW2q8UmNwLH6ez+Ts4jNrs+AmmH6qAQfVmhvoUit
         7qY/IELwFSASMwAV7MbGLhNUApMCYWyUGp2uJQd5/fVlAR7J1UqsI5u6ijrovA/b6G1D
         b1WGJvCfjLiS1fhEEwa5V5tQf4KgEQpReD+30UvKvA6Ud8FWz9F1BElwuDFkm0lXm0X/
         v9KxTdaYkKVmCVzHpcZzV5CUIWm7xAY2AB4xsshgrJQaFzJJxVwkmQCxpaZpy+QU8fq9
         wlej8VxamAnpHuNg31t5RXOqW1MJeKHU/2bem/TtLZmduDvts35ntKA2fwLQN354207P
         K5rg==
X-Gm-Message-State: AODbwcCt1XdBiZY2zBJ2cR4ydgDhgC2nVhSeUICFoX3zPkTZvAMYiy26
        gC4PO8Arc0C5xNe9
X-Received: by 10.84.224.70 with SMTP id a6mr84982903plt.38.1496165484427;
        Tue, 30 May 2017 10:31:24 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t19sm24940187pfg.31.2017.05.30.10.31.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 May 2017 10:31:23 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sandals@crustytoothpaste.net,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 06/33] builtin/notes: convert to struct object_id
Date:   Tue, 30 May 2017 10:30:42 -0700
Message-Id: <20170530173109.54904-7-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170530173109.54904-1-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <sandals@crustytoothpaste.net>

Convert most of the static functions to use struct object_id.  In
addition, convert copy_notes_for_rewrite and its callers.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/am.c     |   2 +-
 builtin/commit.c |   2 +-
 builtin/notes.c  | 110 +++++++++++++++++++++++++++----------------------------
 notes-utils.c    |   4 +-
 notes-utils.h    |   2 +-
 5 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 0f63dcab1..d9fdddac4 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -563,7 +563,7 @@ static int copy_notes_for_rebase(const struct am_state *state)
 			goto finish;
 		}
 
-		if (copy_note_for_rewrite(c, from_obj.hash, to_obj.hash))
+		if (copy_note_for_rewrite(c, &from_obj, &to_obj))
 			ret = error(_("Failed to copy notes from '%s' to '%s'"),
 					oid_to_hex(&from_obj), oid_to_hex(&to_obj));
 	}
diff --git a/builtin/commit.c b/builtin/commit.c
index da1ba4c86..758781004 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1809,7 +1809,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		cfg = init_copy_notes_for_rewrite("amend");
 		if (cfg) {
 			/* we are amending, so current_head is not NULL */
-			copy_note_for_rewrite(cfg, current_head->object.oid.hash, oid.hash);
+			copy_note_for_rewrite(cfg, &current_head->object.oid, &oid);
 			finish_copy_notes_for_rewrite(cfg, "Notes added by 'git commit --amend'");
 		}
 		run_rewrite_hook(&current_head->object.oid, &oid);
diff --git a/builtin/notes.c b/builtin/notes.c
index 3d9005b8f..7947a16ed 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -129,10 +129,10 @@ static void copy_obj_to_fd(int fd, const unsigned char *sha1)
 	}
 }
 
-static void write_commented_object(int fd, const unsigned char *object)
+static void write_commented_object(int fd, const struct object_id *object)
 {
 	const char *show_args[5] =
-		{"show", "--stat", "--no-notes", sha1_to_hex(object), NULL};
+		{"show", "--stat", "--no-notes", oid_to_hex(object), NULL};
 	struct child_process show = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf cbuf = STRBUF_INIT;
@@ -145,7 +145,7 @@ static void write_commented_object(int fd, const unsigned char *object)
 	show.git_cmd = 1;
 	if (start_command(&show))
 		die(_("unable to start 'show' for object '%s'"),
-		    sha1_to_hex(object));
+		    oid_to_hex(object));
 
 	if (strbuf_read(&buf, show.out, 0) < 0)
 		die_errno(_("could not read 'show' output"));
@@ -157,10 +157,10 @@ static void write_commented_object(int fd, const unsigned char *object)
 
 	if (finish_command(&show))
 		die(_("failed to finish 'show' for object '%s'"),
-		    sha1_to_hex(object));
+		    oid_to_hex(object));
 }
 
-static void prepare_note_data(const unsigned char *object, struct note_data *d,
+static void prepare_note_data(const struct object_id *object, struct note_data *d,
 		const unsigned char *old_note)
 {
 	if (d->use_editor || !d->given) {
@@ -243,16 +243,16 @@ static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
 {
 	struct note_data *d = opt->value;
 	char *buf;
-	unsigned char object[20];
+	struct object_id object;
 	enum object_type type;
 	unsigned long len;
 
 	if (d->buf.len)
 		strbuf_addch(&d->buf, '\n');
 
-	if (get_sha1(arg, object))
+	if (get_oid(arg, &object))
 		die(_("failed to resolve '%s' as a valid ref."), arg);
-	if (!(buf = read_sha1_file(object, &type, &len))) {
+	if (!(buf = read_sha1_file(object.hash, &type, &len))) {
 		free(buf);
 		die(_("failed to read object '%s'."), arg);
 	}
@@ -292,7 +292,7 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 	}
 
 	while (strbuf_getline_lf(&buf, stdin) != EOF) {
-		unsigned char from_obj[20], to_obj[20];
+		struct object_id from_obj, to_obj;
 		struct strbuf **split;
 		int err;
 
@@ -301,15 +301,15 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 			die(_("malformed input line: '%s'."), buf.buf);
 		strbuf_rtrim(split[0]);
 		strbuf_rtrim(split[1]);
-		if (get_sha1(split[0]->buf, from_obj))
+		if (get_oid(split[0]->buf, &from_obj))
 			die(_("failed to resolve '%s' as a valid ref."), split[0]->buf);
-		if (get_sha1(split[1]->buf, to_obj))
+		if (get_oid(split[1]->buf, &to_obj))
 			die(_("failed to resolve '%s' as a valid ref."), split[1]->buf);
 
 		if (rewrite_cmd)
-			err = copy_note_for_rewrite(c, from_obj, to_obj);
+			err = copy_note_for_rewrite(c, &from_obj, &to_obj);
 		else
-			err = copy_note(t, from_obj, to_obj, force,
+			err = copy_note(t, from_obj.hash, to_obj.hash, force,
 					combine_notes_overwrite);
 
 		if (err) {
@@ -350,7 +350,7 @@ static struct notes_tree *init_notes_check(const char *subcommand,
 static int list(int argc, const char **argv, const char *prefix)
 {
 	struct notes_tree *t;
-	unsigned char object[20];
+	struct object_id object;
 	const struct object_id *note;
 	int retval = -1;
 	struct option options[] = {
@@ -368,15 +368,15 @@ static int list(int argc, const char **argv, const char *prefix)
 
 	t = init_notes_check("list", 0);
 	if (argc) {
-		if (get_sha1(argv[0], object))
+		if (get_oid(argv[0], &object))
 			die(_("failed to resolve '%s' as a valid ref."), argv[0]);
-		note = get_note(t, object);
+		note = get_note(t, object.hash);
 		if (note) {
 			puts(oid_to_hex(note));
 			retval = 0;
 		} else
 			retval = error(_("no note found for object %s."),
-				       sha1_to_hex(object));
+				       oid_to_hex(&object));
 	} else
 		retval = for_each_note(t, 0, list_each_note, NULL);
 
@@ -391,7 +391,7 @@ static int add(int argc, const char **argv, const char *prefix)
 	int force = 0, allow_empty = 0;
 	const char *object_ref;
 	struct notes_tree *t;
-	unsigned char object[20], new_note[20];
+	struct object_id object, new_note;
 	const struct object_id *note;
 	struct note_data d = { 0, 0, NULL, STRBUF_INIT };
 	struct option options[] = {
@@ -423,11 +423,11 @@ static int add(int argc, const char **argv, const char *prefix)
 
 	object_ref = argc > 1 ? argv[1] : "HEAD";
 
-	if (get_sha1(object_ref, object))
+	if (get_oid(object_ref, &object))
 		die(_("failed to resolve '%s' as a valid ref."), object_ref);
 
 	t = init_notes_check("add", NOTES_INIT_WRITABLE);
-	note = get_note(t, object);
+	note = get_note(t, object.hash);
 
 	if (note) {
 		if (!force) {
@@ -437,7 +437,7 @@ static int add(int argc, const char **argv, const char *prefix)
 				return error(_("Cannot add notes. "
 					"Found existing notes for object %s. "
 					"Use '-f' to overwrite existing notes"),
-					sha1_to_hex(object));
+					oid_to_hex(&object));
 			}
 			/*
 			 * Redirect to "edit" subcommand.
@@ -450,19 +450,19 @@ static int add(int argc, const char **argv, const char *prefix)
 			return append_edit(argc, argv, prefix);
 		}
 		fprintf(stderr, _("Overwriting existing notes for object %s\n"),
-			sha1_to_hex(object));
+			oid_to_hex(&object));
 	}
 
-	prepare_note_data(object, &d, note->hash);
+	prepare_note_data(&object, &d, note->hash);
 	if (d.buf.len || allow_empty) {
-		write_note_data(&d, new_note);
-		if (add_note(t, object, new_note, combine_notes_overwrite))
+		write_note_data(&d, new_note.hash);
+		if (add_note(t, object.hash, new_note.hash, combine_notes_overwrite))
 			die("BUG: combine_notes_overwrite failed");
 		commit_notes(t, "Notes added by 'git notes add'");
 	} else {
 		fprintf(stderr, _("Removing note for object %s\n"),
-			sha1_to_hex(object));
-		remove_note(t, object);
+			oid_to_hex(&object));
+		remove_note(t, object.hash);
 		commit_notes(t, "Notes removed by 'git notes add'");
 	}
 
@@ -476,7 +476,7 @@ static int copy(int argc, const char **argv, const char *prefix)
 	int retval = 0, force = 0, from_stdin = 0;
 	const struct object_id *from_note, *note;
 	const char *object_ref;
-	unsigned char object[20], from_obj[20];
+	struct object_id object, from_obj;
 	struct notes_tree *t;
 	const char *rewrite_cmd = NULL;
 	struct option options[] = {
@@ -509,37 +509,37 @@ static int copy(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_notes_copy_usage, options);
 	}
 
-	if (get_sha1(argv[0], from_obj))
+	if (get_oid(argv[0], &from_obj))
 		die(_("failed to resolve '%s' as a valid ref."), argv[0]);
 
 	object_ref = 1 < argc ? argv[1] : "HEAD";
 
-	if (get_sha1(object_ref, object))
+	if (get_oid(object_ref, &object))
 		die(_("failed to resolve '%s' as a valid ref."), object_ref);
 
 	t = init_notes_check("copy", NOTES_INIT_WRITABLE);
-	note = get_note(t, object);
+	note = get_note(t, object.hash);
 
 	if (note) {
 		if (!force) {
 			retval = error(_("Cannot copy notes. Found existing "
 				       "notes for object %s. Use '-f' to "
 				       "overwrite existing notes"),
-				       sha1_to_hex(object));
+				       oid_to_hex(&object));
 			goto out;
 		}
 		fprintf(stderr, _("Overwriting existing notes for object %s\n"),
-			sha1_to_hex(object));
+			oid_to_hex(&object));
 	}
 
-	from_note = get_note(t, from_obj);
+	from_note = get_note(t, from_obj.hash);
 	if (!from_note) {
 		retval = error(_("missing notes on source object %s. Cannot "
-			       "copy."), sha1_to_hex(from_obj));
+			       "copy."), oid_to_hex(&from_obj));
 		goto out;
 	}
 
-	if (add_note(t, object, from_note->hash, combine_notes_overwrite))
+	if (add_note(t, object.hash, from_note->hash, combine_notes_overwrite))
 		die("BUG: combine_notes_overwrite failed");
 	commit_notes(t, "Notes added by 'git notes copy'");
 out:
@@ -552,7 +552,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 	int allow_empty = 0;
 	const char *object_ref;
 	struct notes_tree *t;
-	unsigned char object[20], new_note[20];
+	struct object_id object, new_note;
 	const struct object_id *note;
 	char *logmsg;
 	const char * const *usage;
@@ -592,13 +592,13 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 
 	object_ref = 1 < argc ? argv[1] : "HEAD";
 
-	if (get_sha1(object_ref, object))
+	if (get_oid(object_ref, &object))
 		die(_("failed to resolve '%s' as a valid ref."), object_ref);
 
 	t = init_notes_check(argv[0], NOTES_INIT_WRITABLE);
-	note = get_note(t, object);
+	note = get_note(t, object.hash);
 
-	prepare_note_data(object, &d, edit && note ? note->hash : NULL);
+	prepare_note_data(&object, &d, edit && note ? note->hash : NULL);
 
 	if (note && !edit) {
 		/* Append buf to previous note contents */
@@ -615,14 +615,14 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 	}
 
 	if (d.buf.len || allow_empty) {
-		write_note_data(&d, new_note);
-		if (add_note(t, object, new_note, combine_notes_overwrite))
+		write_note_data(&d, new_note.hash);
+		if (add_note(t, object.hash, new_note.hash, combine_notes_overwrite))
 			die("BUG: combine_notes_overwrite failed");
 		logmsg = xstrfmt("Notes added by 'git notes %s'", argv[0]);
 	} else {
 		fprintf(stderr, _("Removing note for object %s\n"),
-			sha1_to_hex(object));
-		remove_note(t, object);
+			oid_to_hex(&object));
+		remove_note(t, object.hash);
 		logmsg = xstrfmt("Notes removed by 'git notes %s'", argv[0]);
 	}
 	commit_notes(t, logmsg);
@@ -637,7 +637,7 @@ static int show(int argc, const char **argv, const char *prefix)
 {
 	const char *object_ref;
 	struct notes_tree *t;
-	unsigned char object[20];
+	struct object_id object;
 	const struct object_id *note;
 	int retval;
 	struct option options[] = {
@@ -654,15 +654,15 @@ static int show(int argc, const char **argv, const char *prefix)
 
 	object_ref = argc ? argv[0] : "HEAD";
 
-	if (get_sha1(object_ref, object))
+	if (get_oid(object_ref, &object))
 		die(_("failed to resolve '%s' as a valid ref."), object_ref);
 
 	t = init_notes_check("show", 0);
-	note = get_note(t, object);
+	note = get_note(t, object.hash);
 
 	if (!note)
 		retval = error(_("no note found for object %s."),
-			       sha1_to_hex(object));
+			       oid_to_hex(&object));
 	else {
 		const char *show_args[3] = {"show", oid_to_hex(note), NULL};
 		retval = execv_git_cmd(show_args);
@@ -760,7 +760,7 @@ static int git_config_get_notes_strategy(const char *key,
 static int merge(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf remote_ref = STRBUF_INIT, msg = STRBUF_INIT;
-	unsigned char result_sha1[20];
+	struct object_id result_oid;
 	struct notes_tree *t;
 	struct notes_merge_options o;
 	int do_merge = 0, do_commit = 0, do_abort = 0;
@@ -842,16 +842,16 @@ static int merge(int argc, const char **argv, const char *prefix)
 		    remote_ref.buf, default_notes_ref());
 	strbuf_add(&(o.commit_msg), msg.buf + 7, msg.len - 7); /* skip "notes: " */
 
-	result = notes_merge(&o, t, result_sha1);
+	result = notes_merge(&o, t, result_oid.hash);
 
 	if (result >= 0) /* Merge resulted (trivially) in result_sha1 */
 		/* Update default notes ref with new commit */
-		update_ref(msg.buf, default_notes_ref(), result_sha1, NULL,
+		update_ref(msg.buf, default_notes_ref(), result_oid.hash, NULL,
 			   0, UPDATE_REFS_DIE_ON_ERR);
 	else { /* Merge has unresolved conflicts */
 		const struct worktree *wt;
 		/* Update .git/NOTES_MERGE_PARTIAL with partial merge result */
-		update_ref(msg.buf, "NOTES_MERGE_PARTIAL", result_sha1, NULL,
+		update_ref(msg.buf, "NOTES_MERGE_PARTIAL", result_oid.hash, NULL,
 			   0, UPDATE_REFS_DIE_ON_ERR);
 		/* Store ref-to-be-updated into .git/NOTES_MERGE_REF */
 		wt = find_shared_symref("NOTES_MERGE_REF", default_notes_ref());
@@ -878,10 +878,10 @@ static int merge(int argc, const char **argv, const char *prefix)
 static int remove_one_note(struct notes_tree *t, const char *name, unsigned flag)
 {
 	int status;
-	unsigned char sha1[20];
-	if (get_sha1(name, sha1))
+	struct object_id oid;
+	if (get_oid(name, &oid))
 		return error(_("Failed to resolve '%s' as a valid ref."), name);
-	status = remove_note(t, sha1);
+	status = remove_note(t, oid.hash);
 	if (status)
 		fprintf(stderr, _("Object %s has no note\n"), name);
 	else
diff --git a/notes-utils.c b/notes-utils.c
index 325ff3daa..7d7c22b43 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -155,12 +155,12 @@ struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd)
 }
 
 int copy_note_for_rewrite(struct notes_rewrite_cfg *c,
-			  const unsigned char *from_obj, const unsigned char *to_obj)
+			  const struct object_id *from_obj, const struct object_id *to_obj)
 {
 	int ret = 0;
 	int i;
 	for (i = 0; c->trees[i]; i++)
-		ret = copy_note(c->trees[i], from_obj, to_obj, 1, c->combine) || ret;
+		ret = copy_note(c->trees[i], from_obj->hash, to_obj->hash, 1, c->combine) || ret;
 	return ret;
 }
 
diff --git a/notes-utils.h b/notes-utils.h
index fa538e1d9..119057839 100644
--- a/notes-utils.h
+++ b/notes-utils.h
@@ -40,7 +40,7 @@ struct notes_rewrite_cfg {
 int parse_notes_merge_strategy(const char *v, enum notes_merge_strategy *s);
 struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd);
 int copy_note_for_rewrite(struct notes_rewrite_cfg *c,
-			  const unsigned char *from_obj, const unsigned char *to_obj);
+			  const struct object_id *from_obj, const struct object_id *to_obj);
 void finish_copy_notes_for_rewrite(struct notes_rewrite_cfg *c, const char *msg);
 
 #endif
-- 
2.13.0.219.gdb65acc882-goog

