From: Xypron <xypron.glpk@gmx.de>
Subject: Re: [PATCH] gitweb: add readme to overview page
Date: Thu, 29 Nov 2012 23:30:21 +0100
Message-ID: <50B7E1FD.8060001@gmx.de>
References: <1352647962-21910-1-git-send-email-xypron.glpk@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 23:31:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeCdZ-00005Z-7d
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 23:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754861Ab2K2WbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 17:31:00 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:49291 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752107Ab2K2WbA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 17:31:00 -0500
Received: (qmail invoked by alias); 29 Nov 2012 22:30:58 -0000
Received: from ip-88-153-184-9.unitymediagroup.de (EHLO [192.168.123.22]) [88.153.184.9]
  by mail.gmx.net (mp038) with SMTP; 29 Nov 2012 23:30:58 +0100
X-Authenticated: #41704822
X-Provags-ID: V01U2FsdGVkX1+yUdtX6QGyLYlJJwiJo1bS8urOzN/p26Fa8C2zhw
	O5/xPls0QFjcbB
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.10) Gecko/20121027 Icedove/10.0.10
In-Reply-To: <1352647962-21910-1-git-send-email-xypron.glpk@gmx.de>
X-Enigmail-Version: 1.4.1
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210880>

Hello Junio,

thank you for your comment in message
<7vip9ak971.fsf@alter.siamese.dyndns.org>
that message <1352652039-31453-1-git-send-email-xypron.glpk@gmx.de>
lost the thread context.

As already described I would be happy if a README.html could be added to
the overview page of gitweb.

Please, find below an updated patch. Compared to the first version of my
patch it avoids a warning concerning doubled slashes in filenames and adds
a subtitle "projects" between the README and the project list.

Best regards

Heinrich Schuchardt

Subject: [PATCH] gitweb: add readme to overview page

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
 gitweb/gitweb.perl |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e8812fa..618b0d8 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6368,6 +6368,19 @@ sub git_project_list {
 	}
 
 	git_project_search_form($searchtext, $search_use_regexp);
+	# If XSS prevention is on, we don't include README.html.
+	# TODO: Allow a readme in some safe format.
+	my $path = "";
+	if (defined $project_filter) {
+		$path = "/$project_filter";
+	}
+	if (!$prevent_xss && -s "$projectroot$path/README.html") {
+		print "<div class=\"title\">readme</div>\n" .
+		"<div class=\"readme\">\n";
+		insert_file("$projectroot$path/README.html");
+		print "\n</div>\n"; # class="readme"
+	}
+	print "<div class=\"title\">projects</div>\n";
 	git_project_list_body(\@list, $order);
 	git_footer_html();
 }
-- 
1.7.10.4
