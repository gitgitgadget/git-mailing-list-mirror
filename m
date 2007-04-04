From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] export setup_git_env()
Date: Wed, 4 Apr 2007 22:09:48 +0200
Message-ID: <20070404200948.GA22782@moooo.ath.cx>
References: <20070328141505.GA16600@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 22:09:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZBnr-0005WD-29
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 22:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753969AbXDDUJy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 16:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753965AbXDDUJx
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 16:09:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:42592 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753969AbXDDUJw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 16:09:52 -0400
Received: (qmail invoked by alias); 04 Apr 2007 20:09:50 -0000
Received: from pd9eba5e8.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.165.232]
  by mail.gmx.net (mp009) with SMTP; 04 Apr 2007 22:09:50 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX190SDpTxbd03BF8+3Jw9iWr9yxN0Ngmt3VxqjSXlv
	3g6M86IOsKWl8e
Content-Disposition: inline
In-Reply-To: <20070328141505.GA16600@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43771>

After changing environment variables used by environment.c
we need to call getenv() again.  setup_git_env() does this
and can now be used from other files too.

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
 cache.h       |    1 +
 environment.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index 384b260..7b49258 100644
--- a/cache.h
+++ b/cache.h
@@ -154,6 +154,7 @@ enum object_type {
 #define EXEC_PATH_ENVIRONMENT "GIT_EXEC_PATH"
 
 extern int is_bare_repository_cfg;
+extern void setup_git_env(void);
 extern int is_bare_repository(void);
 extern int is_inside_git_dir(void);
 extern const char *get_git_dir(void);
diff --git a/environment.c b/environment.c
index 2231659..713a011 100644
--- a/environment.c
+++ b/environment.c
@@ -35,7 +35,7 @@ int auto_crlf = 0;	/* 1: both ways, -1: only when adding git objects */
 static const char *git_dir;
 static char *git_object_dir, *git_index_file, *git_refs_dir, *git_graft_file;
 
-static void setup_git_env(void)
+void setup_git_env(void)
 {
 	git_dir = getenv(GIT_DIR_ENVIRONMENT);
 	if (!git_dir)
-- 
1.5.1.4.g446af-dirty
