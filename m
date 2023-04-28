Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39A7C77B7C
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 09:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345451AbjD1JYD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 05:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345539AbjD1JX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 05:23:59 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3187468C
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 02:23:54 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b57c49c4cso7700589b3a.3
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 02:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682673834; x=1685265834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UosYcQykifpwor09cUERJH7EP11mJMbjtx4mo8ApxKo=;
        b=Sr3iBMVMnP74hpUDBGiajHliEXRP3VW0cxBIeU0x6/dq6d938iZRr7tCyimvTx0X/e
         x+lc/IFtdeBIv333EGeK/dXolHGTa4dAWhKHu3vVWy24BRBB1SFLjYcCWWSrJTvso+bS
         H63kJmAY9gxvckhN9pIL5fUfCGsjw+Il7SQT6C4fOnx3DuBoJ/Ii3qZwlPqCj3e29zYa
         ZB2oPM8dWnbwGuk2MBs7uBfBF6CuTxJy1Yv5et2vX3qd0tWaZyB0c+0dOzhgAe+U8nQa
         lbFwLirby7MrERbxQNweZmmj3DXWoD3e7fy1ydEbyAgtgU/QVPhi3ItMWsiLZ8c6URuG
         QrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682673834; x=1685265834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UosYcQykifpwor09cUERJH7EP11mJMbjtx4mo8ApxKo=;
        b=g8iS1II6D72YRMljc6oPL2Gxm7T9ry51c0b/3tICR6bFY1nfzusY6FVcNoEeN6x9LL
         k/zpRaE51kMX+iRmCQefi6aVMR6u8rxNmSfLWm16hK0VoBEbEQ2bPY7RVfyu8eA+MH11
         RK7CDFd2eVmWuICej5VT50V6dKp7987ookSFvQlwscaYa+I1IMME3jHJQmVbOawkj5Ug
         ZHm2RPn3vAcWlBM0GQAFyPxpd//tUY5mk4VFESQ7RuYvZmeuUE13LEYEVl9bff95NE4p
         jt0yx6+QwYIdIxUISASKyBAR0rCNA376D91SXOW7pmjR/RKUNB2k6Hr/V52iLHW65n9i
         yy+A==
X-Gm-Message-State: AC+VfDwcytyGkFXmRyvsEgc8Wp6DU2YUR8u509KpcZKPKqwphga5CT03
        gePO8R4944ISey2IO9kLuTW3uA+lzhYr7w==
X-Google-Smtp-Source: ACHHUZ6XFT/ZxBL+fiw/kgyJnVOfHRI6RtLy9nBxCu92P+lQOxGM599AGpZZDmC9BnHILuZc35R7dw==
X-Received: by 2002:a05:6a00:1385:b0:63d:4752:4da3 with SMTP id t5-20020a056a00138500b0063d47524da3mr8031682pfg.25.1682673834001;
        Fri, 28 Apr 2023 02:23:54 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.51])
        by smtp.gmail.com with ESMTPSA id i21-20020a056a00225500b0063b8f33cb81sm15107078pfu.93.2023.04.28.02.23.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Apr 2023 02:23:53 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v9 4/6] notes.c: introduce '--separator=<paragraph-break>' option
Date:   Fri, 28 Apr 2023 17:23:32 +0800
Message-ID: <ed930ef4f795f30792bc14d9c1939484e4976db8.1682671758.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.40.0.358.g2947072e.dirty
In-Reply-To: <cover.1682671758.git.dyroneteng@gmail.com>
References: <cover.1682671758.git.dyroneteng@gmail.com>
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

The reason we use a "strbuf" array to concat but not "string_list", is
that the binary file content may contain '\0' in the middle, this will
cause the corrupt result if using a string to save.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/git-notes.txt |  21 ++++--
 builtin/notes.c             | 108 ++++++++++++++++++++++++-------
 t/t3301-notes.sh            | 126 ++++++++++++++++++++++++++++++++++++
 3 files changed, 226 insertions(+), 29 deletions(-)

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
index 9d8ca795..3215bce1 100644
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
 
+static char *separator = "\n";
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
@@ -213,65 +229,96 @@ static void write_note_data(struct note_data *d, struct object_id *oid)
 	}
 }
 
+static void insert_separator(struct strbuf *message, size_t pos)
+{
+	if (separator[strlen(separator) - 1] == '\n')
+		strbuf_addstr(message, separator);
+	else
+		strbuf_insertf(message, pos, "%s%s", separator, "\n");
+}
+
+static void concat_messages(struct note_data *d)
+{
+	struct strbuf msg = STRBUF_INIT;
+
+	size_t i;
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
 
@@ -406,6 +453,7 @@ static int add(int argc, const char **argv, const char *prefix)
 	struct object_id object, new_note;
 	const struct object_id *note;
 	struct note_data d = { .buf = STRBUF_INIT };
+
 	struct option options[] = {
 		OPT_CALLBACK_F('m', "message", &d, N_("message"),
 			N_("note contents as a string"), PARSE_OPT_NONEG,
@@ -422,6 +470,8 @@ static int add(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "allow-empty", &allow_empty,
 			N_("allow storing empty note")),
 		OPT__FORCE(&force, N_("replace existing notes"), PARSE_OPT_NOCOMPLETE),
+		OPT_STRING(0, "separator", &separator, N_("separator"),
+			N_("insert <paragraph-break> between paragraphs")),
 		OPT_END()
 	};
 
@@ -433,6 +483,10 @@ static int add(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_notes_add_usage, options);
 	}
 
+	if (d.msg_nr)
+		concat_messages(&d);
+	d.given = !!d.buf.len;
+
 	object_ref = argc > 1 ? argv[1] : "HEAD";
 
 	if (repo_get_oid(the_repository, object_ref, &object))
@@ -587,6 +641,8 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 			parse_reuse_arg),
 		OPT_BOOL(0, "allow-empty", &allow_empty,
 			N_("allow storing empty note")),
+		OPT_STRING(0, "separator", &separator, N_("separator"),
+			N_("insert <paragraph-break> between paragraphs")),
 		OPT_END()
 	};
 	int edit = !strcmp(argv[0], "edit");
@@ -600,6 +656,10 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		usage_with_options(usage, options);
 	}
 
+	if (d.msg_nr)
+		concat_messages(&d);
+	d.given = !!d.buf.len;
+
 	if (d.given && edit)
 		fprintf(stderr, _("The -m/-F/-c/-C options have been deprecated "
 			"for the 'edit' subcommand.\n"
@@ -623,7 +683,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 						       &type, &size);
 
 		if (d.buf.len && prev_buf && size)
-			strbuf_insertstr(&d.buf, 0, "\n");
+			insert_separator(&d.buf, 0);
 		if (prev_buf && size)
 			strbuf_insert(&d.buf, 0, prev_buf, size);
 		free(prev_buf);
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 3288aaec..dbadcf13 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -362,6 +362,7 @@ test_expect_success 'do not create empty note with -m ""' '
 '
 
 test_expect_success 'create note with combination of -m and -F' '
+	test_when_finished git notes remove HEAD &&
 	cat >expect-combine_m_and_F <<-EOF &&
 		foo
 
@@ -380,6 +381,25 @@ test_expect_success 'create note with combination of -m and -F' '
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
@@ -521,6 +541,85 @@ test_expect_success 'listing non-existing notes fails' '
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
@@ -818,6 +917,33 @@ test_expect_success 'create note from blob with "git notes add -C" reuses blob i
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
2.40.0.358.g2947072e.dirty

