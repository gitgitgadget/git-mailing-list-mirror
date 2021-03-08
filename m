Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A823C4332D
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 20:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2611665285
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 20:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbhCHUFO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 15:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbhCHUEt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 15:04:49 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E8EC06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 12:04:48 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so4566493wmi.3
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 12:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qRjXQ/kHmcAUm1VCWtvCw81IemTEi1FsS7jGjLkUbeQ=;
        b=uJgeKr81xI+r8k0MpzFAfo4VlXbmZd52kzXNzIxHFUO0ytJvWhgAvFln17YCWXox0Q
         JCSDIt8GFpYkjM4vDJ4A22DxX+MXpR6Pp5lbOiXB930cP29yymHW3npQ9lrigfTatOUj
         L48Hy5izYJNf93F4+xnmHbm31N3XzHsVC+JyN4ZTwpiPEkBR2RxphvxmAHafMSr/ALb1
         Q5xBu54Vkifqy6nFL/ZvpyJCaneet8kYUFI8Puq54+FZR4dzs7sRL2pnlWfMtI40pJFL
         VRNwSu4uh3BwvU3NFVhg75kIir36xNVNxZLVXsi3citZoYYU8KZRUyQMqWotRkHZ3fW5
         DKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qRjXQ/kHmcAUm1VCWtvCw81IemTEi1FsS7jGjLkUbeQ=;
        b=ej5gKcSUx5czYVGzNKf5xdOdKpt+RjuwJKe0wLySboogO9G3qwP7k9eBqjhn4nXF5V
         jR/a0Vk1H/grsWlejJS+DI7CQm1UIF4hEGYAYX1jDTlDZ53nniiQrdK2RgtN3NWT1Nsq
         Y0eJjkJ8r4WgtCPXHPFQF9wdyNtrbXODRET0hTpa3Rs2GUU66F/TQfncuxnqfV+xfZR8
         +ABK9Zg3eZ75th/l0UKpzy4qwP53UgUNAF1H7ojURyYJkbV7bl4eaPsxEb0KWVwEEdss
         kt4vKJgYzws1xxlcc3YdiuqnR2YidZ9zFcjZ6wcilwl8MVHFy2gG29xTtDOXVcO6srgm
         qR7w==
X-Gm-Message-State: AOAM531fZ12jQwJeGNsN+ceSKI9QLW7rDTYhUn/ZoQ1Apz0J3AhRqK2I
        VO0FR6zZQ4P7ZKwmCvQ3L4eFC9zxbQETeg==
X-Google-Smtp-Source: ABdhPJwjjHSDrC1nSC87xFJ7ZhRFVYT9Vrq3M5kLzQkR73IFNe0QemjAafPG2dIlQwhxV7Fo0G+SRw==
X-Received: by 2002:a05:600c:2048:: with SMTP id p8mr444308wmg.170.1615233887036;
        Mon, 08 Mar 2021 12:04:47 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q15sm20790786wrr.58.2021.03.08.12.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 12:04:46 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 7/7] tag: don't misreport type of tagged objects in errors
Date:   Mon,  8 Mar 2021 21:04:26 +0100
Message-Id: <20210308200426.21824-8-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc1.210.g0f8085a843c
In-Reply-To: <Pine.LNX.4.21.0506212033590.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0506212033590.30848-100000@iabervon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a regression in 89e4202f982 ([PATCH] Parse tags for absent
objects, 2005-06-21) (yes, that ancient!) and correctly report an
error on a tag like:

    object <a tree hash>
    type commit

As:

    error: object <a tree hash> is tree, not a commit

Instead of our long-standing misbehavior of inverting the two, and
reporting:

    error: object <a tree hash> is commit, not a tree

Which, as can be trivially seen with 'git cat-file -t <a tree hash>'
is incorrect.

The reason for this misreporting is that in parse_tag_buffer() we end
up doing a lookup_{blob,commit,tag,tree}() depending on what we read
out of the "type" line.

If we haven't parsed that object before we end up dispatching to the
type-specific lookup functions, e.g. this for commit.c in
lookup_commit_type():

	struct object *obj = lookup_object(r, oid);
	if (!obj)
		return create_object(r, oid, alloc_commit_node(r));

Its allocation will then set the obj->type according to what the tag
told us the type was, but which we've never validated. At this point
we've got an object in memory that hasn't been parsed, and whose type
is incorrect, since we mistrusted a tag to tell us the type.

Then when we actually load the object with parse_object() we read it
and find that it's a "tree". See 8ff226a9d5e (add object_as_type
helper for casting objects, 2014-07-13) for that behavior (that's just
a refactoring commit, but shows all the code involved).

Which explains why we inverted the error report. Normally when
object_as_type() is called it's by the lookup_{blob,commit,tag,tree}()
functions via parse_object(). At that point we can trust the
obj->type.

In the case of parsing objects we've learned about via a tag with an
incorrect type it's the opposite, the obj->type isn't correct and
holds the mislabeled type, but we're parsing the object and know for
sure what object type we're dealing with.

Hence the non-intuitive solution of adding a
lookup_{blob,commit,tag,tree}_type() function. It's to distinguish
parse_object_buffer() where we actually know the type from
parse_tag_buffer() where we're just guessing about the type.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 blob.c                                 | 16 +++++++++++++++-
 blob.h                                 |  3 +++
 commit.c                               | 14 +++++++++++++-
 commit.h                               |  2 ++
 object.c                               |  8 ++++----
 t/t6102-rev-list-unexpected-objects.sh | 16 ++++++++--------
 tag.c                                  | 14 +++++++++++++-
 tag.h                                  |  2 ++
 tree.c                                 | 14 +++++++++++++-
 tree.h                                 |  2 ++
 10 files changed, 75 insertions(+), 16 deletions(-)

diff --git a/blob.c b/blob.c
index 182718aba9f..b233e0daa2f 100644
--- a/blob.c
+++ b/blob.c
@@ -2,17 +2,31 @@
 #include "blob.h"
 #include "repository.h"
 #include "alloc.h"
+#include "object-store.h"
 
 const char *blob_type = "blob";
 
-struct blob *lookup_blob(struct repository *r, const struct object_id *oid)
+struct blob *lookup_blob_type(struct repository *r,
+			      const struct object_id *oid,
+			      enum object_type type)
 {
 	struct object *obj = lookup_object(r, oid);
 	if (!obj)
 		return create_object(r, oid, alloc_blob_node(r));
+	if (type != OBJ_NONE &&
+	    obj->type != OBJ_NONE) {
+		enum object_type want = OBJ_BLOB;
+		if (oid_is_type_or_error(oid, obj->type, &want))
+			return NULL;
+	}
 	return object_as_type(obj, OBJ_BLOB, 0);
 }
 
+struct blob *lookup_blob(struct repository *r, const struct object_id *oid)
+{
+	return lookup_blob_type(r, oid, OBJ_NONE);
+}
+
 int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size)
 {
 	item->object.parsed = 1;
diff --git a/blob.h b/blob.h
index 16648720557..066a2effcbf 100644
--- a/blob.h
+++ b/blob.h
@@ -10,6 +10,9 @@ struct blob {
 };
 
 struct blob *lookup_blob(struct repository *r, const struct object_id *oid);
+struct blob *lookup_blob_type(struct repository *r,
+			      const struct object_id *oid,
+			      enum object_type type);
 
 int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size);
 
diff --git a/commit.c b/commit.c
index 54627b546c3..30cc990d003 100644
--- a/commit.c
+++ b/commit.c
@@ -57,14 +57,26 @@ struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref
 	return c;
 }
 
-struct commit *lookup_commit(struct repository *r, const struct object_id *oid)
+struct commit *lookup_commit_type(struct repository *r, const struct object_id *oid,
+				  enum object_type type)
 {
 	struct object *obj = lookup_object(r, oid);
 	if (!obj)
 		return create_object(r, oid, alloc_commit_node(r));
+	if (type != OBJ_NONE &&
+	    obj->type != OBJ_NONE) {
+		enum object_type want = OBJ_COMMIT;
+		if (oid_is_type_or_error(oid, obj->type, &want))
+			return NULL;
+	}
 	return object_as_type(obj, OBJ_COMMIT, 0);
 }
 
+struct commit *lookup_commit(struct repository *r, const struct object_id *oid)
+{
+	return lookup_commit_type(r, oid, OBJ_NONE);
+}
+
 struct commit *lookup_commit_reference_by_name(const char *name)
 {
 	struct object_id oid;
diff --git a/commit.h b/commit.h
index 49c0f503964..9b92f661836 100644
--- a/commit.h
+++ b/commit.h
@@ -64,6 +64,8 @@ void add_name_decoration(enum decoration_type type, const char *name, struct obj
 const struct name_decoration *get_name_decoration(const struct object *obj);
 
 struct commit *lookup_commit(struct repository *r, const struct object_id *oid);
+struct commit *lookup_commit_type(struct repository *r, const struct object_id *oid,
+				  enum object_type type);
 struct commit *lookup_commit_reference(struct repository *r,
 				       const struct object_id *oid);
 struct commit *lookup_commit_reference_gently(struct repository *r,
diff --git a/object.c b/object.c
index 819ee0faa26..1a45b149e08 100644
--- a/object.c
+++ b/object.c
@@ -227,14 +227,14 @@ struct object *parse_object_buffer(struct repository *r, const struct object_id
 
 	obj = NULL;
 	if (type == OBJ_BLOB) {
-		struct blob *blob = lookup_blob(r, oid);
+		struct blob *blob = lookup_blob_type(r, oid, type);
 		if (blob) {
 			if (parse_blob_buffer(blob, buffer, size))
 				return NULL;
 			obj = &blob->object;
 		}
 	} else if (type == OBJ_TREE) {
-		struct tree *tree = lookup_tree(r, oid);
+		struct tree *tree = lookup_tree_type(r, oid, type);
 		if (tree) {
 			obj = &tree->object;
 			if (!tree->buffer)
@@ -246,7 +246,7 @@ struct object *parse_object_buffer(struct repository *r, const struct object_id
 			}
 		}
 	} else if (type == OBJ_COMMIT) {
-		struct commit *commit = lookup_commit(r, oid);
+		struct commit *commit = lookup_commit_type(r, oid, type);
 		if (commit) {
 			if (parse_commit_buffer(r, commit, buffer, size, 1))
 				return NULL;
@@ -257,7 +257,7 @@ struct object *parse_object_buffer(struct repository *r, const struct object_id
 			obj = &commit->object;
 		}
 	} else if (type == OBJ_TAG) {
-		struct tag *tag = lookup_tag(r, oid);
+		struct tag *tag = lookup_tag_type(r, oid, type);
 		if (tag) {
 			if (parse_tag_buffer(r, tag, buffer, size))
 			       return NULL;
diff --git a/t/t6102-rev-list-unexpected-objects.sh b/t/t6102-rev-list-unexpected-objects.sh
index 2ea1982b9ed..4a6b3cc3b01 100755
--- a/t/t6102-rev-list-unexpected-objects.sh
+++ b/t/t6102-rev-list-unexpected-objects.sh
@@ -156,14 +156,14 @@ test_expect_success 'setup unexpected non-tag tag' '
 test_expect_success 'traverse unexpected incorrectly typed tag (to commit & tag)' '
 	test_must_fail git rev-list --objects $tag_tag_commit 2>err &&
 	cat >expected <<-EOF &&
-	error: object $commit is a tag, not a commit
+	error: object $commit is a commit, not a tag
 	fatal: bad object $commit
 	EOF
 	test_cmp expected err &&
 
 	test_must_fail git rev-list --objects $commit_tag_tag 2>err &&
 	cat >expected <<-EOF &&
-	error: object $tag_commit is a commit, not a tag
+	error: object $tag_commit is a tag, not a commit
 	fatal: bad object $tag_commit
 	EOF
 	test_cmp expected err
@@ -172,14 +172,14 @@ test_expect_success 'traverse unexpected incorrectly typed tag (to commit & tag)
 test_expect_success 'traverse unexpected incorrectly typed tag (to tree)' '
 	test_must_fail git rev-list --objects $tag_tag_tree 2>err &&
 	cat >expected <<-EOF &&
-	error: object $tree is a tag, not a tree
+	error: object $tree is a tree, not a tag
 	fatal: bad object $tree
 	EOF
 	test_cmp expected err &&
 
 	test_must_fail git rev-list --objects $commit_tag_tree 2>err &&
 	cat >expected <<-EOF &&
-	error: object $tree is a commit, not a tree
+	error: object $tree is a tree, not a commit
 	fatal: bad object $tree
 	EOF
 	test_cmp expected err
@@ -188,14 +188,14 @@ test_expect_success 'traverse unexpected incorrectly typed tag (to tree)' '
 test_expect_success 'traverse unexpected incorrectly typed tag (to blob)' '
 	test_must_fail git rev-list --objects $tag_tag_blob 2>err &&
 	cat >expected <<-EOF &&
-	error: object $blob is a tag, not a blob
+	error: object $blob is a blob, not a tag
 	fatal: bad object $blob
 	EOF
 	test_cmp expected err &&
 
 	test_must_fail git rev-list --objects $commit_tag_blob 2>err &&
 	cat >expected <<-EOF &&
-	error: object $blob is a commit, not a blob
+	error: object $blob is a blob, not a commit
 	fatal: bad object $blob
 	EOF
 	test_cmp expected err
@@ -204,14 +204,14 @@ test_expect_success 'traverse unexpected incorrectly typed tag (to blob)' '
 test_expect_success 'traverse unexpected non-tag tag (tree seen to blob)' '
 	test_must_fail git rev-list --objects $tree $commit_tag_blob 2>err &&
 	cat >expected <<-EOF &&
-	error: object $blob is a commit, not a blob
+	error: object $blob is a blob, not a commit
 	fatal: bad object $blob
 	EOF
 	test_cmp expected err &&
 
 	test_must_fail git rev-list --objects $tree $tag_tag_blob 2>err &&
 	cat >expected <<-EOF &&
-	error: object $blob is a tag, not a blob
+	error: object $blob is a blob, not a tag
 	fatal: bad object $blob
 	EOF
 	test_cmp expected err
diff --git a/tag.c b/tag.c
index 3e18a418414..0ef87897b29 100644
--- a/tag.c
+++ b/tag.c
@@ -99,14 +99,26 @@ struct object *deref_tag_noverify(struct object *o)
 	return o;
 }
 
-struct tag *lookup_tag(struct repository *r, const struct object_id *oid)
+struct tag *lookup_tag_type(struct repository *r, const struct object_id *oid,
+			    enum object_type type)
 {
 	struct object *obj = lookup_object(r, oid);
 	if (!obj)
 		return create_object(r, oid, alloc_tag_node(r));
+	if (type != OBJ_NONE &&
+	    obj->type != OBJ_NONE) {
+		enum object_type want = OBJ_TAG;
+		if (oid_is_type_or_error(oid, obj->type, &want))
+			return NULL;
+	}
 	return object_as_type(obj, OBJ_TAG, 0);
 }
 
+struct tag *lookup_tag(struct repository *r, const struct object_id *oid)
+{
+	return lookup_tag_type(r, oid, OBJ_NONE);
+}
+
 static timestamp_t parse_tag_date(const char *buf, const char *tail)
 {
 	const char *dateptr;
diff --git a/tag.h b/tag.h
index 3ce8e721924..42bd3e64011 100644
--- a/tag.h
+++ b/tag.h
@@ -12,6 +12,8 @@ struct tag {
 	timestamp_t date;
 };
 struct tag *lookup_tag(struct repository *r, const struct object_id *oid);
+struct tag *lookup_tag_type(struct repository *r, const struct object_id *oid,
+			    enum object_type type);
 int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, unsigned long size);
 int parse_tag(struct tag *item);
 void release_tag_memory(struct tag *t);
diff --git a/tree.c b/tree.c
index d9b1c70b28a..895c66420e8 100644
--- a/tree.c
+++ b/tree.c
@@ -195,14 +195,26 @@ int read_tree(struct repository *r, struct tree *tree, int stage,
 	return 0;
 }
 
-struct tree *lookup_tree(struct repository *r, const struct object_id *oid)
+struct tree *lookup_tree_type(struct repository *r, const struct object_id *oid,
+			      enum object_type type)
 {
 	struct object *obj = lookup_object(r, oid);
 	if (!obj)
 		return create_object(r, oid, alloc_tree_node(r));
+	if (type != OBJ_NONE &&
+	    obj->type != OBJ_NONE) {
+		enum object_type want = OBJ_TREE;
+		if (oid_is_type_or_error(oid, obj->type, &want))
+			return NULL;
+	}
 	return object_as_type(obj, OBJ_TREE, 0);
 }
 
+struct tree *lookup_tree(struct repository *r, const struct object_id *oid)
+{
+	return lookup_tree_type(r, oid, OBJ_NONE);
+}
+
 int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size)
 {
 	if (item->object.parsed)
diff --git a/tree.h b/tree.h
index 3eb0484cbf2..49bd44f79b3 100644
--- a/tree.h
+++ b/tree.h
@@ -15,6 +15,8 @@ struct tree {
 extern const char *tree_type;
 
 struct tree *lookup_tree(struct repository *r, const struct object_id *oid);
+struct tree *lookup_tree_type(struct repository *r, const struct object_id *oid,
+			      enum object_type type);
 
 int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size);
 
-- 
2.31.0.rc1.210.g0f8085a843c

