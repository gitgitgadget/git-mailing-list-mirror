Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC3B021847
	for <e@80x24.org>; Wed,  2 May 2018 00:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753578AbeEBA1U (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:27:20 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37890 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753524AbeEBA1D (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 20:27:03 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 793096046C;
        Wed,  2 May 2018 00:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525220822;
        bh=QU+lSZxUAS2ODt7u0MoojlivRT/gAXAEBq9XE9a5hns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=0k9pIWm1IOU35gp7L9M/OV81Tyh/dEx+ygdSB7ayIGpDsQr/Ft9ld2ZkcvWYG1U3z
         ijfBFVr7eSHxPgQOe90CUpE4I/sAZ88MbnBN0ZMpdMYHe94+aQGSgprbNtSR1A3zS5
         W5JyjfY6hNAgCMbv1ThBVO9KpRa5mWtQBX7QYvc0kh6YoIy+Ifl7fvIVXkbo4LBveR
         FoueH0XLAyUl0kqxYxj8m6+wXQ6Na8Z0Po/5BkGMhdmAAwo7Ru8KbXF87CaocdRYin
         Sp7UDe4qZ6Xk5NjJ6zCe470VJ3+Z1hj/Mkq/D0FcV8WL2zMnpi2+/SLvkGeFU9eWK1
         ESg5iiVfU9Oy8qzo6DP4PvhcPqp1LVNZxObhaE5N7UYKIZ41yjRjG1W/QUuxJulFIw
         P2P2WgpsxuKufKFaaFvM7gD34q2jC+6w6A3b3O1hjbRSR0nOoHCP+PrHRFC3/0/hqT
         H9flIwNGY4iemqwEoDdcTl9KYEmaZo0KpwmD7csIJp9ZtJWaT0P
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 39/42] sha1_file: only expose empty object constants through git_hash_algo
Date:   Wed,  2 May 2018 00:26:07 +0000
Message-Id: <20180502002610.915892-40-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180502002610.915892-1-sandals@crustytoothpaste.net>
References: <20180502002610.915892-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There really isn't any case in which we want to expose the constants for
empty trees and blobs outside of using the hash algorithm abstraction.
Make these constants static and stop exposing the defines in cache.h.
Remove the constants which are no longer in use.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache.h     | 16 ----------------
 sha1-file.c | 13 +++++++++++--
 2 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/cache.h b/cache.h
index 7115770fa6..ffe145c539 100644
--- a/cache.h
+++ b/cache.h
@@ -1013,22 +1013,6 @@ static inline void oidread(struct object_id *oid, const unsigned char *hash)
 	memcpy(oid->hash, hash, the_hash_algo->rawsz);
 }
 
-
-#define EMPTY_TREE_SHA1_HEX \
-	"4b825dc642cb6eb9a060e54bf8d69288fbee4904"
-#define EMPTY_TREE_SHA1_BIN_LITERAL \
-	 "\x4b\x82\x5d\xc6\x42\xcb\x6e\xb9\xa0\x60" \
-	 "\xe5\x4b\xf8\xd6\x92\x88\xfb\xee\x49\x04"
-extern const struct object_id empty_tree_oid;
-#define EMPTY_TREE_SHA1_BIN (empty_tree_oid.hash)
-
-#define EMPTY_BLOB_SHA1_HEX \
-	"e69de29bb2d1d6434b8b29ae775ad8c2e48c5391"
-#define EMPTY_BLOB_SHA1_BIN_LITERAL \
-	"\xe6\x9d\xe2\x9b\xb2\xd1\xd6\x43\x4b\x8b" \
-	"\x29\xae\x77\x5a\xd8\xc2\xe4\x8c\x53\x91"
-extern const struct object_id empty_blob_oid;
-
 static inline int is_empty_blob_sha1(const unsigned char *sha1)
 {
 	return !hashcmp(sha1, the_hash_algo->empty_blob->hash);
diff --git a/sha1-file.c b/sha1-file.c
index 4acbf8ee08..bf6c8da3ff 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -35,12 +35,21 @@
 /* The maximum size for an object header. */
 #define MAX_HEADER_LEN 32
 
+
+#define EMPTY_TREE_SHA1_BIN_LITERAL \
+	 "\x4b\x82\x5d\xc6\x42\xcb\x6e\xb9\xa0\x60" \
+	 "\xe5\x4b\xf8\xd6\x92\x88\xfb\xee\x49\x04"
+
+#define EMPTY_BLOB_SHA1_BIN_LITERAL \
+	"\xe6\x9d\xe2\x9b\xb2\xd1\xd6\x43\x4b\x8b" \
+	"\x29\xae\x77\x5a\xd8\xc2\xe4\x8c\x53\x91"
+
 const unsigned char null_sha1[GIT_MAX_RAWSZ];
 const struct object_id null_oid;
-const struct object_id empty_tree_oid = {
+static const struct object_id empty_tree_oid = {
 	EMPTY_TREE_SHA1_BIN_LITERAL
 };
-const struct object_id empty_blob_oid = {
+static const struct object_id empty_blob_oid = {
 	EMPTY_BLOB_SHA1_BIN_LITERAL
 };
 
