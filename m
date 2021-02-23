Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7371C433E6
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 11:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A558164E3F
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 11:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbhBWLmc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 06:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbhBWLm1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 06:42:27 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C02AC061786
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 03:41:47 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id y17so691134wrs.12
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 03:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gd+kj6OKVZrONr0A25BLXh3pA4Ie/Gz25f12g/IVXt4=;
        b=Yd1ZYnMbX4aBQVHOCLIyhIBNehZ92iX4+pmB9svrXeVrCqq3okCFLqUODnVej3a14d
         aVRZRztSiqV/fSSk4N+VgNwRutvXzVqtgr928sa/KHTGlz+YSMR8xWMbh7d+34pKrmhb
         FI1cxRsc1gYHNRSijF3X1yaO7Cu/LEBc18aWyIzL+V8AtXK/1SS7Fa2o3c4CwAOYqM4o
         2QtGCCa/NbFmKtZ6GMpMJORPCsVltT5d9qdvZx0MCaCtbyIuwNtkBOQOcos+SS86RHBC
         ulQITkJzaQKgtT2UP+Z4ectawc37eb2C988vDHiNmdx3LVjzovpodTCL+gNuU1PkTSb3
         Iquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gd+kj6OKVZrONr0A25BLXh3pA4Ie/Gz25f12g/IVXt4=;
        b=K5uVtXZY1pV5c87KN7bHCarY59bGwkvu5FL+gkgzXysEnHQsbu9wc6UYrN5Rn8nxbU
         RUBSZifgbnj3TAZZoYrZd1cx+TVRDrJHsymQPEAKBQHHDllb2upLOAdJRJ5s2eP3DM37
         akmSS+HMY+e896KB0sCBfpeCtjKuPgA7by22ryNuoka251ZidfvQATEGhL+uajOKKQ/Y
         3RN/Ant7gZqX8FUD3VuhrhDEuw9+rI5GYeVWg/wQHf6lOcounEi5FQES7hR3WldwXjLO
         hXb+QrGEGKM8Y5hJO1iG3WVMYtkQ2oWJ1w2KWNcX57XFMtTEr5ZqkZ69Gfrm+cvV3Nie
         S9nw==
X-Gm-Message-State: AOAM531W/5ilNUeeATAPTBQUBva0MwPrUfIGQiZWZGVaTbDDmrtrKRIv
        RbyDkADEg/Bu3NKrc475mdhALNhh+hpp9Q==
X-Google-Smtp-Source: ABdhPJyRUeksHzGYEQvtLq6a7WWDaiRGxdhL+H+wKNADn8i2iN6AypaIXuX839BWyZ4wezlsAYdwfg==
X-Received: by 2002:adf:8b0d:: with SMTP id n13mr26525109wra.94.1614080506152;
        Tue, 23 Feb 2021 03:41:46 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n9sm2391336wmi.43.2021.02.23.03.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 03:41:45 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/6] Makefile: split up long OBJECTS line
Date:   Tue, 23 Feb 2021 12:41:28 +0100
Message-Id: <20210223114132.24345-3-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210201111715.10200-1-avarab@gmail.com>
References: <20210201111715.10200-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split up the long OBJECTS line into multiple lines using the "+="
assignment we commonly use elsewhere in the Makefile when these lines
get unwieldy.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index c3872f783f1..a5e389c9c36 100644
--- a/Makefile
+++ b/Makefile
@@ -576,6 +576,7 @@ EXTRA_CPPFLAGS =
 FUZZ_OBJS =
 FUZZ_PROGRAMS =
 LIB_OBJS =
+OBJECTS =
 PROGRAM_OBJS =
 PROGRAMS =
 EXCLUDED_PROGRAMS =
@@ -2372,11 +2373,15 @@ XDIFF_OBJS += xdiff/xprepare.o
 XDIFF_OBJS += xdiff/xutils.o
 
 TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
-OBJECTS := $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) \
-	$(XDIFF_OBJS) \
-	$(FUZZ_OBJS) \
-	common-main.o \
-	git.o
+
+OBJECTS += $(LIB_OBJS)
+OBJECTS += $(BUILTIN_OBJS)
+OBJECTS += $(PROGRAM_OBJS)
+OBJECTS += $(TEST_OBJS)
+OBJECTS += $(XDIFF_OBJS)
+OBJECTS += $(FUZZ_OBJS)
+OBJECTS += common-main.o
+OBJECTS += git.o
 ifndef NO_CURL
 	OBJECTS += http.o http-walker.o remote-curl.o
 endif
-- 
2.30.0.284.gd98b1dd5eaa7

