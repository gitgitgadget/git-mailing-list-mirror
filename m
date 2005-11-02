From: Yaacov Akiba Slama <ya@slamail.org>
Subject: [PATCH 2/7] Add node_kind function to differentiate between file and directory
Date: Wed, 02 Nov 2005 23:51:57 +0200
Message-ID: <E1EXQWT-000508-Sz@localhost.localdomain>
X-From: git-owner@vger.kernel.org Wed Nov 02 22:52:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXQWx-0005A5-2E
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 22:52:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965286AbVKBVwX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 16:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965284AbVKBVwX
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 16:52:23 -0500
Received: from [195.140.142.33] ([195.140.142.33]:45521 "EHLO
	c1-033.cyaris.net") by vger.kernel.org with ESMTP id S965286AbVKBVwV
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 16:52:21 -0500
Received: from localhost ([127.0.33.1] helo=localhost.localdomain)
	by c1-033.cyaris.net with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1EXQWb-0003cc-Kq; Wed, 02 Nov 2005 22:52:10 +0100
Received: from yaslama by localhost.localdomain with local (Exim 4.54)
	id 1EXQWT-000508-Sz; Wed, 02 Nov 2005 23:51:57 +0200
X-Spam-Score: -2.8 (--)
X-Spam-Report: Spam detection software, running on the system "c1-033.cyaris.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Signed-off-by: Yaacov Akiba Slama <ya@slamail.org> ---
	git-svnimport.perl | 21 ++++++++++++++++++--- 1 files changed, 18
	insertions(+), 3 deletions(-) [...] 
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11047>

Signed-off-by: Yaacov Akiba Slama <ya@slamail.org>

---

 git-svnimport.perl |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)

applies-to: e230cf653f1af6412e43f9b527465406bdb76ece
c38f34212ace329637fd87fb11247f6a5733e47f
diff --git a/git-svnimport.perl b/git-svnimport.perl
index 5bf9ef2..83b70f9 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -260,10 +260,17 @@ EOM
 
 open BRANCHES,">>", "$git_dir/svn2git";
 
-sub get_file($$$) {
-	my($rev,$branch,$path) = @_;
+sub node_kind($$$) {
+	my ($branch, $path, $revision) = @_;
+	my $pool=SVN::Pool->new;
+	my $kind = $svn->{'svn'}->check_path(revert_split_path($branch,$path),$revision,$pool);
+	$pool->clear;
+	return $kind;
+}
+
+sub revert_split_path($$) {
+	my($branch,$path) = @_;
 
-	# revert split_path(), below
 	my $svnpath;
 	$path = "" if $path eq "/"; # this should not happen, but ...
 	if($branch eq "/") {
@@ -274,6 +281,14 @@ sub get_file($$$) {
 		$svnpath = "$branch_name/$branch/$path";
 	}
 
+	return $svnpath
+}
+
+sub get_file($$$) {
+	my($rev,$branch,$path) = @_;
+
+	my $svnpath = revert_split_path($branch,$path);
+
 	# now get it
 	my $name;
 	if($opt_d) {
---
0.99.9.GIT
