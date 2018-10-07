Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4A491F97E
	for <e@80x24.org>; Sun,  7 Oct 2018 20:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbeJHDIc (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 23:08:32 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:54075 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbeJHDIc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 23:08:32 -0400
Received: by mail-wm1-f53.google.com with SMTP id y11-v6so3213171wma.3
        for <git@vger.kernel.org>; Sun, 07 Oct 2018 13:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JsxlhhV7jvlbBIr7/mQMtlm7O6OjitvT4oSNJULxj58=;
        b=n74R/qCVzdlSEwvC8fbTt+q4vzb5qr+O2QlJJSIjuA0polwxf910JjuslaehL70Ika
         mFE13Fz+Eyco9DymMF50L1duQitu64NbfY4eubJ803ae3C1rDTpSVhzJDv342SZoCp+t
         U/9TZGoA3Xzz+YfVLu3tXCAvCZzX673J7YoR2myBxQa3fP+R1MeIGUHxqpzUXxQFKdCe
         3w1zXJqcqUGj226bIzqKeXr9vYpzfhJXgrBoevnQiDYhFOYE0dSiLyFgeJxh233bItXw
         DhVoV081DMFC9nYTfnzccXXvNp1hCZLGy6cQHp2oVlrdgpO3Sd2oQWlN9glqQmP3EZM4
         IjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JsxlhhV7jvlbBIr7/mQMtlm7O6OjitvT4oSNJULxj58=;
        b=buSGxXgiDO18ue1DAygC4bLLOk0cA+cCBAxen8m6gQg3J2vSQbv8aNlPqWirCBv9M+
         pany3r0CoZNB9aYCJQTpxxfgL2Sp4AUKVhQc1mxpdmP+Br7Inz8H4LyqJidIfoOkn6Df
         /Qoy0rFvVL+wlgl9YJ2bkEOcuYtc6vCjV/GvfBawoXchkLj9p5qSgp8pKfRibUrkK2Qd
         EizJYj5C6cs+qTBD+lKZRO0CinZBL34qqNRibvR48Grare4Fb9HTOa3ggOWXrILUe2zh
         gDQzlxC3ZyjxFg1/lz2UWLiC1xtul1di6srivCNxw+U9wo64XcOOalxJ7GWiTq5cLX7r
         dVvw==
X-Gm-Message-State: ABuFfoiizKRljQzzyea/Iiy++MqyireE1IvtE2lvM4sDevYd5R6Ckn/W
        PILoEhpoYLiZ3JTltBxSIODD7nVW
X-Google-Smtp-Source: ACcGV60Sy6ZDSE5JAw85jwWl8d7Jp/hkmFwR8RTZF6v+2l88pk3kb1lvrlwmRatouZhFw5yExtjZIA==
X-Received: by 2002:a1c:a851:: with SMTP id r78-v6mr13168775wme.97.1538942407151;
        Sun, 07 Oct 2018 13:00:07 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-60-162.w92-136.abo.wanadoo.fr. [92.136.157.162])
        by smtp.googlemail.com with ESMTPSA id u76-v6sm17082538wmd.10.2018.10.07.13.00.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 13:00:06 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH 00/15] sequencer: refactor functions working on a todo_list
Date:   Sun,  7 Oct 2018 21:54:03 +0200
Message-Id: <20181007195418.25752-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.1
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

Alban Gruin (15):
  sequencer: clear the number of items of a todo_list before parsing
  sequencer: make the todo_list structure public
  sequencer: refactor check_todo_list() to work on a todo_list
  sequencer: refactor sequencer_add_exec_commands() to work on a
    todo_list
  sequencer: refactor rearrange_squash() to work on a todo_list
  sequencer: refactor transform_todos() to work on a todo_list
  sequencer: make sequencer_make_script() write its script to a strbuf
  sequencer: change complete_action() to use the refactored functions
  sequencer: refactor skip_unnecessary_picks() to work on a todo_list
  rebase-interactive: use todo_list_transform() in edit_todo_list()
  rebase-interactive: append_todo_help() changes
  rebase-interactive: rewrite edit_todo_list() to handle the initial
    edit
  sequencer: use edit_todo_list() in complete_action()
  sequencer: fix a call to error() in transform_todo_file()
  rebase--interactive: move transform_todo_file() to
    rebase--interactive.c

 builtin/rebase--interactive.c |  65 +++--
 rebase-interactive.c          | 161 ++++++++++--
 rebase-interactive.h          |   8 +-
 sequencer.c                   | 479 ++++++++++++----------------------
 sequencer.h                   |  66 ++++-
 5 files changed, 406 insertions(+), 373 deletions(-)

-- 
2.19.1

