From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 5/7] gitweb: Use 'local $/ = undef;' before 'print <$fd>;'
Date: Sat, 26 Aug 2006 19:14:24 +0200
Message-ID: <11566124673653-git-send-email-jnareb@gmail.com>
References: <1156612392716-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 26 19:14:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GH1k8-00041P-Gd
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 19:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422883AbWHZROj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 13:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422879AbWHZROj
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 13:14:39 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:34950 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1422883AbWHZROg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Aug 2006 13:14:36 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k7QHDFFp004450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 26 Aug 2006 19:13:16 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k7QHERK4032747;
	Sat, 26 Aug 2006 19:14:27 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k7QHERN6032746;
	Sat, 26 Aug 2006 19:14:27 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <1156612392716-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26057>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 093deab..eae83e6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2017,6 +2017,7 @@ sub git_project_list {
 	if (-f $home_text) {
 		print "<div class=\"index_include\">\n";
 		open (my $fd, $home_text);
+		local $/ = undef;
 		print <$fd>;
 		close $fd;
 		print "</div>\n";
@@ -2395,11 +2396,10 @@ sub git_blob_plain {
 
 	print $cgi->header(-type => "$type",
 	                   -content_disposition => "inline; filename=\"$save_as\"");
-	undef $/;
 	binmode STDOUT, ':raw';
+	local $/ = undef;
 	print <$fd>;
 	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
-	$/ = "\n";
 	close $fd;
 }
 
@@ -2585,6 +2585,7 @@ sub git_snapshot {
 	open my $fd, "-|", "$GIT tar-tree $hash \'$project\' | $command" or
 		die_error(undef, "Execute git-tar-tree failed.");
 	binmode STDOUT, ':raw';
+	local $/ = undef;
 	print <$fd>;
 	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
 	close $fd;
-- 
1.4.1.1
