Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D98C433EF
	for <git@archiver.kernel.org>; Sun, 16 Jan 2022 02:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbiAPCFY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Jan 2022 21:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbiAPCFX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jan 2022 21:05:23 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C65C061574
        for <git@vger.kernel.org>; Sat, 15 Jan 2022 18:05:23 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id s15so6415326pfw.1
        for <git@vger.kernel.org>; Sat, 15 Jan 2022 18:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=08nshMvtVD3UNc+82NxYXwc4Ad+bT3QKVyeDguYoK6o=;
        b=TJ+4rdn/SZVSYbxndC9ElxLfGLfcnH8U5l9ae4dTClrcEw8Glbzyj5VkFgsPMfXH/r
         lebwBMg8srdCiVN4LyavF+2xl/M+Y+NHpX/AdBQJUsvNLBI+6mM1OKc7c5ytIVtX/aEz
         SDg39jAumZjcQ7h0VP0WjmavG8iWECw7rZHQzvP9s4zG/ZfwUiVeAezAIOUnzbV/HeGT
         YxFgsu6KlSUIuZeR3JTUgQ6Onn9PJwcPCLz0EsiYtGtjIkL2dD80l3DEfNU8b8ArQEn/
         R7LJeeJqmbQHWl3W0y1fH1AnHE3CGTs2MNeB+P/Wnzf/BtowOoXS80D4pqL2g385xq4c
         AIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=08nshMvtVD3UNc+82NxYXwc4Ad+bT3QKVyeDguYoK6o=;
        b=wz2wofxF0iEBZqQPEBAXe9JMWJS42MDmN5HZkzAKpbOSIF4IE41r6IDj9XIgjJjRI0
         OAFHRjZrbhuKRaa0Cozhieag7vpRFutjAwq8fLWKs5OW4cgOsstOFLHUjWowaHWFYwKd
         e+3Z42wAQyDFYXzo2Qxs9ynNAUcTO4D1rnrifEQXpHfD135i+Mb5Xd1r5RhfRWJbCRlj
         Yf8UxBzi7eI2ze7Th83atoe0E8JpOpkY4L/fuKeB6zYpgIVTsa2yCmt/n3LNjbt+JGA/
         f7XZryPhs/iwpJvog6YSQ19usKAbx2We1c4qWkAaWKoGTdLyDC4ug8WYhG1wD0CS2PS+
         xcyw==
X-Gm-Message-State: AOAM531UyB41F8afoDDlJqyg/q36F6Q+jypUk4IoTjOcp88Y/3hsUYyC
        KMCyCaxMsv4T1YCSR6UM5e4=
X-Google-Smtp-Source: ABdhPJzqRGwEbq1Y3IdfPj0MQ11lXHUR8jl3ZyjSHaUpBm/ANJnC7BdpT6cN+EvkrNmJxLFswj5RQw==
X-Received: by 2002:a63:6fc4:: with SMTP id k187mr13885807pgc.358.1642298723203;
        Sat, 15 Jan 2022 18:05:23 -0800 (PST)
Received: from sarawiggum.fas.fa.disney.com ([198.187.190.10])
        by smtp.gmail.com with ESMTPSA id m19sm7888878pfk.198.2022.01.15.18.05.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jan 2022 18:05:22 -0800 (PST)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] build: centos/RHEL 7 ships with an older gcc and zlib
Date:   Sat, 15 Jan 2022 18:05:20 -0800
Message-Id: <20220116020520.26895-1-davvid@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

GCC 4.8.5 is the default system compiler on centos7/RHEL7.
This version requires -std=c99 to enable c99 support.

zlib 1.2.7 on centos7/rhel7 lacks uncompress2().

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 config.mak.uname | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 9b3e9bff5f..c48db45106 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -63,6 +63,11 @@ ifeq ($(uname_S),Linux)
 	PROCFS_EXECUTABLE_PATH = /proc/self/exe
 	HAVE_PLATFORM_PROCINFO = YesPlease
 	COMPAT_OBJS += compat/linux/procinfo.o
+	# centos7/rhel7 provides gcc 4.8.5 and zlib 1.2.7.
+	ifneq ($(findstring .el7.,$(uname_R)),)
+		BASIC_CFLAGS += -std=c99
+		NO_UNCOMPRESS2 = YesPlease
+	endif
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	HAVE_ALLOCA_H = YesPlease
-- 
2.30.1 (Apple Git-130)

