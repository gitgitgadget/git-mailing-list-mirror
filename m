From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] contrib/git-svn: force GIT_DIR to an absolute path
Date: Wed, 29 Mar 2006 22:37:18 -0800
Message-ID: <1143700638461-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Mar 30 08:37:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOqmZ-0001mw-8o
	for gcvg-git@gmane.org; Thu, 30 Mar 2006 08:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWC3GhU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Mar 2006 01:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbWC3GhU
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Mar 2006 01:37:20 -0500
Received: from hand.yhbt.net ([66.150.188.102]:55741 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932072AbWC3GhT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Mar 2006 01:37:19 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 4AB1E2DC035;
	Wed, 29 Mar 2006 22:37:18 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>, <git@vger.kernel.org>
X-Mailer: git-send-email
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18191>

We chdir internally, so we need a consistent GIT_DIR variable.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn.perl |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

40a9f8f87bbf041966c61431536186d03acefb50
diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 3e5733e..59dd504 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -9,7 +9,11 @@ use vars qw/	$AUTHOR $VERSION
 		$GIT_DIR $REV_DIR/;
 $AUTHOR = 'Eric Wong <normalperson@yhbt.net>';
 $VERSION = '0.11.0';
-$GIT_DIR = $ENV{GIT_DIR} || "$ENV{PWD}/.git";
+
+use Cwd qw/abs_path/;
+$GIT_DIR = abs_path($ENV{GIT_DIR} || '.git');
+$ENV{GIT_DIR} = $GIT_DIR;
+
 # make sure the svn binary gives consistent output between locales and TZs:
 $ENV{TZ} = 'UTC';
 $ENV{LC_ALL} = 'C';
@@ -69,7 +73,6 @@ GetOptions(%opts, 'help|H|h' => \$_help,
 
 $GIT_SVN ||= $ENV{GIT_SVN_ID} || 'git-svn';
 $GIT_SVN_INDEX = "$GIT_DIR/$GIT_SVN/index";
-$ENV{GIT_DIR} ||= $GIT_DIR;
 $SVN_URL = undef;
 $REV_DIR = "$GIT_DIR/$GIT_SVN/revs";
 $SVN_WC = "$GIT_DIR/$GIT_SVN/tree";
-- 
1.3.0.rc1.g709a5
