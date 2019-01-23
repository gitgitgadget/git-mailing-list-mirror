Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 546D51F453
	for <e@80x24.org>; Wed, 23 Jan 2019 20:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfAWU7S (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 15:59:18 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:44507 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfAWU7S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 15:59:18 -0500
Received: by mail-wr1-f47.google.com with SMTP id z5so4098144wrt.11
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 12:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gN2a/op8C24rRzUrMpkAs0KkpTo/gejSlYzlWkoDdFs=;
        b=ibM+tJlVV+/DFPBxg5sOeavHaIHAfV5VCZOPpKB/oCLCYZYvAFFp7TyApYfWjqnyiW
         RCDrcuruHk5btASE5qaEkCJEs26GpauknWITet8OpoFKyFXmYe7HLNJafP4ozjMHZmwf
         Bd6NrY9Oo++bdwPfYfUyORlpqtLo6/0Kry9EGCnRwR8sQnL9nPeUDg09ayXGgl+pJCHd
         r8Db0e83DQ7+3xxbs0M/O0g3sf/BaH6wW8QnUatEmTXHZn10zg5sG9z1FQ5DqWDm7/mu
         tfex0GEberS1iVBhUu13LylrnZWgSVPc3yWWsB++FZDqtQ4q1wL4j1JpMRO543pzyuHe
         BlVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gN2a/op8C24rRzUrMpkAs0KkpTo/gejSlYzlWkoDdFs=;
        b=XNHhDF2alzXHgX7SJ0UEoPFEN1Ac0xtCt6anVHZ1zU9jQyO7t4acCLZTz/j6d8ehIj
         2MK7JVCDvp1C5ZHkkPAujuMS9ogyU5qHEK1LfYmTVWW2efQPFi5dOv2TB7x86DNAeX3M
         whkc1wsv0mTWCCdCDb2sVI1KAGq21N1BeamQfteoK0SXU4+WqMEyu4ygE6HiawBKGmY5
         sn6mzbe6EtEbA6/aQ/7XF/6VRxd/UXiJoDmbtKTjk+YeWs/Xup406gU8HEXENbsFR/qg
         ZmT5ZW0t6dOYtxrKzhIuu5rGa3HYz/pgm3nfIT9VA8JNfN4fCN0I3EWv1ftURte1hyoX
         dHpA==
X-Gm-Message-State: AJcUukefmipCTdxeTnJV3fSkEAwIfVJhGT3x/3yajYsSNgbQ88az/Hbb
        aPhLpmHXSwi/I4AGdXxz/SDBycjh
X-Google-Smtp-Source: ALg8bN7ZKMjbj/s/4DPVdV5mlsljDcKml+FGNCqbSRqS1otp0rVGxvW5/Zv8vshew5FHhFIh3IOXVA==
X-Received: by 2002:adf:fa90:: with SMTP id h16mr4597047wrr.326.1548277155007;
        Wed, 23 Jan 2019 12:59:15 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-2-163.w86-222.abo.wanadoo.fr. [86.222.145.163])
        by smtp.googlemail.com with ESMTPSA id h13sm80634127wrp.61.2019.01.23.12.59.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 12:59:14 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v5 00/16] sequencer: refactor functions working on a todo_list
Date:   Wed, 23 Jan 2019 21:58:05 +0100
Message-Id: <20190123205821.27459-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181229160413.19333-1-alban.gruin@gmail.com>
References: <20181229160413.19333-1-alban.gruin@gmail.com>
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
the_repository references").

Changes since v4:

 - Adding todo_item_get_arg() to return the address of the parameter of
   an item to avoid confusion.

 - Squashed <d414e1a2-e5a1-ce15-96b5-cf294c7f3c92@ramsayjones.plus.com>
   and <5440ddf5-0b80-3d00-7daf-133a8611efa8@ramsayjones.plus.com> from
   Ramsay Jones.

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
 rebase-interactive.h          |   9 +-
 sequencer.c                   | 687 ++++++++++++++--------------------
 sequencer.h                   |  81 +++-
 5 files changed, 533 insertions(+), 477 deletions(-)

-- 
2.20.1

