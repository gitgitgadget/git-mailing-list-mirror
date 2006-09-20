From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] gitweb: Fix showing of path in tree view
Date: Thu, 21 Sep 2006 01:12:24 +0200
Message-ID: <20060920231224.GN13132@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=fixed
X-From: git-owner@vger.kernel.org Thu Sep 21 01:13:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQBEz-0002k4-Hb
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 01:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWITXM0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 19:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWITXM0
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 19:12:26 -0400
Received: from w241.dkm.cz ([62.24.88.241]:2279 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750701AbWITXM0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 19:12:26 -0400
Received: (qmail 7738 invoked by uid 2001); 21 Sep 2006 01:12:24 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27427>

This patch fixes two things - links to all path elements except the last
one were broken since gitweb does not like the trailing slash in them, and
the root tree was not reachable from the subdirectory view.

To compensate for the one more slash in the front, the trailing slash is
not there anymore. ;-) I don't care if it stays there though.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 834a773..70f409e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1503,12 +1503,13 @@ sub git_print_page_path {
 		my $fullname = '';
 
 		print "<div class=\"page_path\">";
+		print $cgi->a({-href => href(action=>"tree", hash_base=>$hb),
+			      -title => '/'}, '/');
 		foreach my $dir (@dirname) {
-			$fullname .= $dir . '/';
+			$fullname .= ($fullname ? '/' : '') . $dir;
 			print $cgi->a({-href => href(action=>"tree", file_name=>$fullname,
 			                             hash_base=>$hb),
-			              -title => $fullname}, esc_html($dir));
-			print "/";
+			              -title => $fullname}, esc_html($dir . '/'));
 		}
 		if (defined $type && $type eq 'blob') {
 			print $cgi->a({-href => href(action=>"blob_plain", file_name=>$file_name,
@@ -1518,7 +1519,6 @@ sub git_print_page_path {
 			print $cgi->a({-href => href(action=>"tree", file_name=>$file_name,
 			                             hash_base=>$hb),
 			              -title => $name}, esc_html($basename));
-			print "/";
 		} else {
 			print esc_html($basename);
 		}
