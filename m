Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96B1A200B9
	for <e@80x24.org>; Mon,  7 May 2018 22:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753334AbeEGW7n (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 18:59:43 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37647 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753255AbeEGW7k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 18:59:40 -0400
Received: by mail-pf0-f195.google.com with SMTP id e9so18996805pfi.4
        for <git@vger.kernel.org>; Mon, 07 May 2018 15:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YWDxcJaeKBkeb/AyZV7mPUicW8BgqKxTDvCvcrHB+/0=;
        b=sukovx7tYYP/dNa4rdF+6d/VsQX/4vNrJA4qoduUmbHEHK791lSqIAtRm9TwnjD59F
         brmTMTR0qh89DqEUMDR0oy6EJEXuObknmpT8c+zVRN+3rp6oVb79IWk5f6U2jBSGF3Ph
         wvH9QIA1zMOVfUWIsOTbUKw9/KBCpOq6L4HrX8pjzi7NiYv8bTstvhFYR5aRnKkdn+2b
         E/r1t9V867T4R+pHdaHB/wK0gCoV4MjVmV4tI59FOJul1nsSKKcR22x2Jm/aTk9m3bVZ
         lyazLhlUuiv4NIUi6UAM2ORYyXnA/gNzvSDKbrAP4W9d8PZwyDw3x1gF0/mQy69fGGG6
         +AWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YWDxcJaeKBkeb/AyZV7mPUicW8BgqKxTDvCvcrHB+/0=;
        b=CenkI2uyPrlaFFXLfywjxvBLxk2OCLxXknD0UUKxGZfAwWxQjcRRAv3cHHOUN8ln2K
         RWQMqdsuIzEURq8diAkl8IfRJ3XrIFPc/46rTklau9wxrAJRTtsMm4pDDWz6AGtGAQ0p
         W4rN9g8WYQALsAMVRcQuDeYnH3eGIxoVu8HY2A0l2k7XA6N39Kj6knDuvXeNkH+lbZdx
         m3V/y47tIID0D1boo5+HaQRID6spk4b67iSZBKGSajwiZOYdrmYtQPfpaXNhTnKf4RMZ
         F6LVfvSdy4H0o5lxwjAnK1R4gwEd1Wb0Ci5u9FRlcoYUdLLHmiF94FkOvgZ+ea4qNNOe
         qfKQ==
X-Gm-Message-State: ALQs6tBXhEC4+ywytizG1bJBnNpoTTqgvU4yDu9gXg79QZ3qtd4gMaE8
        BxQcGp8Only4LJ0XGx9ouF+iNVl9lfI=
X-Google-Smtp-Source: AB8JxZrGlt6zWT/TvOVoLrW63QYvjhNFj1ns7rv17H6jAOMRXhTlNXt01RUyZGkZRgEDIrr2qbVYIQ==
X-Received: by 2002:a63:7114:: with SMTP id m20-v6mr30978280pgc.144.1525733979829;
        Mon, 07 May 2018 15:59:39 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id i2-v6sm35237484pgo.57.2018.05.07.15.59.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 15:59:38 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, jonathantanmy@google.com, gitster@pobox.com,
        jamill@microsoft.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 10/13] alloc: add repository argument to alloc_commit_index
Date:   Mon,  7 May 2018 15:59:13 -0700
Message-Id: <20180507225916.155236-11-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <20180507225916.155236-1-sbeller@google.com>
References: <20180501213403.14643-1-sbeller@google.com>
 <20180507225916.155236-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a small mechanical change; it doesn't change the
implementation to handle repositories other than the_repository yet.
Use a macro to catch callers passing a repository other than
the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 alloc.c  | 4 ++--
 cache.h  | 3 ++-
 object.c | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/alloc.c b/alloc.c
index 28b85b22144..277dadd221b 100644
--- a/alloc.c
+++ b/alloc.c
@@ -82,7 +82,7 @@ void *alloc_object_node_the_repository(void)
 
 static struct alloc_state commit_state;
 
-unsigned int alloc_commit_index(void)
+unsigned int alloc_commit_index_the_repository(void)
 {
 	static unsigned int count;
 	return count++;
@@ -92,7 +92,7 @@ void *alloc_commit_node_the_repository(void)
 {
 	struct commit *c = alloc_node(&commit_state, sizeof(struct commit));
 	c->object.type = OBJ_COMMIT;
-	c->index = alloc_commit_index();
+	c->index = alloc_commit_index(the_repository);
 	return c;
 }
 
diff --git a/cache.h b/cache.h
index 01cc207d218..0e6c5dd5639 100644
--- a/cache.h
+++ b/cache.h
@@ -1776,7 +1776,8 @@ extern void *alloc_tag_node_the_repository(void);
 extern void *alloc_object_node_the_repository(void);
 #define alloc_report(r) alloc_report_##r()
 extern void alloc_report_the_repository(void);
-extern unsigned int alloc_commit_index(void);
+#define alloc_commit_index(r) alloc_commit_index_##r()
+extern unsigned int alloc_commit_index_the_repository(void);
 
 /* pkt-line.c */
 void packet_trace_identity(const char *prog);
diff --git a/object.c b/object.c
index b8c3f923c51..a365a910859 100644
--- a/object.c
+++ b/object.c
@@ -162,7 +162,7 @@ void *object_as_type(struct object *obj, enum object_type type, int quiet)
 		return obj;
 	else if (obj->type == OBJ_NONE) {
 		if (type == OBJ_COMMIT)
-			((struct commit *)obj)->index = alloc_commit_index();
+			((struct commit *)obj)->index = alloc_commit_index(the_repository);
 		obj->type = type;
 		return obj;
 	}
-- 
2.17.0.255.g8bfb7c0704

