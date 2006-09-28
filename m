From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb: Don't use quotemeta on internally generated strings
Date: Thu, 28 Sep 2006 16:51:43 -0700 (PDT)
Message-ID: <20060928235143.9386.qmail@web31804.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1088876335-1159487503=:8520"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Sep 29 01:52:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT5fQ-00068k-IC
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 01:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbWI1Xvp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 19:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965004AbWI1Xvp
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 19:51:45 -0400
Received: from web31804.mail.mud.yahoo.com ([68.142.207.67]:44138 "HELO
	web31804.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965003AbWI1Xvo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 19:51:44 -0400
Received: (qmail 9388 invoked by uid 60001); 28 Sep 2006 23:51:43 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=fSp3pOr98H0rZkowD0ZvGQstNI1nEimlFvzA9oTARwN/LOPJpmx2OAmEVOOfb3E/zfhy4ZjbpeUqnW4FsaRJcbTUYgHafe3yHGPMzlr23APh3QcaxFnIt1GUlOtk0aRHe3RJlPrpbROlWrM2jxHYDjSn4vMtV4XKHHW7sIt6tgs=  ;
Received: from [64.215.88.90] by web31804.mail.mud.yahoo.com via HTTP; Thu, 28 Sep 2006 16:51:43 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28073>

--0-1088876335-1159487503=:8520
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Do not use quotemeta on internally generated strings
such as filenames of snapshot, blobs, etc.
quotemeta quotes any characters not matching /A-Za-z_0-9/.
Which means that we get strings like this:

before: linux\-2\.6\.git\-5c2d97cb31fb77981797fec46230ca005b865799\.tar\.gz
after:  linux-2.6.git-5c2d97cb31fb77981797fec46230ca005b865799.tar.gz

This patch fixes this.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.perl |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

--0-1088876335-1159487503=:8520
Content-Type: text/plain; name="p6.txt"
Content-Description: 541148421-p6.txt
Content-Disposition: inline; filename="p6.txt"

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9052647..fdbdb82 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2660,7 +2660,7 @@ sub git_blob_plain {
 	print $cgi->header(
 		-type => "$type",
 		-expires=>$expires,
-		-content_disposition => 'inline; filename="' . quotemeta($save_as) . '"');
+		-content_disposition => 'inline; filename="' . "$save_as" . '"');
 	undef $/;
 	binmode STDOUT, ':raw';
 	print <$fd>;
@@ -2835,7 +2835,7 @@ sub git_snapshot {
 	print $cgi->header(
 		-type => 'application/x-tar',
 		-content_encoding => $ctype,
-		-content_disposition => 'inline; filename="' . quotemeta($filename) . '"',
+		-content_disposition => 'inline; filename="' . "$filename" . '"',
 		-status => '200 OK');
 
 	my $git_command = git_cmd_str();
@@ -2933,7 +2933,6 @@ sub git_commit {
 
 	my @views_nav = ();
 	if (defined $file_name && defined $co{'parent'}) {
-		my $parent = $co{'parent'};
 		push @views_nav,
 			$cgi->a({-href => href(action=>"blame", hash_parent=>$parent, file_name=>$file_name)},
 			        "blame");
@@ -3145,7 +3144,7 @@ sub git_blobdiff {
 			-type => 'text/plain',
 			-charset => 'utf-8',
 			-expires => $expires,
-			-content_disposition => 'inline; filename="' . quotemeta($file_name) . '.patch"');
+			-content_disposition => 'inline; filename="' . "$file_name" . '.patch"');
 
 		print "X-Git-Url: " . $cgi->self_url() . "\n\n";
 
@@ -3248,7 +3247,7 @@ sub git_commitdiff {
 			-type => 'text/plain',
 			-charset => 'utf-8',
 			-expires => $expires,
-			-content_disposition => 'inline; filename="' . quotemeta($filename) . '"');
+			-content_disposition => 'inline; filename="' . "$filename" . '"');
 		my %ad = parse_date($co{'author_epoch'}, $co{'author_tz'});
 		print <<TEXT;
 From: $co{'author'}
-- 
1.4.2.1.g05f0f


--0-1088876335-1159487503=:8520--
