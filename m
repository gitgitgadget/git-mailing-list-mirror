From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] gitweb: Allow configuring the default projects order and add order 'none'
Date: Mon, 19 Mar 2007 13:27:13 +0100
Message-ID: <11743072333326-git-send-email-frank@lichtenheld.de>
Cc: Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 19 13:27:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTGxQ-0002DT-0L
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 13:27:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932932AbXCSM1X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 08:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933238AbXCSM1X
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 08:27:23 -0400
Received: from mail.lenk.info ([217.160.134.107]:54100 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932932AbXCSM1W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 08:27:22 -0400
Received: from herkules.lenk.info ([213.239.194.154] helo=smtp.lenk.info)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HTGxf-0004Bu-SB; Mon, 19 Mar 2007 13:27:39 +0100
Received: from p54b0e006.dip.t-dialin.net ([84.176.224.6] helo=goedel.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HTGxM-0006Xn-JL; Mon, 19 Mar 2007 13:27:20 +0100
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1HTGxG-0002cN-5D; Mon, 19 Mar 2007 13:27:14 +0100
X-Mailer: git-send-email 1.5.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42608>

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

 This is intended to serve as an easy way to archive
 arbitrary default orders (e.g. by project's "importance").

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b297410..8f999ae 100755
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
1.5.0.3
