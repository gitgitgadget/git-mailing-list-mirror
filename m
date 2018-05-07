Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AF64200B9
	for <e@80x24.org>; Mon,  7 May 2018 22:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752990AbeEGW7d (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 18:59:33 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34875 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752719AbeEGW7a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 18:59:30 -0400
Received: by mail-pf0-f193.google.com with SMTP id x9so3837443pfm.2
        for <git@vger.kernel.org>; Mon, 07 May 2018 15:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LUe1gsrqgCnip6055xYmt5HOf19Iyl5GWO7pLhm4H18=;
        b=EOq4p3H9caQtOzOO+VPL0/H9xKmqtVu93FdgS2xPPKFTGxShpWS686A/xcb8mD9BN+
         kVe98WJzuG8kK613/FZtpaggEpsYVseqMpgiZG+gHQSxNjqIlFdND+Gbz6PSttUZBa0F
         8xCUgQGoOc0A98O3ThW5M/qRWbucgNJnQT+OFn4hgRTj1xAY+gBUCjMzH9JR+7PjqIF2
         yjwe7IDzW81v7F0gkKiK3LUvrfDwxQ7UgLHclV7WV7EyCxJ04cOP9qdEFDUkAa4Tnha2
         mM+5GcFUMrat4oYHoyLtfY3AGsiL2w0yNYpwk7vWRuBSRghQarD3PCe6vTlEM9hdslIw
         u8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LUe1gsrqgCnip6055xYmt5HOf19Iyl5GWO7pLhm4H18=;
        b=QEaD57ADr7z2+em69PwvHD79OW3yyybQCHOZweCcecSWqeuH8pUQyeM/h1iZbAnkQJ
         5QEEtT5bvuFHEJEnydpWd2azd6CgIFCYiaLKNVEJVm4i5+hOQZkltvZF59AJyHSdJPDs
         86vfu+/iSsH0jLA5YxUowRJrdBAUKUULdP3JSNkqivIw3RbdyuMid/r5EKjv6VGrfiSn
         YAFRZngjaBkY1IQXriZyc0/JWeh6ruZqit7WiiJ7ZkINWP7XHgB4sTjciKGIOG3SZkyY
         Jr2d40+BuI3qyccCiuLZz14AE+IS2FCoElCz1de2rAwRcFfBLrb2ownCjS0/3K53/hqH
         oRlg==
X-Gm-Message-State: ALQs6tCAJP31tYpLuHHXPWoSfb0Zier/uHWh/8Q9ZjqsD5mjlgPk2Lun
        mO/C2v9RkF/LvKOz9wQNa6PJXrEzRY4=
X-Google-Smtp-Source: AB8JxZpePu8nfnwXoN4nPuiwZSFgqVY9xSLtA5gbzZ+BCXmsCFdEWhv2URQnTCzAsgqHLAQ/ynllMg==
X-Received: by 2002:a65:5088:: with SMTP id r8-v6mr25655651pgp.80.1525733968941;
        Mon, 07 May 2018 15:59:28 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id 23sm83568348pfs.147.2018.05.07.15.59.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 15:59:28 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, jonathantanmy@google.com, gitster@pobox.com,
        jamill@microsoft.com, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 03/13] object: add repository argument to grow_object_hash
Date:   Mon,  7 May 2018 15:59:06 -0700
Message-Id: <20180507225916.155236-4-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <20180507225916.155236-1-sbeller@google.com>
References: <20180501213403.14643-1-sbeller@google.com>
 <20180507225916.155236-1-sbeller@google.com>
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

