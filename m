From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: [PATCH 1/8] Builtin git-ls-files.
Date: Tue, 23 May 2006 14:15:29 +0200
Message-ID: <8340.12128548256$1148386596@news.gmane.org>
References: <11483865361243-git-send-email-1>
Reply-To: s022018@student.dtu.dk
Cc: Peter Eriksen <s022018@student.dtu.dk>
X-From: git-owner@vger.kernel.org Tue May 23 14:16:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiVny-0002bL-B4
	for gcvg-git@gmane.org; Tue, 23 May 2006 14:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWEWMPk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 08:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWEWMPj
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 08:15:39 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:48831 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S932188AbWEWMPi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 08:15:38 -0400
Received: (qmail 5906 invoked by uid 5842); 23 May 2006 14:15:36 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g288c
In-Reply-To: <11483865361243-git-send-email-1>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20599>

From: Peter Eriksen <s022018@student.dtu.dk>

Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>


---

bc0dc50a3e9208011a39adc653e3463aa3ab4886
 Makefile                         |    6 +++---
 ls-files.c => builtin-ls-files.c |    3 ++-
 builtin.h                        |    1 +
 git.c                            |    3 ++-
 4 files changed, 8 insertions(+), 5 deletions(-)
 rename ls-files.c => builtin-ls-files.c (100%)

bc0dc50a3e9208011a39adc653e3463aa3ab4886
diff --git a/Makefile b/Makefile
index efe6b12..e522730 100644
--- a/Makefile
+++ b/Makefile
@@ -155,7 +155,7 @@ PROGRAMS = \
 	git-diff-index$X git-diff-stages$X \
 	git-diff-tree$X git-fetch-pack$X git-fsck-objects$X \
 	git-hash-object$X git-index-pack$X git-local-fetch$X \
-	git-ls-files$X git-ls-tree$X git-mailinfo$X git-merge-base$X \
+	git-ls-tree$X git-mailinfo$X git-merge-base$X \
 	git-merge-index$X git-mktag$X git-mktree$X git-pack-objects$X git-patch-id$X \
 	git-peek-remote$X git-prune-packed$X git-read-tree$X \
 	git-receive-pack$X git-rev-parse$X \
@@ -171,7 +171,7 @@ PROGRAMS = \
 BUILT_INS = git-log$X git-whatchanged$X git-show$X \
 	git-count-objects$X git-diff$X git-push$X \
 	git-grep$X git-rev-list$X git-check-ref-format$X \
-	git-init-db$X
+	git-init-db$X git-ls-files$X
 
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
@@ -220,7 +220,7 @@ LIB_OBJS = \
 BUILTIN_OBJS = \
 	builtin-log.o builtin-help.o builtin-count.o builtin-diff.o builtin-push.o \
 	builtin-grep.o builtin-rev-list.o builtin-check-ref-format.o \
-	builtin-init-db.o
+	builtin-init-db.o builtin-ls-files.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 LIBS = $(GITLIBS) -lz
diff --git a/ls-files.c b/builtin-ls-files.c
similarity index 100%
rename from ls-files.c
rename to builtin-ls-files.c
index 4a4af1c..3a0c5f2 100644
--- a/ls-files.c
+++ b/builtin-ls-files.c
@@ -10,6 +10,7 @@ #include <fnmatch.h>
 
 #include "cache.h"
 #include "quote.h"
+#include "builtin.h"
 
 static int abbrev = 0;
 static int show_deleted = 0;
@@ -648,7 +649,7 @@ static const char ls_files_usage[] =
 	"[ --exclude-per-directory=<filename> ] [--full-name] [--abbrev] "
 	"[--] [<file>]*";
 
-int main(int argc, const char **argv)
+int cmd_ls_files(int argc, const char **argv, char** envp)
 {
 	int i;
 	int exc_given = 0;
diff --git a/builtin.h b/builtin.h
index 6054126..a0713d3 100644
--- a/builtin.h
+++ b/builtin.h
@@ -27,5 +27,6 @@ extern int cmd_grep(int argc, const char
 extern int cmd_rev_list(int argc, const char **argv, char **envp);
 extern int cmd_check_ref_format(int argc, const char **argv, char **envp);
 extern int cmd_init_db(int argc, const char **argv, char **envp);
+extern int cmd_ls_files(int argc, const char **argv, char **envp);
 
 #endif
diff --git a/git.c b/git.c
index 3216d31..9cfa9eb 100644
--- a/git.c
+++ b/git.c
@@ -52,7 +52,8 @@ static void handle_internal_command(int 
 		{ "grep", cmd_grep },
 		{ "rev-list", cmd_rev_list },
 		{ "init-db", cmd_init_db },
-		{ "check-ref-format", cmd_check_ref_format }
+		{ "check-ref-format", cmd_check_ref_format },
+		{ "ls-files", cmd_ls_files }
 	};
 	int i;
 
-- 
1.3.3.g288c
