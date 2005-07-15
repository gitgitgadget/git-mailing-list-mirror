From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH 1/6] Move git_author_info and git_commiter_info to ident.c
Date: Thu, 14 Jul 2005 18:50:33 -0600
Message-ID: <m1slygyjs6.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 15 02:51:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtEPu-00020h-0f
	for gcvg-git@gmane.org; Fri, 15 Jul 2005 02:51:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262997AbVGOAuw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 20:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262998AbVGOAuw
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 20:50:52 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:10173 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262997AbVGOAuu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 20:50:50 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6F0oXPg020747;
	Thu, 14 Jul 2005 18:50:33 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6F0oXcZ020746;
	Thu, 14 Jul 2005 18:50:33 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Moving these functions allows all of the logic for figuring out what
these values are to be shared between programs.
---

 cache.h       |    2 ++
 commit-tree.c |   10 ----------
 ident.c       |   10 ++++++++++
 3 files changed, 12 insertions(+), 10 deletions(-)

c6f1b65729df142a8968441ca441f6b69926127a
diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -223,6 +223,8 @@ void datestamp(char *buf, int bufsize);
 
 extern int setup_ident(void);
 extern char *get_ident(const char *name, const char *email, const char *date_str);
+extern char *git_author_info(void);
+extern char *git_committer_info(void);
 
 static inline void *xmalloc(size_t size)
 {
diff --git a/commit-tree.c b/commit-tree.c
--- a/commit-tree.c
+++ b/commit-tree.c
@@ -79,16 +79,6 @@ static int new_parent(int idx)
 	return 1;
 }
 
-static char *git_author_info(void)
-{
-	return get_ident(gitenv("GIT_AUTHOR_NAME"), gitenv("GIT_AUTHOR_EMAIL"), gitenv("GIT_AUTHOR_DATE"));
-}
-
-static char *git_committer_info(void)
-{
-	return get_ident(gitenv("GIT_COMMITTER_NAME"), gitenv("GIT_COMMITTER_EMAIL"), gitenv("GIT_COMMITTER_DATE"));
-}
-
 int main(int argc, char **argv)
 {
 	int i;
diff --git a/ident.c b/ident.c
--- a/ident.c
+++ b/ident.c
@@ -136,3 +136,13 @@ char *get_ident(const char *name, const 
 	buffer[i] = 0;
 	return buffer;
 }
+
+char *git_author_info(void)
+{
+	return get_ident(gitenv("GIT_AUTHOR_NAME"), gitenv("GIT_AUTHOR_EMAIL"), gitenv("GIT_AUTHOR_DATE"));
+}
+
+char *git_committer_info(void)
+{
+	return get_ident(gitenv("GIT_COMMITTER_NAME"), gitenv("GIT_COMMITTER_EMAIL"), gitenv("GIT_COMMITTER_DATE"));
+}
