Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBACC1F42D
	for <e@80x24.org>; Wed, 30 May 2018 00:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968558AbeE3AtS (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 20:49:18 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:38964 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968539AbeE3Asy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 20:48:54 -0400
Received: by mail-pf0-f178.google.com with SMTP id r11-v6so539705pfl.6
        for <git@vger.kernel.org>; Tue, 29 May 2018 17:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iXWYo6eiSeD0sjcy4pbA5nMR8S5C0Oykf/1AXzlKsoU=;
        b=D5PxU0m5szA+rHSR8Lllv7CEO+e/clcIutsuGL/Cyretfavd58Ck0gtybA4Nm0cwJ6
         durRqspQjOi2hlOEMHWTPzUy1b+OuNnjwT6YgaQoPHyiHieYmlrgsMPp1sJF51Fl/3Rw
         OZMczemj0HvO3xbLtyVwuKHfBc8EYFIJeyDIGnFDWIDbJfSlx6qtN6QBGToiBivOF9ok
         9YP1vRMIZH2hlmxSQOD0Cv2mQWH52zDqqF8e+QxFb2+1TnVzZPMybsnAAbITaNMbEGDC
         xeVjtSW7/32/2JeW7K3gO18RLP6gI3B24yV1wZkEwEmvYjNNuRw8XBZlZeSUaUOrNMa2
         +5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iXWYo6eiSeD0sjcy4pbA5nMR8S5C0Oykf/1AXzlKsoU=;
        b=DbIYzwdbkeUbXrCNjCs6YUwX3RKzzgFJSBTABjoUpbyTdnri5MMak+erugrLTU2rub
         0q8RQsf/BC+WwNKqC+gnbhbhdhmXH+Vyn7hGXQYVGHizkkCmw224J4YNRmJ8yeHss5iA
         2gMVSL7AvCHX141l+Jt1HICaDZjTGtGe6tz5hANakGwjv14rK+ul6b7p4nGKK4b6JU8k
         AY8B9+XLB9ql2qawjBu2WA0m/fBtLoWuSl2JWVspGxT8u+cg30P5nP0EsjnVpY99MNOE
         2E6QkmUWughOrlvgBM0jXM6ZbxeVb8HCKuSDpcxgeVn+Z8u06y7cu6oFRVck+1o0/jCU
         AmqQ==
X-Gm-Message-State: ALKqPwd3nGGo7ZyNt5ckVpG6zdHF/+RIKUJAswqKSK7+noKdrsLqaW/d
        jIOewOXxBXeCgu+tTszQlkw8oK8nUqo=
X-Google-Smtp-Source: ADUXVKJIs3oTyO80DUmT3XcmYjgKH5vWfu//T7nQwjnjQ1flMGey+Vfkb4fnEsdRvPfHxdep8WSlcA==
X-Received: by 2002:a62:9696:: with SMTP id s22-v6mr580279pfk.191.1527641333263;
        Tue, 29 May 2018 17:48:53 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id s9-v6sm65245136pfa.141.2018.05.29.17.48.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 17:48:52 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 22/35] tree: allow lookup_tree to handle arbitrary repositories
Date:   Tue, 29 May 2018 17:47:57 -0700
Message-Id: <20180530004810.30076-23-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180530004810.30076-1-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com>
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
index 6b83942e444..58baf29c96f 100644
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
2.17.0.582.gccdcbd54c44.dirty

