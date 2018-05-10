Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C82E71F424
	for <e@80x24.org>; Thu, 10 May 2018 00:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965908AbeEJAlL (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 20:41:11 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45798 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935632AbeEJAkh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 20:40:37 -0400
Received: by mail-pg0-f67.google.com with SMTP id w3-v6so164750pgv.12
        for <git@vger.kernel.org>; Wed, 09 May 2018 17:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X0M49anvLElxs1frAEBYUbXYyy/a9bLY76JJa6hARs8=;
        b=OOtPmsjuimz01fb7N2JcERpoBTNbpnpORg5ZtxDcVfMk2NEMNttmQlVj2bbyTTEMg5
         A9e4qOOyKRLXkNa5I10ANiF0Q6su4Poa85oKO3jumMdpK1BAR6QhrB8Mh1i4ulF3xgdz
         ZnErGT6YHiMeGUWKYNoRQTkR9cJcwR06cn/ftr/1oCaAnxCdJC2UQHqCd1SKu3u5Ls7F
         e+u/v2bU7QD7JwEHBPZXnN+Rev/51ALnG9ksLA+4YFnW6B3LDfCxURHY/d7zxCwqEAuH
         GFsItbVpdE2xUMqo/12hD0V/G/Ki303LVc1Ll53ZJEZjOeBTw3CmimCmS5q2z8fhGe9y
         rzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X0M49anvLElxs1frAEBYUbXYyy/a9bLY76JJa6hARs8=;
        b=MyoUpc3250k1NC9LWcIAwyeRQWd0tPw3w2pdSXB2ryLyfb4nT+uiR6Ziw72X0A44WN
         8naN6gS4dj0I6DHJdxFSB3HnCjj3Xh7rwAk5zSxBpyXsubvduudYn1ex3gM4T4EQ6VIC
         sXyJ1co4WEEBbpCKvsJ5CL5SWFPcEpHkRxTHnoUbeNq2F98k3h/z0+qUw4tB2WSoc7tA
         VZ57whwBK0UtYibG6Mq9vTicD1Z+FkvYPPA9nXxkDjIiOj9Iy3n7enwL4apCny4RyNk+
         QXXoMs/mf7KD+4o124Xsa44Xuu2GXY8jbd7liJnycyjHpdvO3SEhFPMugUrniJnVn8JU
         1mHQ==
X-Gm-Message-State: ALQs6tBD3YrWtfkD9aOq2+v46O+MvXtsj+g8Fe3HmgcCDEiLV1b3ZzdF
        zNv3sMuwrXT8c7vR0jmQXOwjbrEXP/w=
X-Google-Smtp-Source: AB8JxZooxLjCu8N0x/lvptrWMujsjse/fWusabm/Ru/dstAFzbp8P8PfBG5+lb/Y1Tot3v4gWrQhbg==
X-Received: by 2002:a63:6703:: with SMTP id b3-v6mr22483992pgc.176.1525912836006;
        Wed, 09 May 2018 17:40:36 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id v5sm23062042pff.130.2018.05.09.17.40.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 May 2018 17:40:35 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jamill@microsoft.com,
        jonathantanmy@google.com, pclouds@gmail.com
Subject: [PATCH v4 04/13] alloc: add repository argument to alloc_blob_node
Date:   Wed,  9 May 2018 17:40:15 -0700
Message-Id: <20180510004024.93974-5-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <20180510004024.93974-1-sbeller@google.com>
References: <20180508193736.14883-1-sbeller@google.com>
 <20180510004024.93974-1-sbeller@google.com>
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
 alloc.c | 2 +-
 blob.c  | 2 +-
 cache.h | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/alloc.c b/alloc.c
index 12afadfacdd..6c5c376a25a 100644
--- a/alloc.c
+++ b/alloc.c
@@ -49,7 +49,7 @@ static inline void *alloc_node(struct alloc_state *s, size_t node_size)
 }
 
 static struct alloc_state blob_state;
-void *alloc_blob_node(void)
+void *alloc_blob_node_the_repository(void)
 {
 	struct blob *b = alloc_node(&blob_state, sizeof(struct blob));
 	b->object.type = OBJ_BLOB;
diff --git a/blob.c b/blob.c
index 85c2143f299..9e64f301895 100644
--- a/blob.c
+++ b/blob.c
@@ -9,7 +9,7 @@ struct blob *lookup_blob(const struct object_id *oid)
 	struct object *obj = lookup_object(oid->hash);
 	if (!obj)
 		return create_object(the_repository, oid->hash,
-				     alloc_blob_node());
+				     alloc_blob_node(the_repository));
 	return object_as_type(obj, OBJ_BLOB, 0);
 }
 
diff --git a/cache.h b/cache.h
index 3a4d80e92bf..2258e611275 100644
--- a/cache.h
+++ b/cache.h
@@ -1764,7 +1764,8 @@ int decode_85(char *dst, const char *line, int linelen);
 void encode_85(char *buf, const unsigned char *data, int bytes);
 
 /* alloc.c */
-extern void *alloc_blob_node(void);
+#define alloc_blob_node(r) alloc_blob_node_##r()
+extern void *alloc_blob_node_the_repository(void);
 extern void *alloc_tree_node(void);
 extern void *alloc_commit_node(void);
 extern void *alloc_tag_node(void);
-- 
2.17.0.255.g8bfb7c0704

