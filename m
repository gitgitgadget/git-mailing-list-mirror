Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 858801F516
	for <e@80x24.org>; Fri, 29 Jun 2018 01:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936444AbeF2BWj (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 21:22:39 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:53050 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936423AbeF2BWh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 21:22:37 -0400
Received: by mail-it0-f74.google.com with SMTP id y18-v6so474069itc.2
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 18:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=tphcvrJi5e4/1wi+VAT5fdIcYEhPw3qdvmcDIfTyz8I=;
        b=BlRyPmPr9YFOJr1w4fZoxrwwZkGR32rTFO3j3szyRKzZsiOQ18Tg8EizKPM537YgWs
         WjKgH+qLps/bZgedRYhIYZxuGw+Zs3HuRGqCfgxAcMtHB/VlHtABCsIyb8WEstLRTDSp
         2UmxXDW1Kl3yBzfBrOvYoq0PYdTqyBb0f7bWycN+1U7zn9gn1/7u5B89YQf4v2iOYRQ2
         OJUaF+fONvx9dmUdVb2abBMR5iDOKmxoP5pyeuAtYqBOYR0JUmDbDUvD8ocktOEHa0oS
         9/UZ8TKwe5ryQfdm5RXU0h+xyQiRFU0gZCo8d+WjKmt7S0daK2l6kE48vMGRBd2v2aG6
         pHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=tphcvrJi5e4/1wi+VAT5fdIcYEhPw3qdvmcDIfTyz8I=;
        b=Tsbsiwn2U+kQMTAaQZ5UsmIgyVJRqYBceCgM0SLb0vO2tLaydCHhWJSrs1R4VBZ2Jx
         U1763Nzs28m04CciBCv+BFJaCy90tDt6Ll7yHg30RKlVVOs9tb8H8LhISxuX5M5ivf5H
         o/hxyhjm7PUbudU3D5KgO/FLApF6rvF2h1adQIypY//z2Eq9j5qhtUxAdqCyysDEsUML
         MhZUdnC+aIliWEuni/RivNGasEygHc13DVVTysb3htvi8oI/PEyAAR6I42NJbp2HmvCU
         HXPveeU6qHjUOhn91Iz7YRRIFyGaF96aejKHKxxSHPyF7QwgVfPz0gAj2/1K7KSkSrQ3
         SDXg==
X-Gm-Message-State: APt69E1yI51NjsAqaypLaDQK5NL7LOdQAb9hDfsFT8pbSwfhX8f5mHEz
        tdYti6jLBz20wNPCc+tEb1TnZKOwRvVJYEWKFkQkDUswaqfTG5Cp4iwSBiR8q4GX4lLT2lqWQen
        gkYUiv19LKmPbuZ5I+crv4rY9grFH7aAlGtQT+7Fqkz9pT0rEFwHttKg0lemH
X-Google-Smtp-Source: AAOMgpeRfVO3BinmyiT1zGlEC298FEcKbA4eGonvTU53PifmZa4SVQIKggXBY42IwscZBv88GBb40FY/9SUL
MIME-Version: 1.0
X-Received: by 2002:a24:2201:: with SMTP id o1-v6mr88679ito.12.1530235356835;
 Thu, 28 Jun 2018 18:22:36 -0700 (PDT)
Date:   Thu, 28 Jun 2018 18:21:52 -0700
In-Reply-To: <20180629012222.167426-1-sbeller@google.com>
Message-Id: <20180629012222.167426-3-sbeller@google.com>
References: <20180629012222.167426-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v3 02/32] object: add repository argument to lookup_object
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow callers of lookup_object to be more
specific about which repository to handle. This is a small mechanical
change; it doesn't change the implementation to handle repositories
other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 blob.c                   |  2 +-
 builtin/fast-export.c    |  5 +++--
 builtin/fsck.c           |  5 +++--
 builtin/name-rev.c       |  3 ++-
 builtin/prune.c          |  2 +-
 builtin/unpack-objects.c |  2 +-
 commit.c                 |  2 +-
 fetch-pack.c             | 13 +++++++------
 http-push.c              |  2 +-
 object.c                 |  8 ++++----
 object.h                 |  3 ++-
 reachable.c              |  4 ++--
 tag.c                    |  2 +-
 tree.c                   |  2 +-
 upload-pack.c            |  2 +-
 15 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/blob.c b/blob.c
index 458dafa811e..75b737a761e 100644
--- a/blob.c
+++ b/blob.c
@@ -7,7 +7,7 @@ const char *blob_type = "blob";
 
 struct blob *lookup_blob(const struct object_id *oid)
 {
-	struct object *obj = lookup_object(oid->hash);
+	struct object *obj = lookup_object(the_repository, oid->hash);
 	if (!obj)
 		return create_object(the_repository, oid->hash,
 				     alloc_blob_node(the_repository));
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index a16aeaa826f..e39c4e2c1d0 100644
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
index 2b0930101d3..12d01e91747 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -410,7 +410,7 @@ static void fsck_handle_reflog_oid(const char *refname, struct object_id *oid,
 	struct object *obj;
 
 	if (!is_null_oid(oid)) {
-		obj = lookup_object(oid->hash);
+		obj = lookup_object(the_repository, oid->hash);
 		if (obj && (obj->flags & HAS_OBJ)) {
 			if (timestamp && name_objects)
 				add_decoration(fsck_walk_options.object_names,
@@ -763,7 +763,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		const char *arg = argv[i];
 		struct object_id oid;
 		if (!get_oid(arg, &oid)) {
-			struct object *obj = lookup_object(oid.hash);
+			struct object *obj = lookup_object(the_repository,
+							   oid.hash);
 
 			if (!obj || !(obj->flags & HAS_OBJ)) {
 				if (is_promisor_object(&oid))
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index de54fa93e4f..f6eb419a029 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -379,7 +379,8 @@ static void name_rev_line(char *p, struct name_ref_data *data)
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
index 70ec35aa058..72b0621b768 100644
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
index cf585fcc5ee..335b5ed9a0f 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -331,7 +331,7 @@ static int resolve_against_held(unsigned nr, const struct object_id *base,
 {
 	struct object *obj;
 	struct obj_buffer *obj_buffer;
-	obj = lookup_object(base->hash);
+	obj = lookup_object(the_repository, base->hash);
 	if (!obj)
 		return 0;
 	obj_buffer = lookup_object_buffer(obj);
diff --git a/commit.c b/commit.c
index a29070a8133..b4dbfd889a3 100644
--- a/commit.c
+++ b/commit.c
@@ -54,7 +54,7 @@ struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref
 
 struct commit *lookup_commit(const struct object_id *oid)
 {
-	struct object *obj = lookup_object(oid->hash);
+	struct object *obj = lookup_object(the_repository, oid->hash);
 	if (!obj)
 		return create_object(the_repository, oid->hash,
 				     alloc_commit_node(the_repository));
diff --git a/fetch-pack.c b/fetch-pack.c
index 6b406f1d008..771eb8ae471 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -362,7 +362,7 @@ static int find_common(struct fetch_pack_args *args,
 		 * interested in the case we *know* the object is
 		 * reachable and we have already scanned it.
 		 */
-		if (((o = lookup_object(remote->hash)) != NULL) &&
+		if (((o = lookup_object(the_repository, remote->hash)) != NULL) &&
 				(o->flags & COMPLETE)) {
 			continue;
 		}
@@ -436,7 +436,7 @@ static int find_common(struct fetch_pack_args *args,
 			if (skip_prefix(line, "unshallow ", &arg)) {
 				if (get_oid_hex(arg, &oid))
 					die(_("invalid unshallow line: %s"), line);
-				if (!lookup_object(oid.hash))
+				if (!lookup_object(the_repository, oid.hash))
 					die(_("object not found: %s"), line);
 				/* make sure that it is parsed as shallow */
 				if (!parse_object(the_repository, &oid))
@@ -801,7 +801,8 @@ static int everything_local(struct fetch_pack_args *args,
 		 * Don't mark them common yet; the server has to be told so first.
 		 */
 		for (ref = *refs; ref; ref = ref->next) {
-			struct object *o = deref_tag(lookup_object(ref->old_oid.hash),
+			struct object *o = deref_tag(lookup_object(the_repository,
+						     ref->old_oid.hash),
 						     NULL, 0);
 
 			if (!o || o->type != OBJ_COMMIT || !(o->flags & COMPLETE))
@@ -821,7 +822,7 @@ static int everything_local(struct fetch_pack_args *args,
 		const struct object_id *remote = &ref->old_oid;
 		struct object *o;
 
-		o = lookup_object(remote->hash);
+		o = lookup_object(the_repository, remote->hash);
 		if (!o || !(o->flags & COMPLETE)) {
 			retval = 0;
 			print_verbose(args, "want %s (%s)", oid_to_hex(remote),
@@ -1120,7 +1121,7 @@ static void add_wants(const struct ref *wants, struct strbuf *req_buf)
 		 * interested in the case we *know* the object is
 		 * reachable and we have already scanned it.
 		 */
-		if (((o = lookup_object(remote->hash)) != NULL) &&
+		if (((o = lookup_object(the_repository, remote->hash)) != NULL) &&
 		    (o->flags & COMPLETE)) {
 			continue;
 		}
@@ -1317,7 +1318,7 @@ static void receive_shallow_info(struct fetch_pack_args *args,
 		if (skip_prefix(reader->line, "unshallow ", &arg)) {
 			if (get_oid_hex(arg, &oid))
 				die(_("invalid unshallow line: %s"), reader->line);
-			if (!lookup_object(oid.hash))
+			if (!lookup_object(the_repository, oid.hash))
 				die(_("object not found: %s"), reader->line);
 			/* make sure that it is parsed as shallow */
 			if (!parse_object(the_repository, &oid))
diff --git a/http-push.c b/http-push.c
index 37cbf0769ba..d2245cc7380 100644
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
index bf1d9c6b5ff..002ebb69e3b 100644
--- a/object.c
+++ b/object.c
@@ -84,7 +84,7 @@ static void insert_obj_hash(struct object *obj, struct object **hash, unsigned i
  * Look up the record for the given sha1 in the hash map stored in
  * obj_hash.  Return NULL if it was not found.
  */
-struct object *lookup_object(const unsigned char *sha1)
+struct object *lookup_object_the_repository(const unsigned char *sha1)
 {
 	unsigned int i, first;
 	struct object *obj;
@@ -179,7 +179,7 @@ void *object_as_type(struct object *obj, enum object_type type, int quiet)
 
 struct object *lookup_unknown_object(const unsigned char *sha1)
 {
-	struct object *obj = lookup_object(sha1);
+	struct object *obj = lookup_object(the_repository, sha1);
 	if (!obj)
 		obj = create_object(the_repository, sha1,
 				    alloc_object_node(the_repository));
@@ -255,7 +255,7 @@ struct object *parse_object_the_repository(const struct object_id *oid)
 	void *buffer;
 	struct object *obj;
 
-	obj = lookup_object(oid->hash);
+	obj = lookup_object(the_repository, oid->hash);
 	if (obj && obj->parsed)
 		return obj;
 
@@ -267,7 +267,7 @@ struct object *parse_object_the_repository(const struct object_id *oid)
 			return NULL;
 		}
 		parse_blob_buffer(lookup_blob(oid), NULL, 0);
-		return lookup_object(oid->hash);
+		return lookup_object(the_repository, oid->hash);
 	}
 
 	buffer = read_object_file(oid, &type, &size);
diff --git a/object.h b/object.h
index 882f47fbc89..f840a428859 100644
--- a/object.h
+++ b/object.h
@@ -109,7 +109,8 @@ extern struct object *get_indexed_object(unsigned int);
  * half-initialised objects, the caller is expected to initialize them
  * by calling parse_object() on them.
  */
-struct object *lookup_object(const unsigned char *sha1);
+#define lookup_object(r, s) lookup_object_##r(s)
+struct object *lookup_object_the_repository(const unsigned char *sha1);
 
 extern void *create_object(struct repository *r, const unsigned char *sha1, void *obj);
 
diff --git a/reachable.c b/reachable.c
index ffb976c33c6..2ee55695595 100644
--- a/reachable.c
+++ b/reachable.c
@@ -108,7 +108,7 @@ static int add_recent_loose(const struct object_id *oid,
 			    const char *path, void *data)
 {
 	struct stat st;
-	struct object *obj = lookup_object(oid->hash);
+	struct object *obj = lookup_object(the_repository, oid->hash);
 
 	if (obj && obj->flags & SEEN)
 		return 0;
@@ -133,7 +133,7 @@ static int add_recent_packed(const struct object_id *oid,
 			     struct packed_git *p, uint32_t pos,
 			     void *data)
 {
-	struct object *obj = lookup_object(oid->hash);
+	struct object *obj = lookup_object(the_repository, oid->hash);
 
 	if (obj && obj->flags & SEEN)
 		return 0;
diff --git a/tag.c b/tag.c
index 7d282df0697..1b95eb9f07f 100644
--- a/tag.c
+++ b/tag.c
@@ -94,7 +94,7 @@ struct object *deref_tag_noverify(struct object *o)
 
 struct tag *lookup_tag(const struct object_id *oid)
 {
-	struct object *obj = lookup_object(oid->hash);
+	struct object *obj = lookup_object(the_repository, oid->hash);
 	if (!obj)
 		return create_object(the_repository, oid->hash,
 				     alloc_tag_node(the_repository));
diff --git a/tree.c b/tree.c
index 533b6e69755..73e8a8a948d 100644
--- a/tree.c
+++ b/tree.c
@@ -197,7 +197,7 @@ int read_tree(struct tree *tree, int stage, struct pathspec *match,
 
 struct tree *lookup_tree(const struct object_id *oid)
 {
-	struct object *obj = lookup_object(oid->hash);
+	struct object *obj = lookup_object(the_repository, oid->hash);
 	if (!obj)
 		return create_object(the_repository, oid->hash,
 				     alloc_tree_node(the_repository));
diff --git a/upload-pack.c b/upload-pack.c
index d2b85112d08..45e3a94788f 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -570,7 +570,7 @@ static int get_reachable_list(struct object_array *src,
 		if (parse_oid_hex(namebuf, &sha1, &p) || *p != '\n')
 			break;
 
-		o = lookup_object(sha1.hash);
+		o = lookup_object(the_repository, sha1.hash);
 		if (o && o->type == OBJ_COMMIT) {
 			o->flags &= ~TMP_MARK;
 		}
-- 
2.18.0.399.gad0ab374a1-goog

