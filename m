Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E1211F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752240AbeBFAXU (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:23:20 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36376 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752154AbeBFAXS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:23:18 -0500
Received: by mail-pg0-f68.google.com with SMTP id x25so176181pge.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IUYeflNzTA3+j8fS+MNfe7+BSlpnZKFIsRu1IaxO7UU=;
        b=RXD+3/MnosyVcR0a1iaRLLHW8RKzNehfTiJy8uICMGth0dwTJ7fug0NgMCFqxR/w6/
         mla86l9xaZgXANyBkuU2J93UR/BErWltcUkNzhDnai1iqjvtB9EgMgMzebaF08xs04mv
         8FrtDFpGtIKQmwG1F/jKlCrzqd2J2XcTqqZfY7fqVgCJT9P5hycT3qQjlCuH+qg7qUOt
         HDQQT1OtRBKVLGPVT7n2udEEO+dPzoYLQNx0q1nVnnC19Qu8ulJjfvxbepdmfpGGkbFC
         IwkWsfDLeDd+YAuSFW9XlNjLKRUYkkvOvDfs6ctUrUsxpu3bnGfoAumYp1IjP9XDerzF
         UPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IUYeflNzTA3+j8fS+MNfe7+BSlpnZKFIsRu1IaxO7UU=;
        b=Yc+EDteRCv/WSY/KQuGWdCbEhb+Y4XgGANohahIomBJA/2B898aNKE6ZYCZwzXELdb
         x49u7MEJcSOcaGgsaXFdPgjILa1TBLq5MkV+5PMwGtG18r4BnFw8J9eQng6L/bGHufcK
         j3pIcyxBNop7HMHhstxyimud852rCPxIBtR7gLScP0+PHp52yn3fiCxQU4cDMSRPtM9d
         AEb82YpRDYUGcuADzYp+4iRI6ahNfkx0BreVNWxTD7ccWK8hdF+d3fdNwtJPhNi4nOnY
         euHlwW4M4ebin3scR0XUfhQzzbCk+7MZ2/F83DHe2iOcLsZU150/HuzaNkcPlQUF+/ru
         t+Ng==
X-Gm-Message-State: APf1xPAdls77eVr/zUKIHMrE86LJtL0FmXDxRl92GLmn/KgkTVhFXgd7
        gVnngJmWHjeprx3EOTJoFTcX2YcxCwI=
X-Google-Smtp-Source: AH8x226CknuEsyb0xDkHy55306TxhSyNO8C/Q3yRELhJ64WO9xJ56pPSaKAhOfimKG0InKEn4N1ZgQ==
X-Received: by 10.99.175.76 with SMTP id s12mr452404pgo.240.1517876597636;
        Mon, 05 Feb 2018 16:23:17 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id t25sm15104798pge.41.2018.02.05.16.23.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:23:15 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 133/194] alloc: add repository argument to alloc_object_node
Date:   Mon,  5 Feb 2018 16:16:48 -0800
Message-Id: <20180206001749.218943-35-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 alloc.c  | 2 +-
 cache.h  | 3 ++-
 object.c | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/alloc.c b/alloc.c
index 290250e359..f031ce422d 100644
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
index 36c01bdcf5..e0916d1a73 100644
--- a/cache.h
+++ b/cache.h
@@ -1583,7 +1583,8 @@ extern void *alloc_tree_node_the_repository(void);
 extern void *alloc_commit_node_the_repository(void);
 #define alloc_tag_node(r) alloc_tag_node_##r()
 extern void *alloc_tag_node_the_repository(void);
-extern void *alloc_object_node(void);
+#define alloc_object_node(r) alloc_object_node_##r()
+extern void *alloc_object_node_the_repository(void);
 extern void alloc_report(void);
 extern unsigned int alloc_commit_index(void);
 
diff --git a/object.c b/object.c
index 156fbae15e..cd73d41d87 100644
--- a/object.c
+++ b/object.c
@@ -180,7 +180,7 @@ struct object *lookup_unknown_object(struct repository *r,
 	struct object *obj = lookup_object(r, sha1);
 	if (!obj)
 		obj = create_object(r, sha1,
-				    alloc_object_node());
+				    alloc_object_node(the_repository));
 	return obj;
 }
 
-- 
2.15.1.433.g936d1b9894.dirty

