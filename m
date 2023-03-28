Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC2AC6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 14:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbjC1O3M (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 10:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbjC1O3J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 10:29:09 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B5FC164
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 07:29:02 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id kc4so11811436plb.10
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 07:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680013741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBE4whyzRLAaBnjAAwoSEBp5NJW6myC3Mi7AfDcIqEc=;
        b=DbMxM5CKjRtHSOm0Z+Uhoaj7Ulpi6AEQ8VJa96jw2PHv+lTJ7z5fJ54WWxWoJcZ1mA
         2EAo6+h5vw92tOXtcc2ybqeII4f7sN+KN2hJJQkto99ZdSeWe1NwF8soQuqehpeiXeVz
         HH2DbpMe2fI+hBr5ub0DBHRx8EDRann6h1XFKKjwyZIieCRKYsn48iT8ZloTC2hbnrev
         ukPrPV2beP5NNbGH30PB1fbMEFUcPsYU8JtwwYFkQVANgLu9XFGZgjLoM/SO0PDuFuGg
         F6cdUlKw4Jxo7EUTfOW/ZqQ8LMB3OVhDxGtk837dLYiWk8TcfQEJimqaCxj5/L28OrTN
         WVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680013741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBE4whyzRLAaBnjAAwoSEBp5NJW6myC3Mi7AfDcIqEc=;
        b=tIv4rPlaOQP3Xwju+X0NCSENqeRkwWQQrJtZ11cwa3kAMaHPZE+vU/4SqG8QuOYoQk
         olt93OiELqdRgrtuTmzpKZM7nWcN2AxuKY9LXE1xwiToV5MWN2ofvikzxLIxHI3ySlyP
         sZpb5wzH4YlmOo4obc7BpXoeg/oCRn7ahYvC4D0E9F0SWZMTSGb4cThrlezITiHp/KW4
         C5010gcrXkxgUab1EIxdT8L2CNx6Vv30dK2LRMQOI/eAHcrbWvv1WuAo7brqDfrxBQ7n
         89fUxIDAOCYx+TY1+GFK4cMKYFCnQzPKn95lwO0j1u9d4JYz7McXlnohZSpdohJ1UwNt
         H8wg==
X-Gm-Message-State: AAQBX9f9p4QZL+2rjlb4muTlO0z2J3KKav9W4gNJLp8PACGPp9xPv/Ys
        qf+E3Wql4oyrjoFIU1W+FKA=
X-Google-Smtp-Source: AKy350bggO0EvtElvVlP08ICQXIQGbg4bmkA/n6pcYVbRPPAcbU/WLt2lfdcW6/X6dyxpNNaSOsvMQ==
X-Received: by 2002:a17:902:e394:b0:1a1:903f:de61 with SMTP id g20-20020a170902e39400b001a1903fde61mr11756024ple.63.1680013741624;
        Tue, 28 Mar 2023 07:29:01 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.62])
        by smtp.gmail.com with ESMTPSA id bg9-20020a1709028e8900b0019cbabf127dsm21189275plb.182.2023.03.28.07.28.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Mar 2023 07:29:01 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v7 3/4] notes.c: introduce '--separator=<paragraph-break>' option
Date:   Tue, 28 Mar 2023 22:28:46 +0800
Message-Id: <d1febf86d8471c24c9a045d6962fd86f63f414d5.1680012650.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.40.0.rc2.4.gb9d12f0c
In-Reply-To: <cover.1680012650.git.dyroneteng@gmail.com>
References: <cover.1680012650.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

When adding new notes or appending to an existing notes, we will
insert a blank line between the paragraphs, like:

     $ git notes add -m foo -m bar
     $ git notes show HEAD | cat
     foo

     bar

The default behavour sometimes is not enough, the user may want
to use a custom delimiter between paragraphs, like when
specifiy '-m', '-F', '-C', '-c' options. So this commit
introduce a new '--separator' option for 'git notes add' and
'git notes append', for example when execute:

    $ git notes add -m foo -m bar --separator="-"
    $ git notes show HEAD | cat
    foo
    -
    bar

A newline is added to the value given to --separator if it
does not end with one already. So execute:

      $ git notes add -m foo -m bar --separator="-"
and
      $ export LF="
      "
      $ git notes add -m foo -m bar --separator="-$LF"

Running A and B produces the same result.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/git-notes.txt |  21 ++++--
 builtin/notes.c             | 105 ++++++++++++++++++++++-------
 t/t3301-notes.sh            | 127 ++++++++++++++++++++++++++++++++++++
 3 files changed, 224 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index efbc10f0..59980b21 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -9,9 +9,9 @@ SYNOPSIS
 --------
 [verse]
 'git notes' [list [<object>]]
-'git notes' add [-f] [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
+'git notes' add [-f] [--allow-empty] [--separator=<paragraph-break>] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
 'git notes' copy [-f] ( --stdin | <from-object> [<to-object>] )
-'git notes' append [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
+'git notes' append [--allow-empty] [--separator=<paragraph-break>] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
 'git notes' edit [--allow-empty] [<object>]
 'git notes' show [<object>]
 'git notes' merge [-v | -q] [-s <strategy> ] <notes-ref>
@@ -65,7 +65,9 @@ add::
 	However, if you're using `add` interactively (using an editor
 	to supply the notes contents), then - instead of aborting -
 	the existing notes will be opened in the editor (like the `edit`
-	subcommand).
+	subcommand). If you specify multiple `-m` and `-F`, a blank
+	line will be inserted between the messages. Use the `--separator`
+	option to insert other delimiters.
 
 copy::
 	Copy the notes for the first object onto the second object (defaults to
@@ -85,8 +87,12 @@ corresponding <to-object>.  (The optional `<rest>` is ignored so that
 the command can read the input given to the `post-rewrite` hook.)
 
 append::
-	Append to the notes of an existing object (defaults to HEAD).
-	Creates a new notes object if needed.
+	Append new message(s) given by `-m` or `-F` options to an
+	existing note, or add them as a new note if one does not
+	exist, for the object (defaults to HEAD).  When appending to
+	an existing note, a blank line is added before each new
+	message as an inter-paragraph separator.  The separator can
+	be customized with the `--separator` option.
 
 edit::
 	Edit the notes for a given object (defaults to HEAD).
@@ -159,6 +165,11 @@ OPTIONS
 	Allow an empty note object to be stored. The default behavior is
 	to automatically remove empty notes.
 
+--separator <paragraph-break>::
+	Specify a string used as a custom inter-paragraph separator
+	(a newline is added at the end as needed).  Defaults to a
+	blank line.
+
 --ref <ref>::
 	Manipulate the notes tree in <ref>.  This overrides
 	`GIT_NOTES_REF` and the "core.notesRef" configuration.  The ref
diff --git a/builtin/notes.c b/builtin/notes.c
index 553ae2bd..94b69607 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -24,11 +24,12 @@
 #include "notes-utils.h"
 #include "worktree.h"
 
+static char *separator = NULL;
 static const char * const git_notes_usage[] = {
 	N_("git notes [--ref <notes-ref>] [list [<object>]]"),
-	N_("git notes [--ref <notes-ref>] add [-f] [--allow-empty] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
+	N_("git notes [--ref <notes-ref>] add [-f] [--allow-empty] [--separator=<paragraph-break>] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
 	N_("git notes [--ref <notes-ref>] copy [-f] <from-object> <to-object>"),
-	N_("git notes [--ref <notes-ref>] append [--allow-empty] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
+	N_("git notes [--ref <notes-ref>] append [--allow-empty] [--separator=<paragraph-break>] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
 	N_("git notes [--ref <notes-ref>] edit [--allow-empty] [<object>]"),
 	N_("git notes [--ref <notes-ref>] show [<object>]"),
 	N_("git notes [--ref <notes-ref>] merge [-v | -q] [-s <strategy>] <notes-ref>"),
@@ -101,6 +102,9 @@ struct note_data {
 	int use_editor;
 	char *edit_path;
 	struct strbuf buf;
+	struct strbuf **messages;
+	size_t msg_nr;
+	size_t msg_alloc;
 };
 
 static void free_note_data(struct note_data *d)
@@ -209,71 +213,110 @@ static void write_note_data(struct note_data *d, struct object_id *oid)
 	}
 }
 
+static void insert_separator(struct strbuf *message, size_t pos)
+{
+	if (!separator)
+		strbuf_insertstr(message, pos, "\n");
+	else if (separator[strlen(separator) - 1] == '\n')
+		strbuf_insertstr(message, pos, separator);
+	else
+		strbuf_insertf(message, pos, "%s%s", separator, "\n");
+}
+
+/* Consume messages and append them into d->buf, then free them */
+static void concat_messages(struct note_data *d)
+{
+	struct strbuf msg = STRBUF_INIT;
+
+	size_t i;
+	for (i = 0; i < d->msg_nr ; i++) {
+		if (d->buf.len)
+			insert_separator(&d->buf, d->buf.len);
+		strbuf_add(&msg, d->messages[i]->buf, d->messages[i]->len);
+		strbuf_addbuf(&d->buf, &msg);
+		strbuf_reset(&msg);
+		strbuf_release(d->messages[i]);
+		free(d->messages[i]);
+	}
+	strbuf_release(&msg);
+	free(d->messages);
+}
+
 static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
 {
 	struct note_data *d = opt->value;
+	struct strbuf *buf;
 
 	BUG_ON_OPT_NEG(unset);
 
-	if (d->buf.len)
-		strbuf_addch(&d->buf, '\n');
-	strbuf_addstr(&d->buf, arg);
-	strbuf_stripspace(&d->buf, 0);
+	buf = xmalloc(sizeof(*buf));
+	strbuf_init(buf, strlen(arg));
+	strbuf_addstr(buf, arg);
+	strbuf_stripspace(buf, 0);
 
-	d->given = 1;
+	ALLOC_GROW_BY(d->messages, d->msg_nr, 1, d->msg_alloc);
+	d->messages[d->msg_nr - 1] = buf;
 	return 0;
 }
 
 static int parse_file_arg(const struct option *opt, const char *arg, int unset)
 {
 	struct note_data *d = opt->value;
+	struct strbuf *buf;
 
 	BUG_ON_OPT_NEG(unset);
 
-	if (d->buf.len)
-		strbuf_addch(&d->buf, '\n');
+	buf = xmalloc(sizeof(*buf));
+	strbuf_init(buf, 0);
+
 	if (!strcmp(arg, "-")) {
-		if (strbuf_read(&d->buf, 0, 1024) < 0)
+		if (strbuf_read(buf, 0, 1024) < 0)
 			die_errno(_("cannot read '%s'"), arg);
-	} else if (strbuf_read_file(&d->buf, arg, 1024) < 0)
+	} else if (strbuf_read_file(buf, arg, 1024) < 0)
 		die_errno(_("could not open or read '%s'"), arg);
-	strbuf_stripspace(&d->buf, 0);
+	strbuf_stripspace(buf, 0);
 
-	d->given = 1;
+	// we will note stripspace the buf here, because the file maybe
+	// is a binary and it maybe contains multiple continuous line breaks.
+	ALLOC_GROW_BY(d->messages, d->msg_nr, 1, d->msg_alloc);
+	d->messages[d->msg_nr - 1] = buf;
 	return 0;
 }
 
 static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
 {
 	struct note_data *d = opt->value;
-	char *buf;
+	struct strbuf *buf;
 	struct object_id object;
 	enum object_type type;
 	unsigned long len;
 
 	BUG_ON_OPT_NEG(unset);
 
-	if (d->buf.len)
-		strbuf_addch(&d->buf, '\n');
-
+	buf = xmalloc(sizeof(*buf));
 	if (get_oid(arg, &object))
 		die(_("failed to resolve '%s' as a valid ref."), arg);
-	if (!(buf = read_object_file(&object, &type, &len)))
+	if (!(buf->buf = read_object_file(&object, &type, &len)))
 		die(_("failed to read object '%s'."), arg);
 	if (type != OBJ_BLOB) {
+		strbuf_release(buf);
 		free(buf);
 		die(_("cannot read note data from non-blob object '%s'."), arg);
 	}
-	strbuf_add(&d->buf, buf, len);
-	free(buf);
 
-	d->given = 1;
+	// The reuse object maybe is a binary content which could
+	// contains '\0' in the middle, so let's set the correct
+	// lenth of strbuf to concat all of content.
+	buf->len = len;
+	ALLOC_GROW_BY(d->messages, d->msg_nr, 1, d->msg_alloc);
+	d->messages[d->msg_nr - 1] = buf;
 	return 0;
 }
 
 static int parse_reedit_arg(const struct option *opt, const char *arg, int unset)
 {
 	struct note_data *d = opt->value;
+
 	BUG_ON_OPT_NEG(unset);
 	d->use_editor = 1;
 	return parse_reuse_arg(opt, arg, unset);
@@ -401,7 +444,8 @@ static int add(int argc, const char **argv, const char *prefix)
 	struct notes_tree *t;
 	struct object_id object, new_note;
 	const struct object_id *note;
-	struct note_data d = { .buf = STRBUF_INIT };
+	struct note_data d = { .buf = STRBUF_INIT, .messages = NULL };
+
 	struct option options[] = {
 		OPT_CALLBACK_F('m', "message", &d, N_("message"),
 			N_("note contents as a string"), PARSE_OPT_NONEG,
@@ -418,6 +462,8 @@ static int add(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "allow-empty", &allow_empty,
 			N_("allow storing empty note")),
 		OPT__FORCE(&force, N_("replace existing notes"), PARSE_OPT_NOCOMPLETE),
+		OPT_STRING(0, "separator", &separator, N_("separator"),
+			N_("insert <paragraph-break> between paragraphs")),
 		OPT_END()
 	};
 
@@ -429,6 +475,10 @@ static int add(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_notes_add_usage, options);
 	}
 
+	if (d.msg_nr)
+		concat_messages(&d);
+	d.given = !!d.buf.len;
+
 	object_ref = argc > 1 ? argv[1] : "HEAD";
 
 	if (get_oid(object_ref, &object))
@@ -567,7 +617,8 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 	const struct object_id *note;
 	char *logmsg;
 	const char * const *usage;
-	struct note_data d = { .buf = STRBUF_INIT };
+	struct note_data d = { .buf = STRBUF_INIT, .messages = NULL };
+
 	struct option options[] = {
 		OPT_CALLBACK_F('m', "message", &d, N_("message"),
 			N_("note contents as a string"), PARSE_OPT_NONEG,
@@ -583,6 +634,8 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 			parse_reuse_arg),
 		OPT_BOOL(0, "allow-empty", &allow_empty,
 			N_("allow storing empty note")),
+		OPT_STRING(0, "separator", &separator, N_("separator"),
+			N_("insert <paragraph-break> between paragraphs")),
 		OPT_END()
 	};
 	int edit = !strcmp(argv[0], "edit");
@@ -596,6 +649,10 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		usage_with_options(usage, options);
 	}
 
+	if (d.msg_nr)
+		concat_messages(&d);
+	d.given = !!d.buf.len;
+
 	if (d.given && edit)
 		fprintf(stderr, _("The -m/-F/-c/-C options have been deprecated "
 			"for the 'edit' subcommand.\n"
@@ -618,7 +675,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		char *prev_buf = read_object_file(note, &type, &size);
 
 		if (d.buf.len && prev_buf && size)
-			strbuf_insertstr(&d.buf, 0, "\n");
+			insert_separator(&d.buf, 0);
 		if (prev_buf && size)
 			strbuf_insert(&d.buf, 0, prev_buf, size);
 		free(prev_buf);
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 3288aaec..716192b5 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -5,6 +5,7 @@
 
 test_description='Test commit notes'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 write_script fake_editor <<\EOF
@@ -362,6 +363,7 @@ test_expect_success 'do not create empty note with -m ""' '
 '
 
 test_expect_success 'create note with combination of -m and -F' '
+	test_when_finished git notes remove HEAD &&
 	cat >expect-combine_m_and_F <<-EOF &&
 		foo
 
@@ -380,6 +382,25 @@ test_expect_success 'create note with combination of -m and -F' '
 	test_cmp expect-combine_m_and_F actual
 '
 
+test_expect_success 'create note with combination of -m and -F and --separator' '
+	cat >expect-combine_m_and_F <<-\EOF &&
+	foo
+	-------
+	xyzzy
+	-------
+	bar
+	-------
+	zyxxy
+	-------
+	baz
+	EOF
+	echo "xyzzy" >note_a &&
+	echo "zyxxy" >note_b &&
+	git notes add -m "foo" -F note_a -m "bar" -F note_b -m "baz" --separator "-------" &&
+	git notes show >actual &&
+	test_cmp expect-combine_m_and_F actual
+'
+
 test_expect_success 'remove note with "git notes remove"' '
 	git notes remove HEAD^ &&
 	git notes remove &&
@@ -521,6 +542,85 @@ test_expect_success 'listing non-existing notes fails' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'append: specify an empty separator' '
+	test_when_finished git notes remove HEAD &&
+	cat >expect <<-\EOF &&
+	notes-1
+
+	notes-2
+	EOF
+
+	git notes add -m "notes-1" &&
+	git notes append --separator="" -m "notes-2" &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'append: specify separator with line break' '
+	test_when_finished git notes remove HEAD &&
+	cat >expect <<-\EOF &&
+	notes-1
+	-------
+	notes-2
+	EOF
+
+	git notes add -m "notes-1" &&
+	git notes append --separator="-------$LF" -m "notes-2" &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'append: specify separator without line break' '
+	test_when_finished git notes remove HEAD &&
+	cat >expect <<-\EOF &&
+	notes-1
+	-------
+	notes-2
+	EOF
+
+	git notes add -m "notes-1" &&
+	git notes append --separator="-------" -m "notes-2" &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'append: specify separator with multiple messages' '
+	test_when_finished git notes remove HEAD &&
+	cat >expect <<-\EOF &&
+	notes-1
+	-------
+	notes-2
+	-------
+	notes-3
+	EOF
+
+	git notes add -m "notes-1" &&
+	git notes append --separator="-------" -m "notes-2" -m "notes-3" &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'append note with combination of -m and -F and --separator' '
+	test_when_finished git notes remove HEAD &&
+	cat >expect-combine_m_and_F <<-\EOF &&
+	m-notes-1
+	-------
+	f-notes-1
+	-------
+	m-notes-2
+	-------
+	f-notes-2
+	-------
+	m-notes-3
+	EOF
+
+	echo "f-notes-1" >note_a &&
+	echo "f-notes-2" >note_b &&
+	git notes append -m "m-notes-1" -F note_a -m "m-notes-2" -F note_b -m "m-notes-3" --separator "-------" &&
+	git notes show >actual &&
+	test_cmp expect-combine_m_and_F actual
+'
+
 test_expect_success 'append to existing note with "git notes append"' '
 	cat >expect <<-EOF &&
 		Initial set of notes
@@ -818,6 +918,33 @@ test_expect_success 'create note from blob with "git notes add -C" reuses blob i
 	test_cmp blob actual
 '
 
+test_expect_success 'create note from blob with "-C", also specify "-m", "-F" and "--separator"' '
+	# 8th will be reuseed in following tests, so rollback when the test is done
+	test_when_finished "git notes remove && git notes add -C $(cat blob)" &&
+	commit=$(git rev-parse HEAD) &&
+	cat >expect <<-EOF &&
+		commit $commit
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:20:13 2005 -0700
+
+		${indent}8th
+
+		Notes:
+		${indent}This is a blob object
+		${indent}-------
+		${indent}This is created by -m
+		${indent}-------
+		${indent}This is created by -F
+	EOF
+
+	git notes remove &&
+	echo "This is a blob object" | git hash-object -w --stdin >blob &&
+	echo "This is created by -F" >note_a &&
+	git notes add -C $(cat blob) -m "This is created by -m" -F note_a --separator="-------" &&
+	git log -1 >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'create note from other note with "git notes add -c"' '
 	test_commit 9th &&
 	commit=$(git rev-parse HEAD) &&
-- 
2.40.0.rc2.4.gb9d12f0c

