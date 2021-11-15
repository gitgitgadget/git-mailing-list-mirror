Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC3DC433FE
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C46F61882
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352594AbhKOXbg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353001AbhKOXSd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 18:18:33 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1A3C03E03F
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:48 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so439620wme.0
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TsL8LrEQKaSyRd+Dzz91yZf3svyT5PQGwYMP1snYil8=;
        b=AJbyGqaAwBSU71fxUyL2/dmL5vNrZTTW0ITXlqnWaArBJ6vHUfFJJgONztkPvXQu7C
         6RyAEqli0kN0UQBIfEot3sK3nqIvFYpOrZZh8ra2wTQcFIi2TdGXKlpuL8VXBUa7XWmr
         zLBfZ97YyKYBmmkW23kn6fTGhit7Q06V2umIHtdCh8vBhqvW0V7BCoINXghg+xTmd9Pr
         90HwdS4E8irYTgus5C4gPQuXQ7KzBdwQy7VKeDd/nzzlW1ErdDM621CAbWQ0CiEfA2OQ
         QhI7plnB+xqaaqLB77vSakVDcVXhBY3vcm1MYBQIFBTzRjnxQOtxVeF6UBWVRcFTrx/0
         wlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TsL8LrEQKaSyRd+Dzz91yZf3svyT5PQGwYMP1snYil8=;
        b=HUnrQruGD13sjm5xKs7XtbFHeNFAdncyuKkdKlZbN+a4hJ+8O3m+6URbXjyvim6yt1
         /JILRnfMDUriPLvd9ob7S+1EHqtCrpRaebOrqlNSRusX/HhvPzEjTZySrNnoAPxVFnDe
         b/4uXfrnLAmIuAufYUiboAkiDNvh8Zf5NNRtFV6d7yZNVGNBro9MoQvCxqiOhQAy+T0m
         7o1LmfGSe3DOwAyHXihZbQcqO7wO7Lm3fOiZui8C1ncvum8aM5IY6O1hXsgwBYWskuXt
         ILE7JdhGn1j5HL08m4TxA228fHvDnb28YVSMAc+8F2zlu5gmpBNWLIMdtkuOeqYU7yAC
         bXHQ==
X-Gm-Message-State: AOAM530s8p4ggmWENWVTL/pFjR/+nI27qtPEj/RKIMBS78yspiHCKa5w
        KeglrVhgupjPs01fKTFABIOhNy1nFkcKSg==
X-Google-Smtp-Source: ABdhPJyJ5xyPh3JMDXBmmMERl4EwoFM+bSpvK0m1zlgg3ZTv9d2blh9IB/gfmBgY9jX+2/qss6KT2A==
X-Received: by 2002:a1c:5414:: with SMTP id i20mr64576572wmb.88.1637014727027;
        Mon, 15 Nov 2021 14:18:47 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n184sm526812wme.2.2021.11.15.14.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 14:18:46 -0800 (PST)
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
Subject: [RFC PATCH 18/21] usage.c: move rename variables in usage routines around
Date:   Mon, 15 Nov 2021 23:18:28 +0100
Message-Id: <RFC-patch-18.21-d1f6ea70481-20211115T220831Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.809.g11e21d44b24
In-Reply-To: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
References: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A renaming-only change to rename variables in the usage routines to be
consistent. Before we'd use "params", now we use "ap", and the mixture
of "fmt", "err", "warn" etc. is replaced with just "fmt".

This change make a subsequent non-refactoring commit's diff smaller
and easier to understand.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 usage.c | 88 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/usage.c b/usage.c
index 28005106f10..4b93744137d 100644
--- a/usage.c
+++ b/usage.c
@@ -178,38 +178,38 @@ static const char *fmt_with_err(char *buf, int n, const char *fmt)
 	return buf;
 }
 
-void NORETURN usage(const char *err)
+void NORETURN usage(const char *fmt)
 {
-	usagef("%s", err);
+	usagef("%s", fmt);
 }
 
-void NORETURN usagef(const char *err, ...)
+void NORETURN usagef(const char *fmt, ...)
 {
-	va_list params;
+	va_list ap;
 
-	va_start(params, err);
-	usage_routine(err, params);
-	va_end(params);
+	va_start(ap, fmt);
+	usage_routine(fmt, ap);
+	va_end(ap);
 }
 
-void NORETURN die(const char *err, ...)
+void NORETURN die(const char *fmt, ...)
 {
-	va_list params;
+	va_list ap;
 
 	if (die_is_recursing()) {
 		fputs("fatal: recursion detected in die handler\n", stderr);
 		exit(128);
 	}
 
-	va_start(params, err);
-	die_routine(err, params);
-	va_end(params);
+	va_start(ap, fmt);
+	die_routine(fmt, ap);
+	va_end(ap);
 }
 
 void NORETURN die_errno(const char *fmt, ...)
 {
 	char buf[1024];
-	va_list params;
+	va_list ap;
 
 	if (die_is_recursing()) {
 		fputs("fatal: recursion detected in die_errno handler\n",
@@ -217,19 +217,19 @@ void NORETURN die_errno(const char *fmt, ...)
 		exit(128);
 	}
 
-	va_start(params, fmt);
-	die_routine(fmt_with_err(buf, sizeof(buf), fmt), params);
-	va_end(params);
+	va_start(ap, fmt);
+	die_routine(fmt_with_err(buf, sizeof(buf), fmt), ap);
+	va_end(ap);
 }
 
 #undef die_message
-int die_message(const char *err, ...)
+int die_message(const char *fmt, ...)
 {
-	va_list params;
+	va_list ap;
 
-	va_start(params, err);
-	die_message_routine(err, params);
-	va_end(params);
+	va_start(ap, fmt);
+	die_message_routine(fmt, ap);
+	va_end(ap);
 	return 128;
 }
 
@@ -237,22 +237,22 @@ int die_message(const char *err, ...)
 int die_message_errno(const char *fmt, ...)
 {
 	char buf[1024];
-	va_list params;
+	va_list ap;
 
-	va_start(params, fmt);
-	die_message_routine(fmt_with_err(buf, sizeof(buf), fmt), params);
-	va_end(params);
+	va_start(ap, fmt);
+	die_message_routine(fmt_with_err(buf, sizeof(buf), fmt), ap);
+	va_end(ap);
 	return -1;
 }
 
 #undef error
-int error(const char *err, ...)
+int error(const char *fmt, ...)
 {
-	va_list params;
+	va_list ap;
 
-	va_start(params, err);
-	error_routine(err, params);
-	va_end(params);
+	va_start(ap, fmt);
+	error_routine(fmt, ap);
+	va_end(ap);
 	return -1;
 }
 
@@ -260,31 +260,31 @@ int error(const char *err, ...)
 int error_errno(const char *fmt, ...)
 {
 	char buf[1024];
-	va_list params;
+	va_list ap;
 
-	va_start(params, fmt);
-	error_routine(fmt_with_err(buf, sizeof(buf), fmt), params);
-	va_end(params);
+	va_start(ap, fmt);
+	error_routine(fmt_with_err(buf, sizeof(buf), fmt), ap);
+	va_end(ap);
 	return -1;
 }
 
-void warning(const char *warn, ...)
+void warning(const char *fmt, ...)
 {
-	va_list params;
+	va_list ap;
 
-	va_start(params, warn);
-	warning_routine(warn, params);
-	va_end(params);
+	va_start(ap, fmt);
+	warning_routine(fmt, ap);
+	va_end(ap);
 }
 
-void warning_errno(const char *warn, ...)
+void warning_errno(const char *fmt, ...)
 {
 	char buf[1024];
-	va_list params;
+	va_list ap;
 
-	va_start(params, warn);
-	warning_routine(fmt_with_err(buf, sizeof(buf), warn), params);
-	va_end(params);
+	va_start(ap, fmt);
+	warning_routine(fmt_with_err(buf, sizeof(buf), fmt), ap);
+	va_end(ap);
 }
 
 /* Only set this, ever, from t/helper/, when verifying that bugs are caught. */
-- 
2.34.0.rc2.809.g11e21d44b24

