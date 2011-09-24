From: Tom Lazar <tom@tomster.org>
Subject: [PATCH] allow display of the name of the remote the current branch
Date: Sun, 25 Sep 2011 01:30:24 +0200
Message-ID: <A8D2EC99-E9CB-4AC4-9D37-69093F47FC88@tomster.org>
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Sep 25 01:37:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7bmj-0001lL-Sj
	for gcvg-git-2@lo.gmane.org; Sun, 25 Sep 2011 01:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656Ab1IXXhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Sep 2011 19:37:08 -0400
Received: from elektropost.org ([217.13.206.130]:25293 "EHLO elektropost.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752575Ab1IXXhH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Sep 2011 19:37:07 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Sep 2011 19:37:07 EDT
Received: (qmail 39674 invoked from network); 24 Sep 2011 23:34:01 -0000
Received: from elektropost.org (HELO elektropost.org) (tom@tomster.org)
  by elektropost.org with AES128-SHA encrypted SMTP; 24 Sep 2011 23:34:01 -0000
X-Mailer: Apple Mail (2.1244.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182050>

---
 contrib/completion/git-completion.bash |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8648a36..dd34d01 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -60,6 +60,11 @@
 #       per-repository basis by setting the bash.showUpstream config
 #       variable.
 #
+#		If you would like to see the name of the remote that the current branch
+#   	is tracking, set GIT_PS1_SHOWBRANCHREMOTE to a nonempty value. If the
+#		current branch is tracking a remote branch, the name of that remote is
+#		displayed before the branch name, separated by a colon.
+#
 #
 # To submit patches:
 #
@@ -217,7 +222,6 @@ __git_ps1_show_upstream ()
 			p=" u+${count#*	}-${count%	*}" ;;
 		esac
 	fi
-
 }
 
 
@@ -278,6 +282,8 @@ __git_ps1 ()
 		local u=""
 		local c=""
 		local p=""
+		local remote=""
+		local branch=""
 
 		if [ "true" = "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]; then
 			if [ "true" = "$(git rev-parse --is-bare-repository 2>/dev/null)" ]; then
@@ -309,10 +315,17 @@ __git_ps1 ()
 			if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
 				__git_ps1_show_upstream
 			fi
+			branch=${b##refs/heads/}
+            if [ -n "${GIT_PS1_SHOWBRANCHREMOTE-}" ]; then
+                remote=`git config --get branch.$branch.remote`
+                if [[ $remote ]]; then
+                	remote=$remote:
+                fi
+            fi
 		fi
 
 		local f="$w$i$s$u"
-		printf "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
+		printf "${1:- (%s)}" "$c$remote$branch${f:+ $f}$r$p"
 	fi
 }
 
-- 
1.7.5.4
