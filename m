From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/5] git-instaweb: some Apache have mod_cgi builtin
Date: Wed, 26 Jul 2006 16:33:18 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607261633060.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Jul 26 16:33:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5kRv-0006GB-MC
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 16:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbWGZOdU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 10:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbWGZOdU
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 10:33:20 -0400
Received: from mail.gmx.net ([213.165.64.21]:62127 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751646AbWGZOdU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jul 2006 10:33:20 -0400
Received: (qmail invoked by alias); 26 Jul 2006 14:33:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 26 Jul 2006 16:33:19 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net,
	Eric Wong <normalperson@yhbt.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24215>


So test for it, and do not always try to load mod_cgi.o.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 git-instaweb.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 63b18b9..9829c59 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -183,8 +183,10 @@ PerlPassEnv GIT_EXEC_DIR
 EOF
 	else
 		# plain-old CGI
+		list_mods=`echo "$httpd" | sed "s/-f$/-l/"`
+		$list_mods | grep 'mod_cgi\.c' >/dev/null || \
+		echo "LoadModule cgi_module $module_path/mod_cgi.so" >> "$conf"
 		cat >> "$conf" <<EOF
-LoadModule cgi_module $module_path/mod_cgi.so
 AddHandler cgi-script .cgi
 <Location /gitweb.cgi>
 	Options +ExecCGI
-- 
1.4.2.rc2.g6a4e
