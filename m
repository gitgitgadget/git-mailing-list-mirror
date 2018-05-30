Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 074D01F42D
	for <e@80x24.org>; Wed, 30 May 2018 00:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968589AbeE3AtX (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 20:49:23 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:40337 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968531AbeE3Asw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 20:48:52 -0400
Received: by mail-pf0-f172.google.com with SMTP id f189-v6so8105350pfa.7
        for <git@vger.kernel.org>; Tue, 29 May 2018 17:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P5EFC+tgnTRoU6NFhdu5cR7qWRHvwmWB+Qd/Pss7b0M=;
        b=UppF3lchD8C5vOMBuGhOBZZI+bwZhP6Q0FZdKjQ6VnRy4Ql1QewaG/TUOzIo4hZkfE
         FLI1RbnqT2Ldl4p6KPBdQMzHq1+IQxYtuXqAn5IZgnDrA/vKr+Sx5oNQovn7h0gGAo5T
         u7r2grdjt0DyyBxwnhxyMayM7V+w5N1+UATDZCKDmsJkdFDXBS48/e0pz/l6VJSKGjdt
         dmr9KkeZQoS4ffDqMrpoDGmww8rSEtiXMe6Y3KcB+/ZrKRZd3Q/BErYecpnFckxtkv6Z
         swgZdtbnqd4CmDPVNNrq6fI45RvR7J4GyibbmcLB7PjzLGHZtePVDuoeZUbEpV3zgnmX
         6qlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P5EFC+tgnTRoU6NFhdu5cR7qWRHvwmWB+Qd/Pss7b0M=;
        b=ULHlLGyXMvm6NSj0yRmIbkeNt2xz1Z01TPGr53U32Q2NTohcLnVAU+UrSSP5h+Fw/+
         onk1Sx5dyJrzRHQjcAcYlwYIoTTZaOhMfWl+hTHLR1gEOFi+VRSnaHmjmmsbZDcdG5CF
         Rdf81mU2eJLgxCF5lZvZ4FTUciv0O1oQcogAU2OTMqwLb9QajHiideSzkmhf9qMPdIZJ
         KY5XmyHuzuJn96KHRLNjOIJ8fRLimT5VRFAYMJ82Yawtsj6AHgjd1+aakx8D6q8bhcJm
         sZMmieeO84d6BofOC3zvVgh9KBxjDgmKasyOBzxvoIwVmUXpiIw1Z/ZPvpnjRYhNi6JV
         wNuw==
X-Gm-Message-State: ALKqPwf5i3g7Zs0+aHTDLLSKAum2G1r9HnIsG9DAH5tFyCWD8v6RL/DW
        EQme+/ythiyJtXZ+QPgVXnYUayTF0+8=
X-Google-Smtp-Source: ADUXVKJ39TXUdwDw9qfDxdolwb8RVUjp7uay/BPtmloyDY49TpEaiTvBGn8TlNOQ2LH4ExNDwQfmew==
X-Received: by 2002:a63:6b84:: with SMTP id g126-v6mr471448pgc.272.1527641330736;
        Tue, 29 May 2018 17:48:50 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id q68-v6sm58807689pfb.182.2018.05.29.17.48.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 17:48:49 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 20/35] object: allow lookup_object to handle arbitrary repositories
Date:   Tue, 29 May 2018 17:47:55 -0700
Message-Id: <20180530004810.30076-21-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180530004810.30076-1-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com>
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
index fabd3ea2134..03180f84b2a 100644
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
index ad5f3b2826a..6adc8323ca4 100644
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
2.17.0.582.gccdcbd54c44.dirty

