From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC] gitweb: Restore old git_blame using git-annotate under "annotate"
Date: Sat, 26 Aug 2006 01:47:09 +0200
Message-ID: <200608260147.10880.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Aug 26 01:47:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGlOI-0004VB-Q3
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 01:47:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422926AbWHYXrH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Aug 2006 19:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbWHYXrH
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Aug 2006 19:47:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:20146 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932288AbWHYXrG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Aug 2006 19:47:06 -0400
Received: by ug-out-1314.google.com with SMTP id m3so1019830ugc
        for <git@vger.kernel.org>; Fri, 25 Aug 2006 16:47:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MlYxJRAAEYUMxC3xduRoJ2arxWct0pddLgjd84JPhxFqZA5Tewbf2DGGDeoPpVDsc675IbThEFtNBJsfqK5W8eilpQqC7w0haCFJJI2mxoiDfGCz+a+1Ozwo+oUXSu80zp11mVjFaT4cYEuPqnpOQtGihKvMtDPjpgWyVm8lzAQ=
Received: by 10.67.10.12 with SMTP id n12mr2223146ugi;
        Fri, 25 Aug 2006 16:47:04 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id s1sm1175037uge.2006.08.25.16.47.04;
        Fri, 25 Aug 2006 16:47:04 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26019>

Rename git_blame to git_annotate, and git_blame2 to git_blame.
Link git_annotate under "annotate" action.  Add link to "blame
in git_annotate, and to "annotate" in git_blame.

git_annotate doesn't work correctly yet - error during parsing
some lines.  Needs investigation.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Not for work, just for testing and comparing the two implementations.
Applies cleanly to 'next' (v1.4.2-g6580c6b).

 gitweb/gitweb.perl |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a6d6637..6344263 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -229,7 +229,8 @@ if (defined $searchtext) {
 
 # dispatch
 my %actions = (
-	"blame" => \&git_blame2,
+	"blame" => \&git_blame,
+	"annotate" => \&git_annotate,
 	"blobdiff" => \&git_blobdiff,
 	"blobdiff_plain" => \&git_blobdiff_plain,
 	"blob" => \&git_blob,
@@ -2166,7 +2167,7 @@ sub git_tag {
 	git_footer_html();
 }
 
-sub git_blame2 {
+sub git_blame {
 	my $fd;
 	my $ftype;
 
@@ -2193,6 +2194,9 @@ sub git_blame2 {
 		$cgi->a({-href => href(action=>"blob", hash=>$hash, hash_base=>$hash_base, file_name=>$file_name)},
 		        "blob") .
 		" | " .
+		$cgi->a({-href => href(action=>"annotate", hash=>$hash, hash_base=>$hash_base, file_name=>$file_name)},
+		        "annotate") .
+		" | " .
 		$cgi->a({-href => href(action=>"blame", file_name=>$file_name)},
 		        "head");
 	git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
@@ -2236,7 +2240,7 @@ HTML
 	git_footer_html();
 }
 
-sub git_blame {
+sub git_annotate {
 	my $fd;
 
 	if (!gitweb_check_feature('blame')) {
@@ -2258,6 +2262,9 @@ sub git_blame {
 		$cgi->a({-href => href(action=>"blob", hash=>$hash, hash_base=>$hash_base, file_name=>$file_name)},
 		        "blob") .
 		" | " .
+		$cgi->a({-href => href(action=>"blame", hash=>$hash, hash_base=>$hash_base, file_name=>$file_name)},
+		        "blame") .
+		" | " .
 		$cgi->a({-href => href(action=>"blame", file_name=>$file_name)},
 		        "head");
 	git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
-- 
1.4.1.1
