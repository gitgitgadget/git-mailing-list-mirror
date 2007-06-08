From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [RFC][PATCH 07/10] Sparse: fix "'merge_file' not declared" warning
Date: Fri, 08 Jun 2007 23:22:51 +0100
Message-ID: <4669D6BB.9060900@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jun 09 01:39:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwo3d-0007G9-3A
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 01:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755084AbXFHXjk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 19:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756373AbXFHXjj
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 19:39:39 -0400
Received: from anchor-fallback-95.mail.demon.net ([194.217.242.82]:41844 "EHLO
	anchor-fallback-95.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755056AbXFHXjh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2007 19:39:37 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:1546 "EHLO
	anchor-post-30.mail.demon.net") by anchor-fallback-95.mail.demon.net
	with ESMTP id S458042AbXFHWci (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 22:32:38 +0000
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-30.mail.demon.net with esmtp (Exim 4.42)
	id 1Hwmy5-0005oU-2R; Fri, 08 Jun 2007 22:30:06 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49525>


Add a declaration for merge_file() to a new "merge-file.h" header
file, and add the appropriate include directives.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

There are two other (static) definitions of a merge_file() function,
one in merge-recursive.c, which could probably be renamed merge_filespec()
and one in merge-index.c, which could be renamed merge_path().
Maybe the the function in merge-file.c should be called merge_blob() ...
(and then change the file names too!)

 Makefile     |    3 ++-
 merge-file.c |    1 +
 merge-file.h |    8 ++++++++
 merge-tree.c |    3 +--
 4 files changed, 12 insertions(+), 3 deletions(-)
 create mode 100644 merge-file.h

diff --git a/Makefile b/Makefile
index 29243c6..19b6da1 100644
--- a/Makefile
+++ b/Makefile
@@ -296,7 +296,8 @@ LIB_H = \
 	diff.h object.h pack.h pkt-line.h quote.h refs.h list-objects.h sideband.h \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
-	utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h mailmap.h
+	utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h \
+	mailmap.h merge-file.h
 
 DIFF_OBJS = \
 	diff.o diff-lib.o diffcore-break.o diffcore-order.o \
diff --git a/merge-file.c b/merge-file.c
index 748d15c..7bfefe7 100644
--- a/merge-file.c
+++ b/merge-file.c
@@ -2,6 +2,7 @@
 #include "run-command.h"
 #include "xdiff-interface.h"
 #include "blob.h"
+#include "merge-file.h"
 
 static int fill_mmfile_blob(mmfile_t *f, struct blob *obj)
 {
diff --git a/merge-file.h b/merge-file.h
new file mode 100644
index 0000000..a503c90
--- /dev/null
+++ b/merge-file.h
@@ -0,0 +1,8 @@
+#ifndef MERGE_FILE_H
+#define MERGE_FILE_H
+
+#include "blob.h"
+
+extern void *merge_file(struct blob *, struct blob *, struct blob *, unsigned long *);
+
+#endif
diff --git a/merge-tree.c b/merge-tree.c
index 3b8d9e6..93c8f54 100644
--- a/merge-tree.c
+++ b/merge-tree.c
@@ -2,6 +2,7 @@
 #include "tree-walk.h"
 #include "xdiff-interface.h"
 #include "blob.h"
+#include "merge-file.h"
 
 static const char merge_tree_usage[] = "git-merge-tree <base-tree> <branch1> <branch2>";
 static int resolve_directories = 1;
@@ -53,8 +54,6 @@ static const char *explanation(struct merge_list *entry)
 	return "removed in remote";
 }
 
-extern void *merge_file(struct blob *, struct blob *, struct blob *, unsigned long *);
-
 static void *result(struct merge_list *entry, unsigned long *size)
 {
 	enum object_type type;
-- 
1.5.2
