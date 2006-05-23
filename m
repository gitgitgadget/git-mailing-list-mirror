From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: [PATCH 2/8] Builtin git-ls-tree.
Date: Tue, 23 May 2006 14:15:30 +0200
Message-ID: <44992.4130844467$1148386590@news.gmane.org>
References: <11483865361243-git-send-email-1>
Reply-To: s022018@student.dtu.dk
Cc: Peter Eriksen <s022018@student.dtu.dk>
X-From: git-owner@vger.kernel.org Tue May 23 14:16:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiVnw-0002bL-6u
	for gcvg-git@gmane.org; Tue, 23 May 2006 14:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWEWMPj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 08:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWEWMPj
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 08:15:39 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:49087 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S932186AbWEWMPi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 08:15:38 -0400
Received: (qmail 5909 invoked by uid 5842); 23 May 2006 14:15:36 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g288c
In-Reply-To: <11483865361243-git-send-email-1>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20595>

From: Peter Eriksen <s022018@student.dtu.dk>

Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>


---

419257801e5bc91fc435bd4ff9eb42aa8063ffbb
 Makefile                       |    6 +++---
 ls-tree.c => builtin-ls-tree.c |    3 ++-
 builtin.h                      |    1 +
 git.c                          |    3 ++-
 4 files changed, 8 insertions(+), 5 deletions(-)
 rename ls-tree.c => builtin-ls-tree.c (98%)

419257801e5bc91fc435bd4ff9eb42aa8063ffbb
diff --git a/Makefile b/Makefile
index e522730..9b02264 100644
--- a/Makefile
+++ b/Makefile
@@ -155,7 +155,7 @@ PROGRAMS = \
 	git-diff-index$X git-diff-stages$X \
 	git-diff-tree$X git-fetch-pack$X git-fsck-objects$X \
 	git-hash-object$X git-index-pack$X git-local-fetch$X \
-	git-ls-tree$X git-mailinfo$X git-merge-base$X \
+	git-mailinfo$X git-merge-base$X \
 	git-merge-index$X git-mktag$X git-mktree$X git-pack-objects$X git-patch-id$X \
 	git-peek-remote$X git-prune-packed$X git-read-tree$X \
 	git-receive-pack$X git-rev-parse$X \
@@ -171,7 +171,7 @@ PROGRAMS = \
 BUILT_INS = git-log$X git-whatchanged$X git-show$X \
 	git-count-objects$X git-diff$X git-push$X \
 	git-grep$X git-rev-list$X git-check-ref-format$X \
-	git-init-db$X git-ls-files$X
+	git-init-db$X git-ls-files$X git-ls-tree$X
 
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
@@ -220,7 +220,7 @@ LIB_OBJS = \
 BUILTIN_OBJS = \
 	builtin-log.o builtin-help.o builtin-count.o builtin-diff.o builtin-push.o \
 	builtin-grep.o builtin-rev-list.o builtin-check-ref-format.o \
-	builtin-init-db.o builtin-ls-files.o
+	builtin-init-db.o builtin-ls-files.o builtin-ls-tree.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 LIBS = $(GITLIBS) -lz
diff --git a/ls-tree.c b/builtin-ls-tree.c
similarity index 98%
rename from ls-tree.c
rename to builtin-ls-tree.c
index f2b3bc1..b515307 100644
--- a/ls-tree.c
+++ b/builtin-ls-tree.c
@@ -7,6 +7,7 @@ #include "cache.h"
 #include "blob.h"
 #include "tree.h"
 #include "quote.h"
+#include "builtin.h"
 
 static int line_termination = '\n';
 #define LS_RECURSIVE 1
@@ -84,7 +85,7 @@ static int show_tree(unsigned char *sha1
 	return retval;
 }
 
-int main(int argc, const char **argv)
+int cmd_ls_tree(int argc, const char **argv, char **envp)
 {
 	unsigned char sha1[20];
 	struct tree *tree;
diff --git a/builtin.h b/builtin.h
index a0713d3..951f206 100644
--- a/builtin.h
+++ b/builtin.h
@@ -28,5 +28,6 @@ extern int cmd_rev_list(int argc, const 
 extern int cmd_check_ref_format(int argc, const char **argv, char **envp);
 extern int cmd_init_db(int argc, const char **argv, char **envp);
 extern int cmd_ls_files(int argc, const char **argv, char **envp);
+extern int cmd_ls_tree(int argc, const char **argv, char **envp);
 
 #endif
diff --git a/git.c b/git.c
index 9cfa9eb..8574775 100644
--- a/git.c
+++ b/git.c
@@ -53,7 +53,8 @@ static void handle_internal_command(int 
 		{ "rev-list", cmd_rev_list },
 		{ "init-db", cmd_init_db },
 		{ "check-ref-format", cmd_check_ref_format },
-		{ "ls-files", cmd_ls_files }
+		{ "ls-files", cmd_ls_files },
+		{ "ls-tree", cmd_ls_tree }
 	};
 	int i;
 
-- 
1.3.3.g288c
