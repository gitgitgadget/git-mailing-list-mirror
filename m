From: Daniel Trstenjak <Daniel.Trstenjak@online.de>
Subject: [PATCH] Show presense of stashed changes in bash prompt.
Date: Tue, 2 Jun 2009 13:43:25 +0200
Message-ID: <20090602114325.GA3427@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Trstenjak <Daniel.Trstenjak@science-computing.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 13:48:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBSTu-0007Ix-Qr
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 13:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759210AbZFBLs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 07:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757695AbZFBLs2
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 07:48:28 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:53326 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756921AbZFBLs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 07:48:27 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jun 2009 07:48:27 EDT
Received: from localhost (p5B0EE26C.dip.t-dialin.net [91.14.226.108])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0MKsym-1MBSOr39Vv-000dLF; Tue, 02 Jun 2009 13:43:26 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Provags-ID: V01U2FsdGVkX1+kmrgIEoaShQnChbozxbTQxlH3742edcKu6Ex
 pCbTQ4aRKnAhVCfb3v0gvaWxuuFtMMxDuYy41w5cYfEBvoKT9v
 kH80smuaJ5FYui7t7ctgQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120504>

Avoid the forgetting of stashed changes by showing
them in the bash prompt.

If the presense is shown is configurable by setting
GIT_PS1_SHOW_STASH_STATE to a nonempty value.

The code for checking if the stash has entries is
taken from 'git-stash.sh'.

Signed-off-by: Daniel Trstenjak <daniel.trstenjak@online.de>
---
 contrib/completion/git-completion.bash |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 98b9cbe..ed0c463 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -40,6 +40,10 @@
 #       with the bash.showDirtyState variable, which defaults to true
 #       once GIT_PS1_SHOWDIRTYSTATE is enabled.
 #
+#       You can also see if currently something is stashed, by setting
+#       GIT_PS1_SHOW_STASH_STATE to a nonempty value. If something is stashed,
+#       then a '$' will be shown next to the branch name. 
+#
 # To submit patches:
 #
 #    *) Read Documentation/SubmittingPatches
@@ -127,6 +131,7 @@ __git_ps1 ()
 
 		local w
 		local i
+		local s
 		local c
 
 		if [ "true" = "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]; then
@@ -148,12 +153,15 @@ __git_ps1 ()
 					fi
 				fi
 			fi
+			if [ -n "${GIT_PS1_SHOW_STASH_STATE-}" ]; then
+			        git rev-parse --verify refs/stash >/dev/null 2>&1 && s="$"
+			fi
 		fi
 
 		if [ -n "${1-}" ]; then
-			printf "$1" "$c${b##refs/heads/}$w$i$r"
+			printf "$1" "$c${b##refs/heads/}$w$i$s$r"
 		else
-			printf " (%s)" "$c${b##refs/heads/}$w$i$r"
+			printf " (%s)" "$c${b##refs/heads/}$w$i$s$r"
 		fi
 	fi
 }
-- 
1.6.1.2
