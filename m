Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96EA21F403
	for <e@80x24.org>; Wed, 13 Jun 2018 23:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935966AbeFMXGV (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 19:06:21 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:51162 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935933AbeFMXGS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 19:06:18 -0400
Received: by mail-qt0-f201.google.com with SMTP id z26-v6so3101742qto.17
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 16:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=x2v4bJRQMRFebxhfnqUNn0EMwAwAYIkUrVWMfLmd/dY=;
        b=m9c0tqFqKhC+rXbXp7yo8QF2Vy80hvD7h8yggpFNPoeviV8u8veftGRpIp9F+jNy8N
         kjg4OH03jiBtoVSm/uX33Rxq02TTl3P6qGx7x+ZEkI+QlzhpkxV2EJ87d7Rg/rC21iCE
         feDBPRcR3+OOygrFflr0uRyToHvog83x0sRJTNmQOyXTFLRLLtUOqyWoMtaqbGNCsN+k
         B4soN/q9aSTKY/IsKSqhdbsXyCrjNx465Zj/tIYl23zjuN0tja63oTVOvue3kRABXyLB
         NA5YvVFPAqhlQVy7iZZonbH9K3R+1OCaGgp2hNLua09ZtCEhR+LwthLcuC6mblMvSsXx
         52VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=x2v4bJRQMRFebxhfnqUNn0EMwAwAYIkUrVWMfLmd/dY=;
        b=YP2kwV9TT8nlICYgAhgy3TzII3QNfVm9TqsolQwchUauZGmkqyaig0oS5moz6UUWuz
         U4spruttohWvEbnYECpG/tILwpdx8e09O5x0Bnnzo2ERe1CKGZME5DAzkKZDhOVqIuUn
         x60DHvxt3PveDNYtXG76R9AmoCPLUQbgYrBBRpT48kf7kK4D6j/y1VDk3LzgHOPkcdeA
         NhjFDXwf0YqGtGDXxM45yMmSG6Kc0yN08Mae4qXi0o8QXpjb7YssamAXOJ05W1TZGHiB
         UfeFfh8d+hC0Oe69Z/yB/nPsi2TOVTmuE8/U+fKv6UfivjVsvEamdkNCm56uUdNHPsjq
         ckLg==
X-Gm-Message-State: APt69E2Ia0aqEyvBK3dFbCifHAh+hGQPW9IV5zvc8zGc4C+eSa6ZiviI
        ojJ+Hpug6rNha5JqJFIxYHdBf28rUOmJvTqJherx2AqAmHGhlc4Bkt2QIYzGagn4CjS8TWoXtoe
        AJkm0cv2mQHiM3r9sonVVslg/sZmUM1tp8myZuZ6JhAHEK1Xu5gfxi3lilyKM
X-Google-Smtp-Source: ADUXVKLiSPv0Rho5Yg66HnmTG/w85Dz8+mhW5ZK/b/YNg8qtIen9qJbYeJ1F8A56a+fsmr/ShGdb1FHjWyKS
MIME-Version: 1.0
X-Received: by 2002:ac8:3417:: with SMTP id u23-v6mr97063qtb.9.1528931177225;
 Wed, 13 Jun 2018 16:06:17 -0700 (PDT)
Date:   Wed, 13 Jun 2018 16:05:09 -0700
In-Reply-To: <20180613230522.55335-1-sbeller@google.com>
Message-Id: <20180613230522.55335-19-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com> <20180613230522.55335-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v2 18/31] tree: allow lookup_tree to handle arbitrary repositories
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
index 33063b8dde0..2bffc0714a8 100644
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
2.18.0.rc1.244.gcf134e6275-goog

