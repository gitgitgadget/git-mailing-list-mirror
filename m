Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 351D11F424
	for <e@80x24.org>; Thu, 10 May 2018 00:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965766AbeEJAku (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 20:40:50 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:32978 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965469AbeEJAkr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 20:40:47 -0400
Received: by mail-pl0-f68.google.com with SMTP id n10-v6so247540plp.0
        for <git@vger.kernel.org>; Wed, 09 May 2018 17:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xt2RiNt7NNp/+rxj7QjlgFmdXlTi6jL8c+2/wvuifXY=;
        b=EsgMoB9hPyg4UMYCps722g/SW1e6r3RyW7dHXq6YxUaBA13+w6A/ZpxtBPMh+7UaP7
         HrAw1RA3kwaZj+vfZE/+dysPbnVyf2YvehucwtGYIGGQxh1kfp1hTXVE3ofvXzJMKmof
         XQnEL50J3LcxWY/buG07UoTaWLPnxt8U+ywOcF/JQ54oEQPz1AUpplouKNALgr4cbD9O
         k2Ie6kj23wN2W5HfVA1w8mrhIFeubIHB3Qn+ebDUvnG+/vwdFecX4bvizHkeeLklb0BT
         9j/dES3/4tQtrtOA7aPbryKX4mvbRbdjaA7m7rAQDueEx/LDsd2X4KB5ofkFlvEvZyMU
         Ds8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xt2RiNt7NNp/+rxj7QjlgFmdXlTi6jL8c+2/wvuifXY=;
        b=BVasC8As88NIpdjwDxITf4+EzxnV8q2a22xiIfIdhsMsx/2wWRTeYO2IAJn1abe9a/
         ieUMUOxMWpuadx3TUzdRKGiYwZC2a3rJn4JueiJh4tIW9LiF8PjpiM+CBJdYd0p+0x3F
         Q5rM5G4aX5xTuWAyUFH62AOAMb0LaD3xOo3KUk43j6SJpKnNXWpI3ome3iWdEiRtNL1Z
         KReBhLJk9BoZZQkXYG6dw0A6KlzQHZymfAzW45tEWcGTfcmT87/kk0LK9E83KA7l3HmJ
         xwwpLm3bf9J6XxPpjhOHxrm99mJl09r4Y7mOSha/3YPmEs2npOXlpN4Rtjr2kx9q8WGc
         L37w==
X-Gm-Message-State: ALQs6tAh6fSPPlaWTLyL2nHL0NkYLFiVkgr6IGQiHrdVMv4h+abGiXi9
        U8pHYjm8olxwEWO+SCFLjy94jQ==
X-Google-Smtp-Source: AB8JxZrLm699qed7rBHnG4Wka9nJ5obPNUeZBjiHeMb0JlqdJpg2KxjmlK8bH4cpsVFddRQqyvcx1A==
X-Received: by 2002:a17:902:76c1:: with SMTP id j1-v6mr46950526plt.284.1525912846798;
        Wed, 09 May 2018 17:40:46 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id x84sm77269924pfi.160.2018.05.09.17.40.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 May 2018 17:40:45 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jamill@microsoft.com,
        jonathantanmy@google.com, pclouds@gmail.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v4 11/13] object: allow grow_object_hash to handle arbitrary repositories
Date:   Wed,  9 May 2018 17:40:22 -0700
Message-Id: <20180510004024.93974-12-sbeller@google.com>
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

