Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 312831F424
	for <e@80x24.org>; Thu, 10 May 2018 00:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935636AbeEJAkj (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 20:40:39 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38268 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935622AbeEJAkf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 20:40:35 -0400
Received: by mail-pg0-f68.google.com with SMTP id n9-v6so172843pgq.5
        for <git@vger.kernel.org>; Wed, 09 May 2018 17:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BJmIUCUbHoDCj2ebjvHQxvKwm7uUHvz9ibOMSfE4JZg=;
        b=gLntuLNFv6rYIuaoC0mBPBV47n5ba3Zk4AADFPE+7FJVC+9Y+jjSmSjdvvVyN+jxSP
         D7bD3fs5Y6om54mdn+Ijh+Q4Y5PZhj5WVUPadtC2+jRWJF9D3yTe60JQMes0UBmNDwmB
         jtUq623jZfr8CoTQyjdKe3UEqfP6XSZZEbPmI6+2+7x/04cvU3L5Om/6mL0mjtVGdW2l
         pYCwIkvt3MWF5Ehe+3uTxkyoqALpxgcxmDoAXJFpcmKCr8bHw0P5BhstekWRaZ4cyFxI
         gLGZUZa6jV7CIPDSCMrkcVYGJjVQHYfgfbdQw2IaHhs5MZjMHFwCUxuHsEB1fi6T3VB7
         kEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BJmIUCUbHoDCj2ebjvHQxvKwm7uUHvz9ibOMSfE4JZg=;
        b=JhLmvblHSjkhIlqW6XOoz2pgE9WI07AHiuZlK4wv4j1H5u2E+6FAO2aE9dVNOyMyf4
         rKpF1fS8hdJ+jviolItPXBYhnGIrE7TBtKCsyQoqxvSkNQ8kgLI2uWjnfu/YNFW/6xst
         Ft8V2ec9MucpPsAU0CdxUDvfxVvZYb3K9bI9Ft+QKHGDEaCJFTGLr7Dn590Dvn+NfxZ3
         7RCGecwAVIoNltbIVfznXgBZNr6Ajnm1Ot06IX9HPWvRig4P2aMJdJJWWwriV+Eu2UiO
         ed2JYjQQHL4m1Ct8SmkS6pxOoQJeChyobmHCfnsCa4rJzlUr+dFzz4E4eCukgS3aigsd
         dIbQ==
X-Gm-Message-State: ALQs6tDesSs/VG+Pac3U86YIS/sn6KCiyKpN8Q54XeQjb8D5sDI3IdLU
        J2he0lZOIERtUK7MKCA1MvehacOepz8=
X-Google-Smtp-Source: AB8JxZosT8xn6eP/L8/9n8lASw89DJWbM0DywNOEqF+wEjimMcOXeK0DSwhxxz/2LPwsfs9QS8zT7g==
X-Received: by 2002:a63:731c:: with SMTP id o28-v6mr37923729pgc.238.1525912834612;
        Wed, 09 May 2018 17:40:34 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id l14-v6sm5658210pgu.1.2018.05.09.17.40.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 May 2018 17:40:33 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jamill@microsoft.com,
        jonathantanmy@google.com, pclouds@gmail.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v4 03/13] object: add repository argument to grow_object_hash
Date:   Wed,  9 May 2018 17:40:14 -0700
Message-Id: <20180510004024.93974-4-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <20180510004024.93974-1-sbeller@google.com>
References: <20180508193736.14883-1-sbeller@google.com>
 <20180510004024.93974-1-sbeller@google.com>
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

