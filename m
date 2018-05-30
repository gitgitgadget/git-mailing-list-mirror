Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6443E1F42D
	for <e@80x24.org>; Wed, 30 May 2018 00:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968595AbeE3Atq (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 20:49:46 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:38196 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966894AbeE3AtH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 20:49:07 -0400
Received: by mail-pf0-f179.google.com with SMTP id b74-v6so4646266pfl.5
        for <git@vger.kernel.org>; Tue, 29 May 2018 17:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S4urZNBqUftaNhoFuboQIszwZFl5MHXSbBqHQp0dERo=;
        b=Ji9qOamnmLABwVmReWFTjsRcGgavwb3hwwUpPZBl4CP0hrmHnMECA5QlS5SP9ECCUa
         19xWS7qd/a6VwjMLJcT9qRAPkKoJlOBhbiG8eDrtOrzxQ9XpftdlICGEKBGBpbAGcHcW
         ZTAwfRXTv0N8Z/mf0HnE5IJ9VTnlByorAxQNX54NpIgAwWSyjYHzzUmauvVGNw84POdo
         rHTvX3tJY9LRxD6OokOoBMhdgEGgMzZY6rDPQbvFwEsvgzlfFjWLp9TN/jUiNCJkxoNC
         NlLIs8yFzfD8D2c8In966Hc0ByIH4TSzV0ZfClKJEs2Gbl5I9Ic/Jgn4QiOS3LI2GqZ8
         39mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S4urZNBqUftaNhoFuboQIszwZFl5MHXSbBqHQp0dERo=;
        b=hDSmQq6Vru2v102X9f4rkfNHdmjrrEnQG9fpWh78b5Sn0zx+kyR0CFpUg5K5UoNWYR
         xLQexDFyvohMekd++De0gxGkO1C7e3qoEonpOSvB0xIIqtoUN4raKxgx5ojjvZ3EwP3D
         P3s9ojR7AQPJGqQ3sugE3iHd8y+V078Y+qALsK7LRi36D8yBU4WXc5tb2WsRtP9IFwbl
         /ZMnhKsSlmAEXyqjcZutiAa8Wmhb4eR9A0UhKo5lJLzvfb3cZpNrx5eh6wKvF97t7YJH
         aSJ6754I3mBI4rcV5hsDIYwLb3oyDc97Nh5r2ts1CVk+Cqbie45cPlNGjzmq1xGIgEGL
         IlGQ==
X-Gm-Message-State: ALKqPweY39Cdfjioz33xs0R1f+C/2PiNe3J36I3eFgfO0e9C9NKx+fOr
        Nrvy4Qp8wNqCjp+qTpTxXy2x2qVxeR8=
X-Google-Smtp-Source: ADUXVKKk3Dqsu/VahSf+0omRGcDoE+Cok6E/fyWi0ly/N8yjxc7ugzg1aEboeMKrC/vRzsmnQXZMGQ==
X-Received: by 2002:a62:e903:: with SMTP id j3-v6mr616654pfh.196.1527641345948;
        Tue, 29 May 2018 17:49:05 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id x10-v6sm123697565pfd.162.2018.05.29.17.49.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 17:49:05 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 31/35] object.c: allow parse_object_buffer to handle arbitrary repositories
Date:   Tue, 29 May 2018 17:48:06 -0700
Message-Id: <20180530004810.30076-32-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180530004810.30076-1-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com>
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
index ce29601c6c2..d3bdee6888f 100644
--- a/object.c
+++ b/object.c
@@ -185,21 +185,21 @@ struct object *lookup_unknown_object_the_repository(const unsigned char *sha1)
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
index 45e22282101..0cd1307b61c 100644
--- a/object.h
+++ b/object.h
@@ -137,8 +137,7 @@ struct object *parse_object_or_die(const struct object_id *oid, const char *name
  * parsing it.  eaten_p indicates if the object has a borrowed copy
  * of buffer and the caller should not free() it.
  */
-#define parse_object_buffer(r, o, t, s, b, e) parse_object_buffer_##r(o, t, s, b, e)
-struct object *parse_object_buffer_the_repository(const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p);
+struct object *parse_object_buffer(struct repository *r, const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p);
 
 /** Returns the object, with potentially excess memory allocated. **/
 #define lookup_unknown_object(r, s) lookup_unknown_object_##r(s)
-- 
2.17.0.582.gccdcbd54c44.dirty

