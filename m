From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb: tree view: hash_base and hash are now context sensitive
Date: Tue, 26 Sep 2006 12:47:05 -0700 (PDT)
Message-ID: <20060926194706.32255.qmail@web31804.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-701104349-1159300025=:31982"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Sep 26 21:47:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSItc-0007ac-Rx
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 21:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbWIZTrJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 15:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbWIZTrJ
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 15:47:09 -0400
Received: from web31804.mail.mud.yahoo.com ([68.142.207.67]:60334 "HELO
	web31804.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932502AbWIZTrG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 15:47:06 -0400
Received: (qmail 32257 invoked by uid 60001); 26 Sep 2006 19:47:06 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=KumLC9zhglUYYrt+MjaNodH+q6ez/6p5Xb/tfTvbsHjM9w5cs947uXEKirUYRlnKG3YUHBkUNN5UfgpNIrRRx+/f7hU1Iz2nLl5Gva7atJ030avPYOqK6qyG4jQFzU11CxuhvA0q/zmK7lKau7+1QcYuHnDnkihfzm38ogFYb08=  ;
Received: from [64.215.88.90] by web31804.mail.mud.yahoo.com via HTTP; Tue, 26 Sep 2006 12:47:05 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27813>

--0-701104349-1159300025=:31982
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

In tree view, by default, hash_base is HEAD and hash is the
entry equivalent.  Else the user had selected a hash_base or
hash, say by clicking on a revision or commit, in which case
those values are used.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.perl |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

--0-701104349-1159300025=:31982
Content-Type: text/plain; name="p2.txt"
Content-Description: 1908141687-p2.txt
Content-Disposition: inline; filename="p2.txt"

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8e9c827..56638f2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1625,7 +1625,7 @@ sub git_print_tree_entry {
 			              "history");
 		}
 		print " | " .
-			$cgi->a({-href => href(action=>"blob_plain", hash_base=>"HEAD",
+			$cgi->a({-href => href(action=>"blob_plain", hash_base=>$hash_base,
 					       file_name=>"$basedir$t->{'name'}")},
 				"raw");
 		print "</td>\n";
@@ -2713,14 +2713,14 @@ sub git_tree {
 	my ($ctype, $suffix, $command) = gitweb_check_feature('snapshot');
 	my $have_snapshot = (defined $ctype && defined $suffix);
 
+	if (!defined $hash_base) {
+		$hash_base = "HEAD";
+	}
 	if (!defined $hash) {
-		$hash = git_get_head_hash($project);
 		if (defined $file_name) {
-			my $base = $hash_base || $hash;
-			$hash = git_get_hash_by_path($base, $file_name, "tree");
-		}
-		if (!defined $hash_base) {
-			$hash_base = $hash;
+			$hash = git_get_hash_by_path($hash_base, $file_name, "tree");
+		} else {
+			$hash = $hash_base;
 		}
 	}
 	$/ = "\0";
-- 
1.4.2.1.g893b0

--0-701104349-1159300025=:31982--
