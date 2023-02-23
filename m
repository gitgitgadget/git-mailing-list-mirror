Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B34C6379F
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 07:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbjBWHaH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 02:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbjBWHaD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 02:30:03 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F2032E41
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 23:30:01 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id f11so5713560pfe.2
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 23:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTmQ2D0GYskHZINr9pdOOdredVXz+J37y162csW7Lkk=;
        b=QtXskS+0DKatCUhBuCGW2dnsM8a0Jqg5Z3pozhIwGnXJ70zKa691EtPsRWpgofssEx
         ZyQrWaUVqRB8XCTJ7VMrDLWyaHpBFnOerHibO/tbLjmz3f0GNLt/Gf3g/wvS9UCt5IKz
         MpTo/wVd/U1pGCo3D3GYNU/jvCqhf1IEV1q1Rfgo/VMJXK1OyHh8KuLT2Yn38zkm0u6U
         B4LVTRjaKAcXapZeuW1OG3dOkl8GasOHfncSEy09DRNqhn1IvDIKDbeIp0bSSPeYKjyC
         Thuc9n7rM8yI1YWRYpjCt5iXgg7TvubBPRwuUD2UjTXuMS6fDbyF8TFOA8qJ0QzRSDYQ
         THuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTmQ2D0GYskHZINr9pdOOdredVXz+J37y162csW7Lkk=;
        b=LAZk7gv8USSvZ6I1qmiIScITyGQrNzV3QibwkadQn4G91/HjHKdHIKvZpNaI/EAyvv
         n/VMlHz/NITU/pzOdwaG+AmXb3IXag8RYlnyeA37KFNWoF0IWQ/om/Su/vCu06cMR+jC
         37gmGyxACUcU62tJkQ2AcxzGqW+CJtijm01+QiT8YxswScK1M8erC8B0+c1ANOtAun2L
         d+tjd9eO8nasjy/5+eYzxNj5ww2pPlsepxPoXQfKLejyZFxWO3xJpZYynxrGOghk77i0
         EtJIYCx4expvbM4waGQ081S+ad476Pz93gq2EXAX/9S0T+5TUSgJ04Bw18xh6cy9/MMT
         IwxA==
X-Gm-Message-State: AO0yUKW0BVyGk4z4fs6gq2cuMPWI8igVZNt1p51FvRmo69LI/UPM0tL8
        j7+akM1vvBrH4SXXxOQ8uwk=
X-Google-Smtp-Source: AK7set9LuohTgl6c1GkSJCkQz4Z6wzU/m3d7l+owbRE9NAFbFh2Gx5Bqv+cIVTgn5z0OxIDw1uWpAA==
X-Received: by 2002:a62:17c1:0:b0:593:c9b6:dc5d with SMTP id 184-20020a6217c1000000b00593c9b6dc5dmr10494371pfx.0.1677137400177;
        Wed, 22 Feb 2023 23:30:00 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.50])
        by smtp.gmail.com with ESMTPSA id u20-20020a62ed14000000b0059085684b54sm5570364pfh.140.2023.02.22.23.29.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Feb 2023 23:29:59 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com, gitster@pobox.com
Subject: [PATCH v6 3/3] notes.c: introduce '--separator=<paragraph-break>' option
Date:   Thu, 23 Feb 2023 15:29:47 +0800
Message-Id: <d5a6c74792c15e2f83c2ed0758fb99eac11a8174.1677136319.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.39.2.459.gd5a6c747
In-Reply-To: <cover.1677136319.git.dyroneteng@gmail.com>
References: <cover.1677136319.git.dyroneteng@gmail.com>
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
specifiy one or more '-m' or '-F' options. So this commit
introduces a new '--separator' option for 'git-notes-add' and
'git-notes-append', for example when execute:

    $ git notes add -m foo -m bar --separator="-"
    $ git notes show HEAD | cat
    foo
    -
    bar

We will check the option value and if the value doesn't contail
a trailing '\n', will add it automatically, so execute

      $ git notes add -m foo -m bar --separator="-"
and
      $ export LF="
      "
      $ git notes add -m foo -m bar --separator="-$LF"

have the same behavour.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/git-notes.txt |  20 ++++++--
 builtin/notes.c             |  72 ++++++++++++++++++--------
 t/t3301-notes.sh            | 100 ++++++++++++++++++++++++++++++++++++
 3 files changed, 166 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index efbc10f0..53d63888 100644
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
@@ -86,7 +88,13 @@ the command can read the input given to the `post-rewrite` hook.)
 
 append::
 	Append to the notes of an existing object (defaults to HEAD).
-	Creates a new notes object if needed.
+	Creates a new notes object if needed. 
+	The default delimiter is a blank line, use the `--separator`
+	option to insert other delimiters. More specifically, if the
+	note and the message are not empty, the delimiter will be
+	inserted between them. If you specify multiple `-m` and `-F`
+	options, the delimiter will be inserted between the messages
+	too.
 
 edit::
 	Edit the notes for a given object (defaults to HEAD).
@@ -159,6 +167,10 @@ OPTIONS
 	Allow an empty note object to be stored. The default behavior is
 	to automatically remove empty notes.
 
+--separator <paragraph-break>::
+	The '<paragraph-break>' inserted between paragraphs.
+	A blank line by default.
+
 --ref <ref>::
 	Manipulate the notes tree in <ref>.  This overrides
 	`GIT_NOTES_REF` and the "core.notesRef" configuration.  The ref
diff --git a/builtin/notes.c b/builtin/notes.c
index 553ae2bd..e0ada862 100644
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
@@ -209,37 +210,55 @@ static void write_note_data(struct note_data *d, struct object_id *oid)
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
+static void parse_messages(struct string_list *messages, struct note_data *d)
+{
+	size_t i;
+	for (i = 0; i < messages->nr; i++) {
+		if (d->buf.len)
+			insert_separator(&d->buf, d->buf.len);
+		strbuf_insertstr(&d->buf, d->buf.len,
+				 messages->items[i].string);
+		strbuf_stripspace(&d->buf, 0);
+		d->given = 1;
+	}
+}
+
 static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
 {
-	struct note_data *d = opt->value;
+	struct string_list *msg = opt->value;
 
 	BUG_ON_OPT_NEG(unset);
 
-	if (d->buf.len)
-		strbuf_addch(&d->buf, '\n');
-	strbuf_addstr(&d->buf, arg);
-	strbuf_stripspace(&d->buf, 0);
-
-	d->given = 1;
+	string_list_append(msg, arg);
 	return 0;
 }
 
+
 static int parse_file_arg(const struct option *opt, const char *arg, int unset)
 {
-	struct note_data *d = opt->value;
+	struct string_list *msg = opt->value;
+	struct strbuf buf = STRBUF_INIT;
 
 	BUG_ON_OPT_NEG(unset);
 
-	if (d->buf.len)
-		strbuf_addch(&d->buf, '\n');
 	if (!strcmp(arg, "-")) {
-		if (strbuf_read(&d->buf, 0, 1024) < 0)
+		if (strbuf_read(&buf, 0, 1024) < 0)
 			die_errno(_("cannot read '%s'"), arg);
-	} else if (strbuf_read_file(&d->buf, arg, 1024) < 0)
+	} else if (strbuf_read_file(&buf, arg, 1024) < 0)
 		die_errno(_("could not open or read '%s'"), arg);
-	strbuf_stripspace(&d->buf, 0);
 
-	d->given = 1;
+	string_list_append(msg, buf.buf);
+	strbuf_release(&buf);
 	return 0;
 }
 
@@ -402,11 +421,12 @@ static int add(int argc, const char **argv, const char *prefix)
 	struct object_id object, new_note;
 	const struct object_id *note;
 	struct note_data d = { .buf = STRBUF_INIT };
+	struct string_list messages = STRING_LIST_INIT_DUP;
 	struct option options[] = {
-		OPT_CALLBACK_F('m', "message", &d, N_("message"),
+		OPT_CALLBACK_F('m', "message", &messages, N_("message"),
 			N_("note contents as a string"), PARSE_OPT_NONEG,
 			parse_msg_arg),
-		OPT_CALLBACK_F('F', "file", &d, N_("file"),
+		OPT_CALLBACK_F('F', "file", &messages, N_("file"),
 			N_("note contents in a file"), PARSE_OPT_NONEG,
 			parse_file_arg),
 		OPT_CALLBACK_F('c', "reedit-message", &d, N_("object"),
@@ -418,6 +438,8 @@ static int add(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "allow-empty", &allow_empty,
 			N_("allow storing empty note")),
 		OPT__FORCE(&force, N_("replace existing notes"), PARSE_OPT_NOCOMPLETE),
+		OPT_STRING(0, "separator", &separator, N_("separator"),
+			N_("insert <paragraph-break> between paragraphs")),
 		OPT_END()
 	};
 
@@ -429,6 +451,7 @@ static int add(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_notes_add_usage, options);
 	}
 
+	parse_messages(&messages, &d);
 	object_ref = argc > 1 ? argv[1] : "HEAD";
 
 	if (get_oid(object_ref, &object))
@@ -568,11 +591,12 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 	char *logmsg;
 	const char * const *usage;
 	struct note_data d = { .buf = STRBUF_INIT };
+	struct string_list messages = STRING_LIST_INIT_DUP;
 	struct option options[] = {
-		OPT_CALLBACK_F('m', "message", &d, N_("message"),
-			N_("note contents as a string"), PARSE_OPT_NONEG,
+		OPT_CALLBACK_F('m', "message", &messages, N_("message"),
+			N_("note contents as a string"), PARSE_OPT_NONEG, 
 			parse_msg_arg),
-		OPT_CALLBACK_F('F', "file", &d, N_("file"),
+		OPT_CALLBACK_F('F', "file", &messages, N_("file"),
 			N_("note contents in a file"), PARSE_OPT_NONEG,
 			parse_file_arg),
 		OPT_CALLBACK_F('c', "reedit-message", &d, N_("object"),
@@ -583,6 +607,8 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 			parse_reuse_arg),
 		OPT_BOOL(0, "allow-empty", &allow_empty,
 			N_("allow storing empty note")),
+		OPT_STRING(0, "separator", &separator, N_("separator"),
+			N_("insert <paragraph-break> between paragraphs")),
 		OPT_END()
 	};
 	int edit = !strcmp(argv[0], "edit");
@@ -596,6 +622,8 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		usage_with_options(usage, options);
 	}
 
+	parse_messages(&messages, &d);
+
 	if (d.given && edit)
 		fprintf(stderr, _("The -m/-F/-c/-C options have been deprecated "
 			"for the 'edit' subcommand.\n"
@@ -618,7 +646,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		char *prev_buf = read_object_file(note, &type, &size);
 
 		if (d.buf.len && prev_buf && size)
-			strbuf_insertstr(&d.buf, 0, "\n");
+			insert_separator(&d.buf, 0);
 		if (prev_buf && size)
 			strbuf_insert(&d.buf, 0, prev_buf, size);
 		free(prev_buf);
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 3288aaec..c2c09f32 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -362,6 +362,7 @@ test_expect_success 'do not create empty note with -m ""' '
 '
 
 test_expect_success 'create note with combination of -m and -F' '
+	test_when_finished git notes remove HEAD &&
 	cat >expect-combine_m_and_F <<-EOF &&
 		foo
 
@@ -380,6 +381,26 @@ test_expect_success 'create note with combination of -m and -F' '
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
+	
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
-- 
2.39.2.459.gd5a6c747

