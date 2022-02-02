Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DC1C433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 21:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbiBBVEF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 16:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiBBVEE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 16:04:04 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9B0C061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 13:04:04 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id g18so548802wrb.6
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 13:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v7vYFZU+A1HIPLmNPKAENI8rGDv/sAgHM/T/9+0SXcA=;
        b=CZzrSZajh34im/UGMT0Uc1Ix5+ltIgxgR5ZQcLFN5RV0HlNNUhmID1WexTQZLdkIjd
         5pw5LyXGs9f5VUbPj2ewSUOmbsepnp/fVTP9eMq1NzZpw/ZwHW815Fps3oigMz87Nlwn
         X+3oCHN47T2i65W2ViULyI+eOIc81sUY6vdtPyzaQ4NOqc/GaOLxJn/d0fy1piJiUL+w
         Xvl16yLiZDfRbuHYOTcaisd06pj7g5AMXnBkfQWiFHCbgvXDJBOfA+P/PtuDy6Q8JAjO
         3aCunFXFL/tCg3QcI8czhJ2+pXtSTABXA/5+a83xPzkC6DeVE3Qnmf0SPIINWsa9/R+O
         q32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v7vYFZU+A1HIPLmNPKAENI8rGDv/sAgHM/T/9+0SXcA=;
        b=qRF6YKgQFRZevdURNHzTV3A22ydTPydLbLrEaoCgcVI2ij8X6vMFIIQXbxRwGZQlRE
         iXHgStFgy2DeSsS3hMKbNIZhIaUoDuU398j6FGf9j5gnUQTufC286jmCt+xNAmKCXWBK
         wEQn8cEQZH9BfSx3LtPy5HzhGCfy2qbAg4cSTnvfezY3ZRLezEutRG4GlppStI7pvuwW
         IRYqpOVCJ/1LHzHHj+EM6RA9jsC+c6ovshg4n5l03tN4mFQqcvy8cbOXf7/7fL4xZV9n
         nRRii+/GSQl6wP+yOl7yR6VI6UITrdVJIg5UBfO+tz4aYTY54KwBJn8ufgebehdNCMAc
         KIdw==
X-Gm-Message-State: AOAM530nCFZLNyPmqPq3TLFC4uXiySn+pp1mkTD/GnOtj3iFNqqrVIrR
        IE1t1BDEa3KO9tnKby8C/C9iOLUvO98EpQ==
X-Google-Smtp-Source: ABdhPJzEKeqE/kYhQSHOVEPWxMJkpBSRPXIu/fcEKLqfs49SnPZQD+7V6/IhbAXAP1UK2pojB1F0OQ==
X-Received: by 2002:adf:e34c:: with SMTP id n12mr26899777wrj.263.1643835842737;
        Wed, 02 Feb 2022 13:04:02 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l11sm17264592wry.50.2022.02.02.13.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 13:04:02 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/5] date.[ch] API: split from cache.h, add API docs, stop leaking memory
Date:   Wed,  2 Feb 2022 22:03:48 +0100
Message-Id: <cover-0.5-00000000000-20220202T195651Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.920.g34be1f84792
In-Reply-To: <YZQHEiFnOdyxYX5t@coredump.intra.peff.net>
References: <YZQHEiFnOdyxYX5t@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a follow-up to a much smaller patch[1] discussed in November
to make t0006-date.sh pass with SANITIZE=leak.

In reply Jeff King pointed out that reaching into its private guts in
the test helper felt ugly[2].

So this series pursues a more thorough approach, creating a date.h,
moving our date functions there out of cache.h, documenting the core
functions, and finally adding and using a date_mode_release()
function.

It's definitely taking the long way around, but I think that the end
result is worth it. I then have a follow-up series to plug memory
leaks in revision.h, which will make use of this new API.

1. https://lore.kernel.org/git/patch-1.1-15f5bd3e4f4-20211116T183025Z-avarab@gmail.com/
2. https://lore.kernel.org/git/YZQHEiFnOdyxYX5t@coredump.intra.peff.net/

Ævar Arnfjörð Bjarmason (5):
  cache.h: remove always unused show_date_human() declaration
  date API: create a date.h, split from cache.h
  date API: provide and use a DATE_MODE_INIT
  date API: add basic API docs
  date API: add and use a date_mode_release()

 archive-zip.c         |  1 +
 builtin/am.c          |  1 +
 builtin/commit.c      |  1 +
 builtin/fast-import.c |  1 +
 builtin/show-branch.c |  1 +
 builtin/tag.c         |  1 +
 cache.h               | 50 -----------------------------
 config.c              |  1 +
 date.c                |  9 ++++--
 date.h                | 73 +++++++++++++++++++++++++++++++++++++++++++
 http-backend.c        |  1 +
 ident.c               |  1 +
 object-name.c         |  1 +
 pretty.h              | 10 ++++++
 ref-filter.c          |  3 +-
 refs.c                |  1 +
 strbuf.c              |  1 +
 t/helper/test-date.c  |  5 ++-
 t/t0006-date.sh       |  2 ++
 19 files changed, 110 insertions(+), 54 deletions(-)
 create mode 100644 date.h

-- 
2.35.0.913.g12b4baa2536

