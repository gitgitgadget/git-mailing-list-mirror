Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 226C2200B9
	for <e@80x24.org>; Tue,  8 May 2018 19:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755615AbeEHTiF (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 15:38:05 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46536 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755567AbeEHTiC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 15:38:02 -0400
Received: by mail-pl0-f67.google.com with SMTP id 59-v6so2813122plc.13
        for <git@vger.kernel.org>; Tue, 08 May 2018 12:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qhy1XflBOTa8+jjKKDVgf/dc8pguLKI3YGlr1C4VBTI=;
        b=vuTYLRME8Nc8+0hHWxPcGwwbnx+E5/iateeToK9ByMnRZY3xxkM76tQ9+Sm5+XSB34
         IN8p6bIAIbZkg6oeCTHZgSkp6WxGMixDhYJtHCRzvHPvYe4+t6R4o3JLm7T6fRsoxEYH
         xU4znpAHUDG1cENZAjdUyF1Wlx/yLWY84d3F4FltXxbf56iyF7z0d7jbClojX1v2F6Gn
         etY7N/eFpfCQypD3DxHc128zhNpWnukyaahVDeE5unPySphu7L74kQY69w4aM4ndxzXD
         KFGTdOl/lwq1EQmV6qjTiQ3zKbG3PooDqZucq79obblshc0tJ93Zjx0Ur7JdvRyRfGSI
         EO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qhy1XflBOTa8+jjKKDVgf/dc8pguLKI3YGlr1C4VBTI=;
        b=mbzeKQmMiMzuNN0ntZ/1JrCwYO8tLEqfXn2SMubQusYdtbFrX2FmQocNrKxtCEqtkS
         DH0LVc9NzmS+eVavqquPkaUP7vKGixHejQ8GepAJBudvpiDUHTa2sQtBYRiYVZn5W5bV
         43n0akguTMva3M4tElHPayAlwxquThrrlE4H2SaTBrtqyx1s7ts9nfkuISRSxPPVTcNM
         eLQcNUmp+MPj8/QKWB823x7FaC5mPe9eKaMooKAyFyYuXgiKWbXn9Rrpo89LTgFW+wdF
         u1yzdIb5SDbqde8gnmWjVFEKfYUyjTcnOe1JBNGl1iMEu8wOKp3T47G36DU0aFlA7CLa
         dHiQ==
X-Gm-Message-State: ALQs6tAnqgH9FV6yAvc2lKMu0QYrvADkwFMjACsmMbS2JTr26j+iha6O
        J+kwXfv7mZR0HCC+6ln69jsgJw==
X-Google-Smtp-Source: AB8JxZqfdOaj6EEmg2ADlvR6t7XclbEvb+VFUzE4maBI7R2YOZM7AqUCtbUc+ce5asrwwthgUuN0MQ==
X-Received: by 2002:a17:902:3381:: with SMTP id b1-v6mr42870454plc.248.1525808281444;
        Tue, 08 May 2018 12:38:01 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id i1sm18039974pfj.83.2018.05.08.12.37.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 May 2018 12:38:00 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jamill@microsoft.com,
        jonathantanmy@google.com, pclouds@gmail.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3 12/13] object: allow create_object to handle arbitrary repositories
Date:   Tue,  8 May 2018 12:37:35 -0700
Message-Id: <20180508193736.14883-13-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <20180508193736.14883-1-sbeller@google.com>
References: <20180507225916.155236-1-sbeller@google.com>
 <20180508193736.14883-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 object.c | 12 ++++++------
 object.h |  3 +--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/object.c b/object.c
index 0fcd6f6df42..49b952e9299 100644
--- a/object.c
+++ b/object.c
@@ -139,7 +139,7 @@ static void grow_object_hash(struct repository *r)
 	r->parsed_objects->obj_hash_size = new_hash_size;
 }
 
-void *create_object_the_repository(const unsigned char *sha1, void *o)
+void *create_object(struct repository *r, const unsigned char *sha1, void *o)
 {
 	struct object *obj = o;
 
@@ -147,12 +147,12 @@ void *create_object_the_repository(const unsigned char *sha1, void *o)
 	obj->flags = 0;
 	hashcpy(obj->oid.hash, sha1);
 
-	if (the_repository->parsed_objects->obj_hash_size - 1 <= the_repository->parsed_objects->nr_objs * 2)
-		grow_object_hash(the_repository);
+	if (r->parsed_objects->obj_hash_size - 1 <= r->parsed_objects->nr_objs * 2)
+		grow_object_hash(r);
 
-	insert_obj_hash(obj, the_repository->parsed_objects->obj_hash,
-			the_repository->parsed_objects->obj_hash_size);
-	the_repository->parsed_objects->nr_objs++;
+	insert_obj_hash(obj, r->parsed_objects->obj_hash,
+			r->parsed_objects->obj_hash_size);
+	r->parsed_objects->nr_objs++;
 	return obj;
 }
 
diff --git a/object.h b/object.h
index 2cb0b241083..b41d7a3accb 100644
--- a/object.h
+++ b/object.h
@@ -93,8 +93,7 @@ extern struct object *get_indexed_object(unsigned int);
  */
 struct object *lookup_object(const unsigned char *sha1);
 
-#define create_object(r, s, o) create_object_##r(s, o)
-extern void *create_object_the_repository(const unsigned char *sha1, void *obj);
+extern void *create_object(struct repository *r, const unsigned char *sha1, void *obj);
 
 void *object_as_type(struct object *obj, enum object_type type, int quiet);
 
-- 
2.17.0.255.g8bfb7c0704

