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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FEAC10DCE
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 07:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D86E20768
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 07:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pm9BGFrb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgCRHiO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 03:38:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33332 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgCRHiN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 03:38:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id n7so13450712pfn.0
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 00:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kM4pmedVqSeiLFX/QSdy/flJPpJ1HBFO8gZODk2S+Dc=;
        b=Pm9BGFrb/2NhZJQ6nrbwSUJXvHPeH9hdFUVwxBeB1/iyTiU6dAWpihseh8Ai6GMpqG
         IHyo1mcftlc0GDcHKUrT1EG/Lmty5f4d7evT5KsJBqXxjAY8LZeSWaPSFS3rNOcezaj8
         xPlYoKh07qN2iJwTkk3e/jukgnfRrWa13NWYuir3TwHbFodeJz+q34L2HIkfg43w37Jm
         HZ4WSmsfBqzTV8O+29UC1cQJa9rjDFWsVijbQyofQJ7VTL3P3gEsgVD5IEK5HJTf+wr6
         hKHSSwpPBcrp1pcPOE6XUGIwMAImpBsaC3icSYMU4FDCqSvOi9EumFBOS5KUSnzmvj8Y
         FLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kM4pmedVqSeiLFX/QSdy/flJPpJ1HBFO8gZODk2S+Dc=;
        b=NrMVKg5qxZ5ejKNbFi66ToiXQQbojxxTDNaR2+T7az01LgJjg0B6j1I/mJ8eQTIr0W
         aWOz7XQBc7JzFwjYAIvo1wsgBu0aw1LR0aM3DCWYYhsO/vkAFp9c8hoDFgDmoPayOz7t
         +/G1yTk7WLI0WLLKEb21N/X+2uBJMagoLGMNXHsj7kaOPfBgpTCsGioa0dg8tzSn2KZK
         Uc5tErgJCh2tRcraFTWMs4Oruc42PLyh/fS+fpDoboDDvL/heSOfBD0f/+AT0Zh1Hn6W
         jNaE3mo5GTy2y24sHfA4ey0HfxDgGjPmvXchqyk3n3QXAjDn3NaNBh+IQjqGCkycN1GZ
         Yn2w==
X-Gm-Message-State: ANhLgQ3OoyehBadeQ9UvyYh/2C9eiY6OpdDQ1n5qAB2fkIIe/1+s/VdS
        ninPBxKbWPfKxLwCqTWqlQJxLUGM
X-Google-Smtp-Source: ADFU+vtE7PK3iSnWeuoWUWiwjbWBFL1Re9kowLtKaLnvz9ftA96bCW1WI3I/NsRTI0cNcPIUgvbTog==
X-Received: by 2002:a62:1c4c:: with SMTP id c73mr2884046pfc.64.1584517092008;
        Wed, 18 Mar 2020 00:38:12 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:fbd2:7e82:2a61:6f4a:cfb4])
        by smtp.gmail.com with ESMTPSA id 25sm5419748pfn.190.2020.03.18.00.38.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2020 00:38:11 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 1/3] configure: respect --without-curl flags
Date:   Wed, 18 Mar 2020 14:38:00 +0700
Message-Id: <c1c007190683d7ab49e854a66a4832b5ace72b51.1584516715.git.congdanhqx@gmail.com>
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
 configure.ac | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 66aedb9288..f4742878c0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -592,6 +592,9 @@ fi
 # git-http-push are not built, and you cannot use http:// and https://
 # transports.
 
+# Respect --without-curl
+if test "x$NO_CURL" != "xYesPlease"; then
+
 GIT_STASH_FLAGS($CURLDIR)
 
 AC_CHECK_LIB([curl], [curl_global_init],
@@ -600,8 +603,6 @@ AC_CHECK_LIB([curl], [curl_global_init],
 
 GIT_UNSTASH_FLAGS($CURLDIR)
 
-GIT_CONF_SUBST([NO_CURL])
-
 if test -z "$NO_CURL"; then
 
 AC_CHECK_PROG([CURL_CONFIG], [curl-config],
@@ -622,6 +623,9 @@ fi
 
 fi
 
+fi
+
+GIT_CONF_SUBST([NO_CURL])
 
 #
 # Define NO_EXPAT if you do not have expat installed.  git-http-push is
-- 
2.26.0.rc2.234.g969ad452ca

