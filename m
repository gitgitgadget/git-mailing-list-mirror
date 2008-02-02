From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 4/4] instaweb: use 'git-web--browse' to launch browser.
Date: Sat, 2 Feb 2008 07:32:56 +0100
Message-ID: <20080202073256.d9ce1dba.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Feb 02 07:27:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLBqr-0000tD-8Q
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 07:27:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755968AbYBBG0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 01:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755725AbYBBG0x
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 01:26:53 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:54099 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755550AbYBBG0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 01:26:52 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id ACDC11AB2C3;
	Sat,  2 Feb 2008 07:26:51 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 6F1551AB2C2;
	Sat,  2 Feb 2008 07:26:51 +0100 (CET)
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72228>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-instaweb.sh |   20 ++++++--------------
 1 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 3e4452b..6f91c8f 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -24,8 +24,6 @@ restart        restart the web server
 fqgitdir="$GIT_DIR"
 local="`git config --bool --get instaweb.local`"
 httpd="`git config --get instaweb.httpd`"
-browser="`git config --get instaweb.browser`"
-test -z "$browser" && browser="`git config --get web.browser`"
 port=`git config --get instaweb.port`
 module_path="`git config --get instaweb.modulepath`"
 
@@ -36,9 +34,6 @@ conf="$GIT_DIR/gitweb/httpd.conf"
 # if installed, it doesn't need further configuration (module_path)
 test -z "$httpd" && httpd='lighttpd -f'
 
-# probably the most popular browser among gitweb users
-test -z "$browser" && browser='firefox'
-
 # any untaken local port will do...
 test -z "$port" && port=1234
 
@@ -274,14 +269,11 @@ webrick)
 	;;
 esac
 
-init_browser_path() {
-	browser_path="`git config browser.$1.path`"
-	test -z "$browser_path" && browser_path="$1"
-}
-
 start_httpd
 url=http://127.0.0.1:$port
-test -n "$browser" && {
-	init_browser_path "$browser"
-	"$browser_path" $url
-} || echo $url
+
+if test -n "$browser"; then
+	git web--browse -b "$browser" $url || echo $url
+else
+	git web--browse -c "instaweb.browser" $url || echo $url
+fi
-- 
1.5.4.rc5.25.g7a831-dirty
