From: Matthew Wilcox <matthew@wil.cx>
Subject: default update hook broken
Date: Mon, 21 Nov 2005 07:09:14 -0700
Message-ID: <20051121140914.GB1598@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Nov 21 15:10:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeCMW-0002UL-Ap
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 15:09:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbVKUOJQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 09:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbVKUOJQ
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 09:09:16 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:28874 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S932135AbVKUOJQ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 09:09:16 -0500
Received: by palinux.hppa (Postfix, from userid 26919)
	id 18B584940D7; Mon, 21 Nov 2005 07:09:15 -0700 (MST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12444>


There's two syntax errors and one good-netizen error in the hooks/update
file created when cloning Linus' linux-2.6.git repo.  I don't know
if that file is created fresh or if it gets pulled from Linus' tree.
Here's a patch to fix it

--- .git/hooks/update	2005-11-21 06:31:51.000000000 -0700
+++ /home/willy/replacement-update	2005-11-21 07:01:37.000000000 -0700
@@ -8,14 +8,14 @@
 # (2) make this file executable by "chmod +x update".
 #
 
-recipient="commit-list@mydomain.xz"
+recipient="commit-list@example.com"
 
 if expr "$2" : '0*$' >/dev/null
 then
 	echo "Created a new ref, with the following commits:"
 	git-rev-list --pretty "$3"
 else
-	$base=$(git-merge-base "$2" "$3")
+	base=$(git-merge-base "$2" "$3")
 	case "$base" in
 	"$2")
 		echo "New commits:"
@@ -24,8 +24,7 @@
 		echo "Rebased ref, commits from common ancestor:"
 		;;
 	esac
-fi
-git-rev-list --pretty "$3" "^$base"
+	git-rev-list --pretty "$3" "^$base"
 fi |
 mail -s "Changes to ref $1" "$recipient"
 exit 0
