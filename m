From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] gitweb: Restore object-named links in item lists
Date: Wed, 11 Oct 2006 22:18:13 +0200
Message-ID: <20061011201812.26857.58295.stgit@rover>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 11 22:21:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXkXH-0000oi-NV
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 22:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161226AbWJKUSS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 16:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161218AbWJKUSR
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 16:18:17 -0400
Received: from rover.dkm.cz ([62.24.64.27]:16557 "EHLO rover.dkm.cz")
	by vger.kernel.org with ESMTP id S1161216AbWJKUSP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Oct 2006 16:18:15 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 2FB058BBD8;
	Wed, 11 Oct 2006 22:18:13 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This restores the redundant links removed earlier. It supersedes my patch
to stick slashes to tree entries.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |   42 ++++++++++++++++++++++++++++--------------
 1 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a11fa38..d8298b9 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1785,18 +1785,20 @@ sub git_print_tree_entry {
 					       file_name=>"$basedir$t->{'name'}", %base_key),
 				 -class => "list"}, esc_html($t->{'name'})) . "</td>\n";
 		print "<td class=\"link\">";
+		print $cgi->a({-href => href(action=>"blob", hash=>$t->{'hash'},
+					     file_name=>"$basedir$t->{'name'}", %base_key)},
+			      "blob");
 		if ($have_blame) {
-			print $cgi->a({-href => href(action=>"blame", hash=>$t->{'hash'},
+			print " | " .
+				$cgi->a({-href => href(action=>"blame", hash=>$t->{'hash'},
 						     file_name=>"$basedir$t->{'name'}", %base_key)},
-				      "blame");
+					"blame");
 		}
 		if (defined $hash_base) {
-			if ($have_blame) {
-				print " | ";
-			}
-			print $cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
+			print " | " .
+				$cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
 			                             hash=>$t->{'hash'}, file_name=>"$basedir$t->{'name'}")},
-			              "history");
+					"history");
 		}
 		print " | " .
 			$cgi->a({-href => href(action=>"blob_plain", hash_base=>$hash_base,
@@ -1811,17 +1813,19 @@ sub git_print_tree_entry {
 		              esc_html($t->{'name'}));
 		print "</td>\n";
 		print "<td class=\"link\">";
+		print $cgi->a({-href => href(action=>"tree", hash=>$t->{'hash'},
+					     file_name=>"$basedir$t->{'name'}", %base_key)},
+			      "tree");
 		if (defined $hash_base) {
-			print $cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
+			print " | " .
+				$cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
 			                             file_name=>"$basedir$t->{'name'}")},
-			              "history");
-			if ($have_snapshot) {
-				print " | ";
-			}
+					"history");
 		}
 		if ($have_snapshot) {
-			print $cgi->a({-href => href(action=>"snapshot", hash=>$t->{'hash'})},
-				      "snapshot");
+			print " | " .
+				$cgi->a({-href => href(action=>"snapshot", hash=>$t->{'hash'})},
+					"snapshot");
 		}
 		print "</td>\n";
 	}
@@ -1902,6 +1906,9 @@ sub git_difftree_body {
 				print $cgi->a({-href => "#patch$patchno"}, "patch");
 				print " | ";
 			}
+			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'from_id'},
+			                             hash_base=>$parent, file_name=>$diff{'file'})},
+				      "blob") . " | ";
 			print $cgi->a({-href => href(action=>"blame", hash_base=>$parent,
 						     file_name=>$diff{'file'})},
 				      "blame") . " | ";
@@ -1947,6 +1954,9 @@ sub git_difftree_body {
 				}
 				print " | ";
 			}
+			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
+						     hash_base=>$hash, file_name=>$diff{'file'})},
+				      "blob") . " | ";
 			print $cgi->a({-href => href(action=>"blame", hash_base=>$hash,
 						     file_name=>$diff{'file'})},
 				      "blame") . " | ";
@@ -1987,6 +1997,9 @@ sub git_difftree_body {
 				}
 				print " | ";
 			}
+			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'from_id'},
+						     hash_base=>$parent, file_name=>$diff{'from_file'})},
+				      "blob") . " | ";
 			print $cgi->a({-href => href(action=>"blame", hash_base=>$parent,
 						     file_name=>$diff{'from_file'})},
 				      "blame") . " | ";
@@ -2154,6 +2167,7 @@ sub git_shortlog_body {
 		                          href(action=>"commit", hash=>$commit), $ref);
 		print "</td>\n" .
 		      "<td class=\"link\">" .
+		      $cgi->a({-href => href(action=>"commit", hash=>$commit)}, "commit") . " | " .
 		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff") . " | " .
 		      $cgi->a({-href => href(action=>"tree", hash=>$commit, hash_base=>$commit)}, "tree");
 		if (gitweb_have_snapshot()) {
