From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RFC/PATCH] enable rerere by default
Date: Tue, 6 Feb 2007 11:13:16 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702061103070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Feb 06 11:13:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HENKH-0007P6-Pr
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 11:13:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbXBFKNT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 05:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752029AbXBFKNT
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 05:13:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:48664 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751806AbXBFKNT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 05:13:19 -0500
Received: (qmail invoked by alias); 06 Feb 2007 10:13:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp049) with SMTP; 06 Feb 2007 11:13:17 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38830>


Since the theme of the upcoming release is the (true) Wow factor, we 
should enable this feature by default. New users are not likely to learn 
of that feature otherwise.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	I know it is quite late in the game for 1.5.0, but since the theme 
	is usability and user-friendliness, I cannot think of a better 
	release to enable rerere by default, if that should ever happen.

	Comments?

 builtin-init-db.c |    2 ++
 t/t4200-rerere.sh |    3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 12e43d0..2504507 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -260,6 +260,8 @@ static int create_default_files(const char *git_dir, const char *template_path)
 		/* allow template config file to override the default */
 		if (log_all_ref_updates == -1)
 		    git_config_set("core.logallrefupdates", "true");
+		strcpy(path + len, "rr-cache");
+		safe_create_dir(path, 1);
 	}
 	return reinit;
 }
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 91be272..8187038 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -37,9 +37,6 @@ git checkout -b second master
 git show first:a1 | sed 's/To die, t/To die! T/' > a1
 git commit -q -a -m second
 
-# activate rerere
-mkdir .git/rr-cache
-
 test_expect_failure 'conflicting merge' 'git pull . first'
 
 sha1=4f58849a60b4f969a2848966b6d02893b783e8fb
