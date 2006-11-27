X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 4/10] Add current branch in PS1 support to git-completion.bash.
Date: Mon, 27 Nov 2006 03:41:28 -0500
Message-ID: <20061127084128.GD19745@spearce.org>
References: <de7beb117fb963e68e1085b773593be326ffd495.1164616814.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 08:41:38 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <de7beb117fb963e68e1085b773593be326ffd495.1164616814.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32394>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Goc3T-0007Zo-76 for gcvg-git@gmane.org; Mon, 27 Nov
 2006 09:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757418AbWK0Ilc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 03:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757419AbWK0Ilc
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 03:41:32 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:908 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1757418AbWK0Ilb
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 03:41:31 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Goc3M-0004S9-0j; Mon, 27 Nov 2006 03:41:28 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 7FA9A20FB7F; Mon, 27 Nov 2006 03:41:28 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Many users want to display the current branch name of the current git
repository as part of their PS1 prompt, much as their PS1 prompt might
also display the current working directory name.

We don't force our own PS1 onto the user.  Instead we let them craft
their own PS1 string and offer them the function __git_ps1 which they
can invoke to obtain either "" (when not in a git repository) or
"(%s)" where %s is the name of the current branch, as read from HEAD,
with the leading refs/heads/ removed.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1dfb592..a740d05 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -18,12 +18,31 @@
 #    2) Added the following line to your .bashrc:
 #        source ~/.git-completion.sh
 #
+#    3) Consider changing your PS1 to also show the current branch:
+#        PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
+#
+#       The argument to __git_ps1 will be displayed only if you
+#       are currently in a git repository.  The %s token will be
+#       the name of the current branch.
+#
 
 __gitdir ()
 {
 	echo "${__git_dir:-$(git rev-parse --git-dir 2>/dev/null)}"
 }
 
+__git_ps1 ()
+{
+	local b="$(git symbolic-ref HEAD 2>/dev/null)"
+	if [ -n "$b" ]; then
+		if [ -n "$1" ]; then
+			printf "$1" "${b##refs/heads/}"
+		else
+			printf " (%s)" "${b##refs/heads/}"
+		fi
+	fi
+}
+
 __git_refs ()
 {
 	local cmd i is_hash=y dir="${1:-$(__gitdir)}"
-- 
1.4.4.1.ge3fb
