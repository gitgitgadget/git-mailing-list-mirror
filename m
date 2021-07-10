Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41867C07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 08:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 095EF613C2
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 08:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbhGJIuV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 04:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbhGJIuV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 04:50:21 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05ECC0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 01:47:36 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id g16so5758539wrw.5
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 01:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+YaH6U5nfzxdoXK40Eh1YRvetu03IAIzIg1hu0rUk1Y=;
        b=jL9JgybpTjc3OFYP2gev6TmeeUIRz/mcXpkaak8O+xOfAqlr4aYuuVazR8XeJ6C8gr
         3gzE2JZ1k/MMZXNdKUIC4UXKou9yJUEh71NfStTd7cYEAsY8TY1VSOTSZJBco8Cd/1UE
         8jU2aIVOiUydsUuOcAhzxdGG9t53vnVZFwzBqi7kR9Bd4kEVfeVnsZmXZoicbKzjMWwy
         83nUiq6k1qeaesgZggpbN7WYsE26nBCBNCxDNNSjAsyiX29QnnYMscpKnXarqdcW/Ese
         Jxo3w6Hz0gELpP/yY8nnQha6h/lB0TXdZY3yNQm7cvvo+bhZDkNy+pvPdimj8GOdTqbC
         v/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+YaH6U5nfzxdoXK40Eh1YRvetu03IAIzIg1hu0rUk1Y=;
        b=YwbQsD9k8dUsXh0nlaGElUX6rpLf0ZJRcmlkZHif3t+pAJgujJQcXFxgdtt9hceXEo
         opovwv3KPOeO0yzqtbd/dMiL8tFVQGSv1L6cCJTavIk1O6p6JF3Zf7tFSRHoOZkWz7ji
         em+ETrhxSwdrkwr0NEtlp7+vE7B3zD6ZZ8DHnnyotkMgPP0qll+s6wlAAFWlYnfLBTpb
         DSM0gAZt2NtkwocPgkI2AIQZVtYWL+HOJTaPZ1kssD0ZA+jVUGrOvX8d9zVa3OgB/VDW
         U8KTGi6HyieP686ccZZUAZ67KpT7ko26DXN8YHwPFehouO5e9yj+smDVsEnOK8nbqxkI
         Zjrw==
X-Gm-Message-State: AOAM532svOASHt2wKDXUU+hnXu1aJDfl7FqGSPRqmRxM9EgsFxMoY495
        +eK/2XWX5FJ9JtJpyO0HskEXdWvZtsmNQA==
X-Google-Smtp-Source: ABdhPJyo6Bfi3HDjdXDf/QiGLwj7LrJP4ZwPioTfoBw4D8War4LXSzIjUu73z/eZa/jWbGfss5SPaw==
X-Received: by 2002:adf:ea8c:: with SMTP id s12mr6319824wrm.404.1625906854955;
        Sat, 10 Jul 2021 01:47:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x8sm165769wrt.93.2021.07.10.01.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 01:47:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/6] add missing __attribute__((format))
Date:   Sat, 10 Jul 2021 10:47:26 +0200
Message-Id: <cover-0.6-00000000000-20210710T084445Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adds missing add missing __attribute__((format)) in various places,
which improves compile-time checking.

Ævar Arnfjörð Bjarmason (6):
  *.c static functions: don't forward-declare __attribute__
  sequencer.c: move static function to avoid forward decl
  *.c static functions: add missing __attribute__((format))
  *.h: add a few missing  __attribute__((format))
  bugreport.c: tweak cmd_bugreport() to use __attribute__((printf))
  git-compat-util.h: add __attribute__((printf)) to git_*printf*

 add-patch.c                                   |  1 +
 advice.h                                      |  1 +
 builtin/am.c                                  |  1 +
 builtin/bisect--helper.c                      |  2 +
 builtin/bugreport.c                           | 11 ++++-
 builtin/index-pack.c                          |  4 +-
 builtin/receive-pack.c                        |  5 +--
 cache.h                                       |  1 +
 commit-graph.c                                |  1 +
 compat/mingw.c                                |  1 +
 compat/win32/syslog.h                         |  1 +
 compat/winansi.c                              |  1 +
 .../osxkeychain/git-credential-osxkeychain.c  |  1 +
 .../wincred/git-credential-wincred.c          |  1 +
 gettext.c                                     |  1 +
 git-compat-util.h                             |  2 +
 imap-send.c                                   |  3 ++
 mailmap.c                                     |  1 +
 merge-ort.c                                   |  1 +
 merge-recursive.c                             |  1 +
 midx.c                                        |  1 +
 quote.h                                       |  1 +
 ref-filter.c                                  |  1 +
 sequencer.c                                   | 43 +++++++++----------
 server-info.c                                 |  1 +
 strbuf.h                                      |  2 +
 t/helper/test-advise.c                        |  2 +-
 worktree.c                                    |  1 +
 28 files changed, 62 insertions(+), 31 deletions(-)

-- 
2.32.0.636.g43e71d69cff

