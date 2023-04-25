Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA74C77B71
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 13:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbjDYNfv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 09:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbjDYNf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 09:35:26 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B9F14476
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 06:35:03 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63f273b219eso2575232b3a.1
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 06:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682429702; x=1685021702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8zgUjmf+k/9+klnC13FESGBqC8+ySvhcQ5f6JRX3UA=;
        b=a2x+m36ba0EPsvY/00imdEGn/8cLpNxqCoPV6UqL1aMqA2du/HFW7AiOHxJ0OsPFeM
         /0Jy2409TOmZvQJdXv6ud4Bht3UNQMuOt02lXoFxkZYan3IgYED6oneZq/i4JIlgyptA
         e0q+UwjHb2u3bYmnfwr0I2pzjR5Cp+kN74226+AF+REzG8v3VVMEFdAjw+rMKSls3N8C
         cL3YFYdRnecCtwgY0jC+TSJLWYIrDEZ6eYJAjqCb81guWvVib89Q2VBgIxLTOfA42HNA
         X7IqKLyh/2+fYgsLQ7LcoYTLoYVg4jM39C4VQq0Xcq/CB0Gmt0TB9E5h0oaj07lGWz0Z
         syJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682429702; x=1685021702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8zgUjmf+k/9+klnC13FESGBqC8+ySvhcQ5f6JRX3UA=;
        b=MTcIHPPTam/c4ln+Q2q0f+obHXcUBspnjK+kAYNkBOTMs5cCBjUfTPBI2NeQQlMTen
         Z391DHWZauk1Qg79S12AolujICX5GdbhVanf/QaVcF6woL7oVxDSH3o2Ixgozfgo82Qp
         PIR0n8/1g2qiFC3j7dYrKDR696MpFMp+zkm8ZxSGgTaw5iPjlvNZMEgxjCnlAhTF9nHY
         EI16IHVrRgFR2lMJ1MhyfTIhRsmI0CwB3pzQ0e+sjWX3wVxALIOfXz6V8b44S4v44QcH
         A//ScfKvOrxb10sT+8yTA5qrVcNvaocHkNaCTa/MeoNoeNeEKAZX0TzX/WtjdFDbcS9x
         h+DQ==
X-Gm-Message-State: AAQBX9eOPrazmYiwBqaYheDXfOxJ2lWL0+q7+wean97ktWP8zJzWTFbN
        lTjeCSgn/VcBPCNOmYsZ/3w=
X-Google-Smtp-Source: AKy350boxuG1YTyQjZnD/a9gebAxrM9N82UWtedWK/72nB2cBZa1pt9oDqruuHdYEGoElP5w4XWBdQ==
X-Received: by 2002:a05:6a00:230b:b0:63b:8778:99e4 with SMTP id h11-20020a056a00230b00b0063b877899e4mr25286294pfh.2.1682429701646;
        Tue, 25 Apr 2023 06:35:01 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.60])
        by smtp.gmail.com with ESMTPSA id c192-20020a621cc9000000b0063d44634d8csm9243469pfc.71.2023.04.25.06.34.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2023 06:35:01 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v8 6/6] notes.c: introduce "--[no-]stripspace" option
Date:   Tue, 25 Apr 2023 21:34:41 +0800
Message-ID: <f60f743203d78a489b90df81472e71391b45367d.1682429602.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.40.0.358.g931d6dc6
In-Reply-To: <cover.1682429602.git.dyroneteng@gmail.com>
References: <cover.1682429602.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

This commit introduces a new option "--[no-]stripspace" to git notes
append, git notes edit, and git notes add. This option allows users to
control whether the note message need to stripped out.

For the consideration of backward compatibility, let's look at the
behavior about "stripspace" in "git notes" command:

1. "Edit Message" case: using the default editor to edit the note
message.

    In "edit" case, the edited message will always be stripped out, the
    implementation which can be found in the "prepare_note_data()". In
    addition, the "-c" option supports to reuse an existing blob as a
    note message, then open the editor to make a further edition on it,
    the edited message will be stripped.

    This commit doesn't change the default behavior of "edit" case by
    using an enum "notes_stripspace", only when "--no-stripspace" option
    is specified, the note message will not be stripped out. If you do
    not specify the option or you specify "--stripspace", clearly, the
    note message will be stripped out.

2. "Assign Message" case: using the "-m"/"-F"/"-C" option to specify the
note message.

    In "assign" case, when specify message by "-m" or "-F", the message
    will be stripped out by default, but when specify message by "-C",
    the message will be copied verbatim, in other word, the message will
    not be stripped out. One more thing need to note is "the order of
    the options matter", that is, if you specify "-C" before "-m" or
    "-F", the reused message by "-C" will be stripped out together,
    because everytime concat "-m" or "-F" message, the concated message
    will be stripped together. Oppositely, if you specify "-m" or "-F"
    before "-C", the reused message by "-C" will not be stripped out.

    This commit doesn't change the default behavior of "assign" case by
    extending the "stripspace" field in "struct note_msg", so we can
    distinguish the different behavior of "-m"/"-F" and "-C" options
    when we need to parse and concat the message.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/git-notes.txt |  25 ++-
 builtin/notes.c             |  30 +++-
 t/t3321-notes-stripspace.sh | 296 ++++++++++++++++++++++++++++++++----
 3 files changed, 304 insertions(+), 47 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 59980b21..5f3a9479 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -9,10 +9,10 @@ SYNOPSIS
 --------
 [verse]
 'git notes' [list [<object>]]
-'git notes' add [-f] [--allow-empty] [--separator=<paragraph-break>] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
+'git notes' add [-f] [--allow-empty] [--separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
 'git notes' copy [-f] ( --stdin | <from-object> [<to-object>] )
-'git notes' append [--allow-empty] [--separator=<paragraph-break>] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
-'git notes' edit [--allow-empty] [<object>]
+'git notes' append [--allow-empty] [--separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
+'git notes' edit [--allow-empty] [<object>] [--[no-]stripspace]
 'git notes' show [<object>]
 'git notes' merge [-v | -q] [-s <strategy> ] <notes-ref>
 'git notes' merge --commit [-v | -q]
@@ -141,20 +141,26 @@ OPTIONS
 	If multiple `-m` options are given, their values
 	are concatenated as separate paragraphs.
 	Lines starting with `#` and empty lines other than a
-	single line between paragraphs will be stripped out.
+	single line between paragraphs will be stripped out,
+	if you wish to keep them verbatim, use `--no-stripspace`.
 
 -F <file>::
 --file=<file>::
 	Take the note message from the given file.  Use '-' to
 	read the note message from the standard input.
 	Lines starting with `#` and empty lines other than a
-	single line between paragraphs will be stripped out.
+	single line between paragraphs will be stripped out,
+	if you wish to keep them verbatim, use with
+	`--no-stripspace` option.
 
 -C <object>::
 --reuse-message=<object>::
 	Take the given blob object (for example, another note) as the
 	note message. (Use `git notes copy <object>` instead to
-	copy notes between objects.)
+	copy notes between objects.).  By default, message will be
+	copied verbatim, but if you wish to strip out the lines
+	starting with `#` and empty lines other than a single line
+	between paragraphs, use with`--stripspace` option.
 
 -c <object>::
 --reedit-message=<object>::
@@ -170,6 +176,13 @@ OPTIONS
 	(a newline is added at the end as needed).  Defaults to a
 	blank line.
 
+--[no-]stripspace::
+	Strip leading and trailing whitespace from the note message.
+	Also strip out empty lines other than a single line between
+	paragraphs. For lines starting with `#` will be stripped out
+	in non-editor cases like "-m", "-F" and "-C", but not in
+	editor case like "git notes edit", "-c", etc.
+
 --ref <ref>::
 	Manipulate the notes tree in <ref>.  This overrides
 	`GIT_NOTES_REF` and the "core.notesRef" configuration.  The ref
diff --git a/builtin/notes.c b/builtin/notes.c
index 84bc09ed..b27d82d7 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -101,14 +101,21 @@ static const char * const git_notes_get_ref_usage[] = {
 static const char note_template[] =
 	N_("Write/edit the notes for the following object:");
 
+enum notes_stripspace {
+	UNSPECIFIED = -1,
+	NO_STRIPSPACE = 0,
+	STRIPSPACE = 1,
+};
+
 struct note_msg {
-	int stripspace;
+	enum notes_stripspace stripspace;
 	struct strbuf buf;
 };
 
 struct note_data {
 	int given;
 	int use_editor;
+	int stripspace;
 	char *edit_path;
 	struct strbuf buf;
 	struct note_msg **messages;
@@ -214,7 +221,8 @@ static void prepare_note_data(const struct object_id *object, struct note_data *
 		if (launch_editor(d->edit_path, &d->buf, NULL)) {
 			die(_("please supply the note contents using either -m or -F option"));
 		}
-		strbuf_stripspace(&d->buf, 1);
+		if (d->stripspace)
+			strbuf_stripspace(&d->buf, 1);
 	}
 }
 
@@ -250,7 +258,9 @@ static void concat_messages(struct note_data *d)
 			append_separator(&d->buf);
 		strbuf_add(&msg, d->messages[i]->buf.buf, d->messages[i]->buf.len);
 		strbuf_addbuf(&d->buf, &msg);
-		if (d->messages[i]->stripspace)
+		if ((d->stripspace == UNSPECIFIED &&
+		     d->messages[i]->stripspace == STRIPSPACE) ||
+		    d->stripspace == STRIPSPACE)
 			strbuf_stripspace(&d->buf, 0);
 		strbuf_reset(&msg);
 	}
@@ -268,7 +278,7 @@ static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
 	strbuf_addstr(&msg->buf, arg);
 	ALLOC_GROW_BY(d->messages, d->msg_nr, 1, d->msg_alloc);
 	d->messages[d->msg_nr - 1] = msg;
-	msg->stripspace = 1;
+	msg->stripspace = STRIPSPACE;
 	return 0;
 }
 
@@ -288,7 +298,7 @@ static int parse_file_arg(const struct option *opt, const char *arg, int unset)
 
 	ALLOC_GROW_BY(d->messages, d->msg_nr, 1, d->msg_alloc);
 	d->messages[d->msg_nr - 1] = msg;
-	msg->stripspace = 1;
+	msg->stripspace = STRIPSPACE;
 	return 0;
 }
 
@@ -321,7 +331,7 @@ static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
 	msg->buf.len = len;
 	ALLOC_GROW_BY(d->messages, d->msg_nr, 1, d->msg_alloc);
 	d->messages[d->msg_nr - 1] = msg;
-	msg->stripspace = 0;
+	msg->stripspace = NO_STRIPSPACE;
 	return 0;
 }
 
@@ -455,7 +465,7 @@ static int add(int argc, const char **argv, const char *prefix)
 	struct notes_tree *t;
 	struct object_id object, new_note;
 	const struct object_id *note;
-	struct note_data d = { .buf = STRBUF_INIT };
+	struct note_data d = { .buf = STRBUF_INIT, .stripspace = UNSPECIFIED };
 
 	struct option options[] = {
 		OPT_CALLBACK_F('m', "message", &d, N_("message"),
@@ -475,6 +485,8 @@ static int add(int argc, const char **argv, const char *prefix)
 		OPT__FORCE(&force, N_("replace existing notes"), PARSE_OPT_NOCOMPLETE),
 		OPT_STRING(0, "separator", &separator, N_("separator"),
 			N_("insert <paragraph-break> between paragraphs")),
+		OPT_BOOL(0, "stripspace", &d.stripspace,
+			N_("remove unnecessary whitespace")),
 		OPT_END()
 	};
 
@@ -628,7 +640,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 	const struct object_id *note;
 	char *logmsg;
 	const char * const *usage;
-	struct note_data d = { .buf = STRBUF_INIT };
+	struct note_data d = { .buf = STRBUF_INIT, .stripspace = UNSPECIFIED };
 	struct option options[] = {
 		OPT_CALLBACK_F('m', "message", &d, N_("message"),
 			N_("note contents as a string"), PARSE_OPT_NONEG,
@@ -646,6 +658,8 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 			N_("allow storing empty note")),
 		OPT_STRING(0, "separator", &separator, N_("separator"),
 			N_("insert <paragraph-break> between paragraphs")),
+		OPT_BOOL(0, "stripspace", &d.stripspace,
+			N_("remove unnecessary whitespace")),
 		OPT_END()
 	};
 	int edit = !strcmp(argv[0], "edit");
diff --git a/t/t3321-notes-stripspace.sh b/t/t3321-notes-stripspace.sh
index 7c26b184..8e921157 100755
--- a/t/t3321-notes-stripspace.sh
+++ b/t/t3321-notes-stripspace.sh
@@ -32,7 +32,7 @@ test_expect_success 'add note by editor' '
 	test_cmp expect actual
 '
 
-test_expect_success 'add note by specifying single "-m"' '
+test_expect_success 'add note by specifying single "-m", "--stripspace" is the default behavior' '
 	test_when_finished "git notes remove" &&
 	cat >expect <<-EOF &&
 		first-line
@@ -42,10 +42,26 @@ test_expect_success 'add note by specifying single "-m"' '
 
 	git notes add -m "${LF}first-line${MULTI_LF}second-line${LF}" &&
 	git notes show >actual &&
+	test_cmp expect actual &&
+	git notes remove &&
+	git notes add --stripspace -m "${LF}first-line${MULTI_LF}second-line${LF}" &&
+	git notes show >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success 'add note by specifying multiple "-m"' '
+test_expect_success 'add note by specifying single "-m" and "--no-stripspace" ' '
+	test_when_finished "git notes remove" &&
+	cat >expect <<-EOF &&
+		${LF}first-line${MULTI_LF}second-line
+	EOF
+
+	git notes add --no-stripspace \
+		      -m "${LF}first-line${MULTI_LF}second-line${LF}" &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'add note by specifying multiple "-m", "--stripspace" is the default behavior' '
 	test_when_finished "git notes remove" &&
 	cat >expect <<-EOF &&
 	first-line
@@ -59,25 +75,37 @@ test_expect_success 'add note by specifying multiple "-m"' '
 		      -m "second-line" \
 		      -m "${LF}" &&
 	git notes show >actual &&
+	test_cmp expect actual &&
+	git notes remove &&
+	git notes add --stripspace -m "${LF}" \
+		      -m "first-line" \
+		      -m "${MULTI_LF}" \
+		      -m "second-line" \
+		      -m "${LF}" &&
+	git notes show >actual &&
 	test_cmp expect actual
 '
 
-
-test_expect_success 'append note by editor' '
+test_expect_success 'add notes by specifying multiple "-m" and "--no-stripspace"' '
 	test_when_finished "git notes remove" &&
 	cat >expect <<-EOF &&
+		${LF}
 		first-line
-
-		second-line
+		${MULTI_LF}
+		second-line${LF}
 	EOF
 
-	git notes add -m "first-line" &&
-	MSG="${MULTI_LF}second-line${LF}" git notes append  &&
+	git notes add --no-stripspace \
+		      -m "${LF}" \
+		      -m "first-line" \
+		      -m "${MULTI_LF}" \
+		      -m "second-line" \
+		      -m "${LF}" &&
 	git notes show >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success 'append note by specifying single "-m"' '
+test_expect_success 'add note by specifying single "-F", "--stripspace" is the default behavior' '
 	test_when_finished "git notes remove" &&
 	cat >expect <<-EOF &&
 		first-line
@@ -85,34 +113,30 @@ test_expect_success 'append note by specifying single "-m"' '
 		second-line
 	EOF
 
-	git notes add -m "${LF}first-line" &&
-	git notes append -m "${MULTI_LF}second-line${LF}" &&
-	git notes show >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'append note by specifying multiple "-m"' '
-	test_when_finished "git notes remove" &&
-	cat >expect <<-EOF &&
-	first-line
-
-	second-line
+	cat >note-file <<-EOF &&
+		${LF}
+		first-line
+		${MULTI_LF}
+		second-line
+		${LF}
 	EOF
 
-	git notes add -m "${LF}first-line" &&
-	git notes append -m "${MULTI_LF}" \
-		      -m "second-line" \
-		      -m "${LF}" &&
+	git notes add -F note-file &&
 	git notes show >actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	git notes remove &&
+	git notes add --stripspace -F note-file &&
+	git notes show >actual
 '
 
-test_expect_success 'add note by specifying single "-F"' '
+test_expect_success 'add note by specifying single "-F" and "--no-stripspace"' '
 	test_when_finished "git notes remove" &&
 	cat >expect <<-EOF &&
+		${LF}
 		first-line
-
+		${MULTI_LF}
 		second-line
+		${LF}
 	EOF
 
 	cat >note-file <<-EOF &&
@@ -123,12 +147,12 @@ test_expect_success 'add note by specifying single "-F"' '
 		${LF}
 	EOF
 
-	git notes add -F note-file &&
+	git notes add --no-stripspace -F note-file &&
 	git notes show >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success 'add notes by specifying multiple "-F"' '
+test_expect_success 'add note by specifying multiple "-F", "--stripspace" is the default behavior' '
 	test_when_finished "git notes remove" &&
 	cat >expect <<-EOF &&
 		file-1-first-line
@@ -158,6 +182,89 @@ test_expect_success 'add notes by specifying multiple "-F"' '
 
 	git notes add -F note-file-1 -F note-file-2 &&
 	git notes show >actual &&
+	test_cmp expect actual &&
+	git notes remove &&
+	git notes add --stripspace -F note-file-1 -F note-file-2 &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'add note by specifying multiple "-F" with "--no-stripspace"' '
+	test_when_finished "git notes remove" &&
+	cat >expect <<-EOF &&
+		${LF}
+		file-1-first-line
+		${MULTI_LF}
+		file-1-second-line
+		${LF}
+
+		${LF}
+		file-2-first-line
+		${MULTI_LF}
+		file-2-second-line
+		${LF}
+	EOF
+
+	cat >note-file-1 <<-EOF &&
+		${LF}
+		file-1-first-line
+		${MULTI_LF}
+		file-1-second-line
+		${LF}
+	EOF
+
+	cat >note-file-2 <<-EOF &&
+		${LF}
+		file-2-first-line
+		${MULTI_LF}
+		file-2-second-line
+		${LF}
+	EOF
+
+	git notes add --no-stripspace -F note-file-1 -F note-file-2 &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'append note by editor' '
+	test_when_finished "git notes remove" &&
+	cat >expect <<-EOF &&
+		first-line
+
+		second-line
+	EOF
+
+	git notes add -m "first-line" &&
+	MSG="${MULTI_LF}second-line${LF}" git notes append  &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'append note by specifying single "-m"' '
+	test_when_finished "git notes remove" &&
+	cat >expect <<-EOF &&
+		first-line
+
+		second-line
+	EOF
+
+	git notes add -m "${LF}first-line" &&
+	git notes append -m "${MULTI_LF}second-line${LF}" &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'append note by specifying multiple "-m"' '
+	test_when_finished "git notes remove" &&
+	cat >expect <<-EOF &&
+	first-line
+
+	second-line
+	EOF
+
+	git notes add -m "${LF}first-line" &&
+	git notes append -m "${MULTI_LF}" -m "second-line" -m "${LF}" &&
+	git notes show >actual &&
 	test_cmp expect actual
 '
 
@@ -221,6 +328,45 @@ test_expect_success 'append notes by specifying multiple "-F"' '
 	test_cmp expect actual
 '
 
+test_expect_success 'append note by specifying multiple "-F" with "--no-stripspace"' '
+	test_when_finished "git notes remove" &&
+	cat >expect <<-EOF &&
+		initial-line
+		${LF}${LF}
+		file-1-first-line
+		${MULTI_LF}
+		file-1-second-line
+		${LF}
+
+		${LF}
+		file-2-first-line
+		${MULTI_LF}
+		file-2-second-line
+		${LF}
+	EOF
+
+	cat >note-file-1 <<-EOF &&
+		${LF}
+		file-1-first-line
+		${MULTI_LF}
+		file-1-second-line
+		${LF}
+	EOF
+
+	cat >note-file-2 <<-EOF &&
+		${LF}
+		file-2-first-line
+		${MULTI_LF}
+		file-2-second-line
+		${LF}
+	EOF
+
+	git notes add -m "initial-line" &&
+	git notes append --no-stripspace -F note-file-1 -F note-file-2 &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'add notes with empty messages' '
 	rev=$(git rev-parse HEAD) &&
 	git notes add -m "${LF}" \
@@ -229,7 +375,7 @@ test_expect_success 'add notes with empty messages' '
 	test_i18ngrep "Removing note for object" actual
 '
 
-test_expect_success 'add note by specifying "-C" , do not stripspace is the default behavior' '
+test_expect_success 'add note by specifying "-C", "--no-stripspace" is the default behavior' '
 	test_when_finished "git notes remove" &&
 	cat >expect <<-EOF &&
 		${LF}
@@ -242,10 +388,36 @@ test_expect_success 'add note by specifying "-C" , do not stripspace is the defa
 	cat expect | git hash-object -w --stdin >blob &&
 	git notes add -C $(cat blob) &&
 	git notes show >actual &&
+	test_cmp expect actual &&
+	git notes remove &&
+	git notes add --no-stripspace -C $(cat blob) &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'reuse note by specifying "-C" and "--stripspace"' '
+	test_when_finished "git notes remove" &&
+	cat >data <<-EOF &&
+		${LF}
+		first-line
+		${MULTI_LF}
+		second-line
+		${LF}
+	EOF
+
+	cat >expect <<-EOF &&
+		first-line
+
+		second-line
+	EOF
+
+	cat data | git hash-object -w --stdin >blob &&
+	git notes add --stripspace -C $(cat blob) &&
+	git notes show >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success 'add notes with "-C" and "-m", "-m" will stripspace all together' '
+test_expect_success 'reuse with "-C" and add note with "-m", "-m" will stripspace all together' '
 	test_when_finished "git notes remove" &&
 	cat >data <<-EOF &&
 		${LF}
@@ -269,7 +441,7 @@ test_expect_success 'add notes with "-C" and "-m", "-m" will stripspace all toge
 	test_cmp expect actual
 '
 
-test_expect_success 'add notes with "-m" and "-C", "-C" will not stripspace all together' '
+test_expect_success 'add note with "-m" and reuse note with "-C", "-C" will not stripspace all together' '
 	test_when_finished "git notes remove" &&
 	cat >data <<-EOF &&
 
@@ -288,4 +460,62 @@ test_expect_success 'add notes with "-m" and "-C", "-C" will not stripspace all
 	test_cmp expect actual
 '
 
+test_expect_success 'add note by specifying "-c", "--stripspace" is the default behavior' '
+	test_when_finished "git notes remove" &&
+	cat >expect <<-EOF &&
+		first-line
+
+		second-line
+	EOF
+
+	echo "initial-line" | git hash-object -w --stdin >blob &&
+	MSG="${LF}first-line${MULTI_LF}second-line${LF}" git notes add -c $(cat blob) &&
+	git notes show >actual &&
+	test_cmp expect actual &&
+	git notes remove &&
+	MSG="${LF}first-line${MULTI_LF}second-line${LF}" git notes add --stripspace -c $(cat blob) &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'add note by specifying "-c" with "--no-stripspace"' '
+	test_when_finished "git notes remove" &&
+	cat >expect <<-EOF &&
+		${LF}first-line${MULTI_LF}second-line${LF}
+	EOF
+
+	echo "initial-line" | git hash-object -w --stdin >blob &&
+	MSG="${LF}first-line${MULTI_LF}second-line${LF}" git notes add --no-stripspace -c $(cat blob) &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'edit note by specifying "-c", "--stripspace" is the default behavior' '
+	test_when_finished "git notes remove" &&
+	cat >expect <<-EOF &&
+		first-line
+
+		second-line
+	EOF
+
+	MSG="${LF}first-line${MULTI_LF}second-line${LF}" git notes edit &&
+	git notes show >actual &&
+	test_cmp expect actual &&
+	git notes remove &&
+	MSG="${LF}first-line${MULTI_LF}second-line${LF}" git notes edit --stripspace &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'edit note by specifying "-c" with "--no-stripspace"' '
+	test_when_finished "git notes remove" &&
+	cat >expect <<-EOF &&
+		${LF}first-line${MULTI_LF}second-line${LF}
+	EOF
+
+	MSG="${LF}first-line${MULTI_LF}second-line${LF}" git notes add --no-stripspace &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.40.0.358.g931d6dc6

