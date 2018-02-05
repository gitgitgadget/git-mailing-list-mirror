Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E85451F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbeBFAOD (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:14:03 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34364 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752156AbeBFAOA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:14:00 -0500
Received: by mail-pg0-f65.google.com with SMTP id s73so162858pgc.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w9Baw5me45vU+eonVxOj9pXYKbvFpUJl+00F42RW3xI=;
        b=YqZGzJwlwG9QiWXyfMelVJfKm+f2Y8+aG65dNGEl8Udkg78aGimvEp97pnWekQ0/en
         BlNnxuXPfWwv8xkgMFabfCWXqD3rWG3RzC3KfFgyUnhT990hM+1qQ9I2tbsskwYJf1Tm
         pAwxnyJQEa0z8Nklo62pHTZICqDVyQSY98olP71p6rTRxN6ChJyCDkRZMvHvRuizEH3K
         kVHRxSHJijIaKYojmPMi7gFrbBOL9jJbHNXEMZ2RGfjVfG2WMlOmD11CuIvZ+rQwDIae
         KjoAYxhsywjyYllVG2tKc1FQZYw0HDhILwzc7JheywFTlDsjr1HwsnBHf1gZqt21bLwj
         inlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w9Baw5me45vU+eonVxOj9pXYKbvFpUJl+00F42RW3xI=;
        b=a+TzHl+KQlIa0YYetssyl3JFruBfICqqDHZkqsnlMq7jKUVFm5+2mxjmPrS5khnt/D
         YepWer1CTMF2q60LfI0EsInbWJgV/k8GF1BXSVr+zMheTXDkXEst6qEPC6MxMspaj6wN
         vieZBLBYCQ2Zh5FxFzIHtwgK+veNxrTlC6Qn/W/LCRLB+sW77OfSS2jC+sypjniU24tS
         eo29MhX+5iWB1y872pNkKnh1h3mFuLqKnSIfQjRby+c2Dt+OopZT5MMBmWlKUxj5MkXA
         BrUFjNAXNbrwUenyboIYuTW289QGZBl6iaGvxlRB42bCxf9gdKyd+o27IkzHgISaZgIy
         yl7g==
X-Gm-Message-State: APf1xPA1AhbLu8B0RpuQrDpR6YIWqX6nF6MToHcw5gsYnoPVOgal5hlz
        niRyJR0SB2n6z+wl0ekyTOUjyTmK2o0=
X-Google-Smtp-Source: AH8x227rN2axXsk7xXnySLqSvxqqAHBPR3piGZmk+T8xmJG3RuwugvFHNsufr/ZSTaxPsRs9h2qycA==
X-Received: by 10.98.34.27 with SMTP id i27mr519935pfi.43.1517876039171;
        Mon, 05 Feb 2018 16:13:59 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id g27sm9049224pfa.25.2018.02.05.16.13.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:13:58 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 092/194] object: move grafts to object parser
Date:   Mon,  5 Feb 2018 15:55:53 -0800
Message-Id: <20180205235735.216710-72-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Grafts are only meaningful in the context of a single repository.
Therefore they cannot be global.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 commit.c | 44 +++++++++++++++++++++++---------------------
 object.h |  6 +++++-
 2 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/commit.c b/commit.c
index 2137a0b9c6..2ad5537ed7 100644
--- a/commit.c
+++ b/commit.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "tag.h"
 #include "commit.h"
+#include "repository.h"
 #include "object-store.h"
 #include "pkt-line.h"
 #include "utf8.h"
@@ -98,9 +99,6 @@ static timestamp_t parse_commit_date(const char *buf, const char *tail)
 	return parse_timestamp(dateptr, NULL, 10);
 }
 
-static struct commit_graft **commit_graft;
-static int commit_graft_alloc, commit_graft_nr;
-
 static const unsigned char *commit_graft_sha1_access(size_t index, void *table)
 {
 	struct commit_graft **commit_graft_table = table;
@@ -109,7 +107,8 @@ static const unsigned char *commit_graft_sha1_access(size_t index, void *table)
 
 static int commit_graft_pos(const unsigned char *sha1)
 {
-	return sha1_pos(sha1, commit_graft, commit_graft_nr,
+	return sha1_pos(sha1, the_repository->parsed_objects.grafts,
+			the_repository->parsed_objects.grafts_nr,
 			commit_graft_sha1_access);
 }
 
@@ -121,20 +120,22 @@ int register_commit_graft(struct commit_graft *graft, int ignore_dups)
 		if (ignore_dups)
 			free(graft);
 		else {
-			free(commit_graft[pos]);
-			commit_graft[pos] = graft;
+			free(the_repository->parsed_objects.grafts[pos]);
+			the_repository->parsed_objects.grafts[pos] = graft;
 		}
 		return 1;
 	}
 	pos = -pos - 1;
-	ALLOC_GROW(commit_graft, commit_graft_nr + 1, commit_graft_alloc);
-	commit_graft_nr++;
-	if (pos < commit_graft_nr)
-		memmove(commit_graft + pos + 1,
-			commit_graft + pos,
-			(commit_graft_nr - pos - 1) *
-			sizeof(*commit_graft));
-	commit_graft[pos] = graft;
+	ALLOC_GROW(the_repository->parsed_objects.grafts,
+		   the_repository->parsed_objects.grafts_nr + 1,
+		   the_repository->parsed_objects.grafts_alloc);
+	the_repository->parsed_objects.grafts_nr++;
+	if (pos < the_repository->parsed_objects.grafts_nr)
+		memmove(the_repository->parsed_objects.grafts + pos + 1,
+			the_repository->parsed_objects.grafts + pos,
+			(the_repository->parsed_objects.grafts_nr - pos - 1) *
+			sizeof(*the_repository->parsed_objects.grafts));
+	the_repository->parsed_objects.grafts[pos] = graft;
 	return 0;
 }
 
@@ -216,14 +217,14 @@ struct commit_graft *lookup_commit_graft(const struct object_id *oid)
 	pos = commit_graft_pos(oid->hash);
 	if (pos < 0)
 		return NULL;
-	return commit_graft[pos];
+	return the_repository->parsed_objects.grafts[pos];
 }
 
 int for_each_commit_graft(each_commit_graft_fn fn, void *cb_data)
 {
 	int i, ret;
-	for (i = ret = 0; i < commit_graft_nr && !ret; i++)
-		ret = fn(commit_graft[i], cb_data);
+	for (i = ret = 0; i < the_repository->parsed_objects.grafts_nr && !ret; i++)
+		ret = fn(the_repository->parsed_objects.grafts[i], cb_data);
 	return ret;
 }
 
@@ -232,10 +233,11 @@ int unregister_shallow(const struct object_id *oid)
 	int pos = commit_graft_pos(oid->hash);
 	if (pos < 0)
 		return -1;
-	if (pos + 1 < commit_graft_nr)
-		MOVE_ARRAY(commit_graft + pos, commit_graft + pos + 1,
-			   commit_graft_nr - pos - 1);
-	commit_graft_nr--;
+	if (pos + 1 < the_repository->parsed_objects.grafts_nr)
+		MOVE_ARRAY(the_repository->parsed_objects.grafts + pos,
+			   the_repository->parsed_objects.grafts + pos + 1,
+			   the_repository->parsed_objects.grafts_nr - pos - 1);
+	the_repository->parsed_objects.grafts_nr--;
 	return 0;
 }
 
diff --git a/object.h b/object.h
index 727a03ebd6..b667404f88 100644
--- a/object.h
+++ b/object.h
@@ -4,9 +4,13 @@
 struct object_parser {
 	struct object **obj_hash;
 	int nr_objs, obj_hash_size;
+
+	/* parent substitutions from .git/info/grafts and .git/shallow */
+	struct commit_graft **grafts;
+	int grafts_alloc, grafts_nr;
 };
 
-#define OBJECT_PARSER_INIT { NULL, 0, 0 }
+#define OBJECT_PARSER_INIT { NULL, 0, 0, NULL, 0, 0 }
 
 struct object_list {
 	struct object *item;
-- 
2.15.1.433.g936d1b9894.dirty

