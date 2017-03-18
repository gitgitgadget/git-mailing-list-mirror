Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FA602095B
	for <e@80x24.org>; Sat, 18 Mar 2017 23:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbdCRXPQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 19:15:16 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:46260 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751315AbdCRXPI (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Mar 2017 19:15:08 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 5BC5C280AE;
        Sat, 18 Mar 2017 21:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1489872000;
        bh=CulWmSqH0+mV/gtzCpLWj7uXSRpTADdONuQoUsiSQvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r1TwTIX7Uxg5iEV+YxOn3sP5cziQRHDrRDnGovM50brH4roBQwC2g8YMCtIzb5HQw
         Y3v1sgB+Nf3OAvC2RSZKj75MzbKBk/wiPm3MMfrC3Y3gdWljITlvsHZOQkdvair1c1
         fW4zqjYQgeqI1RKpoi8WTTVwIa9ckFKHICn5WdM6SAQe6kT5nZyNfqcQfPKbgohtAU
         53T5YsvqYRLWu8UioK5RYOngUj8crIysTEG8x1xOjA4PACq6aNZOeN/mDwHnHAqRZ+
         xev+VB2YnX4JXcLjXTrvCo4+oFh8IZg9zOEVJAdR17+DVMzIixfskWjTexDkd2ld+6
         Jva8uh1voR5mP6O3u/ehEuh+2Q6HW+bH8RuTugGi69o6iMX0n9a4LhCn0koLSDPq5M
         YmsdrB/WLl/apUbdwMEMR7on5hGP7mKdcmTYvWxBEwUd6xK1FGvLVKjclYCn02NYZR
         gXvYxgz9KoEs0HrFunvw/4i+O7q9sSnqmLeSsa1/udGcM/S533L
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 01/20] Define new hash-size constants for allocating memory
Date:   Sat, 18 Mar 2017 21:19:35 +0000
Message-Id: <20170318211954.564030-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170318211954.564030-1-sandals@crustytoothpaste.net>
References: <20170318211954.564030-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since we will want to transition to a new hash at some point in the
future, and that hash may be larger in size than 160 bits, introduce two
constants that can be used for allocating a sufficient amount of memory.
They can be increased to reflect the largest supported hash size.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index 9b2157f591..cb301d8d7d 100644
--- a/cache.h
+++ b/cache.h
@@ -66,8 +66,12 @@ unsigned long git_deflate_bound(git_zstream *, unsigned long);
 #define GIT_SHA1_RAWSZ 20
 #define GIT_SHA1_HEXSZ (2 * GIT_SHA1_RAWSZ)
 
+/* The length in byte and in hex digits of the largest possible hash value. */
+#define GIT_MAX_RAWSZ GIT_SHA1_RAWSZ
+#define GIT_MAX_HEXSZ GIT_SHA1_HEXSZ
+
 struct object_id {
-	unsigned char hash[GIT_SHA1_RAWSZ];
+	unsigned char hash[GIT_MAX_RAWSZ];
 };
 
 #if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
