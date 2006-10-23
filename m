From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] Git-branch: fix regression and style issues
Date: Tue, 24 Oct 2006 01:51:03 +0200
Message-ID: <11616474633074-git-send-email-hjemli@gmail.com>
References: <7vk62qwtk7.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 01:51:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc9Zf-0005mO-R6
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 01:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWJWXvO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 19:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbWJWXvO
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 19:51:14 -0400
Received: from mail45.e.nsc.no ([193.213.115.45]:19193 "EHLO mail45.e.nsc.no")
	by vger.kernel.org with ESMTP id S932337AbWJWXvN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 19:51:13 -0400
Received: from localhost.localdomain (ti231210a080-7372.bb.online.no [80.213.28.208])
	by mail45.nsc.no (8.13.8/8.13.5) with ESMTP id k9NNp46X014421;
	Tue, 24 Oct 2006 01:51:04 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.3.1.g4604-dirty
In-Reply-To: <7vk62qwtk7.fsf@assigned-by-dhcp.cox.net>
Date: Tue, 24 Oct 2006 01:45:46 +0200
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29903>

This is on top of my previuos patch to builtin-branch.c

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 builtin-branch.c |   17 ++++++++---------
 builtin.h        |    2 +-
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 3105efd..ffc2db0 100755
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -11,7 +11,7 @@ #include "commit.h"
 #include "builtin.h"
 
 static const char builtin_branch_usage[] =
-"git-branch [(-d | -D) <branchname>] | [[-f] <branchname> [<start-point>]] | -r";
+"git-branch (-d | -D) <branchname> | [-l] [-f] <branchname> [<start-point>] | [-r]";
 
 
 static const char *head;
@@ -74,7 +74,7 @@ static void delete_branches(int argc, co
 			printf("Error deleting branch '%s'\n", argv[i]);
 		else
 			printf("Deleted branch %s.\n", argv[i]);
-			
+
 		free(name);
 	}
 }
@@ -82,11 +82,11 @@ static void delete_branches(int argc, co
 static int ref_index, ref_alloc;
 static char **ref_list;
 
-static int append_ref(const char *refname, const unsigned char *sha1, int flags, 
+static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 		void *cb_data)
 {
 	if (ref_index >= ref_alloc) {
-		ref_alloc = ref_alloc > 0 ? ref_alloc * 2 : 16;
+		ref_alloc = alloc_nr(ref_alloc);
 		ref_list = xrealloc(ref_list, ref_alloc * sizeof(char *));
 	}
 
@@ -137,14 +137,14 @@ static void create_branch(const char *na
 			die("Cannot force update the current branch.");
 	}
 
-	if (get_sha1(start, sha1))
+	if (get_sha1(mkpath("%s^0", start), sha1))
 		die("Not a valid branch point: '%s'.", start);
 
 	lock = lock_any_ref_for_update(ref, NULL);
 	if (!lock)
 		die("Failed to lock ref for update: %s.", strerror(errno));
-		
-	if (reflog){
+
+	if (reflog) {
 		log_all_ref_updates = 1;
 		snprintf(msg, sizeof msg, "branch: Created from %s", start);
 	}
@@ -199,9 +199,8 @@ int cmd_branch(int argc, const char **ar
 		die("Failed to resolve HEAD as a valid ref.");
 	if (strncmp(head, "refs/heads/", 11))
 		die("HEAD not found below refs/heads!");
-		
 	head += 11;
-	
+
 	if (delete)
 		delete_branches(argc - i, argv + i, force_delete);
 	else if (i == argc)
diff --git a/builtin.h b/builtin.h
index 144d299..9b4749f 100644
--- a/builtin.h
+++ b/builtin.h
@@ -15,8 +15,8 @@ extern int write_tree(unsigned char *sha
 extern int cmd_add(int argc, const char **argv, const char *prefix);
 extern int cmd_annotate(int argc, const char **argv, const char *prefix);
 extern int cmd_apply(int argc, const char **argv, const char *prefix);
-extern int cmd_branch(int argc, const char **argv, const char *prefix);
 extern int cmd_archive(int argc, const char **argv, const char *prefix);
+extern int cmd_branch(int argc, const char **argv, const char *prefix);
 extern int cmd_cat_file(int argc, const char **argv, const char *prefix);
 extern int cmd_checkout_index(int argc, const char **argv, const char *prefix);
 extern int cmd_check_ref_format(int argc, const char **argv, const char *prefix);
-- 
1.4.3.1.g4604-dirty
