From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] gitweb: make PATHINFO URL generation conditional on input URL.
Date: Tue, 3 Oct 2006 20:08:32 +0200
Message-ID: <20061003180832.GP2871@admingilde.org>
References: <20060929221641.GC2871@admingilde.org> <7v8xk2jofc.fsf@assigned-by-dhcp.cox.net> <efu3u4$tc9$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 03 20:09:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUoh3-0001AP-9Z
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 20:08:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbWJCSIe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 14:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbWJCSIe
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 14:08:34 -0400
Received: from agent.admingilde.org ([213.95.21.5]:29893 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP id S964876AbWJCSId
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 Oct 2006 14:08:33 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GUogy-0004bN-Kq; Tue, 03 Oct 2006 20:08:32 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <efu3u4$tc9$1@sea.gmane.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28287>

Now the feature 'pathinfo' configuration only applies to the project
list.  All other URLs are generated in the form the webpage was
called itself.

Signed-off-by: Martin Waitz <tali@admingilde.org>
---
 gitweb/gitweb.perl |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0ff6f7c..70246de 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -206,6 +206,8 @@ our $git_version = qx($GIT --version) =~
 
 $projects_list ||= $projectroot;
 
+our $use_pathinfo_url = gitweb_check_feature('pathinfo');
+
 # ======================================================================
 # input validation and dispatch
 our $action = $cgi->param('a');
@@ -226,6 +228,8 @@ if (defined $project) {
 		undef $project;
 		die_error(undef, "No such project");
 	}
+	# we got called without PATH_INFO, let's keep it that way.
+	$use_pathinfo_url = 0;
 }
 
 our $file_name = $cgi->param('f');
@@ -308,6 +312,10 @@ sub evaluate_path_info {
 		undef $project;
 		return;
 	}
+	
+	# we were called using a PATH_INFO URL, let's keep it that way.
+	$use_pathinfo_url = 1;
+
 	# do not change any parameters if an action is given using the query string
 	return if $action;
 	$path_info =~ s,^$project/*,,;
@@ -402,8 +410,7 @@ sub href(%) {
 
 	$params{'project'} = $project unless exists $params{'project'};
 
-	my ($use_pathinfo) = gitweb_check_feature('pathinfo');
-	if ($use_pathinfo) {
+	if ($use_pathinfo_url) {
 		# use PATH_INFO for project name
 		$href .= "/$params{'project'}" if defined $params{'project'};
 		delete $params{'project'};
-- 
1.4.2.3

-- 
Martin Waitz
