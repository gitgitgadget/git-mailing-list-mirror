Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 060301F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932692AbeDWXlE (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:41:04 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60752 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932791AbeDWXks (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 19:40:48 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 216C160B13;
        Mon, 23 Apr 2018 23:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524526846;
        bh=VVvJIcWf0iU+zbWFL3JsfLtHb77A3JTcJx3nNqLPJgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=PDyrZOe4Z5eqUI7cY23m6NxOJPrmW0tfZSjmxXqfKoHn567kyEL1ylMvKETKNKSnM
         C3MeUrw7LeKYSNt6uLpqMOkWPX0JoYhq3f///C4kapbaWqJCqrwO1VPtEv7X79fLx+
         PDb0MVy5fzdgKYTa/eusp5yEti/YuhwFrQjq9+xyDFau/SVuACnl75EanstZbb4zHX
         CAsEb8q8/f8//2h3n+/kQm+xJoTkcVPahWUcAQajwVh2H8+7g0JMHEx43BPnS1Slpx
         CbetRyzZvPm8vi8Lp3s3Xv0jzlncs+Pe3ot2gHzYjks9ITU+jeXML2mHIh87eOAwc3
         Ub9UB532iO7k9bgkbTeXa1ditpOL4MTTdT5WYyL7twoyn5wVgwJzkIonEP0+sZX+du
         wL9rU3CT16tPipO5idKrRgCq8aWHsK4uPC59g6VoBk7TT3+T/aqwicuMw2Zo2W9j+F
         NlEb2TCrVx0jUfjD+yhO4Z2Aw2I9DL7hmYhWIChWpHaosW0cFx+
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 38/41] sha1_file: only expose empty object constants through git_hash_algo
Date:   Mon, 23 Apr 2018 23:39:48 +0000
Message-Id: <20180423233951.276447-39-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180423233951.276447-1-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
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
 sha1_file.c | 13 +++++++++++--
 2 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/cache.h b/cache.h
index 9ad1dd2ddc..c5b041019b 100644
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
diff --git a/sha1_file.c b/sha1_file.c
index 11c840f89c..794753bd54 100644
--- a/sha1_file.c
+++ b/sha1_file.c
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
 
