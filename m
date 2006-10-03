From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] gitweb: document webserver configuration for common gitweb/repo URLs.
Date: Tue, 3 Oct 2006 10:03:28 +0200
Message-ID: <20061003080328.GI2871@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Oct 03 10:03:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUfFZ-0006hl-By
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 10:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965272AbWJCIDb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 04:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965455AbWJCIDb
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 04:03:31 -0400
Received: from agent.admingilde.org ([213.95.21.5]:26041 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP id S965272AbWJCID3
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 Oct 2006 04:03:29 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GUfFQ-0005GT-Ae
	for git@vger.kernel.org; Tue, 03 Oct 2006 10:03:28 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28252>

Add a small apache configuration which shows how to use apache
to put gitweb and GIT repositories at the same URL.

Signed-off-by: Martin Waitz <tali@admingilde.org>
---
I've been running such a configuration on git.admingilde.org for quite
some time now, it's time to document it:

 gitweb/README |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index 27c6dac..61c7ab5 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -1,4 +1,5 @@
 GIT web Interface
+=================
 
 The one working on:
   http://www.kernel.org/git/
@@ -6,7 +7,8 @@ The one working on:
 From the git version 1.4.0 gitweb is bundled with git.
 
 
-How to configure gitweb for your local system:
+How to configure gitweb for your local system
+---------------------------------------------
 
 You can specify the following configuration variables when building GIT:
  * GITWEB_SITENAME
@@ -29,6 +31,28 @@ You can specify the following configurat
    environment variable will be loaded instead of the file
    specified when gitweb.cgi was created.
 
+
+Webserver configuration
+-----------------------
+
+If you want to have one URL for both gitweb and your http://
+repositories, you can configure apache like this:
+
+<VirtualHost www:80>
+    ServerName git.domain.org
+    DocumentRoot /pub/git
+    RewriteEngine on
+    RewriteRule ^/(.*\.git/(?!/?(info|objects|refs)).*)?$ /cgi-bin/gitweb.cgi%{REQUEST_URI}  [L,PT]
+</VirtualHost>
+
+The above configuration expects your public repositories to live under
+/pub/git and will serve them as http://git.domain.org/dir-under-pub-git,
+both as cloneable GIT URL and as browseable gitweb interface.
+If you then start your git-daemon with --base-path=/pub/git --export-all
+then you can even use the git:// URL with exactly the same path.
+
+
+
 Originally written by:
   Kay Sievers <kay.sievers@vrfy.org>
 
-- 
1.4.2.gb8b6b

-- 
Martin Waitz
