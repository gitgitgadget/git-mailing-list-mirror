From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH] gitweb: add readme to overview page
Date: Sun, 11 Nov 2012 16:32:42 +0100
Message-ID: <1352647962-21910-1-git-send-email-xypron.glpk@gmx.de>
Cc: xypron.glpk@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 16:33:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXZXI-00030Z-Cx
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 16:33:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255Ab2KKPdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 10:33:10 -0500
Received: from mailout-eu.gmx.com ([213.165.64.43]:56630 "HELO
	mailout-eu.gmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753150Ab2KKPdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 10:33:09 -0500
Received: (qmail invoked by alias); 11 Nov 2012 15:33:08 -0000
Received: from xdsl-78-35-188-85.netcologne.de (EHLO family2.heinrich-schuchardt.de) [78.35.188.85]
  by mail.gmx.com (mp-eu001) with SMTP; 11 Nov 2012 16:33:08 +0100
X-Authenticated: #41704822
X-Provags-ID: V01U2FsdGVkX18wt0NFo8UwR2eR8jrg+sdOhRE59Mw/Iba9+cnj45
	OJ045Yx4fxMa/l
X-Mailer: git-send-email 1.7.10.4
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209393>

For repositories it is possible to maintain a README.html which will
be shown on the summary page. This is not possible for the server
root.

German law requires to provide contact data on the web server. This
data could easily be entered in the overview page using a README.html.

Furthermore it is possible to put the repositories not directly into
the root directory but into a subdirectory. Here also a README.html
would be helpful to indicate what the subdirectory is about.

The patch introduces README.html functionality for the root directory
and all subdirectories.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 gitweb/gitweb.perl |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 10ed9e5..30cd028 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6369,6 +6369,18 @@ sub git_project_list {
 	}
 
 	git_project_search_form($searchtext, $search_use_regexp);
+    # If XSS prevention is on, we don't include README.html.
+    # TODO: Allow a readme in some safe format.
+	my $path = "/";
+	if (defined $project_filter) {
+	    $path .= $project_filter;
+	}
+    if (!$prevent_xss && -s "$projectroot$path/README.html") {
+        print "<div class=\"title\">readme</div>\n" .
+              "<div class=\"readme\">\n";
+        insert_file("$projectroot$path/README.html");
+        print "\n</div>\n"; # class="readme"
+    }
 	git_project_list_body(\@list, $order);
 	git_footer_html();
 }
-- 
1.7.10.4
