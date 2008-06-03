From: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
Subject: [PATCH] Make cell alignment more robust in gitweb blame
Date: Tue,  3 Jun 2008 12:14:20 +0200
Message-ID: <1212488060-23251-2-git-send-email-rgarciasuarez@gmail.com>
References: <1212488060-23251-1-git-send-email-rgarciasuarez@gmail.com>
Cc: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 12:15:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3TXo-0002CK-TY
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 12:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756376AbYFCKOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 06:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756349AbYFCKOL
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 06:14:11 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:46967 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752659AbYFCKOI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 06:14:08 -0400
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id B3E585FE88;
	Tue,  3 Jun 2008 12:14:06 +0200 (CEST)
Received: from localhost.localdomain (inv75-3-82-241-119-67.fbx.proxad.net [82.241.119.67])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 9C4FA5FE82;
	Tue,  3 Jun 2008 12:14:06 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc1
In-Reply-To: <1212488060-23251-1-git-send-email-rgarciasuarez@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83632>

It appears that git-blame's returned group size can be wrong,
inducing the table display to be completely broken.

For gitweb to cope with that in a more robust manner, we can
drop the "rowspan" argument to the first <td> containing
the blame commit id, and just put empty cells instead,
whenever we have nothing to print in that column.

Signed-off-by: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
---
 gitweb/gitweb.perl |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 472326f..c760884 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4218,7 +4218,6 @@ HTML
 		if ($group_size) {
 			print "<td class=\"sha1\"";
 			print " title=\"". esc_html($author) . ", $date\"";
-			print " rowspan=\"$group_size\"" if ($group_size > 1);
 			print ">";
 			print $cgi->a({-href => href(action=>"commit",
 			                             hash=>$full_rev,
@@ -4226,6 +4225,9 @@ HTML
 			              esc_html($rev));
 			print "</td>\n";
 		}
+		else {
+			print "<td class=\"sha1\">&nbsp;</td>";
+		}
 		open (my $dd, "-|", git_cmd(), "rev-parse", '--', "$full_rev^")
 			or die_error(undef, "Open git-rev-parse failed");
 		my $parent_commit = <$dd>;
-- 
1.5.6.rc1
