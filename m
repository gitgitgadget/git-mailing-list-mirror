Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 584E51F424
	for <e@80x24.org>; Thu, 10 May 2018 00:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935642AbeEJAkm (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 20:40:42 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45579 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935622AbeEJAkk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 20:40:40 -0400
Received: by mail-pl0-f67.google.com with SMTP id bi12-v6so233157plb.12
        for <git@vger.kernel.org>; Wed, 09 May 2018 17:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YTbMo0eKHm1n72trBEb3LlfxuboPfMfUdsl+tEWGBF4=;
        b=nxqCE2/aR0UDwhTi8YDZT/2mZVq80EBqQ1Gj+BnWmWpwMCK0Hs3pQGkosxM0nbD/Yp
         1qqp/vzIgcUw5oHCFgRH25vpDjUgzxD2i/3e0namJTWvtVmWDFEe+ALlWfsbk6x9+cra
         P+y8nt1rK9F3sM0Fyd/SGgREIjRP7DeXiRHYa7DhaFHSzk1CPpEB7MtUOeED9yzJOuae
         R/YVfph8k8vAvCpnZVmoRI0eJN4TVcNdKpILZgVEhpK8UwnWyPG1AWv9ajQUUyr0yg2E
         Ct+nBZ43qSYZrinDOd6hmzFSo6seTExJuIP5x17vQutF8ersDQngKUYCLERKHvXI0kAN
         ybOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YTbMo0eKHm1n72trBEb3LlfxuboPfMfUdsl+tEWGBF4=;
        b=IHo+kwXVwWWQTXTdrRRc9xjQf3tnpmCIe1N51wKUCd1jZ/7MtbAVQdHi3/ov8i3yXO
         vC86pVLJ2614ADCYfa0b7iYKbFS19tgQ3b/jLl+5oiKWA4oHURAv23DWZGEVy7bvRP5c
         Yoh+Z1wTZ5ZS0Psc5e0+4SUJtbTL0KoqGvwPc9SUahTBRF0k6YyYFpYbKQxzyYDsYUKh
         +gehrYrlFju9G72w2YsZIXUw03+M7m8laSXApYJAdmivmkIi3C2R91KekAAd4BTEz5r3
         LIJfDu3303cs4DrF3R06JGYdjjLv0jIniVdpECHeOVlH3/v52I96gfJPLLo8sPZ3Mj6Q
         yH8A==
X-Gm-Message-State: ALQs6tCsmApglKC5S4qRcO90N3o1oQW1oqVhMWZJP0O+HhZSspCkPbrl
        9CGczuH6mjLdWXdCTPGpkJQL979voRk=
X-Google-Smtp-Source: AB8JxZq97lzehwGrVn19HVWggbLiYNAq8T/mk1EjFs0Tpa0jX64mJ8WHd+sZ5/robO5aLxRdG3CMHw==
X-Received: by 2002:a17:902:22cc:: with SMTP id o12-v6mr48668391plg.38.1525912839269;
        Wed, 09 May 2018 17:40:39 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id a77sm23812226pfe.70.2018.05.09.17.40.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 May 2018 17:40:38 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jamill@microsoft.com,
        jonathantanmy@google.com, pclouds@gmail.com
Subject: [PATCH v4 06/13] alloc: add repository argument to alloc_commit_node
Date:   Wed,  9 May 2018 17:40:17 -0700
Message-Id: <20180510004024.93974-7-sbeller@google.com>
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
 alloc.c           | 2 +-
 blame.c           | 2 +-
 cache.h           | 3 ++-
 commit.c          | 2 +-
 merge-recursive.c | 2 +-
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/alloc.c b/alloc.c
index 2c8d1430758..9e2b897ec1d 100644
--- a/alloc.c
+++ b/alloc.c
@@ -88,7 +88,7 @@ unsigned int alloc_commit_index(void)
 	return count++;
 }
 
-void *alloc_commit_node(void)
+void *alloc_commit_node_the_repository(void)
 {
 	struct commit *c = alloc_node(&commit_state, sizeof(struct commit));
 	c->object.type = OBJ_COMMIT;
diff --git a/blame.c b/blame.c
index dfa24473dc6..ba9b18e7542 100644
--- a/blame.c
+++ b/blame.c
@@ -161,7 +161,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 
 	read_cache();
 	time(&now);
-	commit = alloc_commit_node();
+	commit = alloc_commit_node(the_repository);
 	commit->object.parsed = 1;
 	commit->date = now;
 	parent_tail = &commit->parents;
diff --git a/cache.h b/cache.h
index 1717d07a2c5..bf6e8c87d83 100644
--- a/cache.h
+++ b/cache.h
@@ -1768,7 +1768,8 @@ void encode_85(char *buf, const unsigned char *data, int bytes);
 extern void *alloc_blob_node_the_repository(void);
 #define alloc_tree_node(r) alloc_tree_node_##r()
 extern void *alloc_tree_node_the_repository(void);
-extern void *alloc_commit_node(void);
+#define alloc_commit_node(r) alloc_commit_node_##r()
+extern void *alloc_commit_node_the_repository(void);
 extern void *alloc_tag_node(void);
 extern void *alloc_object_node(void);
 extern void alloc_report(void);
diff --git a/commit.c b/commit.c
index 9106acf0aad..a9a43e79bae 100644
--- a/commit.c
+++ b/commit.c
@@ -51,7 +51,7 @@ struct commit *lookup_commit(const struct object_id *oid)
 	struct object *obj = lookup_object(oid->hash);
 	if (!obj)
 		return create_object(the_repository, oid->hash,
-				     alloc_commit_node());
+				     alloc_commit_node(the_repository));
 	return object_as_type(obj, OBJ_COMMIT, 0);
 }
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 0c0d48624da..6dac8908648 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -98,7 +98,7 @@ static struct tree *shift_tree_object(struct tree *one, struct tree *two,
 
 static struct commit *make_virtual_commit(struct tree *tree, const char *comment)
 {
-	struct commit *commit = alloc_commit_node();
+	struct commit *commit = alloc_commit_node(the_repository);
 
 	set_merge_remote_desc(commit, comment, (struct object *)commit);
 	commit->tree = tree;
-- 
2.17.0.255.g8bfb7c0704

