From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: [PATCH 7/8] Builtin git-show-branch.
Date: Tue, 23 May 2006 14:15:35 +0200
Message-ID: <34919.3137757995$1148386594@news.gmane.org>
References: <11483865361243-git-send-email-1>
Reply-To: s022018@student.dtu.dk
Cc: Peter Eriksen <s022018@student.dtu.dk>
X-From: git-owner@vger.kernel.org Tue May 23 14:16:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiVnx-0002bL-8z
	for gcvg-git@gmane.org; Tue, 23 May 2006 14:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWEWMPn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 08:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWEWMPn
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 08:15:43 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:50623 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S932194AbWEWMPi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 08:15:38 -0400
Received: (qmail 5924 invoked by uid 5842); 23 May 2006 14:15:37 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g288c
In-Reply-To: <11483865361243-git-send-email-1>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20597>

From: Peter Eriksen <s022018@student.dtu.dk>

Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>


---

d0d1cfb7985fa90442e423a55ca23e6bc83f912d
 Makefile                               |    6 +++---
 show-branch.c => builtin-show-branch.c |    3 ++-
 builtin.h                              |    1 +
 git.c                                  |    3 ++-
 4 files changed, 8 insertions(+), 5 deletions(-)
 rename show-branch.c => builtin-show-branch.c (100%)

d0d1cfb7985fa90442e423a55ca23e6bc83f912d
diff --git a/Makefile b/Makefile
index eeb4fdb..b438a90 100644
--- a/Makefile
+++ b/Makefile
@@ -159,7 +159,7 @@ PROGRAMS = \
 	git-merge-index$X git-mktag$X git-mktree$X git-pack-objects$X git-patch-id$X \
 	git-peek-remote$X git-prune-packed$X \
 	git-receive-pack$X git-rev-parse$X \
-	git-send-pack$X git-show-branch$X git-shell$X \
+	git-send-pack$X git-shell$X \
 	git-show-index$X git-ssh-fetch$X \
 	git-ssh-upload$X git-unpack-file$X \
 	git-unpack-objects$X git-update-index$X git-update-server-info$X \
@@ -173,7 +173,7 @@ BUILT_INS = git-log$X git-whatchanged$X 
 	git-grep$X git-rev-list$X git-check-ref-format$X \
 	git-init-db$X git-ls-files$X git-ls-tree$X \
 	git-tar-tree$X git-read-tree$X git-commit-tree$X \
-	git-apply$X 
+	git-apply$X git-show-branch$X
 
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
@@ -224,7 +224,7 @@ BUILTIN_OBJS = \
 	builtin-grep.o builtin-rev-list.o builtin-check-ref-format.o \
 	builtin-init-db.o builtin-ls-files.o builtin-ls-tree.o \
         builtin-tar-tree.o builtin-read-tree.o builtin-commit-tree.o \
-	builtin-apply.o
+	builtin-apply.o builtin-show-branch.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 LIBS = $(GITLIBS) -lz
diff --git a/show-branch.c b/builtin-show-branch.c
similarity index 100%
rename from show-branch.c
rename to builtin-show-branch.c
index 268c57b..d1be8bb 100644
--- a/show-branch.c
+++ b/builtin-show-branch.c
@@ -3,6 +3,7 @@ #include <fnmatch.h>
 #include "cache.h"
 #include "commit.h"
 #include "refs.h"
+#include "builtin.h"
 
 static const char show_branch_usage[] =
 "git-show-branch [--dense] [--current] [--all] [--heads] [--tags] [--topo-order] [--more=count | --list | --independent | --merge-base ] [--topics] [<refs>...]";
@@ -548,7 +549,7 @@ static int omit_in_dense(struct commit *
 	return 0;
 }
 
-int main(int ac, char **av)
+int cmd_show_branch(int ac, const char **av, char **envp)
 {
 	struct commit *rev[MAX_REVS], *commit;
 	struct commit_list *list = NULL, *seen = NULL;
diff --git a/builtin.h b/builtin.h
index d6ff88e..01882ec 100644
--- a/builtin.h
+++ b/builtin.h
@@ -33,5 +33,6 @@ extern int cmd_tar_tree(int argc, const 
 extern int cmd_read_tree(int argc, const char **argv, char **envp);
 extern int cmd_commit_tree(int argc, const char **argv, char **envp);
 extern int cmd_apply(int argc, const char **argv, char **envp);
+extern int cmd_show_branch(int argc, const char **argv, char **envp);
 
 #endif
diff --git a/git.c b/git.c
index f44e08b..d29505c 100644
--- a/git.c
+++ b/git.c
@@ -58,7 +58,8 @@ static void handle_internal_command(int 
 		{ "tar-tree", cmd_tar_tree },
 		{ "read-tree", cmd_read_tree },
 		{ "commit-tree", cmd_commit_tree },
-		{ "apply", cmd_apply }
+		{ "apply", cmd_apply },
+		{ "show-branch", cmd_show_branch }
 	};
 	int i;
 
-- 
1.3.3.g288c
