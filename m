Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38B971F453
	for <e@80x24.org>; Sat, 27 Oct 2018 21:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbeJ1GML (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 02:12:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33510 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbeJ1GML (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Oct 2018 02:12:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id u1-v6so4687555wrn.0
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 14:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2OSTyo3jxCKSGdxMQvLGpojCTMyCyT2gSVnLrrOe5XM=;
        b=PYKxu2IfypO922JXT+1Kgv7T7zh/BOqAY0IHkb8F+0Tf5PAIFXEu2okm1aQS8IQZHw
         fuYazn71dl4oaxx1jpmQIJ5ODC0TKwb+vJh11h5j6zxRKFtD5s6fSSrRa6O+nMQhPpoH
         k0GJUS+Slswhz1cHzjCpPeNzPvbFIDWGqdm2LfunrP6SqpT9UkfGUucU62O3NO2vOpRj
         YGhqy9dGIBe3OZw9F/abXMilyrfVMDLyM9Ad6NABV2kRlToGe32n5yXNURhICSzd0e4g
         FJRjFL1UXKmUGP1SDlc4DUSTHV+MoVlKVuG05dF+tZ9rhk37b+CzyoFi8W81kHy/xu+h
         UPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2OSTyo3jxCKSGdxMQvLGpojCTMyCyT2gSVnLrrOe5XM=;
        b=JSNeKde7eZlyshdjom8aB/UrUq0KY+DpYk+Ev2wrcYVhblcpUP9lONi0yuBsc/DCfL
         RChDX2wOwAkBDPgDf4mQOi/29RpaC6GlGSXOd0SQhO76kyLC1bA6Z0d+PglRbAZanaxz
         RIpswAH31QQxle7TOR2UzrVJj/OM+83nItpeVRZldhXt361vpho04/4OrmETPiXH7a1F
         EkvnoGtAYlAOfW91qWukIUDnglF8HcJl4Nga1nKRKCAkLCD9QzfTwX8DyJ2rtYEZx2Y1
         5vbY53eDVtZ+rnztobp595hfV7lcckK6XUmB7LUa0msolmJEfwIi5LsU4ZMSpAEpXPYD
         ZHnw==
X-Gm-Message-State: AGRZ1gJ+c4vtkKb53Mg9AWfax2IWHDWJoiI2S1omVf3ioy7No8YEqQQS
        rOFMJBP/ONDR08VEGLXEgPabKO/7
X-Google-Smtp-Source: AJdET5c8wWuQkX99267P7UxQvAFIwx06z97DL3g1nAmzendmNFhYTp5M33iF+cP5rQm56ju08psnRQ==
X-Received: by 2002:a5d:6b0f:: with SMTP id v15-v6mr9228478wrw.53.1540675790638;
        Sat, 27 Oct 2018 14:29:50 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-19-179.w86-222.abo.wanadoo.fr. [86.222.18.179])
        by smtp.googlemail.com with ESMTPSA id t198-v6sm9842514wmd.9.2018.10.27.14.29.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 14:29:49 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 00/16] sequencer: refactor functions working on a todo_list
Date:   Sat, 27 Oct 2018 23:29:14 +0200
Message-Id: <20181027212930.9303-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181007195418.25752-1-alban.gruin@gmail.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
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

It is based onto ag/rebase-i-in-c (34b4731, "rebase -i: move
rebase--helper modes to rebase--interactive").

Changes since v1:

 - When a line is invalid, parse_insn_buffer() sets the type of the
   corresponding command to a garbage value instead of `noop', and its
   argument is defined properly.

 - todo_list_add_exec_commands(), todo_list_rearrange_squash(),
   skip_unnecessary_picks() don’t reparse the todo list after processing
   them.  Instead, they recreate a new item list.

 - Due to the previous change, a todo list buffer can’t directly be
   written to the disk.  A new function, todo_list_write_to_disk(), is
   introduced to take care of this task.

 - rewrite_file() has been deleted.

 - A call to strbuf_addf(&buf, "\n"); has been replaced by strbuf_addch(…).

 - complete_action() and todo_list_check() expect that their input todo list
   have already been parsed.

 - complete_action() no longer writes "noop\n" to the todo list buffer
   if it is empty.  Instead, it appends a `noop' command to the item
   list.

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

 builtin/rebase--interactive.c |  68 +++-
 rebase-interactive.c          | 142 ++++++--
 rebase-interactive.h          |   8 +-
 sequencer.c                   | 589 +++++++++++++---------------------
 sequencer.h                   |  68 +++-
 5 files changed, 455 insertions(+), 420 deletions(-)

-- 
2.19.1

