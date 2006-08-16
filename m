From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] gitweb: use common parameter parsing and generation for "o", too.
Date: Thu, 17 Aug 2006 00:28:37 +0200
Message-ID: <11557673212235-git-send-email-tali@admingilde.org>
References: <11557673213372-git-send-email-tali@admingilde.org>
Cc: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Thu Aug 17 00:29:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDTsY-00005o-JL
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 00:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWHPW2s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 18:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWHPW2s
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 18:28:48 -0400
Received: from agent.admingilde.org ([213.95.21.5]:12744 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP id S932294AbWHPW2r
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Aug 2006 18:28:47 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GDTsP-0007OP-Sk; Thu, 17 Aug 2006 00:28:42 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.2.rc2.gf055
In-Reply-To: <11557673213372-git-send-email-tali@admingilde.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25533>

The "o" (list order) parameter was handled special.
Now it is generated with the common href() function and parsed together with
all other parameters.

Signed-off-by: Martin Waitz <tali@admingilde.org>
---
 gitweb/gitweb.perl |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 72e687e..ed6bd0e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -91,6 +91,11 @@ if (defined $action) {
 	}
 }
 
+our $order = $cgi->param('o');
+if (defined $order && $order !~ m/project|descr|owner|age/) {
+	die_error(undef, "Unknown order parameter");
+}
+
 our $project = ($cgi->param('p') || $ENV{'PATH_INFO'});
 if (defined $project) {
 	$project =~ s|^/||;
@@ -197,6 +202,7 @@ sub href(%) {
 		hash_base => "hb",
 		page => "pg",
 		searchtext => "s",
+		order => "o",
 	);
 
 	my %params = @_;
@@ -1577,11 +1583,6 @@ ## =====================================
 ## actions
 
 sub git_project_list {
-	my $order = $cgi->param('o');
-	if (defined $order && $order !~ m/project|descr|owner|age/) {
-		die_error(undef, "Unknown order parameter");
-	}
-
 	my @list = git_get_projects_list();
 	my @projects;
 	if (!@list) {
@@ -1624,7 +1625,7 @@ sub git_project_list {
 		print "<th>Project</th>\n";
 	} else {
 		print "<th>" .
-		      $cgi->a({-href => "$my_uri?" . esc_param("o=project"),
+		      $cgi->a({-href => href(order=>"project"),
 		               -class => "header"}, "Project") .
 		      "</th>\n";
 	}
@@ -1633,7 +1634,7 @@ sub git_project_list {
 		print "<th>Description</th>\n";
 	} else {
 		print "<th>" .
-		      $cgi->a({-href => "$my_uri?" . esc_param("o=descr"),
+		      $cgi->a({-href => href(order=>"descr"),
 		               -class => "header"}, "Description") .
 		      "</th>\n";
 	}
@@ -1642,7 +1643,7 @@ sub git_project_list {
 		print "<th>Owner</th>\n";
 	} else {
 		print "<th>" .
-		      $cgi->a({-href => "$my_uri?" . esc_param("o=owner"),
+		      $cgi->a({-href => href(order=>"owner"),
 		               -class => "header"}, "Owner") .
 		      "</th>\n";
 	}
@@ -1651,7 +1652,7 @@ sub git_project_list {
 		print "<th>Last Change</th>\n";
 	} else {
 		print "<th>" .
-		      $cgi->a({-href => "$my_uri?" . esc_param("o=age"),
+		      $cgi->a({-href => href(order=>"age"),
 		               -class => "header"}, "Last Change") .
 		      "</th>\n";
 	}
-- 
1.4.2.rc2.gf055
