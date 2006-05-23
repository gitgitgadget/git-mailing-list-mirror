From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: [PATCH 3/8] Builtin git-tar-tree.
Date: Tue, 23 May 2006 14:15:31 +0200
Message-ID: <11159.2464884327$1148386596@news.gmane.org>
References: <11483865361243-git-send-email-1>
Reply-To: s022018@student.dtu.dk
Cc: Peter Eriksen <s022018@student.dtu.dk>
X-From: git-owner@vger.kernel.org Tue May 23 14:16:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiVny-0002bL-S6
	for gcvg-git@gmane.org; Tue, 23 May 2006 14:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWEWMPr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 08:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWEWMPq
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 08:15:46 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:49599 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S932185AbWEWMPi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 08:15:38 -0400
Received: (qmail 5912 invoked by uid 5842); 23 May 2006 14:15:36 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g288c
In-Reply-To: <11483865361243-git-send-email-1>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20600>

From: Peter Eriksen <s022018@student.dtu.dk>

Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>


---

9860ed2d4a598ad100c3b4f6b07dd0a88a4547a6
 Makefile                         |    8 +++++---
 tar-tree.c => builtin-tar-tree.c |    3 ++-
 builtin.h                        |    1 +
 git.c                            |    3 ++-
 4 files changed, 10 insertions(+), 5 deletions(-)
 rename tar-tree.c => builtin-tar-tree.c (99%)

9860ed2d4a598ad100c3b4f6b07dd0a88a4547a6
diff --git a/Makefile b/Makefile
index 9b02264..966f7ee 100644
--- a/Makefile
+++ b/Makefile
@@ -161,7 +161,7 @@ PROGRAMS = \
 	git-receive-pack$X git-rev-parse$X \
 	git-send-pack$X git-show-branch$X git-shell$X \
 	git-show-index$X git-ssh-fetch$X \
-	git-ssh-upload$X git-tar-tree$X git-unpack-file$X \
+	git-ssh-upload$X git-unpack-file$X \
 	git-unpack-objects$X git-update-index$X git-update-server-info$X \
 	git-upload-pack$X git-verify-pack$X git-write-tree$X \
 	git-update-ref$X git-symbolic-ref$X \
@@ -171,7 +171,8 @@ PROGRAMS = \
 BUILT_INS = git-log$X git-whatchanged$X git-show$X \
 	git-count-objects$X git-diff$X git-push$X \
 	git-grep$X git-rev-list$X git-check-ref-format$X \
-	git-init-db$X git-ls-files$X git-ls-tree$X
+	git-init-db$X git-ls-files$X git-ls-tree$X \
+	git-tar-tree$X
 
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
@@ -220,7 +221,8 @@ LIB_OBJS = \
 BUILTIN_OBJS = \
 	builtin-log.o builtin-help.o builtin-count.o builtin-diff.o builtin-push.o \
 	builtin-grep.o builtin-rev-list.o builtin-check-ref-format.o \
-	builtin-init-db.o builtin-ls-files.o builtin-ls-tree.o
+	builtin-init-db.o builtin-ls-files.o builtin-ls-tree.o \
+        builtin-tar-tree.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 LIBS = $(GITLIBS) -lz
diff --git a/tar-tree.c b/builtin-tar-tree.c
similarity index 99%
rename from tar-tree.c
rename to builtin-tar-tree.c
index 3308736..6ada04c 100644
--- a/tar-tree.c
+++ b/builtin-tar-tree.c
@@ -7,6 +7,7 @@ #include "tree-walk.h"
 #include "commit.h"
 #include "strbuf.h"
 #include "tar.h"
+#include "builtin.h"
 
 #define RECORDSIZE	(512)
 #define BLOCKSIZE	(RECORDSIZE * 20)
@@ -301,7 +302,7 @@ static void traverse_tree(struct tree_de
 	}
 }
 
-int main(int argc, char **argv)
+int cmd_tar_tree(int argc, const char **argv, char** envp)
 {
 	unsigned char sha1[20], tree_sha1[20];
 	struct commit *commit;
diff --git a/builtin.h b/builtin.h
index 951f206..d210543 100644
--- a/builtin.h
+++ b/builtin.h
@@ -29,5 +29,6 @@ extern int cmd_check_ref_format(int argc
 extern int cmd_init_db(int argc, const char **argv, char **envp);
 extern int cmd_ls_files(int argc, const char **argv, char **envp);
 extern int cmd_ls_tree(int argc, const char **argv, char **envp);
+extern int cmd_tar_tree(int argc, const char **argv, char **envp);
 
 #endif
diff --git a/git.c b/git.c
index 8574775..c253e60 100644
--- a/git.c
+++ b/git.c
@@ -54,7 +54,8 @@ static void handle_internal_command(int 
 		{ "init-db", cmd_init_db },
 		{ "check-ref-format", cmd_check_ref_format },
 		{ "ls-files", cmd_ls_files },
-		{ "ls-tree", cmd_ls_tree }
+		{ "ls-tree", cmd_ls_tree },
+		{ "tar-tree", cmd_tar_tree }
 	};
 	int i;
 
-- 
1.3.3.g288c
