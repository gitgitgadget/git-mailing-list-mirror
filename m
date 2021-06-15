Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86371C48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 16:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C2736162E
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 16:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhFOQUf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 12:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhFOQUd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 12:20:33 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48254C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 09:18:28 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q5so19014562wrm.1
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 09:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RYMeQBlG2H5I8KiJQB0P8En2VSxDdGKgPNb/60wZu5Y=;
        b=RQKu4fGO8QuQym3hdlTPWAU9kqG1EsUh3Sacjt2ZUyFMlr3ua33c1At/xLLvx/MTJv
         YBwK1DQsJdGKLaDB22/ve85CBOQXwT9uTi1LanM/tH65DNJxBL/LdttN+DGpRa19AuA4
         xBHxMYF/JV+x2i2ckA037/X9d03J2y9hkcPK8wLthqOubqNM3SbWzWmJgXf+EMMz213V
         5ejPHQWI+cGk1Ra58r4On2BVPkZEfhhuCxrQ4NRZzhIkjU3SGiMBSKme2nbHQ5pbuM+9
         kYwWT9UrRctpDodso68ckVVcb966Sqc8bSSxOP9nrfHaxxg1MyHMFxCU7A03cOmrQDZY
         2nOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RYMeQBlG2H5I8KiJQB0P8En2VSxDdGKgPNb/60wZu5Y=;
        b=BoBGdQYvUkEI/qSXNUCqRn2xWmqTwu10wHw6L0HjamSaIA6KZLrZ724MSXbORure5l
         YIZHTWzUv1g0W28tccoy90D4kNuJmO/mnb69ARdVXb1bCufECQNnO6rPceGPlllh8ppv
         zEljWij/EY2KYq4gVj2xc/atsgg5iziyM36s1GnPQA5tFVaLEftX0vKX24k5jq2vk+HX
         VfG0pcHYRizpDVMthRS0AFBOAoYM3I0w+1VNei+339x5hMFD4NF/8zAe1S20PJ4QXAVw
         LpntUq4+ZFxyeqmw01VXts8x2f0vFFMHv1BmYIMxyevi2dxVq52bzedkgTiIlATC2T03
         s8gQ==
X-Gm-Message-State: AOAM532orskvLb6JzRIT0fbPxgpqDwtLMoicg+YmxTPb+GK8EiHRHwGa
        2afMcafW8rSDT7X77jXT8NAHjQ4bc7pvvA==
X-Google-Smtp-Source: ABdhPJz7waoYLTm2PvHmrQ9cDUkpJpf2FAN/Y1zzA1ZCmLnu3R4vu9wGpSuzUpRSiNZnVb6R5N0s3A==
X-Received: by 2002:adf:d1ec:: with SMTP id g12mr26571782wrd.204.1623773906550;
        Tue, 15 Jun 2021 09:18:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b8sm2671901wmd.35.2021.06.15.09.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 09:18:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/6] doc: replace "alice" and "bob" examples
Date:   Tue, 15 Jun 2021 18:17:57 +0200
Message-Id: <cover-0.6-00000000000-20210615T161330Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.555.g0268d380f7b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I suggested in [1] that the "alice" and "bob" examples in our
documentation would be better written without a reference to such
fictional characters, for reasons that have nothing to do with trying
to bend over backwards to avoid any reference to people's gender. It
just makes for better documentation.

Since it's clear that Derrick's not interested in picking up that task
in his parallel series[2] here a brief series to implement that. This
leaves the only occurances of "alice" and "bob" (and "david" and
"cindy") at the bottom of giteveryday(7). Those could also be changed,
but I didn't think doing so provided a clear benefit, unlike the
changes being made here.

1. https://lore.kernel.org/git/875yyp4fun.fsf@evledraar.gmail.com/
2. pull.975.v3.git.1623766273.gitgitgadget@gmail.com

Ævar Arnfjörð Bjarmason (6):
  gittutorial doc: replace "alice" and "bob" with "you" and "www-data"
  gitcvs-migration doc: replace "alice" and "bob" with "you" and
    "www-data"
  daemon doc + code comments: reword "alice" example
  fast-import doc: change "bob" in an example to "file.txt"
  doc: replace "alice" and "bob" with "jdoe" and "msmith"
  pack-protocol doc: use "www-data" in place of "alice"

 Documentation/git-credential.txt          |   2 +-
 Documentation/git-daemon.txt              |  13 ++-
 Documentation/git-fast-import.txt         |  14 ++-
 Documentation/git-imap-send.txt           |   4 +-
 Documentation/git-interpret-trailers.txt  |  22 ++--
 Documentation/gitcvs-migration.txt        |  18 +--
 Documentation/gittutorial.txt             | 128 +++++++++++-----------
 Documentation/technical/pack-protocol.txt |   4 +-
 daemon.c                                  |  10 +-
 9 files changed, 112 insertions(+), 103 deletions(-)

-- 
2.32.0.555.g0268d380f7b

