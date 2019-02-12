Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C65B61F453
	for <e@80x24.org>; Tue, 12 Feb 2019 01:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfBLBXl (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 20:23:41 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34346 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727227AbfBLBXk (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Feb 2019 20:23:40 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EB9FF60E5A;
        Tue, 12 Feb 2019 01:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549934618;
        bh=6lFN0qiDIfVD5kLeIIGjcDrmBFAO3vCq4WNSLzWU0TQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ry2O1s2Q5SMnCq4IjjsRmRbsV/pjmRtb7NbjjgStHBmX7uzX5ivM4mMlMjSU1Z/Tm
         VfWgBI5yYwb4NVQ8STCPHSGqwRb8pbuC1vj8fqtkvfb0nXuisGCp9zOrBhHfUc4zat
         LKU61YcDz4DNBiQwphNm43reEMcnF60HVhoi037MrV9xb0uTwYYyH8n381PqxgXC0M
         9c7OX8tEmCU5bXUpOOqMjoWQA7MMUifpWg90Yd/iHLUASogks5vhRe+zi71saKvQzS
         X7WBmHOsLouXZVxTBW0jcsKeHKktP1uQJA7GwTbfcQuTulq0W1mY+SUEsctsr/V1J/
         EYndJ4eAIY8CThWNOZsZWMSwFtkeFzRc/wbenl3kVQDdU0Vj0QitFl4qDUpXzTFcC1
         bCqdzyFtlOdgOI+731a8qUgmGj0IyURW+ra9+5+dv6U7AytXFSKAMSL7QKCzHB31Na
         VxKhCPbGjh5Fr72eHfy9LO/H8HgBz5XtDxCZnWAjuX5kACDMDSh
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH 22/31] http: replace sha1_to_hex
Date:   Tue, 12 Feb 2019 01:22:47 +0000
Message-Id: <20190212012256.1005924-23-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a
In-Reply-To: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since sha1_to_hex is limited to SHA-1, replace it with hash_to_hex.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 http.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/http.c b/http.c
index 458d07fabb..8ab07458e4 100644
--- a/http.c
+++ b/http.c
@@ -2079,19 +2079,19 @@ int http_fetch_ref(const char *base, struct ref *ref)
 }
 
 /* Helpers for fetching packs */
-static char *fetch_pack_index(unsigned char *sha1, const char *base_url)
+static char *fetch_pack_index(unsigned char *hash, const char *base_url)
 {
 	char *url, *tmp;
 	struct strbuf buf = STRBUF_INIT;
 
 	if (http_is_verbose)
-		fprintf(stderr, "Getting index for pack %s\n", sha1_to_hex(sha1));
+		fprintf(stderr, "Getting index for pack %s\n", hash_to_hex(hash));
 
 	end_url_with_slash(&buf, base_url);
-	strbuf_addf(&buf, "objects/pack/pack-%s.idx", sha1_to_hex(sha1));
+	strbuf_addf(&buf, "objects/pack/pack-%s.idx", hash_to_hex(hash));
 	url = strbuf_detach(&buf, NULL);
 
-	strbuf_addf(&buf, "%s.temp", sha1_pack_index_name(sha1));
+	strbuf_addf(&buf, "%s.temp", sha1_pack_index_name(hash));
 	tmp = strbuf_detach(&buf, NULL);
 
 	if (http_get_file(url, tmp, NULL) != HTTP_OK) {
@@ -2262,7 +2262,7 @@ struct http_pack_request *new_http_pack_request(
 
 	end_url_with_slash(&buf, base_url);
 	strbuf_addf(&buf, "objects/pack/pack-%s.pack",
-		sha1_to_hex(target->hash));
+		hash_to_hex(target->hash));
 	preq->url = strbuf_detach(&buf, NULL);
 
 	strbuf_addf(&preq->tmpfile, "%s.temp", sha1_pack_name(target->hash));
@@ -2289,7 +2289,7 @@ struct http_pack_request *new_http_pack_request(
 		if (http_is_verbose)
 			fprintf(stderr,
 				"Resuming fetch of pack %s at byte %"PRIuMAX"\n",
-				sha1_to_hex(target->hash),
+				hash_to_hex(target->hash),
 				(uintmax_t)prev_posn);
 		http_opt_request_remainder(preq->slot->curl, prev_posn);
 	}
