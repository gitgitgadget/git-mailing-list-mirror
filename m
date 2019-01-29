Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 274501F453
	for <e@80x24.org>; Tue, 29 Jan 2019 15:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbfA2PDB (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 10:03:01 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:44519 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbfA2PDA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 10:03:00 -0500
Received: by mail-wr1-f49.google.com with SMTP id z5so22393588wrt.11
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 07:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6TOoBAqPHMGgqy2zRC33OhDPtYmqRF+uUmeRhiVvu90=;
        b=sW9JvqS/ShkR/OsY1ORQVzEhW0I2YiCk/r7uzYYRUo7FbgIZ3z8h+2QiVTHs//aWqL
         HDz3sVYohbfLiNcdl5zs5uUtrqiHs2E5yFAI5BVrLN9ByS20xSfIceZVqx/dSU+mjOFK
         k4QifTlSF+bTqZ5YVVoRr7+rGOBuQPqMqQ0NBTm5Gt7iJdTJGrOsxMsLrBwx+koSRJ/E
         bhlmKhl2Yv2zQ3H/PzU+5sZfGpknVz/yiM6NHHWV0ZaEUMexXjDC0QMg71/ZVIhQ8b4Z
         EsEXLwTXVRdSXNPcT3c9inatIQ9AzcFvG9Fiyq0kLTOfw8a2PNm/kku5JVVtqh3tMtcj
         v7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6TOoBAqPHMGgqy2zRC33OhDPtYmqRF+uUmeRhiVvu90=;
        b=QIJCJxrHd0ApLPMhEGAIgeWcPxCBzuJykJEO1KQ23zBYpi1L+azRNGGkYQwf+mh0/C
         HL6eTVu1LiLNaXDOcoiO0bXe1aGyqwh2DfuECsZmOqAM8tLaB++OxPAtItmX4R2qZK2C
         C6MKo3aRpNBEjmbSy4MmcFskjiL8GsNdxn8ew2u1kcetjQEYxZ1GQG8Hh2X01gFAjalW
         1rNQCSTrR37w7kM5ZWYmnwh3vr6Kg9aJm86qbs6YRXe+nMN+a6Gb77n30difGOz1/XHx
         CMY+RVouJcNKwc8+fv31t7bHWRKysLxNVc/Jil4Ok3oH6/Q/99ab/n1Ev4KMiLXxojWW
         jBmA==
X-Gm-Message-State: AJcUukdFvF5Pw1nyZ6IaY44PZdkDyaA6fqb1fxfXE6tajjFA4nB94IG2
        U+yQB8BYDdjfnXfWHSkW7dkTw+Vb
X-Google-Smtp-Source: ALg8bN5l05sGdLX9bNyqOuqwhzDI/UI6T891W7ox5/AL98Gejvg0G1A2lqQf19qMdomnDOtBar03SQ==
X-Received: by 2002:adf:8231:: with SMTP id 46mr22668338wrb.327.1548774178294;
        Tue, 29 Jan 2019 07:02:58 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-47-104.w86-221.abo.wanadoo.fr. [86.221.54.104])
        by smtp.googlemail.com with ESMTPSA id 129sm4420851wmd.18.2019.01.29.07.02.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 07:02:57 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v6 00/16] sequencer: refactor functions working on a todo_list
Date:   Tue, 29 Jan 2019 16:01:43 +0100
Message-Id: <20190129150159.10588-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190123205821.27459-1-alban.gruin@gmail.com>
References: <20190123205821.27459-1-alban.gruin@gmail.com>
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

I am rerolling this because I accidentally added a newline to a place I
shouldn’t in the patch 05/16 of the v5.  There is no change in this
version.

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

