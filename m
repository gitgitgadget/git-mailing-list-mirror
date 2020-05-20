Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D1FC433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 17:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D5B6207D4
	for <git@archiver.kernel.org>; Wed, 20 May 2020 17:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUKUGRGe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgETRgQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 13:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETRgP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 13:36:15 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DD2C061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 10:36:15 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f134so3291345wmf.1
        for <git@vger.kernel.org>; Wed, 20 May 2020 10:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=F4BWtYV0F/T7vyZJCf6dqXENhU89ZX/bTnVFMDgyqZY=;
        b=fUKUGRGe0BbD3Y86PmA4CMQoN31ydRB94f8AkdNHIbydGgoapJJxgqCK6J4cWASHw+
         HpUpZiaeS49NF2xphlc9ryzq3jyW38gpiyBc1YHq3WIWONSKV3GaP/3mBIj2ImoDbtxb
         UqMqxV5/CJJdpzIwMiUBe7nASxXcYdfYXKgZVOQp5tDtdr8k24x5b+09CPWlbUDU0f8y
         ALXQDdMAZS7bX/NdEnNn8YYUmI4MyoIPBx9aOeIZ2XP2Fx4UwfPUHB8xJ0NhdPjgof4l
         9Tz0Xg40Orlgd2ITaNQ5r127tJPVFrvzctIRaizquhZXtD2a8lcvCjfiehAsExITD2MH
         USNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=F4BWtYV0F/T7vyZJCf6dqXENhU89ZX/bTnVFMDgyqZY=;
        b=Gjpg3O0pKJXwcCxpz+WbwGld4tC2/97UyIfEMuTGfJQjeCbypEuKLUXmYbmJdN8fI0
         oPatOJSorz4jXRJ7ajSiAytLUdz6IxNEGrjDJjICzNPyKNAR9kzsztE6quqS7TP92YJ2
         djOAru0WI9rzTg60ETeo9qbLYksFm7XsdmhOOIfqJfJxjpd0+iogprV9ZfDe/z/aCdlz
         XBzazNoRsXaS9dzmX0H21rHZvSmEcoIfzRBdvLZfpEuQkIzZmUSNI0Xd67DZnvPUj+bE
         yZUuEk/PSdGkeeyAdsiCd2qMbeM7/KVQcRWeTBvVWKk3AI4EgqPxHEn3pctxOs6upoBI
         I/Rg==
X-Gm-Message-State: AOAM531Ur9kzjtLhbci5VWo+20o7O7WhIQnOk+LhKGKscMIPTvmWVwV7
        qtxvIbSvEeP9qCqfEOHhakMixlj/
X-Google-Smtp-Source: ABdhPJxBDuHqYVazGnftMWTwCnD0E1yIs+awICjZG7iDRIsuwOw/DNhXTXIfljo7aSx3fX8t9bxUqg==
X-Received: by 2002:a1c:e157:: with SMTP id y84mr5399258wmg.15.1589996174023;
        Wed, 20 May 2020 10:36:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o15sm3439610wrw.65.2020.05.20.10.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 10:36:13 -0700 (PDT)
Message-Id: <pull.638.git.1589996173.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 May 2020 17:36:06 +0000
Subject: [PATCH 0/6] Refs cleanup
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series contains preliminary cleanups for adding reftable support
to git-core

Han-Wen Nienhuys (5):
  refs.h: clarify reflog iteration order
  t: use update-ref and show-ref to reading/writing refs
  refs: improve documentation for ref iterator
  reftable: clarify how empty tables should be written
  reftable: define version 2 of the spec to accomodate SHA256

Jonathan Nieder (1):
  reftable: file format documentation

 Documentation/Makefile               |    1 +
 Documentation/technical/reftable.txt | 1083 ++++++++++++++++++++++++++
 refs.h                               |   18 +-
 refs/refs-internal.h                 |   18 +-
 t/t0002-gitfile.sh                   |    2 +-
 t/t1400-update-ref.sh                |   32 +-
 t/t1506-rev-parse-diagnosis.sh       |    2 +-
 t/t6050-replace.sh                   |    2 +-
 t/t9020-remote-svn.sh                |    4 +-
 9 files changed, 1137 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/technical/reftable.txt


base-commit: b34789c0b0d3b137f0bb516b417bd8d75e0cb306
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-638%2Fhanwen%2Frefs-cleanup-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-638/hanwen/refs-cleanup-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/638
-- 
gitgitgadget
