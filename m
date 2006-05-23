From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: [PATCH 4/8] Builtin git-read-tree.
Date: Tue, 23 May 2006 14:15:32 +0200
Message-ID: <39709.2846375473$1148386594@news.gmane.org>
References: <11483865361243-git-send-email-1>
Reply-To: s022018@student.dtu.dk
Cc: Peter Eriksen <s022018@student.dtu.dk>
X-From: git-owner@vger.kernel.org Tue May 23 14:16:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiVnx-0002bL-QH
	for gcvg-git@gmane.org; Tue, 23 May 2006 14:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWEWMPq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 08:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWEWMPp
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 08:15:45 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:49855 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S932189AbWEWMPi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 08:15:38 -0400
Received: (qmail 5915 invoked by uid 5842); 23 May 2006 14:15:37 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g288c
In-Reply-To: <11483865361243-git-send-email-1>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20598>

From: Peter Eriksen <s022018@student.dtu.dk>

Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>


---

baba8c18d8a5fff876d16a434b49677cd3ebbdb0
 Makefile                           |    6 +++---
 read-tree.c => builtin-read-tree.c |    3 ++-
 builtin.h                          |    1 +
 git.c                              |    3 ++-
 4 files changed, 8 insertions(+), 5 deletions(-)
 rename read-tree.c => builtin-read-tree.c (100%)

baba8c18d8a5fff876d16a434b49677cd3ebbdb0
diff --git a/Makefile b/Makefile
index 966f7ee..667fa5d 100644
--- a/Makefile
+++ b/Makefile
@@ -157,7 +157,7 @@ PROGRAMS = \
 	git-hash-object$X git-index-pack$X git-local-fetch$X \
 	git-mailinfo$X git-merge-base$X \
 	git-merge-index$X git-mktag$X git-mktree$X git-pack-objects$X git-patch-id$X \
-	git-peek-remote$X git-prune-packed$X git-read-tree$X \
+	git-peek-remote$X git-prune-packed$X \
 	git-receive-pack$X git-rev-parse$X \
 	git-send-pack$X git-show-branch$X git-shell$X \
 	git-show-index$X git-ssh-fetch$X \
@@ -172,7 +172,7 @@ BUILT_INS = git-log$X git-whatchanged$X 
 	git-count-objects$X git-diff$X git-push$X \
 	git-grep$X git-rev-list$X git-check-ref-format$X \
 	git-init-db$X git-ls-files$X git-ls-tree$X \
-	git-tar-tree$X
+	git-tar-tree$X git-read-tree$X
 
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
@@ -222,7 +222,7 @@ BUILTIN_OBJS = \
 	builtin-log.o builtin-help.o builtin-count.o builtin-diff.o builtin-push.o \
 	builtin-grep.o builtin-rev-list.o builtin-check-ref-format.o \
 	builtin-init-db.o builtin-ls-files.o builtin-ls-tree.o \
-        builtin-tar-tree.o
+        builtin-tar-tree.o builtin-read-tree.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 LIBS = $(GITLIBS) -lz
diff --git a/read-tree.c b/builtin-read-tree.c
similarity index 100%
rename from read-tree.c
rename to builtin-read-tree.c
index 82e2a9a..ec40d01 100644
--- a/read-tree.c
+++ b/builtin-read-tree.c
@@ -11,6 +11,7 @@ #include "object.h"
 #include "tree.h"
 #include <sys/time.h>
 #include <signal.h>
+#include "builtin.h"
 
 static int reset = 0;
 static int merge = 0;
@@ -763,7 +764,7 @@ static const char read_tree_usage[] = "g
 
 static struct cache_file cache_file;
 
-int main(int argc, char **argv)
+int cmd_read_tree(int argc, const char **argv, char **envp)
 {
 	int i, newfd, stage = 0;
 	unsigned char sha1[20];
diff --git a/builtin.h b/builtin.h
index d210543..88b3523 100644
--- a/builtin.h
+++ b/builtin.h
@@ -30,5 +30,6 @@ extern int cmd_init_db(int argc, const c
 extern int cmd_ls_files(int argc, const char **argv, char **envp);
 extern int cmd_ls_tree(int argc, const char **argv, char **envp);
 extern int cmd_tar_tree(int argc, const char **argv, char **envp);
+extern int cmd_read_tree(int argc, const char **argv, char **envp);
 
 #endif
diff --git a/git.c b/git.c
index c253e60..300e2b2 100644
--- a/git.c
+++ b/git.c
@@ -55,7 +55,8 @@ static void handle_internal_command(int 
 		{ "check-ref-format", cmd_check_ref_format },
 		{ "ls-files", cmd_ls_files },
 		{ "ls-tree", cmd_ls_tree },
-		{ "tar-tree", cmd_tar_tree }
+		{ "tar-tree", cmd_tar_tree },
+		{ "read-tree", cmd_read_tree }
 	};
 	int i;
 
-- 
1.3.3.g288c
