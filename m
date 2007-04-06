From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH(resend)] gitweb: Allow configuring the default projects order and add order 'none'
Date: Fri,  6 Apr 2007 23:58:24 +0200
Message-ID: <11758967042669-git-send-email-frank@lichtenheld.de>
Cc: Jakub Narebski <jnareb@gmail.com>, Junio C Hamano <junkio@cox.net>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 07 01:28:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZwSM-0007TG-FW
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 23:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbXDFV6v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 17:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbXDFV6v
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 17:58:51 -0400
Received: from mail.lenk.info ([217.160.134.107]:59454 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751572AbXDFV6u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 17:58:50 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HZwSY-0006Qu-3R; Fri, 06 Apr 2007 23:59:06 +0200
Received: from p54b0f96b.dip.t-dialin.net ([84.176.249.107] helo=goedel.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HZwSF-0001m9-TJ; Fri, 06 Apr 2007 23:58:48 +0200
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1HZwRs-0003BJ-OD; Fri, 06 Apr 2007 23:58:24 +0200
X-Mailer: git-send-email 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43929>

Introduce new configuration variable $default_projects_order
that can be used to specify the default order of projects on
the index page if no 'o' parameter is given.

Allow a new value 'none' for order that will cause the projects
to be in the order we learned about them. In case of reading the
list of projects from a file, this should be the order as they are
listed in the file. In case of reading the list of projects from
a directory this will probably give random results depending on the
filesystem in use.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 gitweb/gitweb.perl |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

Directly send after the other patch the first time, too, and equally
lost.

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 379c89c..1d265ea 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -71,6 +71,10 @@ our $logo_label = "git homepage";
 # source of projects list
 our $projects_list = "++GITWEB_LIST++";
 
+# default order of projects list
+# valid values are none, project, descr, owner, and age
+our $default_projects_order = "project";
+
 # show repository only if this file exists
 # (only effective if this variable evaluates to true)
 our $export_ok = "++GITWEB_EXPORT_OK++";
@@ -1131,7 +1135,6 @@ sub git_get_projects_list {
 		}
 		close $fd;
 	}
-	@list = sort {$a->{'path'} cmp $b->{'path'}} @list;
 	return @list;
 }
 
@@ -2618,7 +2621,7 @@ sub git_project_list_body {
 		push @projects, $pr;
 	}
 
-	$order ||= "project";
+	$order ||= $default_projects_order;
 	$from = 0 unless defined $from;
 	$to = $#projects if (!defined $to || $#projects < $to);
 
@@ -2977,7 +2980,7 @@ sub git_search_grep_body {
 
 sub git_project_list {
 	my $order = $cgi->param('o');
-	if (defined $order && $order !~ m/project|descr|owner|age/) {
+	if (defined $order && $order !~ m/none|project|descr|owner|age/) {
 		die_error(undef, "Unknown order parameter");
 	}
 
@@ -3000,7 +3003,7 @@ sub git_project_list {
 
 sub git_forks {
 	my $order = $cgi->param('o');
-	if (defined $order && $order !~ m/project|descr|owner|age/) {
+	if (defined $order && $order !~ m/none|project|descr|owner|age/) {
 		die_error(undef, "Unknown order parameter");
 	}
 
-- 
1.5.1
