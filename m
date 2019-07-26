Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68E041F462
	for <e@80x24.org>; Fri, 26 Jul 2019 20:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfGZU0u (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 16:26:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32850 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbfGZU0u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 16:26:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id g2so25028394pfq.0
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 13:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QPRg0TP/1X96ckiWkeqcI8XRdMYMK1zmqI9Cl6zZj1g=;
        b=DrCSFrFFZ/kJRXAxg8VR1P7t2yxcDIRStG5JYd8AfQOKC1uHkV8caHH29F/ufFjSc7
         SMuTwGmZ8zqS/E6luaU3Iu1CJIaKb2ZenrAYqzBKkBFF0AO+1UTHZVnNH6KP7w0lVtIQ
         IkUa4nYbNPJpc6o6F71JtA8VQuTlCh3+PKY6WhzlH2+Jye+7gjiJbEjfNOJZxfpHp7Jl
         t2JyzmYtIMLRYHWLIojpCt6/29lyl47AMD+emzDXo+Cl0vf/Dv2oDsO6cfafdRV5ipwF
         62pBtfUCBTL4FdHs4yRT06SqFzwK4qcPfB1z2bpUyD2gCMnmtLom4/LWchFdSkRWkcoW
         14WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QPRg0TP/1X96ckiWkeqcI8XRdMYMK1zmqI9Cl6zZj1g=;
        b=dYtL/GXjtEWMiFIV3M/y9epoz+Q8mdx5JOVeNo4ePIxJpLyGjL4V5ogGtSFazzjHkW
         TT/UbqrEnVELGCpcZFwVYy/OskISnmtkr2mliwE+f7j7covwZbnMQMEeESHNaGh0Oq0b
         OcuvM5Q/9YM91t8M1qJB33vroMyuI94CL7IZYsjVC63k+vd/CCCyblCEk5IoTDrMuE8f
         50S7ltn/9Ti/EyhkrLWGSigvASLHHpXnePOCmihjhWszLawzSlCsKFjuOlEtvm1pf8vT
         YB4G8TVzRsA2dHc9rP8q9r6jnvy5mROJX064J+7MVTMnWKDIukbPeYyEeMRVGlEqxVeH
         pZGQ==
X-Gm-Message-State: APjAAAUT32wiMQNqvg+16rRwKeG1VG4uSJ5S8yvHJNF5Pm6um+0p8dRa
        3Y1i9lmvnLzy2a/HWZuZDZi8+MPudNA=
X-Google-Smtp-Source: APXvYqxIeZM1Pa4WCSd3uyl/YAdziBnDIteMr93fQ8utenXOA9t6GBYpYSJRhnVPgwkAHg5DOrpbVA==
X-Received: by 2002:a65:640a:: with SMTP id a10mr91721472pgv.338.1564172809522;
        Fri, 26 Jul 2019 13:26:49 -0700 (PDT)
Received: from localhost.localdomain ([205.209.24.227])
        by smtp.gmail.com with ESMTPSA id 4sm63754514pfc.92.2019.07.26.13.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 13:26:49 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, Johannes.Schindelin@gmx.de, dev+git@drbeat.li,
        gitster@pobox.com
Subject: [RFC PATCH 1/2] grep: make sure NO_LIBPCRE1_JIT disable JIT in PCRE1
Date:   Fri, 26 Jul 2019 13:26:41 -0700
Message-Id: <20190726202642.7986-2-carenas@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726202642.7986-1-carenas@gmail.com>
References: <87ftms7t6s.fsf@evledraar.gmail.com>
 <20190726202642.7986-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

e87de7cab4 ("grep: un-break building with PCRE < 8.32", 2017-05-25)
added a restriction for JIT support that is no longer needed after
pcre_jit_exec() calls were removed.

Reorganize the definitions in grep.h so that JIT support could be
detected early and NO_LIBPCRE1_JIT could be used reliably to enforce
JIT doesn't get used.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Makefile | 9 ++-------
 grep.h   | 4 +---
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 11ccea4071..7e0e6cc129 100644
--- a/Makefile
+++ b/Makefile
@@ -34,13 +34,8 @@ all::
 # library. Support for version 1 will likely be removed in some future
 # release of Git, as upstream has all but abandoned it.
 #
-# When using USE_LIBPCRE1, define NO_LIBPCRE1_JIT if the PCRE v1
-# library is compiled without --enable-jit. We will auto-detect
-# whether the version of the PCRE v1 library in use has JIT support at
-# all, but we unfortunately can't auto-detect whether JIT support
-# hasn't been compiled in in an otherwise JIT-supporting version. If
-# you have link-time errors about a missing `pcre_jit_exec` define
-# this, or recompile PCRE v1 with --enable-jit.
+# When using USE_LIBPCRE1, define NO_LIBPCRE1_JIT if you want to
+# disable JIT even if supported by your library.
 #
 # Define LIBPCREDIR=/foo/bar if your PCRE header and library files are
 # in /foo/bar/include and /foo/bar/lib directories. Which version of
diff --git a/grep.h b/grep.h
index a405fc870c..2a74e28d94 100644
--- a/grep.h
+++ b/grep.h
@@ -3,14 +3,12 @@
 #include "color.h"
 #ifdef USE_LIBPCRE1
 #include <pcre.h>
-#ifdef PCRE_CONFIG_JIT
-#if PCRE_MAJOR >= 8 && PCRE_MINOR >= 32
 #ifndef NO_LIBPCRE1_JIT
+#ifdef PCRE_CONFIG_JIT
 #define GIT_PCRE1_USE_JIT
 #define GIT_PCRE_STUDY_JIT_COMPILE PCRE_STUDY_JIT_COMPILE
 #endif
 #endif
-#endif
 #ifndef GIT_PCRE_STUDY_JIT_COMPILE
 #define GIT_PCRE_STUDY_JIT_COMPILE 0
 #endif
-- 
2.22.0
