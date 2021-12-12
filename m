Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB00CC433EF
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 20:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhLLUOe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 15:14:34 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:41945 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhLLUOe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 15:14:34 -0500
Received: by mail-wm1-f41.google.com with SMTP id az34-20020a05600c602200b0033bf8662572so10388349wmb.0
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 12:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WH4h+akfZE/KGmJZ1L6nal76D1aVclo+qQtIpf6hDmw=;
        b=UpyGrbZBVLNx9g6YKdX4l0yedziMz9nN/6EgFCPyN4TlvA806GVx8F1OF8EKsfksH/
         fPN+/9X9zRvpnX+yyOadWLrntq521g+C23p0eRLXXGn4dZDwe53kX2lB1QTBZT/PbDrg
         X9n2IuRVNhgR2ZhjPZKSTVp7psqTCd0BzPKdplNYtzy72np/OtDPi9RGbidsZ+H6QQPk
         YRA/pw+PZb7V/BNpvW4Ihrn97V80QG8sz/gEe4LtQU8UZkoFkta3wbb0NYGuoyCG6j4o
         wIa3TyR0TISB0kBfPGPgcHqJZHMoJsRnR0cOTnWU6GHo09FMkXa6bwCZxF+IOxMA/zwa
         9Ccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WH4h+akfZE/KGmJZ1L6nal76D1aVclo+qQtIpf6hDmw=;
        b=oU4wAmIndUuTmO1CM5W//cu48BfDVfm7YTtZdpjHesWE6dHscI00zl3XNdN8qK1EMY
         EwSTDa8cLcdBZQsUWRTBfQtXPLVH9/rBowG2bkygc/kHqBA8KYGN32gE4tFzaXt3EPDD
         1kV3FLBZElKneCYI9ot+lLsNfg2C5RIMORbY1swy9Wc69HMJxOBR33Ly0L/mm9pu5sxK
         R2YuyxnmmQiSYdd/Z9ITy9F7rIonIHBhA3/zLOGuhnVTUKtzb2wxBsdDuxjPehqghAl8
         k35or5lIfd9vQGfCKHJ8d8cf/8ycTIcVWWpKE5z6rRiJ27AovDMfyGa7qpU9tlIWae/y
         3Usw==
X-Gm-Message-State: AOAM532hZhgQoWxGm8Na4ujw5yuH/Kga468kt0RHjOrYSFSk2cPvh87L
        hOsbRcLqE1dwljQDpHYIUXY0DsL+oqew8w==
X-Google-Smtp-Source: ABdhPJxHYR0dY31Oi98NpKF98cOS05lK9ddGnIpMIHnr0XqPPnokShUf0vUi2ED+LiCBxSkBU71Dtg==
X-Received: by 2002:a7b:cf02:: with SMTP id l2mr33126534wmg.78.1639340013117;
        Sun, 12 Dec 2021 12:13:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay21sm4824336wmb.7.2021.12.12.12.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 12:13:32 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/13] tests + init: don't rely on templates & add --no-template + config
Date:   Sun, 12 Dec 2021 21:13:10 +0100
Message-Id: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1020.gb1392dd1877
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[This series does a couple of different things that could be split up,
but I thought that it was easier to review it in one piece].

This series changes our tests to not rely on the default template that
"git init" populates new repositories with. This reliance hid a bug
where a recently added mode of "sparse-checkout" had a hard dependency
on git's default template, i.e. it would potentially break on
repositories with a custom --template.

So this changes all the tests that relied on those, and declares that
we'll always create the "info" directory whatever the template says
(which will fix that sparse-checkout isssue).

We also add a new "git [init|clone] --no-template" option, and make
the existing init.templateDir accept "false" as a way of doing what
the existing-but-undocumented --template= would do, i.e. use no
template at all.

I would like to eventually follow-up and make something like
init.templateDir=false the default (or at least something closer to
it). Notably we litter the rather large sample hooks in every
repository ever cloned, but this series doesn't chane anything about
what we do by default.

This topic was mentioned (item 16) in the recent contributor
summit[1]. The notes only reflect that I mentioned .git/branches, but
I think it was in reply to someone's question about that or the
default templates.

1. https://lore.kernel.org/git/nycvar.QRO.7.76.6.2110211148400.56@tvgsbejvaqbjf.bet/

Ævar Arnfjörð Bjarmason (13):
  t0001: fix gaps in "TEMPLATE DIRECTORY" coverage
  init: split out template population from create_default_files()
  init: unconditionally create the "info" directory
  t0008: don't rely on default ".git/info/exclude"
  init & clone: add a --no-template option
  init & clone: add init.templateDir=[bool]
  test-lib: create test data with "git init --no-template" (almost)
  tests: don't depend on template-created .git/branches
  t5540: don't rely on "hook/post-update.sample"
  test-lib-functions: add and use a "write_hook" wrapper
  tests: change "cat && chmod +x" to use "write_hook"
  tests: migrate miscellaneous "write_script" to "write_hooks"
  tests: don't depend on template-created .git/hooks

 Documentation/git-clone.txt            |   8 +-
 Documentation/git-init.txt             |  31 +++++++-
 Documentation/gitrepository-layout.txt |  17 ++++-
 builtin/clone.c                        |  15 +++-
 builtin/init-db.c                      |  75 +++++++++++++------
 cache.h                                |   2 +
 config.c                               |  34 +++++++++
 config.h                               |  17 +++++
 t/t0001-init.sh                        | 100 ++++++++++++++++++++++---
 t/t0008-ignores.sh                     |  10 +--
 t/t1416-ref-transaction-hooks.sh       |  14 ++--
 t/t3412-rebase-root.sh                 |  18 ++---
 t/t3413-rebase-hook.sh                 |  18 ++---
 t/t3430-rebase-merges.sh               |   5 +-
 t/t5401-update-hooks.sh                |  62 +++++++--------
 t/t5402-post-merge-hook.sh             |  16 ++--
 t/t5406-remote-rejects.sh              |   2 +-
 t/t5407-post-rewrite-hook.sh           |  14 ++--
 t/t5409-colorize-remote-messages.sh    |   2 +-
 t/t5411-proc-receive-hook.sh           |   4 +-
 t/t5505-remote.sh                      |   2 +
 t/t5510-fetch.sh                       |   6 +-
 t/t5516-fetch-push.sh                  |  26 +++----
 t/t5521-pull-options.sh                |   4 +-
 t/t5540-http-push-webdav.sh            |   4 +-
 t/t5541-http-push-smart.sh             |   4 +-
 t/t5547-push-quarantine.sh             |   4 +-
 t/t5548-push-porcelain.sh              |   2 +-
 t/t5601-clone.sh                       |   4 +-
 t/t6500-gc.sh                          |   4 +-
 t/t7450-bad-git-dotfiles.sh            |   1 +
 t/test-lib-functions.sh                |  30 ++++++++
 t/test-lib.sh                          |   5 +-
 wrap-for-bin.sh                        |   4 +-
 34 files changed, 391 insertions(+), 173 deletions(-)

-- 
2.34.1.1020.gb1392dd1877

