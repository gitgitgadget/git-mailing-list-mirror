From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH] gitweb: link base commit (hpb) to blobdiff output
Date: Sun, 25 Mar 2007 22:34:19 +0200
Message-ID: <11748548623841-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <11748548622888-git-send-email-mkoegler@auto.tuwien.ac.at> <11748548621186-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 25 22:34:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVZQ6-0003Ft-6f
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 22:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470AbXCYUe1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 16:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752578AbXCYUe0
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 16:34:26 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:60110 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470AbXCYUeX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 16:34:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id C0D50735D740;
	Sun, 25 Mar 2007 22:34:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mNWCtNzaeqvJ; Sun, 25 Mar 2007 22:34:22 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 5F2FC735D745; Sun, 25 Mar 2007 22:34:22 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
In-Reply-To: <11748548621186-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43065>

blobdiff only has links for the "TO" commit. This patch
adds the same links for the "FROM" commit.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 gitweb/gitweb.perl |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e3c2918..4c371b2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4014,6 +4014,21 @@ sub git_blobdiff {
 			                       hash_base=>$hash_base, hash_parent_base=>$hash_parent_base,
 			                       file_name=>$file_name, file_parent=>$file_parent)},
 			        "raw");
+		if (defined $hash_parent_base && (my %co = parse_commit($hash_parent_base))) {
+			$formats_nav .= " | from: ".
+				$cgi->a({-href => href(action=>"commit",
+				                       hash=>$hash_parent_base)},
+				        "commit")
+				." | ".
+				$cgi->a({-href => href(action=>"commitdiff",
+				                       hash=>$hash_parent_base)},
+				        "commitdiff")
+				." | ".
+				$cgi->a({-href => href(action=>"tree",
+						       hash=>$co{'tree'},
+				                       hash_base=>$hash_parent_base)},
+				        "tree");
+		}
 		git_header_html(undef, $expires);
 		if (defined $hash_base && (my %co = parse_commit($hash_base))) {
 			git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
-- 
1.5.1.rc1.51.gb08b-dirty
