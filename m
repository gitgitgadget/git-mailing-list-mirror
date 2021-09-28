Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82340C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 09:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 670D0611C7
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 09:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239916AbhI1JMs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 05:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239886AbhI1JMr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 05:12:47 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B60CC061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 02:11:08 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id k11-20020a4abd8b000000b002b5c622a4ddso1625286oop.1
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 02:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QRteyXp7zJ26l8jvSxxivYT8yfLceUcxnxd2vvRt2Xc=;
        b=HnDxFVO7UmTmQJwEl7bdaH74BivpphKnIKHIURtuVQWj4XzzcdJ+EdtJHwDfVoGkA0
         beIC1ZT7ixyrGSnEq44fXLApdYDcNAf7rS5HZ+STzlQ9A+fOf0S8Iv8BVwpFH7AjK5pr
         0hy27kdqcNkQP8FE6gPf6i/SqFA7K0Vsi8fqV+5WlDaYOPK+hhs18UuahZwQYDuXd9qu
         sUeYFwvExbIXYPGzxiCX4mziCIIsIJB0juUm78V//ktOJeflW6GOcp2sFwkd2umfKeUr
         yDkXzHlbONLfI638i91bxWzxaqqXlwaV3AKvOhdvNXUKWfYBKgUHpSseL8rkHIwtR26m
         wKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QRteyXp7zJ26l8jvSxxivYT8yfLceUcxnxd2vvRt2Xc=;
        b=aviN8QrEgNL1iaNnWNaxwffJzBeATUwg3uAcVTDMrZDpHkUbH6DPx5qLuFjab7k7Gj
         F9RDE2im8oyCY0/BgE4pffbClP7UBbRQiY45L5a1CHsP1I7tM7bx7IHKN/OnhuxEjAGM
         3sS3bl25XgQFM0Qj2fLXbhT4EQ0XscEJpYk3c4yA0j0WGc6AL88pxwxRDZFHqy7p9zYf
         tH+22eDQ0czPBAK/tgFhx2Sa+Kn4BpXhbM3KzhDoP5p9sP494MJRdQUIPri8zAQzJFCt
         QmAZf3itaWAIRQXseY1Vx1h7NdgeBrFBymbSRH4okPcJPN+EizVHNduLlj1dU8VDCcL2
         ZYUA==
X-Gm-Message-State: AOAM533LUO4J5xthgLKkCcJoxO5FcF6CmxmLLcng10SRKz3wzlfbGizd
        4Yb4qqN0iS0aIGaBDR+zmUu+VDb3obJFWQ==
X-Google-Smtp-Source: ABdhPJxqYJijK37UsfxNwhuwRonBoSGbHCL2I7bXB4p3mI3ycJYk8klJXctchBE4iTRuybNrkIXTew==
X-Received: by 2002:a4a:c90a:: with SMTP id v10mr3973441ooq.83.1632820267389;
        Tue, 28 Sep 2021 02:11:07 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id r23sm4441250otu.54.2021.09.28.02.11.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Sep 2021 02:11:07 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com, avarab@gmail.com, pclouds@gmail.com,
        jonathantanmy@google.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 1/3] Makefile: restrict -Wpedantic and -Wno-pedantic-ms-format better
Date:   Tue, 28 Sep 2021 02:10:52 -0700
Message-Id: <20210928091054.78895-2-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.955.gee03ddbf0e
In-Reply-To: <20210928091054.78895-1-carenas@gmail.com>
References: <20210928091054.78895-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

6a8cbc41ba (developer: enable pedantic by default, 2021-09-03)
enables pedantic mode in as many compilers as possible to help gather
feedback on future tightening of the net, so lets do so.

-Wpedantic is missing in some really old gcc 4 versions so lets restrict
it to gcc5 and clang4 (it does work in clang3 AFAIK, but it will be
unlikely a developer will use such an old compiler anyway).

MinGW gcc is the only one which has -Wno-pedantic-ms-format, and while
that is available also in older compilers, the Windows SDK provides gcc10
so lets aim for that.  Note that in order to target the flag to only
Windows, additional changes were needed in config.mak.uname to propagate
the OS detection done there.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 config.mak.dev   | 6 +++++-
 config.mak.uname | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/config.mak.dev b/config.mak.dev
index cdf043c52b..c81be62a5c 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -9,11 +9,15 @@ endif
 DEVELOPER_CFLAGS += -Wall
 ifeq ($(filter no-pedantic,$(DEVOPTS)),)
 DEVELOPER_CFLAGS += -pedantic
+ifneq ($(filter clang4 gcc5,$(COMPILER_FEATURES)),)
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
index 76516aaa9a..aa68bbdec7 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -589,6 +589,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	SHELL_PATH = /usr/coreutils/bin/bash
 endif
 ifneq (,$(findstring MINGW,$(uname_S)))
+	uname_S := MINGW
 	pathsep = ;
 	HAVE_ALLOCA_H = YesPlease
 	NO_PREAD = YesPlease
@@ -705,6 +706,8 @@ ifeq ($(uname_S),QNX)
 	NO_STRLCPY = YesPlease
 endif
 
+export uname_S
+
 vcxproj:
 	# Require clean work tree
 	git update-index -q --refresh && \
-- 
2.33.0.955.gee03ddbf0e

