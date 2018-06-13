Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 199F51F403
	for <e@80x24.org>; Wed, 13 Jun 2018 23:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935989AbeFMXG1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 19:06:27 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:37840 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935864AbeFMXGM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 19:06:12 -0400
Received: by mail-ua0-f202.google.com with SMTP id z33-v6so1352568uah.4
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 16:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=ZnymeA6NGPNnMhhALzm/XcWXxuwiJd6wcnaNpFENWAk=;
        b=QWANcdkbiWBI3i6tLQ0q+CoPtjffrf013JvJTaEBiFncnttn1TaO2QEoH0wIfwz+rf
         hCGhESA0IY1LpEVwzHdWB1PMtZFslXVXWkt94CzqqYL2SPYp07byGSD8YTQjWtmj76/Y
         hoj7lXoNAbRVKw2whVYCm+WUwJTw+wqcp13CW2dZcgA8rnWd31G4z8C6c7tRjdyjdtAF
         RlAqy7Q8HStGRxCfHIUfUsvjhMEqg6WTtDl5Derax7vKX2jwCBEFL0DFPZ2pkcKqql+A
         VmE6Aj1xbLoIIv67lUagXrnZyzVShXHpO/pBxh+BR0AV20iPRhel1QeG/TNEib4TV30l
         8RVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=ZnymeA6NGPNnMhhALzm/XcWXxuwiJd6wcnaNpFENWAk=;
        b=pID1W+ZL5k0xn/HiqmDzbHAsTi40qfq0M8Chomg5Wnltj2HGY/wxvPhOZmO/CictqC
         kwM8PbPWs1ICq19NraiMKQR/ccuyQC/jmNaMLo0VSWusH8O9MKBAazT2jqGFjyUJZh6f
         QjVoguwR214uQo3PA1AiBw043XDMDD6zHej5fEqJESOH45bOE0DGiHni9OT2cX8eFcc/
         Ur6/fxAnWVykMyFqoWZletCDm+ew9PhTInnl7RFL3yBVZx5DLk58vNNUbvsA8wNTdxPL
         jGrj6UD/nmu+/nGhO+6P7Q1v1vserqtW7SPiwbhk/RhVzyts/FjcsR+tJV4u3Zv/IrME
         rcjw==
X-Gm-Message-State: APt69E1YDjnRwtfz9jze8R0wfGO972aRLtsfPynx7YG2vGpTIVV2WJht
        YrA/mFI+AVt3b/zjap4tIIor+8aEY6PhhlI8ibdpf3F9FZ987x4tX5TcOi956k/ChkDjTdt2uxo
        oVbzOAPqL9C91wzwULiz0aWU50nmTxHWgq6VjHXBijNye16ZTqydSVLnApA8G
X-Google-Smtp-Source: ADUXVKICRnFqwftvljAMDY72QtLBzN0Fx6JRDs5I/YyGTNP2w9JmYxZFY3s5kfr8IJuYdFcdZI8Rgs5ONOwG
MIME-Version: 1.0
X-Received: by 2002:ab0:4929:: with SMTP id z38-v6mr77025uac.122.1528931172229;
 Wed, 13 Jun 2018 16:06:12 -0700 (PDT)
Date:   Wed, 13 Jun 2018 16:05:07 -0700
In-Reply-To: <20180613230522.55335-1-sbeller@google.com>
Message-Id: <20180613230522.55335-17-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com> <20180613230522.55335-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v2 16/31] object: allow lookup_object to handle arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
index 876ca4977e2..c1c1cbc1f53 100644
--- a/object.c
+++ b/object.c
@@ -84,21 +84,20 @@ static void insert_obj_hash(struct object *obj, struct object **hash, unsigned i
  * Look up the record for the given sha1 in the hash map stored in
  * obj_hash.  Return NULL if it was not found.
  */
-struct object *lookup_object_the_repository(const unsigned char *sha1)
+struct object *lookup_object(struct repository *r, const unsigned char *sha1)
 {
 	unsigned int i, first;
 	struct object *obj;
 
-	if (!the_repository->parsed_objects->obj_hash)
+	if (!r->parsed_objects->obj_hash)
 		return NULL;
 
-	first = i = hash_obj(sha1,
-			     the_repository->parsed_objects->obj_hash_size);
-	while ((obj = the_repository->parsed_objects->obj_hash[i]) != NULL) {
+	first = i = hash_obj(sha1, r->parsed_objects->obj_hash_size);
+	while ((obj = r->parsed_objects->obj_hash[i]) != NULL) {
 		if (!hashcmp(sha1, obj->oid.hash))
 			break;
 		i++;
-		if (i == the_repository->parsed_objects->obj_hash_size)
+		if (i == r->parsed_objects->obj_hash_size)
 			i = 0;
 	}
 	if (obj && i != first) {
@@ -107,8 +106,8 @@ struct object *lookup_object_the_repository(const unsigned char *sha1)
 		 * that we do not need to walk the hash table the next
 		 * time we look for it.
 		 */
-		SWAP(the_repository->parsed_objects->obj_hash[i],
-		     the_repository->parsed_objects->obj_hash[first]);
+		SWAP(r->parsed_objects->obj_hash[i],
+		     r->parsed_objects->obj_hash[first]);
 	}
 	return obj;
 }
diff --git a/object.h b/object.h
index bd25155480f..66e0b7b93dc 100644
--- a/object.h
+++ b/object.h
@@ -110,8 +110,7 @@ extern struct object *get_indexed_object(unsigned int);
  * half-initialised objects, the caller is expected to initialize them
  * by calling parse_object() on them.
  */
-#define lookup_object(r, s) lookup_object_##r(s)
-struct object *lookup_object_the_repository(const unsigned char *sha1);
+struct object *lookup_object(struct repository *r, const unsigned char *sha1);
 
 extern void *create_object(struct repository *r, const unsigned char *sha1, void *obj);
 
-- 
2.18.0.rc1.244.gcf134e6275-goog

