From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 1/2] gitweb: Show snapshot links for tree entries in tree listing
Date: Sat, 07 Oct 2006 16:10:41 +0200
Message-ID: <20061007141040.16912.50717.stgit@rover>
References: <20061007132457.GB20017@pasky.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 07 16:11:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWCt6-0003fv-3J
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 16:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbWJGOKn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 10:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbWJGOKn
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 10:10:43 -0400
Received: from rover.dkm.cz ([62.24.64.27]:52357 "EHLO rover.dkm.cz")
	by vger.kernel.org with ESMTP id S1751803AbWJGOKm (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Oct 2006 10:10:42 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 292348B996;
	Sat,  7 Oct 2006 16:10:41 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20061007132457.GB20017@pasky.or.cz>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28484>

Currently that's inconsistently reachable only by first displaying the
tree.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c4970f4..096a01b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1752,7 +1752,7 @@ sub git_print_simplified_log {
 
 # print tree entry (row of git_tree), but without encompassing <tr> element
 sub git_print_tree_entry {
-	my ($t, $basedir, $hash_base, $have_blame) = @_;
+	my ($t, $basedir, $hash_base, $have_blame, $have_snapshot) = @_;
 
 	my %base_key = ();
 	$base_key{hash_base} = $hash_base if defined $hash_base;
@@ -1798,6 +1798,13 @@ sub git_print_tree_entry {
 			print $cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
 			                             file_name=>"$basedir$t->{'name'}")},
 			              "history");
+			if ($have_snapshot) {
+				print " | ";
+			}
+		}
+		if ($have_snapshot) {
+			print $cgi->a({-href => href(action=>"snapshot", hash=>$t->{'hash'})},
+				      "snapshot");
 		}
 		print "</td>\n";
 	}
@@ -2931,7 +2938,7 @@ sub git_tree {
 		}
 		$alternate ^= 1;
 
-		git_print_tree_entry(\%t, $base, $hash_base, $have_blame);
+		git_print_tree_entry(\%t, $base, $hash_base, $have_blame, $have_snapshot);
 
 		print "</tr>\n";
 	}
