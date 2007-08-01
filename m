From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/4] Add set_git_dir() function
Date: Wed, 1 Aug 2007 01:29:38 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708010129310.14781@racer.site>
References: <Pine.LNX.4.64.0707300016470.14781@racer.site>
 <Pine.LNX.4.64.0708010058130.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: gitster@pobox.com, git@vger.kernel.org, matled@gmx.net
X-From: git-owner@vger.kernel.org Wed Aug 01 02:30:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IG26L-0005Ck-9v
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 02:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756398AbXHAAaG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 20:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756567AbXHAAaF
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 20:30:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:36666 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754916AbXHAAaC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 20:30:02 -0400
Received: (qmail invoked by alias); 01 Aug 2007 00:30:00 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 01 Aug 2007 02:30:00 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/yWHIah/HySK/sI6bHCgDa6RMS19edvaHKWl6ll8
	JYZmk7Nje9sUEl
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0708010058130.14781@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54387>


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
index 98af530..e1f94cb 100644
--- a/cache.h
+++ b/cache.h
@@ -214,6 +214,7 @@ extern char *get_object_directory(void);
 extern char *get_refs_directory(void);
 extern char *get_index_file(void);
 extern char *get_graft_file(void);
+extern int set_git_dir(const char *path);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
diff --git a/environment.c b/environment.c
index f83fb9e..a571fae 100644
--- a/environment.c
+++ b/environment.c
@@ -107,3 +107,11 @@ char *get_graft_file(void)
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
1.5.3.rc3.94.g3024
