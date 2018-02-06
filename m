Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6F471F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752415AbeBFAaR (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:30:17 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34876 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752366AbeBFAaD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:30:03 -0500
Received: by mail-pl0-f65.google.com with SMTP id j19so144956pll.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OKVs01l7nrXJPC3encFPisfvkhtXwSoV4ALta/jUa2I=;
        b=q5qcm3Ml7fBUMJppQT+XGWCywlmeqLP5WgTu815LwIB/sPlB46r6s2oLcghGOH6ZB2
         I7Frcc3NONeQ98tAxtdl833Wi6Pk6nYREwnLtOpA5y/TVsx5U4oykfL89kXGgzK3H5TW
         11EA13aslHjMN/S3AI16J+CI+KeLI75wD6iiTQDkwVydKwhiavfRdvOLtVDQS4xtDc4S
         9ewOKoX3pxG3NOGwsSR8xZzuDBsd3Xel24pRUDjVIK7FQ3P+xn7U9IW+MoApPwi8A7hE
         scn+4aR+JR3yknmreqiZN1HWIb5kHuOw/gFRO6Bhp6jiNuzwWSLn1F7RB5r4wPui2Jha
         S2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OKVs01l7nrXJPC3encFPisfvkhtXwSoV4ALta/jUa2I=;
        b=bNeZwGXylcNZuyJp+cLVvtDN3RZ452pw/dZkh0S4WZUFgDKLCHnlkdaOrk9XZYzYuC
         0L0id0XW9IBFt70nR0DA72FWYvSlB4LXAsXGaFlBsnR2jU8YbNsbyzQbC9gaSMgHpwIY
         mToP/ME46CzZm701Hvq7m5z/lL56+jf9uAzDaEaUufqcp7q2xtJPfNkhaXbLTlqpTVHQ
         fAqFKcTFQkT/2d2YukAuMcXAKIjfj6CQeA7zahdrEdwUPXvxcQUd53FP+iERlbmBWWpE
         y7YTnMtFVQkVG+oJ+qLtugtxafk4kWUXLHfStjHZNOns4PiDYp68YhIy/5t7NusNXjxM
         Ogfw==
X-Gm-Message-State: APf1xPAcGOpyKZK7nra9WRjiXppITbTtCSJn2MxQ/R9b/NQREk+ITmt8
        sN8/EVWh2WRZxECWoYm39TNkNX/5ewQ=
X-Google-Smtp-Source: AH8x2245GhCkaSmkmWOK8h5nFJZS0M5G4wEyiNhTnTb3NIcIqUZFbYduPc98HIrD+i+qLYMvbPEeDg==
X-Received: by 2002:a17:902:aa46:: with SMTP id c6-v6mr547849plr.357.1517877002780;
        Mon, 05 Feb 2018 16:30:02 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id l10sm10205080pfc.133.2018.02.05.16.30.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:30:02 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 176/194] object: allow parse_object_buffer to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:17:31 -0800
Message-Id: <20180206001749.218943-78-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
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
index c2268990dd..2a05613c64 100644
--- a/object.c
+++ b/object.c
@@ -184,21 +184,21 @@ struct object *lookup_unknown_object(struct repository *r,
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
@@ -210,20 +210,20 @@ struct object *parse_object_buffer_the_repository(const struct object_id *oid, e
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
index 14e0d412bb..a5456fc2d7 100644
--- a/object.h
+++ b/object.h
@@ -174,8 +174,7 @@ struct object *parse_object_or_die(const struct object_id *oid, const char *name
  * parsing it.  eaten_p indicates if the object has a borrowed copy
  * of buffer and the caller should not free() it.
  */
-#define parse_object_buffer(r, o, t, s, b, e) parse_object_buffer_##r(o, t, s, b, e)
-struct object *parse_object_buffer_the_repository(const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p);
+struct object *parse_object_buffer(struct repository *r, const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p);
 
 /** Returns the object, with potentially excess memory allocated. **/
 struct object *lookup_unknown_object(struct repository *r, const unsigned char *sha1);
-- 
2.15.1.433.g936d1b9894.dirty

