From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/3] Use {web,instaweb,help}.browser config options.
Date: Sun, 2 Dec 2007 06:08:00 +0100
Message-ID: <20071202060800.9eff150f.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Eric Wong <normalperson@yhbt.net>
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Dec 02 06:01:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iygxg-0003DW-HF
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 06:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbXLBFBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 00:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbXLBFBa
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 00:01:30 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:35101 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750718AbXLBFB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 00:01:29 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id E81981AB2B5;
	Sun,  2 Dec 2007 06:01:28 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 8A2CD1AB2B2;
	Sun,  2 Dec 2007 06:01:28 +0100 (CET)
X-Mailer: Sylpheed 2.4.7 (GTK+ 2.12.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66757>

Now "git-instaweb" will try to use the browser configured as
"web.browser", if "instaweb.browser" is not set.

"git-browse-help" will check first "help.browser" and then
"web.browser".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-browse-help.sh |    8 ++++++--
 git-instaweb.sh    |    1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/git-browse-help.sh b/git-browse-help.sh
index 11f8bfa..de52365 100755
--- a/git-browse-help.sh
+++ b/git-browse-help.sh
@@ -80,9 +80,13 @@ do
 done
 
 if test -z "$browser"; then
-    browser=`git config web.browser`
+    for opt in "help.browser" "web.browser"
+    do
+	browser="`git config $opt`"
+	test -z "$browser" || break
+    done
     if test -n "$browser" && ! valid_tool "$browser"; then
-	    echo >&2 "git config option web.browser set to unknown browser: $browser"
+	    echo >&2 "git config option $opt set to unknown browser: $browser"
 	    echo >&2 "Resetting to default..."
 	    unset browser
     fi
diff --git a/git-instaweb.sh b/git-instaweb.sh
index 8503ae4..42d8d7f 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -24,6 +24,7 @@ fqgitdir="$GIT_DIR"
 local="`git config --bool --get instaweb.local`"
 httpd="`git config --get instaweb.httpd`"
 browser="`git config --get instaweb.browser`"
+test -z "$browser" && browser="`git config --get web.browser`"
 port=`git config --get instaweb.port`
 module_path="`git config --get instaweb.modulepath`"
 
-- 
1.5.3.6.1993.g154f-dirty
