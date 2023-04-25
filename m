Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DDBC6FD18
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 13:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbjDYNf2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 09:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbjDYNfS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 09:35:18 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A2D1445A
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 06:34:50 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b5465fb99so4823377b3a.1
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 06:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682429689; x=1685021689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k05jn+CB3by2N+QjO3w85fkfjSzc58b5gvYxKJnft1U=;
        b=qZ6OOFNt7GRAj4KojsJToImjn5DuW20Ep2y5W73l6kRLCjW9/z2za8uzPvPGyGT/Y2
         As8WqCYdzU8VnXdZYNlDOJSSjjxTQPM5xNAmrG7/zN65frY3B4s7nNsqHMYsYl9Xpm/y
         jie6q5c1hmN8H0aiEdOwxLNx6uqdidlWlCT1iuGEyirH5LnTVV0bZWJowY5MkV6PQJ3Z
         Gsc1x3CAWWK9o1lln0Qtg5EHtJUShRAZ+RWDhHaEiLqftMoG1joKg8FIe4f9L+PlgIae
         K5CJCG/rEVW0dcXgNKG+TJaEkBirxfRCB5nlGG3wh2ztmefOpnmfvk6RxJcR9AmufrDO
         mYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682429689; x=1685021689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k05jn+CB3by2N+QjO3w85fkfjSzc58b5gvYxKJnft1U=;
        b=AxkgwIVSTvKmn9FCTl5/bbihhzcm1/vScU83OB/zb0iYB9yxukepEY44vsLTv8UEAP
         j29yNZG5qeeGzZ7k0J5vr6Rb4BJFWC7KrYkDFERlKw06ATNHvMsy84DogaU5uas+bHJd
         BsoJoI4SFfo7/UJQB8ALcEw14Ee1aSYDkgsNcn20Ds618abI59HNYJQAo/iYQiYbkoKf
         77KagNbnTrxYwmKtb+Zd3aDcI7lAVFZ3ITXJaxyY7ONFRpwfoOp18dQaxXqhPSFE3Dhg
         qUubr/t33B/Tbod/sQE3zs/C5jJ0XFL9AbeQU7vJyUX44AOKaTY+Jyl9ul84mAaFAGr1
         IBXA==
X-Gm-Message-State: AC+VfDyDklgMLVf/GOr/NlZ/v5wYKuIjVlXzFIDVFCHA4K8Bn4aiCwus
        /pWh5cXRZG/ri6eZQHLlVzUHK39zJrDSE6ml
X-Google-Smtp-Source: ACHHUZ6ULtxVap+/rKXjTa7mzhKn90O6EYuQ1Qf58YMHUsiSJjuJqz4GBEs0l6tCA08cN/SalNZm2g==
X-Received: by 2002:a05:6a21:1189:b0:f6:8d47:17f5 with SMTP id oj9-20020a056a21118900b000f68d4717f5mr370726pzb.11.1682429689182;
        Tue, 25 Apr 2023 06:34:49 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.60])
        by smtp.gmail.com with ESMTPSA id c192-20020a621cc9000000b0063d44634d8csm9243469pfc.71.2023.04.25.06.34.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2023 06:34:48 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH 0/6] notes.c: introduce "--separator" option
Date:   Tue, 25 Apr 2023 21:34:35 +0800
Message-ID: <cover.1682429602.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.40.0.358.g931d6dc6
In-Reply-To: <cover.1680012650.git.dyroneteng@gmail.com>
References: <cover.1680012650.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

Diff since v7:

1. Fix problems that Junio's replies in last patch, except:

   * array of strbufs -> string_list (in [1]): the message may from
   a binary file which may contain '\0' in middle, string will be
   cut off then make a unexpected result.

2. New commit [3/6] for adding test cases about stripspace behavior.
3. New commit [6/6] for supporting "--[no-]stripspace".

[1] https://public-inbox.org/git/xmqq5yakhoo9.fsf@gitster.g/

Thanks.

Teng Long (6):
  notes.c: cleanup 'strbuf_grow' call in 'append_edit'
  notes.c: use designated initializers for clarity
  t3321: add test cases about the notes stripspace behavior
  notes.c: introduce '--separator=<paragraph-break>' option
  notes.c: append separator instead of insert by pos
  notes.c: introduce "--[no-]stripspace" option

 Documentation/git-notes.txt |  42 ++-
 builtin/notes.c             | 144 +++++++---
 t/t3301-notes.sh            | 126 +++++++++
 t/t3321-notes-stripspace.sh | 521 ++++++++++++++++++++++++++++++++++++
 4 files changed, 791 insertions(+), 42 deletions(-)
 create mode 100755 t/t3321-notes-stripspace.sh

Range-diff against v7:
1:  ea9c199e ! 1:  0634434e notes.c: cleanup 'strbuf_grow' call in 'append_edit'
    @@ builtin/notes.c: static int parse_msg_arg(const struct option *opt, const char *
      		strbuf_addch(&d->buf, '\n');
      	strbuf_addstr(&d->buf, arg);
     @@ builtin/notes.c: static int append_edit(int argc, const char **argv, const char *prefix)
    - 		enum object_type type;
    - 		char *prev_buf = read_object_file(note, &type, &size);
    + 		char *prev_buf = repo_read_object_file(the_repository, note,
    + 						       &type, &size);
      
     -		strbuf_grow(&d.buf, size + 1);
      		if (d.buf.len && prev_buf && size)
2:  9dc123c8 ! 2:  4ad78405 notes.c: cleanup for "designated init"
    @@ Metadata
     Author: Teng Long <dyroneteng@gmail.com>
     
      ## Commit message ##
    -    notes.c: cleanup for "designated init"
    +    notes.c: use designated initializers for clarity
     
         The "struct note_data d = { 0, 0, NULL, STRBUF_INIT };" style could be
    -    replaced with designated init format.
    +    replaced with designated initializer for clarity.
     
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
    +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## builtin/notes.c ##
     @@ builtin/notes.c: static int add(int argc, const char **argv, const char *prefix)
-:  -------- > 3:  6dfb5bf2 t3321: add test cases about the notes stripspace behavior
3:  d1febf86 ! 4:  be86f9ca notes.c: introduce '--separator=<paragraph-break>' option
    @@ Commit message
     
         The default behavour sometimes is not enough, the user may want
         to use a custom delimiter between paragraphs, like when
    -    specifiy '-m', '-F', '-C', '-c' options. So this commit
    +    specifying '-m', '-F', '-C', '-c' options. So this commit
         introduce a new '--separator' option for 'git notes add' and
    -    'git notes append', for example when execute:
    +    'git notes append', for example when executing:
     
             $ git notes add -m foo -m bar --separator="-"
             $ git notes show HEAD | cat
    @@ Commit message
             -
             bar
     
    -    A newline is added to the value given to --separator if it
    -    does not end with one already. So execute:
    +    a newline is added to the value given to --separator if it
    +    does not end with one already. So when executing:
     
               $ git notes add -m foo -m bar --separator="-"
         and
    @@ Commit message
               "
               $ git notes add -m foo -m bar --separator="-$LF"
     
    -    Running A and B produces the same result.
    +    Both the two exections produce the same result.
    +
    +    The reason we use a "strbuf" array to concat but not "string_list", is
    +    that the binary file content may contain '\0' in the middle, this will
    +    cause the corrupt result if using a string to save.
     
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
     
    @@ Documentation/git-notes.txt: OPTIONS
     
      ## builtin/notes.c ##
     @@
    - #include "notes-utils.h"
    +  */
    + 
    + #include "cache.h"
    ++#include "alloc.h"
    + #include "config.h"
    + #include "builtin.h"
    + #include "gettext.h"
    +@@
      #include "worktree.h"
    + #include "write-or-die.h"
      
     +static char *separator = NULL;
      static const char * const git_notes_usage[] = {
    @@ builtin/notes.c
      	N_("git notes [--ref <notes-ref>] edit [--allow-empty] [<object>]"),
      	N_("git notes [--ref <notes-ref>] show [<object>]"),
      	N_("git notes [--ref <notes-ref>] merge [-v | -q] [-s <strategy>] <notes-ref>"),
    -@@ builtin/notes.c: struct note_data {
    +@@ builtin/notes.c: static const char * const git_notes_get_ref_usage[] = {
    + static const char note_template[] =
    + 	N_("Write/edit the notes for the following object:");
    + 
    ++struct note_msg {
    ++	int stripspace;
    ++	struct strbuf buf;
    ++};
    ++
    + struct note_data {
    + 	int given;
      	int use_editor;
      	char *edit_path;
      	struct strbuf buf;
    -+	struct strbuf **messages;
    ++	struct note_msg **messages;
     +	size_t msg_nr;
     +	size_t msg_alloc;
      };
      
      static void free_note_data(struct note_data *d)
    +@@ builtin/notes.c: static void free_note_data(struct note_data *d)
    + 		free(d->edit_path);
    + 	}
    + 	strbuf_release(&d->buf);
    ++
    ++	while (d->msg_nr) {
    ++		--d->msg_nr;
    ++		strbuf_release(&d->messages[d->msg_nr]->buf);
    ++		free(d->messages[d->msg_nr]);
    ++	}
    ++	free(d->messages);
    + }
    + 
    + static int list_each_note(const struct object_id *object_oid,
     @@ builtin/notes.c: static void write_note_data(struct note_data *d, struct object_id *oid)
      	}
      }
    @@ builtin/notes.c: static void write_note_data(struct note_data *d, struct object_
     +		strbuf_insertf(message, pos, "%s%s", separator, "\n");
     +}
     +
    -+/* Consume messages and append them into d->buf, then free them */
     +static void concat_messages(struct note_data *d)
     +{
     +	struct strbuf msg = STRBUF_INIT;
    @@ builtin/notes.c: static void write_note_data(struct note_data *d, struct object_
     +	for (i = 0; i < d->msg_nr ; i++) {
     +		if (d->buf.len)
     +			insert_separator(&d->buf, d->buf.len);
    -+		strbuf_add(&msg, d->messages[i]->buf, d->messages[i]->len);
    ++		strbuf_add(&msg, d->messages[i]->buf.buf, d->messages[i]->buf.len);
     +		strbuf_addbuf(&d->buf, &msg);
    ++		if (d->messages[i]->stripspace)
    ++			strbuf_stripspace(&d->buf, 0);
     +		strbuf_reset(&msg);
    -+		strbuf_release(d->messages[i]);
    -+		free(d->messages[i]);
     +	}
     +	strbuf_release(&msg);
    -+	free(d->messages);
     +}
     +
      static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
      {
      	struct note_data *d = opt->value;
    -+	struct strbuf *buf;
    ++	struct note_msg *msg = xmalloc(sizeof(*msg));
      
      	BUG_ON_OPT_NEG(unset);
      
    @@ builtin/notes.c: static void write_note_data(struct note_data *d, struct object_
     -		strbuf_addch(&d->buf, '\n');
     -	strbuf_addstr(&d->buf, arg);
     -	strbuf_stripspace(&d->buf, 0);
    -+	buf = xmalloc(sizeof(*buf));
    -+	strbuf_init(buf, strlen(arg));
    -+	strbuf_addstr(buf, arg);
    -+	strbuf_stripspace(buf, 0);
    - 
    +-
     -	d->given = 1;
    ++	strbuf_init(&msg->buf, strlen(arg));
    ++	strbuf_addstr(&msg->buf, arg);
     +	ALLOC_GROW_BY(d->messages, d->msg_nr, 1, d->msg_alloc);
    -+	d->messages[d->msg_nr - 1] = buf;
    ++	d->messages[d->msg_nr - 1] = msg;
    ++	msg->stripspace = 1;
      	return 0;
      }
      
      static int parse_file_arg(const struct option *opt, const char *arg, int unset)
      {
      	struct note_data *d = opt->value;
    -+	struct strbuf *buf;
    ++	struct note_msg *msg = xmalloc(sizeof(*msg));
      
      	BUG_ON_OPT_NEG(unset);
      
     -	if (d->buf.len)
     -		strbuf_addch(&d->buf, '\n');
    -+	buf = xmalloc(sizeof(*buf));
    -+	strbuf_init(buf, 0);
    -+
    ++	strbuf_init(&msg->buf , 0);
      	if (!strcmp(arg, "-")) {
     -		if (strbuf_read(&d->buf, 0, 1024) < 0)
    -+		if (strbuf_read(buf, 0, 1024) < 0)
    ++		if (strbuf_read(&msg->buf, 0, 1024) < 0)
      			die_errno(_("cannot read '%s'"), arg);
     -	} else if (strbuf_read_file(&d->buf, arg, 1024) < 0)
    -+	} else if (strbuf_read_file(buf, arg, 1024) < 0)
    ++	} else if (strbuf_read_file(&msg->buf, arg, 1024) < 0)
      		die_errno(_("could not open or read '%s'"), arg);
     -	strbuf_stripspace(&d->buf, 0);
    -+	strbuf_stripspace(buf, 0);
      
     -	d->given = 1;
    -+	// we will note stripspace the buf here, because the file maybe
    -+	// is a binary and it maybe contains multiple continuous line breaks.
     +	ALLOC_GROW_BY(d->messages, d->msg_nr, 1, d->msg_alloc);
    -+	d->messages[d->msg_nr - 1] = buf;
    ++	d->messages[d->msg_nr - 1] = msg;
    ++	msg->stripspace = 1;
      	return 0;
      }
      
    @@ builtin/notes.c: static void write_note_data(struct note_data *d, struct object_
      {
      	struct note_data *d = opt->value;
     -	char *buf;
    -+	struct strbuf *buf;
    ++	struct note_msg *msg = xmalloc(sizeof(*msg));
    ++	char *value;
      	struct object_id object;
      	enum object_type type;
      	unsigned long len;
    @@ builtin/notes.c: static void write_note_data(struct note_data *d, struct object_
     -	if (d->buf.len)
     -		strbuf_addch(&d->buf, '\n');
     -
    -+	buf = xmalloc(sizeof(*buf));
    - 	if (get_oid(arg, &object))
    ++	strbuf_init(&msg->buf, 0);
    + 	if (repo_get_oid(the_repository, arg, &object))
      		die(_("failed to resolve '%s' as a valid ref."), arg);
    --	if (!(buf = read_object_file(&object, &type, &len)))
    -+	if (!(buf->buf = read_object_file(&object, &type, &len)))
    +-	if (!(buf = repo_read_object_file(the_repository, &object, &type, &len)))
    ++	if (!(value = repo_read_object_file(the_repository, &object, &type, &len)))
      		die(_("failed to read object '%s'."), arg);
      	if (type != OBJ_BLOB) {
    -+		strbuf_release(buf);
    - 		free(buf);
    +-		free(buf);
    ++		strbuf_release(&msg->buf);
    ++		free(value);
    ++		free(msg);
      		die(_("cannot read note data from non-blob object '%s'."), arg);
      	}
     -	strbuf_add(&d->buf, buf, len);
     -	free(buf);
      
     -	d->given = 1;
    -+	// The reuse object maybe is a binary content which could
    -+	// contains '\0' in the middle, so let's set the correct
    -+	// lenth of strbuf to concat all of content.
    -+	buf->len = len;
    ++	strbuf_add(&msg->buf, value, len);
    ++	free(value);
    ++
    ++	msg->buf.len = len;
     +	ALLOC_GROW_BY(d->messages, d->msg_nr, 1, d->msg_alloc);
    -+	d->messages[d->msg_nr - 1] = buf;
    ++	d->messages[d->msg_nr - 1] = msg;
    ++	msg->stripspace = 0;
      	return 0;
      }
      
    - static int parse_reedit_arg(const struct option *opt, const char *arg, int unset)
    - {
    - 	struct note_data *d = opt->value;
    -+
    - 	BUG_ON_OPT_NEG(unset);
    - 	d->use_editor = 1;
    - 	return parse_reuse_arg(opt, arg, unset);
     @@ builtin/notes.c: static int add(int argc, const char **argv, const char *prefix)
    - 	struct notes_tree *t;
      	struct object_id object, new_note;
      	const struct object_id *note;
    --	struct note_data d = { .buf = STRBUF_INIT };
    -+	struct note_data d = { .buf = STRBUF_INIT, .messages = NULL };
    + 	struct note_data d = { .buf = STRBUF_INIT };
     +
      	struct option options[] = {
      		OPT_CALLBACK_F('m', "message", &d, N_("message"),
    @@ builtin/notes.c: static int add(int argc, const char **argv, const char *prefix)
     +
      	object_ref = argc > 1 ? argv[1] : "HEAD";
      
    - 	if (get_oid(object_ref, &object))
    -@@ builtin/notes.c: static int append_edit(int argc, const char **argv, const char *prefix)
    - 	const struct object_id *note;
    - 	char *logmsg;
    - 	const char * const *usage;
    --	struct note_data d = { .buf = STRBUF_INIT };
    -+	struct note_data d = { .buf = STRBUF_INIT, .messages = NULL };
    -+
    - 	struct option options[] = {
    - 		OPT_CALLBACK_F('m', "message", &d, N_("message"),
    - 			N_("note contents as a string"), PARSE_OPT_NONEG,
    + 	if (repo_get_oid(the_repository, object_ref, &object))
     @@ builtin/notes.c: static int append_edit(int argc, const char **argv, const char *prefix)
      			parse_reuse_arg),
      		OPT_BOOL(0, "allow-empty", &allow_empty,
    @@ builtin/notes.c: static int append_edit(int argc, const char **argv, const char
      		fprintf(stderr, _("The -m/-F/-c/-C options have been deprecated "
      			"for the 'edit' subcommand.\n"
     @@ builtin/notes.c: static int append_edit(int argc, const char **argv, const char *prefix)
    - 		char *prev_buf = read_object_file(note, &type, &size);
    + 						       &type, &size);
      
      		if (d.buf.len && prev_buf && size)
     -			strbuf_insertstr(&d.buf, 0, "\n");
    @@ builtin/notes.c: static int append_edit(int argc, const char **argv, const char
      		free(prev_buf);
     
      ## t/t3301-notes.sh ##
    -@@
    - 
    - test_description='Test commit notes'
    - 
    -+TEST_PASSES_SANITIZE_LEAK=true
    - . ./test-lib.sh
    - 
    - write_script fake_editor <<\EOF
     @@ t/t3301-notes.sh: test_expect_success 'do not create empty note with -m ""' '
      '
      
4:  b9d12f0c < -:  -------- notes.c: don't do stripespace when parse file arg
-:  -------- > 5:  ef40e0ef notes.c: append separator instead of insert by pos
-:  -------- > 6:  f60f7432 notes.c: introduce "--[no-]stripspace" option
-- 
2.40.0.358.g931d6dc6

