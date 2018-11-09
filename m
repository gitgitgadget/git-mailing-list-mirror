Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F24D1F453
	for <e@80x24.org>; Fri,  9 Nov 2018 08:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbeKIRr6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 12:47:58 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42893 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbeKIRr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 12:47:57 -0500
Received: by mail-wr1-f66.google.com with SMTP id y15-v6so864844wru.9
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 00:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ttDuqwZtSsxDcLK8pVf4X1zj0uww6wbkB7UqNeVY+Fw=;
        b=pdPWQFBzTzuQivEme7w+8ZupyaT1KOa9TBktnKJ1mWu22z/DgQrHdmgWoLQjzHunE2
         o9byiXJQ4LFtV3mH4wnr+dKfmSucnWNaQX5T7rKBY5Zuxr731bV60iT0jxgN30N967Ze
         ZT8k/r34cNLCrVF6YxwXN4u6lv/osfM6uaqWVDycNkrORkk001cGLdwmTO8T6CZWFkul
         AzExfWEtkz8GkESHLXk2dFDOqvx1nlfihBkL+dXtMBxCJIkUm0iqW4yKpDMyk1EjROJP
         pcNKyw5WhI9N6ypclqTl1EHcCRzgnI8muuuyPbLLO7dJshzh0dt7YQKW7L2eLrR14d07
         a10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ttDuqwZtSsxDcLK8pVf4X1zj0uww6wbkB7UqNeVY+Fw=;
        b=ZkV1jN/7K69xgJAeXgQSP2tAmySLk2r5Jj/oEsQyv3qzzrHzACaxmgDE4Kj6ochSKQ
         F1jPIUAWFoSwm2fM75El1QjJhguArMCPmnhdMPKMK92iNSIlgzWZA4t97+o4OyTutxkO
         0PrX0edIoKz05pkkgzWk4dt1vh2hvyRSE8X6rQKZPW+o7VD2HZ1UakgeFIyu+sWTZTPt
         dZ2MLqx6O5WZJD4tSbxN27xcAfXpjhmBv6ZG2QSQVdyXmuyq8ruqLti1B57dWrYw4iut
         m8AvZOQrKY0LbZSa1TF2m68OycVXQJclbcv42V7kEIkanJ8tVKtxLVU5tgv+vZJGAQ3K
         DxkQ==
X-Gm-Message-State: AGRZ1gJUIKD0Qih0N/0/A1h70yHTGxciHb7y2uYiCkfxVWp84x8sjyZ3
        VbN4wJSzD2HZygqj0nYqUgaH/+n6
X-Google-Smtp-Source: AJdET5dpi4LqauFWAE29wlBlAedZT9gGyyON3A9y+98tYGZIeYAMSs9JxnV/Myk2LmAGMJG4xq0vxA==
X-Received: by 2002:adf:c5c4:: with SMTP id v4-v6mr7062946wrg.30.1541750910078;
        Fri, 09 Nov 2018 00:08:30 -0800 (PST)
Received: from andromeda.lan (atoulouse-658-1-60-221.w92-136.abo.wanadoo.fr. [92.136.157.221])
        by smtp.googlemail.com with ESMTPSA id x194-v6sm3003973wmd.41.2018.11.09.00.08.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 00:08:29 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 00/16] sequencer: refactor functions working on a todo_list
Date:   Fri,  9 Nov 2018 09:07:49 +0100
Message-Id: <20181109080805.6350-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181027212930.9303-1-alban.gruin@gmail.com>
References: <20181027212930.9303-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At the center of the "interactive" part of the interactive rebase lies
the todo list.  When the user starts an interactive rebase, a todo list
is generated, presented to the user (who then edits it using a text
editor), read back, and then is checked and processed before the actual
rebase takes place.

Some of this processing includes adding execs commands, reordering
fixup! and squash! commits, and checking if no commits were accidentally
dropped by the user.

Before I converted the interactive rebase in C, these functions were
called by git-rebase--interactive.sh through git-rebase--helper.  Since
the only way to pass around a large amount of data between a shell
script and a C program is to use a file (or any declination of a file),
the functions that checked and processed the todo list were directly
working on a file, the same file that the user edited.

During the conversion, I did not address this issue, which lead to a
complete_action() that reads the todo list file, does some computation
based on its content, and writes it back to the disk, several times in
the same function.

As it is not an efficient way to handle a data structure, this patch
series refactor the functions that processes the todo list to work on a
todo_list structure instead of reading it from the disk.

Some commits consists in modifying edit_todo_list() (initially used by
--edit-todo) to handle the initial edition of the todo list, to increase
code sharing.

This is based on 8858448bb4 ("Ninth batch for 2.20", 2018-11-06) to
avoid conflicts with 'js/rebase-i-break'.

Changes since v2:

 - Clarifying some commit messages

 - Reducing the number of parameters in todo_list_write_to_file()

 - sequencer_add_exec_commands() now requests a string list instead of a
   string.

 - Replacing calls to memcpy() by shallow copies

 - Applying array.cocci.patch

Alban Gruin (16):
  sequencer: changes in parse_insn_buffer()
  sequencer: make the todo_list structure public
  sequencer: refactor transform_todos() to work on a todo_list
  sequencer: introduce todo_list_write_to_file()
  sequencer: refactor check_todo_list() to work on a todo_list
  sequencer: refactor sequencer_add_exec_commands() to work on a
    todo_list
  sequencer: refactor rearrange_squash() to work on a todo_list
  sequencer: make sequencer_make_script() write its script to a strbuf
  sequencer: change complete_action() to use the refactored functions
  sequencer: refactor skip_unnecessary_picks() to work on a todo_list
  rebase-interactive: use todo_list_write_to_file() in edit_todo_list()
  rebase-interactive: append_todo_help() changes
  rebase-interactive: rewrite edit_todo_list() to handle the initial
    edit
  sequencer: use edit_todo_list() in complete_action()
  sequencer: fix a call to error() in transform_todo_file()
  rebase--interactive: move transform_todo_file() to
    rebase--interactive.c

 builtin/rebase--interactive.c |  81 +++--
 rebase-interactive.c          | 142 ++++++--
 rebase-interactive.h          |   8 +-
 sequencer.c                   | 615 +++++++++++++---------------------
 sequencer.h                   |  75 ++++-
 5 files changed, 481 insertions(+), 440 deletions(-)

Range-diff against v2:
 1:  55fa1fff03 =  1:  9ae965b73e sequencer: changes in parse_insn_buffer()
 2:  192fb771ed <  -:  ---------- sequencer: make the todo_list structure public
 -:  ---------- >  2:  9c15cdede4 sequencer: make the todo_list structure public
 3:  e2f821ffbe =  3:  a5c01d5a95 sequencer: refactor transform_todos() to work on a todo_list
 4:  0001e8dbde <  -:  ---------- sequencer: introduce todo_list_write_to_file()
 -:  ---------- >  4:  f2781fe4c3 sequencer: introduce todo_list_write_to_file()
 5:  aa9554d81d =  5:  337e0dce57 sequencer: refactor check_todo_list() to work on a todo_list
 6:  8bd793caf5 <  -:  ---------- sequencer: refactor sequencer_add_exec_commands() to work on a todo_list
 7:  e984946cef <  -:  ---------- sequencer: refactor rearrange_squash() to work on a todo_list
 8:  cf05254acf <  -:  ---------- sequencer: make sequencer_make_script() write its script to a strbuf
 9:  ac79151792 <  -:  ---------- sequencer: change complete_action() to use the refactored functions
10:  e227e38b24 <  -:  ---------- sequencer: refactor skip_unnecessary_picks() to work on a todo_list
11:  5bfd9d3460 <  -:  ---------- rebase-interactive: use todo_list_write_to_file() in edit_todo_list()
12:  f4d7578a77 <  -:  ---------- rebase-interactive: append_todo_help() changes
13:  11c43f1dfe <  -:  ---------- rebase-interactive: rewrite edit_todo_list() to handle the initial edit
14:  e9a6396c26 <  -:  ---------- sequencer: use edit_todo_list() in complete_action()
 -:  ---------- >  6:  2c75eed153 sequencer: refactor sequencer_add_exec_commands() to work on a todo_list
 -:  ---------- >  7:  90e01bc713 sequencer: refactor rearrange_squash() to work on a todo_list
 -:  ---------- >  8:  850261fbf7 sequencer: make sequencer_make_script() write its script to a strbuf
 -:  ---------- >  9:  7bcfe98241 sequencer: change complete_action() to use the refactored functions
 -:  ---------- > 10:  50cdea7ef7 sequencer: refactor skip_unnecessary_picks() to work on a todo_list
 -:  ---------- > 11:  6d4fcf96e0 rebase-interactive: use todo_list_write_to_file() in edit_todo_list()
 -:  ---------- > 12:  3bea4eb9ba rebase-interactive: append_todo_help() changes
 -:  ---------- > 13:  bfe8f568ee rebase-interactive: rewrite edit_todo_list() to handle the initial edit
 -:  ---------- > 14:  0d6499b7c8 sequencer: use edit_todo_list() in complete_action()
15:  a36d094610 = 15:  21d3d1abd7 sequencer: fix a call to error() in transform_todo_file()
16:  344e8ceeed <  -:  ---------- rebase--interactive: move transform_todo_file() to rebase--interactive.c
 -:  ---------- > 16:  22fd27fa2f rebase--interactive: move transform_todo_file() to rebase--interactive.c
-- 
2.19.1.872.ga867da739e

