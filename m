Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C2CD1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752303AbeBFA0L (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:26:11 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46977 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752172AbeBFA0K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:26:10 -0500
Received: by mail-pl0-f68.google.com with SMTP id 36so119819ple.13
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YaQEuYL6RCu8+HmRVaibT9oAo7+AwtArhy+7igX1pTQ=;
        b=EJTXu98mO5Wnmu+D4A1EF7FnNlBLEh1Wn+a9W+BcGSensRv6zhsaWyrph6oZ1fdvOA
         k5Grql4IrffIvo+pzP25ghV85/peWwGYXTqMCndmmj4bNADZc/mftF2Eh/NTVUvCwipD
         bvvZsyB709skxjZOEbG119LhlM6BfMM66PIcUYtuc7OSjL4+0ZcLhKIVKoTCSas6FY2P
         2JDQ8svZnRUpb1oqOSQxPm+x743QMhDDRur28bOKSAWDHVWxo24vh/o6TaIKMzM80nHn
         5qcj47bmPBpwecj+iinBv8/SZrnZLZoftxKAhfrJosiqPr/LCc8oWqlfrwgpDwXDilgx
         bYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YaQEuYL6RCu8+HmRVaibT9oAo7+AwtArhy+7igX1pTQ=;
        b=OkVAR6SYJ7FpEkjJIUGefjerjsmgohskPEJsDrAFfUMMoDNxXhwGrjleIeWbeUaqde
         BGmiMjvstT6/zDPszlzaVJqoFo0xF8fUe37l/v5ZtdD4SvJ7/j2NwEwAwK+HKneGoGeW
         vjmIyoRqNG9/nz3k+EGWic4aBooNiJ5KJ0U7MEoRZOuhNOFFavIz9RXCmWcYN3JMTman
         ILRsh+fy+6du3vWEFLmN1Zhu6TkkqTInSZhsuRQ5aAA6cIZNehbkFxL0wa6pwP0xGaXF
         pHKThO08aESUbvLqIkxm515+StWBbw36BMlqVTdzphS94Qtv+n7ADG9edS3QL77mOfEs
         IL4w==
X-Gm-Message-State: APf1xPBPJ9Q5bJ4cThGQ6pXdnAYECOrxSN5SeuA6evTqmlMT+i5lxX7P
        OcQjsEHIyl5Th39mfQwgJuCGgqJMv5I=
X-Google-Smtp-Source: AH8x225oEYHhVSeAGa3bYC9wIqjnnPfKu0cwpAvqTo/vqeChxjdt2JUBPn+yPn39+A/BxE4JFL3A1g==
X-Received: by 2002:a17:902:6d09:: with SMTP id s9-v6mr575677plk.176.1517876769465;
        Mon, 05 Feb 2018 16:26:09 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id p62sm19045926pfi.88.2018.02.05.16.26.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:26:08 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 150/194] tree: allow lookup_tree to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:17:05 -0800
Message-Id: <20180206001749.218943-52-sbeller@google.com>
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
 tree.c | 10 +++++-----
 tree.h |  3 +--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/tree.c b/tree.c
index 1635a01794..e8150ba54b 100644
--- a/tree.c
+++ b/tree.c
@@ -194,13 +194,13 @@ int read_tree(struct tree *tree, int stage, struct pathspec *match,
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
index 8195db473f..5e7988d390 100644
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
2.15.1.433.g936d1b9894.dirty

