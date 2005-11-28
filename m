From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/3] Introduce i18n.commitencoding.
Date: Sun, 27 Nov 2005 16:39:08 -0800
Message-ID: <7vd5kl61xv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Nov 28 01:40:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgX34-0007R6-Pn
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 01:39:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbVK1AjM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 19:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbVK1AjL
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 19:39:11 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:45242 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751164AbVK1AjK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2005 19:39:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051128003742.YLTW17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 27 Nov 2005 19:37:42 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12840>

This is to hold what the project-local rule as to the
charset/encoding for the commit log message is.  Lack of it
defaults to utf-8.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * This is not needed to make the gitk patch I just sent out
   work, because git-repo-config can do its own thing without
   the C-level integration like this.

   That may or may not be a good thing, though.  I wished either
   'git-var i18n.commitencoding' or 'git-repo-config --get
   i18n.commitencoding' in a vanilla repository to emit the
   default "utf-8".  Johannes?

 cache.h       |    3 +++
 config.c      |    5 +++++
 environment.c |    1 +
 3 files changed, 9 insertions(+), 0 deletions(-)

applies-to: 5596ac6f4661c80f823d93de7fa9aeec65ace1f1
4e72dcec89c7cda7022d4ec2dd686e77deb5376e
diff --git a/cache.h b/cache.h
index 61bf884..634b5aa 100644
--- a/cache.h
+++ b/cache.h
@@ -399,6 +399,9 @@ extern int check_repository_format_versi
 extern char git_default_email[MAX_GITNAME];
 extern char git_default_name[MAX_GITNAME];
 
+#define MAX_ENCODING_LENGTH 64
+extern char git_commit_encoding[MAX_ENCODING_LENGTH];
+
 /* Sane ctype - no locale, and works with signed chars */
 #undef isspace
 #undef isdigit
diff --git a/config.c b/config.c
index 0c43d76..152fa28 100644
--- a/config.c
+++ b/config.c
@@ -237,6 +237,11 @@ int git_default_config(const char *var, 
 		return 0;
 	}
 
+	if (!strcmp(var, "i18n.commitencoding")) {
+		strncpy(git_commit_encoding, value, sizeof(git_commit_encoding));
+		return 0;
+	}
+
 	/* Add other config variables here.. */
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 3f19473..0886ad3 100644
--- a/environment.c
+++ b/environment.c
@@ -14,6 +14,7 @@ char git_default_name[MAX_GITNAME];
 int trust_executable_bit = 1;
 int only_use_symrefs = 0;
 int repository_format_version = 0;
+char git_commit_encoding[MAX_ENCODING_LENGTH] = "utf-8";
 
 static char *git_dir, *git_object_dir, *git_index_file, *git_refs_dir,
 	*git_graft_file;
---
0.99.9.GIT
