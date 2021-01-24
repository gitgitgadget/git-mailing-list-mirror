Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C86C433DB
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 01:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BCB9225AC
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 01:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbhAXB7V (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 20:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbhAXB7U (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 20:59:20 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B66C0613D6
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 17:58:39 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id a1so8777906wrq.6
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 17:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ieUgqlwfK1UM1CwPj1QDLIftg78rRmybIoi+rdP16NQ=;
        b=OKnGw3pVJGrrn/WbonuC9s8/MMj+sqXpJ+OWEgDuTkqZgGsLukX1JAKb6mh6twhkT3
         96XBzOtEW3F+A3mJArDawddx0pa223eDApwZb0JGNeEnNjXZzlD/QxO/VkTpgBnhUjxh
         swo+QCTKIfdk1AmFnFpgHsHk3iuNgemRT8UFG6XMuhGT8/Fn90bcfSD+pDp9oHwnlTq8
         Zna6tYYhkBazdWGwEYG+qsv+MSHjPOx8D8qA8UZltuhzJih25qGRNuPbdZRAu57P1CXt
         zrhWWlZPXsRuhVjrTXmQoNhe+2GTEIVWbIRoBYZzdZamqecKOmd8Iovpm5MKK2/WPNAb
         Hnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ieUgqlwfK1UM1CwPj1QDLIftg78rRmybIoi+rdP16NQ=;
        b=EGSYiS4ug4EWbwm/W+1uxDMidF62dbgV0HtivzAUCDxeVb/a3DEACR4DlLlSJP6wUE
         AaidleMCT9C+MIyOloCao6XayCVITGFmjTRFAWrDnOBDIv9FCMYkpwlt2T3IkoRTMHbo
         hsC9ay3cz7wJWVQ7GS1lmGJNFlAZB7+HwT0yl3Pmij+G+sjP1fEAbevmpAtO2+4ElCvk
         +YX2opvpYoZKIaGaE6Kla6n0/ewdZKJkXRA7oWGULbZJR8loUyJEuJErBK7niAM7boCY
         nrj7lWLHDECZdZwqKhwZ2IFz3iKmhu1EC7ScPrEy92y5559hf17aclxMxZ7JTeBhGbfY
         0SeA==
X-Gm-Message-State: AOAM533hXVom8ZG8WPyDFvTiivP/zNE/+4HAP1ZL6yNCJbBfIOnYN6Mh
        QIGjUwUZiajxBcJLSEl0B5XI7KeINFq7/Q==
X-Google-Smtp-Source: ABdhPJzgV/YFyPWiuKQHLtiDjVQRQNUX5hAWJdx4vE32IOAU3lSMrgKnyA/7PP+BA+FbNEWObGCENg==
X-Received: by 2002:adf:e984:: with SMTP id h4mr1680350wrm.247.1611453518129;
        Sat, 23 Jan 2021 17:58:38 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s19sm19810139wrf.72.2021.01.23.17.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 17:58:37 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] config.mak.uname: remove redundant NO_LIBPCRE1_JIT flag
Date:   Sun, 24 Jan 2021 02:58:32 +0100
Message-Id: <20210124015833.2753-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove a flag added in my fb95e2e38d (grep: un-break building with
PCRE >= 8.32 without --enable-jit, 2017-06-01). It's set just below
USE_LIBPCRE=YesPlease, so it's been redundant since
e6c531b808 (Makefile: make USE_LIBPCRE=YesPlease mean v2, not v1,
2018-03-11).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 config.mak.uname | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index 198ab1e58f..e22d4b6d67 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -664,7 +664,6 @@ else
 		NO_GETTEXT =
 		USE_GETTEXT_SCHEME = fallthrough
 		USE_LIBPCRE= YesPlease
-		NO_LIBPCRE1_JIT = UnfortunatelyYes
 		NO_CURL =
 		USE_NED_ALLOCATOR = YesPlease
 	else
-- 
2.29.2.222.g5d2a92d10f8

