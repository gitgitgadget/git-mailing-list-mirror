Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172DAC433FE
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 03:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F29E76138F
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 03:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243906AbhI2DVi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 23:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243892AbhI2DVh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 23:21:37 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D37C06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 20:19:56 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id e16so1019460qte.13
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 20:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WlSebNwYPqeonzOR1gZ4SXx7Vt5FfOi/vCYHqKbPDW0=;
        b=Z3KBXk1DSdnTAdmfSojC6nzqO2K6svjQSWWh7kfb12jsc6xOi56p1ommJn9W9d+ug1
         /HPh91OOrehjy2BKs/TAJBIW07y0WhNxn+eqmn06futer+U0UDL4pumIL0O7zf7Z/zYK
         giwPa9i6BQ9+pWzyTpD8/+V/6S6Th+tqZ9eeLYfOVjsn7hWtnZAnkyawqpXwuwU/X7jr
         mS/k5SP60ynF4TmWnOC1bi/yvh2G4frNvYmzu0ZH/3YPzUG6xV4NCnyuu/Qhakb4l0AA
         7ejiT0sckoeNPlceByPxkXUyRtJSTQFe4VCi1khq1PWCM1XGEEWw4FLiWoUTappp8SDL
         nGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WlSebNwYPqeonzOR1gZ4SXx7Vt5FfOi/vCYHqKbPDW0=;
        b=OTTY2k4vuEtI/EDcS9iWzlsPJisLPi5C9Rj72v2lW1AZpXNKsOnjJ2n51QkCdOMpPV
         Ro5RoR7pMFguT6Pzu+32m38+MrKcHfvRl3DjYSVbuIlrTAXMHwSkVWx/AMiBxXCcC0UI
         vpqp2Ul638zQgCwuKbqQAF+m8mmHxJdorqH1Xstcz1m/lEQY3pWIw1LLEeD2dKTdpiek
         KCXAtj2PyYHnTrYdGJBzpJPbpwUAw42RvIAOqZXuB2JB24iO7eYBoBWcOSVMpQY5wAr/
         kL3Z4TlfMVyLKCUO+T/Zxsrae+rcVSS7WELiClDQAowpwuCK+k1mapo/BF2xPbD2Uzty
         2EYw==
X-Gm-Message-State: AOAM532DWV+Pqlr+xGlAWqBL4JjxIsZyA1SnsWhgZpa2mVI3wDtWonJR
        Tw4qD1uiB3XvIPSyoxbq63HrokonpcGUMg==
X-Google-Smtp-Source: ABdhPJzoVS4YMkepfu7PCI/0ilymsdhenu5/VGNi9nBuhcD/NA1a3aIMFYKFwutTornjC+4fvBEu0g==
X-Received: by 2002:ac8:4113:: with SMTP id q19mr9574932qtl.108.1632885595438;
        Tue, 28 Sep 2021 20:19:55 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id h2sm801350qkk.10.2021.09.28.20.19.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Sep 2021 20:19:54 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, gitster@pobox.com, avarab@gmail.com,
        jonathantanmy@google.com, ramsay@ramsayjones.plus.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v5 3/3] Makefile: restrict -Wpedantic and -Wno-pedantic-ms-format better
Date:   Tue, 28 Sep 2021 20:19:40 -0700
Message-Id: <20210929031940.97092-4-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.955.gee03ddbf0e
In-Reply-To: <20210929031940.97092-1-carenas@gmail.com>
References: <20210929004832.96304-1-carenas@gmail.com>
 <20210929031940.97092-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

6a8cbc41ba (developer: enable pedantic by default, 2021-09-03)
enables pedantic mode in as many compilers as possible to help gather
feedback on future tightening, so lets do so.

-Wpedantic is missing in some really old gcc 4 versions so lets restrict
it to gcc5 and clang4 (it does work in clang3 AFAIK, but it will be
unlikely that a developer will use such an old compiler anyway).

MinGW gcc is the only one which has -Wno-pedantic-ms-format, and while
that is available also in older compilers, the Windows SDK provides gcc10
so lets aim for that.

Note that in order to target the flag to only Windows, additional changes
were needed in config.mak.uname to propagate the OS detection which also
did some minor refactoring, but which is functionaly equivalent.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 config.mak.dev   | 7 ++++++-
 config.mak.uname | 6 +++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/config.mak.dev b/config.mak.dev
index cdf043c52b..7673fed114 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -6,14 +6,19 @@ ifeq ($(filter no-error,$(DEVOPTS)),)
 DEVELOPER_CFLAGS += -Werror
 SPARSE_FLAGS += -Wsparse-error
 endif
+
 DEVELOPER_CFLAGS += -Wall
 ifeq ($(filter no-pedantic,$(DEVOPTS)),)
 DEVELOPER_CFLAGS += -pedantic
+ifneq (($or $(filter gcc5,$(COMPILER_FEATURES)),$(filter clang4,$(COMPILER_FEATURES))),)
 DEVELOPER_CFLAGS += -Wpedantic
-ifneq ($(filter gcc5,$(COMPILER_FEATURES)),)
+ifneq ($(filter gcc10,$(COMPILER_FEATURES)),)
+ifeq ($(uname_S),MINGW)
 DEVELOPER_CFLAGS += -Wno-pedantic-ms-format
 endif
 endif
+endif
+endif
 DEVELOPER_CFLAGS += -Wdeclaration-after-statement
 DEVELOPER_CFLAGS += -Wformat-security
 DEVELOPER_CFLAGS += -Wold-style-definition
diff --git a/config.mak.uname b/config.mak.uname
index 76516aaa9a..2b178bad58 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -11,6 +11,10 @@ uname_R := $(shell sh -c 'uname -r 2>/dev/null || echo not')
 uname_P := $(shell sh -c 'uname -p 2>/dev/null || echo not')
 uname_V := $(shell sh -c 'uname -v 2>/dev/null || echo not')
 
+ifneq ($(findstring MINGW,$(uname_S)),)
+	uname_S := MINGW
+endif
+
 ifdef MSVC
 	# avoid the MingW and Cygwin configuration sections
 	uname_S := Windows
@@ -588,7 +592,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	SANE_TOOL_PATH = /usr/coreutils/bin:/usr/local/bin
 	SHELL_PATH = /usr/coreutils/bin/bash
 endif
-ifneq (,$(findstring MINGW,$(uname_S)))
+ifeq ($(uname_S),MINGW)
 	pathsep = ;
 	HAVE_ALLOCA_H = YesPlease
 	NO_PREAD = YesPlease
-- 
2.33.0.955.gee03ddbf0e

