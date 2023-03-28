Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1D0C76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 14:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbjC1O27 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 10:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjC1O26 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 10:28:58 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98360AD1F
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 07:28:56 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id l7so10984933pjg.5
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 07:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680013736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpRCk2YrBU9glzfGCqj4CDixfqqcflPxoSTDB+wqDj4=;
        b=OlH9XEPe/97qYdoIfR8wXD4arAhFkCrJId/qOWr5plvstwwFFvEemIiLRDTa8QT/yq
         vqv/zl7DzgIHVq6+Y7c4WWY/LuxwofvahP7Zfl6saF8hqE2sQRgIkxyZrrFuAeGKbYZ1
         lNDxkN0DZu0JB3z8l+ajZrYWdhX8ZIFgzy+f5atAL9hQqXrCOzDV862uQbog6Wy9z1y5
         8I9fCz9vBmT7JIIUl07otVXwZah3nNLGWLYGrz3KHRhqsEj/TND8BC0rLq0baSpv8vvS
         MULuyT7pHiMO4SpTwlFdCB6QC6FrkXv5Ja6CH9JaTNLBxciGqOgSGWWlt/ADV92vZITM
         aQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680013736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FpRCk2YrBU9glzfGCqj4CDixfqqcflPxoSTDB+wqDj4=;
        b=B9ica6e1vIgFT86i/pT8UKqHU1n/6QffQaqlVTVTf03MG8VpA2vGXBS4++RMjKlpvT
         h2YjQu87zqfXc/R52YDIfAZZ2GCr7U2vP5nPZ0+rN08VKSHfqZin8aD2ufaJ/dDcbKMb
         TIE15qy7qVic+rSgJzFXnaLDeo/aEwOZnTpD1Ez1b/PyeltE+ihvA58/LvJ3KUz3i8Zk
         uZlTWhSkKNPR3q+OaFjD2LxztrEk1R4JY8+rJDx3v4BLa/A8VoY38Q31lxfQ74q9qSRO
         HWeIvewWWwUdvRVPn6zzQjTaHxgze1Wzu8KvrMUxkjE3zk0NTxijBpz9v6ugHIPLUqiY
         o6Sg==
X-Gm-Message-State: AAQBX9eNJ86hZ3D5S0Jwn8Zm4jBUMJpTRvEHU3XcAl9WjbFzuGs+2qpM
        2O9FRLMcVlsHSlvGBfwFKSk=
X-Google-Smtp-Source: AKy350a07y/Gn6DJKJsv231ALt/bjeqLzWxZvy8e8i731SfOrC0lLkhvHyP5Nr3Xpe0U+Q++X/sr5w==
X-Received: by 2002:a17:902:ec91:b0:1a1:dd3a:7509 with SMTP id x17-20020a170902ec9100b001a1dd3a7509mr18519351plg.48.1680013735673;
        Tue, 28 Mar 2023 07:28:55 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.62])
        by smtp.gmail.com with ESMTPSA id bg9-20020a1709028e8900b0019cbabf127dsm21189275plb.182.2023.03.28.07.28.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Mar 2023 07:28:55 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v7 0/4] notes.c: introduce "--separator" option 
Date:   Tue, 28 Mar 2023 22:28:43 +0800
Message-Id: <cover.1680012650.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.40.0.rc2.4.gb9d12f0c
In-Reply-To: <cover.1677136319.git.dyroneteng@gmail.com>
References: <cover.1677136319.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

Diff since v6:

1. apply Junio's code[1] in 3/4  
2. apply Junio's code[2] and text in 3/4
3. adjust -c/-C codepath in 3/4
4. add new test cases in 3/4
5. in v6, I used a string_list struct to temporarily save the message
then concat them with the separator. But, I found it will be a problem
when we use -C/-F to save the content of binary file(break the t3307)
because binary file maybe contains the NUL in the middle, so I use
strbuf struct instead to make sure the whole content is saved to the
notes.
6. 4/4 is a new commit, which fix the problem about the binary file
too. The binary file maybe contains multiple consecutive empty lines,
we shouldn't make them into just one empty line, which may corrupt
the file I think.

[1] https://public-inbox.org/git/xmqqk005v3ex.fsf@gitster.g/
[2] https://public-inbox.org/git/xmqqcz608cpk.fsf@gitster.g/

Thanks.

Teng Long (4):
  notes.c: cleanup 'strbuf_grow' call in 'append_edit'
  notes.c: cleanup for "designated init"
  notes.c: introduce '--separator=<paragraph-break>' option
  notes.c: don't do stripespace when parse file arg

 Documentation/git-notes.txt |  21 ++++--
 builtin/notes.c             | 106 +++++++++++++++++++++-------
 t/t3301-notes.sh            | 137 +++++++++++++++++++++++++++++++++++-
 3 files changed, 232 insertions(+), 32 deletions(-)

Range-diff against v6:
1:  b029ee0b = 1:  ea9c199e notes.c: cleanup 'strbuf_grow' call in 'append_edit'
2:  043db631 = 2:  9dc123c8 notes.c: cleanup for "designated init"
3:  d5a6c747 ! 3:  d1febf86 notes.c: introduce '--separator=<paragraph-break>' option
    @@ Commit message
     
         The default behavour sometimes is not enough, the user may want
         to use a custom delimiter between paragraphs, like when
    -    specifiy one or more '-m' or '-F' options. So this commit
    -    introduces a new '--separator' option for 'git-notes-add' and
    -    'git-notes-append', for example when execute:
    +    specifiy '-m', '-F', '-C', '-c' options. So this commit
    +    introduce a new '--separator' option for 'git notes add' and
    +    'git notes append', for example when execute:
     
             $ git notes add -m foo -m bar --separator="-"
             $ git notes show HEAD | cat
    @@ Commit message
             -
             bar
     
    -    We will check the option value and if the value doesn't contail
    -    a trailing '\n', will add it automatically, so execute
    +    A newline is added to the value given to --separator if it
    +    does not end with one already. So execute:
     
               $ git notes add -m foo -m bar --separator="-"
         and
    @@ Commit message
               "
               $ git notes add -m foo -m bar --separator="-$LF"
     
    -    have the same behavour.
    +    Running A and B produces the same result.
     
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
     
    @@ Documentation/git-notes.txt: add::
     -	subcommand).
     +	subcommand). If you specify multiple `-m` and `-F`, a blank
     +	line will be inserted between the messages. Use the `--separator`
    -+	option to insert other delimiters. 
    ++	option to insert other delimiters.
      
      copy::
      	Copy the notes for the first object onto the second object (defaults to
    -@@ Documentation/git-notes.txt: the command can read the input given to the `post-rewrite` hook.)
    +@@ Documentation/git-notes.txt: corresponding <to-object>.  (The optional `<rest>` is ignored so that
    + the command can read the input given to the `post-rewrite` hook.)
      
      append::
    - 	Append to the notes of an existing object (defaults to HEAD).
    +-	Append to the notes of an existing object (defaults to HEAD).
     -	Creates a new notes object if needed.
    -+	Creates a new notes object if needed. 
    -+	The default delimiter is a blank line, use the `--separator`
    -+	option to insert other delimiters. More specifically, if the
    -+	note and the message are not empty, the delimiter will be
    -+	inserted between them. If you specify multiple `-m` and `-F`
    -+	options, the delimiter will be inserted between the messages
    -+	too.
    ++	Append new message(s) given by `-m` or `-F` options to an
    ++	existing note, or add them as a new note if one does not
    ++	exist, for the object (defaults to HEAD).  When appending to
    ++	an existing note, a blank line is added before each new
    ++	message as an inter-paragraph separator.  The separator can
    ++	be customized with the `--separator` option.
      
      edit::
      	Edit the notes for a given object (defaults to HEAD).
    @@ Documentation/git-notes.txt: OPTIONS
      	to automatically remove empty notes.
      
     +--separator <paragraph-break>::
    -+	The '<paragraph-break>' inserted between paragraphs.
    -+	A blank line by default.
    ++	Specify a string used as a custom inter-paragraph separator
    ++	(a newline is added at the end as needed).  Defaults to a
    ++	blank line.
     +
      --ref <ref>::
      	Manipulate the notes tree in <ref>.  This overrides
    @@ builtin/notes.c
      	N_("git notes [--ref <notes-ref>] edit [--allow-empty] [<object>]"),
      	N_("git notes [--ref <notes-ref>] show [<object>]"),
      	N_("git notes [--ref <notes-ref>] merge [-v | -q] [-s <strategy>] <notes-ref>"),
    +@@ builtin/notes.c: struct note_data {
    + 	int use_editor;
    + 	char *edit_path;
    + 	struct strbuf buf;
    ++	struct strbuf **messages;
    ++	size_t msg_nr;
    ++	size_t msg_alloc;
    + };
    + 
    + static void free_note_data(struct note_data *d)
     @@ builtin/notes.c: static void write_note_data(struct note_data *d, struct object_id *oid)
      	}
      }
    @@ builtin/notes.c: static void write_note_data(struct note_data *d, struct object_
     +		strbuf_insertf(message, pos, "%s%s", separator, "\n");
     +}
     +
    -+static void parse_messages(struct string_list *messages, struct note_data *d)
    ++/* Consume messages and append them into d->buf, then free them */
    ++static void concat_messages(struct note_data *d)
     +{
    ++	struct strbuf msg = STRBUF_INIT;
    ++
     +	size_t i;
    -+	for (i = 0; i < messages->nr; i++) {
    ++	for (i = 0; i < d->msg_nr ; i++) {
     +		if (d->buf.len)
     +			insert_separator(&d->buf, d->buf.len);
    -+		strbuf_insertstr(&d->buf, d->buf.len,
    -+				 messages->items[i].string);
    -+		strbuf_stripspace(&d->buf, 0);
    -+		d->given = 1;
    ++		strbuf_add(&msg, d->messages[i]->buf, d->messages[i]->len);
    ++		strbuf_addbuf(&d->buf, &msg);
    ++		strbuf_reset(&msg);
    ++		strbuf_release(d->messages[i]);
    ++		free(d->messages[i]);
     +	}
    ++	strbuf_release(&msg);
    ++	free(d->messages);
     +}
     +
      static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
      {
    --	struct note_data *d = opt->value;
    -+	struct string_list *msg = opt->value;
    + 	struct note_data *d = opt->value;
    ++	struct strbuf *buf;
      
      	BUG_ON_OPT_NEG(unset);
      
    @@ builtin/notes.c: static void write_note_data(struct note_data *d, struct object_
     -		strbuf_addch(&d->buf, '\n');
     -	strbuf_addstr(&d->buf, arg);
     -	strbuf_stripspace(&d->buf, 0);
    --
    ++	buf = xmalloc(sizeof(*buf));
    ++	strbuf_init(buf, strlen(arg));
    ++	strbuf_addstr(buf, arg);
    ++	strbuf_stripspace(buf, 0);
    + 
     -	d->given = 1;
    -+	string_list_append(msg, arg);
    ++	ALLOC_GROW_BY(d->messages, d->msg_nr, 1, d->msg_alloc);
    ++	d->messages[d->msg_nr - 1] = buf;
      	return 0;
      }
      
    -+
      static int parse_file_arg(const struct option *opt, const char *arg, int unset)
      {
    --	struct note_data *d = opt->value;
    -+	struct string_list *msg = opt->value;
    -+	struct strbuf buf = STRBUF_INIT;
    + 	struct note_data *d = opt->value;
    ++	struct strbuf *buf;
      
      	BUG_ON_OPT_NEG(unset);
      
     -	if (d->buf.len)
     -		strbuf_addch(&d->buf, '\n');
    ++	buf = xmalloc(sizeof(*buf));
    ++	strbuf_init(buf, 0);
    ++
      	if (!strcmp(arg, "-")) {
     -		if (strbuf_read(&d->buf, 0, 1024) < 0)
    -+		if (strbuf_read(&buf, 0, 1024) < 0)
    ++		if (strbuf_read(buf, 0, 1024) < 0)
      			die_errno(_("cannot read '%s'"), arg);
     -	} else if (strbuf_read_file(&d->buf, arg, 1024) < 0)
    -+	} else if (strbuf_read_file(&buf, arg, 1024) < 0)
    ++	} else if (strbuf_read_file(buf, arg, 1024) < 0)
      		die_errno(_("could not open or read '%s'"), arg);
     -	strbuf_stripspace(&d->buf, 0);
    ++	strbuf_stripspace(buf, 0);
    + 
    +-	d->given = 1;
    ++	// we will note stripspace the buf here, because the file maybe
    ++	// is a binary and it maybe contains multiple continuous line breaks.
    ++	ALLOC_GROW_BY(d->messages, d->msg_nr, 1, d->msg_alloc);
    ++	d->messages[d->msg_nr - 1] = buf;
    + 	return 0;
    + }
    + 
    + static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
    + {
    + 	struct note_data *d = opt->value;
    +-	char *buf;
    ++	struct strbuf *buf;
    + 	struct object_id object;
    + 	enum object_type type;
    + 	unsigned long len;
    + 
    + 	BUG_ON_OPT_NEG(unset);
    + 
    +-	if (d->buf.len)
    +-		strbuf_addch(&d->buf, '\n');
    +-
    ++	buf = xmalloc(sizeof(*buf));
    + 	if (get_oid(arg, &object))
    + 		die(_("failed to resolve '%s' as a valid ref."), arg);
    +-	if (!(buf = read_object_file(&object, &type, &len)))
    ++	if (!(buf->buf = read_object_file(&object, &type, &len)))
    + 		die(_("failed to read object '%s'."), arg);
    + 	if (type != OBJ_BLOB) {
    ++		strbuf_release(buf);
    + 		free(buf);
    + 		die(_("cannot read note data from non-blob object '%s'."), arg);
    + 	}
    +-	strbuf_add(&d->buf, buf, len);
    +-	free(buf);
      
     -	d->given = 1;
    -+	string_list_append(msg, buf.buf);
    -+	strbuf_release(&buf);
    ++	// The reuse object maybe is a binary content which could
    ++	// contains '\0' in the middle, so let's set the correct
    ++	// lenth of strbuf to concat all of content.
    ++	buf->len = len;
    ++	ALLOC_GROW_BY(d->messages, d->msg_nr, 1, d->msg_alloc);
    ++	d->messages[d->msg_nr - 1] = buf;
      	return 0;
      }
      
    + static int parse_reedit_arg(const struct option *opt, const char *arg, int unset)
    + {
    + 	struct note_data *d = opt->value;
    ++
    + 	BUG_ON_OPT_NEG(unset);
    + 	d->use_editor = 1;
    + 	return parse_reuse_arg(opt, arg, unset);
     @@ builtin/notes.c: static int add(int argc, const char **argv, const char *prefix)
    + 	struct notes_tree *t;
      	struct object_id object, new_note;
      	const struct object_id *note;
    - 	struct note_data d = { .buf = STRBUF_INIT };
    -+	struct string_list messages = STRING_LIST_INIT_DUP;
    +-	struct note_data d = { .buf = STRBUF_INIT };
    ++	struct note_data d = { .buf = STRBUF_INIT, .messages = NULL };
    ++
      	struct option options[] = {
    --		OPT_CALLBACK_F('m', "message", &d, N_("message"),
    -+		OPT_CALLBACK_F('m', "message", &messages, N_("message"),
    + 		OPT_CALLBACK_F('m', "message", &d, N_("message"),
      			N_("note contents as a string"), PARSE_OPT_NONEG,
    - 			parse_msg_arg),
    --		OPT_CALLBACK_F('F', "file", &d, N_("file"),
    -+		OPT_CALLBACK_F('F', "file", &messages, N_("file"),
    - 			N_("note contents in a file"), PARSE_OPT_NONEG,
    - 			parse_file_arg),
    - 		OPT_CALLBACK_F('c', "reedit-message", &d, N_("object"),
     @@ builtin/notes.c: static int add(int argc, const char **argv, const char *prefix)
      		OPT_BOOL(0, "allow-empty", &allow_empty,
      			N_("allow storing empty note")),
    @@ builtin/notes.c: static int add(int argc, const char **argv, const char *prefix)
      		usage_with_options(git_notes_add_usage, options);
      	}
      
    -+	parse_messages(&messages, &d);
    ++	if (d.msg_nr)
    ++		concat_messages(&d);
    ++	d.given = !!d.buf.len;
    ++
      	object_ref = argc > 1 ? argv[1] : "HEAD";
      
      	if (get_oid(object_ref, &object))
     @@ builtin/notes.c: static int append_edit(int argc, const char **argv, const char *prefix)
    + 	const struct object_id *note;
      	char *logmsg;
      	const char * const *usage;
    - 	struct note_data d = { .buf = STRBUF_INIT };
    -+	struct string_list messages = STRING_LIST_INIT_DUP;
    +-	struct note_data d = { .buf = STRBUF_INIT };
    ++	struct note_data d = { .buf = STRBUF_INIT, .messages = NULL };
    ++
      	struct option options[] = {
    --		OPT_CALLBACK_F('m', "message", &d, N_("message"),
    --			N_("note contents as a string"), PARSE_OPT_NONEG,
    -+		OPT_CALLBACK_F('m', "message", &messages, N_("message"),
    -+			N_("note contents as a string"), PARSE_OPT_NONEG, 
    - 			parse_msg_arg),
    --		OPT_CALLBACK_F('F', "file", &d, N_("file"),
    -+		OPT_CALLBACK_F('F', "file", &messages, N_("file"),
    - 			N_("note contents in a file"), PARSE_OPT_NONEG,
    - 			parse_file_arg),
    - 		OPT_CALLBACK_F('c', "reedit-message", &d, N_("object"),
    + 		OPT_CALLBACK_F('m', "message", &d, N_("message"),
    + 			N_("note contents as a string"), PARSE_OPT_NONEG,
     @@ builtin/notes.c: static int append_edit(int argc, const char **argv, const char *prefix)
      			parse_reuse_arg),
      		OPT_BOOL(0, "allow-empty", &allow_empty,
    @@ builtin/notes.c: static int append_edit(int argc, const char **argv, const char
      		usage_with_options(usage, options);
      	}
      
    -+	parse_messages(&messages, &d);
    ++	if (d.msg_nr)
    ++		concat_messages(&d);
    ++	d.given = !!d.buf.len;
     +
      	if (d.given && edit)
      		fprintf(stderr, _("The -m/-F/-c/-C options have been deprecated "
    @@ builtin/notes.c: static int append_edit(int argc, const char **argv, const char
      		free(prev_buf);
     
      ## t/t3301-notes.sh ##
    +@@
    + 
    + test_description='Test commit notes'
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + write_script fake_editor <<\EOF
     @@ t/t3301-notes.sh: test_expect_success 'do not create empty note with -m ""' '
      '
      
    @@ t/t3301-notes.sh: test_expect_success 'create note with combination of -m and -F
     +	git notes add -m "foo" -F note_a -m "bar" -F note_b -m "baz" --separator "-------" &&
     +	git notes show >actual &&
     +	test_cmp expect-combine_m_and_F actual
    -+	
     +'
     +
      test_expect_success 'remove note with "git notes remove"' '
    @@ t/t3301-notes.sh: test_expect_success 'listing non-existing notes fails' '
      test_expect_success 'append to existing note with "git notes append"' '
      	cat >expect <<-EOF &&
      		Initial set of notes
    +@@ t/t3301-notes.sh: test_expect_success 'create note from blob with "git notes add -C" reuses blob i
    + 	test_cmp blob actual
    + '
    + 
    ++test_expect_success 'create note from blob with "-C", also specify "-m", "-F" and "--separator"' '
    ++	# 8th will be reuseed in following tests, so rollback when the test is done
    ++	test_when_finished "git notes remove && git notes add -C $(cat blob)" &&
    ++	commit=$(git rev-parse HEAD) &&
    ++	cat >expect <<-EOF &&
    ++		commit $commit
    ++		Author: A U Thor <author@example.com>
    ++		Date:   Thu Apr 7 15:20:13 2005 -0700
    ++
    ++		${indent}8th
    ++
    ++		Notes:
    ++		${indent}This is a blob object
    ++		${indent}-------
    ++		${indent}This is created by -m
    ++		${indent}-------
    ++		${indent}This is created by -F
    ++	EOF
    ++
    ++	git notes remove &&
    ++	echo "This is a blob object" | git hash-object -w --stdin >blob &&
    ++	echo "This is created by -F" >note_a &&
    ++	git notes add -C $(cat blob) -m "This is created by -m" -F note_a --separator="-------" &&
    ++	git log -1 >actual &&
    ++	test_cmp expect actual
    ++'
    ++
    + test_expect_success 'create note from other note with "git notes add -c"' '
    + 	test_commit 9th &&
    + 	commit=$(git rev-parse HEAD) &&
-:  -------- > 4:  b9d12f0c notes.c: don't do stripespace when parse file arg
-- 
2.40.0.rc2.4.gb9d12f0c

