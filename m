From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 3/4] add mode to add_pending_object
Date: Sat, 21 Apr 2007 14:26:19 +0200
Message-ID: <11771583803353-git-send-email-mkoegler@auto.tuwien.ac.at>
References: 20070421122348.GA29174@auto.tuwien.ac.at <1177158380197-git-send-email-mkoegler@auto.tuwien.ac.at> <11771583802243-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 21 14:26:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfEfj-0000Vy-Om
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 14:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030802AbXDUM03 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 08:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030864AbXDUM03
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 08:26:29 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:37254 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030802AbXDUM0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 08:26:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 0D07473EA3C3;
	Sat, 21 Apr 2007 14:26:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oaPsdpcxSU5E; Sat, 21 Apr 2007 14:26:22 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 7F25C73EA3C0; Sat, 21 Apr 2007 14:26:20 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
In-Reply-To: <11771583802243-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45172>

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 builtin-blame.c         |    2 +-
 builtin-bundle.c        |    4 ++--
 builtin-diff.c          |    2 +-
 builtin-fmt-merge-msg.c |    4 ++--
 builtin-log.c           |    6 +++---
 reachable.c             |    8 ++++----
 revision.c              |   38 ++++++++++++++++++++------------------
 revision.h              |    2 +-
 upload-pack.c           |    4 ++--
 9 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 7777748..5491dd2 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2274,7 +2274,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		 * or "--contents".
 		 */
 		sb.final = fake_working_tree_commit(path, contents_from);
-		add_pending_object(&revs, &(sb.final->object), ":");
+		add_pending_object(&revs, &(sb.final->object), ":", S_IFINVALID);
 	}
 	else if (contents_from)
 		die("Cannot use --contents with final commit object name");
diff --git a/builtin-bundle.c b/builtin-bundle.c
index 97cce9e..80a1a3f 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -140,7 +140,7 @@ static int verify_bundle(struct bundle_header *header, int verbose)
 		struct object *o = parse_object(e->sha1);
 		if (o) {
 			o->flags |= PREREQ_MARK;
-			add_pending_object(&revs, o, e->name);
+			add_pending_object(&revs, o, e->name, S_IFINVALID);
 			continue;
 		}
 		if (++ret == 1)
@@ -238,7 +238,7 @@ static int create_bundle(struct bundle_header *header, const char *path,
 			if (!get_sha1_hex(buffer + 1, sha1)) {
 				struct object *object = parse_object(sha1);
 				object->flags |= UNINTERESTING;
-				add_pending_object(&revs, object, buffer);
+				add_pending_object(&revs, object, buffer, S_IFINVALID);
 			}
 		} else if (!get_sha1_hex(buffer, sha1)) {
 			struct object *object = parse_object(sha1);
diff --git a/builtin-diff.c b/builtin-diff.c
index 5f1b50e..a427358 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -178,7 +178,7 @@ void add_head(struct rev_info *revs)
 	obj = parse_object(sha1);
 	if (!obj)
 		return;
-	add_pending_object(revs, obj, "HEAD");
+	add_pending_object(revs, obj, "HEAD", S_IFINVALID);
 }
 
 int cmd_diff(int argc, const char **argv, const char *prefix)
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index 89224c2..127263a 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -186,8 +186,8 @@ static void shortlog(const char *name, unsigned char *sha1,
 
 	setup_revisions(0, NULL, rev, NULL);
 	rev->ignore_merges = 1;
-	add_pending_object(rev, branch, name);
-	add_pending_object(rev, &head->object, "^HEAD");
+	add_pending_object(rev, branch, name, S_IFINVALID);
+	add_pending_object(rev, &head->object, "^HEAD", S_IFINVALID);
 	head->object.flags |= UNINTERESTING;
 	prepare_revision_walk(rev);
 	while ((commit = get_revision(rev)) != NULL) {
diff --git a/builtin-log.c b/builtin-log.c
index ca12791..678ef6b 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -388,8 +388,8 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids, const cha
 	init_revisions(&check_rev, prefix);
 	o1->flags ^= UNINTERESTING;
 	o2->flags ^= UNINTERESTING;
-	add_pending_object(&check_rev, o1, "o1");
-	add_pending_object(&check_rev, o2, "o2");
+	add_pending_object(&check_rev, o1, "o1", S_IFINVALID);
+	add_pending_object(&check_rev, o2, "o2", S_IFINVALID);
 	prepare_revision_walk(&check_rev);
 
 	while ((commit = get_revision(&check_rev)) != NULL) {
@@ -652,7 +652,7 @@ static int add_pending_commit(const char *arg, struct rev_info *revs, int flags)
 		struct commit *commit = lookup_commit_reference(sha1);
 		if (commit) {
 			commit->object.flags |= flags;
-			add_pending_object(revs, &commit->object, arg);
+			add_pending_object(revs, &commit->object, arg, S_IFINVALID);
 			return 0;
 		}
 	}
diff --git a/reachable.c b/reachable.c
index ff3dd34..4edca75 100644
--- a/reachable.c
+++ b/reachable.c
@@ -112,10 +112,10 @@ static int add_one_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 
 	object = parse_object(osha1);
 	if (object)
-		add_pending_object(revs, object, "");
+		add_pending_object(revs, object, "", S_IFINVALID);
 	object = parse_object(nsha1);
 	if (object)
-		add_pending_object(revs, object, "");
+		add_pending_object(revs, object, "", S_IFINVALID);
 	return 0;
 }
 
@@ -126,7 +126,7 @@ static int add_one_ref(const char *path, const unsigned char *sha1, int flag, vo
 
 	if (!object)
 		die("bad object ref: %s:%s", path, sha1_to_hex(sha1));
-	add_pending_object(revs, object, "");
+	add_pending_object(revs, object, "", S_IFINVALID);
 
 	return 0;
 }
@@ -140,7 +140,7 @@ static int add_one_reflog(const char *path, const unsigned char *sha1, int flag,
 static void add_one_tree(const unsigned char *sha1, struct rev_info *revs)
 {
 	struct tree *tree = lookup_tree(sha1);
-	add_pending_object(revs, &tree->object, "");
+	add_pending_object(revs, &tree->object, "", S_IFINVALID);
 }
 
 static void add_cache_tree(struct cache_tree *it, struct rev_info *revs)
diff --git a/revision.c b/revision.c
index b2df974..4ff2e4e 100644
--- a/revision.c
+++ b/revision.c
@@ -114,11 +114,11 @@ void mark_parents_uninteresting(struct commit *commit)
 	}
 }
 
-void add_pending_object(struct rev_info *revs, struct object *obj, const char *name)
+void add_pending_object(struct rev_info *revs, struct object *obj, const char *name, unsigned mode)
 {
 	if (revs->no_walk && (obj->flags & UNINTERESTING))
 		die("object ranges do not make sense when not walking revisions");
-	add_object_array(obj, name, S_IFINVALID, &revs->pending);
+	add_object_array(obj, name, mode, &revs->pending);
 	if (revs->reflog_info && obj->type == OBJ_COMMIT)
 		add_reflog_for_walk(revs->reflog_info,
 				(struct commit *)obj, name);
@@ -145,7 +145,7 @@ static struct commit *handle_commit(struct rev_info *revs, struct object *object
 	while (object->type == OBJ_TAG) {
 		struct tag *tag = (struct tag *) object;
 		if (revs->tag_objects && !(flags & UNINTERESTING))
-			add_pending_object(revs, object, tag->tag);
+			add_pending_object(revs, object, tag->tag, S_IFINVALID);
 		object = parse_object(tag->tagged->sha1);
 		if (!object)
 			die("bad object %s", sha1_to_hex(tag->tagged->sha1));
@@ -179,7 +179,7 @@ static struct commit *handle_commit(struct rev_info *revs, struct object *object
 			mark_tree_uninteresting(tree);
 			return NULL;
 		}
-		add_pending_object(revs, object, "");
+		add_pending_object(revs, object, "", S_IFINVALID);
 		return NULL;
 	}
 
@@ -194,7 +194,7 @@ static struct commit *handle_commit(struct rev_info *revs, struct object *object
 			mark_blob_uninteresting(blob);
 			return NULL;
 		}
-		add_pending_object(revs, object, "");
+		add_pending_object(revs, object, "", S_IFINVALID);
 		return NULL;
 	}
 	die("%s is unknown object", name);
@@ -548,7 +548,7 @@ static int handle_one_ref(const char *path, const unsigned char *sha1, int flag,
 	struct all_refs_cb *cb = cb_data;
 	struct object *object = get_reference(cb->all_revs, path, sha1,
 					      cb->all_flags);
-	add_pending_object(cb->all_revs, object, path);
+	add_pending_object(cb->all_revs, object, path, S_IFINVALID);
 	return 0;
 }
 
@@ -567,7 +567,7 @@ static void handle_one_reflog_commit(unsigned char *sha1, void *cb_data)
 		struct object *o = parse_object(sha1);
 		if (o) {
 			o->flags |= cb->all_flags;
-			add_pending_object(cb->all_revs, o, "");
+			add_pending_object(cb->all_revs, o, "", S_IFINVALID);
 		}
 		else if (!cb->warned_bad_reflog) {
 			warning("reflog of '%s' references pruned commits",
@@ -628,7 +628,7 @@ static int add_parents_only(struct rev_info *revs, const char *arg, int flags)
 	for (parents = commit->parents; parents; parents = parents->next) {
 		it = &parents->item->object;
 		it->flags |= flags;
-		add_pending_object(revs, it, arg);
+		add_pending_object(revs, it, arg, S_IFINVALID);
 	}
 	return 1;
 }
@@ -671,7 +671,7 @@ static void add_pending_commit_list(struct rev_info *revs,
 	while (commit_list) {
 		struct object *object = &commit_list->item->object;
 		object->flags |= flags;
-		add_pending_object(revs, object, sha1_to_hex(object->sha1));
+		add_pending_object(revs, object, sha1_to_hex(object->sha1), S_IFINVALID);
 		commit_list = commit_list->next;
 	}
 }
@@ -688,8 +688,8 @@ static void prepare_show_merge(struct rev_info *revs)
 		die("--merge without HEAD?");
 	if (get_sha1("MERGE_HEAD", sha1, NULL) || !(other = lookup_commit(sha1)))
 		die("--merge without MERGE_HEAD?");
-	add_pending_object(revs, &head->object, "HEAD");
-	add_pending_object(revs, &other->object, "MERGE_HEAD");
+	add_pending_object(revs, &head->object, "HEAD", S_IFINVALID);
+	add_pending_object(revs, &other->object, "MERGE_HEAD", S_IFINVALID);
 	bases = get_merge_bases(head, other, 1);
 	while (bases) {
 		struct commit *it = bases->item;
@@ -697,7 +697,7 @@ static void prepare_show_merge(struct rev_info *revs)
 		free(bases);
 		bases = n;
 		it->object.flags |= UNINTERESTING;
-		add_pending_object(revs, &it->object, "(merge-base)");
+		add_pending_object(revs, &it->object, "(merge-base)", S_IFINVALID);
 	}
 
 	if (!active_nr)
@@ -727,6 +727,7 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 	struct object *object;
 	unsigned char sha1[20];
 	int local_flags;
+	unsigned mode;
 
 	dotdot = strstr(arg, "..");
 	if (dotdot) {
@@ -771,8 +772,8 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 			} else
 				a->object.flags |= flags_exclude;
 			b->object.flags |= flags;
-			add_pending_object(revs, &a->object, this);
-			add_pending_object(revs, &b->object, next);
+			add_pending_object(revs, &a->object, this, S_IFINVALID);
+			add_pending_object(revs, &b->object, next, S_IFINVALID);
 			return 0;
 		}
 		*dotdot = '.';
@@ -796,12 +797,12 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 		local_flags = UNINTERESTING;
 		arg++;
 	}
-	if (get_sha1(arg, sha1, NULL))
+	if (get_sha1(arg, sha1, &mode))
 		return -1;
 	if (!cant_be_filename)
 		verify_non_filename(revs->prefix, arg);
 	object = get_reference(revs, arg, sha1, flags ^ local_flags);
-	add_pending_object(revs, object, arg);
+	add_pending_object(revs, object, arg, mode);
 	return 0;
 }
 
@@ -1177,10 +1178,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 	if (def && !revs->pending.nr) {
 		unsigned char sha1[20];
 		struct object *object;
-		if (get_sha1(def, sha1, NULL))
+		unsigned mode;
+		if (get_sha1(def, sha1, &mode))
 			die("bad default revision '%s'", def);
 		object = get_reference(revs, def, sha1, 0);
-		add_pending_object(revs, object, def);
+		add_pending_object(revs, object, def, mode);
 	}
 
 	if (revs->topo_order)
diff --git a/revision.h b/revision.h
index 8a02618..c58ec75 100644
--- a/revision.h
+++ b/revision.h
@@ -130,6 +130,6 @@ extern void add_object(struct object *obj,
 		       struct name_path *path,
 		       const char *name);
 
-extern void add_pending_object(struct rev_info *revs, struct object *obj, const char *name);
+extern void add_pending_object(struct rev_info *revs, struct object *obj, const char *name, unsigned mode);
 
 #endif
diff --git a/upload-pack.c b/upload-pack.c
index 1f12d29..aefca5f 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -139,12 +139,12 @@ static void create_pack_file(void)
 				struct object *o = want_obj.objects[i].item;
 				/* why??? */
 				o->flags &= ~UNINTERESTING;
-				add_pending_object(&revs, o, NULL);
+				add_pending_object(&revs, o, NULL, S_IFINVALID);
 			}
 			for (i = 0; i < have_obj.nr; i++) {
 				struct object *o = have_obj.objects[i].item;
 				o->flags |= UNINTERESTING;
-				add_pending_object(&revs, o, NULL);
+				add_pending_object(&revs, o, NULL, S_IFINVALID);
 			}
 			setup_revisions(0, NULL, &revs, NULL);
 		}
-- 
1.4.4.4
