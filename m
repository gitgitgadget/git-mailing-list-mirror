Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922F0C433EF
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 10:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242015AbiBSKmH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 05:42:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239701AbiBSKmF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 05:42:05 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC52F36E30
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 02:41:46 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id f3so18443360wrh.7
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 02:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J8QbbgX/LYOMsosM2kglX2uwXEHX5ICqDuZSxdMSspc=;
        b=JWJ2AfHDhdSbJuQpBhQBa/fClexPPdYoKzxE2d3ZoTmALFmT2F7AU5HGb/mL2Ul5ff
         Zd/R5f6H49E3qJyXi2px6NY+2Q+z7uZKTjbKNkyDxM1HK1N7Ec0FFt3fdi/IToDSNkX/
         bE6d0u2MllsPNDczIF8oVQ4flJYXvrClaso+zmF3GW0O+HqLoJBWmWR6gi7DYzCIjmN/
         VR2WxqEWwIH33uXGwXdsx/Eptk9XVER04BZj9HykP/dkbioXOIYd/vXxddzCCmwVSyGU
         H0vWEsnyx7oIEOUAmlUTmE6WQutyxCWBHLK1HerePOqCZ2WSG8VSpscu62WOLM0CRHVG
         d+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J8QbbgX/LYOMsosM2kglX2uwXEHX5ICqDuZSxdMSspc=;
        b=FF6YP9aecQvfkEyiHkY2ubpsHRWtHWIL+sfmuhESL+tFW0M8/eyYmfuSnoh9V2lcMi
         XA7+Z9SlG9N7a0eVxQnUhxOLvpGOL/WCj1lvGOwxrYhBNbVgKslGvQgHIavYtjVEVKQ3
         g19OFXe1qbkl0H74HFGEgjHk+nlG8DxY3MkHhMr6I1sCn09SVeVxz4xEdaiNjRIq9EBl
         qlp8VCnZsnuL2/WkDjdCVEiGFyw/ekD0TxqBGaPE84gQUWRi2HS6AQUFHLTenu2xlI89
         X+3xmVP0mkbMnkSnJlBS05D911mWT2zY41K6lkt8IS622BqKmOEBJC/az+4ogIsIPyiv
         YlXA==
X-Gm-Message-State: AOAM531X8qFKYD5wIcKpHdKHhmS2RC+KgvBqV9vrA8tLKyRNEZS4UjE3
        aIn2a02cilkXuEX3S2g9+ojVtPCIjYPZAw==
X-Google-Smtp-Source: ABdhPJyRkRPGW53YuqEHzPQB99mfuSsy3BA6hcTRpZlbbTneX7QbBXbiSzA74pTC2NDma/Hd3CeCKw==
X-Received: by 2002:a5d:4b43:0:b0:1e4:2deb:59e6 with SMTP id w3-20020a5d4b43000000b001e42deb59e6mr8775705wrs.515.1645267304988;
        Sat, 19 Feb 2022 02:41:44 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 1sm21623928wrz.75.2022.02.19.02.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 02:41:44 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/3] git-compat-util.h: clarify GCC v.s. C99-specific in comment
Date:   Sat, 19 Feb 2022 11:41:08 +0100
Message-Id: <patch-v3-1.3-1a15fe4fd74-20220219T103752Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1129.g03fd99ecb8d
In-Reply-To: <cover-v3-0.3-00000000000-20220219T103752Z-avarab@gmail.com>
References: <cover-v2-0.2-00000000000-20220128T110330Z-avarab@gmail.com> <cover-v3-0.3-00000000000-20220219T103752Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a comment added in e208f9cc757 (make error()'s constant return
value more visible, 2012-12-15). It's not correct that this is GCC-ism
anymore, it's code that uses standard C99 features.

The comment being changed here pre-dates the HAVE_VARIADIC_MACROS
define, which we got in e05bed960d3 (trace: add 'file:line' to all
trace output, 2014-07-12).

The original implementation of an error() macro) in e208f9cc757 used a
GCC-ism with the paste operator (see the commit message for mention of
it), but that was dropped later by 9798f7e5f9 (Use __VA_ARGS__ for all
of error's arguments, 2013-02-08), giving us the C99-portable version
we have now.

While we could remove the __GNUC__ define here, it might cause issues
for other compilers or static analysis systems, so let's not. See
87fe5df365 (inline constant return from error() function, 2014-05-06)
for one such issue.

See also e05bed960d3 (trace: add 'file:line' to all trace output,
2014-07-12) for another comment about GNUC's handling of __VA_ARGS__.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-compat-util.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 876907b9df4..2d9b75a021a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -534,9 +534,7 @@ void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 /*
  * Let callers be aware of the constant return value; this can help
  * gcc with -Wuninitialized analysis. We restrict this trick to gcc, though,
- * because some compilers may not support variadic macros. Since we're only
- * trying to help gcc, anyway, it's OK; other compilers will fall back to
- * using the function as usual.
+ * because other compilers may be confused by this.
  */
 #if defined(__GNUC__)
 static inline int const_error(void)
-- 
2.35.1.1129.g03fd99ecb8d

