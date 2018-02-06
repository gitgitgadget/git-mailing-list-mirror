Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1CB71F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751924AbeBFAR7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:17:59 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41375 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbeBFAR6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:17:58 -0500
Received: by mail-pg0-f68.google.com with SMTP id 141so151628pgd.8
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L1NFRQQYbD1AWRkwHy/zKxQ0yfJ/dfNjx1euxVbUQj4=;
        b=hwaA1doW3kDj+jQ0hsq9YtowTt+Zhre3EaSUY46hhrb0kCLdEQxPkxFCJ+js6mRoMq
         sWCQ1wkv2l6Vxh6x4k1P5ejIX+k2gPy5R5oTUi7Sh0JEfjbJmWHZXDHpmXzdDvDhhYIL
         ROqWG1k+yUEIzSPIJEphv8vgJUtum+n6gSdIjyclgXr3N2t5CQfykXAKWehiXrYse5pn
         xayZFGOjJ0JRoMGLKdzjs0ACskNBAwAYlMX1oujx6mHkdfuynkRbtYUAZyCdX547vDzM
         vNgf8BhPRhFZnvJtmRkxLv7FvTAqfWEDwSFHpeRLUaIU8wdAp2Co6wLSQrhN+iIm117a
         VK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L1NFRQQYbD1AWRkwHy/zKxQ0yfJ/dfNjx1euxVbUQj4=;
        b=hxIFg7P78RghLGveal5W1CtZWmQtKiqpyqZawYJsWg8NpBBy3Pm8uw6OUDr+kQJUyF
         R3m0++i7uc3rbtpzwbyFfPrdLawKd5vPHJwQI4ASBDKXGID1iTAX3x4JuzYqErR8Cxc0
         SZBsM8xTATmrUzz7KzO2r6wPIhICLxDnSO/a1PdfR6DpxpgWWXoP6cb3p+sQVYz0NeMD
         vqZva3ulmx6hIwWrTonWCdpeYL/FRD50HM1sf8i22Wkot5POXVmStjLu6Y07ZxoRZv0R
         6NdcTdOfLbgVCAnRijUnPC2d70ZayQpI2gLDYp66EwJMFvZf2FYEQHl/wLFkD47wm0kQ
         v8tg==
X-Gm-Message-State: APf1xPDe4nfckQlT4B9T5+/kUtujJRXvEsngQw7R5dDKJnhL8tEEeRbZ
        6i1BQee+DMFHp6E0D6EbS8LkcU9BJGs=
X-Google-Smtp-Source: AH8x225BUd7zUVMx44r1d3Gin8oWxUwwEcEBJh+Hex7sZKEab95QbkKrYAvgm7TUlH0tLTuCboupCA==
X-Received: by 10.99.136.200 with SMTP id l191mr416599pgd.384.1517876277761;
        Mon, 05 Feb 2018 16:17:57 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id i11sm13842712pgq.34.2018.02.05.16.17.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:17:57 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 099/194] object: allow grow_object_hash to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:16:14 -0800
Message-Id: <20180206001749.218943-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235508.216277-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 object.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/object.c b/object.c
index f518e5703b..be5d6c0931 100644
--- a/object.c
+++ b/object.c
@@ -115,27 +115,28 @@ struct object *lookup_object_the_repository(const unsigned char *sha1)
  * power of 2 (but at least 32).  Copy the existing values to the new
  * hash map.
  */
-#define grow_object_hash(r) grow_object_hash_##r()
-static void grow_object_hash_the_repository(void)
+static void grow_object_hash(struct repository *r)
 {
 	int i;
 	/*
 	 * Note that this size must always be power-of-2 to match hash_obj
 	 * above.
 	 */
-	int new_hash_size = the_repository->parsed_objects.obj_hash_size < 32 ? 32 : 2 * the_repository->parsed_objects.obj_hash_size;
+	int new_hash_size = r->parsed_objects.obj_hash_size < 32
+				? 32
+				: 2 * r->parsed_objects.obj_hash_size;
 	struct object **new_hash;
 
 	new_hash = xcalloc(new_hash_size, sizeof(struct object *));
-	for (i = 0; i < the_repository->parsed_objects.obj_hash_size; i++) {
-		struct object *obj = the_repository->parsed_objects.obj_hash[i];
+	for (i = 0; i < r->parsed_objects.obj_hash_size; i++) {
+		struct object *obj = r->parsed_objects.obj_hash[i];
 		if (!obj)
 			continue;
 		insert_obj_hash(obj, new_hash, new_hash_size);
 	}
-	free(the_repository->parsed_objects.obj_hash);
-	the_repository->parsed_objects.obj_hash = new_hash;
-	the_repository->parsed_objects.obj_hash_size = new_hash_size;
+	free(r->parsed_objects.obj_hash);
+	r->parsed_objects.obj_hash = new_hash;
+	r->parsed_objects.obj_hash_size = new_hash_size;
 }
 
 void *create_object_the_repository(const unsigned char *sha1, void *o)
-- 
2.15.1.433.g936d1b9894.dirty

