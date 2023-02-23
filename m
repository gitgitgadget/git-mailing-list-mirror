Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339FDC678D5
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 07:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjBWH36 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 02:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjBWH35 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 02:29:57 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF473251B
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 23:29:55 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 130so2937267pgg.3
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 23:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUce+xM+wyrDUV5I9PqRe0sdJ24qBULxZgsk79Sbx6M=;
        b=p2BfZtZx5DAvOMIINXxUaK7uPz7if0qsnScydNPsn6nO8lyp63tUfYuoSoTCBtXxCQ
         cj3sf7HCmE8JRCTUYZOZTp6KRNWR4Vf1x2Wdfj2miL6eKTj+/SWs7ThM50/JEcylmmm/
         Ye+06fKozsByICIBBtt/yxiLbyha7rpheMZQLPPig7OFOBfWJ4/BiPd8mBzqSpP/SShw
         72s2RPRymbMdLKgY0TLwy83zSx5hdtLCSTE7Uiri354mHdNYFEcFjR/FsgajW4+DV5dX
         0diPN9/NGVfiD/amJi9aZ6CUx7s4GkxY1oLDTq7dt/FX/ycj784AvLr9FqT4crDHW6w8
         ekkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bUce+xM+wyrDUV5I9PqRe0sdJ24qBULxZgsk79Sbx6M=;
        b=voQ6LBtIK1xXDKAR37wCfYW5JteWhrzlt7xKv1Im7lol7YSLJ/h5CwuRMAOyf6gVtM
         +MFWbjbu89uUlYUP6bjqEaFP9q1Juwk4BpteuhH/9nDMsMY8sOZDE+w2vhRLwi+pOyu+
         mMR6FejEExSdZw1DrK0xVQYUK2WyZJEXEUTUFHRDd7Qvg/OD9RxagYCsz+kd4ek/6toH
         xl3KP9d/wu0IFC2JtWMuvYULPEbJPHGTwQC59Go+aUHZpxqWoV5SX1zQmXvMkvwgwHnS
         nUhVsenqneBY8ue+/jaid3rE3muUIyORwNWMc5ylpP0ET+8QC3fkpd89D14I1yRR9OXn
         ascg==
X-Gm-Message-State: AO0yUKVgwCdLXqJiUkUFtlEWhL96vrpr6EZj+1tg2kNa0iN5BF2d2krJ
        UcZ1r3K7mC0lrHCxlm4ialQ=
X-Google-Smtp-Source: AK7set++LKSncaMiSYQ2brT9MD0SZpKkYP1WtWnlcak0M7ik4143TxQbnKtikqgGbZxkJNFhAeqKZA==
X-Received: by 2002:aa7:8f0b:0:b0:5a8:380d:7822 with SMTP id x11-20020aa78f0b000000b005a8380d7822mr10001843pfr.23.1677137394283;
        Wed, 22 Feb 2023 23:29:54 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.50])
        by smtp.gmail.com with ESMTPSA id u20-20020a62ed14000000b0059085684b54sm5570364pfh.140.2023.02.22.23.29.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Feb 2023 23:29:53 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com, gitster@pobox.com
Subject: [PATCH v6 0/3] notes.c: introduce "--separator" option
Date:   Thu, 23 Feb 2023 15:29:44 +0800
Message-Id: <cover.1677136319.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.39.2.459.gd5a6c747
In-Reply-To: <cover.1676551077.git.dyroneteng@gmail.com>
References: <cover.1676551077.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

Diff since v5:

1. Optimized and fixed the commit-message problems.
2. Optimized and fixed the related documentation.
3. the order of "-m" and -F should matter, but not, it was newly
introduced problem in v4, now fixed in v5.

By the way, In order to add a separator when parsing '-F and
'-m', I used 'string_list' to save all messages for subsequent
processing instead of processing in callback, because the value
of '--separator' has not been initialized and set at this time and
I have not found a similar "OPT_XXX" API for doing this. I'm not
sure if it's worth adding a similar API to parse the value of an
option in advance and initialize it for this scenario. If so, it
may not be suitable to continue to incubate in the current patch
series, but I will try to contribute it.

Thanks.

Teng Long (3):
  notes.c: cleanup 'strbuf_grow' call in 'append_edit'
  notes.c: cleanup for "designated init"
  notes.c: introduce '--separator=<paragraph-break>' option

 Documentation/git-notes.txt |  20 ++++++--
 builtin/notes.c             |  78 ++++++++++++++++++----------
 t/t3301-notes.sh            | 100 ++++++++++++++++++++++++++++++++++++
 3 files changed, 168 insertions(+), 30 deletions(-)

Range-diff against v5:
1:  9a450669 ! 1:  b029ee0b notes.c: cleanup 'strbuf_grow' call in 'append_edit'
    @@ Commit message
         needed, but actually when inserting, "strbuf_insertstr(&d.buf, 0,
         "\n");" will do the "grow" for us.
     
    -    Best guess may be that the author originally inserted "\n" manually by
    -    direct manipulation of the strbuf rather than employing a strbuf
    -    function, but then switched to strbuf_insert() before submitting the
    -    series and forgot to remove the now-unnecessary strbuf_grow().
    +    348f199b (builtin-notes: Refactor handling of -F option to allow
    +    combining -m and -F, 2010-02-13) added these to mimic the code
    +    introduced by 2347fae5 (builtin-notes: Add "append" subcommand for
    +    appending to note objects, 2010-02-13) that reads in previous note
    +    before the message.  And the resulting code with explicit sizing is
    +    carried to this day.
    +
    +    In the context of reading an existing note in, exact sizing may have
    +    made sense, but because the resulting note needs cleansing with
    +    stripspace() when appending with this option, such an exact sizing
    +    does not buy us all that much in practice.
    +
    +    It may help avoiding overallocation due to ALLOC_GROW() slop, but
    +    nobody can feed so many long messages for it to matter from the
    +    command line.
     
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
         Helped-by: Eric Sunshine <sunshine@sunshineco.com>
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
     
      ## builtin/notes.c ##
     @@ builtin/notes.c: static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
2:  e7bc6060 ! 2:  043db631 notes.c: cleanup for "designated init"
    @@ Commit message
         The "struct note_data d = { 0, 0, NULL, STRBUF_INIT };" style could be
         replaced with designated init format.
     
    +    Signed-off-by: Teng Long <dyroneteng@gmail.com>
    +
      ## builtin/notes.c ##
     @@ builtin/notes.c: static int add(int argc, const char **argv, const char *prefix)
      	struct notes_tree *t;
3:  a74c96d6 ! 3:  d5a6c747 notes.c: introduce "--separator" option
    @@ Metadata
     Author: Teng Long <dyroneteng@gmail.com>
     
      ## Commit message ##
    -    notes.c: introduce "--separator" option
    +    notes.c: introduce '--separator=<paragraph-break>' option
     
    -    When appending to a given notes object and the appended note is not
    -    empty too, we will insert a blank line at first which separates the
    -    existing note and the appended one, which as the separator.
    +    When adding new notes or appending to an existing notes, we will
    +    insert a blank line between the paragraphs, like:
     
    -    Sometimes, we want to use a specified <separator> as the separator. For
    -    example, if we specify as:
    +         $ git notes add -m foo -m bar
    +         $ git notes show HEAD | cat
    +         foo
     
    -        * --separator='------': we will insert "------\n" as the separator,
    -        because user do not provide the line break char at last, we will add
    -        the trailing '\n' compatibly.
    +         bar
     
    -        * --separator='------\n': we will insert as-is because it contains
    -        the line break at last.
    +    The default behavour sometimes is not enough, the user may want
    +    to use a custom delimiter between paragraphs, like when
    +    specifiy one or more '-m' or '-F' options. So this commit
    +    introduces a new '--separator' option for 'git-notes-add' and
    +    'git-notes-append', for example when execute:
     
    -        * not specified --separator option: will use '\n' as the separator
    -        when do appending and this is the default behavour.
    +        $ git notes add -m foo -m bar --separator="-"
    +        $ git notes show HEAD | cat
    +        foo
    +        -
    +        bar
     
    -        * --separator='': we specify an empty separator which has the same
    -        behavour with --separator='\n' and or not specified the option.
    +    We will check the option value and if the value doesn't contail
    +    a trailing '\n', will add it automatically, so execute
     
    -    In addition, if a user specifies multple "-m" with "--separator", the
    -    separator should be inserted between the messages too, so we use
    -    OPT_STRING_LIST instead of OPT_CALLBACK_F to parse "-m" option, make
    -    sure the option value of "--separator" been parsed already when we need
    -    it.
    +          $ git notes add -m foo -m bar --separator="-"
    +    and
    +          $ export LF="
    +          "
    +          $ git notes add -m foo -m bar --separator="-$LF"
    +
    +    have the same behavour.
     
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
     
      ## Documentation/git-notes.txt ##
     @@ Documentation/git-notes.txt: SYNOPSIS
    + --------
    + [verse]
      'git notes' [list [<object>]]
    - 'git notes' add [-f] [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
    +-'git notes' add [-f] [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
    ++'git notes' add [-f] [--allow-empty] [--separator=<paragraph-break>] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
      'git notes' copy [-f] ( --stdin | <from-object> [<to-object>] )
     -'git notes' append [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
    -+'git notes' append [--allow-empty] [--separator] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
    ++'git notes' append [--allow-empty] [--separator=<paragraph-break>] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
      'git notes' edit [--allow-empty] [<object>]
      'git notes' show [<object>]
      'git notes' merge [-v | -q] [-s <strategy> ] <notes-ref>
    +@@ Documentation/git-notes.txt: add::
    + 	However, if you're using `add` interactively (using an editor
    + 	to supply the notes contents), then - instead of aborting -
    + 	the existing notes will be opened in the editor (like the `edit`
    +-	subcommand).
    ++	subcommand). If you specify multiple `-m` and `-F`, a blank
    ++	line will be inserted between the messages. Use the `--separator`
    ++	option to insert other delimiters. 
    + 
    + copy::
    + 	Copy the notes for the first object onto the second object (defaults to
     @@ Documentation/git-notes.txt: the command can read the input given to the `post-rewrite` hook.)
      
      append::
      	Append to the notes of an existing object (defaults to HEAD).
     -	Creates a new notes object if needed.
    -+	Creates a new notes object if needed. If the note and the
    -+	message are not empty, "\n" will be inserted between them.
    -+	Use the `--separator` option to insert other delimiters.
    ++	Creates a new notes object if needed. 
    ++	The default delimiter is a blank line, use the `--separator`
    ++	option to insert other delimiters. More specifically, if the
    ++	note and the message are not empty, the delimiter will be
    ++	inserted between them. If you specify multiple `-m` and `-F`
    ++	options, the delimiter will be inserted between the messages
    ++	too.
      
      edit::
      	Edit the notes for a given object (defaults to HEAD).
    @@ Documentation/git-notes.txt: OPTIONS
      	Allow an empty note object to be stored. The default behavior is
      	to automatically remove empty notes.
      
    -+--separator <separator>::
    -+	The '<separator>' inserted between the note and message
    -+	by 'append', "\n" by default. A custom separator can be
    -+	provided, if it doesn't end in a "\n", one will be added
    -+	implicitly .
    ++--separator <paragraph-break>::
    ++	The '<paragraph-break>' inserted between paragraphs.
    ++	A blank line by default.
     +
      --ref <ref>::
      	Manipulate the notes tree in <ref>.  This overrides
    @@ builtin/notes.c
     +static char *separator = NULL;
      static const char * const git_notes_usage[] = {
      	N_("git notes [--ref <notes-ref>] [list [<object>]]"),
    - 	N_("git notes [--ref <notes-ref>] add [-f] [--allow-empty] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
    +-	N_("git notes [--ref <notes-ref>] add [-f] [--allow-empty] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
    ++	N_("git notes [--ref <notes-ref>] add [-f] [--allow-empty] [--separator=<paragraph-break>] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
    + 	N_("git notes [--ref <notes-ref>] copy [-f] <from-object> <to-object>"),
    +-	N_("git notes [--ref <notes-ref>] append [--allow-empty] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
    ++	N_("git notes [--ref <notes-ref>] append [--allow-empty] [--separator=<paragraph-break>] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
    + 	N_("git notes [--ref <notes-ref>] edit [--allow-empty] [<object>]"),
    + 	N_("git notes [--ref <notes-ref>] show [<object>]"),
    + 	N_("git notes [--ref <notes-ref>] merge [-v | -q] [-s <strategy>] <notes-ref>"),
     @@ builtin/notes.c: static void write_note_data(struct note_data *d, struct object_id *oid)
      	}
      }
    @@ builtin/notes.c: static void write_note_data(struct note_data *d, struct object_
     +	else
     +		strbuf_insertf(message, pos, "%s%s", separator, "\n");
     +}
    ++
    ++static void parse_messages(struct string_list *messages, struct note_data *d)
    ++{
    ++	size_t i;
    ++	for (i = 0; i < messages->nr; i++) {
    ++		if (d->buf.len)
    ++			insert_separator(&d->buf, d->buf.len);
    ++		strbuf_insertstr(&d->buf, d->buf.len,
    ++				 messages->items[i].string);
    ++		strbuf_stripspace(&d->buf, 0);
    ++		d->given = 1;
    ++	}
    ++}
     +
      static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
      {
    - 	struct note_data *d = opt->value;
    -@@ builtin/notes.c: static int append_edit(int argc, const char **argv, const char *prefix)
    +-	struct note_data *d = opt->value;
    ++	struct string_list *msg = opt->value;
    + 
    + 	BUG_ON_OPT_NEG(unset);
    + 
    +-	if (d->buf.len)
    +-		strbuf_addch(&d->buf, '\n');
    +-	strbuf_addstr(&d->buf, arg);
    +-	strbuf_stripspace(&d->buf, 0);
    +-
    +-	d->given = 1;
    ++	string_list_append(msg, arg);
    + 	return 0;
    + }
    + 
    ++
    + static int parse_file_arg(const struct option *opt, const char *arg, int unset)
    + {
    +-	struct note_data *d = opt->value;
    ++	struct string_list *msg = opt->value;
    ++	struct strbuf buf = STRBUF_INIT;
    + 
    + 	BUG_ON_OPT_NEG(unset);
    + 
    +-	if (d->buf.len)
    +-		strbuf_addch(&d->buf, '\n');
    + 	if (!strcmp(arg, "-")) {
    +-		if (strbuf_read(&d->buf, 0, 1024) < 0)
    ++		if (strbuf_read(&buf, 0, 1024) < 0)
    + 			die_errno(_("cannot read '%s'"), arg);
    +-	} else if (strbuf_read_file(&d->buf, arg, 1024) < 0)
    ++	} else if (strbuf_read_file(&buf, arg, 1024) < 0)
    + 		die_errno(_("could not open or read '%s'"), arg);
    +-	strbuf_stripspace(&d->buf, 0);
    + 
    +-	d->given = 1;
    ++	string_list_append(msg, buf.buf);
    ++	strbuf_release(&buf);
    + 	return 0;
    + }
    + 
    +@@ builtin/notes.c: static int add(int argc, const char **argv, const char *prefix)
    + 	struct object_id object, new_note;
      	const struct object_id *note;
    + 	struct note_data d = { .buf = STRBUF_INIT };
    ++	struct string_list messages = STRING_LIST_INIT_DUP;
    + 	struct option options[] = {
    +-		OPT_CALLBACK_F('m', "message", &d, N_("message"),
    ++		OPT_CALLBACK_F('m', "message", &messages, N_("message"),
    + 			N_("note contents as a string"), PARSE_OPT_NONEG,
    + 			parse_msg_arg),
    +-		OPT_CALLBACK_F('F', "file", &d, N_("file"),
    ++		OPT_CALLBACK_F('F', "file", &messages, N_("file"),
    + 			N_("note contents in a file"), PARSE_OPT_NONEG,
    + 			parse_file_arg),
    + 		OPT_CALLBACK_F('c', "reedit-message", &d, N_("object"),
    +@@ builtin/notes.c: static int add(int argc, const char **argv, const char *prefix)
    + 		OPT_BOOL(0, "allow-empty", &allow_empty,
    + 			N_("allow storing empty note")),
    + 		OPT__FORCE(&force, N_("replace existing notes"), PARSE_OPT_NOCOMPLETE),
    ++		OPT_STRING(0, "separator", &separator, N_("separator"),
    ++			N_("insert <paragraph-break> between paragraphs")),
    + 		OPT_END()
    + 	};
    + 
    +@@ builtin/notes.c: static int add(int argc, const char **argv, const char *prefix)
    + 		usage_with_options(git_notes_add_usage, options);
    + 	}
    + 
    ++	parse_messages(&messages, &d);
    + 	object_ref = argc > 1 ? argv[1] : "HEAD";
    + 
    + 	if (get_oid(object_ref, &object))
    +@@ builtin/notes.c: static int append_edit(int argc, const char **argv, const char *prefix)
      	char *logmsg;
      	const char * const *usage;
    -+	size_t message_idx;
      	struct note_data d = { .buf = STRBUF_INIT };
    -+	struct string_list message = STRING_LIST_INIT_DUP;
    ++	struct string_list messages = STRING_LIST_INIT_DUP;
      	struct option options[] = {
     -		OPT_CALLBACK_F('m', "message", &d, N_("message"),
     -			N_("note contents as a string"), PARSE_OPT_NONEG,
    --			parse_msg_arg),
    -+		OPT_STRING_LIST('m', "message", &message, N_("message"),
    -+			N_("note contents as a string")),
    - 		OPT_CALLBACK_F('F', "file", &d, N_("file"),
    ++		OPT_CALLBACK_F('m', "message", &messages, N_("message"),
    ++			N_("note contents as a string"), PARSE_OPT_NONEG, 
    + 			parse_msg_arg),
    +-		OPT_CALLBACK_F('F', "file", &d, N_("file"),
    ++		OPT_CALLBACK_F('F', "file", &messages, N_("file"),
      			N_("note contents in a file"), PARSE_OPT_NONEG,
      			parse_file_arg),
    + 		OPT_CALLBACK_F('c', "reedit-message", &d, N_("object"),
     @@ builtin/notes.c: static int append_edit(int argc, const char **argv, const char *prefix)
      			parse_reuse_arg),
      		OPT_BOOL(0, "allow-empty", &allow_empty,
      			N_("allow storing empty note")),
     +		OPT_STRING(0, "separator", &separator, N_("separator"),
    -+			N_("insert <separator> as separator before appending a message")),
    ++			N_("insert <paragraph-break> between paragraphs")),
      		OPT_END()
      	};
      	int edit = !strcmp(argv[0], "edit");
    @@ builtin/notes.c: static int append_edit(int argc, const char **argv, const char
      		usage_with_options(usage, options);
      	}
      
    -+	for (message_idx = 0; message_idx < message.nr; message_idx++) {
    -+		if (d.buf.len)
    -+			insert_separator(&d.buf, d.buf.len);
    -+		strbuf_insertstr(&d.buf, d.buf.len,
    -+				 message.items[message_idx].string);
    -+		strbuf_stripspace(&d.buf, 0);
    -+		d.given = 1;
    -+	}
    ++	parse_messages(&messages, &d);
     +
      	if (d.given && edit)
      		fprintf(stderr, _("The -m/-F/-c/-C options have been deprecated "
    @@ builtin/notes.c: static int append_edit(int argc, const char **argv, const char
      		free(prev_buf);
     
      ## t/t3301-notes.sh ##
    +@@ t/t3301-notes.sh: test_expect_success 'do not create empty note with -m ""' '
    + '
    + 
    + test_expect_success 'create note with combination of -m and -F' '
    ++	test_when_finished git notes remove HEAD &&
    + 	cat >expect-combine_m_and_F <<-EOF &&
    + 		foo
    + 
    +@@ t/t3301-notes.sh: test_expect_success 'create note with combination of -m and -F' '
    + 	test_cmp expect-combine_m_and_F actual
    + '
    + 
    ++test_expect_success 'create note with combination of -m and -F and --separator' '
    ++	cat >expect-combine_m_and_F <<-\EOF &&
    ++	foo
    ++	-------
    ++	xyzzy
    ++	-------
    ++	bar
    ++	-------
    ++	zyxxy
    ++	-------
    ++	baz
    ++	EOF
    ++	echo "xyzzy" >note_a &&
    ++	echo "zyxxy" >note_b &&
    ++	git notes add -m "foo" -F note_a -m "bar" -F note_b -m "baz" --separator "-------" &&
    ++	git notes show >actual &&
    ++	test_cmp expect-combine_m_and_F actual
    ++	
    ++'
    ++
    + test_expect_success 'remove note with "git notes remove"' '
    + 	git notes remove HEAD^ &&
    + 	git notes remove &&
     @@ t/t3301-notes.sh: test_expect_success 'listing non-existing notes fails' '
      	test_must_be_empty actual
      '
    @@ t/t3301-notes.sh: test_expect_success 'listing non-existing notes fails' '
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'append: specify separatoro with line break' '
    ++test_expect_success 'append: specify separator with line break' '
     +	test_when_finished git notes remove HEAD &&
     +	cat >expect <<-\EOF &&
     +	notes-1
    @@ t/t3301-notes.sh: test_expect_success 'listing non-existing notes fails' '
     +	git notes show >actual &&
     +	test_cmp expect actual
     +'
    ++
    ++test_expect_success 'append note with combination of -m and -F and --separator' '
    ++	test_when_finished git notes remove HEAD &&
    ++	cat >expect-combine_m_and_F <<-\EOF &&
    ++	m-notes-1
    ++	-------
    ++	f-notes-1
    ++	-------
    ++	m-notes-2
    ++	-------
    ++	f-notes-2
    ++	-------
    ++	m-notes-3
    ++	EOF
    ++
    ++	echo "f-notes-1" >note_a &&
    ++	echo "f-notes-2" >note_b &&
    ++	git notes append -m "m-notes-1" -F note_a -m "m-notes-2" -F note_b -m "m-notes-3" --separator "-------" &&
    ++	git notes show >actual &&
    ++	test_cmp expect-combine_m_and_F actual
    ++'
     +
      test_expect_success 'append to existing note with "git notes append"' '
      	cat >expect <<-EOF &&
-- 
2.39.2.459.gd5a6c747

