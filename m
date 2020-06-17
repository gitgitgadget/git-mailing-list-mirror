Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799D4C433DF
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 09:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B1072100A
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 09:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ul9PF3ve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgFQJQY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 05:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgFQJQW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 05:16:22 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF088C061573
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 02:16:20 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id e9so953234pgo.9
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 02:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ij+Yib+f3PlB+fwRGnASqTjNUKP9NOz2qNcqC+UQMJs=;
        b=Ul9PF3veV969I+63Q0K/SFrL3FpMbSiLUgO5XntaBVBxMPI6Qf7PF8cT8aBOErNxeX
         vulPex/dDRPnaaPrr77LzRWykfiS5TZ2dEyYrm2VifEksr81Ugupux7nzjboI9x6YYRH
         rEeBEiSnTHJFLIxGSu62+9qG/3yN1t2pnT3NkBGevNwfDLpPfwS35X2rod5Dy4cLnd8R
         BC4T6PhBeKC8vjPWw00u2JzIjHOLxrKLvtgXK20m38lobHoGpRnpl5QfqY13g/ECJK2o
         3ZVoUmM5oAQOmGdYVOABMHK+cZEZmNcA3uSYkZkStGv0l6GUhdqn2lKzZRBOLeETUKV/
         fj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ij+Yib+f3PlB+fwRGnASqTjNUKP9NOz2qNcqC+UQMJs=;
        b=eD5BmnUfKiibi4LiJpZk3YpF3AW3ig7kVqzXLPYpsu4Rw8xZnftAlgplh6ulWIB7S3
         0l2KB6BAoucHNAdXhfVMPrzuvgNq7DrQcr1Zk5sqO6Th+RVA/t29HM6gakxkCndCjeAo
         W5XfLaDG3gXjCD9em20FiLhyvNaQearWwQu7hi+wb1L92+zCWx1BW3NuAahvUNAcuOfT
         uxZlHNRFr2s8AYXDr1VMuuIjnV8bCEgwp6vcbOliF//USUnJ7OhqyNLrv48d1HKJnZc+
         X2ci7em4CE6RgoK+3sfMtsJn84fY4ZTfnNkYUVDUUTL97i4e1+zKox+REHIldqs/KD/5
         B+Pw==
X-Gm-Message-State: AOAM533u7a6cfxi8v7XLjoJmPQudTW00WMxUOqvNuLdHjU7yqINhc+CO
        eSiBEnOI/cSzxsyJrHBY9paDupNC
X-Google-Smtp-Source: ABdhPJx6K+W8ODcLnFaxf6wymvJeG1718+BVT5s3DANaVB7WOADh0+RhefUc7GXg8IE0H03CvSoSXw==
X-Received: by 2002:a63:4407:: with SMTP id r7mr5863252pga.274.1592385379546;
        Wed, 17 Jun 2020 02:16:19 -0700 (PDT)
Received: from localhost.localdomain ([2409:4064:40b:ccca:8c2b:e6b:e670:4483])
        by smtp.gmail.com with ESMTPSA id r8sm17162110pgn.19.2020.06.17.02.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 02:16:18 -0700 (PDT)
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Cc:     jnareb@gmail.com, stolee@gmail.com
Subject: [GSOC Patch v4 1/4] object: drop parsed_object_pool->commit_count
Date:   Wed, 17 Jun 2020 14:44:08 +0530
Message-Id: <20200617091411.14650-2-abhishekkumar8222@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200617091411.14650-1-abhishekkumar8222@gmail.com>
References: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
 <20200617091411.14650-1-abhishekkumar8222@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

14ba97f8 (alloc: allow arbitrary repositories for alloc functions,
2018-05-15) introduced parsed_object_pool->commit_count to keep count of
commits per repository and was used to assign commit->index.

However, commit-slab code requires commit->index values to be unique
and a global count would be correct, rather than a per-repo count.

Let's introduce a static counter variable, `parsed_commits_count` to
keep track of parsed commits so far.

As commit_count has no use anymore, let's also drop it from the struct.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 alloc.c                | 16 +++++++++++-----
 alloc.h                |  2 +-
 blob.c                 |  2 +-
 builtin/commit-graph.c |  2 +-
 builtin/fsck.c         |  2 +-
 commit.c               |  4 ++--
 object.c               |  4 ++--
 object.h               |  3 +--
 refs.c                 |  2 +-
 t/helper/test-reach.c  |  2 +-
 tag.c                  |  2 +-
 tree.c                 |  2 +-
 12 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/alloc.c b/alloc.c
index 1c64c4dd16..99fa934b32 100644
--- a/alloc.c
+++ b/alloc.c
@@ -99,15 +99,21 @@ void *alloc_object_node(struct repository *r)
 	return obj;
 }
 
-static unsigned int alloc_commit_index(struct repository *r)
+/*
+ * The returned count is to be used as an index into commit slabs,
+ * that are *NOT* maintained per repository, and that is why a single
+ * global counter is used.
+ */
+static unsigned int alloc_commit_index(void)
 {
-	return r->parsed_objects->commit_count++;
+	static unsigned int parsed_commits_count;
+	return parsed_commits_count++;
 }
 
-void init_commit_node(struct repository *r, struct commit *c)
+void init_commit_node(struct commit *c)
 {
 	c->object.type = OBJ_COMMIT;
-	c->index = alloc_commit_index(r);
+	c->index = alloc_commit_index();
 	c->graph_pos = COMMIT_NOT_FROM_GRAPH;
 	c->generation = GENERATION_NUMBER_INFINITY;
 }
@@ -115,7 +121,7 @@ void init_commit_node(struct repository *r, struct commit *c)
 void *alloc_commit_node(struct repository *r)
 {
 	struct commit *c = alloc_node(r->parsed_objects->commit_state, sizeof(struct commit));
-	init_commit_node(r, c);
+	init_commit_node(c);
 	return c;
 }
 
diff --git a/alloc.h b/alloc.h
index ed1071c11e..371d388b55 100644
--- a/alloc.h
+++ b/alloc.h
@@ -9,7 +9,7 @@ struct repository;
 
 void *alloc_blob_node(struct repository *r);
 void *alloc_tree_node(struct repository *r);
-void init_commit_node(struct repository *r, struct commit *c);
+void init_commit_node(struct commit *c);
 void *alloc_commit_node(struct repository *r);
 void *alloc_tag_node(struct repository *r);
 void *alloc_object_node(struct repository *r);
diff --git a/blob.c b/blob.c
index 36f9abda19..182718aba9 100644
--- a/blob.c
+++ b/blob.c
@@ -10,7 +10,7 @@ struct blob *lookup_blob(struct repository *r, const struct object_id *oid)
 	struct object *obj = lookup_object(r, oid);
 	if (!obj)
 		return create_object(r, oid, alloc_blob_node(r));
-	return object_as_type(r, obj, OBJ_BLOB, 0);
+	return object_as_type(obj, OBJ_BLOB, 0);
 }
 
 int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size)
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 75455da138..f6797e2a9f 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -154,7 +154,7 @@ static int read_one_commit(struct oidset *commits, struct progress *progress,
 			   NULL, 0);
 	if (!result)
 		return error(_("invalid object: %s"), hash);
-	else if (object_as_type(the_repository, result, OBJ_COMMIT, 1))
+	else if (object_as_type(result, OBJ_COMMIT, 1))
 		oidset_insert(commits, &result->oid);
 
 	display_progress(progress, oidset_size(commits));
diff --git a/builtin/fsck.c b/builtin/fsck.c
index f02cbdb439..b2cef01389 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -241,7 +241,7 @@ static void mark_unreachable_referents(const struct object_id *oid)
 		enum object_type type = oid_object_info(the_repository,
 							&obj->oid, NULL);
 		if (type > 0)
-			object_as_type(the_repository, obj, type, 0);
+			object_as_type(obj, type, 0);
 	}
 
 	options.walk = mark_used;
diff --git a/commit.c b/commit.c
index 87686a7055..b30875e66b 100644
--- a/commit.c
+++ b/commit.c
@@ -37,7 +37,7 @@ struct commit *lookup_commit_reference_gently(struct repository *r,
 
 	if (!obj)
 		return NULL;
-	return object_as_type(r, obj, OBJ_COMMIT, quiet);
+	return object_as_type(obj, OBJ_COMMIT, quiet);
 }
 
 struct commit *lookup_commit_reference(struct repository *r, const struct object_id *oid)
@@ -62,7 +62,7 @@ struct commit *lookup_commit(struct repository *r, const struct object_id *oid)
 	struct object *obj = lookup_object(r, oid);
 	if (!obj)
 		return create_object(r, oid, alloc_commit_node(r));
-	return object_as_type(r, obj, OBJ_COMMIT, 0);
+	return object_as_type(obj, OBJ_COMMIT, 0);
 }
 
 struct commit *lookup_commit_reference_by_name(const char *name)
diff --git a/object.c b/object.c
index 794c86650e..3257518656 100644
--- a/object.c
+++ b/object.c
@@ -157,13 +157,13 @@ void *create_object(struct repository *r, const struct object_id *oid, void *o)
 	return obj;
 }
 
-void *object_as_type(struct repository *r, struct object *obj, enum object_type type, int quiet)
+void *object_as_type(struct object *obj, enum object_type type, int quiet)
 {
 	if (obj->type == type)
 		return obj;
 	else if (obj->type == OBJ_NONE) {
 		if (type == OBJ_COMMIT)
-			init_commit_node(r, (struct commit *) obj);
+			init_commit_node((struct commit *) obj);
 		else
 			obj->type = type;
 		return obj;
diff --git a/object.h b/object.h
index b22328b838..532d7d7f28 100644
--- a/object.h
+++ b/object.h
@@ -15,7 +15,6 @@ struct parsed_object_pool {
 	struct alloc_state *commit_state;
 	struct alloc_state *tag_state;
 	struct alloc_state *object_state;
-	unsigned commit_count;
 
 	/* parent substitutions from .git/info/grafts and .git/shallow */
 	struct commit_graft **grafts;
@@ -121,7 +120,7 @@ struct object *lookup_object(struct repository *r, const struct object_id *oid);
 
 void *create_object(struct repository *r, const struct object_id *oid, void *obj);
 
-void *object_as_type(struct repository *r, struct object *obj, enum object_type type, int quiet);
+void *object_as_type(struct object *obj, enum object_type type, int quiet);
 
 /*
  * Returns the object, having parsed it to find out what it is.
diff --git a/refs.c b/refs.c
index 224ff66c7b..1f551dd279 100644
--- a/refs.c
+++ b/refs.c
@@ -339,7 +339,7 @@ enum peel_status peel_object(const struct object_id *name, struct object_id *oid
 
 	if (o->type == OBJ_NONE) {
 		int type = oid_object_info(the_repository, name, NULL);
-		if (type < 0 || !object_as_type(the_repository, o, type, 0))
+		if (type < 0 || !object_as_type(o, type, 0))
 			return PEEL_INVALID;
 	}
 
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index a0272178b7..ccf837cb33 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -67,7 +67,7 @@ int cmd__reach(int ac, const char **av)
 			die("failed to load commit for input %s resulting in oid %s\n",
 			    buf.buf, oid_to_hex(&oid));
 
-		c = object_as_type(r, peeled, OBJ_COMMIT, 0);
+		c = object_as_type(peeled, OBJ_COMMIT, 0);
 
 		if (!c)
 			die("failed to load commit for input %s resulting in oid %s\n",
diff --git a/tag.c b/tag.c
index 71b544467e..1ed2684e45 100644
--- a/tag.c
+++ b/tag.c
@@ -103,7 +103,7 @@ struct tag *lookup_tag(struct repository *r, const struct object_id *oid)
 	struct object *obj = lookup_object(r, oid);
 	if (!obj)
 		return create_object(r, oid, alloc_tag_node(r));
-	return object_as_type(r, obj, OBJ_TAG, 0);
+	return object_as_type(obj, OBJ_TAG, 0);
 }
 
 static timestamp_t parse_tag_date(const char *buf, const char *tail)
diff --git a/tree.c b/tree.c
index 1466bcc6a8..e76517f6b1 100644
--- a/tree.c
+++ b/tree.c
@@ -200,7 +200,7 @@ struct tree *lookup_tree(struct repository *r, const struct object_id *oid)
 	struct object *obj = lookup_object(r, oid);
 	if (!obj)
 		return create_object(r, oid, alloc_tree_node(r));
-	return object_as_type(r, obj, OBJ_TREE, 0);
+	return object_as_type(obj, OBJ_TREE, 0);
 }
 
 int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size)
-- 
2.27.0

