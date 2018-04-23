Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A12D91F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932744AbeDWXkd (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:40:33 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60532 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932738AbeDWXk3 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 19:40:29 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 62B0260B3B;
        Mon, 23 Apr 2018 23:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524526828;
        bh=lbrjuRNp+Vxx6jdPrBW9KZBqW1TXM9mCmQpHC4oMdes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=vXI3h7UOq62rS4xPI1zMOMJYca0Y5LBG3jNRWikOrW6l5e/Tw/7W/ufi6J06OEASd
         UAd3l3PqNb3N9jVLYJr9brXnLPmeMUYKf2pIYvlD2ydayS+/injG53f/NtQiZvH0Vq
         JCMLiEUKBv6DCO/PUGV97b4w2WewUYFX0qySVPhqkvmf6esyE6ZKMu5uzcYpcJqiTh
         zCgghV++PxVtdbcR+wIdAamDXWe+ne3qM1p8EO7QYpCI8TDhlyz/VyYzZ33q7O+oct
         4oe2TM5ExMQdR7OyDIP4h8ONcfbgvLiUR4LHm+uk8QQO1WIxhgYd08iazg0b0XGIyj
         BI8Puni6Ye8G9XLaaALdDkhICFLSnyLMXrTruh6TJ+LCCl1/b8d7zOvIYtT6lcxkwL
         iLmu2Pii2q0UOZkBwuruI4pGJgKsZRTNr8LIxbC2qD3IlKw3194Hke9W8l+zcQ3WgB
         2JMrNGtncsFhQGw28CvptDMBYcHV89vRjrR+nhlotExHOmcPMJ3
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 22/41] revision: replace use of hard-coded constants
Date:   Mon, 23 Apr 2018 23:39:32 +0000
Message-Id: <20180423233951.276447-23-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180423233951.276447-1-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace two uses of the hard-coded constant 40 with references to
the_hash_algo.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 revision.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index ce0e7b71f2..daf7fe6ff4 100644
--- a/revision.c
+++ b/revision.c
@@ -1751,6 +1751,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	const char *arg = argv[0];
 	const char *optarg;
 	int argcount;
+	const unsigned hexsz = the_hash_algo->hexsz;
 
 	/* pseudo revision arguments */
 	if (!strcmp(arg, "--all") || !strcmp(arg, "--branches") ||
@@ -2038,8 +2039,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->abbrev = strtoul(optarg, NULL, 10);
 		if (revs->abbrev < MINIMUM_ABBREV)
 			revs->abbrev = MINIMUM_ABBREV;
-		else if (revs->abbrev > 40)
-			revs->abbrev = 40;
+		else if (revs->abbrev > hexsz)
+			revs->abbrev = hexsz;
 	} else if (!strcmp(arg, "--abbrev-commit")) {
 		revs->abbrev_commit = 1;
 		revs->abbrev_commit_given = 1;
