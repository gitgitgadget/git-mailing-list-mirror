From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] gitweb: fix $project usage
Date: Sun, 6 Aug 2006 13:25:41 +0200
Message-ID: <20060806112541.GA21515@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Aug 06 13:25:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9glQ-0003tl-MQ
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 13:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbWHFLZp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Aug 2006 07:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbWHFLZp
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Aug 2006 07:25:45 -0400
Received: from moooo.ath.cx ([85.116.203.178]:57992 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1751426AbWHFLZp (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Aug 2006 07:25:45 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24974>

There were some places where $project was used even if it was not
defined.

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
 gitweb/gitweb.perl |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d0672cd..fa9ecce 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -85,7 +85,10 @@ if (defined $action) {
 }
 
 our $project = ($cgi->param('p') || $ENV{'PATH_INFO'});
-$project =~ s|^/||; $project =~ s|/$||;
+if (defined $project) {
+	$project =~ s|^/||;
+	$project =~ s|/$||;
+}
 if (defined $project && $project) {
 	if (!validate_input($project)) {
 		die_error(undef, "Invalid project parameter");
@@ -874,11 +877,15 @@ sub git_header_html {
 <title>$title</title>
 <link rel="stylesheet" type="text/css" href="$stylesheet"/>
 EOF
-	print "<link rel=\"alternate\" title=\"" . esc_param($project) . " log\" href=\"" .
-	      "$my_uri?" . esc_param("p=$project;a=rss") . "\" type=\"application/rss+xml\"/>\n" .
-	      "</head>\n";
+	if (defined $project) {
+		printf('<link rel="alternate" title="%s log" '.
+		       'href="%s" type="application/rss+xml"/>'."\n",
+		       esc_param($project),
+		       esc_param("$my_uri?p=$project;a=rss"));
+	}
 
-	print "<body>\n" .
+	print "</head>\n" .
+	      "<body>\n" .
 	      "<div class=\"page_header\">\n" .
 	      "<a href=\"http://www.kernel.org/pub/software/scm/git/docs/\" title=\"git documentation\">" .
 	      "<img src=\"$logo\" width=\"72\" height=\"27\" alt=\"git\" style=\"float:right; border-width:0px;\"/>" .
-- 
1.4.2.rc3.g2f52
