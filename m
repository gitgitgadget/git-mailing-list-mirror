Return-Path: <SRS0=/qQH=ZU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2A2C432C0
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 12:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8672158A
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 12:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bk1i0945"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfK1MZw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Nov 2019 07:25:52 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35263 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfK1MZw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Nov 2019 07:25:52 -0500
Received: by mail-pj1-f68.google.com with SMTP id s8so11838551pji.2
        for <git@vger.kernel.org>; Thu, 28 Nov 2019 04:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7vWWjarTydkzhl4r+TfiSkqyRF95R0RwfGZH2g/SZ9I=;
        b=Bk1i0945LF7bE5XmNPozJFXHU0bd5teXfx5bKcErsxjjMzY7R7yW9Lq3314e0I3QYi
         r2oRhu1dN/+tU5Ff6IWMhDtOojj2sgvHJhV5LZ17pV53AVRfaoY0Vp99+yIWXGf4T+oc
         XsvHhHdtumoz7VvfHetI+hfCqkqFq9Hkya5WFDCoREEFaNKT8P7z/SmfV9X98W+TclX6
         7VpsWLtYaj5RXWc+J7iTE49SqZ4AQsc32FngovY0WXptW37wQnzUDL89yRpDhJMSCS5n
         b8HCV39xn6scX1ix7K7rf/e8QXttqbem7rr5+br7hTq5eunxN5jyJZ/kcl1mAF0k2e6L
         NjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7vWWjarTydkzhl4r+TfiSkqyRF95R0RwfGZH2g/SZ9I=;
        b=aRMYF6maLT0tj/Q3RMjC9QIgUd48KH8QV1l5mefsfVnEJTkr+kLQrY68qjV6BYRF5I
         BKexBqRm1AHAmumQl2rZY9EZUYWmkxTVP98atfyyXpMx/Rz7VXJVIEnJ07gUSqZ4z0AY
         GUypG+SjaJZQt9oQ+g4oi1Jf+rztTJSUaO1aL+dmA4bc5Vu9t6lZhD6o7yvXWd6rhAso
         AryqSv3/K3PpGYrlea7oio/SuXr8+v8KAlSMy7FPmJ8CuOLepSbH8YuCGKSyfaKERtrE
         S0dPKoNdXTX0+wBPFZGvZaJNiC+o67pvQ68aOOj6L+yrV3c+WAPNCIDO1H+iYJzVo23w
         KIwg==
X-Gm-Message-State: APjAAAX4SujnqqYX/L7z+Xpi5YRJt7gGn2JefXwyPGAb/77o/G/1YUqe
        OuGv9DVrLYbkotPb2fqp6bGr1z3E6Qc=
X-Google-Smtp-Source: APXvYqzkNL1kR8Bm9et+L3YNPiYPN41tjBcF+8EOy4M6l4vVKN6I+rgG9SHIcQrCrTfRZRkbN1/71g==
X-Received: by 2002:a17:902:7084:: with SMTP id z4mr5953951plk.247.1574943951548;
        Thu, 28 Nov 2019 04:25:51 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:24ff:b05:3145:6413:309f])
        by smtp.gmail.com with ESMTPSA id r28sm18849448pgk.75.2019.11.28.04.25.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Nov 2019 04:25:51 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, Doan Tran Cong Danh <congdanhqx@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 3/3] mingw: use {gm,local}time_s as backend for {gm,local}time_r
Date:   Thu, 28 Nov 2019 19:25:05 +0700
Message-Id: <33a67eb37702172a6ff29215a840d2cf925daab8.1574943677.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.615.g37f5bfbdea
In-Reply-To: <cover.1574943677.git.congdanhqx@gmail.com>
References: <cover.1574943677.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since Windows doesn't provide gmtime_r(3) and localtime_r(3),
we're providing a compat version by using non-reentrant gmtime(3) and
localtime(3) as backend. Then, we copy the returned data into the
buffer.

By doing that, in case of failure, we will dereference a NULL pointer
returned by gmtime(3), and localtime(3), and we always return a valid
pointer instead of NULL.

Drop the memcpy(3) by using gmtime_s, and localtime_s as backend on
Windows, and make sure we will return NULL in case of failure.

Cc: Johannes Sixt <j6t@kdbg.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---
 compat/mingw.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index fe609239dd..75695a24a3 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -986,16 +986,16 @@ int pipe(int filedes[2])
 
 struct tm *gmtime_r(const time_t *timep, struct tm *result)
 {
-	/* gmtime() in MSVCRT.DLL is thread-safe, but not reentrant */
-	memcpy(result, gmtime(timep), sizeof(struct tm));
-	return result;
+	if (gmtime_s(result, timep) == 0)
+		return result;
+	return NULL;
 }
 
 struct tm *localtime_r(const time_t *timep, struct tm *result)
 {
-	/* localtime() in MSVCRT.DLL is thread-safe, but not reentrant */
-	memcpy(result, localtime(timep), sizeof(struct tm));
-	return result;
+	if (localtime_s(result, timep) == 0)
+		return result;
+	return NULL;
 }
 
 char *mingw_getcwd(char *pointer, int len)
-- 
2.24.0.615.g37f5bfbdea

