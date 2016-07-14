Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95A6B20196
	for <e@80x24.org>; Thu, 14 Jul 2016 15:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbcGNPbA (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 11:31:00 -0400
Received: from mout.gmx.net ([212.227.15.15]:51483 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751305AbcGNPa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 11:30:58 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LlVZv-1amSyN2a8N-00bKj9; Thu, 14 Jul 2016 17:30:48
 +0200
Date:	Thu, 14 Jul 2016 17:30:47 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] fsck: optionally show more helpful info for broken
 links
In-Reply-To: <cover.1468510191.git.johannes.schindelin@gmx.de>
Message-ID: <2cc123136b25cae12dce2a6f30fe0ba5ae8dc811.1468510191.git.johannes.schindelin@gmx.de>
References: <cover.1468510191.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:QORa9S9+Z7rYSUgikKuiv4Zr5EmdPsr6TfuzdU6hs6x83N7f8uM
 I50QDh6cdXrFqs194M6YtBtvwIiaNJPGnuQLmNec4r+KTc5JQlOaAYVwR6YISJhXXeYG+k6
 et9HOmaCOW/0k/jxl4PnJj8ebJHJ00OpLvt4GXYW7QSJZS8D+8buq+BHz8q69DQTXesox7V
 MZYTlacewvkcuP/a1RWfA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:Iyzy1+GSjuI=:nGCKHhljzxfZCi6GsPSxo9
 iLNY0dku+L0yBK/nt3y+ZBkEFwn+6O4U2m3hJRKKesXGDt/usqGC7XWUs9ioRQ11Io13299H3
 mpaPxDWi9U6FRWrw7oIZ7/e7vnnedNL85ZntFt1Txf/eVxU3HVqeTMRPT1EMcKytgBYz5XSCs
 zhaVbZCegm6/KwcDvsiaAp8hvSEopiI3ZCAenEhL8h76xhIA/yW80mv5HvJQWooy0T1J8yAFZ
 8DW2+eGLKurp/Kqc/2mk9OhcuggeFOmqdGgIiaJpUb1JitMrawP1qHaeDWjJbaLuCS9DRw/Sq
 kSNyWEz5ouHOqQP3YqwSKM5K/1J1uCALGykprDdnst4az2y/826CugRS+IWHh34zmM5lARptn
 VFzc79ee+2pAVwVCumeF2zlHcRo7NcMEfc4X8ICm8du1VHXkmvFmoiy7m359YF+Yl7pGZtzui
 iTXh9SFcveAHEbosKWR8IPcNvr2pl+CWm38AjoDB1nHHohfo4h0ihzwiGV/JsEYhs0y3mPvrK
 +AZEtt8N0VMRuI4IgHLwLIjx7LvqnGPYAmVRzjJjZ/hipiT5dN5bw2joDVTFM3Ucsql32so73
 fSJH9HqHKxqgoCauUg+phwB/Ns5gp+VunhVcz4J0Czmi/dH9+avCdM6LHLHljz0+vK/FimRZv
 ZvBR7XqDhQJl+d6hcu2Gi+w+9rADbmxP4YbCHTpFLrZmzU9kE6lGgAgxaTphl6NAXctbO8/KK
 bmlz6HAw5wlQU+lDJ0Hd2i7JIdVfwfW3CVusaIz0cazX1eSPXZ91bvwIpP143YOaEKr58F5uP
 WUOYnc/
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
 t/t1450-fsck.sh            | 22 ++++++++++++++++++++++
 3 files changed, 68 insertions(+), 5 deletions(-)

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
index 87df191..e2173b6 100644
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
@@ -377,13 +388,18 @@ static int fsck_obj_buffer(const unsigned char *sha1, enum object_type type,
 
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
@@ -403,8 +419,8 @@ static int fsck_handle_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 		fprintf(stderr, "Checking reflog %s->%s\n",
 			sha1_to_hex(osha1), sha1_to_hex(nsha1));
 
-	fsck_handle_reflog_sha1(refname, osha1);
-	fsck_handle_reflog_sha1(refname, nsha1);
+	fsck_handle_reflog_sha1(refname, osha1, 0);
+	fsck_handle_reflog_sha1(refname, nsha1, timestamp);
 	return 0;
 }
 
@@ -433,6 +449,9 @@ static int fsck_handle_ref(const char *refname, const struct object_id *oid,
 	}
 	default_refs++;
 	obj->used = 1;
+	if (name_objects)
+		add_decoration(fsck_walk_options.object_names,
+			obj, xstrdup(refname));
 	mark_object_reachable(obj);
 
 	return 0;
@@ -548,6 +567,9 @@ static int fsck_cache_tree(struct cache_tree *it)
 			return 1;
 		}
 		obj->used = 1;
+		if (name_objects)
+			add_decoration(fsck_walk_options.object_names,
+				obj, xstrdup(":"));
 		mark_object_reachable(obj);
 		if (obj->type != OBJ_TREE)
 			err |= objerror(obj, "non-tree in cache-tree");
@@ -576,6 +598,7 @@ static struct option fsck_opts[] = {
 	OPT_BOOL(0, "lost-found", &write_lost_and_found,
 				N_("write dangling objects in .git/lost-found")),
 	OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
+	OPT_BOOL(0, "name-objects", &name_objects, N_("show verbose names for rechable objects")),
 	OPT_END(),
 };
 
@@ -605,6 +628,10 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		include_reflogs = 0;
 	}
 
+	if (name_objects)
+		fsck_walk_options.object_names =
+			xcalloc(1, sizeof(struct decoration));
+
 	git_config(fsck_config, NULL);
 
 	fsck_head_link();
@@ -660,6 +687,9 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 				continue;
 
 			obj->used = 1;
+			if (name_objects)
+				add_decoration(fsck_walk_options.object_names,
+					obj, xstrdup(arg));
 			mark_object_reachable(obj);
 			heads++;
 			continue;
@@ -692,6 +722,10 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
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
2.9.0.278.g1caae67
