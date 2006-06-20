From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC] gitweb: Add title attribute with unshortened value for table cells
Date: Tue, 20 Jun 2006 10:12:31 +0200
Message-ID: <200606201012.31684.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jun 20 10:12:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsbLg-0007GM-MI
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 10:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbWFTIMc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 04:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbWFTIMc
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 04:12:32 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:62017 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965006AbWFTIMb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jun 2006 04:12:31 -0400
Received: by ug-out-1314.google.com with SMTP id a2so2150630ugf
        for <git@vger.kernel.org>; Tue, 20 Jun 2006 01:12:30 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=VgNowinHnjKGronZRK8gQkWTQKMgC21lFE0mKWK8QpM/t9swo8b7HYVmfWFKn8pMudRS120DWgst3sOTTb1/hag1pEtsbMjhW0zes8B3ESe2CWs8E3Gyshg93FdmPQl+2O/Ax3sxBe8EKd80bFGBtTsdLetfpoRVDDc6XhUBRXg=
Received: by 10.67.101.8 with SMTP id d8mr5911347ugm;
        Tue, 20 Jun 2006 01:12:30 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id w40sm895806ugc.2006.06.20.01.12.29;
        Tue, 20 Jun 2006 01:12:30 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.6.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22179>

This allows to see full, unshortened value on mouseover using 'title'
attribute for <td> element. For now it means only author name and
project owner name.

Ugly solution using $cgi->start_td({-title => VALUE})

Doesn't work well with values outside us-ascii, but that might be
considered web browser bug (misfeature), not a bug in gitweb.

---
The idea is to have full value available on mouseover, be it commit title, 
author of the commit, project owner, tag name/title or project description.
For now only author name and project owner name are implemented, and
implementation is ugly and results is not perfect.


 gitweb/gitweb.cgi |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

b72280ac4649d54375732de771f7d92c7d350258
diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 1b254df..9a09b20 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -887,7 +887,7 @@ sub git_project_list {
 		$alternate ^= 1;
 		print "<td>" . $cgi->a({-href => "$my_uri?" . esc_param("p=$pr->{'path'};a=summary"), -class => "list"}, esc_html($pr->{'path'})) . "</td>\n" .
 		      "<td>$pr->{'descr'}</td>\n" .
-		      "<td><i>" . chop_str($pr->{'owner'}, 15) . "</i></td>\n";
+		      $cgi->start_td({-title => $pr->{'owner'}}) . chop_str($pr->{'owner'}, 15) . "</i></td>\n";
 		my $colored_age;
 		if ($pr->{'commit'}{'age'} < 60*60*2) {
 			$colored_age = "<span style =\"color: #009900;\"><b><i>$pr->{'commit'}{'age_string'}</i></b></span>";
@@ -1057,7 +1057,7 @@ sub git_summary {
 				$ref = " <span class=\"tag\">" . esc_html($refs->{$commit}) . "</span>";
 			}
 			print "<td><i>$co{'age_string'}</i></td>\n" .
-			      "<td><i>" . esc_html(chop_str($co{'author_name'}, 10)) . "</i></td>\n" .
+			      $cgi->start_td({-title => $co{'author_name'}}) . esc_html(chop_str($co{'author_name'}, 10)) . "</i></td>\n" .
 			      "<td>";
 			if (length($co{'title_short'}) < length($co{'title'})) {
 				print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$commit"), -class => "list", -title => "$co{'title'}"},
@@ -2306,7 +2306,7 @@ sub git_history {
 			}
 			$alternate ^= 1;
 			print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
-			      "<td><i>" . esc_html(chop_str($co{'author_name'}, 15, 3)) . "</i></td>\n" .
+			      $cgi->start_td({-title => $co{'author_name'}}) . esc_html(chop_str($co{'author_name'}, 15, 3)) . "</i></td>\n" .
 			      "<td>" . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$commit"), -class => "list"}, "<b>" .
 			      esc_html(chop_str($co{'title'}, 50)) . "$ref</b>") . "</td>\n" .
 			      "<td class=\"link\">" .
@@ -2396,7 +2396,7 @@ sub git_search {
 			}
 			$alternate ^= 1;
 			print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
-			      "<td><i>" . esc_html(chop_str($co{'author_name'}, 15, 5)) . "</i></td>\n" .
+			      $cgi->start_td({-title => $co{'author_name'}}) . esc_html(chop_str($co{'author_name'}, 15, 5)) . "</i></td>\n" .
 			      "<td>" .
 			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$co{'id'}"), -class => "list"}, "<b>" . esc_html(chop_str($co{'title'}, 50)) . "</b><br/>");
 			my $comment = $co{'comment'};
@@ -2449,7 +2449,7 @@ sub git_search {
 					}
 					$alternate ^= 1;
 					print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
-					      "<td><i>" . esc_html(chop_str($co{'author_name'}, 15, 5)) . "</i></td>\n" .
+					      $cgi->start_td({-title => $co{'author_name'}}) . esc_html(chop_str($co{'author_name'}, 15, 5)) . "</i></td>\n" .
 					      "<td>" .
 					      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$co{'id'}"), -class => "list"}, "<b>" .
 					      esc_html(chop_str($co{'title'}, 50)) . "</b><br/>");
@@ -2537,7 +2537,7 @@ sub git_shortlog {
 		}
 		$alternate ^= 1;
 		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
-		      "<td><i>" . esc_html(chop_str($co{'author_name'}, 10)) . "</i></td>\n" .
+		      $cgi->start_td({-title => $co{'author_name'}}) . esc_html(chop_str($co{'author_name'}, 10)) . "</i></td>\n" .
 		      "<td>";
 		if (length($co{'title_short'}) < length($co{'title'})) {
 			print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$commit"), -class => "list", -title => "$co{'title'}"},
-- 
1.3.0
