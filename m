From: Kevin Ballard <kevin@sb.org>
Subject: [PATCH resend 1/2] Make git-svn tests behave better on OS X
Date: Thu, 20 Mar 2008 16:08:48 -0400
Message-ID: <1206043729-61810-1-git-send-email-kevin@sb.org>
Cc: Kevin Ballard <kevin@sb.org>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Mar 20 21:09:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcR4y-0000Zq-Ux
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 21:09:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755068AbYCTUIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 16:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754966AbYCTUIw
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 16:08:52 -0400
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:36386 "EHLO
	randymail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754573AbYCTUIv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Mar 2008 16:08:51 -0400
Received: from localhost.localdomain (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a5.g.dreamhost.com (Postfix) with ESMTP id 4B2C290CE4;
	Thu, 20 Mar 2008 13:08:50 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.rc0.10.g0fd43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77684>

Give lib-git-svn.sh some better defaults for OS X.
Explicitly define the LockFile so httpd will actually start under OS X

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
 t/lib-git-svn.sh |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 9ee35e7..1266609 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -49,8 +49,14 @@ poke() {
 	test-chmtime +1 "$1"
 }
 
-SVN_HTTPD_MODULE_PATH=${SVN_HTTPD_MODULE_PATH-'/usr/lib/apache2/modules'}
-SVN_HTTPD_PATH=${SVN_HTTPD_PATH-'/usr/sbin/apache2'}
+if test `uname -s` = Darwin
+then
+	SVN_HTTPD_MODULE_PATH=${SVN_HTTPD_MODULE_PATH-'/usr/libexec/apache2'}
+	SVN_HTTPD_PATH=${SVN_HTTPD_PATH-'/usr/sbin/httpd'}
+else
+	SVN_HTTPD_MODULE_PATH=${SVN_HTTPD_MODULE_PATH-'/usr/lib/apache2/modules'}
+	SVN_HTTPD_PATH=${SVN_HTTPD_PATH-'/usr/sbin/apache2'}
+fi
 
 start_httpd () {
 	if test -z "$SVN_HTTPD_PORT"
@@ -66,6 +72,7 @@ ServerName "git-svn test"
 ServerRoot "$GIT_DIR"
 DocumentRoot "$GIT_DIR"
 PidFile "$GIT_DIR/httpd.pid"
+LockFile logs/accept.lock
 Listen 127.0.0.1:$SVN_HTTPD_PORT
 LoadModule dav_module $SVN_HTTPD_MODULE_PATH/mod_dav.so
 LoadModule dav_svn_module $SVN_HTTPD_MODULE_PATH/mod_dav_svn.so
-- 
1.5.5.rc0.10.g0fd43
