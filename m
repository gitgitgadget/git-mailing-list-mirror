From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] contrib/git-svn: remove the --no-stop-on-copy flag
Date: Thu, 9 Mar 2006 03:50:34 -0800
Message-ID: <20060309115034.GB11934@localdomain>
References: <20060307220837.GB27397@nowhere.earth> <20060308014207.GA31137@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 09 12:51:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHJg5-0001dM-Jl
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 12:51:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860AbWCILvY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 06:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751859AbWCILvY
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 06:51:24 -0500
Received: from hand.yhbt.net ([66.150.188.102]:2498 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751849AbWCILvX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Mar 2006 06:51:23 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 52BC57DC005;
	Thu,  9 Mar 2006 03:51:22 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu,  9 Mar 2006 03:50:34 -0800
To: Yann Dirson <ydirson@altern.org>, Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060308014207.GA31137@localdomain>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17411>

Output a big warning if somebody actually has a pre-1.0 version
of svn that doesn't support it.

Thanks to Yann Dirson for reminding me it still existed
and attempting to re-enable it :)

I think I subconciously removed support for it earlier...

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn.perl |   11 +++++++++++
 contrib/git-svn/git-svn.txt  |   13 -------------
 2 files changed, 11 insertions(+), 13 deletions(-)

0ec45e489232fad4f1aa3d2c648fa53295efd7ec
diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index dca4e5c..43b50ec 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -1019,6 +1019,17 @@ sub svn_compat_check {
 	if (grep /usage: checkout URL\[\@REV\]/,@co_help) {
 		$_svn_co_url_revs = 1;
 	}
+
+	# I really, really hope nobody hits this...
+	unless (grep /stop-on-copy/, (safe_qx(qw(svn log -h)))) {
+		print STDERR <<'';
+W: The installed svn version does not support the --stop-on-copy flag in
+   the log command.
+   Lets hope the directory you're tracking is not a branch or tag
+   and was never moved within the repository...
+
+		$_no_stop_copy = 1;
+	}
 }
 
 # *sigh*, new versions of svn won't honor -r<rev> without URL@<rev>,
diff --git a/contrib/git-svn/git-svn.txt b/contrib/git-svn/git-svn.txt
index 5fb5b7c..7a6e0c4 100644
--- a/contrib/git-svn/git-svn.txt
+++ b/contrib/git-svn/git-svn.txt
@@ -162,19 +162,6 @@ COMPATIBILITY OPTIONS
 	Otherwise, do not enable this flag unless you know what you're
 	doing.
 
---no-stop-on-copy::
-	Only used with the 'fetch' command.
-
-	By default, git-svn passes --stop-on-copy to avoid dealing with
-	the copied/renamed branch directory problem entirely.  A
-	copied/renamed branch is the result of a <SVN_URL> being created
-	in the past from a different source.  These are problematic to
-	deal with even when working purely with svn if you work inside
-	subdirectories.
-
-	Do not use this flag unless you know exactly what you're getting
-	yourself into.  You have been warned.
-
 Basic Examples
 ~~~~~~~~~~~~~~
 
-- 
1.2.4.ga2910
