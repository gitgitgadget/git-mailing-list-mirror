Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB9E52095B
	for <e@80x24.org>; Sat, 18 Mar 2017 21:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751292AbdCRVbQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 17:31:16 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:46190 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751266AbdCRVbI (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Mar 2017 17:31:08 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id EB57E280B5;
        Sat, 18 Mar 2017 21:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1489872002;
        bh=OCllgegdouh7FKaCVzlsSX0nCekoNSXMCnNJ5OfZMc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HQ7AQJv5RVyihQoFnDQ771YPZJaoxN55qH/C4DL6yyz5XyB1Uy3dZATku/EGk1Iv9
         gc+cuytGD5RHDFCPYMX/hSIVF4Og7jf1oZwK7a4oZTIHqSgpIUZycXQsYy2xrkmcIL
         Oazdf/7IcCUD6Ujzhmf+BVSX9mC6IJ3IpbXrn5WcmYBWXJy7ZD6kDoFzWkOcNkYWjO
         XXK7NRC/OZQa5HmVgQ8wHsJNx0StSU4ePFRkLVCD+C8TwhV5IrqarMmrepIrcHheEp
         IC3shKy8yPLl0QZixsdCZedRrGG3b7M6JVKFDapIMnN6X8jYP09RHCxxBmXcbqPOFw
         zSyokR45SeDOdYz0BReOpKdmVcALsAQWWH3RdJTXzoZcDB2Trb1uTFGhiplmEA0N+M
         D83q3YItkhWDBlJnGLPforZXUhd2oQxeyd0iVMQ5WDVh05jq1p4Gu5MiaE5kDfhGoU
         rQESULbITOj/1qDU4u4nSNRsss7Ak59eNqCZQN8YTfFyOOU/laz
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 08/20] parse-options-cb: convert sha1_array_append caller to struct object_id
Date:   Sat, 18 Mar 2017 21:19:42 +0000
Message-Id: <20170318211954.564030-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170318211954.564030-1-sandals@crustytoothpaste.net>
References: <20170318211954.564030-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 parse-options-cb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/parse-options-cb.c b/parse-options-cb.c
index b7d8f7dcb2..40ece4d8c2 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -96,7 +96,7 @@ int parse_opt_commits(const struct option *opt, const char *arg, int unset)
 
 int parse_opt_object_name(const struct option *opt, const char *arg, int unset)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 
 	if (unset) {
 		sha1_array_clear(opt->value);
@@ -104,9 +104,9 @@ int parse_opt_object_name(const struct option *opt, const char *arg, int unset)
 	}
 	if (!arg)
 		return -1;
-	if (get_sha1(arg, sha1))
+	if (get_oid(arg, &oid))
 		return error(_("malformed object name '%s'"), arg);
-	sha1_array_append(opt->value, sha1);
+	sha1_array_append(opt->value, oid.hash);
 	return 0;
 }
 
