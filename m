Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6931CC433F5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 00:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40E86613CF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 00:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243470AbhI2Aua (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 20:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243433AbhI2Au2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 20:50:28 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76224C06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 17:48:48 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so763381otb.10
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 17:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k6dKo35jmd23qWJV1G5ZOf9TwGQHwDrhjIenT0Nrj6I=;
        b=mjledS4ZQHUG954im/4hKpwSSu6pXFqYug0H5FEeju8btI7na+D995nA/OrdpvUy0w
         uhqMc/g+hQpM8LgVfFmr3AwKmA3TvVZZHX5DBUjOux8I/I+iKdYm6JafvNPFcWsAutU3
         2948QrL5UMDdtHGnb0KHxiWbBF7wcxOPwPQLu93SFJICDh22D1IBdr94ce3Bu6FL2V3/
         7hZ8WBSBqHIUt0H1osgLNWtYuI8QDtgAkQnftJaN2zRIR+NMxkDMIcQ4+voW0QdeJqaI
         VWeVUK+M1J0Y3Ul19DsJTfWIefxwc4MAm38qLAACB/hA13ocil4Ctr3gW1j+0ZLgLrUh
         uCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k6dKo35jmd23qWJV1G5ZOf9TwGQHwDrhjIenT0Nrj6I=;
        b=kct/TX+DTiFS5s0hffW2qraECP7KbvPAHpoHAc/MxCWYkYZFteimF7f8HgiN4ozVj8
         /HKSpQehEowBe2hV58yiSTCicJGKMJMIGo+fI3v4IVlIwIuBF/TBFYk0kOUo1C5JAoY6
         rhg+0CrRZHUf6SVZKx8RNZ7aDq+XY7fvBzNOYvZQOpH0fLYHmqHzAo52L4fV4CuJFhj9
         tsunBTzsbXbOjXz9zdox1zuQWxq+5w9vzGueiMo/a807pwgo+2hFxV2s97/v2t+sQnos
         mv5vc7rL1h6ePS2oKLr1y9R0kmQWrYyiFp4egeGXlD1r1PpTefNzmmdkfbZ4togPZZDO
         kTbw==
X-Gm-Message-State: AOAM532iXrLLgQXL4x0p5h26AibUVXZxnKYUk3JKQYiLkshkoxmdavbd
        tZPtVhMOT0d/oWLocRdlIDzWF1RSYreENQ==
X-Google-Smtp-Source: ABdhPJxd3FNx8sBnEYJaQYrR0egdJA/OIu+qv+9uA0xRIbzRz8cktgi96i3FII8MRMYfkvA2UB/HYA==
X-Received: by 2002:a05:6830:2146:: with SMTP id r6mr7754313otd.1.1632876527648;
        Tue, 28 Sep 2021 17:48:47 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id r18sm159924ote.28.2021.09.28.17.48.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Sep 2021 17:48:47 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, gitster@pobox.com, avarab@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v4 3/3] Makefile: restrict -Wpedantic and -Wno-pedantic-ms-format better
Date:   Tue, 28 Sep 2021 17:48:32 -0700
Message-Id: <20210929004832.96304-4-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.955.gee03ddbf0e
In-Reply-To: <20210929004832.96304-1-carenas@gmail.com>
References: <20210926100512.58924-1-carenas@gmail.com>
 <20210929004832.96304-1-carenas@gmail.com>
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
so let's aim for that.

Note that in order to target the flag to only Windows, additional changes
were needed in config.mak.uname to propagate the OS detection which also
did some minor refactoring, but which is functionaly equivalent.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 config.mak.dev   | 7 ++++++-
 config.mak.uname | 8 +++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

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
index 76516aaa9a..124ddfce36 100644
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
@@ -705,6 +709,8 @@ ifeq ($(uname_S),QNX)
 	NO_STRLCPY = YesPlease
 endif
 
+export uname_S
+
 vcxproj:
 	# Require clean work tree
 	git update-index -q --refresh && \
-- 
2.33.0.955.gee03ddbf0e

