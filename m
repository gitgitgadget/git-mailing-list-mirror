Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFE8C433DB
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 16:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6FD720769
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 16:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbhADQWv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 11:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbhADQWv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 11:22:51 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3F5C061796
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 08:22:10 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id c7so27933695edv.6
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 08:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qcv5ub9mDZRHwW6MDi/twROyqqC1wMp90nCEsrovRcE=;
        b=bbl0StS76Q7Q/vv6hh4iR+aRB/sgxjmX12xmmXb4ZDsSufENfZ3jjc2vgazHeuuJXV
         eAGljLy/45YLRUid3qdKijkbK9r8UgGeSJnOF+BPwSsAsNd6yLXSt9F8cle/YcFcjuQn
         zg3X47e/lR0FdKoCuL3FxQaFg53S61W7jPZnztID28xaufOnPTb6DBmMlmZ9dEMbslIG
         VGMZ6VLKSYUFsQNe+4J8yKEWjM1mfITWjZp9+AGNpqBmXgKnVkP63rXvVzLpwBZBKE0d
         yGGA920CVI6E3O8l2rC4zlWrD3YZv96mIbizbcrupUETmxJE7QprI2nJTjkddlEgkDlF
         qfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qcv5ub9mDZRHwW6MDi/twROyqqC1wMp90nCEsrovRcE=;
        b=UbOOBZXyIH2uCkmET3IyJ9JZtPTT9QNz1ZGZ2IRnf2yTS959imrzf6UMaJ7PimrfKQ
         UYh+1iNRxiQnnWdRmkSNHWvTUt2PnDYGi02d5dAw7MdO2W6ptSyi5nJ+20jmxQid75Ks
         hYZV2n4eLjNMNeIEf7MkO57xHY24otSNxq4EGzC33w/fAM9JxhH/Wmvfxy8xgfR1OhDB
         nY2Kzzp46w3Tl9dTC55v6X7Le7LQ1tHfGzEY8yZWCMshwKx+LBnzeieAjRJBR96Ciu6l
         Y7ScZye6LlfX/tbVpeJIke23V+cEcK1zCTWwO4r0sPVPHPNhp/Sf3eOliDGizrSxrS/5
         uVKw==
X-Gm-Message-State: AOAM531/Nmu0QXFFG1fBmgtoAt+rrMlxpcbcQG7aXIDPLu78HCeTmkyM
        k52kyvMnjEaHnGXP2q+lwhYsHAPExhg=
X-Google-Smtp-Source: ABdhPJznJjfoCXfa7SiDhOu+0yGiyryyeX8eLW4WRtS6ni+arp5r3Fd0pzC0hEoVIv6+Ho3nboJVGQ==
X-Received: by 2002:a50:9dc9:: with SMTP id l9mr71125381edk.377.1609777328740;
        Mon, 04 Jan 2021 08:22:08 -0800 (PST)
Received: from localhost.localdomain ([79.140.115.191])
        by smtp.gmail.com with ESMTPSA id bn21sm23931677ejb.47.2021.01.04.08.22.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jan 2021 08:22:08 -0800 (PST)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH 0/7] teach `worktree list` verbose mode and prunable annotations
Date:   Mon,  4 Jan 2021 17:21:21 +0100
Message-Id: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.30.0.391.g469bf2a980
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In c57b3367be (worktree: teach `list` to annotate locked worktree,
2020-10-11) we taught `git worktree list` to annotate working tree that
is locked by appending "locked" text in order to signalize to the user
that a working tree is locked.  During the review, there was some
discussion about additional annotations and information that `list`
command could provide to the user that has long been envisioned and
mentioned in [2], [3] and [4].

This patch series address some of these changes by teaching
`worktree list` to show "prunable" annotation, adding verbose mode and
extending the --porcelain format with prunable and locked annotation as
follow up from [1]. Additionally, it address one shortcoming for porcelain
format to escape any newline characters (LF and CRLF) for the lock reason
to prevent breaking format mentioned in [4] and [1] during the review
cycle.

I have tried to organise in a way the series is easy to review, the
patches are organised in seven patches.

The first moves the should_prune_worktree() machinery to the top-level
worktree.c exposing the function as general API, that will be reference
by should_prune_worktree() wrapper implemented on the second patch. The
original idea was to not only move should_prune_worktree() but also
refactor to accept "struct worktree" and load the information directly,
which can simplify the `prune` command by reusing get_worktrees().
However this seems to also require refactoring get_worktrees() itself
to return "non-valid" working trees that can/should be pruned. This is
also mentioned in [5]. Having the wrapper function makes it easier to add
the prunable annotation without touching the get_worktrees() and the
other worktree sub commands.  The refactoring can be addressed in a
future patch, if this turns out to be good idea.  One possible approach
is to teach get_worktrees() to take additional flags that will tell
whether to return only valid or all worktrees in GIT_DIR/worktrees/
directory and address its own possible shortcoming, if any.

The third patch changes worktree_lock_reason() to be more gentle for the
main working tree to simply returning NULL instead of aborting the
program via assert() macro. This allow us to simplify the code that
checks if the working tree is locked for default and porcelain format.
This changes is also mentioned in [6].

The forth patch is the one that teaches `list` command to show prunable
annotation, for both default and porcelain format, and adds the verbose
option. These changes are also done for the "locked" annotation that was
not done on in [1]. Additionally, `list` learns to fail when both
--verbose and --porcelain format as used together.

The fifth patch adds worktree_escape_reason() that accepts a (char *)
text and returned the text with any LF or CRLF escaped. The caller is
responsible to freeing the escaped text. This is used by the locked
annotation in porcelain format. Currently, this is defined within
builtin/worktree.c as I was not sure whether libfying the function as
part of this series is a good idea. At this time it seems more sensible
to leave the code internally and libfying later once we are confident
about the implementation and whether it can be used in other part of the
code base but I'm open for suggestion.

The sixth and seventh patches adds tests and update the git-worktree.txt
documentation accordingly.

[1] https://lore.kernel.org/git/20200928154953.30396-1-rafaeloliveira.cs@gmail.com/
[2] https://lore.kernel.org/git/CAPig+cQF6V8HNdMX5AZbmz3_w2WhSfA4SFfNhQqxXBqPXTZL+w@mail.gmail.com/
[3] https://lore.kernel.org/git/CAPig+cSGXqJuaZPhUhOVX5X=LMrjVfv8ye_6ncMUbyKox1i7QA@mail.gmail.com/
[4] https://lore.kernel.org/git/CAPig+cTitWCs5vB=0iXuUyEY22c0gvjXvY1ZtTT90s74ydhE=A@mail.gmail.com/
[5] https://lore.kernel.org/git/CACsJy8ChM99n6skQCv-GmFiod19mnwwH4j-6R+cfZSiVFAxjgA@mail.gmail.com/
[6] https://lore.kernel.org/git/xmqq8sctlgzx.fsf@gitster.c.googlers.com/

Series is built on top of 71ca53e8125e36efbda17293c50027d31681a41f, currently
poiting to master and v2.30.0 tag.

Rafael Silva (7):
  worktree: move should_prune_worktree() to worktree.c
  worktree: implement worktree_prune_reason() wrapper
  worktree: teach worktree_lock_reason() to gently handle main worktree
  worktree: teach `list` prunable annotation and verbose
  worktree: `list` escape lock reason in --porcelain
  worktree: add tests for `list` verbose and annotations
  worktree: document `list` verbose and prunable annotations

 Documentation/git-worktree.txt |  59 ++++++++++++++-
 builtin/worktree.c             | 130 ++++++++++++++-------------------
 t/t2402-worktree-list.sh       |  94 +++++++++++++++++++++++-
 worktree.c                     |  96 +++++++++++++++++++++++-
 worktree.h                     |  17 +++++
 5 files changed, 313 insertions(+), 83 deletions(-)

-- 
2.30.0.391.g469bf2a980

