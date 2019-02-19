Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1990F1F453
	for <e@80x24.org>; Tue, 19 Feb 2019 00:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732273AbfBSAGK (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 19:06:10 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34784 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732248AbfBSAGH (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 19:06:07 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1CF8C61097;
        Tue, 19 Feb 2019 00:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550534765;
        bh=6lFN0qiDIfVD5kLeIIGjcDrmBFAO3vCq4WNSLzWU0TQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=zE0TnQfZKOxwPFd9KchFKsm0VvWU0HI3M0Cw0QCEpytr+FJkNbGgbgv/JhlL9Vs54
         8LoREk42wE5mjStR4lqBAAVqnsKGJjcViY46jA1o5FRe0wWOGQXsmo0vNLaiSWqWf+
         +0yRxD9zGxNCFoPFiWL0Fmu2WbLZQ7jgtwGqIGPwhPn03hcRFWN8sWijZZWBvU1FC3
         ccympH2YDgNGAZuSdj8IrpDlGR6777hhQa5T+geaxxab6E27HMQDVZLfTwh65p/lEp
         hY38asndOVjgD4s3Euh0Ka412mDBGVx/5JWLT2wVMGncvN3HChcTxUV6SdnBgBEwku
         wZxMN0obd668DDCz2/IINClX7Rg/ocWyMxC+wKXZa9ShWUIeqjI6gta3NsC7yCrzuE
         0A8BYVxX/tKTPUlQdJMu/ohtIr7cZyQmUH86CY5ldy12UM5ijHOcoqvcI08TCcD/f9
         DLfwCgo6VO1hdugpe2dPpAzrDvbhmo6CbtVav/p3tEu49CWwthl
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 24/35] http: replace sha1_to_hex
Date:   Tue, 19 Feb 2019 00:05:15 +0000
Message-Id: <20190219000526.476553-25-sandals@crustytoothpaste.net>
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
