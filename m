Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1616C20195
	for <e@80x24.org>; Sun, 17 Jul 2016 11:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbcGQLAP (ORCPT <rfc822;e@80x24.org>);
	Sun, 17 Jul 2016 07:00:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:54278 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751117AbcGQLAN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2016 07:00:13 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LikQP-1aoJ3e3AZ3-00czLD; Sun, 17 Jul 2016 13:00:03
 +0200
Date:	Sun, 17 Jul 2016 13:00:02 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 4/4] fsck: optionally show more helpful info for broken
 links
In-Reply-To: <cover.1468752290.git.johannes.schindelin@gmx.de>
Message-ID: <83754a3f19a172af1e0ff014060a0c698f3d6678.1468752291.git.johannes.schindelin@gmx.de>
References: <cover.1468510191.git.johannes.schindelin@gmx.de> <cover.1468752290.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ceGWY5cDRZKv80KTU5iaEdtjO+pEkxnLE+gC4b/AjLyigyzX7Jl
 r2ZJea6lym8EAInLCitkWioTjX3LhKQijrsbH1RHcB7K4McK42+sZ+4avJ/x3rjcxM89Aka
 4rbb0FhSxx8AiKTI2MXncGUZKqV0WuGhHKt6EYM5/Ge4UynDlinj2SuRcvy5a5TSE8QZBCD
 gDa06Pe0hBcidJRCeQKWw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:KtEkCh3/2iU=:DFqQgBAEXog/vWnmg4u9PI
 b/VX9QR87tyeDOZ+8Rg6LVLwUNK7TaZGl5GqPimB/eY1NSK5P7yEjVrseYHgKLqioK+rrH+bX
 pEDVgeJ2+IwxQdc8YOqTcYEJJmx2VNd04d5PdMobyxuXx8T7cYgw1qLFDPvyDP4Dggnn8Nd+D
 X49mP08txvRlaCk4GLle6XiMPTUecuDTSyLU/8Vw+CAQGmMCnzNuv+06+g4I9QLApRkIeqmxv
 5Ld2UwsjENAgXWDGE9ZtbIKZK3NHnb/hCXi6POnSGemTvZ9ik6WPnJHeptgebioR46TarJ+2f
 r9/HGY47VvRjtofWZUXwDRxTKtu+ymCP+tB7/F7LVJHfZ0YPwBgvVc/OM0NFkAjFSpK5Np3+/
 TIXJpFRKFYniOCBe87YEvIpPcuenlvUL3soFynMzLjbHlCHlTWCLaBuB0odOHpK6no/4wxwvx
 wlz4vku6De+n88F9IQ1iI/zJ4caAF2xeilG+v1PQh9TsUN8Q1MrZ/3bV0ty4NYfaI73OBW0HM
 j4qnGCPoSrq3cKr5EWifz2NMoVTugwLro7iV7sPCF3XEYTGDfDAAnqFLdZf1dV79iLQ0AXqyF
 rj1DtOPX8H3Y7rD/noadxqpBL50MC07nOSeacGN9Oy+ac4vlPxdtFh+imUZU6pBHsEWdGmaNB
 XdNdAf+MQWuZt7g7NFZB843hzwOAK77LT8I3pRKu2vu3i/CujSNInozDyEwLAS+xdAVqsXBkR
 7SYKraon3lb5zwmqCcO21yDQYBhBCvLaoccmm+A+AkzigE2V0knvQew8v9Cp5Wx5anodxhkdb
 q2jQxs7
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When reporting broken links between commits/trees/blobs, it would be
quite helpful at times if the user would be told how the object is
supposed to be reachable.

With the new --name-objects option, git-fsck will try to do exactly
that: name the objects in a way that shows how they are reachable.

For example, when some reflog got corrupted and a blob is missing that
should not be, the user might want to remove the corresponding reflog
entry. This option helps them find that entry: `git fsck` will now
report something like this:

	broken link from    tree b5eb6ff...  (refs/stash@{<date>}~37:)
	              to    blob ec5cf80...

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-fsck.txt |  9 ++++++++-
 builtin/fsck.c             | 42 ++++++++++++++++++++++++++++++++++++++----
 fsck.c                     | 21 +++++++++++++++++----
 t/t1450-fsck.sh            | 22 ++++++++++++++++++++++
 4 files changed, 85 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index 7fc68eb..b9f060e 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -11,7 +11,8 @@ SYNOPSIS
 [verse]
 'git fsck' [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]
 	 [--[no-]full] [--strict] [--verbose] [--lost-found]
-	 [--[no-]dangling] [--[no-]progress] [--connectivity-only] [<object>*]
+	 [--[no-]dangling] [--[no-]progress] [--connectivity-only]
+	 [--[no-]name-objects] [<object>*]
 
 DESCRIPTION
 -----------
@@ -82,6 +83,12 @@ index file, all SHA-1 references in `refs` namespace, and all reflogs
 	a blob, the contents are written into the file, rather than
 	its object name.
 
+--name-objects::
+	When displaying names of reachable objects, in addition to the
+	SHA-1 also display a name that describes *how* they are reachable,
+	compatible with linkgit:git-rev-parse[1], e.g.
+	`HEAD@{1234567890}~25^2:src/`.
+
 --[no-]progress::
 	Progress status is reported on the standard error stream by
 	default when it is attached to a terminal, unless
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 6c9d598..49680e9 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -13,6 +13,7 @@
 #include "dir.h"
 #include "progress.h"
 #include "streaming.h"
+#include "decorate.h"
 
 #define REACHABLE 0x0001
 #define SEEN      0x0002
@@ -35,6 +36,7 @@ static int write_lost_and_found;
 static int verbose;
 static int show_progress = -1;
 static int show_dangling = 1;
+static int name_objects = 0;
 #define ERROR_OBJECT 01
 #define ERROR_REACHABLE 02
 #define ERROR_PACK 04
@@ -42,7 +44,16 @@ static int show_dangling = 1;
 
 static const char *describe_object(struct object *obj)
 {
-	return oid_to_hex(&obj->oid);
+	static struct strbuf buf = STRBUF_INIT;
+	char *name = name_objects ?
+		lookup_decoration(fsck_walk_options.object_names, obj) : NULL;
+
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, oid_to_hex(&obj->oid));
+	if (name)
+		strbuf_addf(&buf, " (%s)", name);
+
+	return buf.buf;
 }
 
 static int fsck_config(const char *var, const char *value, void *cb)
@@ -378,13 +389,18 @@ static int fsck_obj_buffer(const unsigned char *sha1, enum object_type type,
 
 static int default_refs;
 
-static void fsck_handle_reflog_sha1(const char *refname, unsigned char *sha1)
+static void fsck_handle_reflog_sha1(const char *refname, unsigned char *sha1,
+	unsigned long timestamp)
 {
 	struct object *obj;
 
 	if (!is_null_sha1(sha1)) {
 		obj = lookup_object(sha1);
 		if (obj) {
+			if (timestamp && name_objects)
+				add_decoration(fsck_walk_options.object_names,
+					obj,
+					xstrfmt("%s@{%ld}", refname, timestamp));
 			obj->used = 1;
 			mark_object_reachable(obj);
 		} else {
@@ -404,8 +420,8 @@ static int fsck_handle_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 		fprintf(stderr, "Checking reflog %s->%s\n",
 			sha1_to_hex(osha1), sha1_to_hex(nsha1));
 
-	fsck_handle_reflog_sha1(refname, osha1);
-	fsck_handle_reflog_sha1(refname, nsha1);
+	fsck_handle_reflog_sha1(refname, osha1, 0);
+	fsck_handle_reflog_sha1(refname, nsha1, timestamp);
 	return 0;
 }
 
@@ -434,6 +450,9 @@ static int fsck_handle_ref(const char *refname, const struct object_id *oid,
 	}
 	default_refs++;
 	obj->used = 1;
+	if (name_objects)
+		add_decoration(fsck_walk_options.object_names,
+			obj, xstrdup(refname));
 	mark_object_reachable(obj);
 
 	return 0;
@@ -549,6 +568,9 @@ static int fsck_cache_tree(struct cache_tree *it)
 			return 1;
 		}
 		obj->used = 1;
+		if (name_objects)
+			add_decoration(fsck_walk_options.object_names,
+				obj, xstrdup(":"));
 		mark_object_reachable(obj);
 		if (obj->type != OBJ_TREE)
 			err |= objerror(obj, "non-tree in cache-tree");
@@ -577,6 +599,7 @@ static struct option fsck_opts[] = {
 	OPT_BOOL(0, "lost-found", &write_lost_and_found,
 				N_("write dangling objects in .git/lost-found")),
 	OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
+	OPT_BOOL(0, "name-objects", &name_objects, N_("show verbose names for reachable objects")),
 	OPT_END(),
 };
 
@@ -606,6 +629,10 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		include_reflogs = 0;
 	}
 
+	if (name_objects)
+		fsck_walk_options.object_names =
+			xcalloc(1, sizeof(struct decoration));
+
 	git_config(fsck_config, NULL);
 
 	fsck_head_link();
@@ -661,6 +688,9 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 				continue;
 
 			obj->used = 1;
+			if (name_objects)
+				add_decoration(fsck_walk_options.object_names,
+					obj, xstrdup(arg));
 			mark_object_reachable(obj);
 			heads++;
 			continue;
@@ -693,6 +723,10 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 				continue;
 			obj = &blob->object;
 			obj->used = 1;
+			if (name_objects)
+				add_decoration(fsck_walk_options.object_names,
+					obj,
+					xstrfmt(":%s", active_cache[i]->name));
 			mark_object_reachable(obj);
 		}
 		if (active_cache_tree)
diff --git a/fsck.c b/fsck.c
index 828c5c6..c9cf3de 100644
--- a/fsck.c
+++ b/fsck.c
@@ -323,6 +323,19 @@ static void put_object_name(struct fsck_options *options, struct object *obj,
 	va_end(ap);
 }
 
+static const char *describe_object(struct fsck_options *o, struct object *obj)
+{
+	static struct strbuf buf = STRBUF_INIT;
+	char *name;
+
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, oid_to_hex(&obj->oid));
+	if (o->object_names && (name = lookup_decoration(o->object_names, obj)))
+		strbuf_addf(&buf, " (%s)", name);
+
+	return buf.buf;
+}
+
 static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *options)
 {
 	struct tree_desc desc;
@@ -358,7 +371,7 @@ static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *op
 		}
 		else {
 			result = error("in tree %s: entry %s has bad mode %.6o",
-					oid_to_hex(&tree->object.oid), entry.path, entry.mode);
+					describe_object(options, &tree->object), entry.path, entry.mode);
 		}
 		if (result < 0)
 			return result;
@@ -454,7 +467,7 @@ int fsck_walk(struct object *obj, void *data, struct fsck_options *options)
 	case OBJ_TAG:
 		return fsck_walk_tag((struct tag *)obj, data, options);
 	default:
-		error("Unknown object type for %s", oid_to_hex(&obj->oid));
+		error("Unknown object type for %s", describe_object(options, obj));
 		return -1;
 	}
 }
@@ -901,9 +914,9 @@ int fsck_error_function(struct fsck_options *o,
 	struct object *obj, int msg_type, const char *message)
 {
 	if (msg_type == FSCK_WARN) {
-		warning("object %s: %s", oid_to_hex(&obj->oid), message);
+		warning("object %s: %s", describe_object(o, obj), message);
 		return 0;
 	}
-	error("object %s: %s", oid_to_hex(&obj->oid), message);
+	error("object %s: %s", describe_object(o, obj), message);
 	return 1;
 }
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 7ee8ea0..8f52da2 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -523,4 +523,26 @@ test_expect_success 'fsck --connectivity-only' '
 	)
 '
 
+remove_loose_object () {
+	sha1="$(git rev-parse "$1")" &&
+	remainder=${sha1#??} &&
+	firsttwo=${sha1%$remainder} &&
+	rm .git/objects/$firsttwo/$remainder
+}
+
+test_expect_success 'fsck --name-objects' '
+	rm -rf name-objects &&
+	git init name-objects &&
+	(
+		cd name-objects &&
+		test_commit julius caesar.t &&
+		test_commit augustus &&
+		test_commit caesar &&
+		remove_loose_object $(git rev-parse julius:caesar.t) &&
+		test_must_fail git fsck --name-objects >out &&
+		tree=$(git rev-parse --verify julius:) &&
+		grep "$tree (\(refs/heads/master\|HEAD\)@{[0-9]*}:" out
+	)
+'
+
 test_done
-- 
2.9.0.281.g286a8d9
