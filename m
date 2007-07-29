From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 5/9] Add set_git_dir() function
Date: Mon, 30 Jul 2007 00:25:18 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707300025100.14781@racer.site>
References: <Pine.LNX.4.64.0707300016470.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: gitster@pobox.com, git@vger.kernel.org, matled@gmx.net
X-From: git-owner@vger.kernel.org Mon Jul 30 01:25:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFI8n-0002Rv-8i
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 01:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965128AbXG2XZf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 19:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935375AbXG2XZe
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 19:25:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:58534 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S935148AbXG2XZe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 19:25:34 -0400
Received: (qmail invoked by alias); 29 Jul 2007 23:25:32 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 30 Jul 2007 01:25:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+SeFoJu3OSVMfk8tcwJ/E7nARkIiwRFNbV6d0vkq
	yzRsqAy9cQ/pNa
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707300016470.14781@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54154>


With the function set_git_dir() you can reset the path that will
be used for git_path(), git_dir() and friends.

The responsibility to close files and throw away information from the
old git_dir lies with the caller.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
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
index 26f41af..2af12fd 100644
--- a/environment.c
+++ b/environment.c
@@ -124,3 +124,11 @@ char *get_graft_file(void)
 		setup_git_env();
 	return git_graft_file;
 }
+
+int set_git_dir(const char *path)
+{
+	if (setenv(GIT_DIR_ENVIRONMENT, path, 1))
+		return error("Could not set GIT_DIR to '%s'", path);
+	setup_git_env();
+	return 0;
+}
-- 
1.5.3.rc3.28.g1406
