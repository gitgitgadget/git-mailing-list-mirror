Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E905C4332D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 03:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A4020753
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 03:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTXKm4Ko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgCSD7H (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 23:59:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39880 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgCSD7G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 23:59:06 -0400
Received: by mail-pl1-f195.google.com with SMTP id m1so459607pll.6
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 20:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bwoJod4U/j6ovJ8aF2y2Zan9KzxL61gkTGRNmNLOmlw=;
        b=TTXKm4KoI9z9+W7Sw51I/KG8eTB8J6kWIh7LNIY8xLbwxy7kB6hV+MZE3dd25BqrBG
         m88rj6uGcQD7BvEE9wqfOrrOpkDLyyH3KS0xe984xb357EbZV/zrtqw0o/hEe9TauUYd
         Zv9qFIU7Pha13In3n1IQMrnh51bf8kaR2Ysw8GIZojojt+XyN+Am/WQEVPXE7CQem/j5
         YdXPj1y9zImopLOFZnSwUHqRV5wt4rTe16CZP4t4meFUcgDAHMG4r4laHf0vt5/SLBqA
         0n2NMnTYG6WfLdjttHVGJPfG6sNilmHCw3UM3rfDDEWB+ls4wDE3kCHavGa4xqbqWePF
         mjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bwoJod4U/j6ovJ8aF2y2Zan9KzxL61gkTGRNmNLOmlw=;
        b=DEnnze8HkcMSuhHJHbV5C2fUkIrrzxqcBuFOpiF2d9tk0UO4Jnvu5QN8QMGcy1UhaL
         b7vzQuoU1EOtujNuCvS7nXQQnmsWgyatB11UiraB4zWzfDnoycHr/wZBPtGHKuNnggMi
         U2zgfefW6++dvnSDio39IPlQto6j7HwrsFA9OCNL5/1blnIctNFhZkbqH/Jl5c8rR7NN
         c31y5f4lLdP/Gn7EX+NUc3Yw9bQGj+WWtg2oqkUIEVarSWJ21igh4Hkb5Q+H3R9m6cpr
         866Ox5AKe/aX4p0R+id32xBboX2qH8wlfthBbyLjNTwP44xE580l9GWIJvL+w4VikcDx
         UXnQ==
X-Gm-Message-State: ANhLgQ3R+dxW3HYaDdzF4O4/4kRRkuzDqGdKduGvMHtktxgPZBoAD+HG
        RPtatHQgDH3w0NqlpXRJcwdbDq8O
X-Google-Smtp-Source: ADFU+vvvL/L2wagZmd4oeuwXDy+b5fCtaERp0GOS5l0OeN2/N3YChHP9DZDef8LhEPzc6CkyRBLIOw==
X-Received: by 2002:a17:902:5a44:: with SMTP id f4mr1570050plm.306.1584590345024;
        Wed, 18 Mar 2020 20:59:05 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:fbd2:7e82:2a61:6f4a:cfb4])
        by smtp.gmail.com with ESMTPSA id u6sm506604pgj.7.2020.03.18.20.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2020 20:59:04 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, sandals@crustytoothpaste.net,
        sunshine@sunshineco.com
Subject: [PATCH v2 0/3] configure: respect --without-<package> flags
Date:   Thu, 19 Mar 2020 10:58:54 +0700
Message-Id: <cover.1584589859.git.congdanhqx@gmail.com>
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

Current git's configure script allow --without-<package>,
it rightfully set NO_<PACKAGE> in the beginning of the configure script,
but overwrite them with autodetect later.

Respect them now.

Change from v1:
- Simply check if NO_<PACKAGE> is empty or not instead of explicitly
  check for YesPlease
- --without-openssl will ignore libcrypto all-together and fallback
  into DC_SHA1

Đoàn Trần Công Danh (3):
  configure: respect --without-curl flag
  configure: respect --without-expat flag
  configure: respect --without-openssl flag

 configure.ac | 13 +++++++++++++
 1 file changed, 13 insertions(+)

Interdiff against v1:
diff --git a/configure.ac b/configure.ac
index 20a11e1f32..807bb8bc5a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -542,17 +542,18 @@ AC_MSG_NOTICE([CHECKS for libraries])
 
 GIT_STASH_FLAGS($OPENSSLDIR)
 
+if test -z "$NO_OPENSSL"; then
 AC_CHECK_LIB([crypto], [SHA1_Init],
 [NEEDS_SSL_WITH_CRYPTO=],
-[
-if "x$NO_OPENSSL" = xYesPlease; then
-	AC_MSG_ERROR([Disabled OpenSSL is required for SHA1])
+[AC_CHECK_LIB([ssl], [SHA1_Init],
+ [NEEDS_SSL_WITH_CRYPTO=YesPlease NO_OPENSSL=],
+ [NEEDS_SSL_WITH_CRYPTO=          NO_OPENSSL=YesPlease])])
 else
-	AC_CHECK_LIB([ssl], [SHA1_Init],
-	[NEEDS_SSL_WITH_CRYPTO=YesPlease NO_OPENSSL=],
-	[NEEDS_SSL_WITH_CRYPTO=          NO_OPENSSL=YesPlease])
+	# Fallback to DC SHA1
+	NEEDS_SSL_WITH_CRYPTO=
+	DC_SHA1=YesPlease
+	GIT_CONF_SUBST([DC_SHA1])
 fi
-])
 
 GIT_UNSTASH_FLAGS($OPENSSLDIR)
 
@@ -598,17 +599,19 @@ fi
 # git-http-push are not built, and you cannot use http:// and https://
 # transports.
 
-# Respect --without-curl
-if test "x$NO_CURL" != "xYesPlease"; then
-
 GIT_STASH_FLAGS($CURLDIR)
 
+# Respect --without-curl
+if test -z "$NO_CURL"; then
 AC_CHECK_LIB([curl], [curl_global_init],
 [NO_CURL=],
 [NO_CURL=YesPlease])
+fi
 
 GIT_UNSTASH_FLAGS($CURLDIR)
 
+GIT_CONF_SUBST([NO_CURL])
+
 if test -z "$NO_CURL"; then
 
 AC_CHECK_PROG([CURL_CONFIG], [curl-config],
@@ -629,27 +632,22 @@ fi
 
 fi
 
-fi
-
-GIT_CONF_SUBST([NO_CURL])
 
 #
 # Define NO_EXPAT if you do not have expat installed.  git-http-push is
 # not built, and you cannot push using http:// and https:// transports.
 
-# Respect --without-expat
-if test "x$NO_EXPAT" != xYesPlease; then
-
 GIT_STASH_FLAGS($EXPATDIR)
 
+# Respect --without-expat
+if test -z "$NO_EXPAT"; then
 AC_CHECK_LIB([expat], [XML_ParserCreate],
 [NO_EXPAT=],
 [NO_EXPAT=YesPlease])
+fi
 
 GIT_UNSTASH_FLAGS($EXPATDIR)
 
-fi
-
 GIT_CONF_SUBST([NO_EXPAT])
 
 #
-- 
2.26.0.rc2.234.g969ad452ca

