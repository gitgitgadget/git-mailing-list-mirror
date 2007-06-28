From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] getenv/setenv: use constants if available
Date: Thu, 28 Jun 2007 16:15:25 +0200
Message-ID: <20070628141525.GA25448@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 28 16:15:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3umY-0001c1-Pf
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 16:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756881AbXF1OP3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 10:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754904AbXF1OP3
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 10:15:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:41931 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752071AbXF1OP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 10:15:28 -0400
Received: (qmail invoked by alias); 28 Jun 2007 14:15:26 -0000
Received: from pD9EBB5BD.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.181.189]
  by mail.gmx.net (mp010) with SMTP; 28 Jun 2007 16:15:26 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1+HiApt9TKHPHB5hUDLLO4+rKTdKLu/NPPW8/f2vC
	DnHxVdTHqMMKKj
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51108>

There were places using "GIT_DIR" instead of GIT_DIR_ENVIRONMENT and
"GIT_CONFIG" instead of CONFIG_ENVIRONMENT.  This makes it easier to
find all places touching an environment variable using git grep or
similar tools.

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
I only found one other place where a string was used directly even
though there is a constant: GIT_REFLOG_ACTION is only defined in
git-revert.c and builtin-fetch--tool.c uses the environment variable
too.  At least when searching with grep this makes no problem because
the name of the constant is the same as the string it is defined to..
---
 builtin-config.c |    4 ++--
 path.c           |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index 3f7cab1..7d2063c 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -178,14 +178,14 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			char *home = getenv("HOME");
 			if (home) {
 				char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
-				setenv("GIT_CONFIG", user_config, 1);
+				setenv(CONFIG_ENVIRONMENT, user_config, 1);
 				free(user_config);
 			} else {
 				die("$HOME not set");
 			}
 		}
 		else if (!strcmp(argv[1], "--system"))
-			setenv("GIT_CONFIG", ETC_GITCONFIG, 1);
+			setenv(CONFIG_ENVIRONMENT, ETC_GITCONFIG, 1);
 		else if (!strcmp(argv[1], "--null") || !strcmp(argv[1], "-z")) {
 			term = '\0';
 			delim = '\n';
diff --git a/path.c b/path.c
index 6395cf2..c4ce962 100644
--- a/path.c
+++ b/path.c
@@ -252,7 +252,7 @@ char *enter_repo(char *path, int strict)
 
 	if (access("objects", X_OK) == 0 && access("refs", X_OK) == 0 &&
 	    validate_headref("HEAD") == 0) {
-		setenv("GIT_DIR", ".", 1);
+		setenv(GIT_DIR_ENVIRONMENT, ".", 1);
 		check_repository_format();
 		return path;
 	}
-- 
1.5.2.2.1398.ga4b05
