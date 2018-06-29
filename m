Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B9931F516
	for <e@80x24.org>; Fri, 29 Jun 2018 01:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936490AbeF2BXT (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 21:23:19 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:52775 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936468AbeF2BXR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 21:23:17 -0400
Received: by mail-ua0-f201.google.com with SMTP id d23-v6so2259476uap.19
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 18:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=OdPVxzJnlLGc5X/T1ZRtwFmAUFFx1b8hHyGt7DXi7fQ=;
        b=gTcouiLdf16u+9+ENX+cnJGffsaGU94u6HBZu6nzOo1UmwswwcTXKHAHdAJ6V6mpJc
         8nzNylg2Ql7qGMzZsk0VBf2MgcBZgLNnyosw+QJj/ihukuLlXcf53Jv3E+ljVVhpeo4n
         Y5W1+mqB3u3znC3vNhxFHAb9H1Gdc9dCBpHxUzzXjGh7L7NY4Mbm6YCfNsJy8gavAHTV
         cmkQ1EWOqOWgxfQEkEmR8ffH9x5cV1Kkqk6jahvJTTLcDuAhR6fILVi95w990/OEbkq1
         72WN/43qsat5OQm/nEpYLqQmEgZvoDaNcLHuTVbEMh3qimpalg+C/4slqSdC8UiuNybP
         zahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=OdPVxzJnlLGc5X/T1ZRtwFmAUFFx1b8hHyGt7DXi7fQ=;
        b=F72k21cxHZPhZMnqmKZXhtC2L1X2QC96WauGII4gZKSeuDv1M/o+gBLq7f/5eYkysQ
         GlBkYHZ2I76hIEqwYf5P+B+60i8Y+K8b2BpJPLR7CzhC4cTYNH5q+Pfi7oPbNcNw7R+B
         I7acwGoDAAeAbM/HOcmYlTtuv/dWXGZMbXfdyTqyoDoRoXi5/8IraORyoYZeBD8htb+e
         Xz78rHNrmgy/tw2qqX2i7fnml6Jil/BNR759882Sfj1V2SrvUUZrzxk3HBPMPk4uPD/Q
         On5WpCBEpb7EFNEnLoRPLcI6tjZuYzkMPE9VkZ5hfyogSDDfNCPjTiMfxw1zQkE5dQ4g
         dWaQ==
X-Gm-Message-State: APt69E3Jsbce3afPE24wOpdwmD5GyYWcc4lc6FhKLW8INpY1PjdYNRnJ
        eQR5OXtPgAhOawaQ5GdHPEqpbqZrUcCdIPoM+pxRs2cEyUyX1w5QWVwEdjGOEOUqYtiIa8s0oww
        6C3cepWKIQ/Qb+pV6olwZvQf6ArJhbOj0CUg1hl8Uq2p8waMuYsglxpQOq9+A
X-Google-Smtp-Source: AAOMgpfPoZhdUg9LYZwjMY1iVQFupLhbIyRJCuSMQy9ldyMwuu+BfL8fw7Iwv066Yoix8zcoGKvwXvslkjD8
MIME-Version: 1.0
X-Received: by 2002:ab0:1a08:: with SMTP id a8-v6mr5013643uai.96.1530235396608;
 Thu, 28 Jun 2018 18:23:16 -0700 (PDT)
Date:   Thu, 28 Jun 2018 18:22:09 -0700
In-Reply-To: <20180629012222.167426-1-sbeller@google.com>
Message-Id: <20180629012222.167426-20-sbeller@google.com>
References: <20180629012222.167426-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v3 19/32] tree: allow lookup_tree to handle arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 tree.c | 10 +++++-----
 tree.h |  3 +--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/tree.c b/tree.c
index 45e89ff08eb..78d440a9c8f 100644
--- a/tree.c
+++ b/tree.c
@@ -195,13 +195,13 @@ int read_tree(struct tree *tree, int stage, struct pathspec *match,
 	return 0;
 }
 
-struct tree *lookup_tree_the_repository(const struct object_id *oid)
+struct tree *lookup_tree(struct repository *r, const struct object_id *oid)
 {
-	struct object *obj = lookup_object(the_repository, oid->hash);
+	struct object *obj = lookup_object(r, oid->hash);
 	if (!obj)
-		return create_object(the_repository, oid->hash,
-				     alloc_tree_node(the_repository));
-	return object_as_type(the_repository, obj, OBJ_TREE, 0);
+		return create_object(r, oid->hash,
+				     alloc_tree_node(r));
+	return object_as_type(r, obj, OBJ_TREE, 0);
 }
 
 int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size)
diff --git a/tree.h b/tree.h
index 2ea21ed174b..d4807dc8058 100644
--- a/tree.h
+++ b/tree.h
@@ -12,8 +12,7 @@ struct tree {
 	unsigned long size;
 };
 
-#define lookup_tree(r, oid) lookup_tree_##r(oid)
-struct tree *lookup_tree_the_repository(const struct object_id *oid);
+struct tree *lookup_tree(struct repository *r, const struct object_id *oid);
 
 int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size);
 
-- 
2.18.0.399.gad0ab374a1-goog

