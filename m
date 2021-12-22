Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F38C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 03:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbhLVD7s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 22:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbhLVD7s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 22:59:48 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6A7C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 19:59:47 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v7so1990625wrv.12
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 19:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YTluWbdhN27QUYtC0fkG91MvimXXwiS0Z1LJg/00mfQ=;
        b=m2i26pyoJcc3yGwZMcMabNu6rthu93EOmpPkqgpHoK37aiJidC2cB2UQVWuuc3ubDo
         8kHlavkEaIIcd6K2kiHvLgNZeSdMr7gfSaU2trl0XKP4+DVrXOVeDm2MSVH/m35dBmuh
         N7rN6tGW4speejbgtaRIxdGZhBi0OoPCnkhuiSKgeydzegHSD17tlX7H+pk2Dy295v+K
         5C89Olpr0j1uil8xiTbC/LGYjeGqllCOv+l2VbKPTQ4idHWV1oNn4XhMoYi7nwT6vNA3
         0RgbqxeSPL87oNXDWMMkUpf8xQ2JwVdOF8IRjNeg0r/++OnHGrWIcP+6suFTlC6wCybl
         jBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YTluWbdhN27QUYtC0fkG91MvimXXwiS0Z1LJg/00mfQ=;
        b=kTMz+j6rd9mMNla05yFOpjJlEwJeBTq8lLQwOgv7+SEq9/Ud8gckU/Y4HbIv4COQ//
         xR37TCEqzH+2usSSVkH6BSydoUBcjOx4zanbYHlWvMpWyhyNao9RlObZl0D81gXb2mxM
         q1iqg82PajlvxnfKtPKK0sY0NRrNGs4ObotrYeMYJDTkpnoYsECSQyrjzP8dSik1wQOe
         FRnICyk1zZtNnu+j55poqc2c50HLHdGCjIdwQyQzIqPwjtlT47SMPQBJ49mZFR4ADp6V
         eETbR+57n8vFBWVf2ansZ10yDDMfiaCZxSpNYbY7ENozYSJA0Gt6zFih6F4C7qLItiG4
         8DnA==
X-Gm-Message-State: AOAM530Xs0/1Oud0V9OrlOG2KPXQvuftUQYvVCbJWrR8lcnQV8FR0pDO
        8l1rLoqTboPnk52HV7djyzTeexoecPY3dg==
X-Google-Smtp-Source: ABdhPJzFO4c5ndeahnTuYL7i2lH3OJGoPK8gZ13cNXMBD/Dl/xAKp+YPvt5bHQegF89MiyOzxxToKw==
X-Received: by 2002:a5d:448e:: with SMTP id j14mr749405wrq.42.1640145586256;
        Tue, 21 Dec 2021 19:59:46 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s8sm867300wra.9.2021.12.21.19.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 19:59:45 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 00/17] hook.[ch]: new library to run hooks + simple hook conversion
Date:   Wed, 22 Dec 2021 04:59:26 +0100
Message-Id: <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
References: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A trivial update to v5 to rebase it past conflicts with topics that
recently landed on "master". For v5 see:
https://lore.kernel.org/git/cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com/

Emily Shaffer (14):
  hook: add 'run' subcommand
  gc: use hook library for pre-auto-gc hook
  am: convert {pre,post}-applypatch to use hook.h
  rebase: convert pre-rebase to use hook.h
  am: convert applypatch-msg to use hook.h
  merge: convert post-merge to use hook.h
  hooks: convert non-worktree 'post-checkout' hook to hook library
  hooks: convert worktree 'post-checkout' hook to hook library
  send-email: use 'git hook run' for 'sendemail-validate'
  git-p4: use 'git hook' to run hooks
  commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
  read-cache: convert post-index-change to use hook.h
  receive-pack: convert push-to-checkout hook to hook.h
  run-command: remove old run_hook_{le,ve}() hook API

Ævar Arnfjörð Bjarmason (3):
  hook API: add a run_hooks() wrapper
  hook API: add a run_hooks_l() wrapper
  git hook run: add an --ignore-missing flag

 .gitignore                 |   1 +
 Documentation/git-hook.txt |  45 +++++++++++++
 Documentation/githooks.txt |   4 ++
 Makefile                   |   1 +
 builtin.h                  |   1 +
 builtin/am.c               |   6 +-
 builtin/checkout.c         |   3 +-
 builtin/clone.c            |   3 +-
 builtin/gc.c               |   3 +-
 builtin/hook.c             |  84 +++++++++++++++++++++++
 builtin/merge.c            |   2 +-
 builtin/rebase.c           |   3 +-
 builtin/receive-pack.c     |   7 +-
 builtin/worktree.c         |  26 +++----
 command-list.txt           |   1 +
 commit.c                   |  15 +++--
 git-p4.py                  |  70 ++-----------------
 git-send-email.perl        |  22 +++---
 git.c                      |   1 +
 hook.c                     | 131 ++++++++++++++++++++++++++++++++++++
 hook.h                     |  57 ++++++++++++++++
 read-cache.c               |   3 +-
 reset.c                    |   3 +-
 run-command.c              |  33 ---------
 run-command.h              |  17 -----
 t/t1800-hook.sh            | 134 +++++++++++++++++++++++++++++++++++++
 t/t9001-send-email.sh      |   4 +-
 27 files changed, 522 insertions(+), 158 deletions(-)
 create mode 100644 Documentation/git-hook.txt
 create mode 100644 builtin/hook.c
 create mode 100755 t/t1800-hook.sh

Range-diff against v5:
 1:  4ca52feebb8 =  1:  ba6fd47482e hook: add 'run' subcommand
 2:  6275b97a306 =  2:  cfba5c139e7 hook API: add a run_hooks() wrapper
 3:  b5b3051b2e5 =  3:  a4cca074bcb gc: use hook library for pre-auto-gc hook
 4:  c88eb5d4c25 =  4:  ce57ce1adcb am: convert {pre,post}-applypatch to use hook.h
 5:  1d8f7b7e4c1 =  5:  d6162fbef80 hook API: add a run_hooks_l() wrapper
 6:  d49a1444345 =  6:  4c1a8951fc5 rebase: convert pre-rebase to use hook.h
 7:  191fdad0165 =  7:  d8aa5e8345f am: convert applypatch-msg to use hook.h
 8:  119b92fbeae =  8:  6f8d3754b4f merge: convert post-merge to use hook.h
 9:  359ba416e84 !  9:  d3107034806 hooks: convert non-worktree 'post-checkout' hook to hook library
    @@ builtin/checkout.c
      #include "ll-merge.h"
      #include "lockfile.h"
      #include "merge-recursive.h"
    -@@ builtin/checkout.c: struct branch_info {
    +@@ builtin/checkout.c: static void branch_info_release(struct branch_info *info)
      static int post_checkout_hook(struct commit *old_commit, struct commit *new_commit,
      			      int changed)
      {
10:  b7599be95a7 ! 10:  bff7c1513ca hooks: convert worktree 'post-checkout' hook to hook library
    @@ builtin/worktree.c: static int add_worktree(const char *path, const char *refnam
     -		const char *hook = find_hook("post-checkout");
     -		if (hook) {
     -			const char *env[] = { "GIT_DIR", "GIT_WORK_TREE", NULL };
    --			cp.git_cmd = 0;
    +-			struct child_process cp = CHILD_PROCESS_INIT;
     -			cp.no_stdin = 1;
     -			cp.stdout_to_stderr = 1;
     -			cp.dir = path;
    --			cp.env = env;
    --			cp.argv = NULL;
    +-			strvec_pushv(&cp.env_array, env);
     -			cp.trace2_hook_name = "post-checkout";
     -			strvec_pushl(&cp.args, absolute_path(hook),
     -				     oid_to_hex(null_oid()),
11:  f1c84d7f627 = 11:  7d9c0a73568 git hook run: add an --ignore-missing flag
12:  4e0f94d9102 = 12:  8ea3b250dff send-email: use 'git hook run' for 'sendemail-validate'
13:  e858f332a62 = 13:  a184afd1ffd git-p4: use 'git hook' to run hooks
14:  9a5956cc028 = 14:  1a43e50617f commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
15:  6fd47c4c499 = 15:  08b7e63ba5b read-cache: convert post-index-change to use hook.h
16:  b201ea46f4b = 16:  c47b36ab41a receive-pack: convert push-to-checkout hook to hook.h
17:  281d17b04db ! 17:  7b99a4b633c run-command: remove old run_hook_{le,ve}() hook API
    @@ run-command.c: int async_with_fork(void)
     -	strvec_push(&hook.args, p);
     -	while ((p = va_arg(args, const char *)))
     -		strvec_push(&hook.args, p);
    --	hook.env = env;
    +-	if (env)
    +-		strvec_pushv(&hook.env_array, (const char **)env);
     -	hook.no_stdin = 1;
     -	hook.stdout_to_stderr = 1;
     -	hook.trace2_hook_name = name;
-- 
2.34.1.1146.gb52885e7c44

