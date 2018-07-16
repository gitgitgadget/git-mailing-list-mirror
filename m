Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0C261F597
	for <e@80x24.org>; Mon, 16 Jul 2018 01:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbeGPBxe (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jul 2018 21:53:34 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59058 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727661AbeGPBxd (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Jul 2018 21:53:33 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:78f3:848c:e199:5398])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0C75860781;
        Mon, 16 Jul 2018 01:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531704516;
        bh=FZevZFIE9zCFGfByasyRYTbqLDI/t9xWWD9TrnfAPgs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ZFLH+LjOK43LvlN/V+2hrhIjoapJjEBQbHGgblzb7FcZ6846rC6YWuNuuguX4ua9M
         DXcKCRS4xJ5qb5VqOrGlCWFrrjvEO5RlmCHU4j299NNyfWGriQf+KnxXMCoyrrYnx1
         gkC0xeUwGl7dafKrdzH5B0CANEGY/lMYzZy+aLpGcpT6EekjkTEpVEEbYCG77NHC0F
         uc3CJyjgyEc0Rdt++AmC8oUIVMBJXfpcw45+b7+VCv2f1OmakMc9iIcQwgSQlY+CPe
         u1s04D7CZlomE8uKk2W4s67GGRV9Hf9+vul3vMyhx+G875WBziqmIrTugGSkYuUkU1
         p2WTLLWI6jFnjDgdLa6DZEpYKTzaUt4K3dSdysGiIwdI/J/cisW1HFuoHZnmdzmQms
         sLVg2ulltHgcbnrwUKk5JN5cpQQmkx2ipmnVW4HRA+z5rSGr5amNw6GCXNulGGcUqp
         P8Uh86jHdjBvDPUiMAJt0JAaf6EU7vOyBmwrZxRdSdRYIBZF+Do
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 15/16] sha1-file: convert constants to uses of the_hash_algo
Date:   Mon, 16 Jul 2018 01:28:07 +0000
Message-Id: <20180716012808.961328-16-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180716012808.961328-1-sandals@crustytoothpaste.net>
References: <20180716012808.961328-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert one use of 20 and several uses of GIT_SHA1_HEXSZ into references
to the_hash_algo.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 sha1-file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sha1-file.c b/sha1-file.c
index de4839e634..1f66b9594f 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -336,7 +336,7 @@ int raceproof_create_file(const char *path, create_file_fn fn, void *cb)
 static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
 {
 	int i;
-	for (i = 0; i < 20; i++) {
+	for (i = 0; i < the_hash_algo->rawsz; i++) {
 		static char hex[] = "0123456789abcdef";
 		unsigned int val = sha1[i];
 		strbuf_addch(buf, hex[val >> 4]);
@@ -1473,7 +1473,7 @@ void *read_object_with_reference(const struct object_id *oid,
 		}
 		ref_length = strlen(ref_type);
 
-		if (ref_length + GIT_SHA1_HEXSZ > isize ||
+		if (ref_length + the_hash_algo->hexsz > isize ||
 		    memcmp(buffer, ref_type, ref_length) ||
 		    get_oid_hex((char *) buffer + ref_length, &actual_oid)) {
 			free(buffer);
@@ -2062,9 +2062,9 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 		namelen = strlen(de->d_name);
 		strbuf_setlen(path, baselen);
 		strbuf_add(path, de->d_name, namelen);
-		if (namelen == GIT_SHA1_HEXSZ - 2 &&
+		if (namelen == the_hash_algo->hexsz - 2 &&
 		    !hex_to_bytes(oid.hash + 1, de->d_name,
-				  GIT_SHA1_RAWSZ - 1)) {
+				  the_hash_algo->rawsz - 1)) {
 			if (obj_cb) {
 				r = obj_cb(&oid, path->buf, data);
 				if (r)
