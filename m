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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5703C5ACD6
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 07:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF1220768
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 07:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzalW06v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgCRHiS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 03:38:18 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36792 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgCRHiS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 03:38:18 -0400
Received: by mail-pf1-f194.google.com with SMTP id i13so13450971pfe.3
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 00:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=etPGNQLCZ1+Al2EOOJhv0p/VLRJQU2BbhCDaqBFXFjI=;
        b=PzalW06v6Q1MzFKLv8IxMKFTDbUE3gJFSrA/qQX8jM/t0ilTlT49VCpr/YkTaNjg7w
         FSsU0kzIo6WeIvkt7u39BiCCqgjYko2vqDDexOMKx0KfdPK6qPe31BputmLeglaTYI9r
         J8s5ANzT3B5cxaLNzFmIPU6t2UWkT3Fiy75aRwKkkoqFRZRZGItrRpmlOnz/3A4bxNHO
         CNVi5kgrUz+llsislR30uWMqzRVGsyc5Q86aKd3ntoz+emMhG+D9yhw8Wf8wH5mxwFzc
         czrNjWHvPqJF601XjjlXv3EN59EQPsLigkyVhM8cfImNK+LktOTFwCuyaliblo2c6N5i
         SgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=etPGNQLCZ1+Al2EOOJhv0p/VLRJQU2BbhCDaqBFXFjI=;
        b=FVxgvawy0OoEKxLFY4YLA1UuxYRLFQUFhh3uQt/iXKHUvnBMG78y3mz0s9n80GFZRR
         QrBhpfBxMrcSFRl6POijQ3Vr6luZeY0Dlve+IcqZbjfkf0MOZw5WuXPbaZioYIElXmRg
         vyMCCjWoEEdnQM6Ys5Er0HpszL318M28J22WwB/IYBAMbJdCVWS8GSDIO8MADrKFz8J5
         aoZr5wJ2KRJFizbZp2x3F++ycR0Vs6IaDXgQiysOpVnXO+ZV6F4APd02e+D0PGehphvz
         w9bavXmL1IbD4HQLFLxDQf0S66BxtVq3D0frvwZhWg+r/xtYMhawfvBCKX9PDuDrkYFK
         7pdw==
X-Gm-Message-State: ANhLgQ16QT6GMaAVaAlS+fSVXawmS2BNSI4pMjkpkyoNITfRbxEUMafS
        3tgFVr+bGeeQehNxqpkWuk7znJGh
X-Google-Smtp-Source: ADFU+vvROsVdC57dZ2TmnIsVw1ejIt3qc2HtjhCQlYB6zsl2qsoeXBRSKR/y4IsbrDSI4lt+uYczZg==
X-Received: by 2002:a62:e505:: with SMTP id n5mr3083190pff.189.1584517096915;
        Wed, 18 Mar 2020 00:38:16 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:fbd2:7e82:2a61:6f4a:cfb4])
        by smtp.gmail.com with ESMTPSA id 25sm5419748pfn.190.2020.03.18.00.38.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2020 00:38:16 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 2/3] configure: respect --without-expat
Date:   Wed, 18 Mar 2020 14:38:01 +0700
Message-Id: <bd80a1480e5bbed641599be91e54110e00ed1500.1584516715.git.congdanhqx@gmail.com>
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
 configure.ac | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configure.ac b/configure.ac
index f4742878c0..7468eb6bc8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -631,6 +631,9 @@ GIT_CONF_SUBST([NO_CURL])
 # Define NO_EXPAT if you do not have expat installed.  git-http-push is
 # not built, and you cannot push using http:// and https:// transports.
 
+# Respect --without-expat
+if test "x$NO_EXPAT" != xYesPlease; then
+
 GIT_STASH_FLAGS($EXPATDIR)
 
 AC_CHECK_LIB([expat], [XML_ParserCreate],
@@ -639,6 +642,8 @@ AC_CHECK_LIB([expat], [XML_ParserCreate],
 
 GIT_UNSTASH_FLAGS($EXPATDIR)
 
+fi
+
 GIT_CONF_SUBST([NO_EXPAT])
 
 #
-- 
2.26.0.rc2.234.g969ad452ca

