Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DD0A200B9
	for <e@80x24.org>; Mon,  7 May 2018 22:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753360AbeEGW7r (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 18:59:47 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35802 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753343AbeEGW7o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 18:59:44 -0400
Received: by mail-pl0-f66.google.com with SMTP id i5-v6so1012015plt.2
        for <git@vger.kernel.org>; Mon, 07 May 2018 15:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=br+deI8IeswQxDx71WP2p1uI7zhESszQB0HCABxe3MA=;
        b=dPzZcrhi6n/yqqtPL0A6X4QCqjrVZ8p01gTVZDoCuCSQX2k3Vj0JXs17y0U0GhYuyz
         y5LfwfhOVa+glX/Fd1MYZ59O/liGYaHuDR1FMitD9IMA5/Td/p+jfQxk4v7ef3mOKwqp
         zBdqrmZ8lrgQHYDrpnXIiFvqHzpSfGHk/lWB5RYI8rdvmP95PajeJ5CLiDPYRTijHxMW
         JleP3eilNyR37LwJAilHvopYVpVMAfMMX6eaEVuw2fN460rwS4ByKn5WIsgZgblBEJ/4
         +CzDKHpjUJh1jkV0bZ5r/0W6dRfZYnAsTqYRpfgNXxZMqS1XGaBYw8CtCkOuWSSy5Pdx
         VzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=br+deI8IeswQxDx71WP2p1uI7zhESszQB0HCABxe3MA=;
        b=rB6PWLdT+3G0BxuuD13netzXJANVkvrASsD3sp1aiAzcsgVxgqMvPsko+GQ0Tkbf8I
         BxMe0NqRIBQsqMaV21JjFrQrPsHhyb9NOR71EtDubErKZ7KhOSQmuOmdpJVbJf/9ybjk
         N2xQ4GkiueihnXNuNmnXSercwzOBCbdYK6fdPek1dLzxqK7WcMHXZzIyA8lMSSeEwLNR
         3EegaEu8uAK0E56MwaKu1Sk9ULkHeiw7WJKGMJlm/J1zMVQgkFvRczwg35aCAeTUU69V
         LcIQTkqOrKgn5MxWjf1TBqsA2OlccG5QClDcwQUcI4RU6zZI+9ZLhIogEw1JeEws77ai
         PZxQ==
X-Gm-Message-State: ALQs6tCjo4EIBtvVRa+Bv2uJMHBwCsJYl2Wdab9YhJT501E48mzKM6YE
        sqMNPfHQFVNw24SlnqBb//PtESqOSwQ=
X-Google-Smtp-Source: AB8JxZpK9sx5yuHsDuA86dMBXeShRKuNReBnvwKsHCKIRoHbGmgjq/KdQUok0K9HfZTDmYTvByttrA==
X-Received: by 2002:a17:902:7441:: with SMTP id e1-v6mr24701508plt.238.1525733983376;
        Mon, 07 May 2018 15:59:43 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id o10-v6sm39236171pgc.80.2018.05.07.15.59.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 15:59:42 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, jonathantanmy@google.com, gitster@pobox.com,
        jamill@microsoft.com, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 12/13] object: allow create_object to handle arbitrary repositories
Date:   Mon,  7 May 2018 15:59:15 -0700
Message-Id: <20180507225916.155236-13-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <20180507225916.155236-1-sbeller@google.com>
References: <20180501213403.14643-1-sbeller@google.com>
 <20180507225916.155236-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
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

