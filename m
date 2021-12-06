Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC1FC433FE
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 17:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242005AbhLFRHl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 12:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbhLFQ71 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 11:59:27 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EFDC061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 08:55:58 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id j3so23868091wrp.1
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 08:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/UX8Fb8OjipW5lAzuijt+PprKezztg8JuRK4aWcSSEk=;
        b=EihHoQ5oE9PXHmZ3QIraH9MBQUcYpzERci0Bv0fvS5nT7wl8ReZEl1RtB1/0tzoO+i
         tFjUFu6cZigM1dkbRmAWAOuDbHgMnC5ytZS3ho2ktUt6E5izsGQLNM78NYX0jVSokXii
         OvAJIvZv2Rhe2ppypGM6mTAQdRWIKIoUbMIXhWuo2TKuPllfwhV8QLdsm3tce+Ui2DoQ
         Nwyd2NCsC3+kjWul5YUjflcv52Q6Pqext//8jnsZcF/1kOdRUxgA45EzPP1n1PeeNCzF
         ATduFlvOjRDjWzMOAUXdp/igR2J3qjcmNkLf7/AuSuXSgHxZAHaM6P/3UAoZoU/NH4w7
         8Q9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/UX8Fb8OjipW5lAzuijt+PprKezztg8JuRK4aWcSSEk=;
        b=HMt3tng7tsAfhPZhQsI5xef8My5Vu8Zf/XSOCc+s2Qw94cKxweKQ0B7gHnR4ouLURU
         vTI66MQqL9YId9U4dCIj+A4ED0aCG2vAR177QijnJi7gazJJ1ma4qUO0iOlODCuPozaH
         hYGsvpCCHNnpLTx9JdMXcimTZWuULiV3XIEz/cCONOrK8Mi/0qIMw7G57WpObPbZ0Vq+
         NRqWDJj91Q2DYTZKFMg1f0NuMOBS5HWl49lWyf1wRW9E4QhLo4777PRUFlixm8g4IqC3
         X/qSZtYZs/+/j4ENBE1YQ1lxlTPsUeo6u+7tnRDIz53588jQgjM88TAHCaNFFSnWg8U5
         bCzw==
X-Gm-Message-State: AOAM532cf4GiNukFPi5ZCpeJpRPlhyJQ4v7kEQ1CMEPkN5WPUpwj6Lvn
        txvWg4VVjeMH/TQQ7o0E1TSYM8ah2G14cA==
X-Google-Smtp-Source: ABdhPJzOCLPN/WYEgSvcHyZYU3Bak82Sj9L7VTUxztyFDx0YMiRh+fNEHUWGdQI+NY0ahKRbpMELjg==
X-Received: by 2002:adf:cc91:: with SMTP id p17mr44697472wrj.589.1638809756811;
        Mon, 06 Dec 2021 08:55:56 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j40sm11775419wms.16.2021.12.06.08.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 08:55:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/4] usage.c: add a die_message() routine
Date:   Mon,  6 Dec 2021 17:55:50 +0100
Message-Id: <patch-1.4-5a9ab85fa56-20211206T165221Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.898.g5a552c2e5f0
In-Reply-To: <cover-0.4-00000000000-20211206T165221Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20211206T165221Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have code in various places that would like to call die(), but
wants to defer the exit(128) it would invoke, e.g. to print an
additional message, or adjust the exit code. Add a die_message()
helper routine to bridge this gap in the API.

Functionally this behaves just like the error() routine, except it'll
print a "fatal: " prefix, and it will return with 128 instead of -1,
this is so that caller can pass the return value to "exit()", instead
of having to hardcode "exit(128)".

A subsequent commit will migrate various callers that benefit from
this function over to it. For now we're just adding the routine and
making die_builtin() in usage.c itself use it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-compat-util.h |  1 +
 usage.c           | 22 ++++++++++++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index c6bd2a84e55..a83fbdf6398 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -479,6 +479,7 @@ NORETURN void usage(const char *err);
 NORETURN void usagef(const char *err, ...) __attribute__((format (printf, 1, 2)));
 NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
 NORETURN void die_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
+int die_message(const char *err, ...) __attribute__((format (printf, 1, 2)));
 int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
 int error_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
diff --git a/usage.c b/usage.c
index c7d233b0de9..74b43c5db6f 100644
--- a/usage.c
+++ b/usage.c
@@ -55,6 +55,12 @@ static NORETURN void usage_builtin(const char *err, va_list params)
 	exit(129);
 }
 
+static void die_message_builtin(const char *err, va_list params)
+{
+	trace2_cmd_error_va(err, params);
+	vreportf("fatal: ", err, params);
+}
+
 /*
  * We call trace2_cmd_error_va() in the below functions first and
  * expect it to va_copy 'params' before using it (because an 'ap' can
@@ -62,10 +68,7 @@ static NORETURN void usage_builtin(const char *err, va_list params)
  */
 static NORETURN void die_builtin(const char *err, va_list params)
 {
-	trace2_cmd_error_va(err, params);
-
-	vreportf("fatal: ", err, params);
-
+	die_message_builtin(err, params);
 	exit(128);
 }
 
@@ -211,6 +214,17 @@ void NORETURN die_errno(const char *fmt, ...)
 	va_end(params);
 }
 
+#undef die_message
+int die_message(const char *err, ...)
+{
+	va_list params;
+
+	va_start(params, err);
+	die_message_builtin(err, params);
+	va_end(params);
+	return 128;
+}
+
 #undef error_errno
 int error_errno(const char *fmt, ...)
 {
-- 
2.34.1.898.g5a552c2e5f0

