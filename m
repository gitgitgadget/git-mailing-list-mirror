From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 4/6] Convert struct name_entry to use struct object_id.
Date: Sun, 17 Apr 2016 23:10:39 +0000
Message-ID: <1460934641-435791-5-git-send-email-sandals@crustytoothpaste.net>
References: <1460934641-435791-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 04:20:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arynK-00049B-AI
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 04:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbcDRCUE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Apr 2016 22:20:04 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:52834 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751226AbcDRCT5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2016 22:19:57 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E91BB282AF;
	Sun, 17 Apr 2016 23:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1460934675;
	bh=JPDbxKlOy1i0w8xi+02R24G9gYwHdgSS2C13GIh/OQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JPbTGOkA3i3cmNULZhgtUcIoeud7lToEXtuvBwebGXIov5t5oluYXYNFIwiVr7Jn3
	 s3vfgydF78qgANisxsTtV8YmXq/JYawKgDQaCjD4qiKX5JtDGnfF96/MR/1rf7BoqV
	 dnXQmHZLocCxJopyKS5tnwiHi8CQz8HPETY1SorrAjQiE9DIZqlIusg32aFupulErd
	 1k4RCILyGE/9t3yMpK07kN/O9NSfcnQKu+3WVt42pKGiPAyeo9YiD6KZW4YUgrLa8t
	 2L4kzCKj5tpmEvB0q0/JraJdZbFz4YmVccmGFlRKvKX/TEEysVOeyG6sI/54Y5z8CB
	 w9hMQVvgGLG1bD9bRsX0sTlCRsSX0HTQDlwkYSeXtk9IR06K7C9VWChe9oFlMim3Nr
	 Kx9JjQhRStfjMgqZrKNjpJKa+h4eAKKVFBOa2BkakMwDKaSJdzQVpvdvp2p3aTcWw1
	 V8TjaZkeaCdoGUMnneMASqijX2o5+rJC3qeoSISMRjn4NioHQIg
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1460934641-435791-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291788>

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/grep.c         |  6 +++---
 builtin/merge-tree.c   | 18 +++++++++---------
 builtin/pack-objects.c |  4 ++--
 builtin/reflog.c       |  4 ++--
 cache-tree.c           |  4 ++--
 fsck.c                 |  4 ++--
 http-push.c            |  4 ++--
 list-objects.c         |  6 +++---
 match-trees.c          |  2 +-
 notes.c                |  4 ++--
 revision.c             |  4 ++--
 tree-diff.c            |  6 +++---
 tree-walk.c            |  6 +++---
 tree-walk.h            |  6 +++---
 tree.c                 | 10 +++++-----
 unpack-trees.c         |  4 ++--
 walker.c               |  4 ++--
 17 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 111b6f6c..462e6079 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -438,7 +438,7 @@ static int grep_tree(struct grep_opt *opt, const st=
ruct pathspec *pathspec,
 		strbuf_add(base, entry.path, te_len);
=20
 		if (S_ISREG(entry.mode)) {
-			hit |=3D grep_sha1(opt, entry.sha1, base->buf, tn_len,
+			hit |=3D grep_sha1(opt, entry.oid->hash, base->buf, tn_len,
 					 check_attr ? base->buf + tn_len : NULL);
 		}
 		else if (S_ISDIR(entry.mode)) {
@@ -447,10 +447,10 @@ static int grep_tree(struct grep_opt *opt, const =
struct pathspec *pathspec,
 			void *data;
 			unsigned long size;
=20
-			data =3D lock_and_read_sha1_file(entry.sha1, &type, &size);
+			data =3D lock_and_read_sha1_file(entry.oid->hash, &type, &size);
 			if (!data)
 				die(_("unable to read tree (%s)"),
-				    sha1_to_hex(entry.sha1));
+				    oid_to_hex(entry.oid));
=20
 			strbuf_addch(base, '/');
 			init_tree_desc(&sub, data, size);
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index ca570041..81cced50 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -150,15 +150,15 @@ static void show_result(void)
 /* An empty entry never compares same, not even to another empty entry=
 */
 static int same_entry(struct name_entry *a, struct name_entry *b)
 {
-	return	a->sha1 &&
-		b->sha1 &&
-		!hashcmp(a->sha1, b->sha1) &&
+	return	a->oid &&
+		b->oid &&
+		!oidcmp(a->oid, b->oid) &&
 		a->mode =3D=3D b->mode;
 }
=20
 static int both_empty(struct name_entry *a, struct name_entry *b)
 {
-	return !(a->sha1 || b->sha1);
+	return !(a->oid || b->oid);
 }
=20
 static struct merge_list *create_entry(unsigned stage, unsigned mode, =
const unsigned char *sha1, const char *path)
@@ -188,8 +188,8 @@ static void resolve(const struct traverse_info *inf=
o, struct name_entry *ours, s
 		return;
=20
 	path =3D traverse_path(info, result);
-	orig =3D create_entry(2, ours->mode, ours->sha1, path);
-	final =3D create_entry(0, result->mode, result->sha1, path);
+	orig =3D create_entry(2, ours->mode, ours->oid->hash, path);
+	final =3D create_entry(0, result->mode, result->oid->hash, path);
=20
 	final->link =3D orig;
=20
@@ -213,7 +213,7 @@ static void unresolved_directory(const struct trave=
rse_info *info,
=20
 	newbase =3D traverse_path(info, p);
=20
-#define ENTRY_SHA1(e) (((e)->mode && S_ISDIR((e)->mode)) ? (e)->sha1 :=
 NULL)
+#define ENTRY_SHA1(e) (((e)->mode && S_ISDIR((e)->mode)) ? (e)->oid->h=
ash : NULL)
 	buf0 =3D fill_tree_descriptor(t+0, ENTRY_SHA1(n + 0));
 	buf1 =3D fill_tree_descriptor(t+1, ENTRY_SHA1(n + 1));
 	buf2 =3D fill_tree_descriptor(t+2, ENTRY_SHA1(n + 2));
@@ -239,7 +239,7 @@ static struct merge_list *link_entry(unsigned stage=
, const struct traverse_info
 		path =3D entry->path;
 	else
 		path =3D traverse_path(info, n);
-	link =3D create_entry(stage, n->mode, n->sha1, path);
+	link =3D create_entry(stage, n->mode, n->oid->hash, path);
 	link->link =3D entry;
 	return link;
 }
@@ -314,7 +314,7 @@ static int threeway_callback(int n, unsigned long m=
ask, unsigned long dirmask, s
 	}
=20
 	if (same_entry(entry+0, entry+1)) {
-		if (entry[2].sha1 && !S_ISDIR(entry[2].mode)) {
+		if (entry[2].oid->hash && !S_ISDIR(entry[2].mode)) {
 			/* We did not touch, they modified -- take theirs */
 			resolve(info, entry+1, entry+2);
 			return mask;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a27de5b3..d56b2c2d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1186,7 +1186,7 @@ static void add_pbase_object(struct tree_desc *tr=
ee,
 		if (cmp < 0)
 			return;
 		if (name[cmplen] !=3D '/') {
-			add_object_entry(entry.sha1,
+			add_object_entry(entry.oid->hash,
 					 object_type(entry.mode),
 					 fullname, 1);
 			return;
@@ -1197,7 +1197,7 @@ static void add_pbase_object(struct tree_desc *tr=
ee,
 			const char *down =3D name+cmplen+1;
 			int downlen =3D name_cmp_len(down);
=20
-			tree =3D pbase_tree_get(entry.sha1);
+			tree =3D pbase_tree_get(entry.oid->hash);
 			if (!tree)
 				return;
 			init_tree_desc(&sub, tree->tree_data, tree->tree_size);
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 2d46b648..7a7136e5 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -84,8 +84,8 @@ static int tree_is_complete(const unsigned char *sha1=
)
 	init_tree_desc(&desc, tree->buffer, tree->size);
 	complete =3D 1;
 	while (tree_entry(&desc, &entry)) {
-		if (!has_sha1_file(entry.sha1) ||
-		    (S_ISDIR(entry.mode) && !tree_is_complete(entry.sha1))) {
+		if (!has_sha1_file(entry.oid->hash) ||
+		    (S_ISDIR(entry.mode) && !tree_is_complete(entry.oid->hash))) {
 			tree->object.flags |=3D INCOMPLETE;
 			complete =3D 0;
 		}
diff --git a/cache-tree.c b/cache-tree.c
index 3ebf9c3a..ddf0cc9f 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -663,7 +663,7 @@ static void prime_cache_tree_rec(struct cache_tree =
*it, struct tree *tree)
 			cnt++;
 		else {
 			struct cache_tree_sub *sub;
-			struct tree *subtree =3D lookup_tree(entry.sha1);
+			struct tree *subtree =3D lookup_tree(entry.oid->hash);
 			if (!subtree->object.parsed)
 				parse_tree(subtree);
 			sub =3D cache_tree_sub(it, entry.path);
@@ -710,7 +710,7 @@ int cache_tree_matches_traversal(struct cache_tree =
*root,
=20
 	it =3D find_cache_tree_from_traversal(root, info);
 	it =3D cache_tree_find(it, ent->path);
-	if (it && it->entry_count > 0 && !hashcmp(ent->sha1, it->sha1))
+	if (it && it->entry_count > 0 && !hashcmp(ent->oid->hash, it->sha1))
 		return it->entry_count;
 	return 0;
 }
diff --git a/fsck.c b/fsck.c
index ca4c6853..606eba8c 100644
--- a/fsck.c
+++ b/fsck.c
@@ -312,9 +312,9 @@ static int fsck_walk_tree(struct tree *tree, void *=
data, struct fsck_options *op
 		if (S_ISGITLINK(entry.mode))
 			continue;
 		if (S_ISDIR(entry.mode))
-			result =3D options->walk(&lookup_tree(entry.sha1)->object, OBJ_TREE=
, data, options);
+			result =3D options->walk(&lookup_tree(entry.oid->hash)->object, OBJ=
_TREE, data, options);
 		else if (S_ISREG(entry.mode) || S_ISLNK(entry.mode))
-			result =3D options->walk(&lookup_blob(entry.sha1)->object, OBJ_BLOB=
, data, options);
+			result =3D options->walk(&lookup_blob(entry.oid->hash)->object, OBJ=
_BLOB, data, options);
 		else {
 			result =3D error("in tree %s: entry %s has bad mode %.6o",
 					oid_to_hex(&tree->object.oid), entry.path, entry.mode);
diff --git a/http-push.c b/http-push.c
index bd606687..ded0b742 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1312,10 +1312,10 @@ static struct object_list **process_tree(struct=
 tree *tree,
 	while (tree_entry(&desc, &entry))
 		switch (object_type(entry.mode)) {
 		case OBJ_TREE:
-			p =3D process_tree(lookup_tree(entry.sha1), p);
+			p =3D process_tree(lookup_tree(entry.oid->hash), p);
 			break;
 		case OBJ_BLOB:
-			p =3D process_blob(lookup_blob(entry.sha1), p);
+			p =3D process_blob(lookup_blob(entry.oid->hash), p);
 			break;
 		default:
 			/* Subproject commit - not in this repository */
diff --git a/list-objects.c b/list-objects.c
index 917cc5d7..f3ca6aaf 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -110,16 +110,16 @@ static void process_tree(struct rev_info *revs,
=20
 		if (S_ISDIR(entry.mode))
 			process_tree(revs,
-				     lookup_tree(entry.sha1),
+				     lookup_tree(entry.oid->hash),
 				     show, base, entry.path,
 				     cb_data);
 		else if (S_ISGITLINK(entry.mode))
-			process_gitlink(revs, entry.sha1,
+			process_gitlink(revs, entry.oid->hash,
 					show, base, entry.path,
 					cb_data);
 		else
 			process_blob(revs,
-				     lookup_blob(entry.sha1),
+				     lookup_blob(entry.oid->hash),
 				     show, base, entry.path,
 				     cb_data);
 	}
diff --git a/match-trees.c b/match-trees.c
index 9977752a..751f8f20 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -104,7 +104,7 @@ static int score_trees(const unsigned char *hash1, =
const unsigned char *hash2)
 		else if (cmp > 0)
 			/* path2 does not appear in one */
 			score +=3D score_missing(e2.mode, e2.path);
-		else if (hashcmp(e1.sha1, e2.sha1))
+		else if (oidcmp(e1.oid, e2.oid))
 			/* they are different */
 			score +=3D score_differs(e1.mode, e2.mode, e1.path);
 		else
diff --git a/notes.c b/notes.c
index 88cf4747..e4e4854d 100644
--- a/notes.c
+++ b/notes.c
@@ -446,7 +446,7 @@ static void load_subtree(struct notes_tree *t, stru=
ct leaf_node *subtree,
 			l =3D (struct leaf_node *)
 				xcalloc(1, sizeof(struct leaf_node));
 			hashcpy(l->key_sha1, object_sha1);
-			hashcpy(l->val_sha1, entry.sha1);
+			hashcpy(l->val_sha1, entry.oid->hash);
 			if (len < 20) {
 				if (!S_ISDIR(entry.mode) || path_len !=3D 2)
 					goto handle_non_note; /* not subtree */
@@ -493,7 +493,7 @@ handle_non_note:
 			}
 			strbuf_addstr(&non_note_path, entry.path);
 			add_non_note(t, strbuf_detach(&non_note_path, NULL),
-				     entry.mode, entry.sha1);
+				     entry.mode, entry.oid->hash);
 		}
 	}
 	free(buf);
diff --git a/revision.c b/revision.c
index b683476b..d30d1c4f 100644
--- a/revision.c
+++ b/revision.c
@@ -59,10 +59,10 @@ static void mark_tree_contents_uninteresting(struct=
 tree *tree)
 	while (tree_entry(&desc, &entry)) {
 		switch (object_type(entry.mode)) {
 		case OBJ_TREE:
-			mark_tree_uninteresting(lookup_tree(entry.sha1));
+			mark_tree_uninteresting(lookup_tree(entry.oid->hash));
 			break;
 		case OBJ_BLOB:
-			mark_blob_uninteresting(lookup_blob(entry.sha1));
+			mark_blob_uninteresting(lookup_blob(entry.oid->hash));
 			break;
 		default:
 			/* Subproject commit - not in this repository */
diff --git a/tree-diff.c b/tree-diff.c
index 4dda9a14..402f9ff2 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -229,7 +229,7 @@ static struct combine_diff_path *emit_path(struct c=
ombine_diff_path *p,
 						DIFF_STATUS_ADDED;
=20
 			if (tpi_valid) {
-				sha1_i =3D tp[i].entry.sha1;
+				sha1_i =3D tp[i].entry.oid->hash;
 				mode_i =3D tp[i].entry.mode;
 			}
 			else {
@@ -270,7 +270,7 @@ static struct combine_diff_path *emit_path(struct c=
ombine_diff_path *p,
 			/* same rule as in emitthis */
 			int tpi_valid =3D tp && !(tp[i].entry.mode & S_IFXMIN_NEQ);
=20
-			parents_sha1[i] =3D tpi_valid ? tp[i].entry.sha1
+			parents_sha1[i] =3D tpi_valid ? tp[i].entry.oid->hash
 						    : NULL;
 		}
=20
@@ -482,7 +482,7 @@ static struct combine_diff_path *ll_diff_tree_paths=
(
 						continue;
=20
 					/* diff(t,pi) !=3D =C3=B8 */
-					if (hashcmp(t.entry.sha1, tp[i].entry.sha1) ||
+					if (oidcmp(t.entry.oid, tp[i].entry.oid) ||
 					    (t.entry.mode !=3D tp[i].entry.mode))
 						continue;
=20
diff --git a/tree-walk.c b/tree-walk.c
index cd4bb2c3..fab57dd5 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -38,7 +38,7 @@ static void decode_tree_entry(struct tree_desc *desc,=
 const char *buf, unsigned
 	/* Initialize the descriptor entry */
 	desc->entry.path =3D path;
 	desc->entry.mode =3D canon_mode(mode);
-	desc->entry.sha1 =3D (const unsigned char *)(path + len);
+	desc->entry.oid  =3D (const struct object_id *)(path + len);
 }
=20
 void init_tree_desc(struct tree_desc *desc, const void *buffer, unsign=
ed long size)
@@ -76,7 +76,7 @@ static void entry_extract(struct tree_desc *t, struct=
 name_entry *a)
 void update_tree_entry(struct tree_desc *desc)
 {
 	const void *buf =3D desc->buffer;
-	const unsigned char *end =3D desc->entry.sha1 + 20;
+	const unsigned char *end =3D desc->entry.oid->hash + 20;
 	unsigned long size =3D desc->size;
 	unsigned long len =3D end - (const unsigned char *)buf;
=20
@@ -110,7 +110,7 @@ void setup_traverse_info(struct traverse_info *info=
, const char *base)
 		pathlen--;
 	info->pathlen =3D pathlen ? pathlen + 1 : 0;
 	info->name.path =3D base;
-	info->name.sha1 =3D (void *)(base + pathlen + 1);
+	info->name.oid =3D (void *)(base + pathlen + 1);
 	if (pathlen)
 		info->prev =3D &dummy;
 }
diff --git a/tree-walk.h b/tree-walk.h
index 174eb617..58f31f55 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -2,7 +2,7 @@
 #define TREE_WALK_H
=20
 struct name_entry {
-	const unsigned char *sha1;
+	const struct object_id *oid;
 	const char *path;
 	unsigned int mode;
 };
@@ -17,12 +17,12 @@ static inline const unsigned char *tree_entry_extra=
ct(struct tree_desc *desc, co
 {
 	*pathp =3D desc->entry.path;
 	*modep =3D desc->entry.mode;
-	return desc->entry.sha1;
+	return desc->entry.oid->hash;
 }
=20
 static inline int tree_entry_len(const struct name_entry *ne)
 {
-	return (const char *)ne->sha1 - ne->path - 1;
+	return (const char *)ne->oid - ne->path - 1;
 }
=20
 void update_tree_entry(struct tree_desc *);
diff --git a/tree.c b/tree.c
index f79ff981..0089e52d 100644
--- a/tree.c
+++ b/tree.c
@@ -76,7 +76,7 @@ static int read_tree_1(struct tree *tree, struct strb=
uf *base,
 				continue;
 		}
=20
-		switch (fn(entry.sha1, base,
+		switch (fn(entry.oid->hash, base,
 			   entry.path, entry.mode, stage, context)) {
 		case 0:
 			continue;
@@ -87,19 +87,19 @@ static int read_tree_1(struct tree *tree, struct st=
rbuf *base,
 		}
=20
 		if (S_ISDIR(entry.mode))
-			hashcpy(sha1, entry.sha1);
+			hashcpy(sha1, entry.oid->hash);
 		else if (S_ISGITLINK(entry.mode)) {
 			struct commit *commit;
=20
-			commit =3D lookup_commit(entry.sha1);
+			commit =3D lookup_commit(entry.oid->hash);
 			if (!commit)
 				die("Commit %s in submodule path %s%s not found",
-				    sha1_to_hex(entry.sha1),
+				    oid_to_hex(entry.oid),
 				    base->buf, entry.path);
=20
 			if (parse_commit(commit))
 				die("Invalid commit %s in submodule path %s%s",
-				    sha1_to_hex(entry.sha1),
+				    oid_to_hex(entry.oid),
 				    base->buf, entry.path);
=20
 			hashcpy(sha1, commit->tree->object.oid.hash);
diff --git a/unpack-trees.c b/unpack-trees.c
index 9f55cc28..11308e9e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -475,7 +475,7 @@ static int traverse_trees_recursive(int n, unsigned=
 long dirmask,
 	for (i =3D 0; i < n; i++, dirmask >>=3D 1) {
 		const unsigned char *sha1 =3D NULL;
 		if (dirmask & 1)
-			sha1 =3D names[i].sha1;
+			sha1 =3D names[i].oid->hash;
 		buf[i] =3D fill_tree_descriptor(t+i, sha1);
 	}
=20
@@ -591,7 +591,7 @@ static struct cache_entry *create_ce_entry(const st=
ruct traverse_info *info, con
 	ce->ce_mode =3D create_ce_mode(n->mode);
 	ce->ce_flags =3D create_ce_flags(stage);
 	ce->ce_namelen =3D len;
-	hashcpy(ce->sha1, n->sha1);
+	hashcpy(ce->sha1, n->oid->hash);
 	make_traverse_path(ce->name, info, n);
=20
 	return ce;
diff --git a/walker.c b/walker.c
index 08773d41..d95b0072 100644
--- a/walker.c
+++ b/walker.c
@@ -43,12 +43,12 @@ static int process_tree(struct walker *walker, stru=
ct tree *tree)
 		if (S_ISGITLINK(entry.mode))
 			continue;
 		if (S_ISDIR(entry.mode)) {
-			struct tree *tree =3D lookup_tree(entry.sha1);
+			struct tree *tree =3D lookup_tree(entry.oid->hash);
 			if (tree)
 				obj =3D &tree->object;
 		}
 		else {
-			struct blob *blob =3D lookup_blob(entry.sha1);
+			struct blob *blob =3D lookup_blob(entry.oid->hash);
 			if (blob)
 				obj =3D &blob->object;
 		}
--=20
2.8.0.rc3.226.g39d4020
