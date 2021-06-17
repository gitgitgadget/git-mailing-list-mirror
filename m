Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E284C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83BDB61245
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhFQKLs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhFQKLr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:11:47 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8B9C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:09:39 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id y13-20020a1c4b0d0000b02901c20173e165so3375783wma.0
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xM1ldanP4CjVRaeQ4VKP8xqVtvvCi39oJyilSWgrK+Q=;
        b=RvEkrqVaNIDjVczBvqK6fDU3YpP30g9exswR5WpoDmyvG4xpFEuFPVbSaHk6TpBR9a
         +0+bzBvWs/2pRMl7WCpk9mTWUFyE/HKIb1TjbtAKFaybY8Cw/DvT/WXrtv8FcxcwCtkR
         98+2xZMHlQL04yQpbYSIhlUBnQmvM2Vret4Co/sG3xv5xsD3xC6tudOewzghu6mdxpnE
         2PxXddhdS39fGHlFm+BOKW5CmH4UNtv+y3pZaH7jhWq0u+4i8T7JxypWlOM2zz83vuy3
         owPuEylGoW8FUIEuk+JL3U4FcuGJ49FlFqyxDcbZK8LQOQBMRgGYPSePx9kRLmPH4x6Y
         eOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xM1ldanP4CjVRaeQ4VKP8xqVtvvCi39oJyilSWgrK+Q=;
        b=ATJuMB3pJkGlKV/iREgDLQLUyOwVDhPWnq3QkmeMpxSJKVJ7r77DjE0E9ofp1OtrPw
         /nfpdBZ5L7cF0TbBW7GY7oAplGqO3IlZOc557D6L4LM5ctpDDDRu1KRo7qczwh4jHfSp
         znxwMx18MsYDZ08uOq29NUkLnL4MWW1bPU1He6vjVnwCErPdyGU9wN/WIbBU02EpUl63
         b/+/CNLErqbc9n8ZxClKfFHd2bm4ezUmnhq8V5RRZU2tbuEkFTWYgTz/BjqpfNDoMKEW
         qdx7EvVER199OFL12ew+Gwi0rqVNX8kUJ9Bt0HwKDu5hyPyMVKfTXKWGUqOHdvzNbs2J
         51tA==
X-Gm-Message-State: AOAM533i5OSi94OCO3Nl2VPk1WmmxGwIlLrqrkDJpcT54ZlIrnGea37C
        fj3xh5jWRycymqQOq7AHp1WVkW2FUWTi5g==
X-Google-Smtp-Source: ABdhPJyJxsnTP9w7yPu7RdlmQCqPkLBjbgf/yJxdZUPK5V0kT0ZOPftJclZamI6lAAmYVaSlZJFRLw==
X-Received: by 2002:a1c:1f54:: with SMTP id f81mr4018391wmf.121.1623924578345;
        Thu, 17 Jun 2021 03:09:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9sm7348425wmm.33.2021.06.17.03.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:09:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] Add a generated list of hooks in hook-list.h
Date:   Thu, 17 Jun 2021 12:09:33 +0200
Message-Id: <cover-0.3-0000000000-20210617T100239Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.576.g59759b6ca7d
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This goes on top of my just-submitted trivial Makefile fixes[1], and
adds a list of hooks in hook-list.h, similar to the existing
config-list.h.

We can then error when a C API provides us with an unknown hook, so
non-type-checked things in the codebase like find_hook("proc-receive")
now effectively have a type check of sorts (well, we'd catch a typo in
our tests).

These changes are currently at the end of the
ab/config-based-hooks-base series[2], I'm carving them out to make
that topic even easier to digest. We can this without any of the "git
hook run" stuff.

We also had a big but inaccurate list of hooks in builtin/help.c, as
part of submitting a bugreport. That's now using githooks(5) as a
source of truth.

This also builds on Windows with cmake, unlike the outstanding [2]
`restart of "config-based-hooks"` series, at least that part of the CI
now passes, and the change to contrib/buildsystems/CMakeLists.txt
looks trivially correct to me.

1. https://lore.kernel.org/git/cover-0.3-0000000000-20210617T095827Z-avarab@gmail.com/
2. https://lore.kernel.org/git/cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com/

Emily Shaffer (1):
  hook.c: add a hook_exists() wrapper and use it in bugreport.c

Ævar Arnfjörð Bjarmason (2):
  hook.[ch]: move find_hook() to this new library
  hook-list.h: add a generated list of hooks, like config-list.h

 .gitignore                          |  1 +
 Makefile                            | 12 +++++-
 builtin/am.c                        |  1 +
 builtin/bugreport.c                 | 46 +++++-----------------
 builtin/commit.c                    |  1 +
 builtin/merge.c                     |  1 +
 builtin/receive-pack.c              |  1 +
 builtin/worktree.c                  |  1 +
 contrib/buildsystems/CMakeLists.txt |  7 ++++
 generate-hooklist.sh                | 24 ++++++++++++
 hook.c                              | 61 +++++++++++++++++++++++++++++
 hook.h                              | 16 ++++++++
 refs.c                              |  1 +
 run-command.c                       | 35 +----------------
 run-command.h                       |  7 ----
 sequencer.c                         |  1 +
 transport.c                         |  1 +
 17 files changed, 138 insertions(+), 79 deletions(-)
 create mode 100755 generate-hooklist.sh
 create mode 100644 hook.c
 create mode 100644 hook.h

-- 
2.32.0.576.g59759b6ca7d

