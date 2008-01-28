From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/2] instaweb: use 'browser.<tool>.path' config option if
 it's set.
Date: Mon, 28 Jan 2008 08:02:25 +0100
Message-ID: <20080128080225.583dbac8.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jan 28 07:57:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJNvV-0004HS-9x
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 07:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbYA1G4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 01:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbYA1G4f
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 01:56:35 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:50928 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285AbYA1G4W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 01:56:22 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 7000E1AB2CA;
	Mon, 28 Jan 2008 07:56:21 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 32F801AB2D4;
	Mon, 28 Jan 2008 07:56:21 +0100 (CET)
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71853>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt |    3 ++-
 git-instaweb.sh          |   10 +++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c2fedd1..584250c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -369,7 +369,8 @@ branch.<name>.rebase::
 
 browser.<tool>.path::
 	Override the path for the given tool that may be used to
-	browse help. See linkgit:git-help[1].
+	browse help (see linkgit:git-help[1]) or a working repository
+	in gitweb (see linkgit:git-instaweb[1]).
 
 clean.requireForce::
 	A boolean to make git-clean do nothing unless given -f
diff --git a/git-instaweb.sh b/git-instaweb.sh
index ad0723c..b21a0a5 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -274,6 +274,14 @@ webrick)
 	;;
 esac
 
+init_browser_path() {
+	browser_path=`git config browser.$1.path`
+	test -z "$browser_path" && browser_path=$1
+}
+
 start_httpd
 url=http://127.0.0.1:$port
-test -n "$browser" && "$browser" $url || echo $url
+test -n "$browser" && {
+	init_browser_path "$browser"
+	"$browser_path" $url
+} || echo $url
-- 
1.5.4.rc4.16.g1009
