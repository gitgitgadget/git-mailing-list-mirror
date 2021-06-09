Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD9CC48BCF
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 19:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C574D613FE
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 19:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhFITcA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 15:32:00 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:43635 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhFITb7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 15:31:59 -0400
Received: by mail-ot1-f41.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso25031798otu.10
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 12:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ap2KVrzlhh8murJTQJBa2gRy42O2Sw3kQdgsDp+GORE=;
        b=QxTfopVIrbqCI7X+A6JFI9s3GrY4hJfv+sHI4hXf1OY+WRFnwKdZkHlkTqPv6aHZCf
         V6x1MvxpiaP31Bm/t59hHQpNkQXNKRwSoVwUcbAm3O1G7bA2fKd8JoPRwPoC3CXi3wv6
         7BIu9zS8ingLlzIA7IvcqBUeXm1MaVS74n2Nv8XaEcW9p2i2HbZvnEsCpCWVdEdQjJvk
         HH2CjDGTlRdGt1BJefy6umwMZxyoeRVlaAkup5ce7J8lywsiNLUIMesm3MWua3PJ+B/0
         xmXY6kQQ5phKyNJnkUqdug4QBdLxmz8kozL3EankV4KvbuAFmO0uSmA9+MhHY1D3luuF
         hreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ap2KVrzlhh8murJTQJBa2gRy42O2Sw3kQdgsDp+GORE=;
        b=UcAawJ2xAgYOzfgeoW1MRjNIVhF0utSKWGWrk02vER3bf4Ac6Ye9fkcg46CYTukhXJ
         2FBI3upaPGA9jLka13XrAnAURDZMfH2LryVQH7SUW4eYQJDtPWw8RpRJ+GYXyRenUygi
         C+MnPaVuSThk/RW1wczVLtxArML+HX7sX0qg1g1g93lRpkJU+PMydXVYOKI8cqxL0RF6
         f4Af+6m02JuBFvVkO7IsbKfwMdrHKQ77p4aUfoLg7wehrIP1IgrdnODysEEEIdl7Xyw8
         071c0fOJVWT90Rfrs9ogz2TjN5vqk1W/DxlKEJcTyCKylZVslWTWHQ6Esm7wan+VUMVH
         sZLw==
X-Gm-Message-State: AOAM532iS3Ol8JXK/Q1lBz+2AAx2hRk0xt1xoc8bxQXSKVI2wAvwpsvh
        ayy9s4v4owErlzFmEhuyQCM0M63H4NSD/A==
X-Google-Smtp-Source: ABdhPJwiEZkYNAmdPnDoFpnk3egFcxD5waPuDNb6fsFC1UhCSD5Ko8EVkqLTaDImEAHSYJJguPyYAw==
X-Received: by 2002:a9d:588c:: with SMTP id x12mr801334otg.193.1623266934379;
        Wed, 09 Jun 2021 12:28:54 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id u15sm127604ooq.24.2021.06.09.12.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 12:28:53 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/7] Make diff3 the default conflict style
Date:   Wed,  9 Jun 2021 14:28:35 -0500
Message-Id: <20210609192842.696646-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.2.g41be0a4e50
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series turned out much more complicated that simply flipping
the switch and dealing with the consequences. Apparently some commands
are completely ignoring the configuration (notes and merge-tree), and
others are handling it wrong (checkout).

So in preparation I created a new test to make sure these rowdy
commands handle the configuration correctly, and then step by step I fix
them.

Once all the commands are fixed I proceed to cleanup xdiff-interface in
preparation for the switch.

And finally once the switch is flipped the documnetation is updated, and
funch of test scripts receive a temporary configuration that returns
them to the old "merge" (diff2) behavior so they pass with minimum
changes.

I have already written patches to update the tests so no configuration
is needed and they parse the diff3 style directly, but the series is
already quite verbose as it is.

One salient thorn is that from my point of view merge_recursive_config()
is implemtend wrongly and thus can't be called as other configuration
functions, like git_diff_basic_config(). It seems there's a huge area of
opportunity there to clean all that up, but that's for another series.

Felipe Contreras (7):
  test: add merge style config test
  merge-tree: fix merge.conflictstyle handling
  notes: fix merge.conflictstyle handling
  checkout: fix merge.conflictstyle handling
  xdiff: rename XDL_MERGE_STYLE_DIFF3
  xdiff: simplify style assignments
  xdiff: make diff3 the default conflictStyle

 Documentation/config/merge.txt           |  12 +--
 Documentation/git-merge-file.txt         |   2 +
 Documentation/git-merge.txt              |  28 ++----
 Documentation/git-rerere.txt             |   2 +-
 Documentation/gitattributes.txt          |   6 +-
 Documentation/technical/rerere.txt       |   3 +-
 Documentation/user-manual.txt            |   6 +-
 builtin/merge-file.c                     |   5 +-
 builtin/merge-recursive.c                |   3 +
 builtin/merge-tree.c                     |   4 +
 builtin/merge.c                          |   4 +
 builtin/notes.c                          |   3 +-
 ll-merge.c                               |   3 +-
 merge-recursive.c                        |   2 +-
 sequencer.c                              |   5 +
 t/t2023-checkout-m.sh                    |   2 +
 t/t3310-notes-merge-manual-resolve.sh    |   2 +
 t/t3311-notes-merge-fanout.sh            |   2 +
 t/t3404-rebase-interactive.sh            |   2 +
 t/t3507-cherry-pick-conflict.sh          |   2 +
 t/t4017-diff-retval.sh                   |   2 +
 t/t4048-diff-combined-binary.sh          |   2 +
 t/t4200-rerere.sh                        |   2 +
 t/t4300-merge-tree.sh                    |   2 +
 t/t6402-merge-rename.sh                  |   2 +
 t/t6403-merge-file.sh                    |   2 +
 t/t6404-recursive-merge.sh               |   2 +
 t/t6416-recursive-corner-cases.sh        |   2 +
 t/t6417-merge-ours-theirs.sh             |   2 +
 t/t6418-merge-text-auto.sh               |   2 +
 t/t6422-merge-rename-corner-cases.sh     |   2 +
 t/t6423-merge-rename-directories.sh      |   1 +
 t/t6428-merge-conflicts-sparse.sh        |   1 +
 t/t6432-merge-recursive-space-options.sh |   2 +
 t/t6440-config-conflict-markers.sh       | 123 +++++++++++++++++++++++
 t/t7201-co.sh                            |   2 +
 t/t7506-status-submodule.sh              |   1 +
 xdiff-interface.c                        |   6 +-
 xdiff/xdiff.h                            |   3 +-
 xdiff/xmerge.c                           |   4 +-
 40 files changed, 217 insertions(+), 46 deletions(-)
 create mode 100755 t/t6440-config-conflict-markers.sh

-- 
2.32.0.2.g41be0a4e50

