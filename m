From: Daniel Trstenjak <daniel.trstenjak@online.de>
Subject: Re: [PATCH] Show presense of stashed changes in bash prompt.
Date: Tue, 2 Jun 2009 20:03:22 +0200
Message-ID: <20090602180322.GA5719@laptop>
References: <20090602114325.GA3427@laptop> <7vzlcqfyli.fsf@alter.siamese.dyndns.org> <20090602152915.GK30527@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Daniel Trstenjak <Daniel.Trstenjak@science-computing.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jun 02 20:03:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBYL6-0002Rs-Ge
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 20:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758196AbZFBSD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 14:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757856AbZFBSD3
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 14:03:29 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:62128 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755066AbZFBSD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 14:03:28 -0400
Received: from localhost (p5B0EEE2C.dip.t-dialin.net [91.14.238.44])
	by mrelayeu.kundenserver.de (node=mrelayeu4) with ESMTP (Nemesis)
	id 0ML21M-1MBYKZ0RCS-0002GS; Tue, 02 Jun 2009 20:03:26 +0200
Content-Disposition: inline
In-Reply-To: <20090602152915.GK30527@spearce.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Provags-ID: V01U2FsdGVkX1+3o2mnpSHkh3D8TdOn0MCrqnPiFw2OLdvT73P
 BpOMZusvPQFf+lxpILBLCYCK2p9oZB94xVWEm+iCy2VA3m4SNV
 nCHEbVwSPDI6djTCiuJSg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120531>

Avoid the forgetting of stashed changes by showing
them in the bash prompt.

If the presense is shown is configurable by setting
GIT_PS1_SHOWSTASHSTATE to a nonempty value.

The code for checking if the stash has entries is
taken from 'git-stash.sh'.

Signed-off-by: Daniel Trstenjak <daniel.trstenjak@online.de>
Acked-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 98b9cbe..c4ae423 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -40,6 +40,10 @@
 #       with the bash.showDirtyState variable, which defaults to true
 #       once GIT_PS1_SHOWDIRTYSTATE is enabled.
 #
+#       You can also see if currently something is stashed, by setting
+#       GIT_PS1_SHOWSTASHSTATE to a nonempty value. If something is stashed,
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
+			if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ]; then
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
