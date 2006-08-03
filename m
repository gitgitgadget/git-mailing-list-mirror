From: Matthias Kestenholz <matthias@spinlock.ch>
Subject: [PATCH] Make git-unpack-objects a builtin
Date: Thu,  3 Aug 2006 17:24:37 +0200
Message-ID: <11546186792277-git-send-email-matthias@spinlock.ch>
References: <11546186794129-git-send-email-matthias@spinlock.ch> <1154618679860-git-send-email-matthias@spinlock.ch>
Cc: git@vger.kernel.org, Matthias Kestenholz <matthias@spinlock.ch>
X-From: git-owner@vger.kernel.org Thu Aug 03 17:26:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8f4e-0005U7-6p
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 17:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWHCPZT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 11:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbWHCPZS
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 11:25:18 -0400
Received: from mail15.bluewin.ch ([195.186.18.63]:22725 "EHLO
	mail15.bluewin.ch") by vger.kernel.org with ESMTP id S964782AbWHCPZR
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 3 Aug 2006 11:25:17 -0400
Received: from spinlock.ch (83.78.18.234) by mail15.bluewin.ch (Bluewin 7.3.110.2)
        id 4492529600B36B79; Thu, 3 Aug 2006 15:25:12 +0000
Received: (nullmailer pid 5964 invoked by uid 1000);
	Thu, 03 Aug 2006 15:24:39 -0000
To: junkio@cox.net
X-Mailer: git-send-email 1.4.2.rc2.g2e994
In-Reply-To: <1154618679860-git-send-email-matthias@spinlock.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24731>

Signed-off-by: Matthias Kestenholz <matthias@spinlock.ch>
---
 Makefile                                     |    7 ++++---
 unpack-objects.c => builtin-unpack-objects.c |    4 ++--
 builtin.h                                    |    1 +
 git.c                                        |    1 +
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 4827bff..4d0243b 100644
--- a/Makefile
+++ b/Makefile
@@ -201,7 +201,7 @@ PROGRAMS = \
 	git-send-pack$X git-shell$X \
 	git-show-index$X git-ssh-fetch$X \
 	git-ssh-upload$X git-unpack-file$X \
-	git-unpack-objects$X git-update-server-info$X \
+	git-update-server-info$X \
 	git-upload-pack$X git-verify-pack$X \
 	git-symbolic-ref$X \
 	git-pack-redundant$X git-var$X \
@@ -218,7 +218,8 @@ BUILT_INS = git-log$X git-whatchanged$X 
 	git-apply$X git-show-branch$X git-diff-files$X git-update-index$X \
 	git-diff-index$X git-diff-stages$X git-diff-tree$X git-cat-file$X \
 	git-fmt-merge-msg$X git-prune$X git-mv$X git-prune-packed$X \
-	git-repo-config$X git-name-rev$X git-pack-objects$X
+	git-repo-config$X git-name-rev$X git-pack-objects$X \
+	git-unpack-objects$X
 
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
@@ -276,7 +277,7 @@ BUILTIN_OBJS = \
 	builtin-cat-file.o builtin-mailsplit.o builtin-stripspace.o \
 	builtin-update-ref.o builtin-fmt-merge-msg.o builtin-prune.o \
 	builtin-mv.o builtin-prune-packed.o builtin-repo-config.o \
-	builtin-name-rev.o builtin-pack-objects.o
+	builtin-name-rev.o builtin-pack-objects.o builtin-unpack-objects.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 EXTLIBS = -lz
diff --git a/unpack-objects.c b/builtin-unpack-objects.c
similarity index 99%
rename from unpack-objects.c
rename to builtin-unpack-objects.c
index b23fe58..ccf2643 100644
--- a/unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -1,3 +1,4 @@
+#include "builtin.h"
 #include "cache.h"
 #include "object.h"
 #include "delta.h"
@@ -260,12 +261,11 @@ static void unpack_all(void)
 		die("unresolved deltas left after unpacking");
 }
 
-int main(int argc, char **argv)
+int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	unsigned char sha1[20];
 
-	setup_git_directory();
 	git_config(git_default_config);
 
 	quiet = !isatty(2);
diff --git a/builtin.h b/builtin.h
index bc57a04..af73c3c 100644
--- a/builtin.h
+++ b/builtin.h
@@ -51,6 +51,7 @@ extern int cmd_mv(int argc, const char *
 extern int cmd_repo_config(int argc, const char **argv, const char *prefix);
 extern int cmd_name_rev(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_objects(int argc, const char **argv, const char *prefix);
+extern int cmd_unpack_objects(int argc, const char **argv, const char *prefix);
 
 extern int cmd_write_tree(int argc, const char **argv, const char *prefix);
 extern int write_tree(unsigned char *sha1, int missing_ok, const char *prefix);
diff --git a/git.c b/git.c
index 5d58946..7c3a7f8 100644
--- a/git.c
+++ b/git.c
@@ -267,6 +267,7 @@ static void handle_internal_command(int 
 		{ "repo-config", cmd_repo_config },
 		{ "name-rev", cmd_name_rev, NEEDS_PREFIX },
 		{ "pack-objects", cmd_pack_objects, NEEDS_PREFIX },
+		{ "unpack-objects", cmd_unpack_objects, NEEDS_PREFIX },
 	};
 	int i;
 
-- 
1.4.2.rc2.g2e994
