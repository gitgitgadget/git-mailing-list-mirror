From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [1/5] Header files for object parsing
Date: Sun, 17 Apr 2005 22:35:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504172233580.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0504172229240.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 04:31:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNM2v-0001b0-Rp
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 04:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVDRCfX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 22:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVDRCfX
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 22:35:23 -0400
Received: from iabervon.org ([66.92.72.58]:25606 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261400AbVDRCfF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 22:35:05 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNM6b-0004zk-00; Sun, 17 Apr 2005 22:35:21 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.21.0504172229240.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds the structs and function declarations for parsing git objects.

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>
Index: blob.h
===================================================================
--- /dev/null  (tree:5ca133e1b74aee39b2124c0ec9fd51539babb5e0)
+++ 1172a9b8f45b2fd640985595cc5258db3b027828/blob.h  (mode:100644 sha1:9a23db3a7deca67981b67ceb768411e31f723715)
@@ -0,0 +1,14 @@
+#ifndef BLOB_H
+#define BLOB_H
+
+#include "object.h"
+
+extern const char *blob_type;
+
+struct blob {
+	struct object object;
+};
+
+struct blob *lookup_blob(unsigned char *sha1);
+
+#endif /* BLOB_H */
Index: commit.h
===================================================================
--- /dev/null  (tree:5ca133e1b74aee39b2124c0ec9fd51539babb5e0)
+++ 1172a9b8f45b2fd640985595cc5258db3b027828/commit.h  (mode:100644 sha1:8cd20b046875f5f7e534b0607fdd97f330f53272)
@@ -0,0 +1,27 @@
+#ifndef COMMIT_H
+#define COMMIT_H
+
+#include "object.h"
+#include "tree.h"
+
+struct commit_list {
+	struct commit *item;
+	struct commit_list *next;
+};
+
+struct commit {
+	struct object object;
+	unsigned long date;
+	struct commit_list *parents;
+	struct tree *tree;
+};
+
+extern const char *commit_type;
+
+struct commit *lookup_commit(unsigned char *sha1);
+
+int parse_commit(struct commit *item);
+
+void free_commit_list(struct commit_list *list);
+
+#endif /* COMMIT_H */
Index: object.h
===================================================================
--- /dev/null  (tree:5ca133e1b74aee39b2124c0ec9fd51539babb5e0)
+++ 1172a9b8f45b2fd640985595cc5258db3b027828/object.h  (mode:100644 sha1:20f879e0867b8d6a052c458d9230fbc7786d2864)
@@ -0,0 +1,29 @@
+#ifndef OBJECT_H
+#define OBJECT_H
+
+struct object_list {
+	struct object *item;
+	struct object_list *next;
+};
+
+struct object {
+	unsigned parsed : 1;
+	unsigned used : 1;
+	unsigned int flags;
+	unsigned char sha1[20];
+	const char *type;
+	struct object_list *refs;
+};
+
+int nr_objs;
+struct object **objs;
+
+struct object *lookup_object(unsigned char *sha1);
+
+void created_object(unsigned char *sha1, struct object *obj);
+
+void add_ref(struct object *refer, struct object *target);
+
+void mark_reachable(struct object *obj, unsigned int mask);
+
+#endif /* OBJECT_H */
Index: tree.h
===================================================================
--- /dev/null  (tree:5ca133e1b74aee39b2124c0ec9fd51539babb5e0)
+++ 1172a9b8f45b2fd640985595cc5258db3b027828/tree.h  (mode:100644 sha1:14ebbacded09d5e058c7f94652dcb9e12bc31cae)
@@ -0,0 +1,17 @@
+#ifndef TREE_H
+#define TREE_H
+
+#include "object.h"
+
+extern const char *tree_type;
+
+struct tree {
+	struct object object;
+	unsigned has_full_path : 1;
+};
+
+struct tree *lookup_tree(unsigned char *sha1);
+
+int parse_tree(struct tree *tree);
+
+#endif /* TREE_H */

