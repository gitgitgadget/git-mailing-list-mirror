Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C2141F516
	for <e@80x24.org>; Fri, 29 Jun 2018 01:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936485AbeF2BXQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 21:23:16 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:44077 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936468AbeF2BXM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 21:23:12 -0400
Received: by mail-ua0-f201.google.com with SMTP id a11-v6so2251490uak.11
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 18:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=3dDcULx8V/83AnmF8zuxoQSHYhtHlea/9ZQAdJJEFWQ=;
        b=OyuYgIiJzZrk9cAeHDwDaqRlhK8p/eBv18hns7WCeBd0CkSdTmsCyTizdw3C4nr2Yu
         vVmaI4Z/jgbRZta1DPSXlzE+a3tQKzwd2CUs7ZvlQdqIbtqQSaiLR8lLorYgYd//dcOt
         kJzPkqO2a30z3KUvq9kjDY1rYCJ2e+ama1CNvCW10pQZcfHHz5VnO5BL6wvLhB5K0Z4O
         2buJqMWQUabG7FC9Nk0HrcUIKW5WZiNE1inPQWzqF7CvT6S2FvL0Msod3/ea6UoRG08P
         ZoBcIV5KnMTZk3GgguizC6ta3DpDUC9RmjEKwzdTVB70MYU4jiLPPY6qh8wkZcjBZaZx
         E3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=3dDcULx8V/83AnmF8zuxoQSHYhtHlea/9ZQAdJJEFWQ=;
        b=aXr9YDTk+vJYr7bPhiEcQFFVh3p54OzjMEfC0gjghOnZRkSgTZW4kN4GR3yCMpOcqV
         jDOkIYRNmIS4mOX50vaYN4AWjx5JLX3fiVZObQTCUzhPVz0Lxk/rRQcl6KKUxOMbdhz+
         4F9x8acjhjDFcGJGK9NXYJouw57LHDQQgaUjkIAwk5Jdz/+7GFOfIyJbBGw7iIbxJENv
         KKadVSwUcAuzHZbRxzgj6AUz9qyN/j8YY9gR4tkrJwWHf9VP0B/wc1iZWD/3mD7MiCOD
         C8FHcSksmPqn1pdiTvFAMmITxdcbEzRNdQW1CiAH1yYsz7I1YdXpqaon21lUA39HJcNa
         gyPQ==
X-Gm-Message-State: APt69E3TKkKCA5CgyFqyo1zm2TxrmHmD3jEjwJMpCNK0QYuihKj3Zhg3
        HBoavb5YlB2f+YAN4P75GkCleZLpIdOyxDAGwOGITEnkpiyyVkba6rz5xcFTwG0d1nMbCMlxss+
        ny+5cqtpWp9E70oMDjT4kvGeohwl8J4+Rq6dSTxTCpJe8cm79N/d8mlFufNNT
X-Google-Smtp-Source: AAOMgpf8wenZ8w+VmbVKsqHBQsHNXl3HcjdHybT0zJqUGkan5/RU43liv+v76HIDZ4ncyHDuYPmpsjrd96Tp
MIME-Version: 1.0
X-Received: by 2002:a1f:960d:: with SMTP id y13-v6mr5370457vkd.60.1530235392093;
 Thu, 28 Jun 2018 18:23:12 -0700 (PDT)
Date:   Thu, 28 Jun 2018 18:22:07 -0700
In-Reply-To: <20180629012222.167426-1-sbeller@google.com>
Message-Id: <20180629012222.167426-18-sbeller@google.com>
References: <20180629012222.167426-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v3 17/32] object: allow lookup_object to handle arbitrary repositories
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
index f41f82c6725..9d74de95f5b 100644
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
index 6f3271eb228..0d7d74129b6 100644
--- a/object.h
+++ b/object.h
@@ -109,8 +109,7 @@ extern struct object *get_indexed_object(unsigned int);
  * half-initialised objects, the caller is expected to initialize them
  * by calling parse_object() on them.
  */
-#define lookup_object(r, s) lookup_object_##r(s)
-struct object *lookup_object_the_repository(const unsigned char *sha1);
+struct object *lookup_object(struct repository *r, const unsigned char *sha1);
 
 extern void *create_object(struct repository *r, const unsigned char *sha1, void *obj);
 
-- 
2.18.0.399.gad0ab374a1-goog

