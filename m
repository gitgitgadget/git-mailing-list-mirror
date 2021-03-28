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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E8CC433EC
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEEFA6197C
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhC1CPA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 22:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbhC1COO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 22:14:14 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E721FC0613B1
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:14:13 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id g20so4841626wmk.3
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GaDTAT+a+A5xWFIG1SiJJDT6gWiliq9e2RKUC9vO1ms=;
        b=c7Gd1AKtretCxB4Qk5vDR1sKLD6Ydj2KkxEs2ta+fZjBdpKnY9e8RTtpM5b2rkOUz0
         j6CzSPIHaRTemTCWmbAtG+X2KIjiZk5JjbTqI9a4io56btRTA3CY1JjaSlCjSMXPN954
         fb4rdHPVvBcULeJdQZ5VPFSrC2pGkgHk3Cn0ME3EDYsclOiM6aA23Ohqq9fZFLWbnqZG
         /NnXs6C1jiW7NLQ4SlKIG/H+XEYsmxRi0sg4Zxc4uVEYdAiOuSK/gfljsZuzBeGzFhfK
         uWxuhaBQnpAqE/SngoLbsKMIaFGYYzapT74X1ulUOT0yDuaABzaW0yc/OqqMLsKU5Zxn
         JXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GaDTAT+a+A5xWFIG1SiJJDT6gWiliq9e2RKUC9vO1ms=;
        b=SqAYMIFOUoJmERIDzQp3QsvDnn72+CdsS0/GgdtrNsvDarDnBqU9u0RrcLxDl1bX9p
         hUztTIMHUgJNxWv4i44gJORHuAmvhOoQHh8n8JOlvUUIrXqdpSpKeZLUBa+uA+8rMahI
         arJwfDS5WusnRJthcN7Lq5EAoCZinXYDKGJuA1Z3rSw/oaGOvRLDznHhFVlm2eYEF0RC
         nS4KEL3g9Gxri7jvtdLeahrb6pothQI7IoVHa4L4SvhnZAN7N4MUMMjelVIFFXAmjQXe
         cBtHDfczDDXAUJ4KjPZuLuR5xeXBbOGfeTmli7y1ItXK9T5r0PgrXYoxUxsish9wyoF0
         RpXA==
X-Gm-Message-State: AOAM532xxMIzZ/hLPn/3liZX+7XFzAxJoci9+R7zgvPaOsajWJ0PmOUM
        KZ1yWuCHYKNVTVqr9l2L3Hbix0fwpcBr7Q==
X-Google-Smtp-Source: ABdhPJygLegcZBNsOqNUrMKR3dkt+m0dDumbJX+JcuVH9aJy5NkWjxsgUlqPSBFw5JBGZPX+bByiLw==
X-Received: by 2002:a05:600c:4fcb:: with SMTP id o11mr19165879wmq.117.1616897652201;
        Sat, 27 Mar 2021 19:14:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c2sm11291524wrt.47.2021.03.27.19.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 19:14:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/10] tag: don't misreport type of tagged objects in errors
Date:   Sun, 28 Mar 2021 04:13:40 +0200
Message-Id: <patch-10.11-a84f670ac24-20210328T021238Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.442.g6c06c9fe35c
In-Reply-To: <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
References: <20210308200426.21824-1-avarab@gmail.com> <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
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
calls from parse_object_buffer() where we actually know the type, from
a parse_tag_buffer() where we're just guessing about the type.

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
index b3701003678..ab6cee1e8c3 100644
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
index df42eb434f3..9def4f3f19d 100644
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
index 0f60743e61f..60037422488 100644
--- a/object.c
+++ b/object.c
@@ -230,14 +230,14 @@ struct object *parse_object_buffer(struct repository *r, const struct object_id
 
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
@@ -249,7 +249,7 @@ struct object *parse_object_buffer(struct repository *r, const struct object_id
 			}
 		}
 	} else if (type == OBJ_COMMIT) {
-		struct commit *commit = lookup_commit(r, oid);
+		struct commit *commit = lookup_commit_type(r, oid, type);
 		if (commit) {
 			if (parse_commit_buffer(r, commit, buffer, size, 1))
 				return NULL;
@@ -260,7 +260,7 @@ struct object *parse_object_buffer(struct repository *r, const struct object_id
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
2.31.1.442.g6c06c9fe35c

