Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E194C7EE22
	for <git@archiver.kernel.org>; Thu, 18 May 2023 12:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjERMC3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 08:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjERMC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 08:02:27 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B6E10E
        for <git@vger.kernel.org>; Thu, 18 May 2023 05:02:24 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64d247a023aso242496b3a.2
        for <git@vger.kernel.org>; Thu, 18 May 2023 05:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684411344; x=1687003344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wqFOX2ZB/lM0LHojfJH3cwwJ0JAeq3kb3Fm4kmaGV8=;
        b=OaQsuYKFOIM78rPh3/TH5fhvwZ1dk+QNJpO/1l2/3iRy2BZFo43yjNipNxvYhEUd98
         kQ0Y/wSgZOicWE+cjWrDhxh/kaoflCXUlkLuS/bNACKEf9uKGoV+49pAD0BrfcvVU7YH
         iwbAB1EhGhqeVVIKbJGzS6g0UMF3HdpI0C4FAvNPvwKbC3lC/HoPk5nWcxYTk01SyNgw
         uTXRa8wlu7raDDrudWvnEPW9t+G2s6zJTE3WtJPIIE/8IqodS3vFWVl/qvQGOJJIB3dt
         K+H74veOGtwmWASg7m6mBfvilQobq6LSkiAfXG8tqatqFyC9toflVqLeR7k4PNICYatD
         wt/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684411344; x=1687003344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wqFOX2ZB/lM0LHojfJH3cwwJ0JAeq3kb3Fm4kmaGV8=;
        b=h7BhoLs+AEBQYt+uTrPlIxRuMh7LUyRNKkfPH8CkEtH5pr4xGibnRwuE6nM9+B/nK5
         gYfe5b9Ggx4nP/fpRL3nB8W7FLv/g7C7Bt7wkeIuAYa5tAKlxjJ/kKe3c2jOVPyCr4d9
         0L/yeAXBUL+M+I9CqQAu8DSasJUgqxqfSXD9cyaPO8CLCgS8+BUt01QmkcOV8juO/+Wn
         QkAVEu8/+vPko33VuG/sfN7AbUlteCwLubfvayypo2/TsCtkTkxi3qmdQkHzmgfVaThe
         7k8Twv1xquD1Q8SvNPMqpLl8NykMXchJ8iqVnyroaRVbxp3xbpV9DXCXDfK3oQ2fVCfW
         1N/Q==
X-Gm-Message-State: AC+VfDzCA62tj6shVkT+60f114ykYTPL4HZhrDB+ur2ix1ncdRfds12X
        aYBx1LQzBf08R9tf4vslhAg=
X-Google-Smtp-Source: ACHHUZ65W4+eA72lMBDsDuTpav98WVcIQSQpokI1MEMjZ/26ZLp158PTMTmTpy1/vTx7l2l8Olz19Q==
X-Received: by 2002:a17:902:ea06:b0:1ac:8ad0:1707 with SMTP id s6-20020a170902ea0600b001ac8ad01707mr2738206plg.1.1684411343651;
        Thu, 18 May 2023 05:02:23 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.51])
        by smtp.gmail.com with ESMTPSA id ji17-20020a170903325100b001960706141fsm1264203plb.149.2023.05.18.05.02.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 May 2023 05:02:21 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v10 0/6] notes.c: introduce "--separator" option
Date:   Thu, 18 May 2023 20:02:05 +0800
Message-ID: <cover.1684411136.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.40.0.356.g67a1c1d0
In-Reply-To: <cover.1682671758.git.dyroneteng@gmail.com>
References: <cover.1682671758.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

Diff since v9:

1. [4/6] support `--no-separator` which means not to add any paragraph-breaks.
2. [4/6] Fix the problems by the Junio's suggestion [1]

[1] https://public-inbox.org/git/xmqqsfcjbuud.fsf@gitster.g/

Thanks.

Teng Long (6):
  notes.c: cleanup 'strbuf_grow' call in 'append_edit'
  notes.c: use designated initializers for clarity
  t3321: add test cases about the notes stripspace behavior
  notes.c: introduce '[--[no-]separator|--separator=<paragraph-break>]'
    option
  notes.c: append separator instead of insert by pos
  notes.c: introduce "--[no-]stripspace" option

 Documentation/git-notes.txt |  43 ++-
 builtin/notes.c             | 157 +++++++---
 t/t3301-notes.sh            | 169 +++++++++++
 t/t3321-notes-stripspace.sh | 577 ++++++++++++++++++++++++++++++++++++
 4 files changed, 904 insertions(+), 42 deletions(-)
 create mode 100755 t/t3321-notes-stripspace.sh

Range-diff against v9:
1:  0634434e = 1:  0634434e notes.c: cleanup 'strbuf_grow' call in 'append_edit'
2:  4ad78405 = 2:  4ad78405 notes.c: use designated initializers for clarity
3:  c2fc2091 = 3:  c2fc2091 t3321: add test cases about the notes stripspace behavior
4:  ed930ef4 ! 4:  820dda04 notes.c: introduce '--separator=<paragraph-break>' option
    @@ Metadata
     Author: Teng Long <dyroneteng@gmail.com>
     
      ## Commit message ##
    -    notes.c: introduce '--separator=<paragraph-break>' option
    +    notes.c: introduce '[--[no-]separator|--separator=<paragraph-break>]' option
     
         When adding new notes or appending to an existing notes, we will
         insert a blank line between the paragraphs, like:
    @@ Commit message
     
         Both the two exections produce the same result.
     
    +    Alternatively, if you do not want any new paragraph
    +    separators, even a newline by default, you can specify
    +    '--no-separator'.
    +
         The reason we use a "strbuf" array to concat but not "string_list", is
         that the binary file content may contain '\0' in the middle, this will
         cause the corrupt result if using a string to save.
    @@ Documentation/git-notes.txt: SYNOPSIS
      [verse]
      'git notes' [list [<object>]]
     -'git notes' add [-f] [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
    -+'git notes' add [-f] [--allow-empty] [--separator=<paragraph-break>] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
    ++'git notes' add [-f] [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
      'git notes' copy [-f] ( --stdin | <from-object> [<to-object>] )
     -'git notes' append [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
    -+'git notes' append [--allow-empty] [--separator=<paragraph-break>] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
    ++'git notes' append [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
      'git notes' edit [--allow-empty] [<object>]
      'git notes' show [<object>]
      'git notes' merge [-v | -q] [-s <strategy> ] <notes-ref>
    @@ Documentation/git-notes.txt: OPTIONS
      	Allow an empty note object to be stored. The default behavior is
      	to automatically remove empty notes.
      
    -+--separator <paragraph-break>::
    ++--[no-]separator, --separator=<paragraph-break>::
     +	Specify a string used as a custom inter-paragraph separator
    -+	(a newline is added at the end as needed).  Defaults to a
    -+	blank line.
    ++	(a newline is added at the end as needed). If `--no-separator`, no
    ++	separators will be added between paragraphs.  Defaults to a blank
    ++	line.
     +
      --ref <ref>::
      	Manipulate the notes tree in <ref>.  This overrides
    @@ builtin/notes.c
      #include "worktree.h"
      #include "write-or-die.h"
      
    -+static char *separator = "\n";
    ++static const char *separator = "\n";
      static const char * const git_notes_usage[] = {
      	N_("git notes [--ref <notes-ref>] [list [<object>]]"),
     -	N_("git notes [--ref <notes-ref>] add [-f] [--allow-empty] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
    -+	N_("git notes [--ref <notes-ref>] add [-f] [--allow-empty] [--separator=<paragraph-break>] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
    ++	N_("git notes [--ref <notes-ref>] add [-f] [--allow-empty] [--[no-]separator|--separator=<paragraph-break>] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
      	N_("git notes [--ref <notes-ref>] copy [-f] <from-object> <to-object>"),
     -	N_("git notes [--ref <notes-ref>] append [--allow-empty] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
    -+	N_("git notes [--ref <notes-ref>] append [--allow-empty] [--separator=<paragraph-break>] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
    ++	N_("git notes [--ref <notes-ref>] append [--allow-empty] [--[no-]separator|--separator=<paragraph-break>] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
      	N_("git notes [--ref <notes-ref>] edit [--allow-empty] [<object>]"),
      	N_("git notes [--ref <notes-ref>] show [<object>]"),
      	N_("git notes [--ref <notes-ref>] merge [-v | -q] [-s <strategy>] <notes-ref>"),
    @@ builtin/notes.c: static void write_note_data(struct note_data *d, struct object_
      
     +static void insert_separator(struct strbuf *message, size_t pos)
     +{
    -+	if (separator[strlen(separator) - 1] == '\n')
    -+		strbuf_addstr(message, separator);
    ++	if (!separator)
    ++		return;
    ++	else if (separator[strlen(separator) - 1] == '\n')
    ++		strbuf_insertstr(message, pos, separator);
     +	else
     +		strbuf_insertf(message, pos, "%s%s", separator, "\n");
     +}
    @@ builtin/notes.c: static void write_note_data(struct note_data *d, struct object_
     +static void concat_messages(struct note_data *d)
     +{
     +	struct strbuf msg = STRBUF_INIT;
    -+
     +	size_t i;
    ++
     +	for (i = 0; i < d->msg_nr ; i++) {
     +		if (d->buf.len)
     +			insert_separator(&d->buf, d->buf.len);
    @@ builtin/notes.c: static void write_note_data(struct note_data *d, struct object_
      	return 0;
      }
      
    +@@ builtin/notes.c: static int parse_reedit_arg(const struct option *opt, const char *arg, int unset
    + 	return parse_reuse_arg(opt, arg, unset);
    + }
    + 
    ++static int parse_separator_arg(const struct option *opt, const char *arg,
    ++			       int unset)
    ++{
    ++	if (unset)
    ++		*(const char **)opt->value = NULL;
    ++	else
    ++		*(const char **)opt->value = arg ? arg : "\n";
    ++	return 0;
    ++}
    ++
    + static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
    + {
    + 	struct strbuf buf = STRBUF_INIT;
     @@ builtin/notes.c: static int add(int argc, const char **argv, const char *prefix)
      	struct object_id object, new_note;
      	const struct object_id *note;
    @@ builtin/notes.c: static int add(int argc, const char **argv, const char *prefix)
      		OPT_BOOL(0, "allow-empty", &allow_empty,
      			N_("allow storing empty note")),
      		OPT__FORCE(&force, N_("replace existing notes"), PARSE_OPT_NOCOMPLETE),
    -+		OPT_STRING(0, "separator", &separator, N_("separator"),
    -+			N_("insert <paragraph-break> between paragraphs")),
    ++		OPT_CALLBACK_F(0, "separator", &separator,
    ++			N_("<paragraph-break>"),
    ++			N_("insert <paragraph-break> between paragraphs"),
    ++			PARSE_OPT_OPTARG, parse_separator_arg),
      		OPT_END()
      	};
      
    @@ builtin/notes.c: static int append_edit(int argc, const char **argv, const char
      			parse_reuse_arg),
      		OPT_BOOL(0, "allow-empty", &allow_empty,
      			N_("allow storing empty note")),
    -+		OPT_STRING(0, "separator", &separator, N_("separator"),
    -+			N_("insert <paragraph-break> between paragraphs")),
    ++		OPT_CALLBACK_F(0, "separator", &separator,
    ++			N_("<paragraph-break>"),
    ++			N_("insert <paragraph-break> between paragraphs"),
    ++			PARSE_OPT_OPTARG, parse_separator_arg),
      		OPT_END()
      	};
      	int edit = !strcmp(argv[0], "edit");
    @@ t/t3301-notes.sh: test_expect_success 'create note with combination of -m and -F
      '
      
     +test_expect_success 'create note with combination of -m and -F and --separator' '
    ++	test_when_finished git notes remove HEAD &&
     +	cat >expect-combine_m_and_F <<-\EOF &&
     +	foo
     +	-------
    @@ t/t3301-notes.sh: test_expect_success 'create note with combination of -m and -F
     +	EOF
     +	echo "xyzzy" >note_a &&
     +	echo "zyxxy" >note_b &&
    -+	git notes add -m "foo" -F note_a -m "bar" -F note_b -m "baz" --separator "-------" &&
    ++	git notes add -m "foo" -F note_a -m "bar" -F note_b -m "baz" --separator="-------" &&
    ++	git notes show >actual &&
    ++	test_cmp expect-combine_m_and_F actual
    ++'
    ++
    ++test_expect_success 'create note with combination of -m and -F and --no-separator' '
    ++	cat >expect-combine_m_and_F <<-\EOF &&
    ++	foo
    ++	xyzzy
    ++	bar
    ++	zyxxy
    ++	baz
    ++	EOF
    ++	echo "xyzzy" >note_a &&
    ++	echo "zyxxy" >note_b &&
    ++	git notes add -m "foo" -F note_a -m "bar" -F note_b -m "baz" --no-separator &&
     +	git notes show >actual &&
     +	test_cmp expect-combine_m_and_F actual
     +'
    @@ t/t3301-notes.sh: test_expect_success 'listing non-existing notes fails' '
      	test_must_be_empty actual
      '
      
    -+test_expect_success 'append: specify an empty separator' '
    ++test_expect_success 'append: specify a separator with an empty arg' '
     +	test_when_finished git notes remove HEAD &&
     +	cat >expect <<-\EOF &&
     +	notes-1
    @@ t/t3301-notes.sh: test_expect_success 'listing non-existing notes fails' '
     +	test_cmp expect actual
     +'
     +
    ++test_expect_success 'append: specify a separator without arg' '
    ++	test_when_finished git notes remove HEAD &&
    ++	cat >expect <<-\EOF &&
    ++	notes-1
    ++
    ++	notes-2
    ++	EOF
    ++
    ++	git notes add -m "notes-1" &&
    ++	git notes append --separator -m "notes-2" &&
    ++	git notes show >actual &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'append: specify as --no-separator' '
    ++	test_when_finished git notes remove HEAD &&
    ++	cat >expect <<-\EOF &&
    ++	notes-1
    ++	notes-2
    ++	EOF
    ++
    ++	git notes add -m "notes-1" &&
    ++	git notes append --no-separator -m "notes-2" &&
    ++	git notes show >actual &&
    ++	test_cmp expect actual
    ++'
    ++
     +test_expect_success 'append: specify separator with line break' '
     +	test_when_finished git notes remove HEAD &&
     +	cat >expect <<-\EOF &&
    @@ t/t3301-notes.sh: test_expect_success 'listing non-existing notes fails' '
     +
     +	echo "f-notes-1" >note_a &&
     +	echo "f-notes-2" >note_b &&
    -+	git notes append -m "m-notes-1" -F note_a -m "m-notes-2" -F note_b -m "m-notes-3" --separator "-------" &&
    ++	git notes append -m "m-notes-1" -F note_a -m "m-notes-2" -F note_b -m "m-notes-3" --separator="-------" &&
     +	git notes show >actual &&
     +	test_cmp expect-combine_m_and_F actual
     +'
5:  eea2246f ! 5:  76c93f19 notes.c: append separator instead of insert by pos
    @@ builtin/notes.c: static void write_note_data(struct note_data *d, struct object_
     -static void insert_separator(struct strbuf *message, size_t pos)
     +static void append_separator(struct strbuf *message)
      {
    - 	if (separator[strlen(separator) - 1] == '\n')
    - 		strbuf_addstr(message, separator);
    + 	if (!separator)
    + 		return;
    + 	else if (separator[strlen(separator) - 1] == '\n')
    +-		strbuf_insertstr(message, pos, separator);
    ++		strbuf_addstr(message, separator);
      	else
     -		strbuf_insertf(message, pos, "%s%s", separator, "\n");
     +		strbuf_addf(message, "%s%s", separator, "\n");
    @@ builtin/notes.c: static void write_note_data(struct note_data *d, struct object_
      
      static void concat_messages(struct note_data *d)
     @@ builtin/notes.c: static void concat_messages(struct note_data *d)
    - 	size_t i;
    + 
      	for (i = 0; i < d->msg_nr ; i++) {
      		if (d->buf.len)
     -			insert_separator(&d->buf, d->buf.len);
6:  20063bea ! 6:  d65f067c notes.c: introduce "--[no-]stripspace" option
    @@ Documentation/git-notes.txt: SYNOPSIS
      --------
      [verse]
      'git notes' [list [<object>]]
    --'git notes' add [-f] [--allow-empty] [--separator=<paragraph-break>] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
    -+'git notes' add [-f] [--allow-empty] [--separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
    +-'git notes' add [-f] [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
    ++'git notes' add [-f] [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
      'git notes' copy [-f] ( --stdin | <from-object> [<to-object>] )
    --'git notes' append [--allow-empty] [--separator=<paragraph-break>] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
    +-'git notes' append [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
     -'git notes' edit [--allow-empty] [<object>]
    -+'git notes' append [--allow-empty] [--separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
    ++'git notes' append [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
     +'git notes' edit [--allow-empty] [<object>] [--[no-]stripspace]
      'git notes' show [<object>]
      'git notes' merge [-v | -q] [-s <strategy> ] <notes-ref>
    @@ Documentation/git-notes.txt: OPTIONS
      -c <object>::
      --reedit-message=<object>::
     @@ Documentation/git-notes.txt: OPTIONS
    - 	(a newline is added at the end as needed).  Defaults to a
    - 	blank line.
    + 	separators will be added between paragraphs.  Defaults to a blank
    + 	line.
      
     +--[no-]stripspace::
     +	Strip leading and trailing whitespace from the note message.
    @@ Documentation/git-notes.txt: OPTIONS
      	`GIT_NOTES_REF` and the "core.notesRef" configuration.  The ref
     
      ## builtin/notes.c ##
    +@@
    + static const char *separator = "\n";
    + static const char * const git_notes_usage[] = {
    + 	N_("git notes [--ref <notes-ref>] [list [<object>]]"),
    +-	N_("git notes [--ref <notes-ref>] add [-f] [--allow-empty] [--[no-]separator|--separator=<paragraph-break>] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
    ++	N_("git notes [--ref <notes-ref>] add [-f] [--allow-empty] [--[no-]separator|--separator=<paragraph-break>] [--[no-]stripspace] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
    + 	N_("git notes [--ref <notes-ref>] copy [-f] <from-object> <to-object>"),
    +-	N_("git notes [--ref <notes-ref>] append [--allow-empty] [--[no-]separator|--separator=<paragraph-break>] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
    ++	N_("git notes [--ref <notes-ref>] append [--allow-empty] [--[no-]separator|--separator=<paragraph-break>] [--[no-]stripspace] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
    + 	N_("git notes [--ref <notes-ref>] edit [--allow-empty] [<object>]"),
    + 	N_("git notes [--ref <notes-ref>] show [<object>]"),
    + 	N_("git notes [--ref <notes-ref>] merge [-v | -q] [-s <strategy>] <notes-ref>"),
     @@ builtin/notes.c: static const char * const git_notes_get_ref_usage[] = {
      static const char note_template[] =
      	N_("Write/edit the notes for the following object:");
    @@ builtin/notes.c: static int add(int argc, const char **argv, const char *prefix)
      	struct option options[] = {
      		OPT_CALLBACK_F('m', "message", &d, N_("message"),
     @@ builtin/notes.c: static int add(int argc, const char **argv, const char *prefix)
    - 		OPT__FORCE(&force, N_("replace existing notes"), PARSE_OPT_NOCOMPLETE),
    - 		OPT_STRING(0, "separator", &separator, N_("separator"),
    - 			N_("insert <paragraph-break> between paragraphs")),
    + 			N_("<paragraph-break>"),
    + 			N_("insert <paragraph-break> between paragraphs"),
    + 			PARSE_OPT_OPTARG, parse_separator_arg),
     +		OPT_BOOL(0, "stripspace", &d.stripspace,
     +			N_("remove unnecessary whitespace")),
      		OPT_END()
    @@ builtin/notes.c: static int append_edit(int argc, const char **argv, const char
      		OPT_CALLBACK_F('m', "message", &d, N_("message"),
      			N_("note contents as a string"), PARSE_OPT_NONEG,
     @@ builtin/notes.c: static int append_edit(int argc, const char **argv, const char *prefix)
    - 			N_("allow storing empty note")),
    - 		OPT_STRING(0, "separator", &separator, N_("separator"),
    - 			N_("insert <paragraph-break> between paragraphs")),
    + 			N_("<paragraph-break>"),
    + 			N_("insert <paragraph-break> between paragraphs"),
    + 			PARSE_OPT_OPTARG, parse_separator_arg),
     +		OPT_BOOL(0, "stripspace", &d.stripspace,
     +			N_("remove unnecessary whitespace")),
      		OPT_END()
-- 
2.40.0.356.g67a1c1d0

