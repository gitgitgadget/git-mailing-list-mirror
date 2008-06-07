From: =?utf-8?q?Ask=20Bj=C3=B8rn=20Hansen?= <ask@develooper.com>
Subject: [PATCH] Fix missing "HEAD" in the RewriteRule
Date: Sat,  7 Jun 2008 00:19:26 -0700
Message-ID: <1212823166-25098-1-git-send-email-ask@develooper.com>
Cc: =?utf-8?q?Ask=20Bj=C3=B8rn=20Hansen?= <ask@develooper.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 09:28:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4sr5-0001z8-P4
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 09:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753679AbYFGH15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 03:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754487AbYFGH15
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 03:27:57 -0400
Received: from gw.develooper.com ([64.81.84.140]:59358 "EHLO
	freja.develooper.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754368AbYFGH1r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 03:27:47 -0400
X-Greylist: delayed 498 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Jun 2008 03:27:47 EDT
Received: by freja.develooper.com (Postfix, from userid 500)
	id 2180817D034; Sat,  7 Jun 2008 00:19:26 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.5.561.g140d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84183>

Also add a few more hints for how to setup and configure gitweb as described
---
 gitweb/README |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

The important change is to add HEAD into the regexp, everything else is
optional...

diff --git a/gitweb/README b/gitweb/README
index 8f7ea36..b96834b 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -255,12 +255,15 @@ Webserver configuration
 If you want to have one URL for both gitweb and your http://
 repositories, you can configure apache like this:
 
-<VirtualHost www:80>
-    ServerName git.domain.org
+<VirtualHost *:80>
+    ServerName git.example.org
     DocumentRoot /pub/git
-    RewriteEngine on
-    RewriteRule ^/(.*\.git/(?!/?(info|objects|refs)).*)?$ /cgi-bin/gitweb.cgi%{REQUEST_URI}  [L,PT]
     SetEnv	GITWEB_CONFIG	/etc/gitweb.conf
+    RewriteEngine on
+    # make the front page an internal rewrite to the gitweb script 
+    RewriteEngine ^/$  /cgi-bin/gitweb.cgi
+    # make access for "dumb clients" work
+    RewriteRule ^/(.*\.git/(?!/?(HEAD|info|objects|refs)).*)?$ /cgi-bin/gitweb.cgi%{REQUEST_URI}  [L,PT]
 </VirtualHost>
 
 The above configuration expects your public repositories to live under
@@ -276,6 +279,13 @@ override the defaults given at the head of the gitweb.perl (or
 gitweb.cgi).  Look at the comments in that file for information on
 which variables and what they mean.
 
+If you use the rewrite rules from the example you'll likely also need
+something like the following in your gitweb.conf (or gitweb_config.perl) file:
+
+  @stylesheets = ("/some/absolute/path/gitweb.css");
+  $my_uri = "/";
+  $home_link = "/";
+
 
 Originally written by:
   Kay Sievers <kay.sievers@vrfy.org>
-- 
1.5.3.5.561.g140d
