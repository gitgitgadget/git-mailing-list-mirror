Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DF401F453
	for <e@80x24.org>; Tue, 19 Feb 2019 00:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732246AbfBSAGG (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 19:06:06 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34744 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732233AbfBSAGD (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 19:06:03 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 04C3C61092;
        Tue, 19 Feb 2019 00:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550534761;
        bh=djGtmGWQoZ2/4kWdW91lVER6VquUsqgmCoa91LRkG88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=M/lfMdsaGPcPOWifmN0Gy9HtEYkJtJ/QiAXsK8wcerbsb4nqCRJUGeIMYA7S+Ma30
         OKH98rWDZqf80o8+OItmMbBv1Tfo7xCc0StA1lbt3AAVYG3cDf+lt8w+k20Iw6f89F
         mMoYSiZFfpdtGHjEC1XHhZLgMws3KQJmfE5ooRSwAGyttO3v5UseCUD+Kxhysf0Qri
         deGHPQmPgaKWR+UneH4wt520lJsWTF383fRq0HAkeiDZAEgXPnkXWXro3QS7LmM9R2
         NZwcCIvv1yw6IxGbR/UL7pao08x7hwhR8zm9u0XDbeF1b1raGuQQ+Z1KzAgmtb3Tla
         qgbYj0xiXZ/RNv3rxn/vPX7BGq6iLgHRdfS0hbhUvy1QTPC1zRa+FnuP0caMkkXdPA
         NtzPtbo5sEg2UG7mUn6Rb/vHS5B6TabuvHmD04IY1veB9oyDE1fnJNMRVZkyxII172
         9Uuzpi/zb94sKvTG5PnOo4pUADvDBGn/uWCrSF6D9M/oH9wOaS8
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 21/35] http-walker: replace sha1_to_hex
Date:   Tue, 19 Feb 2019 00:05:12 +0000
Message-Id: <20190219000526.476553-22-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e
In-Reply-To: <20190219000526.476553-1-sandals@crustytoothpaste.net>
References: <20190219000526.476553-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since sha1_to_hex is limited to SHA-1, replace the uses of it in this
file with hash_to_hex.  Rename several variables accordingly to reflect
that they are no longer limited to SHA-1.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 http-walker.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index 8063896cf6..e11670eee2 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -434,9 +434,9 @@ static int http_fetch_pack(struct walker *walker, struct alt_base *repo, unsigne
 
 	if (walker->get_verbosely) {
 		fprintf(stderr, "Getting pack %s\n",
-			sha1_to_hex(target->hash));
+			hash_to_hex(target->hash));
 		fprintf(stderr, " which contains %s\n",
-			sha1_to_hex(sha1));
+			hash_to_hex(sha1));
 	}
 
 	preq = new_http_pack_request(target, repo->base);
@@ -473,9 +473,9 @@ static void abort_object_request(struct object_request *obj_req)
 	release_object_request(obj_req);
 }
 
-static int fetch_object(struct walker *walker, unsigned char *sha1)
+static int fetch_object(struct walker *walker, unsigned char *hash)
 {
-	char *hex = sha1_to_hex(sha1);
+	char *hex = hash_to_hex(hash);
 	int ret = 0;
 	struct object_request *obj_req = NULL;
 	struct http_object_request *req;
@@ -483,7 +483,7 @@ static int fetch_object(struct walker *walker, unsigned char *sha1)
 
 	list_for_each(pos, head) {
 		obj_req = list_entry(pos, struct object_request, node);
-		if (hasheq(obj_req->oid.hash, sha1))
+		if (hasheq(obj_req->oid.hash, hash))
 			break;
 	}
 	if (obj_req == NULL)
@@ -557,20 +557,20 @@ static int fetch_object(struct walker *walker, unsigned char *sha1)
 	return ret;
 }
 
-static int fetch(struct walker *walker, unsigned char *sha1)
+static int fetch(struct walker *walker, unsigned char *hash)
 {
 	struct walker_data *data = walker->data;
 	struct alt_base *altbase = data->alt;
 
-	if (!fetch_object(walker, sha1))
+	if (!fetch_object(walker, hash))
 		return 0;
 	while (altbase) {
-		if (!http_fetch_pack(walker, altbase, sha1))
+		if (!http_fetch_pack(walker, altbase, hash))
 			return 0;
 		fetch_alternates(walker, data->alt->base);
 		altbase = altbase->next;
 	}
-	return error("Unable to find %s under %s", sha1_to_hex(sha1),
+	return error("Unable to find %s under %s", hash_to_hex(hash),
 		     data->alt->base);
 }
 
