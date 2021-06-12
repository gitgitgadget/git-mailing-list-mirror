Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651A3C48BCF
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 04:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 444B5611CD
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 04:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhFLEaL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Jun 2021 00:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhFLEaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jun 2021 00:30:09 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BC3C061574
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 21:28:10 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id l1so4085700pgm.1
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 21:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sy6Lv3fjil+HgmXmCYHjpjNOuDIEeStgw3tgDkh8ttw=;
        b=Cbw8yMuB1qghXcR1vsSf1pLRZ04TLhkzd/rTMvg+LZKn7anScjjQqOnUwYjzy3soyo
         oX6JcQ/RT/2Wm4l0eiD3bzPrMnT9jR5SPr25soRxMYJdx9bzcrMBD0CPebQpHMJrmzQa
         /zhsdEoUhaAoeYUheLri8e5x36D0onujSFg2ske8FYYLiRpAe3BVf+O3T5exzPWJ7KEV
         FuMhWW6ebp7LVYPeZu/Mq6VgZFyCrP6hWmcprhH/aTGGOZhqFkEZHj6/KJH3c9rRRyoi
         1L1qIVNuazcwzZBVDTj9gIO5kXVXxdqseeBmlX0oCUblABLgjmpCseC2ifONjxnxGJZD
         tcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sy6Lv3fjil+HgmXmCYHjpjNOuDIEeStgw3tgDkh8ttw=;
        b=pYpVJAGu8Nzt0vc6czeevPBwk0qlioMDIgCRwZKKpPc8Vc25duVZloOy5JHQYAwAeE
         9Wt2jL+1+7zFiwEWySzdomBkqxA4irlRbqLXKDVsP+FzpgxEoZUKhPWUZltMzFX5THA9
         3jPtZMCHBEPLdVIBj4ULJaV5579ttOAuoxELD+5Xutm16ddoS+VKaGtbLlzkc5VONDyB
         C8tDPqDqjjbSqr1y5zCK/aXeb0dDgdwzErNbBmrPMPIcf4YVmMZqVsOVAnXxvXw5UOy7
         4R6s1KBXriz239hdlyfXymYGCXBQ0QAY3fysRf2VfiaoGhJjKcB5ydS2CfNHUwiXDnwD
         IW8g==
X-Gm-Message-State: AOAM533v+qmbaBL0NJwspJ9UTS6rVk/97ikjrVOOEKpNn1m3OxGFPClZ
        m4mGOEB2cQgtUeiMNzJjT9j07gUetP23ZQ==
X-Google-Smtp-Source: ABdhPJxyt+nN9L7FxTIcVh3bKykc0z1kiiA3TRjYEs2zrG+weIzpJ8aFUZWwvCkxKEPRmWRQBo+ysA==
X-Received: by 2002:a63:d709:: with SMTP id d9mr6882956pgg.337.1623472089503;
        Fri, 11 Jun 2021 21:28:09 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:97c0:59aa:7727:6cb5:cccf])
        by smtp.gmail.com with ESMTPSA id w19sm11272539pjg.48.2021.06.11.21.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 21:28:08 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] t: new helper test_line_count_cmd
Date:   Sat, 12 Jun 2021 11:27:51 +0700
Message-Id: <20210612042755.28342-1-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.32.0.278.gd42b80f139
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a rewrite of a series I sent earlier [1].
Which was a response to a false positive when applying Junio's suggestion
to a series written by Ævar [2].

1: https://lore.kernel.org/git/20210421104102.3409-1-congdanhqx@gmail.com/
2: https://lore.kernel.org/git/87r1j42ffz.fsf@evledraar.gmail.com/

Đoàn Trần Công Danh (4):
  test-lib-functions: introduce test_line_count_cmd
  t6402: use find(1) builtin to filter instead of grep
  t6400: use test_line_count_cmd to count # of lines in stdout
  t6402: use test_line_count_cmd to count # of lines in stdout

 t/t6400-merge-df.sh     |  16 ++---
 t/t6402-merge-rename.sh | 132 +++++++++++++++++++---------------------
 t/test-lib-functions.sh |  64 +++++++++++++++++++
 3 files changed, 134 insertions(+), 78 deletions(-)

-- 
2.32.0.278.gd42b80f139

