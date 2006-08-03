From: Matthias Kestenholz <matthias@spinlock.ch>
Subject: [PATCH] Make git-symbolic-ref a builtin
Date: Thu,  3 Aug 2006 17:24:38 +0200
Message-ID: <11546186792870-git-send-email-matthias@spinlock.ch>
References: <11546186794129-git-send-email-matthias@spinlock.ch> <1154618679860-git-send-email-matthias@spinlock.ch> <11546186792277-git-send-email-matthias@spinlock.ch>
Cc: git@vger.kernel.org, Matthias Kestenholz <matthias@spinlock.ch>
X-From: git-owner@vger.kernel.org Thu Aug 03 17:25:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8f4l-0005Vd-OE
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 17:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWHCPZ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 11:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWHCPZ1
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 11:25:27 -0400
Received: from mail11.bluewin.ch ([195.186.18.61]:36326 "EHLO
	mail11.bluewin.ch") by vger.kernel.org with ESMTP id S964784AbWHCPZ0
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 3 Aug 2006 11:25:26 -0400
Received: from spinlock.ch (83.78.18.234) by mail11.bluewin.ch (Bluewin 7.3.110.2)
        id 44A3D2BF007B286E; Thu, 3 Aug 2006 15:25:23 +0000
Received: (nullmailer pid 5966 invoked by uid 1000);
	Thu, 03 Aug 2006 15:24:40 -0000
To: junkio@cox.net
X-Mailer: git-send-email 1.4.2.rc2.g2e994
In-Reply-To: <11546186792277-git-send-email-matthias@spinlock.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24728>

Signed-off-by: Matthias Kestenholz <matthias@spinlock.ch>
---
 Makefile                                 |    6 +++---
 symbolic-ref.c => builtin-symbolic-ref.c |    4 ++--
 builtin.h                                |    1 +
 git.c                                    |    1 +
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 4d0243b..785e188 100644
--- a/Makefile
+++ b/Makefile
@@ -203,7 +203,6 @@ PROGRAMS = \
 	git-ssh-upload$X git-unpack-file$X \
 	git-update-server-info$X \
 	git-upload-pack$X git-verify-pack$X \
-	git-symbolic-ref$X \
 	git-pack-redundant$X git-var$X \
 	git-describe$X git-merge-tree$X git-blame$X git-imap-send$X \
 	git-merge-recur$X
@@ -219,7 +218,7 @@ BUILT_INS = git-log$X git-whatchanged$X 
 	git-diff-index$X git-diff-stages$X git-diff-tree$X git-cat-file$X \
 	git-fmt-merge-msg$X git-prune$X git-mv$X git-prune-packed$X \
 	git-repo-config$X git-name-rev$X git-pack-objects$X \
-	git-unpack-objects$X
+	git-unpack-objects$X git-symbolic-ref$X
 
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
@@ -277,7 +276,8 @@ BUILTIN_OBJS = \
 	builtin-cat-file.o builtin-mailsplit.o builtin-stripspace.o \
 	builtin-update-ref.o builtin-fmt-merge-msg.o builtin-prune.o \
 	builtin-mv.o builtin-prune-packed.o builtin-repo-config.o \
-	builtin-name-rev.o builtin-pack-objects.o builtin-unpack-objects.o
+	builtin-name-rev.o builtin-pack-objects.o builtin-unpack-objects.o \
+	builtin-symbolic-ref.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 EXTLIBS = -lz
diff --git a/symbolic-ref.c b/builtin-symbolic-ref.c
similarity index 89%
rename from symbolic-ref.c
rename to builtin-symbolic-ref.c
index 193c87c..b4ec6f2 100644
--- a/symbolic-ref.c
+++ b/builtin-symbolic-ref.c
@@ -1,3 +1,4 @@
+#include "builtin.h"
 #include "cache.h"
 
 static const char git_symbolic_ref_usage[] =
@@ -17,9 +18,8 @@ static void check_symref(const char *HEA
 		die("No such ref: %s", HEAD);
 }
 
-int main(int argc, const char **argv)
+int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 {
-	setup_git_directory();
 	git_config(git_default_config);
 	switch (argc) {
 	case 2:
diff --git a/builtin.h b/builtin.h
index af73c3c..b767245 100644
--- a/builtin.h
+++ b/builtin.h
@@ -52,6 +52,7 @@ extern int cmd_repo_config(int argc, con
 extern int cmd_name_rev(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_objects(int argc, const char **argv, const char *prefix);
 extern int cmd_unpack_objects(int argc, const char **argv, const char *prefix);
+extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
 
 extern int cmd_write_tree(int argc, const char **argv, const char *prefix);
 extern int write_tree(unsigned char *sha1, int missing_ok, const char *prefix);
diff --git a/git.c b/git.c
index 7c3a7f8..e40e859 100644
--- a/git.c
+++ b/git.c
@@ -268,6 +268,7 @@ static void handle_internal_command(int 
 		{ "name-rev", cmd_name_rev, NEEDS_PREFIX },
 		{ "pack-objects", cmd_pack_objects, NEEDS_PREFIX },
 		{ "unpack-objects", cmd_unpack_objects, NEEDS_PREFIX },
+		{ "symbolic-ref", cmd_symbolic_ref, NEEDS_PREFIX },
 	};
 	int i;
 
-- 
1.4.2.rc2.g2e994
