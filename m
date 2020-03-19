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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461A9C4332E
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 03:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CDA720722
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 03:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LshXhoyn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgCSD7M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 23:59:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44661 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbgCSD7L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 23:59:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id b72so653834pfb.11
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 20:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qjl6wo2xY3A2Lfckn7hybGnqWof9XzsOESLMx6eP9kg=;
        b=LshXhoynhFgICq92xs1jPa5TBqN32fDXI5+tpyefimejaIk6hc2PLohHK+YBdMRXUW
         StZNal0uD5LmmgbpKPCKsdO1rgtuNUM35ei1My7s2RGZr9Lt6qrpV6/TofzMQ95PJiWm
         BTWihuyaUPN+isrVmMRzAcJxjr2EbHnmbSaVBeSeN9nbEI72V+XDn5NqXW9RhUAsj+W2
         TWXDzDj2CvHDJdfrIUARnw+M4Faqm/ldiUDSxC75UrDGASoMwkU65CkZbZsHKAhGt2EV
         WJkmoB4TJ6pi7qrBPkiJ+itS0UIJzfCJY9ppbB02Kk5QwiXE8/fFAVpDqHU+yc45K0/S
         58Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qjl6wo2xY3A2Lfckn7hybGnqWof9XzsOESLMx6eP9kg=;
        b=CB1sXoiSGXm4AeiHAW6n4DYgK/d+McGOAd6buvkQGq9OGWeNMxChKzrGd2ImzutK6P
         v/LMlMYoqejHmxxxkVdd6QRS02Bm3KBOuA4nnbgM6ahyFquEpImD1PG1pQHx9zJgOu3E
         gf1vxSMY2APv404fHoF/sjronbNnDircVznjubeq+Tb108w4MkOUzMQF6NAlHjPMn5ZC
         UZfBGPYvwk3W9iYe21mpM4e/Ip/ASmSAFlKGl/1aTz4v73hsBwQfod8tDo3q22LlNGpB
         1rl3ztBgvwYNFq2Hzquc7fQknn1Wri3quWyf6qW/Vxws1eELF5Rzw88wRjhAFtSdFaZw
         lHjQ==
X-Gm-Message-State: ANhLgQ0wsXoMd7tRzMuDmt8oCLWUbFnM6cm7P4Xz/we2zuf1f3A97Q4y
        liPtqgQRm5lCeyOdN0VIZlyOlE6i
X-Google-Smtp-Source: ADFU+vtM8Ra80kboS88oP102mhBa6ZTDtgs9lHMtIrKsBxD1Osakf/BvmBeTgJRblW7m3fCbF4/TQA==
X-Received: by 2002:a63:87c1:: with SMTP id i184mr1159789pge.287.1584590350849;
        Wed, 18 Mar 2020 20:59:10 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:fbd2:7e82:2a61:6f4a:cfb4])
        by smtp.gmail.com with ESMTPSA id u6sm506604pgj.7.2020.03.18.20.59.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2020 20:59:10 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, sandals@crustytoothpaste.net,
        sunshine@sunshineco.com
Subject: [PATCH v2 3/3] configure: respect --without-openssl flag
Date:   Thu, 19 Mar 2020 10:58:57 +0700
Message-Id: <9ed6b6cd49bc4cbef8fda3d9a7e08d77d8203740.1584589859.git.congdanhqx@gmail.com>
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
 configure.ac | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configure.ac b/configure.ac
index 896996e177..807bb8bc5a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -542,11 +542,18 @@ AC_MSG_NOTICE([CHECKS for libraries])
 
 GIT_STASH_FLAGS($OPENSSLDIR)
 
+if test -z "$NO_OPENSSL"; then
 AC_CHECK_LIB([crypto], [SHA1_Init],
 [NEEDS_SSL_WITH_CRYPTO=],
 [AC_CHECK_LIB([ssl], [SHA1_Init],
  [NEEDS_SSL_WITH_CRYPTO=YesPlease NO_OPENSSL=],
  [NEEDS_SSL_WITH_CRYPTO=          NO_OPENSSL=YesPlease])])
+else
+	# Fallback to DC SHA1
+	NEEDS_SSL_WITH_CRYPTO=
+	DC_SHA1=YesPlease
+	GIT_CONF_SUBST([DC_SHA1])
+fi
 
 GIT_UNSTASH_FLAGS($OPENSSLDIR)
 
-- 
2.26.0.rc2.234.g969ad452ca

