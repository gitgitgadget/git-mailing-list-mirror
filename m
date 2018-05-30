Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BFC81F42D
	for <e@80x24.org>; Wed, 30 May 2018 00:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968551AbeE3AuN (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 20:50:13 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35391 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966337AbeE3Asm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 20:48:42 -0400
Received: by mail-pl0-f65.google.com with SMTP id i5-v6so9961136plt.2
        for <git@vger.kernel.org>; Tue, 29 May 2018 17:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0d5RQmwBQl28/UvlzbYrp+T82dvryetuYcybkFKIKEQ=;
        b=sIzY+gO7vj/pjY2ApzBI8vFY+k0eSy0y8Dqs+U1oLhOd8U3tmGceiwh7jVYm/VUySU
         pRZLS5lnXpaJkprlskhdjIdsWB8XaXGiNk5Dnui95Lz1IgSZn3Y2dGukBkSGc7VNXC4I
         g/0SL9YFYhx5hQc7pahsVdnrH9i5nSiQnH2N16Mn5yWRgoSk7sm7kqt3yjvd2U5nWPn9
         cmStekum/VlFoDE310tLWsmSClw1YTpFodaovVXCFMYvXO3iC9LvJpitfmfqjYfPwJHa
         C3SkGICAsmd1wsJIoMR7g1ZbZQ0GkC/JGB/3sYzPaST3cjSHjScMLp9dpeuOfLOMGB7j
         8r0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0d5RQmwBQl28/UvlzbYrp+T82dvryetuYcybkFKIKEQ=;
        b=iCajF/cREUmkR4nDXrYJlFozNccmfZ4HITa+EH4i5zFAh075odr0PdtafCUaH8K5/3
         +BUC22hHxtbjcp+CSQ8nrfoI/qZgT4tXyIcRL1mdS5CR87DIUCBY2Zd4ubLY0nEeTnhI
         NJGwVTfSc8yygA7NhEzLoFfjG6pwDiMubsjBoNrRwKwCpmRQVGBiqFD93vmikbzlebVa
         B0evAnZc+PvNMfm0zHbUUexSwGGhm1+rzOLQAjs110H/9BPNZzX4baaQ5T4MHktmT4UC
         TyDyxqfBeM1TZpFphnTRkncfoVrMaJQU6Daxl0WtCnNMuiR9z/D17W9iyj+KIOEox5W+
         llRg==
X-Gm-Message-State: ALKqPwdUovnRh3cXw68W41xvfDigz5BQx9ofLZXd6r2JXeKAc869oTIg
        b480pthxWFWhpuULs3htEXeT2DNXtVQ=
X-Google-Smtp-Source: ADUXVKJqypQJknVItaaSKxDRPIZHEEvdH2gQ+AeRYYhESo7bczO/AfDe8IvgC0kj5M3Uvy3WwOJ35A==
X-Received: by 2002:a17:902:125:: with SMTP id 34-v6mr659325plb.42.1527641321542;
        Tue, 29 May 2018 17:48:41 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id y1-v6sm10658699pfm.87.2018.05.29.17.48.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 17:48:40 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 14/35] tag: add repository argument to lookup_tag
Date:   Tue, 29 May 2018 17:47:49 -0700
Message-Id: <20180530004810.30076-15-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180530004810.30076-1-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of lookup_tag
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/describe.c     | 6 +++---
 builtin/pack-objects.c | 2 +-
 builtin/replace.c      | 2 +-
 log-tree.c             | 2 +-
 object.c               | 2 +-
 sha1-name.c            | 2 +-
 tag.c                  | 4 ++--
 tag.h                  | 4 ++--
 8 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 080b5ce082c..6fb713b6be1 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -93,13 +93,13 @@ static int replace_name(struct commit_name *e,
 		struct tag *t;
 
 		if (!e->tag) {
-			t = lookup_tag(&e->oid);
+			t = lookup_tag(the_repository, &e->oid);
 			if (!t || parse_tag(t))
 				return 1;
 			e->tag = t;
 		}
 
-		t = lookup_tag(oid);
+		t = lookup_tag(the_repository, oid);
 		if (!t || parse_tag(t))
 			return 0;
 		*tag = t;
@@ -267,7 +267,7 @@ static unsigned long finish_depth_computation(
 static void append_name(struct commit_name *n, struct strbuf *dst)
 {
 	if (n->prio == 2 && !n->tag) {
-		n->tag = lookup_tag(&n->oid);
+		n->tag = lookup_tag(the_repository, &n->oid);
 		if (!n->tag || parse_tag(n->tag))
 			die(_("annotated tag %s not available"), n->path);
 	}
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6eae39cf858..41192fdf595 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2365,7 +2365,7 @@ static void add_tag_chain(const struct object_id *oid)
 	if (packlist_find(&to_pack, oid->hash, NULL))
 		return;
 
-	tag = lookup_tag(oid);
+	tag = lookup_tag(the_repository, oid);
 	while (1) {
 		if (!tag || parse_tag(tag) || !tag->tagged)
 			die("unable to pack objects reachable from tag %s",
diff --git a/builtin/replace.c b/builtin/replace.c
index 14e142d5a80..8c8cec4aae6 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -359,7 +359,7 @@ static void check_one_mergetag(struct commit *commit,
 	int i;
 
 	hash_object_file(extra->value, extra->len, type_name(OBJ_TAG), &tag_oid);
-	tag = lookup_tag(&tag_oid);
+	tag = lookup_tag(the_repository, &tag_oid);
 	if (!tag)
 		die(_("bad mergetag in commit '%s'"), ref);
 	if (parse_tag_buffer(tag, extra->value, extra->len))
diff --git a/log-tree.c b/log-tree.c
index a47283eca64..727758eb442 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -506,7 +506,7 @@ static void show_one_mergetag(struct commit *commit,
 	size_t payload_size, gpg_message_offset;
 
 	hash_object_file(extra->value, extra->len, type_name(OBJ_TAG), &oid);
-	tag = lookup_tag(&oid);
+	tag = lookup_tag(the_repository, &oid);
 	if (!tag)
 		return; /* error message already given */
 
diff --git a/object.c b/object.c
index e859662c63c..b94f8358919 100644
--- a/object.c
+++ b/object.c
@@ -223,7 +223,7 @@ struct object *parse_object_buffer_the_repository(const struct object_id *oid, e
 			obj = &commit->object;
 		}
 	} else if (type == OBJ_TAG) {
-		struct tag *tag = lookup_tag(oid);
+		struct tag *tag = lookup_tag(the_repository, oid);
 		if (tag) {
 			if (parse_tag_buffer(tag, buffer, size))
 			       return NULL;
diff --git a/sha1-name.c b/sha1-name.c
index 5eef8ddd6d6..98b66c4896c 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -359,7 +359,7 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 			format_commit_message(commit, " %ad - %s", &desc, &pp);
 		}
 	} else if (type == OBJ_TAG) {
-		struct tag *tag = lookup_tag(oid);
+		struct tag *tag = lookup_tag(the_repository, oid);
 		if (!parse_tag(tag) && tag->tag)
 			strbuf_addf(&desc, " %s", tag->tag);
 	}
diff --git a/tag.c b/tag.c
index 5dcdf7bf6f9..5b41fc71fad 100644
--- a/tag.c
+++ b/tag.c
@@ -92,7 +92,7 @@ struct object *deref_tag_noverify(struct object *o)
 	return o;
 }
 
-struct tag *lookup_tag(const struct object_id *oid)
+struct tag *lookup_tag_the_repository(const struct object_id *oid)
 {
 	struct object *obj = lookup_object(the_repository, oid->hash);
 	if (!obj)
@@ -160,7 +160,7 @@ int parse_tag_buffer(struct tag *item, const void *data, unsigned long size)
 	} else if (!strcmp(type, commit_type)) {
 		item->tagged = (struct object *)lookup_commit(the_repository, &oid);
 	} else if (!strcmp(type, tag_type)) {
-		item->tagged = (struct object *)lookup_tag(&oid);
+		item->tagged = (struct object *)lookup_tag(the_repository, &oid);
 	} else {
 		error("Unknown type %s", type);
 		item->tagged = NULL;
diff --git a/tag.h b/tag.h
index 9057d76a506..276c448cd55 100644
--- a/tag.h
+++ b/tag.h
@@ -11,8 +11,8 @@ struct tag {
 	char *tag;
 	timestamp_t date;
 };
-
-extern struct tag *lookup_tag(const struct object_id *oid);
+#define lookup_tag(r, o) lookup_tag_##r(o)
+extern struct tag *lookup_tag_the_repository(const struct object_id *oid);
 extern int parse_tag_buffer(struct tag *item, const void *data, unsigned long size);
 extern int parse_tag(struct tag *item);
 extern void release_tag_memory(struct tag *t);
-- 
2.17.0.582.gccdcbd54c44.dirty

