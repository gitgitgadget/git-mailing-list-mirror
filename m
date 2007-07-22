From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/3] Add setup_new_git_dir() function
Date: Sun, 22 Jul 2007 19:56:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707221956010.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jul 22 20:56:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICgbZ-00062M-Qw
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 20:56:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763832AbXGVS42 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 14:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763818AbXGVS40
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 14:56:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:32954 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762980AbXGVS4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 14:56:24 -0400
Received: (qmail invoked by alias); 22 Jul 2007 18:56:22 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp052) with SMTP; 22 Jul 2007 20:56:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19XrtoXrVRX+lplrAp2TKjXk4JteK1bdg08R0rbLh
	ZAbAjv2joTQSOj
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53291>


With the function setup_new_git_dir() you can reset the path that will
be used for git_path(), git_dir() and friends.

The responsibility to close files and throw away information from the
old git_dir lies with the caller.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 cache.h       |    1 +
 environment.c |    8 ++++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 98af530..bd58853 100644
--- a/cache.h
+++ b/cache.h
@@ -214,6 +214,7 @@ extern char *get_object_directory(void);
 extern char *get_refs_directory(void);
 extern char *get_index_file(void);
 extern char *get_graft_file(void);
+extern int setup_new_git_dir(const char *path);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
diff --git a/environment.c b/environment.c
index f83fb9e..264392b 100644
--- a/environment.c
+++ b/environment.c
@@ -107,3 +107,11 @@ char *get_graft_file(void)
 		setup_git_env();
 	return git_graft_file;
 }
+
+int setup_new_git_dir(const char *path)
+{
+	if (setenv(GIT_DIR_ENVIRONMENT, path, 1))
+		return error("Could not set GIT_DIR to '%s'", path);
+	setup_git_env();
+	return 0;
+}
-- 
1.5.3.rc2.29.gc4640f
