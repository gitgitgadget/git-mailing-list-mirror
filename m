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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C74EC433F5
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3BD5610D2
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350185AbhICREE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 13:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350182AbhICRED (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 13:04:03 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1EDC061575
        for <git@vger.kernel.org>; Fri,  3 Sep 2021 10:03:03 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id u25so10361oiv.5
        for <git@vger.kernel.org>; Fri, 03 Sep 2021 10:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZAHO3vGxJfSdFkOV9A9rHwEV7DBtxf3V23sUlegXtcc=;
        b=lrjcWNgGIm8JPLa8LQlDF4UAsURTvVzTC9YVGmLLIYrwP2osnuYL//n4GEK6s5jj6e
         QM7I4pSDfo/yMCkG37r9CV/VNeOyq0kGC63Wp91xEOdHpV0B9fXUxDBLTgeIaTDBFZTh
         RRUzYr1dEGcUsY1hq+urZzUv50YoV1N8RcHRO/ZUJ7P7wu2V3P/T7rRsci//xfFz8q4T
         XMlAQsd39ldqcUwXy7jarUqp9UiiYRYTCWs235M2pgeFEbLusbXmYO4SKXowlHqF5nUC
         i02drwqvLw/GPEg19d7qcQ0l+8ztHQ+BP7vFx1QWDrxvyxOZcrPwGsfp1sUNcGLniktB
         Vxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZAHO3vGxJfSdFkOV9A9rHwEV7DBtxf3V23sUlegXtcc=;
        b=rQ36cNRjQp55YyNmFPr7p01IW2J5VnNkOTnF2WmuERdKBcVyklxRVQs92XaIHvUeEJ
         +Tblz+KnG7yvPhpb1ym1h4dXvCtXF896o2GTSjJx1EhqOO+TFoXYpBgUBLl+/8uFB8fI
         260aJwB7kf+Lxzi+MV2gncCUHfZoYlL8FIlC0A+Lvw+fcIj5aVVhcNlsxd17ou2eKx9T
         WWkz/esRruf2TQ/pXM+VqnY8gNFtSitG3ZUVt+/3SH20V83en27/GGv1CWnQjkSxvS2v
         Zj9kHnb1lVwfvy9sAWB+ytRZhZhxgV6uewPbxmHBUyOR1bwNtpXdgneh1auJxdd2xBvn
         z6JA==
X-Gm-Message-State: AOAM532znshPFoX1CWNh4eT4O11qn8XbGUm2vFHRs88GlWL75FIW39AW
        08V9FU4BaOR+LugxIB4NzUbjfHbgNaU=
X-Google-Smtp-Source: ABdhPJxt4RWM4yvEVPbmCs6ZSgK83uGqAhSP9+P5exWSvVPMwBXCVkBp99/ZVqVKZTHtkm4AATctTA==
X-Received: by 2002:a05:6808:618:: with SMTP id y24mr3446612oih.179.1630688582929;
        Fri, 03 Sep 2021 10:03:02 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id bf6sm1124044oib.0.2021.09.03.10.03.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Sep 2021 10:03:02 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, phillip.wood@dunelm.org.uk,
        sunshine@sunshineco.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v3 2/3] win32: allow building with pedantic mode enabled
Date:   Fri,  3 Sep 2021 10:02:31 -0700
Message-Id: <20210903170232.57646-3-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210903170232.57646-1-carenas@gmail.com>
References: <20210901091941.34886-1-carenas@gmail.com>
 <20210903170232.57646-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation to building with pedantic mode enabled, change a couple
of places where the current mingw gcc compiler provided with the SDK
reports issues.

A full fix for the incompatible use of (void *) to store function
pointers has been punted, with the minimal change to instead use a
generic function pointer (FARPROC), and therefore the (hopefully)
temporary need to disable incompatible pointer warnings.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
This is all that is needed to build cleanly once merged to maint/master/next

There is at least one fix needed on top for seen, that was sent already
and is expected as part of a different reroll as well of several more for
git-for-windows/main that will be send independently.

 compat/nedmalloc/nedmalloc.c |  2 +-
 compat/win32/lazyload.h      |  2 +-
 config.mak.dev               | 13 ++++++++-----
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/compat/nedmalloc/nedmalloc.c b/compat/nedmalloc/nedmalloc.c
index 1cc31c3502..edb438a777 100644
--- a/compat/nedmalloc/nedmalloc.c
+++ b/compat/nedmalloc/nedmalloc.c
@@ -510,7 +510,7 @@ static void threadcache_free(nedpool *p, threadcache *tc, int mymspace, void *me
 	assert(idx<=THREADCACHEMAXBINS);
 	if(tck==*binsptr)
 	{
-		fprintf(stderr, "Attempt to free already freed memory block %p - aborting!\n", tck);
+		fprintf(stderr, "Attempt to free already freed memory block %p - aborting!\n", (void *)tck);
 		abort();
 	}
 #ifdef FULLSANITYCHECKS
diff --git a/compat/win32/lazyload.h b/compat/win32/lazyload.h
index 9e631c8593..d2056cdadf 100644
--- a/compat/win32/lazyload.h
+++ b/compat/win32/lazyload.h
@@ -37,7 +37,7 @@ struct proc_addr {
 #define INIT_PROC_ADDR(function) \
 	(function = get_proc_addr(&proc_addr_##function))
 
-static inline void *get_proc_addr(struct proc_addr *proc)
+static inline FARPROC get_proc_addr(struct proc_addr *proc)
 {
 	/* only do this once */
 	if (!proc->initialized) {
diff --git a/config.mak.dev b/config.mak.dev
index 41d6345bc0..5424db5c22 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -1,11 +1,18 @@
+ifndef COMPILER_FEATURES
+COMPILER_FEATURES := $(shell ./detect-compiler $(CC))
+endif
+
 ifeq ($(filter no-error,$(DEVOPTS)),)
 DEVELOPER_CFLAGS += -Werror
 SPARSE_FLAGS += -Wsparse-error
 endif
+DEVELOPER_CFLAGS += -Wall
 ifneq ($(filter pedantic,$(DEVOPTS)),)
 DEVELOPER_CFLAGS += -pedantic
+ifneq ($(filter gcc5,$(COMPILER_FEATURES)),)
+DEVELOPER_CFLAGS += -Wno-incompatible-pointer-types
+endif
 endif
-DEVELOPER_CFLAGS += -Wall
 DEVELOPER_CFLAGS += -Wdeclaration-after-statement
 DEVELOPER_CFLAGS += -Wformat-security
 DEVELOPER_CFLAGS += -Wold-style-definition
@@ -16,10 +23,6 @@ DEVELOPER_CFLAGS += -Wunused
 DEVELOPER_CFLAGS += -Wvla
 DEVELOPER_CFLAGS += -fno-common
 
-ifndef COMPILER_FEATURES
-COMPILER_FEATURES := $(shell ./detect-compiler $(CC))
-endif
-
 ifneq ($(filter clang4,$(COMPILER_FEATURES)),)
 DEVELOPER_CFLAGS += -Wtautological-constant-out-of-range-compare
 endif
-- 
2.33.0.481.g26d3bed244

