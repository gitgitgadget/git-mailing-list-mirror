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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA4BC07E95
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEBCF61369
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237159AbhGNAOp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 20:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236998AbhGNAOp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 20:14:45 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C39AC0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:11:53 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n4so458095wms.1
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QwUYSuUDRt2suWLsDuFy05rdX3sX+Meqf2/hbMAsw20=;
        b=Wx3kp94wb7ytqR4PqkOkJvgGIAZzC55A3cDppXK2ceJsjzV9QAnK28PXpQojFp/OZl
         2UKdlMPNdNeSRgMcnYJQbW43/g9Djo4oS4guvhqyabXPPbJlpYc4TXKOaQoXkJjscuFj
         faup+jajGUIppW9RiYbTL6DnnF0/QC55iDWqN3AF+cmFhxGuTfIXb3Ggsg+eT+MODTTG
         x9iByOzcq6rWsvJK0rlep+EWkRRu9PobTr+7NJIoG+JGb5t3Gv12jUJIT0Vcc78Ci8Ku
         bLWBJcOZB99rSZNzts1HmCQpOIlM2q5S7IL9ogJtT7LXxJru+FXGZJKIydUDV9ikBCM0
         xAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QwUYSuUDRt2suWLsDuFy05rdX3sX+Meqf2/hbMAsw20=;
        b=cOpWpC+qvvvkiY/gj2yKXBubDeTlpyTjKop6Hq3OsUM8QYaNc0jLvpTOcXMjpPQASE
         FwypmtHBWgO6GMp7DPeVBET3L6Rp9RLpUJMW9pee9cJ2gmmriu2UrlQPJkIq7Yvuu276
         Q8sCtTiBajf99kPHrjvW0Jt1cuz9LQSNtE8Py69GzUCeCfZJBDlFSUrW1nNovCKNY0Oe
         xVre2xyR4WXTc9U6yrKgstRSoTv1Gob0t7y1EcJg/YcHC6t1vgECw9H/TeJmki2lEVFo
         XTBiXIadidRsbUT3Ps7rsPJxoO854eIFtJuNu9U3B0Mkbq+AQCY/1dMnJWhamVpxanYR
         Sdww==
X-Gm-Message-State: AOAM533wrvV5GtMKqgIsz0VIfIOlDJEv5b23dVTlyMxXfsvHb+rGyXUL
        tnGQ3pjbqGS41wKTvkC4VNZTsOVp3L0YIv0n
X-Google-Smtp-Source: ABdhPJyA3FWPbCdIZBnhHkw67R6M3j6Y+CtMBDaVKYRaDmGLzZt06Y4JbBn7A6/tkFjqTLX4oPVd7Q==
X-Received: by 2002:a05:600c:2058:: with SMTP id p24mr7832370wmg.76.1626221512018;
        Tue, 13 Jul 2021 17:11:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x1sm442382wmc.31.2021.07.13.17.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 17:11:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/4] add a test mode for SANITIZE=leak, run it in CI
Date:   Wed, 14 Jul 2021 02:11:45 +0200
Message-Id: <cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0-dev
In-Reply-To: <87czsv2idy.fsf@evledraar.gmail.com>
References: <87czsv2idy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a follow-up to my recent thread asking if we had some test mode or
CI to test for memory leak regression (we don't), add such a test
mode, and run it in CI.

Currently the two new CI targets take ~2-3 minutes to run in GitHub
CI, whereas the normal test targets take 20-30 minutes. The tests run
slower, but we have a small whitelist of test scripts that are OK.

1. https://lore.kernel.org/git/87czsv2idy.fsf@evledraar.gmail.com/

Ævar Arnfjörð Bjarmason (4):
  tests: add a test mode for SANITIZE=leak, run it in CI
  SANITIZE tests: fix memory leaks in t13*config*, add to whitelist
  SANITIZE tests: fix memory leaks in t5701*, add to whitelist
  SANITIZE tests: fix leak in mailmap.c

 .github/workflows/main.yml  |  6 ++++
 Makefile                    |  5 +++
 ci/install-dependencies.sh  |  4 +--
 ci/lib.sh                   | 18 ++++++++---
 ci/run-build-and-tests.sh   |  4 +--
 config.c                    | 17 ++++++++---
 mailmap.c                   |  2 ++
 protocol-caps.c             |  5 +--
 t/README                    | 16 ++++++++++
 t/t0500-progress-display.sh |  3 +-
 t/t1300-config.sh           | 16 ++++++----
 t/t4203-mailmap.sh          |  6 ++++
 t/t5701-git-serve.sh        |  3 +-
 t/test-lib.sh               | 61 +++++++++++++++++++++++++++++++++++++
 14 files changed, 142 insertions(+), 24 deletions(-)

-- 
2.32.0-dev

