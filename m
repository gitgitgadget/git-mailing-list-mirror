Return-Path: <SRS0=hslh=3A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD70AC282DD
	for <git@archiver.kernel.org>; Sat, 11 Jan 2020 17:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA48820678
	for <git@archiver.kernel.org>; Sat, 11 Jan 2020 17:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oG4eDxB5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbgAKRkL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Jan 2020 12:40:11 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:35566 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730595AbgAKRkL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Jan 2020 12:40:11 -0500
Received: by mail-wr1-f52.google.com with SMTP id g17so4684329wro.2
        for <git@vger.kernel.org>; Sat, 11 Jan 2020 09:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QhjuuoTTUHcamq672g/Ws4Y195q3urwY0BzFIqs9WhE=;
        b=oG4eDxB5a1cImeJrjo3EuQ4E3skhRBgDZZ2rcsh4D+91lx8hn1emHOVGj/tinqUeBJ
         1YpwTsfJ9k9b3G/PtwOSiPqCLps72G6SJHlwRfUow+uz27Z9NNZ0mym9F98qiHUziqk8
         z8F1GFzL9wW3nz6tFdPuQypihh+ce7EfnaeSFJsl2uaNqUA6Txv/dUO+bQ1Fn4xLoyyY
         eWv0mQ3paa/19SWfa4zaYc6P3tOivqy+8C+0vXXpVS9sQdatNPI6ipF85VF6fEB7LMLb
         wqEvVyDmIYUKPswRkKIduHBEKdXM5Rj1sGZ0kQmiTcaivwIe1hb2+2HVDtzLI/d+OLp0
         ZF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QhjuuoTTUHcamq672g/Ws4Y195q3urwY0BzFIqs9WhE=;
        b=F36TGxc5eB49JHJ4NDA1PYNM1ZqxD3dKQ0AuGtdza4MDeWo9cU6LHHuqkqW0EzGGOE
         Jz7ncj5gBNx64EHD9ozowgMKHhPIh6vCY5QrNSSdrAWiS6imB8OjTlhNelmFJZFG+ElU
         DwaQZWCy/mKBKQD0LRNsWBriNHj04y7PeHWGxqEffQfzt+6HX+51ZjkXUlTr5bx4ekq3
         0ubbwOaNPZy7f0fJEIlw0vVrStU3w9nU47+G1XFaYh35GmRAy2SFlD9demE/sSfttsy8
         Xf374FZwI8dwblB0zha9vUCyPMM32/sDvN/+KoWZGnQ3UFlUY3wuo291KulbEUmoY+bh
         CTOA==
X-Gm-Message-State: APjAAAWydLxlTEUI/jcWPDcCp2vqfbfDM61Ke/NGdNW8V7IahrhkacxA
        zLSp9wyqEOUHtbecNPd3l/4D3sAO
X-Google-Smtp-Source: APXvYqxhr8ndx0SLaHN5JyUSIVm73LvSiH1BmXr0kZi3ZRrbdx8CpX4j+HrCalp4y2VFZCHzAa+zlQ==
X-Received: by 2002:a5d:608a:: with SMTP id w10mr9184648wrt.136.1578764408537;
        Sat, 11 Jan 2020 09:40:08 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-29-116.w86-222.abo.wanadoo.fr. [86.222.28.116])
        by smtp.googlemail.com with ESMTPSA id m3sm7034543wrs.53.2020.01.11.09.40.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Jan 2020 09:40:08 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v4 0/2] rebase -i: extend rebase.missingCommitsCheck
Date:   Sat, 11 Jan 2020 18:39:15 +0100
Message-Id: <20200111173917.15690-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191202234759.26201-1-alban.gruin@gmail.com>
References: <20191202234759.26201-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To prevent mistakes when editing a branch, rebase features a knob,
rebase.missingCommitsCheck, to warn the user if a commit was dropped.
Unfortunately, this check is only effective for the initial edit, which
means that if you edit the todo list at a later point of the rebase and
drop a commit, no warnings or errors would be issued.

This adds the ability to check if commits were dropped when editing the
todo list with `--edit-todo', and when resuming a rebase.

The first patch moves moves check_todo_list_from_file() and
`edit_todo_list_advice' from sequencer.c to rebase-interactive.c so the
latter can be used by edit_todo_list() and todo_list_check().  The
second patch adds the check to `--edit-todo' and `--continue' and tests.

This is based on 393adf7a6f ("sequencer: directly call pick_commits()
from complete_action()", 2019-11-24).

The tip of this series is tagged as "edit-todo-drop-v4" at
https://github.com/agrn/git.

Changes since v3:

 - Set the fake editor in a subshell in the tests to avoid conflicts with
   pw/post-commit-from-sequencer.

 - Added the `dropped' file to indicate that the todo list is incorrect
   (ie. no invalid commands or dropped commits.)

 - The todo list is copied only if it is correct.

 - sequencer_continue() checks the todo list for dropped commits only
   when `dropped' exists.

 - Added a new test to check that `rebase --continue' does not warn for
   dropped commits after solving a conflict.  This was provided by
   Phillip Wood.

 - check_todo_list_from_file() no longer prints `edit_todo_list_advice'
   if there is dropped commits since todo_list_check() do it now.

Alban Gruin (2):
  sequencer: move check_todo_list_from_file() to rebase-interactive.c
  rebase-interactive: warn if commit is dropped with `rebase
    --edit-todo'

 rebase-interactive.c          |  89 ++++++++++++++++++++++++---
 rebase-interactive.h          |   5 ++
 sequencer.c                   |  51 ++++------------
 sequencer.h                   |   2 +-
 t/t3404-rebase-interactive.sh | 109 ++++++++++++++++++++++++++++++++++
 5 files changed, 206 insertions(+), 50 deletions(-)

Diff-intervalle contre v3:
1:  996045a300 = 1:  996045a300 sequencer: move check_todo_list_from_file() to rebase-interactive.c
2:  ba6d27e5b4 < -:  ---------- rebase-interactive: warn if commit is dropped with `rebase --edit-todo'
-:  ---------- > 2:  11b0e1e78c rebase-interactive: warn if commit is dropped with `rebase --edit-todo'
-- 
2.24.1

