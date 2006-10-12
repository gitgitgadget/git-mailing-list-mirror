From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: add a message encouraging use of SVN::* libraries
Date: Wed, 11 Oct 2006 18:19:55 -0700
Message-ID: <11606159952672-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Oct 12 03:20:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXpF9-0005IV-1M
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 03:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161342AbWJLBUJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 21:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965249AbWJLBUJ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 21:20:09 -0400
Received: from hand.yhbt.net ([66.150.188.102]:59788 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S965248AbWJLBUI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Oct 2006 21:20:08 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id DB9437DC08E;
	Wed, 11 Oct 2006 18:19:55 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 11 Oct 2006 18:19:55 -0700
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.3.rc2.g1cbb0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28767>

I'm using svn 1.4.0-4 in Debian unstable and apparently there's
a regression on the SVN side that prevents a symlink from
becoming a regular file (which git supports, of course).

It's not a noticeable regression for most people, but this broke
the full-svn-tests target in t/Makefile for me.

The SVN::* Perl libraries seem to have matured and improved over
the past year, and git-svn has supported them for several months
now, so with that I encourage all users to start using the
SVN::* Perl libraries with git-svn.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 84d2c58..a128d90 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -40,8 +40,22 @@ memoize('cmt_metadata');
 memoize('get_commit_time');
 
 my ($SVN_PATH, $SVN, $SVN_LOG, $_use_lib);
+
+sub nag_lib {
+	print STDERR <<EOF;
+! Please consider installing the SVN Perl libraries (version 1.1.0 or
+! newer).  You will generally get better performance and fewer bugs,
+! especially if you:
+! 1) have a case-insensitive filesystem
+! 2) replace symlinks with files (and vice-versa) in commits
+
+EOF
+}
+
 $_use_lib = 1 unless $ENV{GIT_SVN_NO_LIB};
 libsvn_load();
+nag_lib() unless $_use_lib;
+
 my $_optimize_commits = 1 unless $ENV{GIT_SVN_NO_OPTIMIZE_COMMITS};
 my $sha1 = qr/[a-f\d]{40}/;
 my $sha1_short = qr/[a-f\d]{4,40}/;
-- 
1.4.3.rc2.g1cbb0
