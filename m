From: David Aguilar <davvid@gmail.com>
Subject: [RFC PATCH 2/3] headers: improve header dependencies
Date: Sun, 31 Aug 2014 13:11:32 -0700
Message-ID: <1409515893-48017-2-git-send-email-davvid@gmail.com>
References: <1409515893-48017-1-git-send-email-davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 31 22:10:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOBSj-0007zl-N9
	for gcvg-git-2@plane.gmane.org; Sun, 31 Aug 2014 22:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959AbaHaUKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2014 16:10:47 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:33068 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbaHaUKp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2014 16:10:45 -0400
Received: by mail-pd0-f178.google.com with SMTP id y13so4434642pdi.23
        for <git@vger.kernel.org>; Sun, 31 Aug 2014 13:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=SYz9pntFEJuesqP4HcaENpWojl23d1mkmrZl24JltxA=;
        b=rRi0xrA+ks858VTWE40Y5QEon+50WLBPrHAo03SErcosazlRNYmbXz3Vr+i8o4wTOi
         PrAoDyAz3V8T3C/btuKIW8DLe4nUnekfrzWNaRLQUhCFMeQqXePbFOQWO/CxE4IEOM+Q
         Ml1lDWlIdoX3H6jmR5krT6kwU9tuczps45FRzE/wd3tntrXh85eEt4sz3kM9+jiRCmUa
         uV8Q01gh2P8uilDy07q90wGY27zkXoInppG+Yrj28ZmRfmoM8P1jTUY7bODNsZpIAD2i
         4RehUzm/z8E/itD6MlzvXFHm+w6Q5v0qldQ0tN2jNUj25IiWoExpigrI9HpYNoMtiJ1J
         6ibw==
X-Received: by 10.66.221.163 with SMTP id qf3mr33226626pac.37.1409515844014;
        Sun, 31 Aug 2014 13:10:44 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id ps1sm8947446pdb.73.2014.08.31.13.10.42
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 31 Aug 2014 13:10:43 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.30.g0bdc89a
In-Reply-To: <1409515893-48017-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256298>

Add missing includes or forward declarations where needed.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
If enum date_type were moved to object.h then we wouldn't need
to include cache.h from commit.h, but this patch doesn't touch that.

If we want to avoid including cache.h, another possibility
is moving enum object_type to something like object-types.h so that
e.g. dir.h wouldn't need to include all of cache.h.

Do we prefer these forward declarations or full-on #includes
of the corresponding header?  Forward declarations seemed like
the least intrusive, which is why some of the files do that in
this patch.

 color.h         | 2 ++
 commit.h        | 2 +-
 diffcore.h      | 2 ++
 dir.h           | 1 +
 graph.h         | 3 +++
 object.h        | 2 ++
 parse-options.h | 2 ++
 pathspec.h      | 2 ++
 quote.h         | 2 ++
 refs.h          | 5 +++++
 remote.h        | 2 ++
 sequencer.h     | 4 ++++
 strbuf.h        | 2 ++
 submodule.h     | 3 +++
 tag.h           | 1 +
 tree-walk.h     | 2 ++
 tree.h          | 2 ++
 utf8.h          | 4 ++++
 18 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/color.h b/color.h
index 9a8495b..6d64e6d 100644
--- a/color.h
+++ b/color.h
@@ -1,6 +1,8 @@
 #ifndef COLOR_H
 #define COLOR_H
 
+#include "git-compat-util.h"
+
 struct strbuf;
 
 /*  2 + (2 * num_attrs) + 8 + 1 + 8 + 'm' + NUL */
diff --git a/commit.h b/commit.h
index 268c9d7..339c55d 100644
--- a/commit.h
+++ b/commit.h
@@ -1,7 +1,7 @@
 #ifndef COMMIT_H
 #define COMMIT_H
 
-#include "object.h"
+#include "cache.h"
 #include "tree.h"
 #include "strbuf.h"
 #include "decorate.h"
diff --git a/diffcore.h b/diffcore.h
index c876dac..43856de 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -4,6 +4,8 @@
 #ifndef DIFFCORE_H
 #define DIFFCORE_H
 
+struct diff_options;
+
 /* This header file is internal between diff.c and its diff transformers
  * (e.g. diffcore-rename, diffcore-pickaxe).  Never include this header
  * in anything else.
diff --git a/dir.h b/dir.h
index 6c45e9d..1cc9f90 100644
--- a/dir.h
+++ b/dir.h
@@ -3,6 +3,7 @@
 
 /* See Documentation/technical/api-directory-listing.txt */
 
+#include "cache.h"
 #include "strbuf.h"
 
 struct dir_entry {
diff --git a/graph.h b/graph.h
index 0be62bd..585ebe6 100644
--- a/graph.h
+++ b/graph.h
@@ -3,6 +3,9 @@
 
 /* A graph is a pointer to this opaque structure */
 struct git_graph;
+struct commit;
+struct rev_info;
+struct strbuf;
 
 /*
  * Set up a custom scheme for column colors.
diff --git a/object.h b/object.h
index 5e8d8ee..40bd3a8 100644
--- a/object.h
+++ b/object.h
@@ -1,6 +1,8 @@
 #ifndef OBJECT_H
 #define OBJECT_H
 
+enum object_type;
+
 struct object_list {
 	struct object *item;
 	struct object_list *next;
diff --git a/parse-options.h b/parse-options.h
index 7940bc7..933a1b7 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -1,6 +1,8 @@
 #ifndef PARSE_OPTIONS_H
 #define PARSE_OPTIONS_H
 
+#include "git-compat-util.h"
+
 enum parse_opt_type {
 	/* special types */
 	OPTION_END,
diff --git a/pathspec.h b/pathspec.h
index 0c11262..c92fafc 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -1,6 +1,8 @@
 #ifndef PATHSPEC_H
 #define PATHSPEC_H
 
+#include "git-compat-util.h"
+
 /* Pathspec magic */
 #define PATHSPEC_FROMTOP	(1<<0)
 #define PATHSPEC_MAXDEPTH	(1<<1)
diff --git a/quote.h b/quote.h
index 71dcc3a..f9ca9e2 100644
--- a/quote.h
+++ b/quote.h
@@ -1,6 +1,8 @@
 #ifndef QUOTE_H
 #define QUOTE_H
 
+#include "git-compat-util.h"
+
 struct strbuf;
 
 /* Help to copy the thing properly quoted for the shell safety.
diff --git a/refs.h b/refs.h
index 00f209a..889bf8d 100644
--- a/refs.h
+++ b/refs.h
@@ -1,6 +1,11 @@
 #ifndef REFS_H
 #define REFS_H
 
+#include "git-compat-util.h"
+
+struct strbuf;
+struct string_list;
+
 struct ref_lock {
 	char *ref_name;
 	char *orig_ref_name;
diff --git a/remote.h b/remote.h
index 917d383..4b1533f 100644
--- a/remote.h
+++ b/remote.h
@@ -3,6 +3,8 @@
 
 #include "parse-options.h"
 
+struct strbuf;
+
 enum {
 	REMOTE_CONFIG,
 	REMOTE_REMOTES,
diff --git a/sequencer.h b/sequencer.h
index db43e9c..8e30082 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -1,6 +1,10 @@
 #ifndef SEQUENCER_H
 #define SEQUENCER_H
 
+#include "git-compat-util.h"
+
+struct strbuf;
+
 #define SEQ_DIR		"sequencer"
 #define SEQ_HEAD_FILE	"sequencer/head"
 #define SEQ_TODO_FILE	"sequencer/todo"
diff --git a/strbuf.h b/strbuf.h
index a7c0192..be59d9e 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -1,6 +1,8 @@
 #ifndef STRBUF_H
 #define STRBUF_H
 
+#include "git-compat-util.h"
+
 /* See Documentation/technical/api-strbuf.txt */
 
 extern char strbuf_slopbuf[];
diff --git a/submodule.h b/submodule.h
index 7beec48..5295c01 100644
--- a/submodule.h
+++ b/submodule.h
@@ -1,8 +1,11 @@
 #ifndef SUBMODULE_H
 #define SUBMODULE_H
 
+#include "git-compat-util.h"
+
 struct diff_options;
 struct argv_array;
+struct string_list;
 
 enum {
 	RECURSE_SUBMODULES_ON_DEMAND = -1,
diff --git a/tag.h b/tag.h
index bc8a1e4..68b0334 100644
--- a/tag.h
+++ b/tag.h
@@ -1,6 +1,7 @@
 #ifndef TAG_H
 #define TAG_H
 
+#include "git-compat-util.h"
 #include "object.h"
 
 extern const char *tag_type;
diff --git a/tree-walk.h b/tree-walk.h
index ae7fb3a..d7612cf 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -1,6 +1,8 @@
 #ifndef TREE_WALK_H
 #define TREE_WALK_H
 
+struct strbuf;
+
 struct name_entry {
 	const unsigned char *sha1;
 	const char *path;
diff --git a/tree.h b/tree.h
index d84ac63..bfeef4f 100644
--- a/tree.h
+++ b/tree.h
@@ -3,6 +3,8 @@
 
 #include "object.h"
 
+struct pathspec;
+
 extern const char *tree_type;
 
 struct tree {
diff --git a/utf8.h b/utf8.h
index 65d0e42..4955866 100644
--- a/utf8.h
+++ b/utf8.h
@@ -1,6 +1,10 @@
 #ifndef GIT_UTF8_H
 #define GIT_UTF8_H
 
+#include "git-compat-util.h"
+
+struct strbuf;
+
 typedef unsigned int ucs_char_t;  /* assuming 32bit int */
 
 size_t display_mode_esc_sequence_len(const char *s);
-- 
2.1.0.30.g0bdc89a
