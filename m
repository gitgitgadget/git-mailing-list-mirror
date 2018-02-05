Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5062E1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeBFALo (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:11:44 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44322 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752141AbeBFALl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:11:41 -0500
Received: by mail-pg0-f65.google.com with SMTP id r1so133537pgn.11
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yYOaotxpdQM5e1fhuz/qq2rjyZJeRNtUDT7Zdg2IrKI=;
        b=ASQhJA/P7J8msuh4t5BkKDrlflBzB04t+1XEWF/Ig1sNORl4FcV34BlQZ9XoNkNZsC
         XotmAvUTsOFbBH3bxHRzdBbMPIuhzna0IkH4rNJ/QH/+8UWTu05ax4b8j138oebeabb2
         +hLSzSZ3ac3gP5GmyE1GTQXtGH5NtVpb0xCvNooP7bLB5zqEXoqGI9IUx/XnMmiPG1hN
         w/p0L1set4tiHx7CL9SI/772YaizJDN+NMh1l0zZ04auxsv/aMlx7eewypdIrI3DT4H/
         FUt5QdJvZxmgG2svGgpegF9aekgaz4pPeCqB8abrZTESeXQqPjPRXab5Qy7g+/nMm8nT
         /qDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yYOaotxpdQM5e1fhuz/qq2rjyZJeRNtUDT7Zdg2IrKI=;
        b=Pg6nPeUnSHOyhExM0vno/j2jBuuOxVeJv1N+zvhETEflfp3oPmIufHNaXx1iUi2dQn
         XAt1OGscmcJr2+dmad8WBqF5sVoGQ9qFBEohtOjAadj4S8PoxS/mk59F2AW0DfMIcGvY
         ZLtEdXfsIrZ5lrxaswIQZ9oByw32b2pGrAzKxtBGVVtm0if5BaPbeZDJBeWiuXTp6gbc
         7Yokt0eGRsVVeM7DNrx6NzscKY/7NPVgEZEypUC2ZwTreyhAPtnKywMHGbyec0Blu8Ya
         sg6zXgOHySw5e6m/bdmtPkjz8DZHpbc4wqIP+2GpGZ+tFkH2pvoZSqUGtDBSj1gqUPZ/
         fuLA==
X-Gm-Message-State: APf1xPAwDrVx+JHYjAkbuNSgoTprOW2nEWWa6aN0LrQrnvm6W9Mo6WFh
        MDqLY7xLdF9JKRLI8W0xM7DHlMwxMPY=
X-Google-Smtp-Source: AH8x224goi3ctKpZ8ihEZdOEPLFeLqB9sgbkb0ZSlqbQ5C1nqe57XK+Fs6Df2ky1kb++ACt3qPCg8g==
X-Received: by 10.98.192.11 with SMTP id x11mr525170pff.27.1517875900394;
        Mon, 05 Feb 2018 16:11:40 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id r17sm17611551pfd.113.2018.02.05.16.11.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:11:39 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 082/194] object: add repository argument to lookup_object
Date:   Mon,  5 Feb 2018 15:55:43 -0800
Message-Id: <20180205235735.216710-62-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Add a repository argument to allow callers of lookup_object to be more
specific about which repository to handle. This is a small mechanical
change; it doesn't change the implementation to handle repositories
other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

The included coccinelle semantic patch will adapt any new callers in
the diff produced by `make coccicheck`.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 blob.c                                 | 2 +-
 builtin/fast-export.c                  | 5 +++--
 builtin/fsck.c                         | 5 +++--
 builtin/name-rev.c                     | 3 ++-
 builtin/prune.c                        | 2 +-
 builtin/unpack-objects.c               | 2 +-
 commit.c                               | 2 +-
 contrib/coccinelle/object_parser.cocci | 7 +++++++
 fetch-pack.c                           | 8 ++++----
 http-push.c                            | 2 +-
 object.c                               | 8 ++++----
 object.h                               | 3 ++-
 reachable.c                            | 4 ++--
 tag.c                                  | 2 +-
 tree.c                                 | 2 +-
 upload-pack.c                          | 2 +-
 16 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/blob.c b/blob.c
index 85c2143f29..a9f3aa2ec8 100644
--- a/blob.c
+++ b/blob.c
@@ -6,7 +6,7 @@ const char *blob_type = "blob";
 
 struct blob *lookup_blob(const struct object_id *oid)
 {
-	struct object *obj = lookup_object(oid->hash);
+	struct object *obj = lookup_object(the_repository, oid->hash);
 	if (!obj)
 		return create_object(the_repository, oid->hash,
 				     alloc_blob_node());
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 6140caf8d8..642bafdd30 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -230,7 +230,7 @@ static void export_blob(const struct object_id *oid)
 	if (is_null_oid(oid))
 		return;
 
-	object = lookup_object(oid->hash);
+	object = lookup_object(the_repository, oid->hash);
 	if (object && object->flags & SHOWN)
 		return;
 
@@ -402,7 +402,8 @@ static void show_filemodify(struct diff_queue_struct *q,
 						   anonymize_sha1(&spec->oid) :
 						   spec->oid.hash));
 			else {
-				struct object *object = lookup_object(spec->oid.hash);
+				struct object *object = lookup_object(the_repository,
+								      spec->oid.hash);
 				printf("M %06o :%d ", spec->mode,
 				       get_object_mark(object));
 			}
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 9408ae5cc6..7645418821 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -395,7 +395,7 @@ static void fsck_handle_reflog_oid(const char *refname, struct object_id *oid,
 	struct object *obj;
 
 	if (!is_null_oid(oid)) {
-		obj = lookup_object(oid->hash);
+		obj = lookup_object(the_repository, oid->hash);
 		if (obj && (obj->flags & HAS_OBJ)) {
 			if (timestamp && name_objects)
 				add_decoration(fsck_walk_options.object_names,
@@ -736,7 +736,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		const char *arg = argv[i];
 		struct object_id oid;
 		if (!get_oid(arg, &oid)) {
-			struct object *obj = lookup_object(oid.hash);
+			struct object *obj = lookup_object(the_repository,
+							   oid.hash);
 
 			if (!obj || !(obj->flags & HAS_OBJ)) {
 				error("%s: object missing", oid_to_hex(&oid));
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index c6b253eefb..45ec5515cc 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -363,7 +363,8 @@ static void name_rev_line(char *p, struct name_ref_data *data)
 			*(p+1) = 0;
 			if (!get_oid(p - (GIT_SHA1_HEXSZ - 1), &oid)) {
 				struct object *o =
-					lookup_object(oid.hash);
+					lookup_object(the_repository,
+						      oid.hash);
 				if (o)
 					name = get_rev_name(o, &buf);
 			}
diff --git a/builtin/prune.c b/builtin/prune.c
index 7891048b35..06e6de45b5 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -40,7 +40,7 @@ static int prune_object(const struct object_id *oid, const char *fullpath,
 	 * Do we know about this object?
 	 * It must have been reachable
 	 */
-	if (lookup_object(oid->hash))
+	if (lookup_object(the_repository, oid->hash))
 		return 0;
 
 	if (lstat(fullpath, &st)) {
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index ee707068b3..e26f673a15 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -329,7 +329,7 @@ static int resolve_against_held(unsigned nr, const struct object_id *base,
 {
 	struct object *obj;
 	struct obj_buffer *obj_buffer;
-	obj = lookup_object(base->hash);
+	obj = lookup_object(the_repository, base->hash);
 	if (!obj)
 		return 0;
 	obj_buffer = lookup_object_buffer(obj);
diff --git a/commit.c b/commit.c
index e315d5435b..68967e6c59 100644
--- a/commit.c
+++ b/commit.c
@@ -50,7 +50,7 @@ struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref
 
 struct commit *lookup_commit(const struct object_id *oid)
 {
-	struct object *obj = lookup_object(oid->hash);
+	struct object *obj = lookup_object(the_repository, oid->hash);
 	if (!obj)
 		return create_object(the_repository, oid->hash,
 				     alloc_commit_node());
diff --git a/contrib/coccinelle/object_parser.cocci b/contrib/coccinelle/object_parser.cocci
index 2a554084d1..d57b0f16d4 100644
--- a/contrib/coccinelle/object_parser.cocci
+++ b/contrib/coccinelle/object_parser.cocci
@@ -12,3 +12,10 @@ expression F;
  create_object(
 + the_repository,
  E, F)
+
+@@
+expression E;
+@@
+ lookup_object(
++the_repository,
+ E)
diff --git a/fetch-pack.c b/fetch-pack.c
index 0f7aeabb64..02ac850967 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -360,7 +360,7 @@ static int find_common(struct fetch_pack_args *args,
 		 * interested in the case we *know* the object is
 		 * reachable and we have already scanned it.
 		 */
-		if (((o = lookup_object(remote->hash)) != NULL) &&
+		if (((o = lookup_object(the_repository, remote->hash)) != NULL) &&
 				(o->flags & COMPLETE)) {
 			continue;
 		}
@@ -429,7 +429,7 @@ static int find_common(struct fetch_pack_args *args,
 			if (skip_prefix(line, "unshallow ", &arg)) {
 				if (get_oid_hex(arg, &oid))
 					die(_("invalid unshallow line: %s"), line);
-				if (!lookup_object(oid.hash))
+				if (!lookup_object(the_repository, oid.hash))
 					die(_("object not found: %s"), line);
 				/* make sure that it is parsed as shallow */
 				if (!parse_object(the_repository, &oid))
@@ -751,7 +751,7 @@ static int everything_local(struct fetch_pack_args *args,
 	 * Don't mark them common yet; the server has to be told so first.
 	 */
 	for (ref = *refs; ref; ref = ref->next) {
-		struct object *o = deref_tag(lookup_object(ref->old_oid.hash),
+		struct object *o = deref_tag(lookup_object(the_repository, ref->old_oid.hash),
 					     NULL, 0);
 
 		if (!o || o->type != OBJ_COMMIT || !(o->flags & COMPLETE))
@@ -770,7 +770,7 @@ static int everything_local(struct fetch_pack_args *args,
 		const struct object_id *remote = &ref->old_oid;
 		struct object *o;
 
-		o = lookup_object(remote->hash);
+		o = lookup_object(the_repository, remote->hash);
 		if (!o || !(o->flags & COMPLETE)) {
 			retval = 0;
 			print_verbose(args, "want %s (%s)", oid_to_hex(remote),
diff --git a/http-push.c b/http-push.c
index b4c3cd1cd7..5149c1b425 100644
--- a/http-push.c
+++ b/http-push.c
@@ -722,7 +722,7 @@ static void one_remote_object(const struct object_id *oid)
 {
 	struct object *obj;
 
-	obj = lookup_object(oid->hash);
+	obj = lookup_object(the_repository, oid->hash);
 	if (!obj)
 		obj = parse_object(the_repository, oid);
 
diff --git a/object.c b/object.c
index 1126c7e278..681fa40eb1 100644
--- a/object.c
+++ b/object.c
@@ -81,7 +81,7 @@ static void insert_obj_hash(struct object *obj, struct object **hash, unsigned i
  * Look up the record for the given sha1 in the hash map stored in
  * obj_hash.  Return NULL if it was not found.
  */
-struct object *lookup_object(const unsigned char *sha1)
+struct object *lookup_object_the_repository(const unsigned char *sha1)
 {
 	unsigned int i, first;
 	struct object *obj;
@@ -175,7 +175,7 @@ void *object_as_type(struct object *obj, enum object_type type, int quiet)
 
 struct object *lookup_unknown_object(const unsigned char *sha1)
 {
-	struct object *obj = lookup_object(sha1);
+	struct object *obj = lookup_object(the_repository, sha1);
 	if (!obj)
 		obj = create_object(the_repository, sha1,
 				    alloc_object_node());
@@ -251,7 +251,7 @@ struct object *parse_object_the_repository(const struct object_id *oid)
 	void *buffer;
 	struct object *obj;
 
-	obj = lookup_object(oid->hash);
+	obj = lookup_object(the_repository, oid->hash);
 	if (obj && obj->parsed)
 		return obj;
 
@@ -263,7 +263,7 @@ struct object *parse_object_the_repository(const struct object_id *oid)
 			return NULL;
 		}
 		parse_blob_buffer(lookup_blob(oid), NULL, 0);
-		return lookup_object(oid->hash);
+		return lookup_object(the_repository, oid->hash);
 	}
 
 	buffer = read_sha1_file(oid->hash, &type, &size);
diff --git a/object.h b/object.h
index ac12dc3629..727a03ebd6 100644
--- a/object.h
+++ b/object.h
@@ -98,7 +98,8 @@ extern struct object *get_indexed_object(unsigned int);
  * half-initialised objects, the caller is expected to initialize them
  * by calling parse_object() on them.
  */
-struct object *lookup_object(const unsigned char *sha1);
+#define lookup_object(r, s) lookup_object_##r(s)
+struct object *lookup_object_the_repository(const unsigned char *sha1);
 
 #define create_object(r, s, o) create_object_##r(s, o)
 extern void *create_object_the_repository(const unsigned char *sha1, void *obj);
diff --git a/reachable.c b/reachable.c
index 7e7b9525c0..4007c6428b 100644
--- a/reachable.c
+++ b/reachable.c
@@ -109,7 +109,7 @@ static int add_recent_loose(const struct object_id *oid,
 			    const char *path, void *data)
 {
 	struct stat st;
-	struct object *obj = lookup_object(oid->hash);
+	struct object *obj = lookup_object(the_repository, oid->hash);
 
 	if (obj && obj->flags & SEEN)
 		return 0;
@@ -134,7 +134,7 @@ static int add_recent_packed(const struct object_id *oid,
 			     struct packed_git *p, uint32_t pos,
 			     void *data)
 {
-	struct object *obj = lookup_object(oid->hash);
+	struct object *obj = lookup_object(the_repository, oid->hash);
 
 	if (obj && obj->flags & SEEN)
 		return 0;
diff --git a/tag.c b/tag.c
index a9e5af4294..3712ef7867 100644
--- a/tag.c
+++ b/tag.c
@@ -94,7 +94,7 @@ struct object *deref_tag_noverify(struct object *o)
 
 struct tag *lookup_tag(const struct object_id *oid)
 {
-	struct object *obj = lookup_object(oid->hash);
+	struct object *obj = lookup_object(the_repository, oid->hash);
 	if (!obj)
 		return create_object(the_repository, oid->hash,
 				     alloc_tag_node());
diff --git a/tree.c b/tree.c
index f8e1e6d63d..8f0ee6c8c0 100644
--- a/tree.c
+++ b/tree.c
@@ -196,7 +196,7 @@ int read_tree(struct tree *tree, int stage, struct pathspec *match,
 
 struct tree *lookup_tree(const struct object_id *oid)
 {
-	struct object *obj = lookup_object(oid->hash);
+	struct object *obj = lookup_object(the_repository, oid->hash);
 	if (!obj)
 		return create_object(the_repository, oid->hash,
 				     alloc_tree_node());
diff --git a/upload-pack.c b/upload-pack.c
index b076cbc5f7..8716e28d4f 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -556,7 +556,7 @@ static int get_reachable_list(struct object_array *src,
 		if (namebuf[40] != '\n' || get_oid_hex(namebuf, &sha1))
 			break;
 
-		o = lookup_object(sha1.hash);
+		o = lookup_object(the_repository, sha1.hash);
 		if (o && o->type == OBJ_COMMIT) {
 			o->flags &= ~TMP_MARK;
 		}
-- 
2.15.1.433.g936d1b9894.dirty

