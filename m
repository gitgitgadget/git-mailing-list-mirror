Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 156C21F424
	for <e@80x24.org>; Thu, 10 May 2018 00:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965803AbeEJAkw (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 20:40:52 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34655 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965294AbeEJAkt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 20:40:49 -0400
Received: by mail-pl0-f68.google.com with SMTP id ay10-v6so248874plb.1
        for <git@vger.kernel.org>; Wed, 09 May 2018 17:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qhy1XflBOTa8+jjKKDVgf/dc8pguLKI3YGlr1C4VBTI=;
        b=sKhHERKd6QkwY55jM7cEqJkmEexjsKiV45OCHTvyYeKkysEV/D7t/5u0EoIwWQQflv
         dMm0NG7gXuGgFv51mS7uS2rGLoZnw+oEFsbIIfBYO6B8gxo0Bgg7mUOULdnAurPfrIWl
         jp+Ia9P35H+Z05ZQhY/oANPX6nt7N3pIxBp9eQOU6MtLnz2rE4mOmzPKCPZtg+t20rxR
         1luoyAPUrltIy9dDYjFu88eM5ecqpBmd01ACYpTZvLQlxJGGQTb/oeYciIwoXSB/FcXy
         UsuNqg/riunZyq4v2AXV0oI2XwZ5ONONb18BA2+6tTPonjXRLiipL1ieffu6fKjMyY2u
         rhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qhy1XflBOTa8+jjKKDVgf/dc8pguLKI3YGlr1C4VBTI=;
        b=c5ShPI1SIb527DEsVDSOtg2wF/eKp8XtJRvSFufiYJNYfSBg2pBKFK8XmvK1TPfh3V
         27upfrVKyfwf7LR+7ms0Ms2rDIewsiTdtbfEEebfUQDNtxPfKTIowoa6WJf1fCNqD0Fa
         yEKE8Kcq3jFA5nDPRLlaGUO+tiuoev/xI0/wsuFV6/FEVqmtwMK00otVC+RkJHh2JZ0h
         hE2TqXUU39nlYtA2MBdexKt2oiBJAXSvqJtPu+Cb5vNQNRb8XGhb8KDm6liAe5kn0HRN
         q0knNgzNMFXW90/gVrZAG4hjEEZsD2plpScbEZjzNFO+42Cp7D2hKS46x+9WSPGznHtL
         Wv/w==
X-Gm-Message-State: ALQs6tBXPljuI9C8hFW5fFDChbuHlL6Fg7NfMiQJVR1Nuy6xkurfggnq
        4uaZkDvrmYwLg0imeo3YavHIJ6U9TS4=
X-Google-Smtp-Source: AB8JxZp4WpaOlhZ14Qv2CDDa+D2HuTN7Uw5hMQGBwOECsLd3m7DaPrnJY3w2uBl7ZdYU2aH7qoZ0RQ==
X-Received: by 2002:a17:902:274a:: with SMTP id j10-v6mr48546509plg.393.1525912848219;
        Wed, 09 May 2018 17:40:48 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id t80-v6sm43105341pgb.36.2018.05.09.17.40.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 May 2018 17:40:47 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jamill@microsoft.com,
        jonathantanmy@google.com, pclouds@gmail.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v4 12/13] object: allow create_object to handle arbitrary repositories
Date:   Wed,  9 May 2018 17:40:23 -0700
Message-Id: <20180510004024.93974-13-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <20180510004024.93974-1-sbeller@google.com>
References: <20180508193736.14883-1-sbeller@google.com>
 <20180510004024.93974-1-sbeller@google.com>
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

