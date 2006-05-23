From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: [PATCH 5/8] Builtin git-commit-tree.
Date: Tue, 23 May 2006 14:15:33 +0200
Message-ID: <14658.0410110348$1148386590@news.gmane.org>
References: <11483865361243-git-send-email-1>
Reply-To: s022018@student.dtu.dk
Cc: Peter Eriksen <s022018@student.dtu.dk>
X-From: git-owner@vger.kernel.org Tue May 23 14:16:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiVnv-0002bL-M3
	for gcvg-git@gmane.org; Tue, 23 May 2006 14:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWEWMPl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 08:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWEWMPl
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 08:15:41 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:50111 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S932190AbWEWMPi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 08:15:38 -0400
Received: (qmail 5918 invoked by uid 5842); 23 May 2006 14:15:37 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g288c
In-Reply-To: <11483865361243-git-send-email-1>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20596>

From: Peter Eriksen <s022018@student.dtu.dk>

Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>


---

762e5a2efcde796d84c573fe8bf3224c9fbf3588
 Makefile                               |    6 +++---
 commit-tree.c => builtin-commit-tree.c |    3 ++-
 builtin.h                              |    1 +
 git.c                                  |    3 ++-
 4 files changed, 8 insertions(+), 5 deletions(-)
 rename commit-tree.c => builtin-commit-tree.c (98%)

762e5a2efcde796d84c573fe8bf3224c9fbf3588
diff --git a/Makefile b/Makefile
index 667fa5d..a5efbc7 100644
--- a/Makefile
+++ b/Makefile
@@ -150,7 +150,7 @@ SIMPLE_PROGRAMS = \
 # ... and all the rest that could be moved out of bindir to gitexecdir
 PROGRAMS = \
 	git-apply$X git-cat-file$X \
-	git-checkout-index$X git-clone-pack$X git-commit-tree$X \
+	git-checkout-index$X git-clone-pack$X \
 	git-convert-objects$X git-diff-files$X \
 	git-diff-index$X git-diff-stages$X \
 	git-diff-tree$X git-fetch-pack$X git-fsck-objects$X \
@@ -172,7 +172,7 @@ BUILT_INS = git-log$X git-whatchanged$X 
 	git-count-objects$X git-diff$X git-push$X \
 	git-grep$X git-rev-list$X git-check-ref-format$X \
 	git-init-db$X git-ls-files$X git-ls-tree$X \
-	git-tar-tree$X git-read-tree$X
+	git-tar-tree$X git-read-tree$X git-commit-tree$X
 
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
@@ -222,7 +222,7 @@ BUILTIN_OBJS = \
 	builtin-log.o builtin-help.o builtin-count.o builtin-diff.o builtin-push.o \
 	builtin-grep.o builtin-rev-list.o builtin-check-ref-format.o \
 	builtin-init-db.o builtin-ls-files.o builtin-ls-tree.o \
-        builtin-tar-tree.o builtin-read-tree.o
+        builtin-tar-tree.o builtin-read-tree.o builtin-commit-tree.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 LIBS = $(GITLIBS) -lz
diff --git a/commit-tree.c b/builtin-commit-tree.c
similarity index 98%
rename from commit-tree.c
rename to builtin-commit-tree.c
index 0320036..4ccdbec 100644
--- a/commit-tree.c
+++ b/builtin-commit-tree.c
@@ -6,6 +6,7 @@
 #include "cache.h"
 #include "commit.h"
 #include "tree.h"
+#include "builtin.h"
 
 #define BLOCKING (1ul << 14)
 
@@ -76,7 +77,7 @@ static int new_parent(int idx)
 	return 1;
 }
 
-int main(int argc, char **argv)
+int cmd_commit_tree(int argc, const char **argv, char **envp)
 {
 	int i;
 	int parents = 0;
diff --git a/builtin.h b/builtin.h
index 88b3523..c6b07d9 100644
--- a/builtin.h
+++ b/builtin.h
@@ -31,5 +31,6 @@ extern int cmd_ls_files(int argc, const 
 extern int cmd_ls_tree(int argc, const char **argv, char **envp);
 extern int cmd_tar_tree(int argc, const char **argv, char **envp);
 extern int cmd_read_tree(int argc, const char **argv, char **envp);
+extern int cmd_commit_tree(int argc, const char **argv, char **envp);
 
 #endif
diff --git a/git.c b/git.c
index 300e2b2..4c2c062 100644
--- a/git.c
+++ b/git.c
@@ -56,7 +56,8 @@ static void handle_internal_command(int 
 		{ "ls-files", cmd_ls_files },
 		{ "ls-tree", cmd_ls_tree },
 		{ "tar-tree", cmd_tar_tree },
-		{ "read-tree", cmd_read_tree }
+		{ "read-tree", cmd_read_tree },
+		{ "commit-tree", cmd_commit_tree }
 	};
 	int i;
 
-- 
1.3.3.g288c
