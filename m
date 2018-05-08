Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C6992023D
	for <e@80x24.org>; Tue,  8 May 2018 19:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755642AbeEHTiN (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 15:38:13 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39929 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755537AbeEHThz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 15:37:55 -0400
Received: by mail-pl0-f67.google.com with SMTP id c19-v6so6062pls.6
        for <git@vger.kernel.org>; Tue, 08 May 2018 12:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kuJG+7BR482bR6X+M37w/TU1jfvmm+kifwazfRmPZ7I=;
        b=aZP3ImNoxDsPPW7hP4HQaTP1A4WDr2Y+JqCQ9WnlW3sS14kNIEFt/HSUxZueKzK9r7
         YbpCaAwYfme/53+jzRZf3Kr1K/2LaYVGjxvT3PMex6cxSJU0zTihAQc3Wl0Q6P60ifpN
         V1fiBlTUEOe7tIKmhFjTuyaermtJ+EyoH1HxrsON6bkXTu2CWLTjIbrozWcBmEUjv54U
         n9QZ01fSZYxcHPUdnupAHg/Couiye31e3MjTvfGXcAd37oUeP9oO8Sxi/OcQLpNKOlsP
         /l3XZJQsi2pPhVjQiP3zd4shO/wtjQak87UKDMduV04LDtBZyF36nSeEjWpIo/BkYoad
         TD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kuJG+7BR482bR6X+M37w/TU1jfvmm+kifwazfRmPZ7I=;
        b=o7iga/lc0qrXx9bU06CH2kNYkYxLTS8wDuf/PrgQ+1l54PEOqiwrJLaBy5XmBUHq66
         UN4gmUCh5zzefWNjups5dUtAgTKIx7CsmapbUgnPG8yY9VN7QEjtPfNiQMmruk2IcK7/
         42qCatJnXYWkxSNGFDXYbQFC0gbNW36/orjRbXtjB3IM0vxkALzMJPZSYdXr2X0FU30E
         /PulD7HJWMJqs0eoIlufrhLIyUIDp85+rZKsoHpkkFc3V87RhoiulrQ5Rrs3CgaH+n9N
         Rghdw78no3lkQdv/Wqi7odXIzS7MGEnwZHToekir6M5QrZrJB5i/VLfCxyCKAEvBdl8D
         /n7w==
X-Gm-Message-State: ALQs6tBZCTUbm04Jx9i49EGr3JUN97AoYZtEmDnmgnb4xzl14tryrKy+
        Zj5J9hC+727HvTARcXVCjW9KAQ==
X-Google-Smtp-Source: AB8JxZrC8BuesQA3bHIWgEfHfWYaevX/OdwLozmr2c/PUBGlPXm5htg4N8ROoFzS+ozyUFJv+uCtAA==
X-Received: by 2002:a17:902:42e:: with SMTP id 43-v6mr21030808ple.365.1525808274782;
        Tue, 08 May 2018 12:37:54 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id y29sm55321782pff.42.2018.05.08.12.37.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 May 2018 12:37:54 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jamill@microsoft.com,
        jonathantanmy@google.com, pclouds@gmail.com
Subject: [PATCH v3 08/13] alloc: add repository argument to alloc_object_node
Date:   Tue,  8 May 2018 12:37:31 -0700
Message-Id: <20180508193736.14883-9-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <20180508193736.14883-1-sbeller@google.com>
References: <20180507225916.155236-1-sbeller@google.com>
 <20180508193736.14883-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a small mechanical change; it doesn't change the
implementation to handle repositories other than the_repository yet.
Use a macro to catch callers passing a repository other than
the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 alloc.c  | 2 +-
 cache.h  | 3 ++-
 object.c | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/alloc.c b/alloc.c
index 290250e3595..f031ce422d9 100644
--- a/alloc.c
+++ b/alloc.c
@@ -73,7 +73,7 @@ void *alloc_tag_node_the_repository(void)
 }
 
 static struct alloc_state object_state;
-void *alloc_object_node(void)
+void *alloc_object_node_the_repository(void)
 {
 	struct object *obj = alloc_node(&object_state, sizeof(union any_object));
 	obj->type = OBJ_NONE;
diff --git a/cache.h b/cache.h
index 32f340cde59..2d60359a964 100644
--- a/cache.h
+++ b/cache.h
@@ -1772,7 +1772,8 @@ extern void *alloc_tree_node_the_repository(void);
 extern void *alloc_commit_node_the_repository(void);
 #define alloc_tag_node(r) alloc_tag_node_##r()
 extern void *alloc_tag_node_the_repository(void);
-extern void *alloc_object_node(void);
+#define alloc_object_node(r) alloc_object_node_##r()
+extern void *alloc_object_node_the_repository(void);
 extern void alloc_report(void);
 extern unsigned int alloc_commit_index(void);
 
diff --git a/object.c b/object.c
index 91edc30770c..b8c3f923c51 100644
--- a/object.c
+++ b/object.c
@@ -180,7 +180,7 @@ struct object *lookup_unknown_object(const unsigned char *sha1)
 	struct object *obj = lookup_object(sha1);
 	if (!obj)
 		obj = create_object(the_repository, sha1,
-				    alloc_object_node());
+				    alloc_object_node(the_repository));
 	return obj;
 }
 
-- 
2.17.0.255.g8bfb7c0704

