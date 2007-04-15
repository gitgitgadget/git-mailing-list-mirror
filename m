From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 1/7] gitweb: show "no difference" message for empty diff
Date: Sun, 15 Apr 2007 22:46:04 +0200
Message-ID: <11766699702663-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 15 22:46:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdBc2-0003ud-42
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 22:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753901AbXDOUqO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 16:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753907AbXDOUqO
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 16:46:14 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:58479 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753901AbXDOUqN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 16:46:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 764B97A4D1A9;
	Sun, 15 Apr 2007 22:46:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZWg8tr3aN9jW; Sun, 15 Apr 2007 22:46:11 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id EFA5C7A4D192; Sun, 15 Apr 2007 22:46:10 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
Message-Id: <437446e84f3aea71f74fea7ea66db4c1c326fb6b.1176659094.git.mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Currently, gitweb shows only header and footer, if no differences are
found. This patch adds a "No differences found" message for the html
output.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
$patch_idx does not work, so I need a new variable.

The css style for the no difference message is useable. If somebody
does not like, feel free to send a patch with a better layout.

 gitweb/gitweb.css  |    7 +++++++
 gitweb/gitweb.perl |    3 +++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 5e40292..fb58bec 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -387,6 +387,13 @@ div.diff.incomplete {
 	color: #cccccc;
 }
 
+div.diff.nodifferences {
+	font-weight: bold;
+	background-color: #edece6;
+
+	padding: 4px;
+	border: 1px solid #d9d8d1;
+}
 
 div.index_include {
 	border: solid #d9d8d1;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c48b35a..cbd8d03 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2398,6 +2398,7 @@ sub git_patchset_body {
 	my ($fd, $difftree, $hash, $hash_parent) = @_;
 
 	my $patch_idx = 0;
+	my $patch_number = 0;
 	my $patch_line;
 	my $diffinfo;
 	my (%from, %to);
@@ -2419,6 +2420,7 @@ sub git_patchset_body {
 		# git diff header
 		#assert($patch_line =~ m/^diff /) if DEBUG;
 		#assert($patch_line !~ m!$/$!) if DEBUG; # is chomp-ed
+		$patch_number++;
 		push @diff_header, $patch_line;
 
 		# extended diff header
@@ -2581,6 +2583,7 @@ sub git_patchset_body {
 	} continue {
 		print "</div>\n"; # class="patch"
 	}
+	print "<div class=\"diff nodifferences\">No differences found</div>\n" if (!$patch_number);
 
 	print "</div>\n"; # class="patchset"
 }
-- 
1.5.1.1.85.gf1888
