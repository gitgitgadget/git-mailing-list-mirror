Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A3F01F42D
	for <e@80x24.org>; Wed, 30 May 2018 00:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968566AbeE3AtJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 20:49:09 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33666 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968551AbeE3As6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 20:48:58 -0400
Received: by mail-pf0-f170.google.com with SMTP id a20-v6so8105662pfo.0
        for <git@vger.kernel.org>; Tue, 29 May 2018 17:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VwHdL/baqnRBpH/53gRLOqGlgDB7lrr1ijqTh5AWR1I=;
        b=mvoPmXgQw/IlK140jSprAg1I+CGL5BuphWqPZE+XPi0Hoqm33OwW3uxpMokWFxahzS
         imUsmE1ef4QbfwbB2ehkDPjnYZUnZE0/sP7+2ByD8P5dlKwHGcYtd3PDyv2MEzHyOvO9
         OYZCMRdB1TJTWsZmS86g8ghMrrsfQCqyQUyugMaDj6v96ws/N7oWL2FIEpjqmYg7JeO5
         CWsU01oL5NaGS+S7BTPQq5abeF8Yq/JZwSte2y8CzKFbaqscKwi/TGz7WbHcZ95ss6zX
         /g7h7BOU6lFegSsJ729E/ElGA4EPqDlIeXH8f3uGpLy5+lrqJUI0lghEai5IJA3JOHhM
         puRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VwHdL/baqnRBpH/53gRLOqGlgDB7lrr1ijqTh5AWR1I=;
        b=Es/lA6G9fJtQmwbjLDeghOn8nic8kusk/PNmEfaK77etaSF1gGFGOr6p9i5Zu2f2TV
         4KTP9YlM1In/gxib0i9uUjwhVACF9s/MjOYivpw3kz1KD9/D1N338d4xk6kMlZAVUEas
         27pLwp+WqI7vn5+rj7AoYgAMYIiek0JyhqcV5Y26rnozb1A1yVEFHaaLaHOZZZCDlpHf
         rEOXTfbzoXh+2+XLfSdyw3HUcyv4gX0hE/P7NiTXTwDdB88f0s3HX2TGMi0X/e3xrQms
         TupOnnKL8llbr9RH5neq44X6/riYYFIJGQLNIYWkoUdPnLrop2zDobb5XbWtRlHMOyod
         nSkg==
X-Gm-Message-State: ALKqPwfoAVS9AS8LwIVzBH5AQq73liNCU+cvCjkcoKrvJHx7raAgcErr
        6qrbaMewM5cDa2OU7L604V7pPVqX5sI=
X-Google-Smtp-Source: ADUXVKLPI3l0XLcPq6/Hnzkh0zypW+HsATr/a9k1A6TKKrSymeqMR0Kwk8jZKIMdiTu8EVvQRzT5tg==
X-Received: by 2002:a62:5c06:: with SMTP id q6-v6mr616691pfb.118.1527641337482;
        Tue, 29 May 2018 17:48:57 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id x2-v6sm74873948pfk.113.2018.05.29.17.48.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 17:48:56 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 25/35] tag: allow parse_tag_buffer to handle arbitrary repositories
Date:   Tue, 29 May 2018 17:48:00 -0700
Message-Id: <20180530004810.30076-26-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180530004810.30076-1-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 tag.c | 10 +++++-----
 tag.h |  3 +--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/tag.c b/tag.c
index 46b5882ee12..682e7793059 100644
--- a/tag.c
+++ b/tag.c
@@ -126,7 +126,7 @@ void release_tag_memory(struct tag *t)
 	t->date = 0;
 }
 
-int parse_tag_buffer_the_repository(struct tag *item, const void *data, unsigned long size)
+int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, unsigned long size)
 {
 	struct object_id oid;
 	char type[20];
@@ -154,13 +154,13 @@ int parse_tag_buffer_the_repository(struct tag *item, const void *data, unsigned
 	bufptr = nl + 1;
 
 	if (!strcmp(type, blob_type)) {
-		item->tagged = (struct object *)lookup_blob(the_repository, &oid);
+		item->tagged = (struct object *)lookup_blob(r, &oid);
 	} else if (!strcmp(type, tree_type)) {
-		item->tagged = (struct object *)lookup_tree(the_repository, &oid);
+		item->tagged = (struct object *)lookup_tree(r, &oid);
 	} else if (!strcmp(type, commit_type)) {
-		item->tagged = (struct object *)lookup_commit(the_repository, &oid);
+		item->tagged = (struct object *)lookup_commit(r, &oid);
 	} else if (!strcmp(type, tag_type)) {
-		item->tagged = (struct object *)lookup_tag(the_repository, &oid);
+		item->tagged = (struct object *)lookup_tag(r, &oid);
 	} else {
 		error("Unknown type %s", type);
 		item->tagged = NULL;
diff --git a/tag.h b/tag.h
index 6a160c91875..efd4c7da67c 100644
--- a/tag.h
+++ b/tag.h
@@ -12,8 +12,7 @@ struct tag {
 	timestamp_t date;
 };
 extern struct tag *lookup_tag(struct repository *r, const struct object_id *oid);
-#define parse_tag_buffer(r, i, d, s) parse_tag_buffer_##r(i, d, s)
-extern int parse_tag_buffer_the_repository(struct tag *item, const void *data, unsigned long size);
+extern int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, unsigned long size);
 extern int parse_tag(struct tag *item);
 extern void release_tag_memory(struct tag *t);
 #define deref_tag(r, o, w, l) deref_tag_##r(o, w, l)
-- 
2.17.0.582.gccdcbd54c44.dirty

