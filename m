Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C03851F406
	for <e@80x24.org>; Tue, 16 Jan 2018 09:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751199AbeAPJZY (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 04:25:24 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39064 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbeAPJZX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 04:25:23 -0500
Received: by mail-pf0-f194.google.com with SMTP id e11so9345671pff.6
        for <git@vger.kernel.org>; Tue, 16 Jan 2018 01:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+X42UM09CQHkersKKxN5aCvd8A5rXusFsRE2ZQrCEks=;
        b=nAZYsH53c6Xa2RomTwAaBWJOVTdBJgNWHdD40qzT3bDuk59e7sozK6JPDfX1pPHXb5
         CDmX8xsuLnz2ejABU8qN4RZAAU8bPC2rnPUU+Ao0snn1WKfBF6vOoKU/98KYVCVFyx4L
         XktFLycA6uk/deHEA3q9K7OSGx4x8H1HTUTVJbyAXvdeuaYnbXOVzeW7lnYRD7yaUvdV
         bIWBLs3jPZ5Qz7avGt9hS2bG4jwrzbBmXQjvTztgSngU/g1pZi5Tgn2MMUhjG0stCUTq
         4BShITj0EGzESBZjWyAT7nwvhMrwNdHQKrUGWXEpAVkBGCR7rZv6s0lJW7b5De4f3R4i
         icaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+X42UM09CQHkersKKxN5aCvd8A5rXusFsRE2ZQrCEks=;
        b=KSHene6mHwnSvj1HKFgywmcvsI6u9QnxvT3GRRr6mgrbte4Ji58gWDCqC0ZDUq9De6
         lxuGhTWZLMLxlsSWHmHLrET9t5yIDBO45JbjDoIvIP/yU5jn12yrUJIFddwCRKeZvOjF
         zlkFo9kcnWEuabLV4ckICnRLgPxq+kvnxxFV6dQp8uBIsgwudCzUdYVJ2Hx8HvNu2SW+
         b7A8nHnfwix8TqrPOxcUOG7swwr8Wp4K13rZJoSRRGgIuajwsXts15ZBn28BL/lNla5y
         tkQpB7yYJBTWTUY1FFq0u89gD+f8OBTTd1IzLlo7rWr/NGRage3iNl5Mlb5d2B1dEVw8
         SuHg==
X-Gm-Message-State: AKGB3mKcL9eEk5/L1Wm37onZOtPZs6Yidhj1jkNIIIxTTxBcKAhyzbyo
        EnPLkkdbAUREe+Vafz2HBKhyvA==
X-Google-Smtp-Source: ACJfBouZSgbNBrWiPGk2wltLf/9vxjFVN1HwLLgq8BQxqbnqZ+z38leLL+5JTWzcyFEyt+cnI9SE5w==
X-Received: by 10.99.97.200 with SMTP id v191mr25147034pgb.121.1516094722574;
        Tue, 16 Jan 2018 01:25:22 -0800 (PST)
Received: from ash ([27.75.129.14])
        by smtp.gmail.com with ESMTPSA id v1sm2868300pfd.111.2018.01.16.01.25.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jan 2018 01:25:21 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Jan 2018 16:25:15 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] diff.c: flush stdout before printing rename warnings
Date:   Tue, 16 Jan 2018 16:23:49 +0700
Message-Id: <20180116092349.11330-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.1.600.g899a5f85c6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The diff output is buffered in a FILE object and could still be
partially buffered when we print these warnings (directly to fd 2).
The output is messed up like this

 worktree.c                                   |   138 +-
 worktree.h        warning: inexact rename detection was skipped due to too many files.
                           |    12 +-
 wrapper.c                                    |    83 +-

It gets worse if the warning is printed after color codes for the graph
part are already printed. You'll get a warning in green or red.

Flush stdout first, so we can get something like this instead:

 xdiff/xutils.c                               |    42 +-
 xdiff/xutils.h                               |     4 +-
 1033 files changed, 150824 insertions(+), 69395 deletions(-)
warning: inexact rename detection was skipped due to too many files.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/diff.c b/diff.c
index fb22b19f09..5545c25640 100644
--- a/diff.c
+++ b/diff.c
@@ -5454,6 +5454,7 @@ N_("you may want to set your %s variable to at least "
 
 void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc)
 {
+	fflush(stdout);
 	if (degraded_cc)
 		warning(_(degrade_cc_to_c_warning));
 	else if (needed)
-- 
2.15.1.600.g899a5f85c6

