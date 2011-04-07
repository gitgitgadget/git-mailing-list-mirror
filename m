From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 5/9] sparse: Fix an "symbol 'merge_file' not decared" warning
Date: Thu, 07 Apr 2011 19:31:24 +0100
Message-ID: <4D9E02FC.90800@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, bebarino@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 20:55:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7uMR-0006DR-CB
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 20:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756681Ab1DGSzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 14:55:13 -0400
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:39162 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756564Ab1DGSzM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Apr 2011 14:55:12 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1Q7uKO-00072Y-mH; Thu, 07 Apr 2011 18:53:13 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171076>


In order to fix the warning, we add a new "merge-file.h" header
containing the extern declaration of the merge_file() function,
and include the header in the source files that require the
declaration.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Note that I considered re-naming this function to merge_blobs()
or something, since there is already two other static merge_file()
functions in builtin/merge-index.c and merge-recursive.c.

 Makefile             |    1 +
 builtin/merge-tree.c |    3 +--
 merge-file.c         |    1 +
 merge-file.h         |    7 +++++++
 4 files changed, 10 insertions(+), 2 deletions(-)
 create mode 100644 merge-file.h

diff --git a/Makefile b/Makefile
index 79bef43..2a100b7 100644
--- a/Makefile
+++ b/Makefile
@@ -525,6 +525,7 @@ LIB_H += list-objects.h
 LIB_H += ll-merge.h
 LIB_H += log-tree.h
 LIB_H += mailmap.h
+LIB_H += merge-file.h
 LIB_H += merge-recursive.h
 LIB_H += notes.h
 LIB_H += notes-cache.h
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 1991742..897a563 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -3,6 +3,7 @@
 #include "xdiff-interface.h"
 #include "blob.h"
 #include "exec_cmd.h"
+#include "merge-file.h"
 
 static const char merge_tree_usage[] = "git merge-tree <base-tree> <branch1> <branch2>";
 static int resolve_directories = 1;
@@ -54,8 +55,6 @@ static const char *explanation(struct merge_list *entry)
 	return "removed in remote";
 }
 
-extern void *merge_file(const char *, struct blob *, struct blob *, struct blob *, unsigned long *);
-
 static void *result(struct merge_list *entry, unsigned long *size)
 {
 	enum object_type type;
diff --git a/merge-file.c b/merge-file.c
index f7f4533..7845528 100644
--- a/merge-file.c
+++ b/merge-file.c
@@ -3,6 +3,7 @@
 #include "xdiff-interface.h"
 #include "ll-merge.h"
 #include "blob.h"
+#include "merge-file.h"
 
 static int fill_mmfile_blob(mmfile_t *f, struct blob *obj)
 {
diff --git a/merge-file.h b/merge-file.h
new file mode 100644
index 0000000..9b3b83a
--- /dev/null
+++ b/merge-file.h
@@ -0,0 +1,7 @@
+#ifndef MERGE_FILE_H
+#define MERGE_FILE_H
+
+extern void *merge_file(const char *path, struct blob *base, struct blob *our,
+			struct blob *their, unsigned long *size);
+
+#endif
-- 
1.7.4
