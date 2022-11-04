Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC6DC433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 13:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiKDN0L (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 09:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbiKDNZk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 09:25:40 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC392F024
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 06:24:54 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id kt23so13217648ejc.7
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 06:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQ4DAsrgGzfJtjqGFEy9kTYbLyQji1nWsv6KBs5cbWc=;
        b=IAAV42RIDh1yuuhsOjSVlOGEe0Gzb1RDuUfRjxHUpn9aAQCMtzLF8zAF8lAnw5w1x6
         wm/BYUY3/3JZ3FekgyWfKQcMi8vmk0pgGwE9jLvMRJ9XXXpU1aVb6W+ZPO0CW+YLMzlw
         CAdw+YBmSyTOxAgb30MBqzrlyET1gTssWP6q+v0gcySXGPQ1Ja44XBk2iQNl6DMSRySV
         YIJyJaUCPtCQ3qXtH8UXurPGyJTl55seGE3HpgbQARUZ4H9dqEEuZKHODL+q4ihnWv56
         drg2DLyuQkrnPkA8nAbcXAA/DWkQCLkGLH1HFz6LTDw4nkvDlsR9q20LxSRPWmtq5pUR
         FoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQ4DAsrgGzfJtjqGFEy9kTYbLyQji1nWsv6KBs5cbWc=;
        b=BOuHjPucf4gco8P6T8ICAMB+zy5vonI5Wrwxmm1U0kYo2q4VJkofs3KSaZgL0X5Yj4
         v7iUjU+qeclZl+IKsp5Hx+GOxBCTYlFi+Zpgcx4rzjspx4Bi5iPHAVaQJe3y/gay+Msz
         iAJAqZ6u/sR9W4rADaifrzhDm+as4lug/UOUyt4i1UL6wGEr2lZTw9r8+WdR/daXQjYL
         uNmD1aJk/eQP6OaH+tbjKafyIyE2h/kpdtxEz7+8ws31Mhn6Cmh1kjPxjfj/E02KGO9P
         5cKLzbHVzvXHzvrTzOKVndiLkgYpYNqOKwB7UjLcOmWURNUxolGdSDvjaZnfG4oEFLPH
         uH2A==
X-Gm-Message-State: ACrzQf1sv+LnVrvlD0dv244DSJZ0siCSI14D+SZfnru5a/BUj9qp+BlY
        lL93d2+fbI93oxbZ3ktIaog96Kur9Q/vig==
X-Google-Smtp-Source: AMsMyM7XQ3fPT/AASLl+d6VGbmkkIx3bJN90gl5vaVl6MNxxuRAq23Djf8sXig0djK2N6NK8C0Yo8A==
X-Received: by 2002:a17:907:1ca2:b0:7ad:e51b:3c7a with SMTP id nb34-20020a1709071ca200b007ade51b3c7amr22957761ejc.665.1667568292866;
        Fri, 04 Nov 2022 06:24:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 6-20020a170906318600b007ae38d837c5sm652979ejy.174.2022.11.04.06.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 06:24:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/13] bisect: v2.30.0 "run" regressions + make it built-in
Date:   Fri,  4 Nov 2022 14:22:37 +0100
Message-Id: <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1452.g710f45c7951
In-Reply-To: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes the regression Lukáš Doktor reported in [1], and also gets
us the full way to a builtin/bisect.c and "git rm git-bisect.sh".

Only 1-4/13 here are needed to fix the "git bisect run <cmd> [...]
--log" regression Lukáš reported, but as Jeff points out we'd still
conflate "--bisect-*" with the user arguments. That's fixed in 11/13
here.

The 1-4/13 here also fixes other but probably more minor "git bisect
run" regressions in v2.30.0, we changed the output in a few ways
without intending it. 4/13 gets us mostly back to v2.29.0 behavior,
5/13 keeps the best of it and the current output.

I think for the v2.30.0 regressions we're better off with just
something like 1-4/13 here for now, and possibly 5/13 too.

But getting to the point of fixing the root cause of "--bisect-*"
being conflated is going to take quite a bit of churn. In the
side-thread Đoàn's diffstat is on the order of 1/2 of the size of this
series, and this gives us built-in "bisect".

The 6-13 here is something I had already for a couple of days, I was
seeing if I could distill Johannes's [2] down to something much
smaller, to just make a beeline towards a built-in bisect.

Johannes's refactors the "term" passing in [3], and Đoàn ends up
needing to do much the same in [4].

Here in 9/13 I instead just extend the OPT_SUBCOMMAND() API so it's
able to accept function callbacks with custom signatures, which
eliminates the need for most of that refactoring. 11/13 then makes use
of it.

1. https://lore.kernel.org/git/1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com/
2. https://lore.kernel.org/git/pull.1132.v6.git.1661885419.gitgitgadget@gmail.com/
3. https://lore.kernel.org/git/92b3b116ef8f879192d9deb94d68b73e29d5dcd6.1661885419.git.gitgitgadget@gmail.com/
4. https://lore.kernel.org/git/081f3f7f9501012404fb9e59ab6d94f632180b53.1667561761.git.congdanhqx@gmail.com/

Johannes Schindelin (3):
  bisect--helper: remove dead --bisect-{next-check,autostart} code
  bisect--helper: make `state` optional
  Turn `git bisect` into a full built-in

Ævar Arnfjörð Bjarmason (10):
  bisect tests: test for v2.30.0 "bisect run" regressions
  bisect: refactor bisect_run() to match CodingGuidelines
  bisect: fix output regressions in v2.30.0
  bisect run: fix "--log" eating regression in v2.30.0
  bisect run: keep some of the post-v2.30.0 output
  bisect test: test exit codes on bad usage
  bisect--helper: emit usage for "git bisect"
  bisect--helper: have all functions take state, argc, argv, prefix
  parse-options API: don't restrict OPT_SUBCOMMAND() to one *_fn  type
  bisect--helper: convert to OPT_SUBCOMMAND_CB()

 Makefile                               |   3 +-
 builtin.h                              |   2 +-
 builtin/{bisect--helper.c => bisect.c} | 250 +++++++++++++------------
 git-bisect.sh                          |  84 ---------
 git.c                                  |   2 +-
 parse-options.c                        |   9 +-
 parse-options.h                        |  31 ++-
 t/t6030-bisect-porcelain.sh            | 109 +++++++++++
 8 files changed, 277 insertions(+), 213 deletions(-)
 rename builtin/{bisect--helper.c => bisect.c} (86%)
 delete mode 100755 git-bisect.sh

-- 
2.38.0.1452.g710f45c7951

