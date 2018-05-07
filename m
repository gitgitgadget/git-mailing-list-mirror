Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 504C0200B9
	for <e@80x24.org>; Mon,  7 May 2018 22:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753356AbeEGW7o (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 18:59:44 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33888 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752955AbeEGW7n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 18:59:43 -0400
Received: by mail-pf0-f196.google.com with SMTP id a14so23012948pfi.1
        for <git@vger.kernel.org>; Mon, 07 May 2018 15:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CSydtl831uOwHS0E5ezmDIYeNLAnKNPONhfkHwSpASY=;
        b=Y0hJjYj0+WGqmH4kkw/3TJOjL/WhMh0PM9afb5c+TE9W/kLATrfM7CeTPHEjoxxS6S
         MfyFNdQdim0bUyIFFZ9dcdK4DkuDHzEI/d9mc7ibmjPAabOuZ7X+n6E0X7/nhHtgnZLb
         ibzy3gmhpDQbUa0OyUTXrxVK4zNWcAl9QuClNRcjknHoBzrDVuUOQ1evvuZuhVXyY11Y
         g9E10mM0DQqMGhde+iWW8qLJiN/17SSuuRGECY09Ang7MzZcX8dpT8sVOSoN/2T4sq76
         DjVK12zUBbEOQZZZV8hzQ0WcZByFuLzlnXVS3CPCIXcgljLTMfd0fUHVk/RPMfbq7ZN/
         dWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CSydtl831uOwHS0E5ezmDIYeNLAnKNPONhfkHwSpASY=;
        b=r06cDji1lT0IiLY73tsR3kopQ0essshJLwTqAgojI1+vJoQp30bWMtyFwKF5ExZ40l
         HT5UxLg9GkDjCl3VUN4yOfLeGkbTC5VwRbY+O1+BxbBMvEOi8hj+TpcZKhNYb7+sKENX
         Dr7Xd+jlQPH7oEO43BaFinNLkiMbMuHE4k5UjT2E5p709iUewcD5qSq4JDk5CWC8UwDS
         Ui1q5YHufBq3SGAdA0gxIHFfKsf2R7orHefVX+UknFyTPyxXFFDGi8j4QLYyrVtM/5JK
         CQ/TDdwd67cCKBc/sM+2caGoF4sWPmZMnGa48RMF6Djdu36/d5iHH2Z2FuhMbna8ZrQ4
         vdKA==
X-Gm-Message-State: ALQs6tD0HMwMaI5KpTsIQ/iVmcCufIuYH2IaZbu2Nj8UbP0YuXW1iU33
        pOf4FNovNvTVUVgvNdyj1nXkfWIFHLk=
X-Google-Smtp-Source: AB8JxZoXObOE+0UeK+tzRLF6g8iFzVf9XKkjIF6fMo02pWRYef7gd1FGFGPqhsX0FloJ3EdPizfc8Q==
X-Received: by 2002:a65:4944:: with SMTP id q4-v6mr31495622pgs.424.1525733982009;
        Mon, 07 May 2018 15:59:42 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id y2-v6sm33530682pgp.92.2018.05.07.15.59.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 15:59:40 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, jonathantanmy@google.com, gitster@pobox.com,
        jamill@microsoft.com, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 11/13] object: allow grow_object_hash to handle arbitrary repositories
Date:   Mon,  7 May 2018 15:59:14 -0700
Message-Id: <20180507225916.155236-12-sbeller@google.com>
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
 object.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/object.c b/object.c
index a365a910859..0fcd6f6df42 100644
--- a/object.c
+++ b/object.c
@@ -116,27 +116,27 @@ struct object *lookup_object(const unsigned char *sha1)
  * power of 2 (but at least 32).  Copy the existing values to the new
  * hash map.
  */
-#define grow_object_hash(r) grow_object_hash_##r()
-static void grow_object_hash_the_repository(void)
+static void grow_object_hash(struct repository *r)
 {
 	int i;
 	/*
 	 * Note that this size must always be power-of-2 to match hash_obj
 	 * above.
 	 */
-	int new_hash_size = the_repository->parsed_objects->obj_hash_size < 32 ? 32 : 2 * the_repository->parsed_objects->obj_hash_size;
+	int new_hash_size = r->parsed_objects->obj_hash_size < 32 ? 32 : 2 * r->parsed_objects->obj_hash_size;
 	struct object **new_hash;
 
 	new_hash = xcalloc(new_hash_size, sizeof(struct object *));
-	for (i = 0; i < the_repository->parsed_objects->obj_hash_size; i++) {
-		struct object *obj = the_repository->parsed_objects->obj_hash[i];
+	for (i = 0; i < r->parsed_objects->obj_hash_size; i++) {
+		struct object *obj = r->parsed_objects->obj_hash[i];
+
 		if (!obj)
 			continue;
 		insert_obj_hash(obj, new_hash, new_hash_size);
 	}
-	free(the_repository->parsed_objects->obj_hash);
-	the_repository->parsed_objects->obj_hash = new_hash;
-	the_repository->parsed_objects->obj_hash_size = new_hash_size;
+	free(r->parsed_objects->obj_hash);
+	r->parsed_objects->obj_hash = new_hash;
+	r->parsed_objects->obj_hash_size = new_hash_size;
 }
 
 void *create_object_the_repository(const unsigned char *sha1, void *o)
-- 
2.17.0.255.g8bfb7c0704

