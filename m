Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A70C4332F
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 03:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83E9B6138F
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 03:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243881AbhI2DVe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 23:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243834AbhI2DVd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 23:21:33 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAF2C06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 20:19:53 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id x9so656042qvn.12
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 20:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xAO+3NfaiMMerkMiqWQIE69+zQfFZyiGUDY/RjSN4Y0=;
        b=Vra7n8wnSSSjsEIDuZHAm7I4ImK+PdrOtwgHdQhHPWHwXiZ+wOBqThiImquSz7Uuzu
         dN9jEsGDHlGUYTgYhEv2IatnjbB3JVBhcSNI75wO0U9sqDd0cFFc9GvBHLJblNcqYiIl
         JYS6DO2S9IHLNn7HIWVp7ZJ643+gsqFWW1UAftmKM1w95/ODYKNJEu0lRppHv++fuKr+
         wZoU3bA/gzVFSf/K0u1z/Q1rXXKAAtM6wfuYgZMp5Ws9zfwmyWXbSAENcpL+5o2SHITf
         SfnFT6We6xAacXoIGDm+O1epGcv88JNg0RYgKq70I8YF3a7bQ0b2ZEpc1fWKYjLKl3iz
         AwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xAO+3NfaiMMerkMiqWQIE69+zQfFZyiGUDY/RjSN4Y0=;
        b=c3pvZaTpNyI9xu9r6UoHlqmlUYOMoAufqIRpqHBlZ9aKYgM5uFCULd9zTJRIihZe/X
         mGBQD3rGGj0nYZLTYM+RwRtREF2nKVa2mJCsuOQKZm7/2ey6isWkqxbuWCnfCXAY30+1
         E/QyJeR5tgYNHQiZL97Rh/+zRiiHrOtzQs3aq+IuVh2BiGDUKNJou8Al08kxoADXwQle
         D09E9iZbWjXJfzR08OIvmXevd+Lqj5OrotM7oA2uf1JfjQVPICTRZDuYIqstDSUF4kmN
         9uche7SDlR9BcI7DUabn0eEZ+Uo1JK7hTnAXmXfHHflvZb6uASA2T0XvO6dZQRMT2K7Z
         9EGA==
X-Gm-Message-State: AOAM530ir+7o9cuypTXwMuh7vilem7Re4sCnMvXuhlBdhSx7riL/adAB
        vqgYKPTwAitgXMoTs4Oyj8FMEIlZwgDb1A==
X-Google-Smtp-Source: ABdhPJwR+uYOcOLgtP3hT1N7pkSuLasCH41f14DoeuoAPdyi1na6aG+slNOJOO2MGhDDnL+AMHPvaw==
X-Received: by 2002:a0c:9d05:: with SMTP id m5mr8917021qvf.30.1632885592716;
        Tue, 28 Sep 2021 20:19:52 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id h2sm801350qkk.10.2021.09.28.20.19.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Sep 2021 20:19:52 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, gitster@pobox.com, avarab@gmail.com,
        jonathantanmy@google.com, ramsay@ramsayjones.plus.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v5 1/3] lazyload.h: fix warnings about mismatching function pointer types
Date:   Tue, 28 Sep 2021 20:19:38 -0700
Message-Id: <20210929031940.97092-2-carenas@gmail.com>
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

From: Johannes Sixt <j6t@kdbg.org>

Here, GCC warns about every use of the INIT_PROC_ADDR macro, for example:

In file included from compat/mingw.c:8:
compat/mingw.c: In function 'mingw_strftime':
compat/win32/lazyload.h:38:12: warning: assignment to
   'size_t (*)(char *, size_t,  const char *, const struct tm *)'
   {aka 'long long unsigned int (*)(char *, long long unsigned int,
      const char *, const struct tm *)'} from incompatible pointer type
   'FARPROC' {aka 'long long int (*)()'} [-Wincompatible-pointer-types]
   38 |  (function = get_proc_addr(&proc_addr_##function))
      |            ^
compat/mingw.c:1014:6: note: in expansion of macro 'INIT_PROC_ADDR'
 1014 |  if (INIT_PROC_ADDR(strftime))
      |      ^~~~~~~~~~~~~~

(message wrapped for convenience). Insert a cast to keep the compiler
happy. A cast is fine in these cases because they are generic function
pointer values that have been looked up in a DLL.

Helped-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 compat/win32/lazyload.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/compat/win32/lazyload.h b/compat/win32/lazyload.h
index d2056cdadf..121ee24ed2 100644
--- a/compat/win32/lazyload.h
+++ b/compat/win32/lazyload.h
@@ -26,7 +26,8 @@ struct proc_addr {
 #define DECLARE_PROC_ADDR(dll, rettype, function, ...) \
 	static struct proc_addr proc_addr_##function = \
 	{ #dll, #function, NULL, 0 }; \
-	static rettype (WINAPI *function)(__VA_ARGS__)
+	typedef rettype (WINAPI *proc_type_##function)(__VA_ARGS__); \
+	static proc_type_##function function
 
 /*
  * Loads a function from a DLL (once-only).
@@ -35,7 +36,7 @@ struct proc_addr {
  * This function is not thread-safe.
  */
 #define INIT_PROC_ADDR(function) \
-	(function = get_proc_addr(&proc_addr_##function))
+	(function = (proc_type_##function)get_proc_addr(&proc_addr_##function))
 
 static inline FARPROC get_proc_addr(struct proc_addr *proc)
 {
-- 
2.33.0.955.gee03ddbf0e

