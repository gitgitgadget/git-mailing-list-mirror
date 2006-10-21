From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/4] gitweb: Improve git_print_page_path
Date: Sat, 21 Oct 2006 17:53:55 +0200
Message-ID: <200610211753.56029.jnareb@gmail.com>
References: <200610211750.49188.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Oct 21 17:55:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbJBc-0004Tu-NP
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 17:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993111AbWJUPy6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 11:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993120AbWJUPy5
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 11:54:57 -0400
Received: from hu-out-0506.google.com ([72.14.214.225]:48549 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S2993111AbWJUPyz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 11:54:55 -0400
Received: by hu-out-0506.google.com with SMTP id 28so571711hub
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 08:54:55 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kOwUoNWsGmGF98q0ilGawJXQclXwjnEJ4DPWGtUHXnRP1ymbAdHEaFg/QB69V46m9VnIPndmrQbxZpU0dsKfjuGx65L70DGQ9gbP+aXrvpkzGh4d2qtw+xhe6Wu5IbhTLbCwUqa/gbl8HfVBwgLBEZ6hdM//Ic/Mk0DJwbD8T3g=
Received: by 10.67.105.19 with SMTP id h19mr3955862ugm;
        Sat, 21 Oct 2006 08:54:54 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id s1sm2762273uge.2006.10.21.08.54.54;
        Sat, 21 Oct 2006 08:54:54 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200610211750.49188.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29623>

Add link to "tree root" (root directory) also for not defined name,
for example for "tree" action without defined "file_name" which means
"tree root".

Add " / " at the end of path when $type eq "tree".

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Consistency (and code simplification).

 gitweb/gitweb.perl |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 209b318..126cf3c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1615,17 +1615,16 @@ sub git_print_page_path {
 	my $type = shift;
 	my $hb = shift;
 
-	if (!defined $name) {
-		print "<div class=\"page_path\">/</div>\n";
-	} else {
+
+	print "<div class=\"page_path\">";
+	print $cgi->a({-href => href(action=>"tree", hash_base=>$hb),
+	              -title => 'tree root'}, "[$project]");
+	print " / ";
+	if (defined $name) {
 		my @dirname = split '/', $name;
 		my $basename = pop @dirname;
 		my $fullname = '';
 
-		print "<div class=\"page_path\">";
-		print $cgi->a({-href => href(action=>"tree", hash_base=>$hb),
-			      -title => 'tree root'}, "[$project]");
-		print " / ";
 		foreach my $dir (@dirname) {
 			$fullname .= ($fullname ? '/' : '') . $dir;
 			print $cgi->a({-href => href(action=>"tree", file_name=>$fullname,
@@ -1641,11 +1640,12 @@ sub git_print_page_path {
 			print $cgi->a({-href => href(action=>"tree", file_name=>$file_name,
 			                             hash_base=>$hb),
 			              -title => $name}, esc_html($basename));
+			print " / ";
 		} else {
 			print esc_html($basename);
 		}
-		print "<br/></div>\n";
 	}
+	print "<br/></div>\n";
 }
 
 # sub git_print_log (\@;%) {
-- 
1.4.2.1
