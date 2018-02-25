Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BFF31F404
	for <e@80x24.org>; Sun, 25 Feb 2018 21:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751945AbeBYVMs (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 16:12:48 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33840 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751817AbeBYVMj (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Feb 2018 16:12:39 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 462D360E4C;
        Sun, 25 Feb 2018 21:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519593158;
        bh=nqMhY/7955D1UXegDKR4pB4YTvCCzDk2HSBcOocPxlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=NOO1s8w7MfBGBqKpFus52z5mkGfK42tSUc5kovqMQFWGdUTA3N3ApSSVoQ+deNJ+J
         iTyApPjhX2kENE1z2b+ztfsKem9p4GNmmP0ygzOTLCwa7wT5bb4txMhCyaS2og/VL6
         SVnR2rETPsmXsXlFlt1k9VhDJSQYp7dV5HMTNoa1UkvxO2mc4OnA77q0uU7AwtoEAM
         y7Jpmx18oZ8E85bkFNIMsLZkmRQuT+u1+PA9f9yATZSHSc4Qsu4oqba0BJd8puKUB9
         0CEhRPtl/1eL41KATwFcnN+1BFacqB5ak1aQTaK4TidOKxrw+QgzBPtORlgZBPnzQV
         bAWNH1eG6vuqblGh6buN9nzqLiLRRmHomJcAqJ6FsTN3fQaPgowd76XGs8+gGnkvdq
         bJRmxh8nTwAOdIMMSAhtV83+jTKsy5BKu9ijc/45osJDVtneu4ZfG7ff7J3ByrsW9R
         G81EdvYX/dGK/RzcNhXWkqyYWG9ncrjFJxhEiPCCmfPD1s1M1Mv
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 14/36] builtin/mktag: convert to struct object_id
Date:   Sun, 25 Feb 2018 21:11:50 +0000
Message-Id: <20180225211212.477570-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd
In-Reply-To: <20180225211212.477570-1-sandals@crustytoothpaste.net>
References: <20180225211212.477570-1-sandals@crustytoothpaste.net>
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
