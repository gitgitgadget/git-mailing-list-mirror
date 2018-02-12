Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 094C81F404
	for <e@80x24.org>; Mon, 12 Feb 2018 03:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932563AbeBLDRF (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Feb 2018 22:17:05 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:37102 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932492AbeBLDRE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Feb 2018 22:17:04 -0500
Received: by mail-io0-f196.google.com with SMTP id f89so15796235ioj.4
        for <git@vger.kernel.org>; Sun, 11 Feb 2018 19:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cy8YgVmh6QJ5icnqPaZ/91uHPItQhJtUEDbBrsiPry8=;
        b=MIIGEDbB/zkNthAPKFMC36DbALymQ7+QbhHjDjYHPcjgOb0fXJ48jOg5EP6ea7HCPe
         NQwFHrpQQt7I4siDyCFr0g1JI919WZA+1p2qmyEMmZkcMbIdGfBfcmuy4GSAG/klaCg/
         Pmzbcu1ZoWN3mohgLS9tpI451I7cPtAh0sxqjHJVESm1btaisQCl+EWYTwg74Kl+YfoY
         7khDqs380TMPRsdtSgJgFVNwLP+r+L0yy1/78JKFsdo+iWC+jzYQYGkYrI+WpRkxZHJ0
         82O4C5553n9RnZGWfSYT932EIOjt2K48ZQ+Lw5Uhhmz1JZs9EbrxUXavmmqdpJ4SswVI
         /0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Cy8YgVmh6QJ5icnqPaZ/91uHPItQhJtUEDbBrsiPry8=;
        b=SnkqYDhQ08Otv/jt3R5R0R2aZMssmXevw4wUqJFlSwl0ksvvM07U+hBUjMz1oSRbUa
         15CRZR0/m+OAYQc4v0k8GKKUbHMOA48yZ77LXKjPcGiUwW0mk/kP0vI3mxWEANEXH9oX
         J8ENpUVJKIlhrrHV6mae4MqUiw/D6kDPuR7PBYrNvuAwUabilvPbOXRYJeNzun2isaU/
         EkSZexvPFgTTX3bbw+xSsZMs+6OT9XErOHAb+vRm4miVmjS7qU+glGmhdjPnq7sjuY21
         Wr2VsLewfIydlmFyYbWp9s+A8Ye7qmuc12MCwzQtj13kMHXTrsF1oO3DRaz0Y9BPjdIH
         Zo3A==
X-Gm-Message-State: APf1xPC0pLM8iGIEchTgrLRBDEQuqukvNqjf48I/W8WzAAVLPAgARjuq
        /3o33kfiepW4tClFXHiAjlFiAQ==
X-Google-Smtp-Source: AH8x224M2OpF/Ue7q5i5Z10E67zNLFt5sQ+/5Ur77X8He2ar+C0ydT0tnsm9MOl/RIX8Bc/nbs0wNg==
X-Received: by 10.107.166.140 with SMTP id p134mr6026180ioe.272.1518405423244;
        Sun, 11 Feb 2018 19:17:03 -0800 (PST)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id 15sm1754139itx.18.2018.02.11.19.17.01
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 11 Feb 2018 19:17:02 -0800 (PST)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        matthew.k.gumbel@intel.com, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/2] worktree: change to new worktree dir before running hook(s)
Date:   Sun, 11 Feb 2018 22:15:24 -0500
Message-Id: <20180212031526.40039-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132
In-Reply-To: <20180210010132.33629-1-lars.schneider@autodesk.com>
References: <20180210010132.33629-1-lars.schneider@autodesk.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series replaces "worktree: set worktree environment in
post-checkout hook"[1] from Lars, which is a proposed bug fix for
ade546be47 (worktree: invoke post-checkout hook, 2017-12-07).

The problem that patch addresses is that "git worktree add" does not
provide proper context to the invoked 'post-checkout' hook, so the hook
doesn't know where the newly-created worktree is. Lars's approach was to
set GIT_WORK_TREE to point at the new worktree directory, however, doing
so has a few drawbacks:

1. GIT_WORK_TREE is normally assigned in conjunction with GIT_DIR; it is
   unusual and possibly problematic to set one but not the other.

2. Assigning GIT_WORK_TREE unconditionally may lead to unforeseen
   interactions and problems with end-user scripts and aliases or even
   within Git itself. It seems better to avoid unconditional assignment
   rather than risk problems such as those described and worked around
   by 86d26f240f (setup.c: re-fix d95138e (setup: set env $GIT_WORK_TREE
   when .., 2015-12-20)

3. Assigning GIT_WORK_TREE is too specialized a solution; it "fixes"
   only Git commands run by the hook, but does nothing for other
   commands ('mv', 'cp', etc.) that the hook might invoke.

The real problem with ade546be47 is that it neglects to change to the
directory of the newly-created worktree before running the hook, thus
the hook incorrectly runs in the directory in which "git worktree add"
was invoked. Rather than messing with GIT_WORK_TREE, this replacement
patch series fixes the problem by ensuring that the directory is changed
before the hook is invoked.

[1]: https://public-inbox.org/git/20180210010132.33629-1-lars.schneider@autodesk.com/

Eric Sunshine (2):
  run-command: teach 'run_hook' about alternate worktrees
  worktree: add: change to new worktree directory before running hook

 builtin/worktree.c      | 11 ++++++++---
 run-command.c           | 23 +++++++++++++++++++++--
 run-command.h           |  4 ++++
 t/t2025-worktree-add.sh | 25 ++++++++++++++++++++++---
 4 files changed, 55 insertions(+), 8 deletions(-)

-- 
2.16.1.291.g4437f3f132
