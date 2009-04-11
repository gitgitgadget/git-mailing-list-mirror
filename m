From: Ben Jackson <ben@ben.com>
Subject: [PATCH v2 2/2] Save init/clone --ignore-paths option as svn-remotes.svn.ignore-paths
Date: Sat, 11 Apr 2009 10:46:18 -0700
Message-ID: <1239471978-45479-2-git-send-email-ben@ben.com>
References: <1239471978-45479-1-git-send-email-ben@ben.com>
Cc: normalperson@yhbt.net, gitster@pobox.com, ben@ben.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 11 19:48:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LshJD-0008VR-75
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 19:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758211AbZDKRqd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 13:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758156AbZDKRqc
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 13:46:32 -0400
Received: from kronos.home.ben.com ([71.117.242.19]:65057 "EHLO
	kronos.home.ben.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758128AbZDKRqb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 13:46:31 -0400
Received: from kronos.home.ben.com (localhost [127.0.0.1])
	by kronos.home.ben.com (8.14.3/8.14.3) with ESMTP id n3BHkJZr045514;
	Sat, 11 Apr 2009 10:46:19 -0700 (PDT)
Received: (from bjj@localhost)
	by kronos.home.ben.com (8.14.3/8.14.3/Submit) id n3BHkJNO045510;
	Sat, 11 Apr 2009 10:46:19 -0700 (PDT)
	(envelope-from bjj)
X-Mailer: git-send-email 1.6.0.1
In-Reply-To: <1239471978-45479-1-git-send-email-ben@ben.com>
X-Virus-Scanned: ClamAV 0.93.3/9224/Fri Apr 10 14:49:29 2009 on kronos.home.ben.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116304>

Signed-off-by: Ben Jackson <ben@ben.com>
---
 Documentation/git-svn.txt       |    4 ++++
 git-svn.perl                    |    3 +++
 t/t9134-git-svn-ignore-paths.sh |    4 ++--
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index af2d6c2..cd47bff 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -85,6 +85,10 @@ COMMANDS
 	specified, the prefix must include a trailing slash.
 	Setting a prefix is useful if you wish to track multiple
 	projects that share a common repository.
+--ignore-paths=<regex>;;
+	When passed to 'init' or 'clone' this regular expression will
+	be preserved as a config key.  See 'fetch' for a description
+	of '--ignore-paths'.
 
 'fetch'::
 	Fetch unfetched revisions from the Subversion remote we are
diff --git a/git-svn.perl b/git-svn.perl
index 8e195ed..a04d158 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -334,6 +334,9 @@ sub do_git_init_db {
 		command_noisy('config', "$pfx.$i", $icv{$i});
 		$set = $i;
 	}
+	my $ignore_regex = \$SVN::Git::Fetcher::_ignore_regex;
+	command_noisy('config', "$pfx.ignore-paths", $$ignore_regex)
+		if defined $$ignore_regex;
 }
 
 sub init_subdir {
diff --git a/t/t9134-git-svn-ignore-paths.sh b/t/t9134-git-svn-ignore-paths.sh
index b9a1597..71fdc4a 100755
--- a/t/t9134-git-svn-ignore-paths.sh
+++ b/t/t9134-git-svn-ignore-paths.sh
@@ -40,10 +40,10 @@ test_expect_success 'init+fetch an SVN repository with ignored www directory' '
 	test_cmp expect expect2
 '
 
-test_expect_success 'set persistent ignore-paths config' '
+test_expect_success 'verify ignore-paths config saved by clone' '
 	(
 	    cd g &&
-	    git config svn-remote.svn.ignore-paths "^www"
+	    git config --get svn-remote.svn.ignore-paths | fgrep "www"
 	)
 '
 
-- 
1.6.2.2.487.gd6486
