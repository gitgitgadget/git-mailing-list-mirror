Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1946AC433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 08:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF75460F4A
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 08:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238314AbhIMI5s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 04:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238312AbhIMI5r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 04:57:47 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA50C061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 01:56:32 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id x5so7451546qtq.13
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 01:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4XFtO4rfgFN8kQALf8OlEda79nvLwivi0RNh2hAVi54=;
        b=ZzZ1YKdoH4bAKeXBkLpZuRy7JQ48guWf8HKHjCypOWRTRIl6NTlEvamhWm8jr21v0b
         T4jUUw2MA7G5/nnXvrEAlqJBRdzoKkEdrG1erRZV9mQ6ZED2RWmJjpGNylOk0gcgoQ2A
         BQagaC/dKDTeh6lKzaUB76vdHmvzG8PwwxegP2impSXd2U+MaKyjoRByui2TClFblv6q
         xa1QJJY7A9PJO0V3NhrB7KsUTQ1eshtDQo5NhJo9WQRvVdzW7H58tggDYcmam4cgchwM
         J9i+vlytB/uCuVwGDAmU5hV7d2NGDWfYDM5mLvIG+4N8EFxgxeCReCgjBMHcgGOqRngL
         iXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4XFtO4rfgFN8kQALf8OlEda79nvLwivi0RNh2hAVi54=;
        b=ShXmmKJpHphz9IxBFUPEtTvEpN3UHTKYcwIQngHwZAKMZGIoO63/FLPmqjPDm2PPcY
         Sx4l/RpQ8OirI3FSBcc/MxPEaXm1feuNadVuQ7lLB9SGg9hwAAI/QPUIIrzFQlQrWgxK
         M90QTk8B5ZA2CPfPIvNYroHrPw/NKUvjpDtsSdZJJLzeLUeeLAeB3iMni4GOo5FgjDh7
         jl1ivxJqVW2fOQu1dV34eTFmxbzd/OlJk/0utKswMBdGdtNbXFcBRtdIW/iL/ErI8leI
         VtLWGTmvhmba/Av5nTz/fhwl1G2xOOnoEzFdhkVWzNOtDkmJSAYReSELq3A6klBEkb1W
         0f1A==
X-Gm-Message-State: AOAM531h1m7JHaVOjne3DJ5gk5fToX2pAtRUT6GMBJyU/mYlXME1Qy8c
        I6tGS7bUl15SuRi5bBdsMM3dQDFpO/A=
X-Google-Smtp-Source: ABdhPJzWEiRU+VQ9Q1MDYPlhQa2F4F/9tdIW0/DpE3fb5cajNkmcDAYhtKL8aoXBx+qJK8DMlQyPdA==
X-Received: by 2002:ac8:5442:: with SMTP id d2mr8670387qtq.176.1631523391121;
        Mon, 13 Sep 2021 01:56:31 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id q10sm4994321qke.108.2021.09.13.01.56.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Sep 2021 01:56:30 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     bagasdotme@gmail.com, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2 3/3] git-compat-util: include declaration for unix sockets
Date:   Mon, 13 Sep 2021 01:56:00 -0700
Message-Id: <20210913085600.35506-4-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210913085600.35506-1-carenas@gmail.com>
References: <20210912202830.25720-1-carenas@gmail.com>
 <20210913085600.35506-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Available since Windows 10 release 1803, therefore only added if
not using NO_UNIX_SOCKETS (which is not the current default).

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 git-compat-util.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index b46605300a..6a420d104c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -160,6 +160,9 @@
 # endif
 #define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
 #include <winsock2.h>
+#ifndef NO_UNIX_SOCKETS
+#include <afunix.h>
+#endif
 #include <windows.h>
 #define GIT_WINDOWS_NATIVE
 #endif
-- 
2.33.0.481.g26d3bed244

