From: Yaacov Akiba Slama <ya@slamail.org>
Subject: [PATCH 6/7] Fix an error when a svn revision consists only of the creation of a new tag
Date: Wed, 02 Nov 2005 23:51:57 +0200
Message-ID: <E1EXQWT-00050O-Vn@localhost.localdomain>
X-From: git-owner@vger.kernel.org Wed Nov 02 22:54:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXQXB-0005F2-4I
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 22:52:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965281AbVKBVw2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 16:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965284AbVKBVw2
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 16:52:28 -0500
Received: from [195.140.142.33] ([195.140.142.33]:49873 "EHLO
	c1-033.cyaris.net") by vger.kernel.org with ESMTP id S965288AbVKBVw0
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 16:52:26 -0500
Received: from localhost ([127.0.33.1] helo=localhost.localdomain)
	by c1-033.cyaris.net with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1EXQWc-0003cg-EU; Wed, 02 Nov 2005 22:52:15 +0100
Received: from yaslama by localhost.localdomain with local (Exim 4.54)
	id 1EXQWT-00050O-Vn; Wed, 02 Nov 2005 23:51:57 +0200
X-Spam-Score: -2.8 (--)
X-Spam-Report: Spam detection software, running on the system "c1-033.cyaris.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  directory (/tags/this_is_a_tag). Signed-off-by: Yaacov
	Akiba Slama <ya@slamail.org> --- [...] 
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11051>

directory (/tags/this_is_a_tag).

Signed-off-by: Yaacov Akiba Slama <ya@slamail.org>

---

 git-svnimport.perl |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

applies-to: 12064f4a47217c44cc28ffb5977ffcd245179b5f
f8f37463ee4c3b24249192345f81a16c0dd74f66
diff --git a/git-svnimport.perl b/git-svnimport.perl
index ae82a7c..e97f470 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -648,6 +648,10 @@ sub commit {
 		die "Error running git-commit-tree: $?\n" if $?;
 	}
 
+	if (not defined $cid) {
+		$cid = $branches{"/"}{"LAST"};
+	}
+
 	if(not defined $dest) {
 		print "... no known parent\n" if $opt_v;
 	} elsif(not $tag) {
@@ -664,6 +668,7 @@ sub commit {
 		# the tag was 'complex', i.e. did not refer to a "real" revision
 
 		$dest =~ tr/_/\./ if $opt_u;
+		$branch = $dest;
 
 		my $pid = open2($in, $out, 'git-mktag');
 		print $out ("object $cid\n".
---
0.99.9.GIT
