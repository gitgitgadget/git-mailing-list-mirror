From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH] gitweb: support filename prefix in git_patchset_body
Date: Sun, 25 Mar 2007 22:34:20 +0200
Message-ID: <11748548622060-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <11748548622888-git-send-email-mkoegler@auto.tuwien.ac.at> <11748548621186-git-send-email-mkoegler@auto.tuwien.ac.at> <11748548623841-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 25 22:34:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVZQ6-0003Ft-On
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 22:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504AbXCYUe1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 16:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752578AbXCYUe1
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 16:34:27 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:60112 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504AbXCYUeY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 16:34:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id D6AA4735D74E;
	Sun, 25 Mar 2007 22:34:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TGKroJcimSEW; Sun, 25 Mar 2007 22:34:22 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 690DC735D746; Sun, 25 Mar 2007 22:34:22 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
In-Reply-To: <11748548623841-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43066>

git_treediff supports comparing subdirectories. As the output of
git-difftree is missing the path to the compared directories,
the links in the output would be wrong.

The patch adds two new parameters to add the missing path prefix.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 gitweb/gitweb.perl |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4c371b2..4195b1a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2372,7 +2372,7 @@ sub git_difftree_body {
 }
 
 sub git_patchset_body {
-	my ($fd, $difftree, $hash, $hash_parent) = @_;
+	my ($fd, $difftree, $hash, $hash_parent, $file_name, $file_parent) = @_;
 
 	my $patch_idx = 0;
 	my $patch_line;
@@ -2380,6 +2380,9 @@ sub git_patchset_body {
 	my $diffinfo;
 	my (%from, %to);
 
+	$file_name = (!defined $file_name)?"":($file_name."/");
+	$file_parent = (!defined $file_parent)?"":($file_parent."/");
+
 	print "<div class=\"patchset\">\n";
 
 	# skip to first patch
@@ -2439,14 +2442,14 @@ sub git_patchset_body {
 			if ($diffinfo->{'status'} ne "A") { # not new (added) file
 				$from{'href'} = href(action=>"blob", hash_base=>$hash_parent,
 				                     hash=>$diffinfo->{'from_id'},
-				                     file_name=>$from{'file'});
+				                     file_name=>$file_parent.$from{'file'});
 			} else {
 				delete $from{'href'};
 			}
 			if ($diffinfo->{'status'} ne "D") { # not deleted file
 				$to{'href'} = href(action=>"blob", hash_base=>$hash,
 				                   hash=>$diffinfo->{'to_id'},
-				                   file_name=>$to{'file'});
+				                   file_name=>$file_name.$to{'file'});
 			} else {
 				delete $to{'href'};
 			}
-- 
1.5.1.rc1.51.gb08b-dirty
