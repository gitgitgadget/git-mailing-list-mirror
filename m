Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B54C77B7E
	for <git@archiver.kernel.org>; Sat, 27 May 2023 07:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjE0H6I (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 May 2023 03:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjE0H6G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 May 2023 03:58:06 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D9AD3
        for <git@vger.kernel.org>; Sat, 27 May 2023 00:58:03 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-256481ce1b5so305036a91.1
        for <git@vger.kernel.org>; Sat, 27 May 2023 00:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685174283; x=1687766283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5yWXHRG2/bKZelhlu9EtenVwwZx46syaVrmppD+UWA=;
        b=RTeOPoRj5XN2wQy8DFTYDW3eVbWHM5SJ12QQPNVWRrTp7vYmVWab6WrMh647gpt/l3
         h7zBAoA5blvsi5cQWWt4uIvf7mB30D6acP+KdDoUFidKvGJVWP7OEYOQu6Idsh6yXK+X
         Xr3m5kGsHStfGCyBR8xU46OJDEyiuIDbkU4biOlntyFe+zd2KFuRgjoZrBXZMKM3knoV
         KvSzCNC1r55sW1I50GKgBImaUIugnOGtUgIgzaNvearM9sqWm7T2Gvy1En1LizzsijK8
         qb108Q9hPkFTs8l47qISj3vn4N7XZIirFAlXMxSOJOwp90xQ/wiBENIOOcE7s6aNg9Tw
         b5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685174283; x=1687766283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5yWXHRG2/bKZelhlu9EtenVwwZx46syaVrmppD+UWA=;
        b=RkldcBBATqPLqFVN/CLsgDlb34FXXY/uHZaAtmOWjKUQ6VqdrfJHjk+H+gMxorye0S
         dV1FdgO+0qkYhIG8SZGqhU00ot/fnYBmAj0cGChWxx7RZGOrqkfkYIkiNml4Wv/7qOjQ
         6oYdntIFWUMYHRK2SGll11Hf0FSSYm/5DMyMBSL6X+tboF0c6A2J8DGqHFyQxUQISYeY
         7t8/73Y/S+4Ra6z8i4d13Gp7Lwp5gvfw/p1072Id2ouuQUciNzLu7ftZxbmmBtvje+lX
         wzPBAOPqKX0aHma8AYkzlLFamrq2rM6KaBstrKSkL+SxWW4iaQOI0V5RTvnoVy+F02KM
         4RDA==
X-Gm-Message-State: AC+VfDxo9gOWicaI00kp1A72QJ9a2l5AWo4/zqbL9nalSIwZ66ab8Vsg
        GUaWIiRNJoj0O1PxRqltLzQ=
X-Google-Smtp-Source: ACHHUZ44FyMF3szwqo3tUUdl2560Er6zW0hLUyBrpRFvrRQwGyoO7wsK5RN2tAPea5dkLOqSjQIGiA==
X-Received: by 2002:a17:902:ecd2:b0:1ad:8c8f:afb1 with SMTP id a18-20020a170902ecd200b001ad8c8fafb1mr5972410plh.39.1685174283054;
        Sat, 27 May 2023 00:58:03 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.60])
        by smtp.gmail.com with ESMTPSA id t4-20020a170902b20400b001a6b2813c13sm4355239plr.172.2023.05.27.00.58.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 May 2023 00:58:02 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com,
        peff@peff.net, code@khaugsbakk.name
Subject: [PATCH v11 0/7] notes.c: introduce "--separator"
Date:   Sat, 27 May 2023 15:57:47 +0800
Message-ID: <cover.1685174011.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.40.0.356.g367cb1d4
In-Reply-To: <cover.1684411136.git.dyroneteng@gmail.com>
References: <cover.1684411136.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

1.  "--[no-]separator" to an independent patch which suggested by Junio[1].
2.  fix "UBSan" problem which found by Peff[2].

[1] https://public-inbox.org/git/xmqqfs7tvfc7.fsf@gitster.g/
[2] https://public-inbox.org/git/20230519005447.GA2955320@coredump.intra.peff.net/

Thanks.

Teng Long (7):
  notes.c: cleanup 'strbuf_grow' call in 'append_edit'
  notes.c: use designated initializers for clarity
  t3321: add test cases about the notes stripspace behavior
  notes.c: introduce '--separator=<paragraph-break>' option
  notes.c: append separator instead of insert by pos
  notes.c: introduce "--[no-]stripspace" option
  notes: introduce "--no-separator" option

 Documentation/git-notes.txt |  43 ++-
 builtin/notes.c             | 159 +++++++---
 t/t3301-notes.sh            | 169 +++++++++++
 t/t3321-notes-stripspace.sh | 577 ++++++++++++++++++++++++++++++++++++
 4 files changed, 906 insertions(+), 42 deletions(-)
 create mode 100755 t/t3321-notes-stripspace.sh

Range-diff against v10:
1:  0634434e = 1:  0634434e notes.c: cleanup 'strbuf_grow' call in 'append_edit'
2:  4ad78405 = 2:  4ad78405 notes.c: use designated initializers for clarity
3:  c2fc2091 = 3:  c2fc2091 t3321: add test cases about the notes stripspace behavior
4:  820dda04 ! 4:  367cb1d4 notes.c: introduce '[--[no-]separator|--separator=<paragraph-break>]' option
    @@ Metadata
     Author: Teng Long <dyroneteng@gmail.com>
     
      ## Commit message ##
    -    notes.c: introduce '[--[no-]separator|--separator=<paragraph-break>]' option
    +    notes.c: introduce '--separator=<paragraph-break>' option
     
         When adding new notes or appending to an existing notes, we will
         insert a blank line between the paragraphs, like:
    @@ Commit message
     
         Both the two exections produce the same result.
     
    -    Alternatively, if you do not want any new paragraph
    -    separators, even a newline by default, you can specify
    -    '--no-separator'.
    -
         The reason we use a "strbuf" array to concat but not "string_list", is
         that the binary file content may contain '\0' in the middle, this will
         cause the corrupt result if using a string to save.
    @@ Documentation/git-notes.txt: SYNOPSIS
      [verse]
      'git notes' [list [<object>]]
     -'git notes' add [-f] [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
    -+'git notes' add [-f] [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
    ++'git notes' add [-f] [--allow-empty] [--separator=<paragraph-break>] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
      'git notes' copy [-f] ( --stdin | <from-object> [<to-object>] )
     -'git notes' append [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
    -+'git notes' append [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
    ++'git notes' append [--allow-empty] [--separator=<paragraph-break>] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
      'git notes' edit [--allow-empty] [<object>]
      'git notes' show [<object>]
      'git notes' merge [-v | -q] [-s <strategy> ] <notes-ref>
    @@ Documentation/git-notes.txt: OPTIONS
      	Allow an empty note object to be stored. The default behavior is
      	to automatically remove empty notes.
      
    -+--[no-]separator, --separator=<paragraph-break>::
    ++--separator <paragraph-break>::
     +	Specify a string used as a custom inter-paragraph separator
    -+	(a newline is added at the end as needed). If `--no-separator`, no
    -+	separators will be added between paragraphs.  Defaults to a blank
    -+	line.
    ++	(a newline is added at the end as needed).  Defaults to a
    ++	blank line.
     +
      --ref <ref>::
      	Manipulate the notes tree in <ref>.  This overrides
    @@ builtin/notes.c
      #include "worktree.h"
      #include "write-or-die.h"
      
    -+static const char *separator = "\n";
    ++static char *separator = "\n";
      static const char * const git_notes_usage[] = {
      	N_("git notes [--ref <notes-ref>] [list [<object>]]"),
     -	N_("git notes [--ref <notes-ref>] add [-f] [--allow-empty] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
    -+	N_("git notes [--ref <notes-ref>] add [-f] [--allow-empty] [--[no-]separator|--separator=<paragraph-break>] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
    ++	N_("git notes [--ref <notes-ref>] add [-f] [--allow-empty] [--separator=<paragraph-break>] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
      	N_("git notes [--ref <notes-ref>] copy [-f] <from-object> <to-object>"),
     -	N_("git notes [--ref <notes-ref>] append [--allow-empty] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
    -+	N_("git notes [--ref <notes-ref>] append [--allow-empty] [--[no-]separator|--separator=<paragraph-break>] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
    ++	N_("git notes [--ref <notes-ref>] append [--allow-empty] [--separator=<paragraph-break>] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
      	N_("git notes [--ref <notes-ref>] edit [--allow-empty] [<object>]"),
      	N_("git notes [--ref <notes-ref>] show [<object>]"),
      	N_("git notes [--ref <notes-ref>] merge [-v | -q] [-s <strategy>] <notes-ref>"),
    @@ builtin/notes.c: static void write_note_data(struct note_data *d, struct object_
      
     +static void insert_separator(struct strbuf *message, size_t pos)
     +{
    -+	if (!separator)
    -+		return;
    -+	else if (separator[strlen(separator) - 1] == '\n')
    ++	size_t sep_len = strlen(separator);
    ++	if (sep_len && separator[sep_len - 1] == '\n')
     +		strbuf_insertstr(message, pos, separator);
     +	else
     +		strbuf_insertf(message, pos, "%s%s", separator, "\n");
    @@ builtin/notes.c: static void write_note_data(struct note_data *d, struct object_
     +static void concat_messages(struct note_data *d)
     +{
     +	struct strbuf msg = STRBUF_INIT;
    -+	size_t i;
     +
    ++	size_t i;
     +	for (i = 0; i < d->msg_nr ; i++) {
     +		if (d->buf.len)
     +			insert_separator(&d->buf, d->buf.len);
    @@ builtin/notes.c: static void write_note_data(struct note_data *d, struct object_
      	return 0;
      }
      
    -@@ builtin/notes.c: static int parse_reedit_arg(const struct option *opt, const char *arg, int unset
    - 	return parse_reuse_arg(opt, arg, unset);
    - }
    - 
    -+static int parse_separator_arg(const struct option *opt, const char *arg,
    -+			       int unset)
    -+{
    -+	if (unset)
    -+		*(const char **)opt->value = NULL;
    -+	else
    -+		*(const char **)opt->value = arg ? arg : "\n";
    -+	return 0;
    -+}
    -+
    - static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
    - {
    - 	struct strbuf buf = STRBUF_INIT;
     @@ builtin/notes.c: static int add(int argc, const char **argv, const char *prefix)
      	struct object_id object, new_note;
      	const struct object_id *note;
    @@ builtin/notes.c: static int add(int argc, const char **argv, const char *prefix)
      		OPT_BOOL(0, "allow-empty", &allow_empty,
      			N_("allow storing empty note")),
      		OPT__FORCE(&force, N_("replace existing notes"), PARSE_OPT_NOCOMPLETE),
    -+		OPT_CALLBACK_F(0, "separator", &separator,
    -+			N_("<paragraph-break>"),
    -+			N_("insert <paragraph-break> between paragraphs"),
    -+			PARSE_OPT_OPTARG, parse_separator_arg),
    ++		OPT_STRING(0, "separator", &separator, N_("separator"),
    ++			N_("insert <paragraph-break> between paragraphs")),
      		OPT_END()
      	};
      
    @@ builtin/notes.c: static int append_edit(int argc, const char **argv, const char
      			parse_reuse_arg),
      		OPT_BOOL(0, "allow-empty", &allow_empty,
      			N_("allow storing empty note")),
    -+		OPT_CALLBACK_F(0, "separator", &separator,
    -+			N_("<paragraph-break>"),
    -+			N_("insert <paragraph-break> between paragraphs"),
    -+			PARSE_OPT_OPTARG, parse_separator_arg),
    ++		OPT_STRING(0, "separator", &separator, N_("separator"),
    ++			N_("insert <paragraph-break> between paragraphs")),
      		OPT_END()
      	};
      	int edit = !strcmp(argv[0], "edit");
    @@ t/t3301-notes.sh: test_expect_success 'create note with combination of -m and -F
      '
      
     +test_expect_success 'create note with combination of -m and -F and --separator' '
    -+	test_when_finished git notes remove HEAD &&
     +	cat >expect-combine_m_and_F <<-\EOF &&
     +	foo
     +	-------
    @@ t/t3301-notes.sh: test_expect_success 'create note with combination of -m and -F
     +	EOF
     +	echo "xyzzy" >note_a &&
     +	echo "zyxxy" >note_b &&
    -+	git notes add -m "foo" -F note_a -m "bar" -F note_b -m "baz" --separator="-------" &&
    -+	git notes show >actual &&
    -+	test_cmp expect-combine_m_and_F actual
    -+'
    -+
    -+test_expect_success 'create note with combination of -m and -F and --no-separator' '
    -+	cat >expect-combine_m_and_F <<-\EOF &&
    -+	foo
    -+	xyzzy
    -+	bar
    -+	zyxxy
    -+	baz
    -+	EOF
    -+	echo "xyzzy" >note_a &&
    -+	echo "zyxxy" >note_b &&
    -+	git notes add -m "foo" -F note_a -m "bar" -F note_b -m "baz" --no-separator &&
    ++	git notes add -m "foo" -F note_a -m "bar" -F note_b -m "baz" --separator "-------" &&
     +	git notes show >actual &&
     +	test_cmp expect-combine_m_and_F actual
     +'
    @@ t/t3301-notes.sh: test_expect_success 'listing non-existing notes fails' '
      	test_must_be_empty actual
      '
      
    -+test_expect_success 'append: specify a separator with an empty arg' '
    ++test_expect_success 'append: specify an empty separator' '
     +	test_when_finished git notes remove HEAD &&
     +	cat >expect <<-\EOF &&
     +	notes-1
    @@ t/t3301-notes.sh: test_expect_success 'listing non-existing notes fails' '
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'append: specify a separator without arg' '
    -+	test_when_finished git notes remove HEAD &&
    -+	cat >expect <<-\EOF &&
    -+	notes-1
    -+
    -+	notes-2
    -+	EOF
    -+
    -+	git notes add -m "notes-1" &&
    -+	git notes append --separator -m "notes-2" &&
    -+	git notes show >actual &&
    -+	test_cmp expect actual
    -+'
    -+
    -+test_expect_success 'append: specify as --no-separator' '
    -+	test_when_finished git notes remove HEAD &&
    -+	cat >expect <<-\EOF &&
    -+	notes-1
    -+	notes-2
    -+	EOF
    -+
    -+	git notes add -m "notes-1" &&
    -+	git notes append --no-separator -m "notes-2" &&
    -+	git notes show >actual &&
    -+	test_cmp expect actual
    -+'
    -+
     +test_expect_success 'append: specify separator with line break' '
     +	test_when_finished git notes remove HEAD &&
     +	cat >expect <<-\EOF &&
    @@ t/t3301-notes.sh: test_expect_success 'listing non-existing notes fails' '
     +
     +	echo "f-notes-1" >note_a &&
     +	echo "f-notes-2" >note_b &&
    -+	git notes append -m "m-notes-1" -F note_a -m "m-notes-2" -F note_b -m "m-notes-3" --separator="-------" &&
    ++	git notes append -m "m-notes-1" -F note_a -m "m-notes-2" -F note_b -m "m-notes-3" --separator "-------" &&
     +	git notes show >actual &&
     +	test_cmp expect-combine_m_and_F actual
     +'
5:  76c93f19 ! 5:  4ba62a48 notes.c: append separator instead of insert by pos
    @@ builtin/notes.c: static void write_note_data(struct note_data *d, struct object_
     -static void insert_separator(struct strbuf *message, size_t pos)
     +static void append_separator(struct strbuf *message)
      {
    - 	if (!separator)
    - 		return;
    - 	else if (separator[strlen(separator) - 1] == '\n')
    + 	size_t sep_len = strlen(separator);
    + 	if (sep_len && separator[sep_len - 1] == '\n')
     -		strbuf_insertstr(message, pos, separator);
     +		strbuf_addstr(message, separator);
      	else
    @@ builtin/notes.c: static void write_note_data(struct note_data *d, struct object_
      
      static void concat_messages(struct note_data *d)
     @@ builtin/notes.c: static void concat_messages(struct note_data *d)
    - 
    + 	size_t i;
      	for (i = 0; i < d->msg_nr ; i++) {
      		if (d->buf.len)
     -			insert_separator(&d->buf, d->buf.len);
6:  d65f067c ! 6:  19865941 notes.c: introduce "--[no-]stripspace" option
    @@ Documentation/git-notes.txt: SYNOPSIS
      --------
      [verse]
      'git notes' [list [<object>]]
    --'git notes' add [-f] [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
    -+'git notes' add [-f] [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
    +-'git notes' add [-f] [--allow-empty] [--separator=<paragraph-break>] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
    ++'git notes' add [-f] [--allow-empty] [--separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
      'git notes' copy [-f] ( --stdin | <from-object> [<to-object>] )
    --'git notes' append [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
    +-'git notes' append [--allow-empty] [--separator=<paragraph-break>] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
     -'git notes' edit [--allow-empty] [<object>]
    -+'git notes' append [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
    ++'git notes' append [--allow-empty] [--separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
     +'git notes' edit [--allow-empty] [<object>] [--[no-]stripspace]
      'git notes' show [<object>]
      'git notes' merge [-v | -q] [-s <strategy> ] <notes-ref>
    @@ Documentation/git-notes.txt: OPTIONS
      -c <object>::
      --reedit-message=<object>::
     @@ Documentation/git-notes.txt: OPTIONS
    - 	separators will be added between paragraphs.  Defaults to a blank
    - 	line.
    + 	(a newline is added at the end as needed).  Defaults to a
    + 	blank line.
      
     +--[no-]stripspace::
     +	Strip leading and trailing whitespace from the note message.
    @@ Documentation/git-notes.txt: OPTIONS
      	`GIT_NOTES_REF` and the "core.notesRef" configuration.  The ref
     
      ## builtin/notes.c ##
    -@@
    - static const char *separator = "\n";
    - static const char * const git_notes_usage[] = {
    - 	N_("git notes [--ref <notes-ref>] [list [<object>]]"),
    --	N_("git notes [--ref <notes-ref>] add [-f] [--allow-empty] [--[no-]separator|--separator=<paragraph-break>] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
    -+	N_("git notes [--ref <notes-ref>] add [-f] [--allow-empty] [--[no-]separator|--separator=<paragraph-break>] [--[no-]stripspace] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
    - 	N_("git notes [--ref <notes-ref>] copy [-f] <from-object> <to-object>"),
    --	N_("git notes [--ref <notes-ref>] append [--allow-empty] [--[no-]separator|--separator=<paragraph-break>] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
    -+	N_("git notes [--ref <notes-ref>] append [--allow-empty] [--[no-]separator|--separator=<paragraph-break>] [--[no-]stripspace] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
    - 	N_("git notes [--ref <notes-ref>] edit [--allow-empty] [<object>]"),
    - 	N_("git notes [--ref <notes-ref>] show [<object>]"),
    - 	N_("git notes [--ref <notes-ref>] merge [-v | -q] [-s <strategy>] <notes-ref>"),
     @@ builtin/notes.c: static const char * const git_notes_get_ref_usage[] = {
      static const char note_template[] =
      	N_("Write/edit the notes for the following object:");
    @@ builtin/notes.c: static int add(int argc, const char **argv, const char *prefix)
      	struct option options[] = {
      		OPT_CALLBACK_F('m', "message", &d, N_("message"),
     @@ builtin/notes.c: static int add(int argc, const char **argv, const char *prefix)
    - 			N_("<paragraph-break>"),
    - 			N_("insert <paragraph-break> between paragraphs"),
    - 			PARSE_OPT_OPTARG, parse_separator_arg),
    + 		OPT__FORCE(&force, N_("replace existing notes"), PARSE_OPT_NOCOMPLETE),
    + 		OPT_STRING(0, "separator", &separator, N_("separator"),
    + 			N_("insert <paragraph-break> between paragraphs")),
     +		OPT_BOOL(0, "stripspace", &d.stripspace,
     +			N_("remove unnecessary whitespace")),
      		OPT_END()
    @@ builtin/notes.c: static int append_edit(int argc, const char **argv, const char
      		OPT_CALLBACK_F('m', "message", &d, N_("message"),
      			N_("note contents as a string"), PARSE_OPT_NONEG,
     @@ builtin/notes.c: static int append_edit(int argc, const char **argv, const char *prefix)
    - 			N_("<paragraph-break>"),
    - 			N_("insert <paragraph-break> between paragraphs"),
    - 			PARSE_OPT_OPTARG, parse_separator_arg),
    + 			N_("allow storing empty note")),
    + 		OPT_STRING(0, "separator", &separator, N_("separator"),
    + 			N_("insert <paragraph-break> between paragraphs")),
     +		OPT_BOOL(0, "stripspace", &d.stripspace,
     +			N_("remove unnecessary whitespace")),
      		OPT_END()
-:  -------- > 7:  7105778c notes: introduce "--no-separator" option
-- 
2.40.0.356.g367cb1d4

