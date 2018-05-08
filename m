Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE3B3200B9
	for <e@80x24.org>; Tue,  8 May 2018 19:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755596AbeEHTiB (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 15:38:01 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45589 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755567AbeEHTh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 15:37:58 -0400
Received: by mail-pl0-f68.google.com with SMTP id bi12-v6so2813416plb.12
        for <git@vger.kernel.org>; Tue, 08 May 2018 12:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DEZRBf+4IE9HgY/+3dJDZU+/urBnXc3UttOKsEC1bOo=;
        b=GIfKOL/vmoQHUsXcKk6CPzzQK4rhKZFsVQbZC7nunXrzQF+4ncD9vSeTC/GF/hRtDr
         bMQKnwKSOPGdwk6hF43U7zCio+JTkS3QfPFV30HC+GmBSWWUGW1SnMzq7Kb8xsXvgeOg
         Sj7+SJ74MoKc/6A3+BHR1kUJ5WTUe8Ty8FWvS621dJChw3exi2uz1rYtw5fesNKI/wj9
         1Xi0RaJEx3eHtv2E6n3C+b/rnNfZsX4hiFR5B1ORX9wvmfaUWJSBoyz2e1ri5/jb/i0F
         V958kYnPn4EHCeoeinDRiRWDIssrWYILJbBjhjACwftdeNRq88Hpzv/TtQG7Pyek2eTw
         GTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DEZRBf+4IE9HgY/+3dJDZU+/urBnXc3UttOKsEC1bOo=;
        b=Kg/0/NIRmw6zWiR6ou0jES+6hFCx0MC9vlBCBIouoooad92rZBXi5UX9BtjJdO7/dN
         GpXzWJkYzaebnbuZ0QmSDJYUeYXeHrwSkZOsr+R8hAFNaJesiIIT7bMObb5wr9PGDBZH
         6Sis7JHeTuxjQpqYjrEhqCKwWzUeTd/w6PZyPQ5dOjoW9mAX8tAxLMMRW1ZPbq1oLWKX
         0Efvv4dbMdxuSoD1VRN7X1NnN5CuUvEkVDLuw+1nVaGjmzZntzBlq8ul6xr4PodrLNr6
         SIBnXTx7G2VyseZmGFh4PNy/jTPuXYf0OFSK5lI4UwVSImyLKvJ1/ZXa2o8do7iRl7+q
         OUNg==
X-Gm-Message-State: ALQs6tBdDdwaXTZPYvNY2BH6Q51FNz11kCEvHFUQDNOMUVpHI1R1tjBH
        1uw+0xJIGsPGg4CnnagnCDJsoA==
X-Google-Smtp-Source: AB8JxZp7XGHKlaGZi9IhnT7OxfChocDQXZr98WNhTuuJaN8Zl5kqExtmRWcn/o8yYZGeTSel0E84qw==
X-Received: by 2002:a17:902:bc4a:: with SMTP id t10-v6mr42803384plz.343.1525808278081;
        Tue, 08 May 2018 12:37:58 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id l8sm45198674pff.126.2018.05.08.12.37.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 May 2018 12:37:57 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jamill@microsoft.com,
        jonathantanmy@google.com, pclouds@gmail.com
Subject: [PATCH v3 10/13] alloc: add repository argument to alloc_commit_index
Date:   Tue,  8 May 2018 12:37:33 -0700
Message-Id: <20180508193736.14883-11-sbeller@google.com>
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

