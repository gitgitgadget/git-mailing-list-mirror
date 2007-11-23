From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git checkout's reflog: even when detaching the HEAD, say
 from where
Date: Fri, 23 Nov 2007 00:20:35 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711230020080.27959@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Nov 23 01:21:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvMIU-0006Oa-TI
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 01:21:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbXKWAVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 19:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbXKWAVM
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 19:21:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:38056 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751266AbXKWAVL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 19:21:11 -0500
Received: (qmail invoked by alias); 23 Nov 2007 00:21:08 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp001) with SMTP; 23 Nov 2007 01:21:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/9w01mY9D9q1HmXq2Bb+HMB1ufTCDUExwqwhZ68w
	pXPKTVMzmdgDui
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65859>


When checking out another ref, the reflogs already record from which
branch you switched.  Do that also when switching to a detached HEAD.

While at it, record also when coming _from_ a detached HEAD.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Yeah, took me a long time to take care of this issue.

 git-checkout.sh |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-checkout.sh b/git-checkout.sh
index aa724ac..5dc8ddb 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -266,7 +266,7 @@ if [ "$?" -eq 0 ]; then
 	if test -n "$branch"
 	then
 		old_branch_name=`expr "z$oldbranch" : 'zrefs/heads/\(.*\)'`
-		GIT_DIR="$GIT_DIR" git symbolic-ref -m "checkout: moving from $old_branch_name to $branch" HEAD "refs/heads/$branch"
+		GIT_DIR="$GIT_DIR" git symbolic-ref -m "checkout: moving from ${old_branch_name:-$old} to $branch" HEAD "refs/heads/$branch"
 		if test -n "$quiet"
 		then
 			true	# nothing
@@ -278,7 +278,8 @@ if [ "$?" -eq 0 ]; then
 		fi
 	elif test -n "$detached"
 	then
-		git update-ref --no-deref -m "checkout: moving to $arg" HEAD "$detached" ||
+		old_branch_name=`expr "z$oldbranch" : 'zrefs/heads/\(.*\)'`
+		git update-ref --no-deref -m "checkout: moving from ${old_branch_name:-$old} to $arg" HEAD "$detached" ||
 			die "Cannot detach HEAD"
 		if test -n "$detach_warn"
 		then
-- 
1.5.3.6.1977.g54d30
