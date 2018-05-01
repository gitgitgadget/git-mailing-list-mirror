Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E0811FADF
	for <e@80x24.org>; Tue,  1 May 2018 21:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751174AbeEAVeq (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 17:34:46 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36761 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbeEAVeP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 17:34:15 -0400
Received: by mail-pf0-f194.google.com with SMTP id w129so4547227pfd.3
        for <git@vger.kernel.org>; Tue, 01 May 2018 14:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RJ4YYy8tazAGUVX4NhpP+PjBAWmfo2mlB8sD0mZ9nOE=;
        b=WyKJc2hqKzpH8s5EdWavH90LMBOR8+fVErd2cFdHjCw6/h9V5zVf2BNr1UqWkPtj9C
         P9BQDroolXOQ0le/iMBN79w61w33D2TiG7H7B6yr60CIUVhLKFOpJJz98pFzky36AB4m
         SAi4GVAb95GPsS2xLSKNNsv0akwZYdmPoDrkZ8gl1wepkagJlAKoS7WOiSrfTQI4OLdb
         Jqi6t6j5Sb6OiGkbCdh+r1i2uE65puSlddFtTUsJiGdlzxsttuZYxkQDarDGRH1SSE4t
         tHNVRIvsmPZH0VUAxOJpo4eHO3lrjlwKF1Dj1UbBt6bCJv1jzJjcbrIUF86oAoOs4M7o
         vIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RJ4YYy8tazAGUVX4NhpP+PjBAWmfo2mlB8sD0mZ9nOE=;
        b=ME+B4oH0bIFyxpWj5aCj5kcEcbXqmO7IwucMTH2qHhKIwop4Ksm4M5s6u6BG4il6zj
         0XGoc19bC3xmRSF7+5LBdzkU3mCj+Y17n5SpmzPNCaip5DQKztDpLssG1EmlNima8Qqg
         GZAbEqTst39gXALzjvAhTqwUVLbo72PW0NzQs8kzeaFQGKTHkCPoTo1EbgNPVD9lGwPI
         7DNQB9whsH3ijdxf87DjvxEYQ7nI5az39r0fWJKPttGZBVdxIzqua9uqmgEHOMvZA8sN
         imCwKaR47/ToJYdcvwyXcIRX8tpqeTLua+qTZPjNa5sqVCzt7/W9VM7QMjZ9QOQD1N9Q
         lyWQ==
X-Gm-Message-State: ALQs6tBi5x1qtm4ft/ISm5vYmPm8foyir7STIxdd25onCoYxWp4mpaz+
        OapsBYgtg8JFD/ev+F60M6RTShjlPtw=
X-Google-Smtp-Source: AB8JxZpMxZJE6o8ffJ2piGeuHURlX5cKImoH+DU5d7nHFW6XjUBGbeTlH5fZY1KDSj5Tu59+FjkOAQ==
X-Received: by 2002:a65:5142:: with SMTP id g2-v6mr3616731pgq.349.1525210453718;
        Tue, 01 May 2018 14:34:13 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id r8-v6sm4691588pgn.2.2018.05.01.14.34.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 14:34:12 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jamill@microsoft.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 04/13] alloc: add repository argument to alloc_blob_node
Date:   Tue,  1 May 2018 14:33:54 -0700
Message-Id: <20180501213403.14643-5-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180501213403.14643-1-sbeller@google.com>
References: <20180501213403.14643-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 alloc.c | 2 +-
 blob.c  | 2 +-
 cache.h | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/alloc.c b/alloc.c
index 12afadfacdd..6c5c376a25a 100644
--- a/alloc.c
+++ b/alloc.c
@@ -49,7 +49,7 @@ static inline void *alloc_node(struct alloc_state *s, size_t node_size)
 }
 
 static struct alloc_state blob_state;
-void *alloc_blob_node(void)
+void *alloc_blob_node_the_repository(void)
 {
 	struct blob *b = alloc_node(&blob_state, sizeof(struct blob));
 	b->object.type = OBJ_BLOB;
diff --git a/blob.c b/blob.c
index 85c2143f299..9e64f301895 100644
--- a/blob.c
+++ b/blob.c
@@ -9,7 +9,7 @@ struct blob *lookup_blob(const struct object_id *oid)
 	struct object *obj = lookup_object(oid->hash);
 	if (!obj)
 		return create_object(the_repository, oid->hash,
-				     alloc_blob_node());
+				     alloc_blob_node(the_repository));
 	return object_as_type(obj, OBJ_BLOB, 0);
 }
 
diff --git a/cache.h b/cache.h
index 3a4d80e92bf..2258e611275 100644
--- a/cache.h
+++ b/cache.h
@@ -1764,7 +1764,8 @@ int decode_85(char *dst, const char *line, int linelen);
 void encode_85(char *buf, const unsigned char *data, int bytes);
 
 /* alloc.c */
-extern void *alloc_blob_node(void);
+#define alloc_blob_node(r) alloc_blob_node_##r()
+extern void *alloc_blob_node_the_repository(void);
 extern void *alloc_tree_node(void);
 extern void *alloc_commit_node(void);
 extern void *alloc_tag_node(void);
-- 
2.17.0.441.gb46fe60e1d-goog

