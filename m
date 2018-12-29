Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 875121F405
	for <e@80x24.org>; Sat, 29 Dec 2018 16:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbeL2QFC (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Dec 2018 11:05:02 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:44652 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbeL2QFC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Dec 2018 11:05:02 -0500
Received: by mail-ed1-f44.google.com with SMTP id y56so19630388edd.11
        for <git@vger.kernel.org>; Sat, 29 Dec 2018 08:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=maqRbcuP2xbfrIeAC/0zJeZ9/gDl0VsDVSpXA325wcE=;
        b=bFQVm/upaHzAzv4THJuT7zfN/i/z8prwH0e2o7pk0zzVTg0saJ5Oq5YLNLQjfg2IuB
         ftVGNgNiGg9eL68iVYxium8zEhyiWRpIxTGhniMTxzs3VX165Ijn+cMLicwupfXcy3qH
         PqI9k2dhCZT1AVG8TNaep8R9dOjbjCuW68BHTLqlycgBm+Rf80hznJRX02CaWidvty8m
         /RRkMtzymR+bxhgAR4c3H8iI51zV/9sQ3157rkakqLLBAlOyAvbHoRQdL1yNq+JeyGWl
         kQoRsIbIByzDhScA5KyjCo0sEfRzskkcZRVA4Rac/Wg1nc2A3qQtzq/AZdQdV/xA2iYO
         7tyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=maqRbcuP2xbfrIeAC/0zJeZ9/gDl0VsDVSpXA325wcE=;
        b=P3t7fRy3A7+YYsDY4N6RfgHM+8lro75ASTSycgd/il3jT5p1qlHZVZ+MEL7Dv7p/7p
         XeuIVYOMHtJlS97Z1BVbPtl60hI6y78njX2xVviYN3KM/qrOIlH8qZfzRuByJQcMh4gv
         XgRALXLb1m7bxSCgIMB0YmgLSxTeOAynfZ6LjgnnUPfMUwlDubjKfGskVLqRoab9mpJU
         LmtX0liQvIR6XzpdE/CvNPFfhm1D8FdtwG3bRspFZ7pKfDsZmRiTi0cc9v4H/CosbNBu
         lYZiyhilWvdJGeUrJbcqU3aYBfycJGAFLuuJXy6f4sDsKf0NqegtAkeFbKJxm3ajNsZy
         wKgA==
X-Gm-Message-State: AA+aEWbA3J4v1dfdwaRBmGKKYM1ejOuyFQxA1xKdUypjXn4IN9YZE5Kn
        ER4DuGrAfgF9zgMKrmvDNl41EGQm
X-Google-Smtp-Source: AFSGD/WzIWBvqnb2CEBqy0psHsOsyJ6f0JpG7KI1zw0hKWCnJk+mtZ7E7IRm5o+gjHEN55hdgH0Kww==
X-Received: by 2002:a17:906:e5a:: with SMTP id q26-v6mr21420831eji.168.1546099499064;
        Sat, 29 Dec 2018 08:04:59 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-184-107.w86-199.abo.wanadoo.fr. [86.199.39.107])
        by smtp.googlemail.com with ESMTPSA id b49sm15108663edb.73.2018.12.29.08.04.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 08:04:58 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v4 00/16] sequencer: refactor functions working on a todo_list
Date:   Sat, 29 Dec 2018 17:03:57 +0100
Message-Id: <20181229160413.19333-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181109080805.6350-1-alban.gruin@gmail.com>
References: <20181109080805.6350-1-alban.gruin@gmail.com>
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

This is based on nd/the-index (36e7ed69de, "rebase-interactive.c: remove
the_repository references"), as it introduced a lot of conflicts.  The
result does not conflict with pu (e31bc98f4b, "Merge branch
'md/list-objects-filter-by-depth' into pu").

Changes since v3:

 - Replacing the 'arg' field from todo_item by 'arg_offset' to avoid
   dealing with pointers on the todo list buffer in
   todo_list_add_exec_commands().  This has led to some additionnal
   changes.

 - Rewording some commits.

 - Dropping the commit "sequencer: fix a call to error() in
   transform_todo_file()".  The call to error() after reading the todo
   file is replaced by error_errno() in "sequencer: refactor
   transform_todos() to work on a todo_list".  The same change has been
   applied to sequencer_add_exec_commands() in "sequencer: refactor
   sequencer_add_exec_commands() to work on a todo_list".

 - transform_todo_file(), sequencer_add_exec_commands() and
   rearrange_squash_in_todo_file() now print an error if they fail to
   write to the todo file.

 - A lot of changes were introduced by the conflict resolution with
   nd/the-index.

Alban Gruin (16):
  sequencer: changes in parse_insn_buffer()
  sequencer: make the todo_list structure public
  sequencer: remove the 'arg' field from todo_item
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
  rebase--interactive: move transform_todo_file() to
    rebase--interactive.c

 builtin/rebase--interactive.c |  90 +++--
 rebase-interactive.c          | 143 +++++--
 rebase-interactive.h          |   8 +-
 sequencer.c                   | 677 +++++++++++++---------------------
 sequencer.h                   |  82 +++-
 5 files changed, 525 insertions(+), 475 deletions(-)

-- 
2.20.1

