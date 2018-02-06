Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77E811F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752150AbeBFASF (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:18:05 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41270 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbeBFASB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:18:01 -0500
Received: by mail-pl0-f68.google.com with SMTP id k8so113622pli.8
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8Yb3UGx7kAg4Z9TS+7WEt7EyaJK5apysPRuOA8XXhyY=;
        b=hC7wT8A46EpAqT1TQL7qhTsKYHV+FYbTkdAA3RzV/lT6YrKvDWD6pE/VAPpdps1qAq
         V3QYPPSTrvFvsYFx7qOEZ1vjujPcUg6WldVXOYP1qa75HbYQInhY5OiIxvRTe/33ltg6
         V4xIhxgKRBgHc69doJdNe0HM5OGyPHkSkhxbyvQdioUmXefjssaLsKiJUJRoF9cJX7Wi
         EU8AZQluLC9Ue7ec0NrthOn6ncPHJn2AQkdJKM3vHWaoU8kl+2JXZxPA2TYCbQxfQGbm
         7WOgDfOqkbLuMl1yMUhrXiQvQF+LiO3/WV42F82aeyeX9S6buHXzEOcWzruwstua5SNK
         eaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8Yb3UGx7kAg4Z9TS+7WEt7EyaJK5apysPRuOA8XXhyY=;
        b=EFO2jzuYI6el4tqiB2P8MXvmj+SQ+wuRMnFUEThLy9h2Ty1TTWJ7ZVcP2FC2b7TKcZ
         Y+vGt+dAFdDQnfigIxy86nyRmJhOjtyq3m7T6VUEzKA+c1N7og0wVNfNbQleZCOwi9FI
         f0KhOmoYVz9DEAELMmGW5BteMAVshs4cxYUGowcoQMyf5/X5D9M8meMxgdXFqnuMgNaO
         CjjEXoWQqSecMBkQtL/R4SoCmmXFufZU+bY0rYL2hY0sTyPNTEePRToE6gR1DcOr9GGH
         yLRzyqN+RXn71PpEtpk7wzgSjNBOgrLrgVc23dTB+6+CYpzCMbdSlRmJDuoIT0S2MfML
         +Swg==
X-Gm-Message-State: APf1xPBuYdufEXawGIwTzPv91eJDdxIb+QZBX3JNkyJUCWZh8l4RfY/J
        Ii+/aGwPkAB8Jx0atb0jKDY08sAZc/E=
X-Google-Smtp-Source: AH8x225/la2p3Na/PYk4G2nDjISR3LMD52veED+rPGtD/yJjrmZLSrro+HqLoOMKLB6YbB7wnDmy2g==
X-Received: by 2002:a17:902:380c:: with SMTP id l12-v6mr545280plc.8.1517876280348;
        Mon, 05 Feb 2018 16:18:00 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id 62sm7761076pfl.50.2018.02.05.16.17.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:17:59 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 101/194] object: allow lookup_object to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:16:16 -0800
Message-Id: <20180206001749.218943-3-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 object.c | 15 +++++++--------
 object.h |  3 +--
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/object.c b/object.c
index de19d814c1..7cac87aa22 100644
--- a/object.c
+++ b/object.c
@@ -81,21 +81,20 @@ static void insert_obj_hash(struct object *obj, struct object **hash, unsigned i
  * Look up the record for the given sha1 in the hash map stored in
  * obj_hash.  Return NULL if it was not found.
  */
-struct object *lookup_object_the_repository(const unsigned char *sha1)
+struct object *lookup_object(struct repository *r, const unsigned char *sha1)
 {
 	unsigned int i, first;
 	struct object *obj;
 
-	if (!the_repository->parsed_objects.obj_hash)
+	if (!r->parsed_objects.obj_hash)
 		return NULL;
 
-	first = i = hash_obj(sha1,
-			     the_repository->parsed_objects.obj_hash_size);
-	while ((obj = the_repository->parsed_objects.obj_hash[i]) != NULL) {
+	first = i = hash_obj(sha1, r->parsed_objects.obj_hash_size);
+	while ((obj = r->parsed_objects.obj_hash[i]) != NULL) {
 		if (!hashcmp(sha1, obj->oid.hash))
 			break;
 		i++;
-		if (i == the_repository->parsed_objects.obj_hash_size)
+		if (i == r->parsed_objects.obj_hash_size)
 			i = 0;
 	}
 	if (obj && i != first) {
@@ -104,8 +103,8 @@ struct object *lookup_object_the_repository(const unsigned char *sha1)
 		 * that we do not need to walk the hash table the next
 		 * time we look for it.
 		 */
-		SWAP(the_repository->parsed_objects.obj_hash[i],
-		     the_repository->parsed_objects.obj_hash[first]);
+		SWAP(r->parsed_objects.obj_hash[i],
+		     r->parsed_objects.obj_hash[first]);
 	}
 	return obj;
 }
diff --git a/object.h b/object.h
index 699adcf161..d59edc88af 100644
--- a/object.h
+++ b/object.h
@@ -102,8 +102,7 @@ extern struct object *get_indexed_object(unsigned int);
  * half-initialised objects, the caller is expected to initialize them
  * by calling parse_object() on them.
  */
-#define lookup_object(r, s) lookup_object_##r(s)
-struct object *lookup_object_the_repository(const unsigned char *sha1);
+struct object *lookup_object(struct repository *r, const unsigned char *sha1);
 
 extern void *create_object(struct repository *r, const unsigned char *sha1, void *obj);
 
-- 
2.15.1.433.g936d1b9894.dirty

