Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D18C10DCE
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 07:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472232076A
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 07:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuUOxNMG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgCRHiW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 03:38:22 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54618 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgCRHiW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 03:38:22 -0400
Received: by mail-pj1-f67.google.com with SMTP id np9so956703pjb.4
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 00:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xh5cXHgj2QRKGX0wCR4/ujV9Q0ie50RYQ2H1hRwTthw=;
        b=EuUOxNMG02u6TD+CPSd3OxSWyiIlC4kuZy2ZTwaIKDO23qQTF6JpPfhCsAGHMTkpEz
         zZW2R+UNtnVmzMWqoqo7ifRJON41crgU5FOPQSJV/a4ZA5I1t4ysMusoUFIw+A705UmF
         Iv66KZm7BO0wkxZGkZVVDyM/xbs9RKXD9lMd1YmtfOdqR/m9IiUaPYcBUqFL14f1+wTL
         AX5ys9vDGZE16gar13brRFUolH7j+r41nEy9yHHypssBXA/sxsgNS3m8xgahmUqmdy60
         0L66YsxVKGFYTfY4okKWvMlXh37vUCn+G7nf+oGURmN3XxTvPAIjNFiTo6BJB/nVSq4y
         TwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xh5cXHgj2QRKGX0wCR4/ujV9Q0ie50RYQ2H1hRwTthw=;
        b=sqKVod2R6t71W6cTHyzDiObcYt1+yOhyipoWj6PulUUJK3rxupUaNMoofCyKtOXI1D
         mqc07llj7a4wU8F1KGcUlWb63Rw8+iAnnuGVRuW+Brs5/AjqentUS4UAZJaaJ+FDrRJV
         v+/gVnAlCvSyTVKgGtqBZzeRuoNC+hsg3lqyL4Tj3LKFmBLMWZHZD9YPkrWgMS0dTYWh
         X/1FDyVQONs3Sd4i65Mf9zGwKMK1gHMl8phs7sSzr6S2YmNtXZtjV75P7zgzrmGWm31x
         UhiZhQ1vbnur1jRg5y64wv2Odm25MfLCKhBPiuSjIZ2N6/4Hwi/X6whEnowclIVcoNd1
         na9A==
X-Gm-Message-State: ANhLgQ1mvO5C8uF2BeS+g5Tn2nHTlFLcaSsl1KYW1FC8tiR0/GR1dZWk
        AKcFy4NAIk5E89XR3jJQQOjn2tM5
X-Google-Smtp-Source: ADFU+vsu0Zi3Qadr52wFk5/RP1egIjnkpNvd+AOaTM6UlK7SHoYilCeS+dU22KyeROE0vYr+VMCz7g==
X-Received: by 2002:a17:90a:22a7:: with SMTP id s36mr3146620pjc.35.1584517100347;
        Wed, 18 Mar 2020 00:38:20 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:fbd2:7e82:2a61:6f4a:cfb4])
        by smtp.gmail.com with ESMTPSA id 25sm5419748pfn.190.2020.03.18.00.38.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2020 00:38:19 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 3/3] configure: respect --without-openssl
Date:   Wed, 18 Mar 2020 14:38:02 +0700
Message-Id: <c08bf880c77b7c43256a275e1102308a829d0ee8.1584516715.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.234.g969ad452ca
In-Reply-To: <cover.1584516715.git.congdanhqx@gmail.com>
References: <cover.1584516715.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 configure.ac | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 7468eb6bc8..20a11e1f32 100644
--- a/configure.ac
+++ b/configure.ac
@@ -544,9 +544,15 @@ GIT_STASH_FLAGS($OPENSSLDIR)
 
 AC_CHECK_LIB([crypto], [SHA1_Init],
 [NEEDS_SSL_WITH_CRYPTO=],
-[AC_CHECK_LIB([ssl], [SHA1_Init],
- [NEEDS_SSL_WITH_CRYPTO=YesPlease NO_OPENSSL=],
- [NEEDS_SSL_WITH_CRYPTO=          NO_OPENSSL=YesPlease])])
+[
+if "x$NO_OPENSSL" = xYesPlease; then
+	AC_MSG_ERROR([Disabled OpenSSL is required for SHA1])
+else
+	AC_CHECK_LIB([ssl], [SHA1_Init],
+	[NEEDS_SSL_WITH_CRYPTO=YesPlease NO_OPENSSL=],
+	[NEEDS_SSL_WITH_CRYPTO=          NO_OPENSSL=YesPlease])
+fi
+])
 
 GIT_UNSTASH_FLAGS($OPENSSLDIR)
 
-- 
2.26.0.rc2.234.g969ad452ca

