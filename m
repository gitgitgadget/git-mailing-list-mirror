From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] svnimport: exit cleanly when we are up to date
Date: Thu, 15 Dec 2005 19:26:46 +1300
Message-ID: <11346280062155-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Thu Dec 15 07:19:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmmRY-0001cB-45
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 07:18:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161119AbVLOGSR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 01:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161149AbVLOGSR
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 01:18:17 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:18059 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1161119AbVLOGSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 01:18:16 -0500
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1EmmRS-0004Pw-Du; Thu, 15 Dec 2005 19:18:14 +1300
Received: from mltest ([127.0.0.1])
	by mltest with smtp (Exim 3.36 #1 (Debian))
	id 1EmmZi-00033Y-00; Thu, 15 Dec 2005 19:26:46 +1300
In-Reply-To: 
X-Mailer: git-send-email
To: smurf@smurf.noris.de, git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13682>

Now we detect that the SVN repo does not have new commits for us and exit
cleanly, removing the lockfile. With this, svnimport supports being run
on a cronjob to maintain a SVN2GIT gateway.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>


---

 git-svnimport.perl |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

0116ebb61f1e11b3c43d4e80ac899d81f24a62d4
diff --git a/git-svnimport.perl b/git-svnimport.perl
index 65868a9..cb241d1 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -736,6 +736,13 @@ sub commit_all {
 }
 
 $opt_l = $svn->{'maxrev'} if not defined $opt_l or $opt_l > $svn->{'maxrev'};
+
+if ($svn->{'maxrev'} < $current_rev) {
+    print "Up to date: no new revisions to fetch!\n" if $opt_v;
+    unlink("$git_dir/SVN2GIT_HEAD");
+    exit;
+}
+
 print "Fetching from $current_rev to $opt_l ...\n" if $opt_v;
 
 my $pool=SVN::Pool->new;
-- 
0.99.9.GIT
