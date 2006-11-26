X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Make project description in projects list link to summary view
Date: Sun, 26 Nov 2006 02:18:26 +0100
Message-ID: <1164503906220-git-send-email-jnareb@gmail.com>
NNTP-Posting-Date: Sun, 26 Nov 2006 01:17:02 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=nm+/g6d6uoGRXgcu18flu8qu0ulaM3lP/CQByp+mnulOkiTYUCbbHS1H/SJINvgLq097DnpHNSV2SYHdbpC4PqWZNAHDGQS9itY2aXQfUGG8P3x1WtfbQSU6yCJ6bgWW4JZUhnSGm1I86Zi5jFOf0Et5kcJXOa076VKInWoQ6Og=
X-Mailer: git-send-email 1.4.4.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32314>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Go8dd-0000ib-TR for gcvg-git@gmane.org; Sun, 26 Nov
 2006 02:16:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935222AbWKZBQq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 20:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935220AbWKZBQq
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 20:16:46 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:65260 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S935222AbWKZBQp
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 20:16:45 -0500
Received: by ug-out-1314.google.com with SMTP id 44so897501uga for
 <git@vger.kernel.org>; Sat, 25 Nov 2006 17:16:44 -0800 (PST)
Received: by 10.66.242.20 with SMTP id p20mr9867923ugh.1164503804548; Sat, 25
 Nov 2006 17:16:44 -0800 (PST)
Received: from roke.D-201 ( [81.190.24.209]) by mx.google.com with ESMTP id
 j1sm16785020ugf.2006.11.25.17.16.43; Sat, 25 Nov 2006 17:16:44 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1]) by roke.D-201
 (8.13.4/8.13.4) with ESMTP id kAQ1IRqf028070; Sun, 26 Nov 2006 02:18:27 +0100
Received: (from jnareb@localhost) by roke.D-201 (8.13.4/8.13.4/Submit) id
 kAQ1IQ75028069; Sun, 26 Nov 2006 02:18:26 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Make (shortened) project description in the "projects list" view
hyperlink to the "summary" view of the project. Project names are
sometimes short; having project description be hyperling gives larger
are to click. While at it, display full description on mouseover via
'title' attribute to introduced link.

Additionally, fix whitespace usage in modified git_project_list_body
subroutine: tabs are for indent, spaces are for align.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index fac7923..0477507 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2441,6 +2441,7 @@ sub git_project_list_body {
 		($pr->{'age'}, $pr->{'age_string'}) = @aa;
 		if (!defined $pr->{'descr'}) {
 			my $descr = git_get_project_description($pr->{'path'}) || "";
+			$pr->{'descr_long'} = to_utf8($descr);
 			$pr->{'descr'} = chop_str($descr, 25, 5);
 		}
 		if (!defined $pr->{'owner'}) {
@@ -2476,7 +2477,7 @@ sub git_project_list_body {
 		} else {
 			print "<th>" .
 			      $cgi->a({-href => href(project=>undef, order=>'project'),
-				       -class => "header"}, "Project") .
+			               -class => "header"}, "Project") .
 			      "</th>\n";
 		}
 		if ($order eq "descr") {
@@ -2485,7 +2486,7 @@ sub git_project_list_body {
 		} else {
 			print "<th>" .
 			      $cgi->a({-href => href(project=>undef, order=>'descr'),
-				       -class => "header"}, "Description") .
+			               -class => "header"}, "Description") .
 			      "</th>\n";
 		}
 		if ($order eq "owner") {
@@ -2494,7 +2495,7 @@ sub git_project_list_body {
 		} else {
 			print "<th>" .
 			      $cgi->a({-href => href(project=>undef, order=>'owner'),
-				       -class => "header"}, "Owner") .
+			               -class => "header"}, "Owner") .
 			      "</th>\n";
 		}
 		if ($order eq "age") {
@@ -2503,7 +2504,7 @@ sub git_project_list_body {
 		} else {
 			print "<th>" .
 			      $cgi->a({-href => href(project=>undef, order=>'age'),
-				       -class => "header"}, "Last Change") .
+			               -class => "header"}, "Last Change") .
 			      "</th>\n";
 		}
 		print "<th></th>\n" .
@@ -2528,7 +2529,9 @@ sub git_project_list_body {
 		}
 		print "<td>" . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary"),
 		                        -class => "list"}, esc_html($pr->{'path'})) . "</td>\n" .
-		      "<td>" . esc_html($pr->{'descr'}) . "</td>\n" .
+		      "<td>" . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary"),
+		                        -class => "list", -title => $pr->{'descr_long'}},
+		                        esc_html($pr->{'descr'})) . "</td>\n" .
 		      "<td><i>" . chop_str($pr->{'owner'}, 15) . "</i></td>\n";
 		print "<td class=\"". age_class($pr->{'age'}) . "\">" .
 		      $pr->{'age_string'} . "</td>\n" .
-- 
1.4.4.1
