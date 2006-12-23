From: Robert Fitzsimons <robfitz@273k.net>
Subject: [PATCH 3/3] gitweb: Allow search to be disabled from the config file.
Date: Sat, 23 Dec 2006 03:35:16 +0000
Message-ID: <11668449274162-git-send-email-robfitz@273k.net>
References: <11668449162618-git-send-email-robfitz@273k.net> <11668449271631-git-send-email-robfitz@273k.net>
Cc: Robert Fitzsimons <robfitz@273k.net>
X-From: git-owner@vger.kernel.org Sat Dec 23 04:35:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxxfO-0002FR-2L
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 04:35:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752337AbWLWDfR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 22:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752394AbWLWDfR
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 22:35:17 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:59434 "EHLO
	igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337AbWLWDfP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 22:35:15 -0500
Received: from [194.125.99.166] (helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.60)
	(envelope-from <robfitz@273k.net>)
	id 1GxxfA-00061d-W2; Sat, 23 Dec 2006 03:35:09 +0000
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.3.gae7ae3
In-Reply-To: <11668449271631-git-send-email-robfitz@273k.net>
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=-2, required 7, autolearn=disabled,
	RCVD_IN_NERDS_IE -2.00)
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35256>


Signed-off-by: Robert Fitzsimons <robfitz@273k.net>
---
 gitweb/gitweb.perl |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6778b24..e8f63aa 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -128,6 +128,12 @@ our %feature = (
 		#         => [content-encoding, suffix, program]
 		'default' => ['x-gzip', 'gz', 'gzip']},
 
+	# Enable text search, which will list the commits which match author, 
+	# committer or commit text to a given string.  Enabled by default.
+	'search' => {
+		'override' => 0,
+		'default' => [1]},
+
 	# Enable the pickaxe search, which will list the commits that modified
 	# a given string in a file. This can be practical and quite faster
 	# alternative to 'blame', but still potentially CPU-intensive.
@@ -1729,6 +1735,9 @@ EOF
 			print " / $action";
 		}
 		print "\n";
+	}
+	my ($have_search) = gitweb_check_feature('search');
+	if ((defined $project) && ($have_search)) {
 		if (!defined $searchtext) {
 			$searchtext = "";
 		}
@@ -4147,6 +4156,10 @@ sub git_history {
 }
 
 sub git_search {
+	my ($have_search) = gitweb_check_feature('search');
+	if (!$have_search) {
+		die_error('403 Permission denied', "Permission denied");
+	}
 	if (!defined $searchtext) {
 		die_error(undef, "Text field empty");
 	}
-- 
1.4.4.3.gae7ae3
