From: Robert Fitzsimons <robfitz@273k.net>
Subject: [PATCH 3/4] gitweb: optimize git_shortlog_body.
Date: Fri, 22 Dec 2006 19:38:14 +0000
Message-ID: <11668162963240-git-send-email-robfitz@273k.net>
References: 200612191214.58474.jnareb@gmail.com <11668162952375-git-send-email-robfitz@273k.net> <11668162961084-git-send-email-robfitz@273k.net> <11668162963671-git-send-email-robfitz@273k.net>
Cc: Robert Fitzsimons <robfitz@273k.net>
X-From: git-owner@vger.kernel.org Fri Dec 22 20:39:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxqEZ-0003L4-AW
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 20:39:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411AbWLVTjH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 14:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752415AbWLVTjH
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 14:39:07 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:35577 "EHLO
	igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413AbWLVTjD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 14:39:03 -0500
Received: from [194.125.117.173] (helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.60)
	(envelope-from <robfitz@273k.net>)
	id 1GxqDH-0005n3-JL; Fri, 22 Dec 2006 19:37:51 +0000
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.3.g8aca-dirty
In-Reply-To: <11668162963671-git-send-email-robfitz@273k.net>
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=-2, required 7, autolearn=disabled,
	RCVD_IN_NERDS_IE -2.00)
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35203>

Don't call gitweb_have_snapshot from within the loop.

Signed-off-by: Robert Fitzsimons <robfitz@273k.net>
---
 gitweb/gitweb.perl |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 01e3a8a..d2ddac8 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2636,6 +2636,8 @@ sub git_shortlog_body {
 	# uses global variable $project
 	my ($revlist, $from, $to, $refs, $extra) = @_;
 
+	my $have_snapshot = gitweb_have_snapshot();
+
 	$from = 0 unless defined $from;
 	$to = $#{$revlist} if (!defined $to || $#{$revlist} < $to);
 
@@ -2663,7 +2665,7 @@ sub git_shortlog_body {
 		      $cgi->a({-href => href(action=>"commit", hash=>$commit)}, "commit") . " | " .
 		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff") . " | " .
 		      $cgi->a({-href => href(action=>"tree", hash=>$commit, hash_base=>$commit)}, "tree");
-		if (gitweb_have_snapshot()) {
+		if ($have_snapshot) {
 			print " | " . $cgi->a({-href => href(action=>"snapshot", hash=>$commit)}, "snapshot");
 		}
 		print "</td>\n" .
-- 
1.4.4.3.gc902c
