Return-Path: <SRS0=1y/A=EO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B86C388F2
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 10:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC87E206ED
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 10:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4FR8dTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgKHKC6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 05:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgKHKC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 05:02:58 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC65DC0613CF
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 02:02:57 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id f9so8035318lfq.2
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 02:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E2b7dmEIo3PULSS7qmN00VrqKHOK4fFjwLl34F+9EbY=;
        b=e4FR8dTdyzXhAEDjGWeGI3Vg1D9Ef8K72oQ96lqXt4D7Dt47QZwJGTIrOD2YPGRwhv
         tchu0vAQ8xGVSy+JgF6LMFk0K7RzIGPsLvA0kwrC/0tUnwEavFxtN+PSkvdNBgK8JBik
         qI4m0HZuEQU8Hd8CzTXve0xY7vnldsx3NPDcdA2a1JS+ohZ7g/oF+FXaVLPLe12muLBn
         hez/FO3iredLpVYnFhkUQMvo6ZhTPwdkC4EmqQY01OjhYrEwXP7h8azmFkjP480oNAJX
         DZSCpva8LcjhqhoydtSa4f1Jrar9cfw9AeSq/3rd30ysP7DS08l/bMcoo9j4JkRVTHDk
         vv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E2b7dmEIo3PULSS7qmN00VrqKHOK4fFjwLl34F+9EbY=;
        b=RsdNUVKQIPj3UJ9f0il1rdQ0p5BmlXMjD7ixEHuIDtI3nCQaLoAV72RMi/eRZVDnSV
         WDsz91lHM5Nza09zNKs24FULvpdyyIOHGMk85EBLzf+0CegywL+iYBhCAJx70FkTmuTh
         6j4F5XIidq0MFjwewIf91w+s8yzFkUryMcOLTze6LVLKYNmIDIm0V4iqGCcTsVPBnc8I
         erlTW0NZ9bllFL1bEn1MmXO6ii7hpIiEJTdaEwo83xUt2beAd5iCeHN3AtJRf49m8DjL
         rUI7JAfwuVeo1wcWv3kLbxr2mEPOjWqijDesBlkr4nMC691K1opUAlaHV+wvdABcnlZZ
         81bw==
X-Gm-Message-State: AOAM532lLEXCe3QvTUOsIDtb4OUIiOW5Qu4ToKIdTPTarCW2wtsWMT3j
        Qzzy4Wtfc7EqPIn4Crw+mdnllXZ0asHfeA==
X-Google-Smtp-Source: ABdhPJwk/JLRJfFhpPqVzt0y//FmX6uuG8ZKpDdVifGlFiQ7C0baZpXJRoMg0/YDOdRAucIQYi28AA==
X-Received: by 2002:ac2:44b6:: with SMTP id c22mr4135784lfm.513.1604829775886;
        Sun, 08 Nov 2020 02:02:55 -0800 (PST)
Received: from desktop.lan.gurney.dev ([185.204.1.184])
        by smtp.gmail.com with ESMTPSA id m2sm1142394lfo.194.2020.11.08.02.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 02:02:55 -0800 (PST)
From:   Daniel Gurney <dgurney99@gmail.com>
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, Johannes.Schindelin@gmx.de,
        Daniel Gurney <dgurney99@gmail.com>
Subject: [PATCH v2] compat/bswap.h: simplify MSVC endianness detection
Date:   Sun,  8 Nov 2020 11:57:41 +0200
Message-Id: <20201108095739.23144-1-dgurney99@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201107234751.10661-1-dgurney99@gmail.com>
References: <20201107234751.10661-1-dgurney99@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Modern MSVC or Windows versions don't support big-endian, so it's
unnecessary to consider architectures when using it.

This also makes ARM64 MSVC builds succeed.

Signed-off-by: Daniel Gurney <dgurney99@gmail.com>
---
v2: just edited the commit message as suggested by Brian.

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

