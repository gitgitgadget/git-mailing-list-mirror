Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E57C77B60
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 09:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345358AbjD1JXv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 05:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjD1JXt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 05:23:49 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95E82114
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 02:23:46 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63b67a26069so11892728b3a.0
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 02:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682673826; x=1685265826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7u74p2tXIJHAe772f18yOOJ6Dg+EPqGEylstjmPUBjw=;
        b=bsKLFaNmyNI0Dld7gCPnin/ELwM1emtTw6kSResOlk8bZZAu1GTI8jKD1F59bD3gCD
         Sq1wAMo4Ax2OHXWWtKzpXlwM2P5IuKQcWh6PJYreOxJhEoKk4qHNmd6WclXng+rhkW8a
         xyOAoHMHk+SJFOsBGUwT1Mn/t3PC9uuJMeA4jkE7biZwEHncX29O/m8tmDN+/EGhoAIi
         9K+/ol6SAxEZC0S+PLiKLt1IOe6T+IZk8v/g5O2Wm10js4+qAwkxWsouuPWR/3po5zYl
         g75wu/Murr9f1hUqkbhlYLSDBAt3PTcDMgWRSGFXi4RO72MPBVTpDA97CRjlsnObdoVE
         Vw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682673826; x=1685265826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7u74p2tXIJHAe772f18yOOJ6Dg+EPqGEylstjmPUBjw=;
        b=AYASALamYuVX5pVWIOruD6bZ66d7c1cpj19hpTfXuS7UGhe+PWxEFMiqlAFUs9u0pC
         lW4Qso3kGOmbvxXuVWhdBSiQWWehw4wNIK7cGwdKX1f0sU7DTOkWrJkzAvch/6vqAMpP
         BqTPeoBRPORatqlz7nPp5xNuoTdorPBUrHuiJqu8Ooi5yPrw9JA/Zv2shu0r21O3fkLJ
         Ja8kbvmO/iDi/h2fTy2Hc/XO2tFpoMHOw+vBiGOQJsiSK5Q00KDUBIleyU+TYY5Wh3Un
         T8D4q61gbGl7AtMC59vYK/bE3oj1cOdmq3M3IGIfRDQq+BXR+uCHBE8Ur5fmvE+gHs24
         z3qg==
X-Gm-Message-State: AC+VfDz2QxQJ2GjyzOIvagG9ZyWGMT6iTGeno4FZ1tzbJP4x8WV0fYEK
        aQkLGegHKTT4dBNO1/5dSao=
X-Google-Smtp-Source: ACHHUZ70GIAJJk2QbcEt4fbcjXn/hZIBge/U8+EIMUNly1L1sjxFTDjMsahJKIgwYAhceI+w4aOPTA==
X-Received: by 2002:a05:6a20:6a26:b0:ef:2389:66ca with SMTP id p38-20020a056a206a2600b000ef238966camr6184894pzk.7.1682673825737;
        Fri, 28 Apr 2023 02:23:45 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.51])
        by smtp.gmail.com with ESMTPSA id i21-20020a056a00225500b0063b8f33cb81sm15107078pfu.93.2023.04.28.02.23.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Apr 2023 02:23:45 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v9 0/6] notes.c: introduce "--separator" option
Date:   Fri, 28 Apr 2023 17:23:28 +0800
Message-ID: <cover.1682671758.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.40.0.358.g2947072e.dirty
In-Reply-To: <cover.1682429602.git.dyroneteng@gmail.com>
References: <cover.1682429602.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

Diff since v8:

1. test case: Uniform indent format, as recommended by Junio C Hamano.

2. [4/6] make the static var "separator" initialized as "\n", simplify
   the code in "insert_separator(...)".

3. [4/6] I don't change the other parts about the "struct note_msg", the
   stripspace way (Junio suggest to consider about the stripspace each messge
   individually, but I found it will break the compatibility about "-C",
   which can be found the case of 'reuse with "-C" and add note with "-m",
   "-m" will stripspace all together').
4. [5/6] Optimized the commit message and replace "strbuf_insert*(...)" with
   "strbuf_add*(...)".

5. [6/6] As Junio replied, I'm not sure whether the "-C" problem (When the
   "-C" argument is used with "-m/-F", the order of "-C" in the options will
   affect the result of stripspace differently,) is need to be fixed or keep
   as is, I choose to do not break the old behaviour (In fact, I hope to fix
   this issue in another patch, if at all, and let this long-tailed patchset
   to mature faster, maybe).

Thanks.

Teng Long (6):
  notes.c: cleanup 'strbuf_grow' call in 'append_edit'
  notes.c: use designated initializers for clarity
  t3321: add test cases about the notes stripspace behavior
  notes.c: introduce '--separator=<paragraph-break>' option
  notes.c: append separator instead of insert by pos
  notes.c: introduce "--[no-]stripspace" option

 Documentation/git-notes.txt |  42 ++-
 builtin/notes.c             | 141 ++++++---
 t/t3301-notes.sh            | 126 ++++++++
 t/t3321-notes-stripspace.sh | 577 ++++++++++++++++++++++++++++++++++++
 4 files changed, 844 insertions(+), 42 deletions(-)
 create mode 100755 t/t3321-notes-stripspace.sh

Range-diff against v8:
1:  0634434e = 1:  0634434e notes.c: cleanup 'strbuf_grow' call in 'append_edit'
2:  4ad78405 = 2:  4ad78405 notes.c: use designated initializers for clarity
3:  6dfb5bf2 ! 3:  c2fc2091 t3321: add test cases about the notes stripspace behavior
    @@ t/t3321-notes-stripspace.sh (new)
     @@
     +#!/bin/sh
     +#
    -+# Copyright (c) 2007 Teng Long
    ++# Copyright (c) 2023 Teng Long
     +#
     +
     +test_description='Test commit notes with stripspace behavior'
    @@ t/t3321-notes-stripspace.sh (new)
     +test_expect_success 'add note by editor' '
     +	test_when_finished "git notes remove" &&
     +	cat >expect <<-EOF &&
    -+		first-line
    ++	first-line
     +
    -+		second-line
    ++	second-line
     +	EOF
     +
     +	MSG="${LF}first-line${MULTI_LF}second-line${LF}" git notes add  &&
    @@ t/t3321-notes-stripspace.sh (new)
     +test_expect_success 'add note by specifying single "-m"' '
     +	test_when_finished "git notes remove" &&
     +	cat >expect <<-EOF &&
    -+		first-line
    ++	first-line
     +
    -+		second-line
    ++	second-line
     +	EOF
     +
     +	git notes add -m "${LF}first-line${MULTI_LF}second-line${LF}" &&
    @@ t/t3321-notes-stripspace.sh (new)
     +test_expect_success 'append note by editor' '
     +	test_when_finished "git notes remove" &&
     +	cat >expect <<-EOF &&
    -+		first-line
    ++	first-line
     +
    -+		second-line
    ++	second-line
     +	EOF
     +
     +	git notes add -m "first-line" &&
    @@ t/t3321-notes-stripspace.sh (new)
     +test_expect_success 'append note by specifying single "-m"' '
     +	test_when_finished "git notes remove" &&
     +	cat >expect <<-EOF &&
    -+		first-line
    ++	first-line
     +
    -+		second-line
    ++	second-line
     +	EOF
     +
     +	git notes add -m "${LF}first-line" &&
    @@ t/t3321-notes-stripspace.sh (new)
     +test_expect_success 'add note by specifying single "-F"' '
     +	test_when_finished "git notes remove" &&
     +	cat >expect <<-EOF &&
    -+		first-line
    ++	first-line
     +
    -+		second-line
    ++	second-line
     +	EOF
     +
     +	cat >note-file <<-EOF &&
    -+		${LF}
    -+		first-line
    -+		${MULTI_LF}
    -+		second-line
    -+		${LF}
    ++	${LF}
    ++	first-line
    ++	${MULTI_LF}
    ++	second-line
    ++	${LF}
     +	EOF
     +
     +	git notes add -F note-file &&
    @@ t/t3321-notes-stripspace.sh (new)
     +test_expect_success 'add notes by specifying multiple "-F"' '
     +	test_when_finished "git notes remove" &&
     +	cat >expect <<-EOF &&
    -+		file-1-first-line
    ++	file-1-first-line
     +
    -+		file-1-second-line
    ++	file-1-second-line
     +
    -+		file-2-first-line
    ++	file-2-first-line
     +
    -+		file-2-second-line
    ++	file-2-second-line
     +	EOF
     +
     +	cat >note-file-1 <<-EOF &&
    -+		${LF}
    -+		file-1-first-line
    -+		${MULTI_LF}
    -+		file-1-second-line
    -+		${LF}
    ++	${LF}
    ++	file-1-first-line
    ++	${MULTI_LF}
    ++	file-1-second-line
    ++	${LF}
     +	EOF
     +
     +	cat >note-file-2 <<-EOF &&
    -+		${LF}
    -+		file-2-first-line
    -+		${MULTI_LF}
    -+		file-2-second-line
    -+		${LF}
    ++	${LF}
    ++	file-2-first-line
    ++	${MULTI_LF}
    ++	file-2-second-line
    ++	${LF}
     +	EOF
     +
     +	git notes add -F note-file-1 -F note-file-2 &&
    @@ t/t3321-notes-stripspace.sh (new)
     +test_expect_success 'append note by specifying single "-F"' '
     +	test_when_finished "git notes remove" &&
     +	cat >expect <<-EOF &&
    -+		initial-line
    ++	initial-line
     +
    -+		first-line
    ++	first-line
     +
    -+		second-line
    ++	second-line
     +	EOF
     +
     +	cat >note-file <<-EOF &&
    -+		${LF}
    -+		first-line
    -+		${MULTI_LF}
    -+		second-line
    -+		${LF}
    ++	${LF}
    ++	first-line
    ++	${MULTI_LF}
    ++	second-line
    ++	${LF}
     +	EOF
     +
     +	git notes add -m "initial-line" &&
    @@ t/t3321-notes-stripspace.sh (new)
     +test_expect_success 'append notes by specifying multiple "-F"' '
     +	test_when_finished "git notes remove" &&
     +	cat >expect <<-EOF &&
    -+		initial-line
    ++	initial-line
     +
    -+		file-1-first-line
    ++	file-1-first-line
     +
    -+		file-1-second-line
    ++	file-1-second-line
     +
    -+		file-2-first-line
    ++	file-2-first-line
     +
    -+		file-2-second-line
    ++	file-2-second-line
     +	EOF
     +
     +	cat >note-file-1 <<-EOF &&
    -+		${LF}
    -+		file-1-first-line
    -+		${MULTI_LF}
    -+		file-1-second-line
    -+		${LF}
    ++	${LF}
    ++	file-1-first-line
    ++	${MULTI_LF}
    ++	file-1-second-line
    ++	${LF}
     +	EOF
     +
     +	cat >note-file-2 <<-EOF &&
    -+		${LF}
    -+		file-2-first-line
    -+		${MULTI_LF}
    -+		file-2-second-line
    -+		${LF}
    ++	${LF}
    ++	file-2-first-line
    ++	${MULTI_LF}
    ++	file-2-second-line
    ++	${LF}
     +	EOF
     +
     +	git notes add -m "initial-line" &&
    @@ t/t3321-notes-stripspace.sh (new)
     +test_expect_success 'add note by specifying "-C" , do not stripspace is the default behavior' '
     +	test_when_finished "git notes remove" &&
     +	cat >expect <<-EOF &&
    -+		${LF}
    -+		first-line
    -+		${MULTI_LF}
    -+		second-line
    -+		${LF}
    ++	${LF}
    ++	first-line
    ++	${MULTI_LF}
    ++	second-line
    ++	${LF}
     +	EOF
     +
     +	cat expect | git hash-object -w --stdin >blob &&
    @@ t/t3321-notes-stripspace.sh (new)
     +test_expect_success 'add notes with "-C" and "-m", "-m" will stripspace all together' '
     +	test_when_finished "git notes remove" &&
     +	cat >data <<-EOF &&
    -+		${LF}
    -+		first-line
    -+		${MULTI_LF}
    -+		second-line
    -+		${LF}
    ++	${LF}
    ++	first-line
    ++	${MULTI_LF}
    ++	second-line
    ++	${LF}
     +	EOF
     +
     +	cat >expect <<-EOF &&
    -+		first-line
    ++	first-line
     +
    -+		second-line
    ++	second-line
     +
    -+		third-line
    ++	third-line
     +	EOF
     +
     +	cat data | git hash-object -w --stdin >blob &&
    @@ t/t3321-notes-stripspace.sh (new)
     +	test_when_finished "git notes remove" &&
     +	cat >data <<-EOF &&
     +
    -+		second-line
    ++	second-line
     +	EOF
     +
     +	cat >expect <<-EOF &&
    -+		first-line
    -+		${LF}
    -+		second-line
    ++	first-line
    ++	${LF}
    ++	second-line
     +	EOF
     +
     +	cat data | git hash-object -w --stdin >blob &&
4:  be86f9ca ! 4:  ed930ef4 notes.c: introduce '--separator=<paragraph-break>' option
    @@ Commit message
         insert a blank line between the paragraphs, like:
     
              $ git notes add -m foo -m bar
    -         $ git notes show HEAD | cat
    +         $ git notes show HEAD
              foo
     
              bar
    @@ Commit message
         'git notes append', for example when executing:
     
             $ git notes add -m foo -m bar --separator="-"
    -        $ git notes show HEAD | cat
    +        $ git notes show HEAD
             foo
             -
             bar
    @@ builtin/notes.c
      #include "worktree.h"
      #include "write-or-die.h"
      
    -+static char *separator = NULL;
    ++static char *separator = "\n";
      static const char * const git_notes_usage[] = {
      	N_("git notes [--ref <notes-ref>] [list [<object>]]"),
     -	N_("git notes [--ref <notes-ref>] add [-f] [--allow-empty] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
    @@ builtin/notes.c: static void free_note_data(struct note_data *d)
      	}
      	strbuf_release(&d->buf);
     +
    -+	while (d->msg_nr) {
    -+		--d->msg_nr;
    ++	while (d->msg_nr--) {
     +		strbuf_release(&d->messages[d->msg_nr]->buf);
     +		free(d->messages[d->msg_nr]);
     +	}
    @@ builtin/notes.c: static void write_note_data(struct note_data *d, struct object_
      
     +static void insert_separator(struct strbuf *message, size_t pos)
     +{
    -+	if (!separator)
    -+		strbuf_insertstr(message, pos, "\n");
    -+	else if (separator[strlen(separator) - 1] == '\n')
    -+		strbuf_insertstr(message, pos, separator);
    ++	if (separator[strlen(separator) - 1] == '\n')
    ++		strbuf_addstr(message, separator);
     +	else
     +		strbuf_insertf(message, pos, "%s%s", separator, "\n");
     +}
5:  ef40e0ef ! 5:  eea2246f notes.c: append separator instead of insert by pos
    @@ Metadata
      ## Commit message ##
         notes.c: append separator instead of insert by pos
     
    -    This commit rename "insert_separator" to "append_separator" and also
    -    remove the "postion" argument, this serves two purpose:
    +    Rename "insert_separator" to "append_separator" and also remove the
    +    "postion" argument, this serves two purpose:
     
         The first is that when specifying more than one "-m" ( like "-F", etc)
         to "git notes add" or "git notes append", the order of them matters,
    @@ Commit message
         so we don't have to make the caller specify the position, the "append"
         operation is enough and clear.
     
    -    The second is that when we execute the "git notes append" subcommand
    -    , we need to combine the "prev_note" and "current_note" to get the
    +    The second is that when we execute the "git notes append" subcommand,
    +    we need to combine the "prev_note" and "current_note" to get the
         final result. Before, we inserted a newline character at the beginning
         of "current_note". Now, we will append a newline to the end of
         "prev_note" instead, this will give the consisitent results.
    @@ builtin/notes.c: static void write_note_data(struct note_data *d, struct object_
     -static void insert_separator(struct strbuf *message, size_t pos)
     +static void append_separator(struct strbuf *message)
      {
    - 	if (!separator)
    --		strbuf_insertstr(message, pos, "\n");
    -+		strbuf_insertstr(message, message->len, "\n");
    - 	else if (separator[strlen(separator) - 1] == '\n')
    --		strbuf_insertstr(message, pos, separator);
    -+		strbuf_insertstr(message, message->len, separator);
    + 	if (separator[strlen(separator) - 1] == '\n')
    + 		strbuf_addstr(message, separator);
      	else
     -		strbuf_insertf(message, pos, "%s%s", separator, "\n");
    -+		strbuf_insertf(message, message->len, "%s%s", separator, "\n");
    ++		strbuf_addf(message, "%s%s", separator, "\n");
      }
      
      static void concat_messages(struct note_data *d)
6:  f60f7432 ! 6:  20063bea notes.c: introduce "--[no-]stripspace" option
    @@ t/t3321-notes-stripspace.sh: test_expect_success 'add note by editor' '
     +test_expect_success 'add note by specifying single "-m", "--stripspace" is the default behavior' '
      	test_when_finished "git notes remove" &&
      	cat >expect <<-EOF &&
    - 		first-line
    + 	first-line
     @@ t/t3321-notes-stripspace.sh: test_expect_success 'add note by specifying single "-m"' '
      
      	git notes add -m "${LF}first-line${MULTI_LF}second-line${LF}" &&
    @@ t/t3321-notes-stripspace.sh: test_expect_success 'add note by specifying single
     +test_expect_success 'add note by specifying single "-m" and "--no-stripspace" ' '
     +	test_when_finished "git notes remove" &&
     +	cat >expect <<-EOF &&
    -+		${LF}first-line${MULTI_LF}second-line
    ++	${LF}first-line${MULTI_LF}second-line
     +	EOF
     +
     +	git notes add --no-stripspace \
    @@ t/t3321-notes-stripspace.sh: test_expect_success 'add note by specifying multipl
      	test_cmp expect actual
      '
      
    --
    --test_expect_success 'append note by editor' '
     +test_expect_success 'add notes by specifying multiple "-m" and "--no-stripspace"' '
    - 	test_when_finished "git notes remove" &&
    - 	cat >expect <<-EOF &&
    -+		${LF}
    - 		first-line
    --
    --		second-line
    -+		${MULTI_LF}
    -+		second-line${LF}
    - 	EOF
    - 
    --	git notes add -m "first-line" &&
    --	MSG="${MULTI_LF}second-line${LF}" git notes append  &&
    ++	test_when_finished "git notes remove" &&
    ++	cat >expect <<-EOF &&
    ++	${LF}
    ++	first-line
    ++	${MULTI_LF}
    ++	second-line${LF}
    ++	EOF
    ++
     +	git notes add --no-stripspace \
     +		      -m "${LF}" \
     +		      -m "first-line" \
     +		      -m "${MULTI_LF}" \
     +		      -m "second-line" \
     +		      -m "${LF}" &&
    - 	git notes show >actual &&
    - 	test_cmp expect actual
    - '
    - 
    --test_expect_success 'append note by specifying single "-m"' '
    -+test_expect_success 'add note by specifying single "-F", "--stripspace" is the default behavior' '
    - 	test_when_finished "git notes remove" &&
    - 	cat >expect <<-EOF &&
    - 		first-line
    -@@ t/t3321-notes-stripspace.sh: test_expect_success 'append note by specifying single "-m"' '
    - 		second-line
    - 	EOF
    - 
    --	git notes add -m "${LF}first-line" &&
    --	git notes append -m "${MULTI_LF}second-line${LF}" &&
    --	git notes show >actual &&
    --	test_cmp expect actual
    --'
    --
    --test_expect_success 'append note by specifying multiple "-m"' '
    --	test_when_finished "git notes remove" &&
    --	cat >expect <<-EOF &&
    --	first-line
    --
    --	second-line
    -+	cat >note-file <<-EOF &&
    -+		${LF}
    -+		first-line
    -+		${MULTI_LF}
    -+		second-line
    -+		${LF}
    - 	EOF
    - 
    --	git notes add -m "${LF}first-line" &&
    --	git notes append -m "${MULTI_LF}" \
    --		      -m "second-line" \
    --		      -m "${LF}" &&
    -+	git notes add -F note-file &&
    - 	git notes show >actual &&
    --	test_cmp expect actual
    -+	test_cmp expect actual &&
    -+	git notes remove &&
    -+	git notes add --stripspace -F note-file &&
    -+	git notes show >actual
    - '
    - 
    --test_expect_success 'add note by specifying single "-F"' '
    -+test_expect_success 'add note by specifying single "-F" and "--no-stripspace"' '
    - 	test_when_finished "git notes remove" &&
    - 	cat >expect <<-EOF &&
    -+		${LF}
    - 		first-line
    --
    -+		${MULTI_LF}
    - 		second-line
    -+		${LF}
    - 	EOF
    - 
    - 	cat >note-file <<-EOF &&
    -@@ t/t3321-notes-stripspace.sh: test_expect_success 'add note by specifying single "-F"' '
    - 		${LF}
    - 	EOF
    - 
    --	git notes add -F note-file &&
    -+	git notes add --no-stripspace -F note-file &&
    - 	git notes show >actual &&
    - 	test_cmp expect actual
    - '
    - 
    --test_expect_success 'add notes by specifying multiple "-F"' '
    -+test_expect_success 'add note by specifying multiple "-F", "--stripspace" is the default behavior' '
    - 	test_when_finished "git notes remove" &&
    - 	cat >expect <<-EOF &&
    - 		file-1-first-line
    -@@ t/t3321-notes-stripspace.sh: test_expect_success 'add notes by specifying multiple "-F"' '
    - 
    - 	git notes add -F note-file-1 -F note-file-2 &&
    - 	git notes show >actual &&
    -+	test_cmp expect actual &&
    -+	git notes remove &&
    -+	git notes add --stripspace -F note-file-1 -F note-file-2 &&
     +	git notes show >actual &&
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'add note by specifying multiple "-F" with "--no-stripspace"' '
    ++test_expect_success 'add note by specifying single "-F", "--stripspace" is the default behavior' '
     +	test_when_finished "git notes remove" &&
     +	cat >expect <<-EOF &&
    -+		${LF}
    -+		file-1-first-line
    -+		${MULTI_LF}
    -+		file-1-second-line
    -+		${LF}
    -+
    -+		${LF}
    -+		file-2-first-line
    -+		${MULTI_LF}
    -+		file-2-second-line
    -+		${LF}
    -+	EOF
    ++	first-line
     +
    -+	cat >note-file-1 <<-EOF &&
    -+		${LF}
    -+		file-1-first-line
    -+		${MULTI_LF}
    -+		file-1-second-line
    -+		${LF}
    ++	second-line
     +	EOF
     +
    -+	cat >note-file-2 <<-EOF &&
    -+		${LF}
    -+		file-2-first-line
    -+		${MULTI_LF}
    -+		file-2-second-line
    -+		${LF}
    ++	cat >note-file <<-EOF &&
    ++	${LF}
    ++	first-line
    ++	${MULTI_LF}
    ++	second-line
    ++	${LF}
     +	EOF
     +
    -+	git notes add --no-stripspace -F note-file-1 -F note-file-2 &&
    ++	git notes add -F note-file &&
     +	git notes show >actual &&
    -+	test_cmp expect actual
    ++	test_cmp expect actual &&
    ++	git notes remove &&
    ++	git notes add --stripspace -F note-file &&
    ++	git notes show >actual
     +'
     +
    -+test_expect_success 'append note by editor' '
    ++test_expect_success 'add note by specifying single "-F" and "--no-stripspace"' '
     +	test_when_finished "git notes remove" &&
     +	cat >expect <<-EOF &&
    -+		first-line
    ++	${LF}
    ++	first-line
    ++	${MULTI_LF}
    ++	second-line
    ++	${LF}
    ++	EOF
     +
    -+		second-line
    ++	cat >note-file <<-EOF &&
    ++	${LF}
    ++	first-line
    ++	${MULTI_LF}
    ++	second-line
    ++	${LF}
     +	EOF
     +
    -+	git notes add -m "first-line" &&
    -+	MSG="${MULTI_LF}second-line${LF}" git notes append  &&
    ++	git notes add --no-stripspace -F note-file &&
     +	git notes show >actual &&
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'append note by specifying single "-m"' '
    ++test_expect_success 'add note by specifying multiple "-F", "--stripspace" is the default behavior' '
     +	test_when_finished "git notes remove" &&
     +	cat >expect <<-EOF &&
    -+		first-line
    ++	file-1-first-line
    ++
    ++	file-1-second-line
    ++
    ++	file-2-first-line
     +
    -+		second-line
    ++	file-2-second-line
    ++	EOF
    ++
    ++	cat >note-file-1 <<-EOF &&
    ++	${LF}
    ++	file-1-first-line
    ++	${MULTI_LF}
    ++	file-1-second-line
    ++	${LF}
    ++	EOF
    ++
    ++	cat >note-file-2 <<-EOF &&
    ++	${LF}
    ++	file-2-first-line
    ++	${MULTI_LF}
    ++	file-2-second-line
    ++	${LF}
     +	EOF
     +
    -+	git notes add -m "${LF}first-line" &&
    -+	git notes append -m "${MULTI_LF}second-line${LF}" &&
    ++	git notes add -F note-file-1 -F note-file-2 &&
    ++	git notes show >actual &&
    ++	test_cmp expect actual &&
    ++	git notes remove &&
    ++	git notes add --stripspace -F note-file-1 -F note-file-2 &&
     +	git notes show >actual &&
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'append note by specifying multiple "-m"' '
    ++test_expect_success 'add note by specifying multiple "-F" with "--no-stripspace"' '
     +	test_when_finished "git notes remove" &&
     +	cat >expect <<-EOF &&
    -+	first-line
    ++	${LF}
    ++	file-1-first-line
    ++	${MULTI_LF}
    ++	file-1-second-line
    ++	${LF}
    ++
    ++	${LF}
    ++	file-2-first-line
    ++	${MULTI_LF}
    ++	file-2-second-line
    ++	${LF}
    ++	EOF
     +
    -+	second-line
    ++	cat >note-file-1 <<-EOF &&
    ++	${LF}
    ++	file-1-first-line
    ++	${MULTI_LF}
    ++	file-1-second-line
    ++	${LF}
    ++	EOF
    ++
    ++	cat >note-file-2 <<-EOF &&
    ++	${LF}
    ++	file-2-first-line
    ++	${MULTI_LF}
    ++	file-2-second-line
    ++	${LF}
     +	EOF
     +
    -+	git notes add -m "${LF}first-line" &&
    -+	git notes append -m "${MULTI_LF}" -m "second-line" -m "${LF}" &&
    ++	git notes add --no-stripspace -F note-file-1 -F note-file-2 &&
     +	git notes show >actual &&
    - 	test_cmp expect actual
    - '
    ++	test_cmp expect actual
    ++'
      
    + test_expect_success 'append note by editor' '
    + 	test_when_finished "git notes remove" &&
     @@ t/t3321-notes-stripspace.sh: test_expect_success 'append notes by specifying multiple "-F"' '
      	test_cmp expect actual
      '
    @@ t/t3321-notes-stripspace.sh: test_expect_success 'append notes by specifying mul
     +test_expect_success 'append note by specifying multiple "-F" with "--no-stripspace"' '
     +	test_when_finished "git notes remove" &&
     +	cat >expect <<-EOF &&
    -+		initial-line
    -+		${LF}${LF}
    -+		file-1-first-line
    -+		${MULTI_LF}
    -+		file-1-second-line
    -+		${LF}
    -+
    -+		${LF}
    -+		file-2-first-line
    -+		${MULTI_LF}
    -+		file-2-second-line
    -+		${LF}
    ++	initial-line
    ++	${LF}${LF}
    ++	file-1-first-line
    ++	${MULTI_LF}
    ++	file-1-second-line
    ++	${LF}
    ++
    ++	${LF}
    ++	file-2-first-line
    ++	${MULTI_LF}
    ++	file-2-second-line
    ++	${LF}
     +	EOF
     +
     +	cat >note-file-1 <<-EOF &&
    -+		${LF}
    -+		file-1-first-line
    -+		${MULTI_LF}
    -+		file-1-second-line
    -+		${LF}
    ++	${LF}
    ++	file-1-first-line
    ++	${MULTI_LF}
    ++	file-1-second-line
    ++	${LF}
     +	EOF
     +
     +	cat >note-file-2 <<-EOF &&
    -+		${LF}
    -+		file-2-first-line
    -+		${MULTI_LF}
    -+		file-2-second-line
    -+		${LF}
    ++	${LF}
    ++	file-2-first-line
    ++	${MULTI_LF}
    ++	file-2-second-line
    ++	${LF}
     +	EOF
     +
     +	git notes add -m "initial-line" &&
    @@ t/t3321-notes-stripspace.sh: test_expect_success 'add notes with empty messages'
     +test_expect_success 'add note by specifying "-C", "--no-stripspace" is the default behavior' '
      	test_when_finished "git notes remove" &&
      	cat >expect <<-EOF &&
    - 		${LF}
    + 	${LF}
     @@ t/t3321-notes-stripspace.sh: test_expect_success 'add note by specifying "-C" , do not stripspace is the defa
      	cat expect | git hash-object -w --stdin >blob &&
      	git notes add -C $(cat blob) &&
    @@ t/t3321-notes-stripspace.sh: test_expect_success 'add note by specifying "-C" ,
     +test_expect_success 'reuse note by specifying "-C" and "--stripspace"' '
     +	test_when_finished "git notes remove" &&
     +	cat >data <<-EOF &&
    -+		${LF}
    -+		first-line
    -+		${MULTI_LF}
    -+		second-line
    -+		${LF}
    ++	${LF}
    ++	first-line
    ++	${MULTI_LF}
    ++	second-line
    ++	${LF}
     +	EOF
     +
     +	cat >expect <<-EOF &&
    -+		first-line
    ++	first-line
     +
    -+		second-line
    ++	second-line
     +	EOF
     +
     +	cat data | git hash-object -w --stdin >blob &&
    @@ t/t3321-notes-stripspace.sh: test_expect_success 'add note by specifying "-C" ,
     +test_expect_success 'reuse with "-C" and add note with "-m", "-m" will stripspace all together' '
      	test_when_finished "git notes remove" &&
      	cat >data <<-EOF &&
    - 		${LF}
    + 	${LF}
     @@ t/t3321-notes-stripspace.sh: test_expect_success 'add notes with "-C" and "-m", "-m" will stripspace all toge
      	test_cmp expect actual
      '
    @@ t/t3321-notes-stripspace.sh: test_expect_success 'add notes with "-m" and "-C",
     +test_expect_success 'add note by specifying "-c", "--stripspace" is the default behavior' '
     +	test_when_finished "git notes remove" &&
     +	cat >expect <<-EOF &&
    -+		first-line
    ++	first-line
     +
    -+		second-line
    ++	second-line
     +	EOF
     +
     +	echo "initial-line" | git hash-object -w --stdin >blob &&
    @@ t/t3321-notes-stripspace.sh: test_expect_success 'add notes with "-m" and "-C",
     +test_expect_success 'add note by specifying "-c" with "--no-stripspace"' '
     +	test_when_finished "git notes remove" &&
     +	cat >expect <<-EOF &&
    -+		${LF}first-line${MULTI_LF}second-line${LF}
    ++	${LF}first-line${MULTI_LF}second-line${LF}
     +	EOF
     +
     +	echo "initial-line" | git hash-object -w --stdin >blob &&
    @@ t/t3321-notes-stripspace.sh: test_expect_success 'add notes with "-m" and "-C",
     +test_expect_success 'edit note by specifying "-c", "--stripspace" is the default behavior' '
     +	test_when_finished "git notes remove" &&
     +	cat >expect <<-EOF &&
    -+		first-line
    ++	first-line
     +
    -+		second-line
    ++	second-line
     +	EOF
     +
     +	MSG="${LF}first-line${MULTI_LF}second-line${LF}" git notes edit &&
    @@ t/t3321-notes-stripspace.sh: test_expect_success 'add notes with "-m" and "-C",
     +test_expect_success 'edit note by specifying "-c" with "--no-stripspace"' '
     +	test_when_finished "git notes remove" &&
     +	cat >expect <<-EOF &&
    -+		${LF}first-line${MULTI_LF}second-line${LF}
    ++	${LF}first-line${MULTI_LF}second-line${LF}
     +	EOF
     +
     +	MSG="${LF}first-line${MULTI_LF}second-line${LF}" git notes add --no-stripspace &&
-- 
2.40.0.358.g2947072e.dirty

