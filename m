From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Advertise per branch RSS/Atom feeds
Date: Sat, 11 Aug 2007 02:41:41 -0700
Message-ID: <7vps1ummqy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 11 11:41:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJnTg-0001Rz-0e
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 11:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755874AbXHKJlo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 05:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755813AbXHKJln
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 05:41:43 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:37404 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755555AbXHKJln (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 05:41:43 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070811094141.GJOF24055.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sat, 11 Aug 2007 05:41:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aZhh1X00a1kojtg0000000; Sat, 11 Aug 2007 05:41:42 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55597>

The feeder code had provisions to accept 'h' parameter to
specify which branch to send the feed data from, but there was
no link that advertised this capability on the pages.

This adds h parameter to the footer of shortlog/log page for the
branch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 gitweb/gitweb.perl |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f282a67..6c1da14 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2378,12 +2378,16 @@ sub git_footer_html {
 	print "<div class=\"page_footer\">\n";
 	if (defined $project) {
 		my $descr = git_get_project_description($project);
+		my @tips = ();
+		if ($hash !~ /^[0-9a-fA-F]{40}$/) {
+			@tips = (hash => $hash);
+		}
 		if (defined $descr) {
 			print "<div class=\"page_footer_text\">" . esc_html($descr) . "</div>\n";
 		}
-		print $cgi->a({-href => href(action=>"rss"),
+		print $cgi->a({-href => href(action=>"rss", @tips),
 		              -class => "rss_logo"}, "RSS") . " ";
-		print $cgi->a({-href => href(action=>"atom"),
+		print $cgi->a({-href => href(action=>"atom", @tips),
 		              -class => "rss_logo"}, "Atom") . "\n";
 	} else {
 		print $cgi->a({-href => href(project=>undef, action=>"opml"),
