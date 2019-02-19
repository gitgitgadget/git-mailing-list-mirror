Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B80E31F453
	for <e@80x24.org>; Tue, 19 Feb 2019 00:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732260AbfBSAGI (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 19:06:08 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34754 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732195AbfBSAGC (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 19:06:02 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A861B61096;
        Tue, 19 Feb 2019 00:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550534760;
        bh=u4Oz/WO5+HhIy4BmxYdkaenf1TjVyDZL9RnBd377Dvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=wOHIGrZ44BW61+8EI3jsGj+QLQThK5PMWRKu9F2cIcvcJcejsnJrmOMRhTt9c/kwQ
         yvSfOIYrRNBpKmL6LFFHjQPHnGbyuD2hFaR0IhIPIg9eQnKaZJ8ZhmqzIefrNpwdnl
         qe+EkfG3MrnHLBENackLMWnuH131Gl3ZgZQ3Gc5X22iTXIhoGcd8MSa/NYUMc6XazE
         3tdxaExj092iVz95jf2K1md1MSUU/KAOaSoY3FmCGlfIyYG4wst17TAPvjqL9iQ8OS
         4gQfUYpYwPSTgxA7ZxzSdT4REF1cO8irgEdCQ7BZh34ZBUlnWKezkKQ9ElqaWThSFe
         6/IYGtZAz0krbifotbWh4WuvtIuMRNtLU13t4ShbUo3WP+m7/RQ+wzTDShEi5WbiUN
         69Hnu/58NyJ5lxoT4ZSy9w4nzbajE7IRZbA2C6GlaEcLYpBTvxNd767/18tq0U+FkL
         yUUybjHBiAs5cIUpeDGWV4QWMI/lwjln7z1QQGZXIWTqWzIQbYw
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 20/35] http-push: remove remaining uses of sha1_to_hex
Date:   Tue, 19 Feb 2019 00:05:11 +0000
Message-Id: <20190219000526.476553-21-sandals@crustytoothpaste.net>
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

Since sha1_to_hex is limited to SHA-1, switch all remaining uses of it
in this file to hash_to_hex or oid_to_hex.  Modify update_remote to take
a pointer to struct object_id, and since we don't modify that parameter
in the function, set it to be const as well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 http-push.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/http-push.c b/http-push.c
index c4e5142bc9..f675a96316 100644
--- a/http-push.c
+++ b/http-push.c
@@ -316,7 +316,7 @@ static void start_fetch_packed(struct transfer_request *request)
 	}
 
 	fprintf(stderr,	"Fetching pack %s\n",
-		sha1_to_hex(target->hash));
+		hash_to_hex(target->hash));
 	fprintf(stderr, " which contains %s\n", oid_to_hex(&request->obj->oid));
 
 	preq = new_http_pack_request(target, repo->url);
@@ -1374,7 +1374,7 @@ static int get_delta(struct rev_info *revs, struct remote_lock *lock)
 	return count;
 }
 
-static int update_remote(unsigned char *sha1, struct remote_lock *lock)
+static int update_remote(const struct object_id *oid, struct remote_lock *lock)
 {
 	struct active_request_slot *slot;
 	struct slot_results results;
@@ -1383,7 +1383,7 @@ static int update_remote(unsigned char *sha1, struct remote_lock *lock)
 
 	dav_headers = get_dav_token_headers(lock, DAV_HEADER_IF);
 
-	strbuf_addf(&out_buffer.buf, "%s\n", sha1_to_hex(sha1));
+	strbuf_addf(&out_buffer.buf, "%s\n", oid_to_hex(oid));
 
 	slot = get_active_slot();
 	slot->results = &results;
@@ -1948,7 +1948,7 @@ int cmd_main(int argc, const char **argv)
 		run_request_queue();
 
 		/* Update the remote branch if all went well */
-		if (aborted || !update_remote(ref->new_oid.hash, ref_lock))
+		if (aborted || !update_remote(&ref->new_oid, ref_lock))
 			rc = 1;
 
 		if (!rc)
