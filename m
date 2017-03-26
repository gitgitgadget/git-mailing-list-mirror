Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71FF020958
	for <e@80x24.org>; Sun, 26 Mar 2017 16:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751439AbdCZQB7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Mar 2017 12:01:59 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:57980 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751389AbdCZQB6 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Mar 2017 12:01:58 -0400
Received: from genre.crustytoothpaste.net (unknown [172.16.2.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id DD84C280AE;
        Sun, 26 Mar 2017 16:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1490544111;
        bh=V0XHccvWCahJrwEO9LNJv3q10vKWggW8okwpDmgbROg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rOn9e9zny0oiYm/UfjOv4/XVNpjTyfLhELGPeOpen2CuWCkMCVB5OdPhD7TON0MEi
         3keYOH/sTy64vEHcrK7yNJ0C0cCEAqUqyb34VikshEkt4MsRUpslbqtXKndGvF+3BS
         shuN8PZal3bpCq7DOcamT9r+cc75ZMTC52SIvs5VJSN9IofCHLX6IVbiBgmdUbACsG
         vTVYkgB5Y5wK0EpEiZX0B8xLbf8MkNV4ix8r/1voqgKCy7mcj6iEDQ1OVYJZ/n/9Wx
         s02VFeddh3Ajd+n/8ChNay+xmeDhIMRAiWXX05WLjv1VLsNWJAEPEJbzoocZutXtiA
         0NcI5lThUerlrrEm6m9UWgpDOQ19XslpZ6q87RnPY3AHWt/Soh7J9ocmA/u8jc/S6o
         pdSmY8bdvuQkHF2AizNacxzeCL2M/T3Yp93YdhW/dZc8mFfmcQHoXLw4FYJl62rOJR
         jjd1xZ1cjBNygn9iLkSPp6GyOm5P35vj6iUJAKJKF688W8IpLam
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 01/21] Define new hash-size constants for allocating memory
Date:   Sun, 26 Mar 2017 16:01:23 +0000
Message-Id: <20170326160143.769630-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170326160143.769630-1-sandals@crustytoothpaste.net>
References: <20170326160143.769630-1-sandals@crustytoothpaste.net>
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
index 2214d52f61..af4b2c78cf 100644
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
