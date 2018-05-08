Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27C68200B9
	for <e@80x24.org>; Tue,  8 May 2018 19:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755666AbeEHTiV (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 15:38:21 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:40544 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751664AbeEHThs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 15:37:48 -0400
Received: by mail-pg0-f67.google.com with SMTP id l2-v6so21590670pgc.7
        for <git@vger.kernel.org>; Tue, 08 May 2018 12:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BJmIUCUbHoDCj2ebjvHQxvKwm7uUHvz9ibOMSfE4JZg=;
        b=WuqyNJs0PMvLdkVgCMRj5wiG+P3m1ObwkIyzmdDjIoe0zI1xvXwHQ44m7EHyxJZNpC
         YsoPBMVrYCcumPFCbvdDRBX6KbKATHLBfHJDRrk6c8OYRRXgQGh3ISjVDcKam3ld3Ina
         BoK+JmE8sLq7SOgmjRIdPyU1o+HPA7WVH4ON5UPZTzyid47kOvlYAbhYp41x6Z6TR2dt
         sBN/5PvHfQOx35AoGNPYkAC9QAtJ9+ERlhYxt7FF8I4zDmTSv+ELtIRa6FzWSRfO1LLc
         8t3GgRHz0u+4iHY8exjjOeWWrf6pgfh5v0eGeFdARAb+5jQknb4O+0I+7MiHqVbjc02t
         fX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BJmIUCUbHoDCj2ebjvHQxvKwm7uUHvz9ibOMSfE4JZg=;
        b=D6qOlYrDFL9Hli9+MM+lbfSPNPaEG9UHsYJQj7fPZ6+v0ePIMCKOqxBgpAbacjlT10
         Qq6po4SQ3SrS2SCZpcMXTJqDHED2u5gOL/dPu788nbNrHvSYg/TgvXg38SvxzEvs7bUj
         w0aBk4k1ZSnMuF9d3IJgSW2CUaPAFMkHLR9wibnDWNDRW1/KJPoUi+s7KejgIRtWxOfs
         G65xGS/NzQmq4fy+CygdJvYCwjTk0TfK5XUYVCW3xM9GC2v8m7Cx4pmg7mByjegbtOGh
         EZajesBtLoVU0qwWPfKPKZChHCf7aUHHG6effKImF4nYHnSy6qHHhpl8ehYI6WgifWIW
         HEPw==
X-Gm-Message-State: ALQs6tArwB4jdanYnHCF3v1LMSP+1wu1FAmpN8dImmsYpF/a37tlutIg
        2U+vKQI+ZxlA2E1uJgmpdo/Idg==
X-Google-Smtp-Source: AB8JxZprhaZp2+0jDJxPNIH0HrZ5L1ByDF+MNgmkR5ptk619uiFwmqPbWc6YY7EuEoGD0K9J0pIQog==
X-Received: by 10.98.233.3 with SMTP id j3mr9128124pfh.196.1525808267426;
        Tue, 08 May 2018 12:37:47 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id w1-v6sm9690084pgp.3.2018.05.08.12.37.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 May 2018 12:37:46 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jamill@microsoft.com,
        jonathantanmy@google.com, pclouds@gmail.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3 03/13] object: add repository argument to grow_object_hash
Date:   Tue,  8 May 2018 12:37:26 -0700
Message-Id: <20180508193736.14883-4-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <20180508193736.14883-1-sbeller@google.com>
References: <20180507225916.155236-1-sbeller@google.com>
 <20180508193736.14883-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Add a repository argument to allow the caller of grow_object_hash to
be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 object.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/object.c b/object.c
index 2de029275bc..91edc30770c 100644
--- a/object.c
+++ b/object.c
@@ -116,7 +116,8 @@ struct object *lookup_object(const unsigned char *sha1)
  * power of 2 (but at least 32).  Copy the existing values to the new
  * hash map.
  */
-static void grow_object_hash(void)
+#define grow_object_hash(r) grow_object_hash_##r()
+static void grow_object_hash_the_repository(void)
 {
 	int i;
 	/*
@@ -147,7 +148,7 @@ void *create_object_the_repository(const unsigned char *sha1, void *o)
 	hashcpy(obj->oid.hash, sha1);
 
 	if (the_repository->parsed_objects->obj_hash_size - 1 <= the_repository->parsed_objects->nr_objs * 2)
-		grow_object_hash();
+		grow_object_hash(the_repository);
 
 	insert_obj_hash(obj, the_repository->parsed_objects->obj_hash,
 			the_repository->parsed_objects->obj_hash_size);
-- 
2.17.0.255.g8bfb7c0704

