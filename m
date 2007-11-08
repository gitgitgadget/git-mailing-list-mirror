From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] instaweb: Minor cleanups and fixes for potential problems
Date: Thu, 8 Nov 2007 16:49:40 +0100
Message-ID: <20071108154940.GA20988@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 16:50:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq9do-0003vm-Hk
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 16:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759772AbXKHPtp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 10:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759507AbXKHPtp
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 10:49:45 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:33814 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759227AbXKHPto (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 10:49:44 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 4367852C371;
	Thu,  8 Nov 2007 16:49:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JWS-mKB0Dx25; Thu,  8 Nov 2007 16:49:41 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 99A8852C370;
	Thu,  8 Nov 2007 16:49:40 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id D643D6DFE8B; Thu,  8 Nov 2007 16:49:19 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 811FF5B8001; Thu,  8 Nov 2007 16:49:40 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64048>

Fix path quoting and test of empty values that some shells do not like.
Remove duplicate check and setting of $browser.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 git-instaweb.sh |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index f05884c..fbacfb1 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -44,7 +44,7 @@ start_httpd () {
 	httpd_only="`echo $httpd | cut -f1 -d' '`"
 	if case "$httpd_only" in /*) : ;; *) which $httpd_only >/dev/null;; esac
 	then
-		$httpd $fqgitdir/gitweb/httpd.conf
+		$httpd "$fqgitdir/gitweb/httpd.conf"
 	else
 		# many httpds are installed in /usr/sbin or /usr/local/sbin
 		# these days and those are not in most users $PATHs
@@ -158,7 +158,7 @@ EOF
 :DirectoryIndex: ["gitweb.cgi"]
 :PidFile: "$fqgitdir/pid"
 EOF
-	test "$local" = true && echo ':BindAddress: "127.0.0.1"' >> "$conf"
+	test x"$local" = xtrue && echo ':BindAddress: "127.0.0.1"' >> "$conf"
 }
 
 lighttpd_conf () {
@@ -171,14 +171,14 @@ server.pid-file = "$fqgitdir/pid"
 cgi.assign = ( ".cgi" => "" )
 mimetype.assign = ( ".css" => "text/css" )
 EOF
-	test "$local" = true && echo 'server.bind = "127.0.0.1"' >> "$conf"
+	test x"$local" = xtrue && echo 'server.bind = "127.0.0.1"' >> "$conf"
 }
 
 apache2_conf () {
 	test -z "$module_path" && module_path=/usr/lib/apache2/modules
 	mkdir -p "$GIT_DIR/gitweb/logs"
 	bind=
-	test "$local" = true && bind='127.0.0.1:'
+	test x"$local" = xtrue && bind='127.0.0.1:'
 	echo 'text/css css' > $fqgitdir/mime.types
 	cat > "$conf" <<EOF
 ServerName "git-instaweb"
@@ -271,6 +271,5 @@ webrick)
 esac
 
 start_httpd
-test -z "$browser" && browser=echo
 url=http://127.0.0.1:$port
-$browser $url || echo $url
+"$browser" $url || echo $url
-- 
1.5.3.5.1623.g4aab495-dirty

-- 
Jonas Fonseca
