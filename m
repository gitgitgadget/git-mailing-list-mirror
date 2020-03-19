Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE69CC4332B
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 03:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8527520757
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 03:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CX9CSId6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgCSD7I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 23:59:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36576 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgCSD7I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 23:59:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id z72so498060pgz.3
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 20:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qlvzk8lPlAK9QdYuNMQQIHMd8phXFYUooHuXr372k+E=;
        b=CX9CSId6+pRt5UKinG00gu84iPz9HjNdFfjuwI+tGfnTLtZwglubIvpmlTZu9guzTW
         8AVwu3EVCaicSKYpVDYyMOOXyy3QD30KEdmJV9dNszJ8zegiSMMpCe/2MEvNN4Idshew
         A4cxEwdIenDwa0e3bUarRwDwjcqnUzwEC/ki/H9c9tPqjwpY7WmvsKE8YzhurHIjVL5w
         FJla4T6nV/i9W/M4gnovCSsMKbx3fobynCcc1NFeXKgnW9DuzxLReJ98PzxRVrDn/oWB
         oR4IrF0daZNNDV+/ZvCODVwJqMqpK3U//jfCU2IQn9HqIPWUHbOkc6IYkCDfUfHINgGi
         cUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qlvzk8lPlAK9QdYuNMQQIHMd8phXFYUooHuXr372k+E=;
        b=Mo294C3a+iAWIx3Lvo834LAiJ07V+pvr16qMkiqUR8TpjIVjS8MaviWxKZTWp8gFQ5
         b9zt49CrVpZJpOXeCixOOJM4djCUMFAiwh24BRW0TWtbU9mJKpvb3xatisevPgqvMxHH
         sBxidBEuiDw7uyIM9spal24iubdBwXFWC4r/0EqnwOIWKphCHqEKPfZCRWgd9cgyOq0i
         msfhw10FidyPFUPi2YKMAQy5+PVod52oixt3auqK/4x7o9MbfZY9FKUe9n/E54+QCmez
         1py51GmYkUDPFIcs698RoQ9dRRnuO3UrVqKQD5LHvXH8jGfGvycsPZux6+kcGVQbwHAj
         1SEg==
X-Gm-Message-State: ANhLgQ2gz87IwWOhQE9/k3ULtHcxquXGt/HauxMpED4ehWuvged+FJQr
        HiIshBSSt22aWgIA9uNInfRx/0ve
X-Google-Smtp-Source: ADFU+vutLRLbXKjsblWyQ8p4lNtbVEpybHwr1jAfr3wYTpxRqKK7T41hlZPrp2uwKDHeKQ7TrokHPQ==
X-Received: by 2002:a63:fd0f:: with SMTP id d15mr1222966pgh.26.1584590347011;
        Wed, 18 Mar 2020 20:59:07 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:fbd2:7e82:2a61:6f4a:cfb4])
        by smtp.gmail.com with ESMTPSA id u6sm506604pgj.7.2020.03.18.20.59.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2020 20:59:06 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, sandals@crustytoothpaste.net,
        sunshine@sunshineco.com
Subject: [PATCH v2 1/3] configure: respect --without-curl flag
Date:   Thu, 19 Mar 2020 10:58:55 +0700
Message-Id: <e55a1258d5b42c9e761116d02e3bf365e5ee9b4a.1584589859.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.234.g969ad452ca
In-Reply-To: <cover.1584589859.git.congdanhqx@gmail.com>
References: <cover.1584516715.git.congdanhqx@gmail.com> <cover.1584589859.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 configure.ac | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configure.ac b/configure.ac
index 66aedb9288..5a73a592e1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -594,9 +594,12 @@ fi
 
 GIT_STASH_FLAGS($CURLDIR)
 
+# Respect --without-curl
+if test -z "$NO_CURL"; then
 AC_CHECK_LIB([curl], [curl_global_init],
 [NO_CURL=],
 [NO_CURL=YesPlease])
+fi
 
 GIT_UNSTASH_FLAGS($CURLDIR)
 
-- 
2.26.0.rc2.234.g969ad452ca

