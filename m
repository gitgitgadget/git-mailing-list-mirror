From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git checkout's reflog: even when detaching the HEAD, say
 from where
Date: Tue, 7 Aug 2007 02:42:27 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708070242140.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 07 03:43:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIE6M-0001fi-Bj
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 03:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763624AbXHGBnJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 21:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763046AbXHGBnI
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 21:43:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:53730 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762611AbXHGBnH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 21:43:07 -0400
Received: (qmail invoked by alias); 07 Aug 2007 01:43:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp021) with SMTP; 07 Aug 2007 03:43:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/mTzIAJ0rmS5p1cdSUJ0t507JUFN57w4W04VMhvX
	Xp7xXfdG3WrxxJ
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55195>


When checking out another ref, the reflogs already record from which
branch you switched.  Do that also when switching to a detached HEAD.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-checkout.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-checkout.sh b/git-checkout.sh
index 17f4392..f427718 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -272,7 +272,8 @@ if [ "$?" -eq 0 ]; then
 		fi
 	elif test -n "$detached"
 	then
-		git update-ref --no-deref -m "checkout: moving to $arg" HEAD "$detached" ||
+		old_branch_name=`expr "z$oldbranch" : 'zrefs/heads/\(.*\)'`
+		git update-ref --no-deref -m "checkout: moving from $old_branch_name to $arg" HEAD "$detached" ||
 			die "Cannot detach HEAD"
 		if test -n "$detach_warn"
 		then
-- 
1.5.3.rc4.17.gb980
