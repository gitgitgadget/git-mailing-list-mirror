Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81A4C7EE23
	for <git@archiver.kernel.org>; Thu, 18 May 2023 12:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjERMCq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 08:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjERMCj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 08:02:39 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8C0E4C
        for <git@vger.kernel.org>; Thu, 18 May 2023 05:02:34 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64d24136663so239831b3a.0
        for <git@vger.kernel.org>; Thu, 18 May 2023 05:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684411354; x=1687003354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leKsjfw/EgVM79GjhGocJy6eeBsAsNNB0AYTS24gvRk=;
        b=PWqDWgN0OeWGmaRC6n+t7LvSmVgphh1e/0CEvBK0YWgzcdQrhbbgzmmFpZPjf/b7sQ
         heo8bi/hmABXar25CCh6coZulI7U80NuEWTxkPlhEpNu2DIkXLTSsdcflvPIZsDRt+wd
         Pd6BEOJOtB06siBzeJZp8rAXzIjgJ09bMKQKPFMEPNcN87IwsVP6NHxhao10yRn7kKlU
         UmZShd+gFLV7CizmeCqo5JEC/u9GTx0vPE9EnOyV1wVm5Xfb3U6ynFkCQe8KXoDawHGG
         zbY8a3QX1gerbXtkODINLzYU8DoUb1+4h5Z5eKy4n+kcdfAwT6qpbHaCKixsrdlYqWGh
         LADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684411354; x=1687003354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=leKsjfw/EgVM79GjhGocJy6eeBsAsNNB0AYTS24gvRk=;
        b=MtxaCZIyoi+gumL8Qbhh/8RtJ1cI/5QK04Cd4Xq1fzbZ/9kG3HYff9yOZDZNGJgVgG
         FC1++LzWdEnLEoGTTSPM/MxcpSw7RAQVEwKZ5oQr5arzmCnRrKSYt4GVB5oBbGH4D3Gu
         y/OJ3q5Z0yXw8tgzb1opMZnBL0LnGjfwSHbVBley/NP9jR2tdaMRAizUqpDIL8VqTQ4I
         U4OIKowxrZeQiOnMIlVbkx7jpPoRGmJ8qTuDLT4cMrOdtzAUEbt08j6beW9gPhAeJhdc
         Q1xfHA/QHPS2Qh7Dz3UzN8p1HrRWkproOMKifx9QMprcsy3hIkqKonrWjabA7pzIYeI2
         Q7Ag==
X-Gm-Message-State: AC+VfDyS9cp3Ddmnp70T/ol4bvZpUD9mSRjko/Mz8LXn8eWsPKOHKpDM
        mFruIzUckwmE/S3wwHqMJlo=
X-Google-Smtp-Source: ACHHUZ7NbDKWoyRLAxuSUrkhv7LRwFwvBR/s5zQia/C+xq1UD/T/CkshzYflupJKf61+aGFz3WpR/g==
X-Received: by 2002:a05:6a20:840c:b0:f1:c63a:f7fa with SMTP id c12-20020a056a20840c00b000f1c63af7famr2006339pzd.15.1684411353825;
        Thu, 18 May 2023 05:02:33 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.51])
        by smtp.gmail.com with ESMTPSA id ji17-20020a170903325100b001960706141fsm1264203plb.149.2023.05.18.05.02.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 May 2023 05:02:33 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v10 4/6] notes.c: introduce '[--[no-]separator|--separator=<paragraph-break>]' option
Date:   Thu, 18 May 2023 20:02:09 +0800
Message-ID: <820dda0458994fdf7ff37870736ce6ed7871720c.1684411136.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.40.0.356.g67a1c1d0
In-Reply-To: <cover.1684411136.git.dyroneteng@gmail.com>
References: <cover.1684411136.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

When adding new notes or appending to an existing notes, we will
insert a blank line between the paragraphs, like:

     $ git notes add -m foo -m bar
     $ git notes show HEAD
     foo

     bar

The default behavour sometimes is not enough, the user may want
to use a custom delimiter between paragraphs, like when
specifying '-m', '-F', '-C', '-c' options. So this commit
introduce a new '--separator' option for 'git notes add' and
'git notes append', for example when executing:

    $ git notes add -m foo -m bar --separator="-"
    $ git notes show HEAD
    foo
    -
    bar

a newline is added to the value given to --separator if it
does not end with one already. So when executing:

      $ git notes add -m foo -m bar --separator="-"
and
      $ export LF="
      "
      $ git notes add -m foo -m bar --separator="-$LF"

Both the two exections produce the same result.

Alternatively, if you do not want any new paragraph
separators, even a newline by default, you can specify
'--no-separator'.

The reason we use a "strbuf" array to concat but not "string_list", is
that the binary file content may contain '\0' in the middle, this will
cause the corrupt result if using a string to save.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/git-notes.txt |  22 +++--
 builtin/notes.c             | 124 +++++++++++++++++++++-----
 t/t3301-notes.sh            | 169 ++++++++++++++++++++++++++++++++++++
 3 files changed, 286 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index efbc10f0..56d25a79 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -9,9 +9,9 @@ SYNOPSIS
 --------
 [verse]
 'git notes' [list [<object>]]
-'git notes' add [-f] [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
+'git notes' add [-f] [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
 'git notes' copy [-f] ( --stdin | <from-object> [<to-object>] )
-'git notes' append [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
+'git notes' append [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
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
@@ -159,6 +165,12 @@ OPTIONS
 	Allow an empty note object to be stored. The default behavior is
 	to automatically remove empty notes.
 
+--[no-]separator, --separator=<paragraph-break>::
+	Specify a string used as a custom inter-paragraph separator
+	(a newline is added at the end as needed). If `--no-separator`, no
+	separators will be added between paragraphs.  Defaults to a blank
+	line.
+
 --ref <ref>::
 	Manipulate the notes tree in <ref>.  This overrides
 	`GIT_NOTES_REF` and the "core.notesRef" configuration.  The ref
diff --git a/builtin/notes.c b/builtin/notes.c
index 9d8ca795..7aa2f923 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -8,6 +8,7 @@
  */
 
 #include "cache.h"
+#include "alloc.h"
 #include "config.h"
 #include "builtin.h"
 #include "gettext.h"
@@ -27,11 +28,12 @@
 #include "worktree.h"
 #include "write-or-die.h"
 
+static const char *separator = "\n";
 static const char * const git_notes_usage[] = {
 	N_("git notes [--ref <notes-ref>] [list [<object>]]"),
-	N_("git notes [--ref <notes-ref>] add [-f] [--allow-empty] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
+	N_("git notes [--ref <notes-ref>] add [-f] [--allow-empty] [--[no-]separator|--separator=<paragraph-break>] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
 	N_("git notes [--ref <notes-ref>] copy [-f] <from-object> <to-object>"),
-	N_("git notes [--ref <notes-ref>] append [--allow-empty] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
+	N_("git notes [--ref <notes-ref>] append [--allow-empty] [--[no-]separator|--separator=<paragraph-break>] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
 	N_("git notes [--ref <notes-ref>] edit [--allow-empty] [<object>]"),
 	N_("git notes [--ref <notes-ref>] show [<object>]"),
 	N_("git notes [--ref <notes-ref>] merge [-v | -q] [-s <strategy>] <notes-ref>"),
@@ -99,11 +101,19 @@ static const char * const git_notes_get_ref_usage[] = {
 static const char note_template[] =
 	N_("Write/edit the notes for the following object:");
 
+struct note_msg {
+	int stripspace;
+	struct strbuf buf;
+};
+
 struct note_data {
 	int given;
 	int use_editor;
 	char *edit_path;
 	struct strbuf buf;
+	struct note_msg **messages;
+	size_t msg_nr;
+	size_t msg_alloc;
 };
 
 static void free_note_data(struct note_data *d)
@@ -113,6 +123,12 @@ static void free_note_data(struct note_data *d)
 		free(d->edit_path);
 	}
 	strbuf_release(&d->buf);
+
+	while (d->msg_nr--) {
+		strbuf_release(&d->messages[d->msg_nr]->buf);
+		free(d->messages[d->msg_nr]);
+	}
+	free(d->messages);
 }
 
 static int list_each_note(const struct object_id *object_oid,
@@ -213,65 +229,98 @@ static void write_note_data(struct note_data *d, struct object_id *oid)
 	}
 }
 
+static void insert_separator(struct strbuf *message, size_t pos)
+{
+	if (!separator)
+		return;
+	else if (separator[strlen(separator) - 1] == '\n')
+		strbuf_insertstr(message, pos, separator);
+	else
+		strbuf_insertf(message, pos, "%s%s", separator, "\n");
+}
+
+static void concat_messages(struct note_data *d)
+{
+	struct strbuf msg = STRBUF_INIT;
+	size_t i;
+
+	for (i = 0; i < d->msg_nr ; i++) {
+		if (d->buf.len)
+			insert_separator(&d->buf, d->buf.len);
+		strbuf_add(&msg, d->messages[i]->buf.buf, d->messages[i]->buf.len);
+		strbuf_addbuf(&d->buf, &msg);
+		if (d->messages[i]->stripspace)
+			strbuf_stripspace(&d->buf, 0);
+		strbuf_reset(&msg);
+	}
+	strbuf_release(&msg);
+}
+
 static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
 {
 	struct note_data *d = opt->value;
+	struct note_msg *msg = xmalloc(sizeof(*msg));
 
 	BUG_ON_OPT_NEG(unset);
 
-	if (d->buf.len)
-		strbuf_addch(&d->buf, '\n');
-	strbuf_addstr(&d->buf, arg);
-	strbuf_stripspace(&d->buf, 0);
-
-	d->given = 1;
+	strbuf_init(&msg->buf, strlen(arg));
+	strbuf_addstr(&msg->buf, arg);
+	ALLOC_GROW_BY(d->messages, d->msg_nr, 1, d->msg_alloc);
+	d->messages[d->msg_nr - 1] = msg;
+	msg->stripspace = 1;
 	return 0;
 }
 
 static int parse_file_arg(const struct option *opt, const char *arg, int unset)
 {
 	struct note_data *d = opt->value;
+	struct note_msg *msg = xmalloc(sizeof(*msg));
 
 	BUG_ON_OPT_NEG(unset);
 
-	if (d->buf.len)
-		strbuf_addch(&d->buf, '\n');
+	strbuf_init(&msg->buf , 0);
 	if (!strcmp(arg, "-")) {
-		if (strbuf_read(&d->buf, 0, 1024) < 0)
+		if (strbuf_read(&msg->buf, 0, 1024) < 0)
 			die_errno(_("cannot read '%s'"), arg);
-	} else if (strbuf_read_file(&d->buf, arg, 1024) < 0)
+	} else if (strbuf_read_file(&msg->buf, arg, 1024) < 0)
 		die_errno(_("could not open or read '%s'"), arg);
-	strbuf_stripspace(&d->buf, 0);
 
-	d->given = 1;
+	ALLOC_GROW_BY(d->messages, d->msg_nr, 1, d->msg_alloc);
+	d->messages[d->msg_nr - 1] = msg;
+	msg->stripspace = 1;
 	return 0;
 }
 
 static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
 {
 	struct note_data *d = opt->value;
-	char *buf;
+	struct note_msg *msg = xmalloc(sizeof(*msg));
+	char *value;
 	struct object_id object;
 	enum object_type type;
 	unsigned long len;
 
 	BUG_ON_OPT_NEG(unset);
 
-	if (d->buf.len)
-		strbuf_addch(&d->buf, '\n');
-
+	strbuf_init(&msg->buf, 0);
 	if (repo_get_oid(the_repository, arg, &object))
 		die(_("failed to resolve '%s' as a valid ref."), arg);
-	if (!(buf = repo_read_object_file(the_repository, &object, &type, &len)))
+	if (!(value = repo_read_object_file(the_repository, &object, &type, &len)))
 		die(_("failed to read object '%s'."), arg);
 	if (type != OBJ_BLOB) {
-		free(buf);
+		strbuf_release(&msg->buf);
+		free(value);
+		free(msg);
 		die(_("cannot read note data from non-blob object '%s'."), arg);
 	}
-	strbuf_add(&d->buf, buf, len);
-	free(buf);
 
-	d->given = 1;
+	strbuf_add(&msg->buf, value, len);
+	free(value);
+
+	msg->buf.len = len;
+	ALLOC_GROW_BY(d->messages, d->msg_nr, 1, d->msg_alloc);
+	d->messages[d->msg_nr - 1] = msg;
+	msg->stripspace = 0;
 	return 0;
 }
 
@@ -283,6 +332,16 @@ static int parse_reedit_arg(const struct option *opt, const char *arg, int unset
 	return parse_reuse_arg(opt, arg, unset);
 }
 
+static int parse_separator_arg(const struct option *opt, const char *arg,
+			       int unset)
+{
+	if (unset)
+		*(const char **)opt->value = NULL;
+	else
+		*(const char **)opt->value = arg ? arg : "\n";
+	return 0;
+}
+
 static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -406,6 +465,7 @@ static int add(int argc, const char **argv, const char *prefix)
 	struct object_id object, new_note;
 	const struct object_id *note;
 	struct note_data d = { .buf = STRBUF_INIT };
+
 	struct option options[] = {
 		OPT_CALLBACK_F('m', "message", &d, N_("message"),
 			N_("note contents as a string"), PARSE_OPT_NONEG,
@@ -422,6 +482,10 @@ static int add(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "allow-empty", &allow_empty,
 			N_("allow storing empty note")),
 		OPT__FORCE(&force, N_("replace existing notes"), PARSE_OPT_NOCOMPLETE),
+		OPT_CALLBACK_F(0, "separator", &separator,
+			N_("<paragraph-break>"),
+			N_("insert <paragraph-break> between paragraphs"),
+			PARSE_OPT_OPTARG, parse_separator_arg),
 		OPT_END()
 	};
 
@@ -433,6 +497,10 @@ static int add(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_notes_add_usage, options);
 	}
 
+	if (d.msg_nr)
+		concat_messages(&d);
+	d.given = !!d.buf.len;
+
 	object_ref = argc > 1 ? argv[1] : "HEAD";
 
 	if (repo_get_oid(the_repository, object_ref, &object))
@@ -587,6 +655,10 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 			parse_reuse_arg),
 		OPT_BOOL(0, "allow-empty", &allow_empty,
 			N_("allow storing empty note")),
+		OPT_CALLBACK_F(0, "separator", &separator,
+			N_("<paragraph-break>"),
+			N_("insert <paragraph-break> between paragraphs"),
+			PARSE_OPT_OPTARG, parse_separator_arg),
 		OPT_END()
 	};
 	int edit = !strcmp(argv[0], "edit");
@@ -600,6 +672,10 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		usage_with_options(usage, options);
 	}
 
+	if (d.msg_nr)
+		concat_messages(&d);
+	d.given = !!d.buf.len;
+
 	if (d.given && edit)
 		fprintf(stderr, _("The -m/-F/-c/-C options have been deprecated "
 			"for the 'edit' subcommand.\n"
@@ -623,7 +699,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 						       &type, &size);
 
 		if (d.buf.len && prev_buf && size)
-			strbuf_insertstr(&d.buf, 0, "\n");
+			insert_separator(&d.buf, 0);
 		if (prev_buf && size)
 			strbuf_insert(&d.buf, 0, prev_buf, size);
 		free(prev_buf);
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 3288aaec..d734000d 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -362,6 +362,7 @@ test_expect_success 'do not create empty note with -m ""' '
 '
 
 test_expect_success 'create note with combination of -m and -F' '
+	test_when_finished git notes remove HEAD &&
 	cat >expect-combine_m_and_F <<-EOF &&
 		foo
 
@@ -380,6 +381,41 @@ test_expect_success 'create note with combination of -m and -F' '
 	test_cmp expect-combine_m_and_F actual
 '
 
+test_expect_success 'create note with combination of -m and -F and --separator' '
+	test_when_finished git notes remove HEAD &&
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
+	git notes add -m "foo" -F note_a -m "bar" -F note_b -m "baz" --separator="-------" &&
+	git notes show >actual &&
+	test_cmp expect-combine_m_and_F actual
+'
+
+test_expect_success 'create note with combination of -m and -F and --no-separator' '
+	cat >expect-combine_m_and_F <<-\EOF &&
+	foo
+	xyzzy
+	bar
+	zyxxy
+	baz
+	EOF
+	echo "xyzzy" >note_a &&
+	echo "zyxxy" >note_b &&
+	git notes add -m "foo" -F note_a -m "bar" -F note_b -m "baz" --no-separator &&
+	git notes show >actual &&
+	test_cmp expect-combine_m_and_F actual
+'
+
 test_expect_success 'remove note with "git notes remove"' '
 	git notes remove HEAD^ &&
 	git notes remove &&
@@ -521,6 +557,112 @@ test_expect_success 'listing non-existing notes fails' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'append: specify a separator with an empty arg' '
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
+test_expect_success 'append: specify a separator without arg' '
+	test_when_finished git notes remove HEAD &&
+	cat >expect <<-\EOF &&
+	notes-1
+
+	notes-2
+	EOF
+
+	git notes add -m "notes-1" &&
+	git notes append --separator -m "notes-2" &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'append: specify as --no-separator' '
+	test_when_finished git notes remove HEAD &&
+	cat >expect <<-\EOF &&
+	notes-1
+	notes-2
+	EOF
+
+	git notes add -m "notes-1" &&
+	git notes append --no-separator -m "notes-2" &&
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
+	git notes append -m "m-notes-1" -F note_a -m "m-notes-2" -F note_b -m "m-notes-3" --separator="-------" &&
+	git notes show >actual &&
+	test_cmp expect-combine_m_and_F actual
+'
+
 test_expect_success 'append to existing note with "git notes append"' '
 	cat >expect <<-EOF &&
 		Initial set of notes
@@ -818,6 +960,33 @@ test_expect_success 'create note from blob with "git notes add -C" reuses blob i
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
2.40.0.356.g67a1c1d0

