Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3748C433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 11:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbhKWLta (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 06:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbhKWLta (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 06:49:30 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7087C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:46:21 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id j3so744208wrp.1
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xRp8y4VUGW25l2bKmf3QNBreryuS/hy6KHeL/7IeArw=;
        b=jUhQWpIbB/GlJ3p1nSITi67dBhvMQlBGwE8rGlyMV7z0hiiCoi0V6Ef8Di5jzIeIjl
         H6y7tLRG4G+ztxkRFr2Sbvk4GrYQjSajNk0QSLzq4TYhRDbNyRkInMeQVfl8AzbKXamM
         hdgfi6VfdGcYeX9VkJylZ/e8SKB3MH25tNsZtfbdShN5ONEfheTncb0SV+DH5D51L48c
         AEwo2hHvto5TflTvQ+Q0lb3BOoVu1iR7Uzgxi/ziNn8GntljLrMP4ROORWxJvSUmJ2iB
         qqHN0NiLs+oyf3CJfsdu0ymRccLnQ7fI81C2vpPY1MQ90K0lvxDgIyHIA19XdWkeadck
         +grg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xRp8y4VUGW25l2bKmf3QNBreryuS/hy6KHeL/7IeArw=;
        b=p21JXu2OYCD8j0YLWDzs7tRLpCbUnu5GaB68IVwyGjvKOqDvZPKg+LGgsP8iemxOMF
         aouEUJqbDyCDCCdyn5rgL3SOsEnf1tGInvSawVf7LJkKvTNB9VGEiYuIviYr6lm+re95
         o8+W/d/ULIDHdgJb/8GaZ2aa0phgu0dhcoepGToIBfXn4eCJwJzPQGDxBz7hUlKDsK/i
         0aotaIpLG7lg/fJ+DE7RDqaJoXJFa4jPc99dF7sxe6YOveHVfTXFGs3QT64Y4w8u8u97
         UoNaxAPK59+I6ME359eKWssq3huiJTZLKeiqfLLcaJzPnbpT/QxxmGO0h90bckXZrcwT
         62lQ==
X-Gm-Message-State: AOAM530unOA+O1SlHPt1e9MeENhoV/Z684J/f5yYYLVNuKFT6DCU9sgj
        FUoIai+aaARp6eeDzNN3aizFz/kvFAJDGg==
X-Google-Smtp-Source: ABdhPJxJ4PblN7XLP2hoc7jxnLzThBzNXWlfVCHw14k/IiKkTpoppqjD5PTX5GTTFLAEQLA/huvZQw==
X-Received: by 2002:a5d:6d0c:: with SMTP id e12mr6789432wrq.94.1637667980041;
        Tue, 23 Nov 2021 03:46:20 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c11sm1723145wmq.27.2021.11.23.03.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 03:46:19 -0800 (PST)
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
Subject: [PATCH v5 00/17] hook.[ch]: new library to run hooks + simple hook conversion
Date:   Tue, 23 Nov 2021 12:45:59 +0100
Message-Id: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.831.gd33babec0d1
In-Reply-To: <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com>
References: <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A trivial update to the v4 of the series to migrate hook execution to
the new hook.c hook execution library. For a meaningful overall
summary see v4's CL[1].

The only update here is to stop using the "env" member of "struct
child_process" in favor of "env_array".

This is in preparation for a re-roll of another series[2] to remove
"argv" (and soon in a re-roll, "env") from that API. Without this
update the two would semantically conflict.

1. https://lore.kernel.org/git/cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com/
2. https://lore.kernel.org/git/cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com/

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
 builtin/worktree.c         |  27 +++-----
 command-list.txt           |   1 +
 commit.c                   |  15 +++--
 git-p4.py                  |  70 ++-----------------
 git-send-email.perl        |  22 +++---
 git.c                      |   1 +
 hook.c                     | 131 ++++++++++++++++++++++++++++++++++++
 hook.h                     |  57 ++++++++++++++++
 read-cache.c               |   3 +-
 reset.c                    |   3 +-
 run-command.c              |  32 ---------
 run-command.h              |  17 -----
 t/t1800-hook.sh            | 134 +++++++++++++++++++++++++++++++++++++
 t/t9001-send-email.sh      |   4 +-
 27 files changed, 522 insertions(+), 158 deletions(-)
 create mode 100644 Documentation/git-hook.txt
 create mode 100644 builtin/hook.c
 create mode 100755 t/t1800-hook.sh

Range-diff against v4:
 1:  d97d6734961 !  1:  4ca52feebb8 hook: add 'run' subcommand
    @@ hook.c: int hook_exists(const char *name)
     +		return 0;
     +
     +	cp->no_stdin = 1;
    -+	cp->env = hook_cb->options->env.v;
    ++	strvec_pushv(&cp->env_array, hook_cb->options->env.v);
     +	cp->stdout_to_stderr = 1;
     +	cp->trace2_hook_name = hook_cb->hook_name;
     +
 2:  ca6464f7d5e =  2:  6275b97a306 hook API: add a run_hooks() wrapper
 3:  173860afca1 =  3:  b5b3051b2e5 gc: use hook library for pre-auto-gc hook
 4:  80a2171ddaf =  4:  c88eb5d4c25 am: convert {pre,post}-applypatch to use hook.h
 5:  74f459db287 =  5:  1d8f7b7e4c1 hook API: add a run_hooks_l() wrapper
 6:  1fd70c0e88a =  6:  d49a1444345 rebase: convert pre-rebase to use hook.h
 7:  ccba3ddf52e =  7:  191fdad0165 am: convert applypatch-msg to use hook.h
 8:  2c23e8645ec =  8:  119b92fbeae merge: convert post-merge to use hook.h
 9:  cb95c79093b =  9:  359ba416e84 hooks: convert non-worktree 'post-checkout' hook to hook library
10:  f330600fec8 ! 10:  b7599be95a7 hooks: convert worktree 'post-checkout' hook to hook library
    @@ builtin/worktree.c: static int add_worktree(const char *path, const char *refnam
     
      ## hook.c ##
     @@ hook.c: static int pick_next_hook(struct child_process *cp,
    - 	cp->env = hook_cb->options->env.v;
    + 	strvec_pushv(&cp->env_array, hook_cb->options->env.v);
      	cp->stdout_to_stderr = 1;
      	cp->trace2_hook_name = hook_cb->hook_name;
     +	cp->dir = hook_cb->options->dir;
11:  a0b6818c766 = 11:  f1c84d7f627 git hook run: add an --ignore-missing flag
12:  efa35971e9f = 12:  4e0f94d9102 send-email: use 'git hook run' for 'sendemail-validate'
13:  98e0e3330fb = 13:  e858f332a62 git-p4: use 'git hook' to run hooks
14:  79ea5a2a4f5 = 14:  9a5956cc028 commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
15:  81612f94707 = 15:  6fd47c4c499 read-cache: convert post-index-change to use hook.h
16:  43ecd6697e0 = 16:  b201ea46f4b receive-pack: convert push-to-checkout hook to hook.h
17:  9ef574fa30c = 17:  281d17b04db run-command: remove old run_hook_{le,ve}() hook API
-- 
2.34.0.831.gd33babec0d1

