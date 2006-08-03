From: Matthias Kestenholz <matthias@spinlock.ch>
Subject: [PATCH] Make git-pack-objects a builtin
Date: Thu,  3 Aug 2006 17:24:36 +0200
Message-ID: <1154618679860-git-send-email-matthias@spinlock.ch>
References: <11546186794129-git-send-email-matthias@spinlock.ch>
Cc: git@vger.kernel.org, Matthias Kestenholz <matthias@spinlock.ch>
X-From: git-owner@vger.kernel.org Thu Aug 03 17:26:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8f4V-0005Ri-7p
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 17:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWHCPZJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 11:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbWHCPZJ
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 11:25:09 -0400
Received: from mail19.bluewin.ch ([195.186.18.65]:42382 "EHLO
	mail19.bluewin.ch") by vger.kernel.org with ESMTP id S964780AbWHCPZH
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 3 Aug 2006 11:25:07 -0400
Received: from spinlock.ch (83.78.18.234) by mail19.bluewin.ch (Bluewin 7.3.110.2)
        id 449253F800A916D6; Thu, 3 Aug 2006 15:25:02 +0000
Received: (nullmailer pid 5962 invoked by uid 1000);
	Thu, 03 Aug 2006 15:24:39 -0000
To: junkio@cox.net
X-Mailer: git-send-email 1.4.2.rc2.g2e994
In-Reply-To: <11546186794129-git-send-email-matthias@spinlock.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24729>

Signed-off-by: Matthias Kestenholz <matthias@spinlock.ch>
---
 Makefile                                 |    6 +++---
 pack-objects.c => builtin-pack-objects.c |    4 ++--
 builtin.h                                |    1 +
 git.c                                    |    1 +
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 67b6846..4827bff 100644
--- a/Makefile
+++ b/Makefile
@@ -196,7 +196,7 @@ PROGRAMS = \
 	git-convert-objects$X git-fetch-pack$X git-fsck-objects$X \
 	git-hash-object$X git-index-pack$X git-local-fetch$X \
 	git-merge-base$X \
-	git-merge-index$X git-mktag$X git-mktree$X git-pack-objects$X git-patch-id$X \
+	git-merge-index$X git-mktag$X git-mktree$X git-patch-id$X \
 	git-peek-remote$X git-receive-pack$X \
 	git-send-pack$X git-shell$X \
 	git-show-index$X git-ssh-fetch$X \
@@ -218,7 +218,7 @@ BUILT_INS = git-log$X git-whatchanged$X 
 	git-apply$X git-show-branch$X git-diff-files$X git-update-index$X \
 	git-diff-index$X git-diff-stages$X git-diff-tree$X git-cat-file$X \
 	git-fmt-merge-msg$X git-prune$X git-mv$X git-prune-packed$X \
-	git-repo-config$X git-name-rev$X
+	git-repo-config$X git-name-rev$X git-pack-objects$X
 
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
@@ -276,7 +276,7 @@ BUILTIN_OBJS = \
 	builtin-cat-file.o builtin-mailsplit.o builtin-stripspace.o \
 	builtin-update-ref.o builtin-fmt-merge-msg.o builtin-prune.o \
 	builtin-mv.o builtin-prune-packed.o builtin-repo-config.o \
-	builtin-name-rev.o
+	builtin-name-rev.o builtin-pack-objects.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 EXTLIBS = -lz
diff --git a/pack-objects.c b/builtin-pack-objects.c
similarity index 100%
rename from pack-objects.c
rename to builtin-pack-objects.c
index e52e977..2f99212 100644
--- a/pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1,3 +1,4 @@
+#include "builtin.h"
 #include "cache.h"
 #include "object.h"
 #include "blob.h"
@@ -1242,7 +1243,7 @@ static int git_pack_config(const char *k
 	return git_default_config(k, v);
 }
 
-int main(int argc, char **argv)
+int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 {
 	SHA_CTX ctx;
 	char line[40 + 1 + PATH_MAX + 2];
@@ -1251,7 +1252,6 @@ int main(int argc, char **argv)
 	int num_preferred_base = 0;
 	int i;
 
-	setup_git_directory();
 	git_config(git_pack_config);
 
 	progress = isatty(2);
diff --git a/builtin.h b/builtin.h
index d1d9dc1..bc57a04 100644
--- a/builtin.h
+++ b/builtin.h
@@ -50,6 +50,7 @@ extern int cmd_fmt_merge_msg(int argc, c
 extern int cmd_mv(int argc, const char **argv, const char *prefix);
 extern int cmd_repo_config(int argc, const char **argv, const char *prefix);
 extern int cmd_name_rev(int argc, const char **argv, const char *prefix);
+extern int cmd_pack_objects(int argc, const char **argv, const char *prefix);
 
 extern int cmd_write_tree(int argc, const char **argv, const char *prefix);
 extern int write_tree(unsigned char *sha1, int missing_ok, const char *prefix);
diff --git a/git.c b/git.c
index 501a781..5d58946 100644
--- a/git.c
+++ b/git.c
@@ -266,6 +266,7 @@ static void handle_internal_command(int 
 		{ "prune-packed", cmd_prune_packed, NEEDS_PREFIX },
 		{ "repo-config", cmd_repo_config },
 		{ "name-rev", cmd_name_rev, NEEDS_PREFIX },
+		{ "pack-objects", cmd_pack_objects, NEEDS_PREFIX },
 	};
 	int i;
 
-- 
1.4.2.rc2.g2e994
