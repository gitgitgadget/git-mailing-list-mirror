From: David Symonds <dsymonds@gmail.com>
Subject: [PATCH] gitweb: Provide title attributes for abbreviated author names.
Date: Mon, 22 Oct 2007 10:28:03 +1000
Message-ID: <11930128831553-git-send-email-dsymonds@gmail.com>
Cc: git@vger.kernel.org, David Symonds <dsymonds@gmail.com>
To: pasky@suse.cz, spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Oct 22 04:07:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijmhv-0002pX-3U
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 04:07:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbXJVCHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 22:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbXJVCHm
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 22:07:42 -0400
Received: from staff.cs.usyd.edu.au ([129.78.8.1]:55535 "helo
	staff.cs.usyd.edu.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751480AbXJVCHl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 22:07:41 -0400
X-Greylist: delayed 5961 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Oct 2007 22:07:41 EDT
Received: from serf10.cs.usyd.edu.au. [129.78.8.85] by serf8.cs.usyd.edu.au.; Mon, 22 Oct 2007 10:28:09 +1000
Received: from localhost.localdomain (laptop-dasymond-2.cs.usyd.edu.au [129.78.115.28])
	by serf10.cs.usyd.edu.au (8.12.8/8.12.8) with ESMTP id l9M0S6hU002823;
	Mon, 22 Oct 2007 10:28:07 +1000
X-Mailer: git-send-email 1.5.3.1
X-Spam-Checker-Version: SpamAssassin 3.0.1 (2004-10-22) on 
	serf8.cs.usyd.edu.au
X-Spam-Report-SoIT: * -2.8 ALL_TRUSTED Did not pass through any untrusted hosts
X-Spam-Flag-SoIT: No (Score=-2.8, required: 5.0)
X-Spam-Level-SoIT: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61926>

Signed-off-by: David Symonds <dsymonds@gmail.com>
---
 gitweb/gitweb.perl |   34 +++++++++++++++++++++++++++++-----
 1 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b2bae1b..119ad55 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3461,9 +3461,15 @@ sub git_shortlog_body {
 			print "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
+		my $author = chop_str($co{'author_name'}, 10);
+		if ($author ne $co{'author_name'}) {
+			$author = "<span title=\"" . esc_html($co{'author_name'}) . "\">" . esc_html($author) . "</span>";
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
+			"<span title=\"" . esc_html($co{'author_name'}) . "\">" . esc_html($author) . "</span>";
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
+			$author = "<span title=\"" . esc_html($co{'author_name'}) . "\">" . esc_html($author) . "</span>";
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
+						$author = "<span title=\"" . esc_html($co{'author_name'}) . "\">" . esc_html($author) . "</span>";
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
