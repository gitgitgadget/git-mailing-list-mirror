From: Jason McMullan <jason.mcmullan@timesys.com>
Subject: [PATCH] Anal retentive 'const unsigned char *sha1'
Date: Fri, 3 Jun 2005 11:05:39 -0400
Message-ID: <20050603150539.GA3239@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jun 03 17:06:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeDiR-0008KF-CF
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 17:04:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVFCPGs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 11:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbVFCPGs
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 11:06:48 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:27052 "EHLO
	timesys.com") by vger.kernel.org with ESMTP id S261315AbVFCPFk
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Jun 2005 11:05:40 -0400
Received: by timesys.com (Postfix, from userid 623)
	id DBA0916E0B; Fri,  3 Jun 2005 11:05:39 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Anal Retentive: make 'sha1' parameters const where possible

Signed-off-by: Jason McMullan <jason.mcmullan@timesys.com>

diff --git a/blob.c b/blob.c
--- a/blob.c
+++ b/blob.c
@@ -4,7 +4,7 @@
 
 const char *blob_type = "blob";
 
-struct blob *lookup_blob(unsigned char *sha1)
+struct blob *lookup_blob(const unsigned char *sha1)
 {
 	struct object *obj = lookup_object(sha1);
 	if (!obj) {
diff --git a/blob.h b/blob.h
--- a/blob.h
+++ b/blob.h
@@ -9,7 +9,7 @@ struct blob {
 	struct object object;
 };
 
-struct blob *lookup_blob(unsigned char *sha1);
+struct blob *lookup_blob(const unsigned char *sha1);
 
 int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size);
 
diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -157,7 +157,7 @@ extern void * unpack_sha1_file(void *map
 extern void * read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size);
 extern int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
 
-extern int check_sha1_signature(unsigned char *sha1, void *buf, unsigned long size, const char *type);
+extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned long size, const char *type);
 
 /* Read a tree into the cache */
 extern int read_tree(void *buffer, unsigned long size, int stage);
diff --git a/commit.c b/commit.c
--- a/commit.c
+++ b/commit.c
@@ -4,7 +4,7 @@
 
 const char *commit_type = "commit";
 
-static struct commit *check_commit(struct object *obj, unsigned char *sha1)
+static struct commit *check_commit(struct object *obj, const unsigned char *sha1)
 {
 	if (obj->type != commit_type) {
 		error("Object %s is a %s, not a commit", 
@@ -14,7 +14,7 @@ static struct commit *check_commit(struc
 	return (struct commit *) obj;
 }
 
-struct commit *lookup_commit_reference(unsigned char *sha1)
+struct commit *lookup_commit_reference(const unsigned char *sha1)
 {
 	struct object *obj = parse_object(sha1);
 
@@ -25,7 +25,7 @@ struct commit *lookup_commit_reference(u
 	return check_commit(obj, sha1);
 }
 
-struct commit *lookup_commit(unsigned char *sha1)
+struct commit *lookup_commit(const unsigned char *sha1)
 {
 	struct object *obj = lookup_object(sha1);
 	if (!obj) {
diff --git a/commit.h b/commit.h
--- a/commit.h
+++ b/commit.h
@@ -19,8 +19,8 @@ struct commit {
 
 extern const char *commit_type;
 
-struct commit *lookup_commit(unsigned char *sha1);
-struct commit *lookup_commit_reference(unsigned char *sha1);
+struct commit *lookup_commit(const unsigned char *sha1);
+struct commit *lookup_commit_reference(const unsigned char *sha1);
 
 int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size);
 
diff --git a/delta.c b/delta.c
--- a/delta.c
+++ b/delta.c
@@ -17,7 +17,7 @@ struct delta {
 	} u;
 };
 
-struct delta *lookup_delta(unsigned char *sha1)
+struct delta *lookup_delta(const unsigned char *sha1)
 {
 	struct object *obj = lookup_object(sha1);
 	if (!obj) {
diff --git a/delta.h b/delta.h
--- a/delta.h
+++ b/delta.h
@@ -12,7 +12,7 @@ extern void *patch_delta(void *src_buf, 
 /* handling of delta objects */
 struct delta;
 struct object_list;
-extern struct delta *lookup_delta(unsigned char *sha1);
+extern struct delta *lookup_delta(const unsigned char *sha1);
 extern int parse_delta_buffer(struct delta *item, void *buffer, unsigned long size);
 extern int parse_delta(struct delta *item, unsigned char sha1);
 extern int process_deltas(void *src, unsigned long src_size,
diff --git a/object.c b/object.c
--- a/object.c
+++ b/object.c
@@ -10,7 +10,7 @@ struct object **objs;
 int nr_objs;
 static int obj_allocs;
 
-static int find_object(unsigned char *sha1)
+static int find_object(const unsigned char *sha1)
 {
 	int first = 0, last = nr_objs;
 
@@ -31,7 +31,7 @@ static int find_object(unsigned char *sh
         return -first-1;
 }
 
-struct object *lookup_object(unsigned char *sha1)
+struct object *lookup_object(const unsigned char *sha1)
 {
 	int pos = find_object(sha1);
 	if (pos >= 0)
@@ -39,7 +39,7 @@ struct object *lookup_object(unsigned ch
 	return NULL;
 }
 
-void created_object(unsigned char *sha1, struct object *obj)
+void created_object(const unsigned char *sha1, struct object *obj)
 {
 	int pos = find_object(sha1);
 
@@ -98,7 +98,7 @@ void mark_reachable(struct object *obj, 
 	}
 }
 
-struct object *parse_object(unsigned char *sha1)
+struct object *parse_object(const unsigned char *sha1)
 {
 	unsigned long mapsize;
 	void *map = map_sha1_file(sha1, &mapsize);
diff --git a/object.h b/object.h
--- a/object.h
+++ b/object.h
@@ -20,12 +20,12 @@ struct object {
 extern int nr_objs;
 extern struct object **objs;
 
-struct object *lookup_object(unsigned char *sha1);
+struct object *lookup_object(const unsigned char *sha1);
 
-void created_object(unsigned char *sha1, struct object *obj);
+void created_object(const unsigned char *sha1, struct object *obj);
 
 /** Returns the object, having parsed it to find out what it is. **/
-struct object *parse_object(unsigned char *sha1);
+struct object *parse_object(const unsigned char *sha1);
 
 void add_ref(struct object *refer, struct object *target);
 
diff --git a/sha1_file.c b/sha1_file.c
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -257,7 +257,7 @@ static char *find_sha1_file(const unsign
 	return NULL;
 }
 
-int check_sha1_signature(unsigned char *sha1, void *map, unsigned long size, const char *type)
+int check_sha1_signature(const unsigned char *sha1, void *map, unsigned long size, const char *type)
 {
 	char header[100];
 	unsigned char real_sha1[20];
diff --git a/tag.c b/tag.c
--- a/tag.c
+++ b/tag.c
@@ -3,7 +3,7 @@
 
 const char *tag_type = "tag";
 
-struct tag *lookup_tag(unsigned char *sha1)
+struct tag *lookup_tag(const unsigned char *sha1)
 {
         struct object *obj = lookup_object(sha1);
         if (!obj) {
diff --git a/tag.h b/tag.h
--- a/tag.h
+++ b/tag.h
@@ -12,7 +12,7 @@ struct tag {
 	char *signature; /* not actually implemented */
 };
 
-extern struct tag *lookup_tag(unsigned char *sha1);
+extern struct tag *lookup_tag(const unsigned char *sha1);
 extern int parse_tag_buffer(struct tag *item, void *data, unsigned long size);
 extern int parse_tag(struct tag *item);
 
diff --git a/tree.c b/tree.c
--- a/tree.c
+++ b/tree.c
@@ -73,7 +73,7 @@ int read_tree(void *buffer, unsigned lon
 	return read_tree_recursive(buffer, size, "", 0, stage);
 }
 
-struct tree *lookup_tree(unsigned char *sha1)
+struct tree *lookup_tree(const unsigned char *sha1)
 {
 	struct object *obj = lookup_object(sha1);
 	if (!obj) {
diff --git a/tree.h b/tree.h
--- a/tree.h
+++ b/tree.h
@@ -24,7 +24,7 @@ struct tree {
 	struct tree_entry_list *entries;
 };
 
-struct tree *lookup_tree(unsigned char *sha1);
+struct tree *lookup_tree(const unsigned char *sha1);
 
 int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size);
 
======== end ========

-- 
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation
