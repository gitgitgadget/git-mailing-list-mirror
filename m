Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15C2D1F424
	for <e@80x24.org>; Thu, 10 May 2018 00:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965676AbeEJAkr (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 20:40:47 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43785 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965294AbeEJAkp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 20:40:45 -0400
Received: by mail-pf0-f196.google.com with SMTP id j20-v6so189616pff.10
        for <git@vger.kernel.org>; Wed, 09 May 2018 17:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DEZRBf+4IE9HgY/+3dJDZU+/urBnXc3UttOKsEC1bOo=;
        b=vwazmJ9ovDtMynoB7LdQipsflN1zxRO/Wu1dycIEfprxyYBy/t6KcKG3iBThs5Y1P2
         udOLTbkyOD6zT6Sp6x95Vcvz3NOk8TcRBqIrqQiqcRMoGWnEXe/hIpuHkg8AW3R49mm9
         2Br93JUq9mU+bOibnxhYu3v9BUpWofeuctNCEhT8WliQac1USXZ25zCiJtGRmV/lgo45
         yuNvYYoEcVLhkTvwXHuI2dQKjAUx+wnXqY4JDP9A1q25vjnreWfOwxlj/dd4kQU6DXPP
         07CT2oxMmHbFUB5AUitJVwONr1cLSSN9R/PyUvSIHvhEClYLadxk0ddwBufbEsajNeFt
         8owQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DEZRBf+4IE9HgY/+3dJDZU+/urBnXc3UttOKsEC1bOo=;
        b=cQG0SeVFqXLNqPJ1I52/uQzDiIaC6TkNjRl5VtzlesrC2KdCFvwJH0JUinQDhWd5H4
         Nf8wZHUXQ8Y/6BvJP1kJjj/aqTWPP0cwnhN1KR+dN3x8uTkjAAzt7blphMNYsMGft9Tg
         29tiuVBJt/m+SdBz2Rz4BjOK6pcSEf684kDhZUjPriAG5N098d6PrG8V80wJ+SQUBdnn
         CHCdDg2Jt8x775/3l1zq7sHsNF8sBHpd5sU5vavK9DSFCdf0Zhh0ngVryOe6n244JqhR
         7lxjQn1Pm0dA8YdrNpLzcaVYlYd0+6secTXMO7ZhDc/L+5/R/WMu03h+Hd/sVpNTfe6r
         lAmQ==
X-Gm-Message-State: ALQs6tAcNI3IW3KWU3Eku/C4ipgZ3A+XwTv6IieJxntRegxdOg1FH6Q1
        0NRijN0VTn+ycA0vIFw/WuJNPA==
X-Google-Smtp-Source: AB8JxZo61HToEaojBf8lw+y4Q8l4t3GKljDm6O8RVvmSOga6ft8d1qkizt4d//xP/17xZ/XZd0xSEg==
X-Received: by 2002:a63:79ce:: with SMTP id u197-v6mr37986317pgc.242.1525912844997;
        Wed, 09 May 2018 17:40:44 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id j74sm60253028pfk.25.2018.05.09.17.40.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 May 2018 17:40:44 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jamill@microsoft.com,
        jonathantanmy@google.com, pclouds@gmail.com
Subject: [PATCH v4 10/13] alloc: add repository argument to alloc_commit_index
Date:   Wed,  9 May 2018 17:40:21 -0700
Message-Id: <20180510004024.93974-11-sbeller@google.com>
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

