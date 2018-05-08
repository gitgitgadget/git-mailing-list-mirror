Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF2DD200B9
	for <e@80x24.org>; Tue,  8 May 2018 19:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755619AbeEHTiG (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 15:38:06 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42196 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755519AbeEHTiA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 15:38:00 -0400
Received: by mail-pl0-f66.google.com with SMTP id u6-v6so2813678pls.9
        for <git@vger.kernel.org>; Tue, 08 May 2018 12:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xt2RiNt7NNp/+rxj7QjlgFmdXlTi6jL8c+2/wvuifXY=;
        b=PnUiUmCVWuqIDDWtQLXPeVpq9zQOBJisC/EBj8CUUENQib1Jln0XDOGMSPq9LSVz6a
         3ykXrXOwAWdBIMfQTeF04E8y39wZScrTH75GKQgf9l/Hz5TXrJR6h2cSxRu4iywb5gJ3
         qZXS092yL5VYmvzzf8YltUH4k1ZXrhV63xbRy9VvkPasSArtBT/8xjlnPKz4gfcy9ZK0
         6NQ+U80WL7nUc/9wMC5x8k8GhhLP6W8N0Sy8XDXLX6FUELQobpJdgQvte10Tm3+ukLvz
         b2Y/j3gl76h9VIkRydTpLFSDBoMvTzYJUjlbctD3sG60GEaRas2YBHv8JME1XoQIDbMO
         GE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xt2RiNt7NNp/+rxj7QjlgFmdXlTi6jL8c+2/wvuifXY=;
        b=HUdLT+ctHitUKkiZW5GeMNXI9DwjTmDBGb1yZymnF3QaEMP2XA5XplwN8o5OWtW/Cj
         99d0tby1S7Z4dahe+YR8THJBtWNGPA4ROH/klHpCzq/xR2mPCb4uT280uqXKC5IIO+Os
         apxOWwPeDjPPbYw1a+/xBoPxq9baROGDzql/88xkhbp1GbEsz13PJXVMVEfS1F2ZcTiZ
         nL8HaB9XLsUa0tQI9ibFLYUiKVlJTdjr4heI0qemEamY2p1c+qo6WWzXAFKbhiN3LpDS
         mTwYFue6kj05mNBNLaFdfq9HnEn8MPlHKMh9zL0G4v2XKM4/hcVzDYR9aCDIjl97VGxM
         ZpTQ==
X-Gm-Message-State: ALQs6tCgdTX6ZV9IN2tmIOB6CJYeKDYIeF0fkfF5Kr1sAeCF34+6Fy3f
        +E2Ml9ABcZsQ22+v6SZ2qPcXGA==
X-Google-Smtp-Source: AB8JxZr1sK4HONq6ATZap5dh+y4SbvXKqNXp+KI4js0joWn/ymL7mTg3UIMSblyOnvOTyodOF7vgmA==
X-Received: by 2002:a17:902:aa95:: with SMTP id d21-v6mr41271956plr.73.1525808279440;
        Tue, 08 May 2018 12:37:59 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id r80sm53069843pfe.44.2018.05.08.12.37.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 May 2018 12:37:58 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jamill@microsoft.com,
        jonathantanmy@google.com, pclouds@gmail.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3 11/13] object: allow grow_object_hash to handle arbitrary repositories
Date:   Tue,  8 May 2018 12:37:34 -0700
Message-Id: <20180508193736.14883-12-sbeller@google.com>
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

