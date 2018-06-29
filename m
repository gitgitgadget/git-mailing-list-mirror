Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 333841F516
	for <e@80x24.org>; Fri, 29 Jun 2018 01:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936492AbeF2BXV (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 21:23:21 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:42312 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936475AbeF2BXP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 21:23:15 -0400
Received: by mail-it0-f74.google.com with SMTP id y23-v6so435731itc.7
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 18:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=+lfnNBslLW8cYpiWcAfXGEApdslsefwD5Gti7693JlY=;
        b=NHPlYVFORG5OcnDYmmWdhM3EbRBkwgk0srhZZc3X66llzOLxO0APs+he+dd/alsMo4
         8hQ/DnMM2A/m4HVF0kWbfOIrDEQK71PnBMSVxes7TeElfEtWKORPP1kGNg/cS/vycpAK
         6E5fV4/vBhaLwv4GyB3s0aHhRQGtdYjWu5CL6u0TLHW09HKCVh3Wh+dPf3W7c0WHteWG
         YDTu9UWgM/fbrop1/YsLCSSysFubfYwtlB/GSFRkIH4LrGA7oxeEOUCnSJYcSBBwyNoB
         O1GKQ2bjrZdKTMKB5O2uPydSILoM5Q58IM2fYjI55+PIla0E3+BzN5AcvUuHa+zwD0Y5
         YBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=+lfnNBslLW8cYpiWcAfXGEApdslsefwD5Gti7693JlY=;
        b=QFUmvVNz7Z+9d95V6ubWtysawcLocKJZWQCYHpFM10poNGREjLvCwb9sIJF53LvkZ6
         mS20tYlLlOnPLt2ipRJs7zCmveU5dJHKWr6bMx3a69UERRKq3THX1XMEFKyc+uXgfsSn
         aGFEL0PjSiZTxIqFBEKoaoxO7MloWK7grub7HFbbQP7rjampSzD0Y/JD/NOnuILCkNzC
         qljmqVM40yqKF2lgHjnQu0jMIlEMi2sRlWAStDSQLnH83u3F8xh84znYFft2AKKkZ0qr
         b2/na8aij6TfvaZzX7c6ydVcPOW/EAK85kjtjuqyJLFpq7mu8Mn6nkoKOsGuahRb50QL
         3gDw==
X-Gm-Message-State: APt69E1QnhxAd1KY42nO/ZJ6EkNhPXwKDM2oV3c8/y0HhC4yux1U4l4I
        T+5pdG/yJv9PITfJ3Aq0G9MTWFvZWKXWkeo4bLrdrGwXTifeehc4Wa5DUAd/d4Q33VTTMMH7o0g
        ScAafBHJ2bEnlQ3YlZgOYO4VrV/qbuBY4Z7youLBdCwKDsk68KQSqBxFvu6wM
X-Google-Smtp-Source: AAOMgpeXNWIg+bl1e1DvZRwX9NqDHmMhLjxEOgc3uGdBYx+iWlFdmwuCE/1v1aKgLRVzTpYMjyGdMdJADD7V
MIME-Version: 1.0
X-Received: by 2002:a24:2201:: with SMTP id o1-v6mr89270ito.12.1530235394279;
 Thu, 28 Jun 2018 18:23:14 -0700 (PDT)
Date:   Thu, 28 Jun 2018 18:22:08 -0700
In-Reply-To: <20180629012222.167426-1-sbeller@google.com>
Message-Id: <20180629012222.167426-19-sbeller@google.com>
References: <20180629012222.167426-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v3 18/32] blob: allow lookup_blob to handle arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 blob.c | 10 +++++-----
 blob.h |  3 +--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/blob.c b/blob.c
index 17b9314f0a0..342bdbb1bbe 100644
--- a/blob.c
+++ b/blob.c
@@ -5,13 +5,13 @@
 
 const char *blob_type = "blob";
 
-struct blob *lookup_blob_the_repository(const struct object_id *oid)
+struct blob *lookup_blob(struct repository *r, const struct object_id *oid)
 {
-	struct object *obj = lookup_object(the_repository, oid->hash);
+	struct object *obj = lookup_object(r, oid->hash);
 	if (!obj)
-		return create_object(the_repository, oid->hash,
-				     alloc_blob_node(the_repository));
-	return object_as_type(the_repository, obj, OBJ_BLOB, 0);
+		return create_object(r, oid->hash,
+				     alloc_blob_node(r));
+	return object_as_type(r, obj, OBJ_BLOB, 0);
 }
 
 int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size)
diff --git a/blob.h b/blob.h
index 08bc34487a0..16648720557 100644
--- a/blob.h
+++ b/blob.h
@@ -9,8 +9,7 @@ struct blob {
 	struct object object;
 };
 
-#define lookup_blob(r, o) lookup_blob_##r(o)
-struct blob *lookup_blob_the_repository(const struct object_id *oid);
+struct blob *lookup_blob(struct repository *r, const struct object_id *oid);
 
 int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size);
 
-- 
2.18.0.399.gad0ab374a1-goog

