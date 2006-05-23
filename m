From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: [PATCH 6/8] Builtin git-apply.
Date: Tue, 23 May 2006 14:15:34 +0200
Message-ID: <3616.78052363477$1148386588@news.gmane.org>
References: <11483865361243-git-send-email-1>
Reply-To: s022018@student.dtu.dk
Cc: Peter Eriksen <s022018@student.dtu.dk>
X-From: git-owner@vger.kernel.org Tue May 23 14:16:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiVnw-0002bL-OF
	for gcvg-git@gmane.org; Tue, 23 May 2006 14:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWEWMPm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 08:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWEWMPm
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 08:15:42 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:50367 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S932192AbWEWMPi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 08:15:38 -0400
Received: (qmail 5921 invoked by uid 5842); 23 May 2006 14:15:37 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g288c
In-Reply-To: <11483865361243-git-send-email-1>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20593>

From: Peter Eriksen <s022018@student.dtu.dk>

Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>


---

104e34d8d562584d212f141b7ce736d47016b60a
 Makefile                   |    8 +++++---
 apply.c => builtin-apply.c |    3 ++-
 builtin.h                  |    1 +
 git.c                      |    3 ++-
 4 files changed, 10 insertions(+), 5 deletions(-)
 rename apply.c => builtin-apply.c (100%)

104e34d8d562584d212f141b7ce736d47016b60a
diff --git a/Makefile b/Makefile
index a5efbc7..eeb4fdb 100644
--- a/Makefile
+++ b/Makefile
@@ -149,7 +149,7 @@ SIMPLE_PROGRAMS = \
 
 # ... and all the rest that could be moved out of bindir to gitexecdir
 PROGRAMS = \
-	git-apply$X git-cat-file$X \
+	git-cat-file$X \
 	git-checkout-index$X git-clone-pack$X \
 	git-convert-objects$X git-diff-files$X \
 	git-diff-index$X git-diff-stages$X \
@@ -172,7 +172,8 @@ BUILT_INS = git-log$X git-whatchanged$X 
 	git-count-objects$X git-diff$X git-push$X \
 	git-grep$X git-rev-list$X git-check-ref-format$X \
 	git-init-db$X git-ls-files$X git-ls-tree$X \
-	git-tar-tree$X git-read-tree$X git-commit-tree$X
+	git-tar-tree$X git-read-tree$X git-commit-tree$X \
+	git-apply$X 
 
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
@@ -222,7 +223,8 @@ BUILTIN_OBJS = \
 	builtin-log.o builtin-help.o builtin-count.o builtin-diff.o builtin-push.o \
 	builtin-grep.o builtin-rev-list.o builtin-check-ref-format.o \
 	builtin-init-db.o builtin-ls-files.o builtin-ls-tree.o \
-        builtin-tar-tree.o builtin-read-tree.o builtin-commit-tree.o
+        builtin-tar-tree.o builtin-read-tree.o builtin-commit-tree.o \
+	builtin-apply.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 LIBS = $(GITLIBS) -lz
diff --git a/apply.c b/builtin-apply.c
similarity index 100%
rename from apply.c
rename to builtin-apply.c
index 0ed9d13..4056b9d 100644
--- a/apply.c
+++ b/builtin-apply.c
@@ -11,6 +11,7 @@ #include "cache.h"
 #include "quote.h"
 #include "blob.h"
 #include "delta.h"
+#include "builtin.h"
 
 //  --check turns on checking that the working tree matches the
 //    files that are being modified, but doesn't apply the patch
@@ -2151,7 +2152,7 @@ static int git_apply_config(const char *
 }
 
 
-int main(int argc, char **argv)
+int cmd_apply(int argc, const char **argv, char **envp)
 {
 	int i;
 	int read_stdin = 1;
diff --git a/builtin.h b/builtin.h
index c6b07d9..d6ff88e 100644
--- a/builtin.h
+++ b/builtin.h
@@ -32,5 +32,6 @@ extern int cmd_ls_tree(int argc, const c
 extern int cmd_tar_tree(int argc, const char **argv, char **envp);
 extern int cmd_read_tree(int argc, const char **argv, char **envp);
 extern int cmd_commit_tree(int argc, const char **argv, char **envp);
+extern int cmd_apply(int argc, const char **argv, char **envp);
 
 #endif
diff --git a/git.c b/git.c
index 4c2c062..f44e08b 100644
--- a/git.c
+++ b/git.c
@@ -57,7 +57,8 @@ static void handle_internal_command(int 
 		{ "ls-tree", cmd_ls_tree },
 		{ "tar-tree", cmd_tar_tree },
 		{ "read-tree", cmd_read_tree },
-		{ "commit-tree", cmd_commit_tree }
+		{ "commit-tree", cmd_commit_tree },
+		{ "apply", cmd_apply }
 	};
 	int i;
 
-- 
1.3.3.g288c
