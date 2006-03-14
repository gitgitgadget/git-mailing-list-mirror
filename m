From: Qingning Huo <qhuo@mayhq.co.uk>
Subject: [PATCH] Invoke git-repo-config directly.
Date: Tue, 14 Mar 2006 21:10:22 +0000
Message-ID: <20060314211022.GA12498@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Mar 14 22:15:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJGmq-0005SD-6n
	for gcvg-git@gmane.org; Tue, 14 Mar 2006 22:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbWCNVKY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Mar 2006 16:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWCNVKY
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Mar 2006 16:10:24 -0500
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:16236 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932444AbWCNVKY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Mar 2006 16:10:24 -0500
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com with ESMTP
          id <20060314211017.GPFK1118.mtaout01-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>
          for <git@vger.kernel.org>; Tue, 14 Mar 2006 21:10:17 +0000
Received: from rabbit.zoo.mayhq.org ([80.0.127.16])
          by aamtaout03-winn.ispmail.ntl.com with SMTP
          id <20060314211017.XBOS20548.aamtaout03-winn.ispmail.ntl.com@rabbit.zoo.mayhq.org>
          for <git@vger.kernel.org>; Tue, 14 Mar 2006 21:10:17 +0000
Received: (qmail 12552 invoked by uid 1000); 14 Mar 2006 21:10:22 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17596>

The system have GNU git installed at /usr/bin/git.  I installed git-core
to ~/opt/bin.  ~/opt/bin is in my PATH, but is after /usr/bin.  I have
set alias git="$HOME/opt/bin/git".

git-push and git-pull behaves strangely, because they call "git
repo-config", which runs /usr/bin/git.  Using "git-repo-config" directly
fixed the problem.

Signed-off-by: Qingning Huo <qhuo@mayhq.co.uk>

---

 git-pull.sh     |    4 ++--
 git-sh-setup.sh |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

a0194fff002cb12ac58b202201d387f8ea55b225
diff --git a/git-pull.sh b/git-pull.sh
index 6caf1aa..e32e2b0 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -70,7 +70,7 @@ case "$merge_head" in
 	exit 0
 	;;
 ?*' '?*)
-	var=`git repo-config --get pull.octopus`
+	var=`git-repo-config --get pull.octopus`
 	if test '' = "$var"
 	then
 		strategy_default_args='-s octopus'
@@ -79,7 +79,7 @@ case "$merge_head" in
 	fi
 	;;
 *)
-	var=`git repo-config --get pull.twohead`
+	var=`git-repo-config --get pull.twohead`
 	if test '' = "$var"
 	then
 		strategy_default_args='-s recursive'
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 025ef2d..12f5ede 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -41,7 +41,7 @@ then
 	: ${GIT_OBJECT_DIRECTORY="$GIT_DIR/objects"}
 
 	# Make sure we are in a valid repository of a vintage we understand.
-	GIT_DIR="$GIT_DIR" git repo-config --get core.nosuch >/dev/null
+	GIT_DIR="$GIT_DIR" git-repo-config --get core.nosuch >/dev/null
 	if test $? = 128
 	then
 	    exit
-- 
1.2.4.ga019-dirty
