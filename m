Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCB1C4742C
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 08:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 718CC206F1
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 08:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yp6uN/Ru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgKKIdQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 03:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbgKKIdA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 03:33:00 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24088C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 00:32:59 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id b17so1090018ljf.12
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 00:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=51XolWnjdOj8cAvuWElLh6KDrB1fY+t/yzjxscHVqzM=;
        b=Yp6uN/RufdBHIJ9osyQHgv2tRJ52nRRkL5l4pbufmX4rAHNcEXZslI/al0vlRIhEfN
         2fN+MXLJgnPGD4LPXb7oiWnFO8R55/P50N4Y+qLptX3SNG5+4X4Yu4kcM3pfm+mU0rkT
         3ZM3x+kHDnrZ3d1Q/Dw4XTb34/1RxNRYWdYda50yMChLRYk7RN6u9TVpo8bsGdC9WrMX
         Uqa9sMz1/Eit7su1Hz8ne3Y0BezpPCgfZpBKNGCR9q0B/AuPMUY8rdAppYttLmPnI28H
         bY65GoFf9ORe7N+b2RBXYkI/GqfQaFpLJycU4/NKZuPu95ByMC4al09D7c33QSwefACH
         /5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=51XolWnjdOj8cAvuWElLh6KDrB1fY+t/yzjxscHVqzM=;
        b=HW6/RROrml41ES1HE89aMNYhs2pP2d0ijy4ATmtUFHqH5phfxLC1rWz7DGTmjna0y/
         b1oIQeXe9giL1Pwb2O296ixDwPPM1QVgtrdKI5BQgS3rKr4d36G5zuQclIUpM3v26P8X
         ft5Cz/sY6zFgvQLoGkM2y2SJanIo/PkCiYjGgniQqGYyZ5o9pKVr+a03D6QBT//Xt2hQ
         xvMrN32iNKQYJBVJ7m3DuF9xXbTInuQyCF3sxSsXIW5FxYHasgHit0mErOrqYXnqNVBn
         zdH6K1iD69TayqJGM4gDKgJAJsEpBw002LDN57L2M4Bg98zcdjxM5/l2wga9DRHiX1vu
         gvJA==
X-Gm-Message-State: AOAM531MlFz8L6H478/N6h9SHCyLAU7XnVPbu1NuV36Ask+PCtLPEFBE
        q0mw19BCV2/fLuyL+FD1qyIv5JzaRBAX6Q==
X-Google-Smtp-Source: ABdhPJwr8c5Fas/u/uxUFtwBR8vGRIEwkwEaps2FtjMDgLUSvheh4zKWX9djNRLGjP2jFmiuxTaDSw==
X-Received: by 2002:a2e:165c:: with SMTP id 28mr9480441ljw.355.1605083577062;
        Wed, 11 Nov 2020 00:32:57 -0800 (PST)
Received: from desktop.lan.gurney.dev ([185.204.1.184])
        by smtp.gmail.com with ESMTPSA id x8sm150744lff.196.2020.11.11.00.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 00:32:56 -0800 (PST)
From:   Daniel Gurney <dgurney99@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, Daniel Gurney <dgurney99@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] compat/bswap.h: don't assume MSVC is little-endian
Date:   Wed, 11 Nov 2020 10:32:27 +0200
Message-Id: <20201111083227.605518-1-dgurney99@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 1af265f0 (compat/bswap.h: simplify MSVC endianness
detection, 2020-11-08) we attempted to simplify code by assuming MSVC
builds will be for little-endian machines, since only unusably old
versions of MSVC supported big-endian MIPS and m68k architectures.

However, it's possible that MSVC could be ported to build for a
big-endian architecture again, so the simplification wasn't as
future-proof as hoped.

So let's go back to the old way of detecting MSVC, and then checking
architecture from a list of little-endian architecture macros.

Note that MSVC does not treat ARM64 as bi-endian, so we can safely treat
it as little-endian.

Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
Helped-by: Jeff King <peff@peff.net>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Daniel Gurney <dgurney99@gmail.com>
---
 compat/bswap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/bswap.h b/compat/bswap.h
index 72f225eaa8..512f6f4b99 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -74,7 +74,7 @@ static inline uint64_t git_bswap64(uint64_t x)
 }
 #endif
 
-#elif defined(_MSC_VER)
+#elif defined(_MSC_VER) && (defined(_M_IX86) || defined(_M_X64) || defined(_M_ARM64))
 
 #include <stdlib.h>
 
-- 
2.29.2

