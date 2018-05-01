Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81F071FADF
	for <e@80x24.org>; Tue,  1 May 2018 21:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbeEAVek (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 17:34:40 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33873 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbeEAVeU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 17:34:20 -0400
Received: by mail-pf0-f193.google.com with SMTP id a14so9986079pfi.1
        for <git@vger.kernel.org>; Tue, 01 May 2018 14:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cyO4I9dVXuPBTf8YkRPobCW+bqtVi+tiWSF+vAUHRsU=;
        b=SYHyuGti995bvZ8NBuN/JCKJFxRDwT9A0izCdar8M3B6ZwqUpCtSI6QFyu326FPPUm
         ybNEk+rJ7bV0VdjhQmQxAehxBJR1npNcVUSGfFZ0H5dTvHWH4SIVqc74iPS2KRL5mdIz
         tzmFSoOfSe7XBn31qrUMjLwvovWT22Kc9f0aeu7/irpTZhY9FcThPtEWluifS6r4WQvq
         NBg2OnBr88jBKWC2z9M1XPVr+uqjHwKbydIByxquu/fCTlHLcmdZ46shOhhWiJFnEhqL
         6HDWyYlQ2OxrdeqrgAm/5XdykgwwNlWJkgOf1PLbbkOtfCqMg3myDDbvn4mXtHRfe+iP
         AUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cyO4I9dVXuPBTf8YkRPobCW+bqtVi+tiWSF+vAUHRsU=;
        b=Yq322sJNbx62HT/wt0UYr+3J777FiphbB8jQkB1QtmfeJMbGmse+5Ch8+Gom2bE+83
         J29RLMw2gy0eo27iJkOfjTAcaiuVHnK8PdAXrmuhgYR0sDt7S8RjzpWLydVzISw2lEga
         9q+UyMJZfnFuvAYXueICOc3NIZ+lh2T/vZl49C7XhCDgdvKvw8vYmJU0uIiSswCu9GaP
         Lr+ShpCBIE4+oVtAsCrCoKMRz27FHRgG/AKbK/R0U5K3jvbs8Un2GAli++dwCyRmuhbM
         rSWq4XoioI66TY+xhfWfVNPPk9mWWlpoVTEJYHOiXdgM4IuCZXiqEG4oNDUGiAHmbXzT
         S7vA==
X-Gm-Message-State: ALQs6tCNh8OxMMvKmarr4UFDPQX6gsuEK5zKVM1qjDrJL97ZAxEi5rYV
        2ZcgwY9YFmUHX5A0aq9yHSkdnN2D/Wk=
X-Google-Smtp-Source: AB8JxZoys4VAPUIz1/IQw7LemZHnal6NzMnZGXqKnhLAT/T+RAmUlrUVvxdfU15SFbdKBceBHbhkDw==
X-Received: by 2002:a17:902:7e05:: with SMTP id b5-v6mr17348977plm.230.1525210459359;
        Tue, 01 May 2018 14:34:19 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id f18-v6sm3345700pgn.60.2018.05.01.14.34.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 14:34:18 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jamill@microsoft.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 08/13] alloc: add repository argument to alloc_object_node
Date:   Tue,  1 May 2018 14:33:58 -0700
Message-Id: <20180501213403.14643-9-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180501213403.14643-1-sbeller@google.com>
References: <20180501213403.14643-1-sbeller@google.com>
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
index a6202d11292..7d36323445b 100644
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
2.17.0.441.gb46fe60e1d-goog

