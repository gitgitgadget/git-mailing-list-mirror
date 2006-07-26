From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 4/5] git-instaweb: Fall back to Apache when LigHTTP was not
 found
Date: Wed, 26 Jul 2006 16:34:10 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607261633560.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Jul 26 16:34:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5kSl-0006R4-Ke
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 16:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbWGZOeN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 10:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbWGZOeM
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 10:34:12 -0400
Received: from mail.gmx.de ([213.165.64.21]:40915 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751648AbWGZOeM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jul 2006 10:34:12 -0400
Received: (qmail invoked by alias); 26 Jul 2006 14:34:11 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 26 Jul 2006 16:34:11 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net,
	Eric Wong <normalperson@yhbt.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24217>


Apache is more likely to be installed...

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 git-instaweb.sh |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 1d3ea73..242b55e 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -25,9 +25,6 @@ conf=$GIT_DIR/gitweb/httpd.conf
 
 # Defaults:
 
-# if installed, it doesn't need further configuration (module_path)
-test -z "$httpd" && httpd='lighttpd -f'
-
 # probably the most popular browser among gitweb users
 test -z "$browser" && browser='firefox'
 
@@ -135,6 +132,15 @@ do
 	shift
 done
 
+# if installed, it doesn't need further configuration (module_path)
+if [ -z "$httpd" ]; then
+	httpd='lighttpd -f'
+	which "$httpd" >/dev/null 2>&1 || httpd='apache2 -f'
+	which "$httpd" >/dev/null 2>&1 || httpd='apache -f'
+	which "$httpd" >/dev/null 2>&1 || httpd='httpd -f'
+	which "$httpd" >/dev/null || exit 1
+fi
+
 mkdir -p "$GIT_DIR/gitweb/tmp"
 GIT_EXEC_PATH="`git --exec-path`"
 GIT_DIR="$fqgitdir"
-- 
1.4.2.rc2.g6a4e
