Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C3D61F406
	for <e@80x24.org>; Tue, 15 May 2018 23:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752145AbeEOXmo (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 19:42:44 -0400
Received: from mail-pl0-f41.google.com ([209.85.160.41]:33656 "EHLO
        mail-pl0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752021AbeEOXmk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 19:42:40 -0400
Received: by mail-pl0-f41.google.com with SMTP id n10-v6so972591plp.0
        for <git@vger.kernel.org>; Tue, 15 May 2018 16:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d6iUmDIIEGNNq+xVH44siQoG2o3uKyQFY35/kP6CYVk=;
        b=MyXjbnEOal5DLLOvR0cWgcskwPRj70MX+QETC3N/vKwtMov/7Di/g1N8ZzIo4XCw+v
         FgZW4+NmFLT+aWjrXQRUr399ct2Z5TRZ+4t2Ww8ELFbNblRKxyVDD+j9cbBaZVgv6hh1
         KQ1Ud65rpb1Emx3vXAfDooC45J8p5H9HR9cM+nNlcR4xB1jL6pGcDILOpb4EIQWA6Toh
         V7e2YHMLtHjfhXItKm4VhJx2yvFbsZKwfduBEU/rFB8dCSmS/Va5/Npg1FfNX0zJk3qF
         p0GkfTCPPMs1aHy0weZjpDlBqVHpq8pD1JhJRlJwMsomlHSmXGNoZUesboERoBj1Owxp
         oJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d6iUmDIIEGNNq+xVH44siQoG2o3uKyQFY35/kP6CYVk=;
        b=cOCtYBD0v1fRu3SSKSYJzjP+6TXprKBERZkAaZA797k/93kszkSp27WOn8Q8KIdlQe
         s2drlQZXprObzi154nfeethDGvTcjmoGl1y5LalTgrII6Nbx+usplGNRV/7nwrh8Vgf2
         kfwPBUO/2s+t1/CYyDu7GEq9QgMPn4grKFz0O8kZKg2mFTVE9Go778BTrIwONkUZu3ay
         OVx1NxKaTfpbYqkwsa/Oau3siFCG8fYO/fbhOLcIclm5PKqU3uE2MKCst5RLuH0NAen3
         vKpb5rmLMB1Db5TWSAB97nf5ivZPextAwom+E/KhLiDqgLzy7xuKTT565LmUgoaAmrh6
         /zFg==
X-Gm-Message-State: ALKqPwfXvDdb3op5GsYu+5XfSE3SI+bVb4FJK0FnnEo7cQ8MCYzi9C8Z
        /w0zMx2qyeXnufeL8msQe0ic1JU6YVw=
X-Google-Smtp-Source: AB8JxZoet3F9c4o+PVtqqWLpjcVb0KszqkNneaBzxCcebto3SgcDmU3sMdRsS8gKVu66JDgqy3RKsA==
X-Received: by 2002:a17:902:2006:: with SMTP id n6-v6mr16713739pla.125.1526427758952;
        Tue, 15 May 2018 16:42:38 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id 206-v6sm1413271pfy.51.2018.05.15.16.42.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 16:42:38 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 02/19] object: move grafts to object parser
Date:   Tue, 15 May 2018 16:42:16 -0700
Message-Id: <20180515234233.143708-3-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180515234233.143708-1-sbeller@google.com>
References: <20180515234233.143708-1-sbeller@google.com>
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
 commit.c | 42 +++++++++++++++++++++++-------------------
 object.h |  4 ++++
 2 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/commit.c b/commit.c
index b053f07f305..a0c9eb05c82 100644
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
@@ -97,9 +98,6 @@ static timestamp_t parse_commit_date(const char *buf, const char *tail)
 	return parse_timestamp(dateptr, NULL, 10);
 }
 
-static struct commit_graft **commit_graft;
-static int commit_graft_alloc, commit_graft_nr;
-
 static const unsigned char *commit_graft_sha1_access(size_t index, void *table)
 {
 	struct commit_graft **commit_graft_table = table;
@@ -108,7 +106,8 @@ static const unsigned char *commit_graft_sha1_access(size_t index, void *table)
 
 static int commit_graft_pos(const unsigned char *sha1)
 {
-	return sha1_pos(sha1, commit_graft, commit_graft_nr,
+	return sha1_pos(sha1, the_repository->parsed_objects->grafts,
+			the_repository->parsed_objects->grafts_nr,
 			commit_graft_sha1_access);
 }
 
@@ -120,18 +119,22 @@ int register_commit_graft(struct commit_graft *graft, int ignore_dups)
 		if (ignore_dups)
 			free(graft);
 		else {
-			free(commit_graft[pos]);
-			commit_graft[pos] = graft;
+			free(the_repository->parsed_objects->grafts[pos]);
+			the_repository->parsed_objects->grafts[pos] = graft;
 		}
 		return 1;
 	}
 	pos = -pos - 1;
-	ALLOC_GROW(commit_graft, commit_graft_nr + 1, commit_graft_alloc);
-	commit_graft_nr++;
-	if (pos < commit_graft_nr)
-		MOVE_ARRAY(commit_graft + pos + 1, commit_graft + pos,
-			   commit_graft_nr - pos - 1);
-	commit_graft[pos] = graft;
+	ALLOC_GROW(the_repository->parsed_objects->grafts,
+		   the_repository->parsed_objects->grafts_nr + 1,
+		   the_repository->parsed_objects->grafts_alloc);
+	the_repository->parsed_objects->grafts_nr++;
+	if (pos < the_repository->parsed_objects->grafts_nr)
+		memmove(the_repository->parsed_objects->grafts + pos + 1,
+			the_repository->parsed_objects->grafts + pos,
+			(the_repository->parsed_objects->grafts_nr - pos - 1) *
+			sizeof(*the_repository->parsed_objects->grafts));
+	the_repository->parsed_objects->grafts[pos] = graft;
 	return 0;
 }
 
@@ -213,14 +216,14 @@ struct commit_graft *lookup_commit_graft(const struct object_id *oid)
 	pos = commit_graft_pos(oid->hash);
 	if (pos < 0)
 		return NULL;
-	return commit_graft[pos];
+	return the_repository->parsed_objects->grafts[pos];
 }
 
 int for_each_commit_graft(each_commit_graft_fn fn, void *cb_data)
 {
 	int i, ret;
-	for (i = ret = 0; i < commit_graft_nr && !ret; i++)
-		ret = fn(commit_graft[i], cb_data);
+	for (i = ret = 0; i < the_repository->parsed_objects->grafts_nr && !ret; i++)
+		ret = fn(the_repository->parsed_objects->grafts[i], cb_data);
 	return ret;
 }
 
@@ -229,10 +232,11 @@ int unregister_shallow(const struct object_id *oid)
 	int pos = commit_graft_pos(oid->hash);
 	if (pos < 0)
 		return -1;
-	if (pos + 1 < commit_graft_nr)
-		MOVE_ARRAY(commit_graft + pos, commit_graft + pos + 1,
-			   commit_graft_nr - pos - 1);
-	commit_graft_nr--;
+	if (pos + 1 < the_repository->parsed_objects->grafts_nr)
+		MOVE_ARRAY(the_repository->parsed_objects->grafts + pos,
+			   the_repository->parsed_objects->grafts + pos + 1,
+			   the_repository->parsed_objects->grafts_nr - pos - 1);
+	the_repository->parsed_objects->grafts_nr--;
 	return 0;
 }
 
diff --git a/object.h b/object.h
index 7916edb4edf..ec908f9bcc1 100644
--- a/object.h
+++ b/object.h
@@ -12,6 +12,10 @@ struct parsed_object_pool {
 	struct alloc_state *tag_state;
 	struct alloc_state *object_state;
 	unsigned commit_count;
+
+	/* parent substitutions from .git/info/grafts and .git/shallow */
+	struct commit_graft **grafts;
+	int grafts_alloc, grafts_nr;
 };
 
 struct parsed_object_pool *parsed_object_pool_new(void);
-- 
2.17.0.582.gccdcbd54c44.dirty

