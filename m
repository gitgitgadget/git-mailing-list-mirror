Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874D3CD37B0
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 17:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjIRR7t (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 13:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjIRR7s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 13:59:48 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E0E102
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 10:59:41 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-401da71b83cso54569385e9.2
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 10:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695059979; x=1695664779; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Txbj22rs5Mxs5ocx1d7lJCvgSY1TIEUA9ezXzvCOWtM=;
        b=T9vHln42VifAkgYCy4JfpPM8FQl6HKLQFO6mWQdY7L852T3R6PSw2/8hQqys71Oy/D
         kC3PTu7qeEACzTJX/iYp9ysynoSic6doiQFoTpGJI/xsAhSX2SIf9iwzE1tCpU6vIj+d
         3w/OyawvRYfDufLyLTJm37lCzO/hGwHcMT6PZhSBFbeqsZoKAtMekmvfrBALhKjB1Xmv
         FC8dlcGauB4XaclNPO3tWFeTL9IwZ4jygfONZQjlJrvHI5VeriT6Kn0sJwxCvIvpTTAC
         LqtsG3W2OIKWI77hDPCeI5O8hTOJzrc8r/cRatIR4fc/QLDz0py7sigQm0dq/FblcQvM
         9Lkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695059979; x=1695664779;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Txbj22rs5Mxs5ocx1d7lJCvgSY1TIEUA9ezXzvCOWtM=;
        b=bvFBhEXjgu55PrOsU6rbueTvat68rD1/oSi9+uIalI3KZzsrAXIemyHHT2agpmzQ7m
         o+QjYjSjWvxBLHUPDv8C2mWDToVCaOAvCjKsmOPxUswvEmBaR7UZ11v6bhTdptf+HSp0
         M/itYWmSlr7cwlZhd1F20TdKnSKAo+buYYBYNANppq860RpSW/ZZOMo90d22su/UOoxc
         Ll5tx8RZOcQtbaNJuO/TnFYOQnIsrvLALo1QsKOnyvNZWxeRpPPvfS8MT1gVxiOxZ7eJ
         pcQl2MtQV7y/eqWgIl91VmQh1najHp8N+u4KQXo79deQOhqtTZAszzLdlPYmmbNgE4D6
         HhIA==
X-Gm-Message-State: AOJu0YyMWi6Ui7Hz2XyLsjY1lssFeFHWAaTdOYI3VWUsSI0PnSmEQIwu
        U0DfXlDMjkOR3YZ2tm+2WpSwqTg1dTc=
X-Google-Smtp-Source: AGHT+IGRYBmzPb/83tlM1kGyaCOjMApNQ43JJ8B/bzkQ/jYD1XDVx1C7pWY8fFYhofElckhZTC6b3w==
X-Received: by 2002:a05:600c:cc:b0:401:c52c:5ed9 with SMTP id u12-20020a05600c00cc00b00401c52c5ed9mr7980730wmm.32.1695059979302;
        Mon, 18 Sep 2023 10:59:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o16-20020a05600c379000b00401e32b25adsm13219934wmr.4.2023.09.18.10.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 10:59:38 -0700 (PDT)
Message-ID: <pull.1574.git.git.1695059978.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 18 Sep 2023 17:59:35 +0000
Subject: [PATCH 0/3] Simple reftable backend
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series comes from a conversation with Patrick Steinhardt at Gitlab, who
have an interest in a more scalable ref storage system.

I unfortunately don't have business reasons to spend much time on this
project anymore, and the original, sweeping migration has too many open
questions.

I thought of an alternate approach, and I wanted to show it as input to
discussions at the contributor summit.

I think the first part ("refs: push lock management into packed backend") is
a good improvement overall, and could be landed separately without much
tweaking.

The second part ("refs: alternate reftable ref backend implementation") is
something open for discussion: the alternative "packed storage" is based on
reftable, but it could conceivably be a different type of database/file
format too. I think it's attractive to use reftable here, because over time
more data (symrefs, reflog) could be moved into reftable.

Han-Wen Nienhuys (3):
  refs: push lock management into packed backend
  refs: move is_packed_transaction_needed out of packed-backend.c
  refs: alternate reftable ref backend implementation

 Makefile                        |    1 +
 config.mak.uname                |    2 +-
 contrib/workdir/git-new-workdir |    2 +-
 refs.c                          |    8 +
 refs/debug.c                    |   15 +
 refs/files-backend.c            |  182 +++-
 refs/packed-backend.c           |  150 +--
 refs/packed-backend.h           |   19 -
 refs/refs-internal.h            |    6 +
 refs/reftable-backend.c         | 1745 +++++++++++++++++++++++++++++++
 refs/reftable-backend.h         |    8 +
 11 files changed, 1941 insertions(+), 197 deletions(-)
 create mode 100644 refs/reftable-backend.c
 create mode 100644 refs/reftable-backend.h


base-commit: bda494f4043963b9ec9a1ecd4b19b7d1cd9a0518
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1574%2Fhanwen%2Fsimple-reftable-backend-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1574/hanwen/simple-reftable-backend-v1
Pull-Request: https://github.com/git/git/pull/1574
-- 
gitgitgadget
