From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: remove files from the index before adding/updating
Date: Fri, 17 Feb 2006 21:04:47 -0800
Message-ID: <11402390872301-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Feb 18 06:04:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAKH6-0000zt-9S
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 06:04:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWBRFEt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Feb 2006 00:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWBRFEt
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Feb 2006 00:04:49 -0500
Received: from hand.yhbt.net ([66.150.188.102]:55460 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1750806AbWBRFEs (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Feb 2006 00:04:48 -0500
Received: from BL4ST (user-118bgak.cable.mindspring.com [66.133.193.84])
	by hand.yhbt.net (Postfix) with SMTP id 9C0857DC005;
	Fri, 17 Feb 2006 21:04:47 -0800 (PST)
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16385>

This fixes a bug when importing where a directory gets removed/renamed
but is immediately replaced by a file of the same name in the same
revision.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

c142c70866ab8ce1765e4b88506aa79b5c5c1427
diff --git a/contrib/git-svn/git-svn b/contrib/git-svn/git-svn
index 2caf057..71a8b3b 100755
--- a/contrib/git-svn/git-svn
+++ b/contrib/git-svn/git-svn
@@ -580,13 +580,12 @@ sub svn_info {
 sub sys { system(@_) == 0 or croak $? }
 
 sub git_addremove {
-	system(	"git-ls-files -z --others ".
+	system( "git-diff-files --name-only -z ".
+				" | git-update-index --remove -z --stdin; ".
+		"git-ls-files -z --others ".
 			"'--exclude-from=$GIT_DIR/$GIT_SVN/info/exclude'".
-				"| git-update-index --add -z --stdin; ".
-		"git-ls-files -z --deleted ".
-				"| git-update-index --remove -z --stdin; ".
-		"git-ls-files -z --modified".
-				"| git-update-index -z --stdin") == 0 or croak $?
+				" | git-update-index --add -z --stdin; "
+		) == 0 or croak $?
 }
 
 sub s_to_file {
-- 
1.2.0.g4d1a-dirty
