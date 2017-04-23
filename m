Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFFBD207E2
	for <e@80x24.org>; Sun, 23 Apr 2017 21:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1046286AbdDWViO (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 17:38:14 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37558 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1046153AbdDWVgB (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Apr 2017 17:36:01 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id EEF6D280D9;
        Sun, 23 Apr 2017 21:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1492983342;
        bh=4Aah0QPZnN3sMvpWAVWvYLoUrYEdAmoP/LF2fg9FgwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WWwe7hetEoqDesgwla4OXszOXitKupAUwQ66A68h5onxSKu2c7fX8YG/bu2xx/XPl
         JHsSMGHxjAvAF1dqv6AduOw2Ppm527r/2Mt7YonUo383EU55ik6OgUV/SzF59/DamR
         esTuI1PyfX4+NN2TO1qGiDb2OQV9M3ikz1GAZp2Fd2tOamBDy9zjMrmvT8wX03xN9z
         lOUs9CUrAtWCyjTlCfKoLA4jAGFNQo48Zes48xhhsfzj+pt1BbD4KUCgi9CZIjoS/C
         7OZy4EPtMCVZ6qnVqNJX5+hYfnckOguEwpkDVnrkNsS/351I1qVHfisPouyRq5ufio
         Fa0B9z776x/NfBqPGbwLyisDOb09Uqkk0x/BZy8+7K2EFES1d6T61T9GdEEXTL6KfY
         WugUZowx0aw7DyOx+a7qRlAzQohNHRyL3urEgPgoRFZeY4Z9WXkFqf6EdsAo3J7ug6
         iO14GvA5N7LC+LAkZeDNq3OnRspiGuX9l99v9lOmR594KiXIoOy
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 44/53] sha1_name: convert internals of peel_onion to object_id
Date:   Sun, 23 Apr 2017 21:34:44 +0000
Message-Id: <20170423213453.253425-45-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226
In-Reply-To: <20170423213453.253425-1-sandals@crustytoothpaste.net>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 sha1_name.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index b7e09ac13..72e72ab9a 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -798,7 +798,7 @@ struct object *peel_to_type(const char *name, int namelen,
 static int peel_onion(const char *name, int len, unsigned char *sha1,
 		      unsigned lookup_flags)
 {
-	unsigned char outer[20];
+	struct object_id outer;
 	const char *sp;
 	unsigned int expected_type = 0;
 	struct object *o;
@@ -846,10 +846,10 @@ static int peel_onion(const char *name, int len, unsigned char *sha1,
 	else if (expected_type == OBJ_TREE)
 		lookup_flags |= GET_SHA1_TREEISH;
 
-	if (get_sha1_1(name, sp - name - 2, outer, lookup_flags))
+	if (get_sha1_1(name, sp - name - 2, outer.hash, lookup_flags))
 		return -1;
 
-	o = parse_object(outer);
+	o = parse_object(outer.hash);
 	if (!o)
 		return -1;
 	if (!expected_type) {
