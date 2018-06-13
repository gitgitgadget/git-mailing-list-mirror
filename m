Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33F921F403
	for <e@80x24.org>; Wed, 13 Jun 2018 23:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936028AbeFMXGk (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 19:06:40 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:33085 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935843AbeFMXGi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 19:06:38 -0400
Received: by mail-qt0-f201.google.com with SMTP id o68-v6so3183881qte.0
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 16:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=SdxOo/uZSSIjSpg3psG/ge/8ExeDhrra53c1QhQgyWM=;
        b=lmmT/c4DunAEtiTjOVp859KPz/QA2thYfdRJtkiw9HHsR/xSTZ76mUyzxdymgbBadL
         EfpwuEzzDTi6v0orKsdTOXKru9Y7yEbSj3GWLiEbfvbPCh+gwYe1Ug/hw3Uf1Uun5r+V
         q5UrHeCcbUWsaPNW4TWv6ulSIEORETwkk0g8U6AyWPWm4dZa0ZbMmG07AffvfTag84RI
         Pmnlrg4qtgLLxYjgfbPSq4PKP7XQc1SvjHGTM55o9LVkcKk6q44Zv/NAVuH4Ih7iZOTT
         u8w8PVw54GE2qUdF/+D+FQxowsoELSouGpSXorUZh44/ztJqfO6sGGA6Az8LrfanIZ3M
         +NGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=SdxOo/uZSSIjSpg3psG/ge/8ExeDhrra53c1QhQgyWM=;
        b=Tp5XyidfFUE+T84OFz7mhHnBU7SZAxMu18bhLpuOvhLC5oBXzzmPffvSmrmwBsLJEr
         fZBljiiLWusMOEJlxKKxi8BToDj1SrjHJNOhqRzJlp76rZqgGJi8EEXxsUorXajJaWCd
         pVenGsWnZfyqvx0m7r6xVh2a4445hu3j8+xNZJn8zbuLHc6vaXHI3HgtxZErvgW4YDgH
         Ox9IXGSqUIOnk6yMYaorejVk2EeE0Ha1/9fpUaQg+wgBkZdytS/xxzCALHhTUIDc25Yy
         iA1I2HgTiYFqESoyzfwgSHiKN4Jr1kqpWCqtsLFA5KUYmGtbfGBHQqpqVcfeHs6CPpwp
         NhWg==
X-Gm-Message-State: APt69E0JL3ND9vck6nfS6NcmDG/YfnzkArRM+2UIreooX0Wzunth17vi
        hHEzQJ+EyaAAx/3UACEWCGlNxJ5wmZiPamvksQHdyZ0X+6WI2G5fP4hZxLr7LxugRQK27mSXiAM
        OPQuybW9N1HDmsqQo4vHaeKQJFSQ0YK2j8yvRXrgyEA8yO8LNuK0W+/TNKnvX
X-Google-Smtp-Source: ADUXVKKBCrXURE79d3fLcW1brkXFXJpqMThHzlU4fbOJRYk40qB3bget8J5ORI1M6eb4RsGABsvUY82ltijR
MIME-Version: 1.0
X-Received: by 2002:a37:145f:: with SMTP id e92-v6mr104322qkh.20.1528931197973;
 Wed, 13 Jun 2018 16:06:37 -0700 (PDT)
Date:   Wed, 13 Jun 2018 16:05:18 -0700
In-Reply-To: <20180613230522.55335-1-sbeller@google.com>
Message-Id: <20180613230522.55335-28-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com> <20180613230522.55335-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v2 27/31] object.c: allow parse_object_buffer to handle
 arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 object.c | 18 +++++++++---------
 object.h |  3 +--
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/object.c b/object.c
index 7a7b078e4d0..b63a51febd4 100644
--- a/object.c
+++ b/object.c
@@ -185,21 +185,21 @@ struct object *lookup_unknown_object(const unsigned char *sha1)
 	return obj;
 }
 
-struct object *parse_object_buffer_the_repository(const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p)
+struct object *parse_object_buffer(struct repository *r, const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p)
 {
 	struct object *obj;
 	*eaten_p = 0;
 
 	obj = NULL;
 	if (type == OBJ_BLOB) {
-		struct blob *blob = lookup_blob(the_repository, oid);
+		struct blob *blob = lookup_blob(r, oid);
 		if (blob) {
 			if (parse_blob_buffer(blob, buffer, size))
 				return NULL;
 			obj = &blob->object;
 		}
 	} else if (type == OBJ_TREE) {
-		struct tree *tree = lookup_tree(the_repository, oid);
+		struct tree *tree = lookup_tree(r, oid);
 		if (tree) {
 			obj = &tree->object;
 			if (!tree->buffer)
@@ -211,20 +211,20 @@ struct object *parse_object_buffer_the_repository(const struct object_id *oid, e
 			}
 		}
 	} else if (type == OBJ_COMMIT) {
-		struct commit *commit = lookup_commit(the_repository, oid);
+		struct commit *commit = lookup_commit(r, oid);
 		if (commit) {
-			if (parse_commit_buffer(the_repository, commit, buffer, size))
+			if (parse_commit_buffer(r, commit, buffer, size))
 				return NULL;
-			if (!get_cached_commit_buffer(the_repository, commit, NULL)) {
-				set_commit_buffer(the_repository, commit, buffer, size);
+			if (!get_cached_commit_buffer(r, commit, NULL)) {
+				set_commit_buffer(r, commit, buffer, size);
 				*eaten_p = 1;
 			}
 			obj = &commit->object;
 		}
 	} else if (type == OBJ_TAG) {
-		struct tag *tag = lookup_tag(the_repository, oid);
+		struct tag *tag = lookup_tag(r, oid);
 		if (tag) {
-			if (parse_tag_buffer(the_repository, tag, buffer, size))
+			if (parse_tag_buffer(r, tag, buffer, size))
 			       return NULL;
 			obj = &tag->object;
 		}
diff --git a/object.h b/object.h
index 876480c933c..9a667fbe795 100644
--- a/object.h
+++ b/object.h
@@ -139,8 +139,7 @@ struct object *parse_object_or_die(const struct object_id *oid, const char *name
  * parsing it.  eaten_p indicates if the object has a borrowed copy
  * of buffer and the caller should not free() it.
  */
-#define parse_object_buffer(r, o, t, s, b, e) parse_object_buffer_##r(o, t, s, b, e)
-struct object *parse_object_buffer_the_repository(const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p);
+struct object *parse_object_buffer(struct repository *r, const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p);
 
 /** Returns the object, with potentially excess memory allocated. **/
 struct object *lookup_unknown_object(const unsigned  char *sha1);
-- 
2.18.0.rc1.244.gcf134e6275-goog

