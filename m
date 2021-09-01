Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E0DC4320E
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 09:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1149E60525
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 09:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243586AbhIAJVS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 05:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243573AbhIAJVR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 05:21:17 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD88C061575
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 02:20:21 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id v2so2938067oie.6
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 02:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+KtdZioubUomZJtWQAAXUJlQUquzzii3CgqAt1sZ9x0=;
        b=QugK93S0vnUsRiYZl9zltCx7fHqNYt4NBSSUOgT165TSTxIQdyUjxk+q965xP20/KM
         Dsy5twK57NVta0CekldUqb2R97uDcAtGY1TVsNkbHCe5toclL6xTW+VYgPaXoJuDT86R
         RvWGb3szgsXK/1HtuiHZwaeryXIV/GNj8HLoy3VK9hfjIVg46E/GjJy/r3oeh9gadIBF
         8BpbBnLHz1Tbzq2xa0z4kno3mpkUKsyKO/b96rkCuc4ma8Owp19OA+S0pLtolTCnyI4x
         gkB3FLO+L059Vuy7v9LhTcV/NDaJuAlLY1EXDhG97kQ0OD5fjtgBRTwjpBVpqPAlxK1t
         UwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+KtdZioubUomZJtWQAAXUJlQUquzzii3CgqAt1sZ9x0=;
        b=Kykxmv6Xc5RCQvPprY4RaOEIRoo+9hYQswk/98as7DlPOjWUMoE//QHkYfQm0+s+8X
         DMk34F56Fo6l1dNy+C19HVq1cYHW8+1ZJab94m3DLrTd0vH9/vtGK4EDKYOjDKYWT8ie
         Mnde6w69Ss13sCc2Po/EW86e7ATCcljFECiAi7+9qCx2V/VDM5Mhsx79MdqBImjsFc22
         rFl1jWJBA93YWokknPy8Zrs1+VS2byE1HN6aEyqxn+TV8FmuIDpVV0hY87qFw0W3S8eW
         KSzacqkOagBGCwYIijmHx3lnrow7ud1Lnqi0q2bDlk6++tWVSOT480CshUFXFsH5E5H0
         mI9Q==
X-Gm-Message-State: AOAM530Ch3sxt024WiGLpor6mcv4ws4uzyqSsOYaG7NqULVN8rPMcJ8K
        PwlBVpTsMYEIbjZ2hpox4RP04M81Uos=
X-Google-Smtp-Source: ABdhPJwrrw02+U3TxtuSqpjYLC5cEaw7ZEkvW2K6L14OlV9SsVwR3puDfqA8WE9vpk5X4GAvXE/Cyg==
X-Received: by 2002:a54:4114:: with SMTP id l20mr6642355oic.178.1630488020423;
        Wed, 01 Sep 2021 02:20:20 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id s206sm4161597oif.44.2021.09.01.02.20.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Sep 2021 02:20:20 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, phillip.wood@dunelm.org.uk,
        gitster@pobox.com, mackyle@gmail.com, sunshine@sunshineco.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [RFC PATCH v2 1/4] developer: retire USE_PARENS_AROUND_GETTEXT_N support
Date:   Wed,  1 Sep 2021 02:19:38 -0700
Message-Id: <20210901091941.34886-2-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210901091941.34886-1-carenas@gmail.com>
References: <20210809013833.58110-4-carenas@gmail.com>
 <20210901091941.34886-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

290c8e7a3f (gettext.h: add parentheses around N_ expansion if supported,
2015-01-11) adds a trick for GNU compilers that breaks the build, if an
accidental concatenation of i18n strings is used, but relies on invalid
C that gcc/clang just happen to allow (unless in pedantic mode).

remove that code and all subsequent fixes so that pedantic can run.

an alternative will be provided in a future patch.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Makefile          | 20 +-------------------
 config.mak.dev    |  2 --
 gettext.h         | 24 ------------------------
 git-compat-util.h |  4 ----
 4 files changed, 1 insertion(+), 49 deletions(-)

diff --git a/Makefile b/Makefile
index 9573190f1d..4e94073c2a 100644
--- a/Makefile
+++ b/Makefile
@@ -409,15 +409,6 @@ all::
 # Define NEEDS_LIBRT if your platform requires linking with librt (glibc version
 # before 2.17) for clock_gettime and CLOCK_MONOTONIC.
 #
-# Define USE_PARENS_AROUND_GETTEXT_N to "yes" if your compiler happily
-# compiles the following initialization:
-#
-#   static const char s[] = ("FOO");
-#
-# and define it to "no" if you need to remove the parentheses () around the
-# constant.  The default is "auto", which means to use parentheses if your
-# compiler is detected to support it.
-#
 # Define HAVE_BSD_SYSCTL if your platform has a BSD-compatible sysctl function.
 #
 # Define HAVE_GETDELIM if your system has the getdelim() function.
@@ -497,8 +488,7 @@ all::
 #
 #    pedantic:
 #
-#        Enable -pedantic compilation. This also disables
-#        USE_PARENS_AROUND_GETTEXT_N to produce only relevant warnings.
+#        Enable -pedantic compilation.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1347,14 +1337,6 @@ ifneq (,$(SOCKLEN_T))
 	BASIC_CFLAGS += -Dsocklen_t=$(SOCKLEN_T)
 endif
 
-ifeq (yes,$(USE_PARENS_AROUND_GETTEXT_N))
-	BASIC_CFLAGS += -DUSE_PARENS_AROUND_GETTEXT_N=1
-else
-ifeq (no,$(USE_PARENS_AROUND_GETTEXT_N))
-	BASIC_CFLAGS += -DUSE_PARENS_AROUND_GETTEXT_N=0
-endif
-endif
-
 ifeq ($(uname_S),Darwin)
 	ifndef NO_FINK
 		ifeq ($(shell test -d /sw/lib && echo y),y)
diff --git a/config.mak.dev b/config.mak.dev
index 022fb58218..41d6345bc0 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -4,8 +4,6 @@ SPARSE_FLAGS += -Wsparse-error
 endif
 ifneq ($(filter pedantic,$(DEVOPTS)),)
 DEVELOPER_CFLAGS += -pedantic
-# don't warn for each N_ use
-DEVELOPER_CFLAGS += -DUSE_PARENS_AROUND_GETTEXT_N=0
 endif
 DEVELOPER_CFLAGS += -Wall
 DEVELOPER_CFLAGS += -Wdeclaration-after-statement
diff --git a/gettext.h b/gettext.h
index c8b34fd612..d209911ebb 100644
--- a/gettext.h
+++ b/gettext.h
@@ -55,31 +55,7 @@ const char *Q_(const char *msgid, const char *plu, unsigned long n)
 }
 
 /* Mark msgid for translation but do not translate it. */
-#if !USE_PARENS_AROUND_GETTEXT_N
 #define N_(msgid) msgid
-#else
-/*
- * Strictly speaking, this will lead to invalid C when
- * used this way:
- *	static const char s[] = N_("FOO");
- * which will expand to
- *	static const char s[] = ("FOO");
- * and in valid C, the initializer on the right hand side must
- * be without the parentheses.  But many compilers do accept it
- * as a language extension and it will allow us to catch mistakes
- * like:
- *	static const char *msgs[] = {
- *		N_("one")
- *		N_("two"),
- *		N_("three"),
- *		NULL
- *	};
- * (notice the missing comma on one of the lines) by forcing
- * a compilation error, because parenthesised ("one") ("two")
- * will not get silently turned into ("onetwo").
- */
-#define N_(msgid) (msgid)
-#endif
 
 const char *get_preferred_languages(void);
 int is_utf8_locale(void);
diff --git a/git-compat-util.h b/git-compat-util.h
index b46605300a..ddc65ff61d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1253,10 +1253,6 @@ int warn_on_fopen_errors(const char *path);
  */
 int open_nofollow(const char *path, int flags);
 
-#if !defined(USE_PARENS_AROUND_GETTEXT_N) && defined(__GNUC__)
-#define USE_PARENS_AROUND_GETTEXT_N 1
-#endif
-
 #ifndef SHELL_PATH
 # define SHELL_PATH "/bin/sh"
 #endif
-- 
2.33.0.481.g26d3bed244

