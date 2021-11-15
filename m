Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B140C433FE
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1836261A7C
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350377AbhKOXVB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352995AbhKOXSc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 18:18:32 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60F0C03E03E
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:47 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id o29so15252150wms.2
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KzIkq4cAW+Qgk5qP28R4B9HIGgLI4FWsR+JHtFG778A=;
        b=XS56UHBt0x4zmH6A5Sy2ag+ppA8lo2N1az6zE+hTxfGPauciJZUhFlfQWUy4WllqYC
         iPBgrtCH+VfE9HODZud+IzezSiw1vB0brsO7BX2ro1r6RmK3dg4hD7YT4jaisgSAmMHx
         o/CesDf9Pe6FDdBUXMtoZ2iLDnJp5kzJp+ixa9/IWxbN3KDmVqS5aoHcsH0KSUQjyadC
         4vYOxv8zsontTtfqRF+VjmcM5q6kTg8PVLSz6b3K/cKfeuGE06v4WrZHSQfyGqJZZ+o9
         kDs6QdGSEjS3rxLZ6aQmo4GmWSRyyY3lHPeRzWazwk03kHE4xz4n+s8ph47hIcgBmDy1
         OzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KzIkq4cAW+Qgk5qP28R4B9HIGgLI4FWsR+JHtFG778A=;
        b=7ouJpb2mKKPNZVVOazounLlNrm+fqlwBffN0rZKbZDya5dWdpwznRm76DKLDyLjBIr
         MJ5pVyofSi011mC7AjP3cpVwJ7c0zFCunXXRmG7UMt3Y3FVbK8FGILgZV6dLsyNCvmSV
         WS8JjdIMC0Jl0qd98zRMJal4nCzau0UePOYs75qZSa8x3p78Aa8rY1KNhcJIy609z5bJ
         HoK3EJNni01OUGKpCp+S1YJrnAynONsiaZgE0yu1YhBFcR/4fl7njtBO9bMVyWVKKoFp
         iq7JEYA4nFy0m1AYxvLjfTZ1FYclFIrjbq85xukSt7bJpGhmeckTyAG4rqNYmJCOTE4H
         Fz0Q==
X-Gm-Message-State: AOAM531o81MfjgQ8FInuBAoM1gE1BprgP/nOGDruFeogZOdvY6Cl7+PX
        LDr8VJkKF+mkP85K7JAtVbMsv1o0UP/LEw==
X-Google-Smtp-Source: ABdhPJz1vboIWB9mx1uAtGG0+BtcqlDQzlszKRnAlX9XsKxojATal6VWGJlUHqxXFBTAhiWrpO0i7w==
X-Received: by 2002:a7b:c388:: with SMTP id s8mr62961993wmj.170.1637014726357;
        Mon, 15 Nov 2021 14:18:46 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n184sm526812wme.2.2021.11.15.14.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 14:18:45 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 17/21] usage.c: move usage routines around
Date:   Mon, 15 Nov 2021 23:18:27 +0100
Message-Id: <RFC-patch-17.21-c89a580e5ec-20211115T220831Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.809.g11e21d44b24
In-Reply-To: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
References: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A move-only change to re-order the usage routines in the order of
usage,die,die_message,error,warning, and to have the "errno" variant
after the non-errno variant, in addition to defining them all after
the fmt_with_err() helper which some of them need.

This change make a subsequent non-refactoring commit's diff smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 usage.c | 84 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/usage.c b/usage.c
index b41f8618f34..28005106f10 100644
--- a/usage.c
+++ b/usage.c
@@ -154,34 +154,6 @@ void set_die_is_recursing_routine(int (*routine)(void))
 	die_is_recursing = routine;
 }
 
-void NORETURN usagef(const char *err, ...)
-{
-	va_list params;
-
-	va_start(params, err);
-	usage_routine(err, params);
-	va_end(params);
-}
-
-void NORETURN usage(const char *err)
-{
-	usagef("%s", err);
-}
-
-void NORETURN die(const char *err, ...)
-{
-	va_list params;
-
-	if (die_is_recursing()) {
-		fputs("fatal: recursion detected in die handler\n", stderr);
-		exit(128);
-	}
-
-	va_start(params, err);
-	die_routine(err, params);
-	va_end(params);
-}
-
 static const char *fmt_with_err(char *buf, int n, const char *fmt)
 {
 	char str_error[256], *err;
@@ -206,6 +178,34 @@ static const char *fmt_with_err(char *buf, int n, const char *fmt)
 	return buf;
 }
 
+void NORETURN usage(const char *err)
+{
+	usagef("%s", err);
+}
+
+void NORETURN usagef(const char *err, ...)
+{
+	va_list params;
+
+	va_start(params, err);
+	usage_routine(err, params);
+	va_end(params);
+}
+
+void NORETURN die(const char *err, ...)
+{
+	va_list params;
+
+	if (die_is_recursing()) {
+		fputs("fatal: recursion detected in die handler\n", stderr);
+		exit(128);
+	}
+
+	va_start(params, err);
+	die_routine(err, params);
+	va_end(params);
+}
+
 void NORETURN die_errno(const char *fmt, ...)
 {
 	char buf[1024];
@@ -245,45 +245,45 @@ int die_message_errno(const char *fmt, ...)
 	return -1;
 }
 
-#undef error_errno
-int error_errno(const char *fmt, ...)
+#undef error
+int error(const char *err, ...)
 {
-	char buf[1024];
 	va_list params;
 
-	va_start(params, fmt);
-	error_routine(fmt_with_err(buf, sizeof(buf), fmt), params);
+	va_start(params, err);
+	error_routine(err, params);
 	va_end(params);
 	return -1;
 }
 
-#undef error
-int error(const char *err, ...)
+#undef error_errno
+int error_errno(const char *fmt, ...)
 {
+	char buf[1024];
 	va_list params;
 
-	va_start(params, err);
-	error_routine(err, params);
+	va_start(params, fmt);
+	error_routine(fmt_with_err(buf, sizeof(buf), fmt), params);
 	va_end(params);
 	return -1;
 }
 
-void warning_errno(const char *warn, ...)
+void warning(const char *warn, ...)
 {
-	char buf[1024];
 	va_list params;
 
 	va_start(params, warn);
-	warning_routine(fmt_with_err(buf, sizeof(buf), warn), params);
+	warning_routine(warn, params);
 	va_end(params);
 }
 
-void warning(const char *warn, ...)
+void warning_errno(const char *warn, ...)
 {
+	char buf[1024];
 	va_list params;
 
 	va_start(params, warn);
-	warning_routine(warn, params);
+	warning_routine(fmt_with_err(buf, sizeof(buf), warn), params);
 	va_end(params);
 }
 
-- 
2.34.0.rc2.809.g11e21d44b24

