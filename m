From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 03/14] lib-git-svn.sh: Avoid setting web server variables
 unnecessarily
Date: Tue, 14 Dec 2010 18:22:29 +0000
Message-ID: <4D07B5E5.9060403@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, normalperson@yhbt.net,
	avarab@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 19:45:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSZse-0004kc-RJ
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 19:45:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757664Ab0LNSpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 13:45:32 -0500
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:52504 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757120Ab0LNSpb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 13:45:31 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1PSZsP-0006nq-Z4; Tue, 14 Dec 2010 18:45:30 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163664>


If the SVN_HTTPD_PORT variable is not set, then we will not even
attempt to start a web server in the start_httpd function (despite
it's name), so there is no need to determine values for the
SVN_HTTPD_PATH and SVN_HTTPD_MODULE_PATH variables.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 t/lib-git-svn.sh |   47 +++++++++++++++++++++++++----------------------
 1 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 92d6d31..919d45a 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -68,28 +68,31 @@ svn_cmd () {
 	svn "$orig_svncmd" --config-dir "$svnconf" "$@"
 }
 
-for d in \
-	"$SVN_HTTPD_PATH" \
-	/usr/sbin/apache2 \
-	/usr/sbin/httpd \
-; do
-	if test -f "$d"
-	then
-		SVN_HTTPD_PATH="$d"
-		break
-	fi
-done
-for d in \
-	"$SVN_HTTPD_MODULE_PATH" \
-	/usr/lib/apache2/modules \
-	/usr/libexec/apache2 \
-; do
-	if test -d "$d"
-	then
-		SVN_HTTPD_MODULE_PATH="$d"
-		break
-	fi
-done
+if test -n "$SVN_HTTPD_PORT"
+then
+	for d in \
+		"$SVN_HTTPD_PATH" \
+		/usr/sbin/apache2 \
+		/usr/sbin/httpd \
+	; do
+		if test -f "$d"
+		then
+			SVN_HTTPD_PATH="$d"
+			break
+		fi
+	done
+	for d in \
+		"$SVN_HTTPD_MODULE_PATH" \
+		/usr/lib/apache2/modules \
+		/usr/libexec/apache2 \
+	; do
+		if test -d "$d"
+		then
+			SVN_HTTPD_MODULE_PATH="$d"
+			break
+		fi
+	done
+fi
 
 start_httpd () {
 	repo_base_path="$1"
-- 
1.7.3
