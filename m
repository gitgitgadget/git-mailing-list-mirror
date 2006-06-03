From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Builtin git-rev-parse.
Date: Sat, 3 Jun 2006 18:45:43 +0200
Message-ID: <20060603184543.be4455c8.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 03 18:41:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmZC8-0006dP-Se
	for gcvg-git@gmane.org; Sat, 03 Jun 2006 18:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWFCQlq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 12:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWFCQlq
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 12:41:46 -0400
Received: from mailfe04.tele2.fr ([212.247.154.108]:13241 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1751129AbWFCQlp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jun 2006 12:41:45 -0400
X-T2-Posting-ID: TxtQRJW1bkfL6FK+j2Eryxlc4dIjlPc+B/S5UvRXFrs=
X-Cloudmark-Score: 0.000000 []
Received: from [83.177.220.103] (HELO localhost.boubyland)
  by mailfe04.swip.net (CommuniGate Pro SMTP 5.0.8)
  with SMTP id 206728667; Sat, 03 Jun 2006 18:41:43 +0200
To: Junio Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21199>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

---
 Makefile                           |    7 +++----
 rev-parse.c => builtin-rev-parse.c |    3 ++-
 builtin.h                          |    1 +
 git.c                              |    3 ++-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index b6fce39..004c216 100644
--- a/Makefile
+++ b/Makefile
@@ -154,8 +154,7 @@ PROGRAMS = \
 	git-hash-object$X git-index-pack$X git-local-fetch$X \
 	git-mailinfo$X git-merge-base$X \
 	git-merge-index$X git-mktag$X git-mktree$X git-pack-objects$X git-patch-id$X \
-	git-peek-remote$X git-prune-packed$X \
-	git-receive-pack$X git-rev-parse$X \
+	git-peek-remote$X git-prune-packed$X git-receive-pack$X \
 	git-send-pack$X git-shell$X \
 	git-show-index$X git-ssh-fetch$X \
 	git-ssh-upload$X git-unpack-file$X \
@@ -168,7 +167,7 @@ PROGRAMS = \
 BUILT_INS = git-log$X git-whatchanged$X git-show$X \
 	git-count-objects$X git-diff$X git-push$X \
 	git-grep$X git-add$X git-rm$X git-rev-list$X \
-	git-check-ref-format$X \
+	git-check-ref-format$X git-rev-parse$X \
 	git-init-db$X git-tar-tree$X git-upload-tar$X git-format-patch$X \
 	git-ls-files$X git-ls-tree$X \
 	git-read-tree$X git-commit-tree$X \
@@ -222,7 +221,7 @@ LIB_OBJS = \
 BUILTIN_OBJS = \
 	builtin-log.o builtin-help.o builtin-count.o builtin-diff.o builtin-push.o \
 	builtin-grep.o builtin-add.o builtin-rev-list.o builtin-check-ref-format.o \
-	builtin-rm.o builtin-init-db.o \
+	builtin-rm.o builtin-init-db.o builtin-rev-parse.o \
 	builtin-tar-tree.o builtin-upload-tar.o \
 	builtin-ls-files.o builtin-ls-tree.o \
 	builtin-read-tree.o builtin-commit-tree.o \
diff --git a/rev-parse.c b/builtin-rev-parse.c
similarity index 99%
rename from rev-parse.c
rename to builtin-rev-parse.c
index 4e2d9fb..c353a48 100644
--- a/rev-parse.c
+++ b/builtin-rev-parse.c
@@ -7,6 +7,7 @@ #include "cache.h"
 #include "commit.h"
 #include "refs.h"
 #include "quote.h"
+#include "builtin.h"
 
 #define DO_REVS		1
 #define DO_NOREV	2
@@ -163,7 +164,7 @@ static int show_file(const char *arg)
 	return 0;
 }
 
-int main(int argc, char **argv)
+int cmd_rev_parse(int argc, const char **argv, char **envp)
 {
 	int i, as_is = 0, verify = 0;
 	unsigned char sha1[20];
diff --git a/builtin.h b/builtin.h
index 738ec3d..ffa9340 100644
--- a/builtin.h
+++ b/builtin.h
@@ -43,5 +43,6 @@ extern int cmd_diff_index(int argc, cons
 extern int cmd_diff_stages(int argc, const char **argv, char **envp);
 extern int cmd_diff_tree(int argc, const char **argv, char **envp);
 extern int cmd_cat_file(int argc, const char **argv, char **envp);
+extern int cmd_rev_parse(int argc, const char **argv, char **envp);
 
 #endif
diff --git a/git.c b/git.c
index 10ea934..bc463c9 100644
--- a/git.c
+++ b/git.c
@@ -69,7 +69,8 @@ static void handle_internal_command(int 
 		{ "diff-index", cmd_diff_index },
 		{ "diff-stages", cmd_diff_stages },
 		{ "diff-tree", cmd_diff_tree },
-		{ "cat-file", cmd_cat_file }
+		{ "cat-file", cmd_cat_file },
+		{ "rev-parse", cmd_rev_parse }
 	};
 	int i;
 
-- 
1.3.3.ge13b
