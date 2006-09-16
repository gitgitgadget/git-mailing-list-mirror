From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] gitweb: fix uninitialized variable warning.
Date: Sat, 16 Sep 2006 23:09:02 +0200
Message-ID: <20060916210902.GW17042@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Sep 16 23:09:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOhPX-0000yR-Cj
	for gcvg-git@gmane.org; Sat, 16 Sep 2006 23:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbWIPVJE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 17:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbWIPVJE
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 17:09:04 -0400
Received: from agent.admingilde.org ([213.95.21.5]:62347 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP
	id S1751818AbWIPVJD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Sep 2006 17:09:03 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GOhPK-00071N-NP
	for git@vger.kernel.org; Sat, 16 Sep 2006 23:09:02 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27134>

Perl spit out a varning when "blob" or "blob_plain" actions were
used without a $hash parameter.

Signed-off-by: Martin Waitz <tali@admingilde.org>
---
 gitweb/gitweb.perl |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2789657..ee561c6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2380,11 +2380,7 @@ sub git_heads {
 }
 
 sub git_blob_plain {
-	# blobs defined by non-textual hash id's can be cached
 	my $expires;
-	if ($hash =~ m/^[0-9a-fA-F]{40}$/) {
-		$expires = "+1d";
-	}
 
 	if (!defined $hash) {
 		if (defined $file_name) {
@@ -2394,7 +2390,11 @@ sub git_blob_plain {
 		} else {
 			die_error(undef, "No file name defined");
 		}
+	} elsif ($hash =~ m/^[0-9a-fA-F]{40}$/) {
+		# blobs defined by non-textual hash id's can be cached
+		$expires = "+1d";
 	}
+
 	my $type = shift;
 	open my $fd, "-|", git_cmd(), "cat-file", "blob", $hash
 		or die_error(undef, "Couldn't cat $file_name, $hash");
@@ -2422,11 +2422,7 @@ sub git_blob_plain {
 }
 
 sub git_blob {
-	# blobs defined by non-textual hash id's can be cached
 	my $expires;
-	if ($hash =~ m/^[0-9a-fA-F]{40}$/) {
-		$expires = "+1d";
-	}
 
 	if (!defined $hash) {
 		if (defined $file_name) {
@@ -2436,7 +2432,11 @@ sub git_blob {
 		} else {
 			die_error(undef, "No file name defined");
 		}
+	} elsif ($hash =~ m/^[0-9a-fA-F]{40}$/) {
+		# blobs defined by non-textual hash id's can be cached
+		$expires = "+1d";
 	}
+
 	my $have_blame = gitweb_check_feature('blame');
 	open my $fd, "-|", git_cmd(), "cat-file", "blob", $hash
 		or die_error(undef, "Couldn't cat $file_name, $hash");
-- 
1.4.2.gb8b6b

-- 
Martin Waitz
