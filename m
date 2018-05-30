Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA2B31F42D
	for <e@80x24.org>; Wed, 30 May 2018 00:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968610AbeE3AuQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 20:50:16 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39077 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968349AbeE3Aso (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 20:48:44 -0400
Received: by mail-pl0-f68.google.com with SMTP id f1-v6so9517747plt.6
        for <git@vger.kernel.org>; Tue, 29 May 2018 17:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hLyoAQlS067yZZzC6uQvmoSGed/vFu1pqexZzKaVJec=;
        b=u7JWs6sCnY8Bpv7spNNIPIq31RIJg3JYHRuijUtSNeNqA0T3xT/2Xg2wHbwmS0cEB9
         eQ0y+z2upxjprXa/N6i4GQO5/2g5UvfaIJewVhWBIPTjASQvVG4BFzvjfkFyw4XYsyAR
         G7jimUWkfbBhk4aJRWLYziJfH7MIvpIfgmvXl5vIXhhzA6yPsmMFkMIEfh4DkRlc5aJu
         EY/QauFoTTBVR9pH2zVP9CHwMGtfwNg6ua2gDoSPRSY4CujEJHBkgIgvyTl+Ycsh2xC3
         ujJxPABhbETrM3PQzLd8x3SKoUl+8xd9Rvgvx8FweRkPloezs69hJj2IVSy30yeIZjC9
         eW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hLyoAQlS067yZZzC6uQvmoSGed/vFu1pqexZzKaVJec=;
        b=rlyc9/kwCFQGMgEAk1luYdM+H16sN2pje304G2LgRlhHvec36JJbearUseFYvt5PQY
         S18K3E6yL/Om4avuCYpgEddLqFDjBpbzFWSe14VcQBX3akYxxqywMF9/1A99bfxwEcuJ
         1joT+5yHN4eXqZSNrSxVVtWawIDndrHSwTt4fyPDZdLOs0qZr4qk17y2E9TehqeXJFGa
         dHxjRAP29tMkuraXvUzKxb+5+0UgdgHMmqJK0hvjskXSPDCLqP2PbaHiXKLl2Wilmxgb
         rUQzORCyv3sLzZDUD2vnqNrYMBiKmFr+nipZphszYjZkgGtt90/Bu1gvEkok7pu6Ek/P
         6jfg==
X-Gm-Message-State: ALKqPwcCxN4TEdt4+wF8tm/g6KM3pyeWKo23Xe9SjzLQ+NUEu767c9+K
        5drgGKKiDLHwBVl5KHvdzLiYMxEbUYk=
X-Google-Smtp-Source: ADUXVKIOSlhXl3AqO8yZxGsuY9/uNQDeloceFifwx0lUKZNF3DeTYfQslsSdAM76SF70SErceGQmMg==
X-Received: by 2002:a17:902:24b:: with SMTP id 69-v6mr660922plc.54.1527641323336;
        Tue, 29 May 2018 17:48:43 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id f16-v6sm17859968pff.57.2018.05.29.17.48.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 17:48:42 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 15/35] tag: add repository argument to parse_tag_buffer
Date:   Tue, 29 May 2018 17:47:50 -0700
Message-Id: <20180530004810.30076-16-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180530004810.30076-1-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of parse_tag_buffer
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/replace.c | 2 +-
 log-tree.c        | 2 +-
 object.c          | 2 +-
 sha1-file.c       | 2 +-
 tag.c             | 4 ++--
 tag.h             | 3 ++-
 6 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 8c8cec4aae6..bff1c3df964 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -362,7 +362,7 @@ static void check_one_mergetag(struct commit *commit,
 	tag = lookup_tag(the_repository, &tag_oid);
 	if (!tag)
 		die(_("bad mergetag in commit '%s'"), ref);
-	if (parse_tag_buffer(tag, extra->value, extra->len))
+	if (parse_tag_buffer(the_repository, tag, extra->value, extra->len))
 		die(_("malformed mergetag in commit '%s'"), ref);
 
 	/* iterate over new parents */
diff --git a/log-tree.c b/log-tree.c
index 727758eb442..ac42ad42acc 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -511,7 +511,7 @@ static void show_one_mergetag(struct commit *commit,
 		return; /* error message already given */
 
 	strbuf_init(&verify_message, 256);
-	if (parse_tag_buffer(tag, extra->value, extra->len))
+	if (parse_tag_buffer(the_repository, tag, extra->value, extra->len))
 		strbuf_addstr(&verify_message, "malformed mergetag\n");
 	else if (is_common_merge(commit) &&
 		 !oidcmp(&tag->tagged->oid,
diff --git a/object.c b/object.c
index b94f8358919..eb35e82a4a9 100644
--- a/object.c
+++ b/object.c
@@ -225,7 +225,7 @@ struct object *parse_object_buffer_the_repository(const struct object_id *oid, e
 	} else if (type == OBJ_TAG) {
 		struct tag *tag = lookup_tag(the_repository, oid);
 		if (tag) {
-			if (parse_tag_buffer(tag, buffer, size))
+			if (parse_tag_buffer(the_repository, tag, buffer, size))
 			       return NULL;
 			obj = &tag->object;
 		}
diff --git a/sha1-file.c b/sha1-file.c
index 00b1b2b8660..3440b67639e 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1788,7 +1788,7 @@ static void check_tag(const void *buf, size_t size)
 {
 	struct tag t;
 	memset(&t, 0, sizeof(t));
-	if (parse_tag_buffer(&t, buf, size))
+	if (parse_tag_buffer(the_repository, &t, buf, size))
 		die("corrupt tag");
 }
 
diff --git a/tag.c b/tag.c
index 5b41fc71fad..4971fd4dfc9 100644
--- a/tag.c
+++ b/tag.c
@@ -126,7 +126,7 @@ void release_tag_memory(struct tag *t)
 	t->date = 0;
 }
 
-int parse_tag_buffer(struct tag *item, const void *data, unsigned long size)
+int parse_tag_buffer_the_repository(struct tag *item, const void *data, unsigned long size)
 {
 	struct object_id oid;
 	char type[20];
@@ -203,7 +203,7 @@ int parse_tag(struct tag *item)
 		return error("Object %s not a tag",
 			     oid_to_hex(&item->object.oid));
 	}
-	ret = parse_tag_buffer(item, data, size);
+	ret = parse_tag_buffer(the_repository, item, data, size);
 	free(data);
 	return ret;
 }
diff --git a/tag.h b/tag.h
index 276c448cd55..149959c81ba 100644
--- a/tag.h
+++ b/tag.h
@@ -13,7 +13,8 @@ struct tag {
 };
 #define lookup_tag(r, o) lookup_tag_##r(o)
 extern struct tag *lookup_tag_the_repository(const struct object_id *oid);
-extern int parse_tag_buffer(struct tag *item, const void *data, unsigned long size);
+#define parse_tag_buffer(r, i, d, s) parse_tag_buffer_##r(i, d, s)
+extern int parse_tag_buffer_the_repository(struct tag *item, const void *data, unsigned long size);
 extern int parse_tag(struct tag *item);
 extern void release_tag_memory(struct tag *t);
 extern struct object *deref_tag(struct object *, const char *, int);
-- 
2.17.0.582.gccdcbd54c44.dirty

