From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 4/8] Add set_git_dir() function
Date: Fri, 27 Jul 2007 19:57:18 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707271957070.14781@racer.site>
References: <Pine.LNX.4.64.0707271851370.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: gitster@pobox.com, git@vger.kernel.org, matled@gmx.net
X-From: git-owner@vger.kernel.org Fri Jul 27 20:57:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEV0G-0007Bo-2t
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 20:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760956AbXG0S53 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 14:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760975AbXG0S52
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 14:57:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:50444 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760386AbXG0S52 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 14:57:28 -0400
Received: (qmail invoked by alias); 27 Jul 2007 18:57:26 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp049) with SMTP; 27 Jul 2007 20:57:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18xp4BQbZ8x73id/FDYWScHTVBcRGIDtr0QPFfoU2
	0trgzfAMQE6ZNs
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707271851370.14781@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53943>


With the function set_git_dir() you can reset the path that will
be used for git_path(), git_dir() and friends.

The responsibility to close files and throw away information from the
old git_dir lies with the caller.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This is just ripped out from the branch--new-workdir topic
	I was working on, just that it has a shorter name now.

	Ah, and just to be sure, it xstrdup()s the path.

 cache.h       |    1 +
 environment.c |    8 ++++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index c0cab34..36963f2 100644
--- a/cache.h
+++ b/cache.h
@@ -216,6 +216,7 @@ extern char *get_refs_directory(void);
 extern char *get_index_file(void);
 extern char *get_graft_file(void);
 extern const char *get_git_work_tree(void);
+extern int set_git_dir(const char *path);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
diff --git a/environment.c b/environment.c
index cb112a4..33c0f90 100644
--- a/environment.c
+++ b/environment.c
@@ -121,3 +121,11 @@ char *get_graft_file(void)
 		setup_git_env();
 	return git_graft_file;
 }
+
+int set_git_dir(const char *path)
+{
+	if (setenv(GIT_DIR_ENVIRONMENT, xstrdup(path), 1))
+		return error("Could not set GIT_DIR to '%s'", path);
+	setup_git_env();
+	return 0;
+}
-- 
1.5.3.rc3.18.g49a1
