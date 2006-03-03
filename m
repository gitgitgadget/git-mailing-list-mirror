From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 8/9] contrib/git-svn: add --id/-i=$GIT_SVN_ID command-line switch
Date: Fri, 3 Mar 2006 01:20:09 -0800
Message-ID: <11413776092524-git-send-email-normalperson@yhbt.net>
References: <11413776092493-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 03 10:20:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FF6Sj-00041U-RH
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 10:20:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196AbWCCJUW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Mar 2006 04:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752211AbWCCJUW
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Mar 2006 04:20:22 -0500
Received: from hand.yhbt.net ([66.150.188.102]:1923 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1752212AbWCCJUK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Mar 2006 04:20:10 -0500
Received: from Muzzle (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id BCB597DC027;
	Fri,  3 Mar 2006 01:20:09 -0800 (PST)
In-Reply-To: <11413776092493-git-send-email-normalperson@yhbt.net>
X-Mailer: git-send-email
To: junkio@cox.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17143>

I ended up using GIT_SVN_ID far more than I ever thought I
would.  Typing less is good.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn.perl |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

1d3dc63f7ed276863c71f9a212471658f359ef75
diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 041791b..db199a3 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -10,13 +10,6 @@ use vars qw/	$AUTHOR $VERSION
 $AUTHOR = 'Eric Wong <normalperson@yhbt.net>';
 $VERSION = '0.10.0';
 $GIT_DIR = $ENV{GIT_DIR} || "$ENV{PWD}/.git";
-$GIT_SVN = $ENV{GIT_SVN_ID} || 'git-svn';
-$GIT_SVN_INDEX = "$GIT_DIR/$GIT_SVN/index";
-$ENV{GIT_DIR} ||= $GIT_DIR;
-$SVN_URL = undef;
-$REV_DIR = "$GIT_DIR/$GIT_SVN/revs";
-$SVN_WC = "$GIT_DIR/$GIT_SVN/tree";
-
 # make sure the svn binary gives consistent output between locales and TZs:
 $ENV{TZ} = 'UTC';
 $ENV{LC_ALL} = 'C';
@@ -78,7 +71,17 @@ foreach (keys %cmd) {
 my %opts;
 %opts = %{$cmd{$cmd}->[2]} if (defined $cmd);
 
-GetOptions(%opts, 'help|H|h' => \$_help, 'version|V' => \$_version ) or exit 1;
+GetOptions(%opts, 'help|H|h' => \$_help,
+		'version|V' => \$_version,
+		'id|i=s' => \$GIT_SVN) or exit 1;
+
+$GIT_SVN ||= $ENV{GIT_SVN_ID} || 'git-svn';
+$GIT_SVN_INDEX = "$GIT_DIR/$GIT_SVN/index";
+$ENV{GIT_DIR} ||= $GIT_DIR;
+$SVN_URL = undef;
+$REV_DIR = "$GIT_DIR/$GIT_SVN/revs";
+$SVN_WC = "$GIT_DIR/$GIT_SVN/tree";
+
 usage(0) if $_help;
 version() if $_version;
 usage(1) unless defined $cmd;
-- 
1.2.3.g4676
