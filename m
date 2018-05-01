Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86F831FADF
	for <e@80x24.org>; Tue,  1 May 2018 21:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751324AbeEAVe1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 17:34:27 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43920 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751245AbeEAVeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 17:34:25 -0400
Received: by mail-pf0-f195.google.com with SMTP id j11so9964022pff.10
        for <git@vger.kernel.org>; Tue, 01 May 2018 14:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c6HGXNiNNxNhDfGSfPhDrHntrE79hC56u0ZQCCqKTkI=;
        b=dahSxp87FugxAJY7fhkVhD0Rcei2dJ18YZ0B+kOBi9hUR+sxh9mHNUASyhm9TLa6+U
         vfnlFmUWHL6NrinlG/xACuhK05Y7faKKmLHnzr1rK4z68p4PWl5sPwu92nyLD4sVI9Wf
         Pt2bjg0YoK0ym7WFE32URcU1hQSME49Y48O5NyQiRUiZ74c8Uo8ixbgsKvAlymWXAZmi
         foVcjDExIdcAleFargFRnH98ZcXPic7QI87xJS/ICfipf81I5hDRIfNHAN9B/RP9267l
         MELN9zyNqX55TRZJd//PzkkLQ2vCUR+rT9zPIkMCHb+pAcg9W9RVvAsmyM/FaRi9Z0vR
         gFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c6HGXNiNNxNhDfGSfPhDrHntrE79hC56u0ZQCCqKTkI=;
        b=Lk5PoU4nwNDblyALbsyNni947L5nJJzwFpKkwxBLf+72oRcqyxkSxBc0eX8HFf3kiD
         0nYdPHfUCX4JX+Ro5QbheDh7jq3wS1OkQawNv6fnQsoFJf/vj7PIBcdhfu21WpERZlSh
         UR3qMQzWoMDBQY9KSsN65uzfiKndHIr3F1SKGaUsSkqB2LL5b39n0NG1qq2Lpz43hbMw
         HXzWMWdLUSmdeuP8eYh0dS8YROSJgxzexHswEEe+Rwv0zx5g1Bzi+aBo40ITKiYSPwvu
         jiDSjc1v+uDYeYGrPSYk27ioetyKsZsvwOGGsnaJf2FycBEghgSJvG5QtrMbqwPdtPiK
         qJNw==
X-Gm-Message-State: ALQs6tATLeNf1UHsCmvl9S7PGlsxcaS7M5wkUae6/9bBXVn7S2j2QSQB
        GvG+4fr86SCoOYREWLZbkKJ0016Y9cE=
X-Google-Smtp-Source: AB8JxZp0rd4xjIucWnZmECX1MP9uRphGGPvR8ybiy8LJ6Ukc1XHrJ20wX4puB1SnMcfrEX3DCsmBbQ==
X-Received: by 2002:a65:6027:: with SMTP id p7-v6mr561752pgu.210.1525210464794;
        Tue, 01 May 2018 14:34:24 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id k13sm23124429pfj.186.2018.05.01.14.34.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 14:34:24 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jamill@microsoft.com, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 12/13] object: allow create_object to handle arbitrary repositories
Date:   Tue,  1 May 2018 14:34:02 -0700
Message-Id: <20180501213403.14643-13-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180501213403.14643-1-sbeller@google.com>
References: <20180501213403.14643-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 object.c | 12 ++++++------
 object.h |  3 +--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/object.c b/object.c
index 43954fadf93..fd27cf54faa 100644
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
index d1869dbc502..5ef6ce1ea96 100644
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
2.17.0.441.gb46fe60e1d-goog

