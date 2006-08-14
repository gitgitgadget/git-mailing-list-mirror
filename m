From: Yasushi SHOJI <yashi@atmark-techno.com>
Subject: [PATCH] gitweb: configurable home link string
Date: Tue, 15 Aug 2006 07:50:49 +0900
Message-ID: <11555958491891-git-send-email-yashi@atmark-techno.com>
Cc: Yasushi SHOJI <yashi@atmark-techno.com>
X-From: git-owner@vger.kernel.org Tue Aug 15 00:51:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GClHH-0006oB-VF
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 00:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965020AbWHNWvS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 18:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965021AbWHNWvS
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 18:51:18 -0400
Received: from shop.atmark-techno.com ([210.191.215.173]:27573 "EHLO
	mail2.atmark-techno.com") by vger.kernel.org with ESMTP
	id S965020AbWHNWvR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 18:51:17 -0400
Received: from localhost (dns1.atmark-techno.com [210.191.215.170])
	by mail2.atmark-techno.com (Postfix) with ESMTP id 9E73F46E9;
	Tue, 15 Aug 2006 07:51:14 +0900 (JST)
Received: from yashi by localhost with local (Exim 4.62)
	(envelope-from <yashi@atmark-techno.com>)
	id 1GClGt-0000xm-Io; Tue, 15 Aug 2006 07:50:59 +0900
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.2.g182a
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25419>

I've always found difficult to figure out git URL for clone from
gitweb URL because git:// and http:// are different on many site
including kernel.org.

I've found this enhancement at http://dev.laptop.org/git when I was on
git channel, and thought that it'd be nice if all public gitweb site
show it's git URL on its page.

This patch allow us to change the home link string.  The current
default is "projects" as we all see on gitweb now.

ie. kernel.org might set this variable to "git://git.kernel.org/pub/scm/"

Signed-off-by: Yasushi SHOJI <yashi@atmark-techno.com>
---
 Makefile           |    2 ++
 gitweb/gitweb.perl |    5 ++++-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index a538710..b363f50 100644
--- a/Makefile
+++ b/Makefile
@@ -123,6 +123,7 @@ # DESTDIR=
 
 # default configuration for gitweb
 GITWEB_CONFIG = gitweb_config.perl
+GITWEB_HOME_LINK_STR = projects
 GITWEB_SITENAME =
 GITWEB_PROJECTROOT = /pub/git
 GITWEB_LIST =
@@ -617,6 +618,7 @@ gitweb/gitweb.cgi: gitweb/gitweb.perl
 	    -e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
 	    -e 's|++GIT_BINDIR++|$(bindir)|g' \
 	    -e 's|++GITWEB_CONFIG++|$(GITWEB_CONFIG)|g' \
+	    -e 's|++GITWEB_HOME_LINK_STR++|$(GITWEB_HOME_LINK_STR)|g' \
 	    -e 's|++GITWEB_SITENAME++|$(GITWEB_SITENAME)|g' \
 	    -e 's|++GITWEB_PROJECTROOT++|$(GITWEB_PROJECTROOT)|g' \
 	    -e 's|++GITWEB_LIST++|$(GITWEB_LIST)|g' \
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 626fcc9..76e8376 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -36,6 +36,9 @@ our $git_temp = "/tmp/gitweb";
 # target of the home link on top of all pages
 our $home_link = $my_uri;
 
+# string of the home link on top of all pages
+our $home_link_str = "++GITWEB_HOME_LINK_STR++";
+
 # name of your site or organization to appear in page titles
 # replace this with something more descriptive for clearer bookmarks
 our $site_name = "++GITWEB_SITENAME++" || $ENV{'SERVER_NAME'} || "Untitled";
@@ -890,7 +893,7 @@ EOF
 	      "<a href=\"http://www.kernel.org/pub/software/scm/git/docs/\" title=\"git documentation\">" .
 	      "<img src=\"$logo\" width=\"72\" height=\"27\" alt=\"git\" style=\"float:right; border-width:0px;\"/>" .
 	      "</a>\n";
-	print $cgi->a({-href => esc_param($home_link)}, "projects") . " / ";
+	print $cgi->a({-href => esc_param($home_link)}, $home_link_str) . " / ";
 	if (defined $project) {
 		print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=summary")}, esc_html($project));
 		if (defined $action) {
-- 
1.4.2.g182a
