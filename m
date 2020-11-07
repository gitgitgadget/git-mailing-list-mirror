Return-Path: <SRS0=euRE=EN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45906C388F7
	for <git@archiver.kernel.org>; Sat,  7 Nov 2020 23:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD992208E4
	for <git@archiver.kernel.org>; Sat,  7 Nov 2020 23:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyMFNIj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgKGXsR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Nov 2020 18:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgKGXsR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Nov 2020 18:48:17 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DB0C0613CF
        for <git@vger.kernel.org>; Sat,  7 Nov 2020 15:48:16 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id f11so849051lfs.3
        for <git@vger.kernel.org>; Sat, 07 Nov 2020 15:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HxsE2/nQRIRwlWaAVktmNlVmlsB83mkKYf0cCIKAyrI=;
        b=LyMFNIj08mLbelWAeAk7FIsV7uHNOFL2hJVOeKdMl96nYdM7GUpmQ/fM0ftxnUHWmQ
         7B72CYakbSNaCnLitfsTUJNk9EfJBrHX7hHdn83quFnTkwT0/OuqR9ZUDKjYEDd4LaUF
         tITKrvTUAvsZtaHVz0ecmYoAArXrpswGoza5MPY4Sek+hNu2HcGTMEr/gw8UeZ0Bi3MG
         6QjxFE/JnlTZw9Jq6WxrOKObCVHDMMxbpHWBo7Zpfj4DNksoSsgerozxi9vYuuTOYhII
         q6sqowSGeDU0frI5QaP1NtGOG4xwUhT2CK3lkH5mxxqvDyG7qD1NSpPaImPDos4B4pqe
         V1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HxsE2/nQRIRwlWaAVktmNlVmlsB83mkKYf0cCIKAyrI=;
        b=PhEtOSLvUATn95dbNLmJGooFUN0FSEHtXMDn9EpQYZEa07+U42VvR05Efm2rfCCB3G
         JzFugzW3eZhnQzmITtNmlTNldjZBrPySQMLaSS941q4QQPr3k1PjbfhV4CC33QXwxhy+
         N9MyKkajPaMiWDZjFoBdctTknNh+GYunucfXbxQNvxcTzMrJ84njytAspHlMlrIvddH4
         706wrKVBn0aOAPq+4NQU0wgNCZPES7PdpSMeDk7+lNRXz91eD8tsD3qJP/+XD+56WEYG
         bi5ONJ2n1WNkBG85nmErTQci59XO9748PFlxz9uH/7cVVE9c+GW4p2xOdj0lDcZ/Zt3/
         R55w==
X-Gm-Message-State: AOAM5318U5bPPOqjhHQqPpiTs76hGh0vLZr2bMh0nS59nOhyKM1N/mrA
        nSWctjcyJiRDI5tye3VxyIk3As0WqXIn9Q==
X-Google-Smtp-Source: ABdhPJyHtqL6OeLdaSsD6448vuPCNtguleapKSW5JZxd1vx3/OMJe+OcqOL7zsthjNZFBSMvOWgpcA==
X-Received: by 2002:ac2:5449:: with SMTP id d9mr2930706lfn.546.1604792894699;
        Sat, 07 Nov 2020 15:48:14 -0800 (PST)
Received: from desktop.lan.gurney.dev ([185.204.1.184])
        by smtp.gmail.com with ESMTPSA id h30sm858921ljb.58.2020.11.07.15.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 15:48:14 -0800 (PST)
From:   Daniel Gurney <dgurney99@gmail.com>
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, Johannes.Schindelin@gmx.de,
        Daniel Gurney <dgurney99@gmail.com>
Subject: [PATCH] compat/bswap.h: Simplify MSVC endianness detection
Date:   Sun,  8 Nov 2020 01:47:51 +0200
Message-Id: <20201107234751.10661-1-dgurney99@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Modern MSVC or Windows versions don't support big-endian, so it's
unnecessary to consider architectures when using it.

Signed-off-by: Daniel Gurney <dgurney99@gmail.com>
---
 compat/bswap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/bswap.h b/compat/bswap.h
index c0bb744adc..72f225eaa8 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -74,7 +74,7 @@ static inline uint64_t git_bswap64(uint64_t x)
 }
 #endif
 
-#elif defined(_MSC_VER) && (defined(_M_IX86) || defined(_M_X64))
+#elif defined(_MSC_VER)
 
 #include <stdlib.h>
 
-- 
2.29.2

