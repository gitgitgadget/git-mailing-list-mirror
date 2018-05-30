Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F2FA1F42D
	for <e@80x24.org>; Wed, 30 May 2018 00:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968584AbeE3AtO (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 20:49:14 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:43428 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968053AbeE3Asz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 20:48:55 -0400
Received: by mail-pg0-f41.google.com with SMTP id p8-v6so7318901pgq.10
        for <git@vger.kernel.org>; Tue, 29 May 2018 17:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F5QNkHpnLWPybsaO8SkY3P0VuJQS7+atLlJI1Yqj2cQ=;
        b=h2pP/JnGqHPVhgwIIjdA0zg69PYYdrMhhJFe/oWy7E15/fr4lIbiq3zd/3aaBDH/N1
         4i1Zqgn5BNPdbbor2QyxXMk9Iez5A71Y1X1zJAwotmUhjARhMGJgrNl6qqblvvywMYRK
         LAtn3RVy/g8NRUPKXgB/OSES/oWRm6otbEqfdgYKr+aFF3zVx8grOEHevycLWvC+EqGz
         w2A+p2jZ9YSYGHtLPK7q4ucV4c2IlFYPukAXUt1IvIdp21R/FkpalIuK+YYDULCH+pKs
         6d9OkQSqzmg190YfjSGiZZ3Ftwnbqjex47NBDaHxAhpvdyDGs4UroHpbCO2jCoDqbTfG
         IGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F5QNkHpnLWPybsaO8SkY3P0VuJQS7+atLlJI1Yqj2cQ=;
        b=nNu/K8T/scmkjKDxA/rX18OblByp/gRQhTwrGVeZPwD84AYpXkaf34VQmVdqdnRKVW
         dZgRuQdQLddZ4c9oGdG0NjBF8ZcUOfyTRSxeybQFOrlIJKd+UvS728bGjKaqcqEJtY2T
         vK06etRAKXxY0DOWMLjrDTjuoULNqxi3vl1zCA22tzXmF4QVxDs6N+eDCcOnwwh4943M
         RR+3bULz/BqF4jEXTACpY6s0KTMTelzIaZ/DG81N3kJ/9Gbku9k7kLzXlrhe8iHRjQBz
         KI4CGjS8gTYENRVKifrLFFbP1EK1gnT889ccGCtR6SnRzQCIIJ9dP+m+ZEAcTtJhQEyn
         Ypkg==
X-Gm-Message-State: ALKqPweo6lumqCYbR8umna1qsCWkGhpecBpJ1KoWVWKeaAKg7qhc2i7J
        i67R2+Iu8bMfl0+YTmXgkUR87phtJTU=
X-Google-Smtp-Source: ADUXVKKJkdLeNcUXGScEbTWiokTUy6zZvtG6kr7/tEiw9cLuQBeUkR9eGygEF/OAYhmf0AoZ03RjCQ==
X-Received: by 2002:a62:49d4:: with SMTP id r81-v6mr612249pfi.146.1527641334800;
        Tue, 29 May 2018 17:48:54 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id j24-v6sm19593696pfi.84.2018.05.29.17.48.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 17:48:53 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 23/35] commit: allow lookup_commit to handle arbitrary repositories
Date:   Tue, 29 May 2018 17:47:58 -0700
Message-Id: <20180530004810.30076-24-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180530004810.30076-1-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 10 +++++-----
 commit.h |  3 +--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/commit.c b/commit.c
index 8e7dfafe850..492bccf10eb 100644
--- a/commit.c
+++ b/commit.c
@@ -52,13 +52,13 @@ struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref
 	return c;
 }
 
-struct commit *lookup_commit_the_repository(const struct object_id *oid)
+struct commit *lookup_commit(struct repository *r, const struct object_id *oid)
 {
-	struct object *obj = lookup_object(the_repository, oid->hash);
+	struct object *obj = lookup_object(r, oid->hash);
 	if (!obj)
-		return create_object(the_repository, oid->hash,
-				     alloc_commit_node(the_repository));
-	return object_as_type(the_repository, obj, OBJ_COMMIT, 0);
+		return create_object(r, oid->hash,
+				     alloc_commit_node(r));
+	return object_as_type(r, obj, OBJ_COMMIT, 0);
 }
 
 struct commit *lookup_commit_reference_by_name(const char *name)
diff --git a/commit.h b/commit.h
index c4d3033dc12..b96a57ad295 100644
--- a/commit.h
+++ b/commit.h
@@ -53,8 +53,7 @@ enum decoration_type {
 void add_name_decoration(enum decoration_type type, const char *name, struct object *obj);
 const struct name_decoration *get_name_decoration(const struct object *obj);
 
-#define lookup_commit(r, o) lookup_commit_##r(o)
-struct commit *lookup_commit_the_repository(const struct object_id *oid);
+struct commit *lookup_commit(struct repository *r, const struct object_id *oid);
 #define lookup_commit_reference(r, o) \
 		lookup_commit_reference_##r(o)
 struct commit *lookup_commit_reference_the_repository(const struct object_id *oid);
-- 
2.17.0.582.gccdcbd54c44.dirty

