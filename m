From: David Symonds <dsymonds@gmail.com>
Subject: [PATCH] gitweb: Provide title attributes for abbreviated author names.
Date: Wed, 17 Oct 2007 10:34:37 +1000
Message-ID: <1192581277533-git-send-email-dsymonds@gmail.com>
Cc: git@vger.kernel.org, David Symonds <dsymonds@gmail.com>
To: pasky@suse.cz
X-From: git-owner@vger.kernel.org Wed Oct 17 02:35:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihwsr-00006f-7K
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 02:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762308AbXJQAf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 20:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932681AbXJQAf1
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 20:35:27 -0400
Received: from ipmail03.adl2.internode.on.net ([203.16.214.135]:16365 "EHLO
	ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760260AbXJQAf0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2007 20:35:26 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAM71FEd5LCBH/2dsb2JhbACBWg
X-IronPort-AV: E=Sophos;i="4.21,285,1188743400"; 
   d="scan'208";a="168580501"
Received: from ppp121-44-32-71.lns10.syd7.internode.on.net (HELO localhost.localdomain) ([121.44.32.71])
  by ipmail03.adl2.internode.on.net with ESMTP; 17 Oct 2007 10:04:40 +0930
X-Mailer: git-send-email 1.5.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61290>

Signed-off-by: David Symonds <dsymonds@gmail.com>
---
 gitweb/gitweb.perl |   34 +++++++++++++++++++++++++++++-----
 1 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b2bae1b..3112fd4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3461,9 +3461,15 @@ sub git_shortlog_body {
 			print "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
+		my $author = chop_str($co{'author_name'}, 10);
+		if ($author ne $co{'author_name'}) {
+			$author = "<span title=\"$co{'author_name'}\">" . esc_html($author) . "</span>";
+		} else {
+			$author = esc_html($author);
+		}
 		# git_summary() used print "<td><i>$co{'age_string'}</i></td>\n" .
 		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
-		      "<td><i>" . esc_html(chop_str($co{'author_name'}, 10)) . "</i></td>\n" .
+		      "<td><i>" . $author . "</i></td>\n" .
 		      "<td>";
 		print format_subject_html($co{'title'}, $co{'title_short'},
 		                          href(action=>"commit", hash=>$commit), $ref);
@@ -3511,9 +3517,15 @@ sub git_history_body {
 			print "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
+	# shortlog uses      chop_str($co{'author_name'}, 10)
+		my $author = chop_str($co{'author_name'}, 15, 3);
+		if ($author ne $co{'author_name'}) {
+			"<span title=\"$co{'author_name'}\">" . esc_html($author) . "</span>";
+		} else {
+			$author = esc_html($author);
+		}
 		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
-		      # shortlog uses      chop_str($co{'author_name'}, 10)
-		      "<td><i>" . esc_html(chop_str($co{'author_name'}, 15, 3)) . "</i></td>\n" .
+		      "<td><i>" . $author . "</i></td>\n" .
 		      "<td>";
 		# originally git_history used chop_str($co{'title'}, 50)
 		print format_subject_html($co{'title'}, $co{'title_short'},
@@ -3667,8 +3679,14 @@ sub git_search_grep_body {
 			print "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
+		my $author = chop_str($co{'author_name'}, 15, 5);
+		if ($author ne $co{'author_name'}) {
+			$author = "<span title=\"$co{'author_name'}\">" . esc_html($author) . "</span>";
+		} else {
+			$author = esc_html($author);
+		}
 		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
-		      "<td><i>" . esc_html(chop_str($co{'author_name'}, 15, 5)) . "</i></td>\n" .
+		      "<td><i>" . $author . "</i></td>\n" .
 		      "<td>" .
 		      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'}), -class => "list subject"},
 			       esc_html(chop_str($co{'title'}, 50)) . "<br/>");
@@ -5181,8 +5199,14 @@ sub git_search {
 						print "<tr class=\"light\">\n";
 					}
 					$alternate ^= 1;
+					my $author = chop_str($co{'author_name'}, 15, 5);
+					if ($author ne $co{'author_name'}) {
+						$author = "<span title=\"$co{'author_name'}\">" . esc_html($author) . "</span>";
+					} else {
+						$author = esc_html($author);
+					}
 					print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
-					      "<td><i>" . esc_html(chop_str($co{'author_name'}, 15, 5)) . "</i></td>\n" .
+					      "<td><i>" . $author . "</i></td>\n" .
 					      "<td>" .
 					      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'}),
 					              -class => "list subject"},
-- 
1.5.3.1
