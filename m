Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9832C433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 00:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B92260F92
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 00:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbhI0AzB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 20:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbhI0AzB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Sep 2021 20:55:01 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31523C061575
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 17:53:24 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id w29so47124079wra.8
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 17:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J5MohpZNYdKLFFXQMwOISkDIjSmZGFvLjTkKHdlpFDE=;
        b=jtJRWuEhkkKFAYQ70P3uP4DviF44Sc4mjM58Dkk2joMqJauhYz3+4o4gr9evRpkgoK
         NIutzTx9TZiZuIB6h/L4hB+rPc4zuFV95k6e5CUXk/ktfWHuLuLx45/E/VBW+9/1Rvof
         /7Jl3P238Kqf+4hQO7iORdkrj8+DVG1mKpBGQ60Vv37YjKj/vMbds69bimxGH9MtjTnC
         6If64IucK/vf6V56/AKsR4hbVhDPap3/AFo6V8aIjguHlNqhPXf/r+uwUHdAqKibRopH
         w7WnhkEXIo+tJQhAmT8sEcs+Qlerl+9WVjzf0A6+S0D4MHhmbHgqzBs6yKA+6EoDftCw
         Pifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J5MohpZNYdKLFFXQMwOISkDIjSmZGFvLjTkKHdlpFDE=;
        b=A2yAiyl6TCbRUd1MyxbgwX6/LyMBGQw+4+twCK/8a93YYRHoEW6gmgmDrbofjzTcTy
         lJ6aiCUMtSFnktPa6FxRcv0NGhiNsFLCul3bv95tDpEFuVxrkV0C5s3szOckCHlmqKuS
         UzxA/savgVsRFNaiZK74RqfPGTtCQqteADxBS1Bv3EwyzQEUQmt+54FNCyT3iSNVjIWl
         FwNU3FS4bpNpGnfQssrYG77dKDcCbNntHVyk/6lirgcr5svECJOM6F7VDs7eBCVwz+so
         v2tbz8bwmdPgPPiWkGa7ZLpsClVd6L+mItm0sw0VDeNAnDz7QrUuzj8XcTPzlvul6rDr
         /vVQ==
X-Gm-Message-State: AOAM533twXuw3YdsZ4Em021ofma1B6qJqnFEYO7NkECl7SxqLDsVg3vj
        NmROn3MTA6OyH7tqHNi2CQmcLjAd5dQXSg==
X-Google-Smtp-Source: ABdhPJxNNYTEDUZG4G5O00fOYWCeY3agapVYc7Ssmq8JtB5K8mP9lKYn0p/PDRmcmvQXBRyZ9zgmNg==
X-Received: by 2002:adf:f9c9:: with SMTP id w9mr23957484wrr.45.1632704002578;
        Sun, 26 Sep 2021 17:53:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i2sm14749745wrq.78.2021.09.26.17.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 17:53:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/6] Non-trivial designated initializer conversion
Date:   Mon, 27 Sep 2021 02:53:14 +0200
Message-Id: <cover-0.6-00000000000-20210927T004920Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1316.gb2e9b3ba3ae
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A sister series to the just-submitted series of trivial designated
initalizer cleanups:
https://lore.kernel.org/git/cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com/

This doesn't conflict semantically or textually with that series, but
is migrating to easier to manage initialization patterns for the same
reasons.

The code changes are all rather small, the diff in 6/6 looks scary,
but as --word-diff will show most of it schanging x->y to an &x->y and
the like, as two struct members were changed from being pointers.

Ævar Arnfjörð Bjarmason (6):
  daemon.c: refactor hostinfo_init() to HOSTINFO_INIT macro
  builtin/blame.c: refactor commit_info_init() to COMMIT_INFO_INIT macro
  shortlog: use designated initializer for "struct shortlog"
  urlmatch.[ch]: add and use URLMATCH_CONFIG_INIT
  builtin/remote.c: add and use a REF_STATES_INIT
  builtin/remote.c: add and use SHOW_INFO_INIT

 builtin/blame.c    |  30 ++++++------
 builtin/config.c   |   3 +-
 builtin/remote.c   | 111 ++++++++++++++++++++++-----------------------
 builtin/shortlog.c |   2 +-
 credential.c       |   4 +-
 daemon.c           |  19 +++-----
 http.c             |   4 +-
 shortlog.h         |   4 ++
 urlmatch.h         |   4 ++
 9 files changed, 87 insertions(+), 94 deletions(-)

-- 
2.33.0.1316.gb2e9b3ba3ae

