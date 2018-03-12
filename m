Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E0591F404
	for <e@80x24.org>; Mon, 12 Mar 2018 02:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932585AbeCLC2f (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 22:28:35 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34358 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932420AbeCLC23 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Mar 2018 22:28:29 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E21FD609A1;
        Mon, 12 Mar 2018 02:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1520821708;
        bh=nqMhY/7955D1UXegDKR4pB4YTvCCzDk2HSBcOocPxlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=qEAoJl9xmVC16WJdHiN1OCeMnmB/IritgyvGTX3EMgaEXpFkMr+otc///ffbUseHv
         9z8/f8UvgM3UwdL+MGJNqIUZTVoSySldfCgI5Ls1SErNOg/fpJP4WamOhDBLxgIB4H
         mcn0ME8yW3sV2U8qMHBo2UNHDSASZcrdrvzzeWk9Y9Ky4uQC8HjhDPXSn/G+AEt7JL
         GzSdY5VM52Rq6iRPpN+htPvZZktcNJd3Wcbm2it+rhzhx6mQ88c7Q3tU2ZHzQaeUx+
         VIngeeZEYZ1KHdrS2UacbfSf3URG6mJQUHoJU2lyqfSCLukgor+yMSCALtaKfsIbXu
         JdR5t3Ql62QkTakcFA2wNEJ1n7EpRI3myp44Gn3Osak1WAOKPu39Xc4/AHvLJURaND
         2RobKsBZQVvf0Oqs+cB0Xpbc/ffRZmmzRplRI6eq3h9B7Bq4fEWyyPaM1F98tYtVed
         kZzAIcL6p2cQ6vRb2umB/ZPP5kkMGQxGphjVn9xmnkePW6xMHAY
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 14/36] builtin/mktag: convert to struct object_id
Date:   Mon, 12 Mar 2018 02:27:34 +0000
Message-Id: <20180312022756.483934-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.660.g709887971b
In-Reply-To: <20180312022756.483934-1-sandals@crustytoothpaste.net>
References: <20180312022756.483934-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/mktag.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/mktag.c b/builtin/mktag.c
index beb552847b..65bb41e3cd 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -18,13 +18,13 @@
 /*
  * We refuse to tag something we can't verify. Just because.
  */
-static int verify_object(const unsigned char *sha1, const char *expected_type)
+static int verify_object(const struct object_id *oid, const char *expected_type)
 {
 	int ret = -1;
 	enum object_type type;
 	unsigned long size;
-	void *buffer = read_sha1_file(sha1, &type, &size);
-	const unsigned char *repl = lookup_replace_object(sha1);
+	void *buffer = read_sha1_file(oid->hash, &type, &size);
+	const unsigned char *repl = lookup_replace_object(oid->hash);
 
 	if (buffer) {
 		if (type == type_from_string(expected_type))
@@ -38,8 +38,8 @@ static int verify_tag(char *buffer, unsigned long size)
 {
 	int typelen;
 	char type[20];
-	unsigned char sha1[20];
-	const char *object, *type_line, *tag_line, *tagger_line, *lb, *rb;
+	struct object_id oid;
+	const char *object, *type_line, *tag_line, *tagger_line, *lb, *rb, *p;
 	size_t len;
 
 	if (size < 84)
@@ -52,11 +52,11 @@ static int verify_tag(char *buffer, unsigned long size)
 	if (memcmp(object, "object ", 7))
 		return error("char%d: does not start with \"object \"", 0);
 
-	if (get_sha1_hex(object + 7, sha1))
+	if (parse_oid_hex(object + 7, &oid, &p))
 		return error("char%d: could not get SHA1 hash", 7);
 
 	/* Verify type line */
-	type_line = object + 48;
+	type_line = p + 1;
 	if (memcmp(type_line - 1, "\ntype ", 6))
 		return error("char%d: could not find \"\\ntype \"", 47);
 
@@ -80,8 +80,8 @@ static int verify_tag(char *buffer, unsigned long size)
 	type[typelen] = 0;
 
 	/* Verify that the object matches */
-	if (verify_object(sha1, type))
-		return error("char%d: could not verify object %s", 7, sha1_to_hex(sha1));
+	if (verify_object(&oid, type))
+		return error("char%d: could not verify object %s", 7, oid_to_hex(&oid));
 
 	/* Verify the tag-name: we don't allow control characters or spaces in it */
 	tag_line += 4;
