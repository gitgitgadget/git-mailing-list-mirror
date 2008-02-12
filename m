From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] git bisect should not expand file globs in log
Date: Tue, 12 Feb 2008 19:50:57 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802121950210.3870@racer.site>
References: <200802122023.28879.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
X-From: git-owner@vger.kernel.org Tue Feb 12 20:51:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP1AH-0001t7-6q
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 20:51:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752876AbYBLTuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 14:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752465AbYBLTuw
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 14:50:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:53648 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752630AbYBLTuv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 14:50:51 -0500
Received: (qmail invoked by alias); 12 Feb 2008 19:50:49 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp048) with SMTP; 12 Feb 2008 20:50:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18e5bh9DEge7RK+741mQrvx/zZ5mQuWqobwnybFrz
	hVqdrJJuX5boZ/
X-X-Sender: gene099@racer.site
In-Reply-To: <200802122023.28879.elendil@planet.nl>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73685>

Hi,

does this help?  (It is a really trivial patch...)

-- snipsnap --
[PATCH] bisect: use verbatim commit subject in the bisect log

Due to a typo, the commit subject was shell expanded in the bisect log.
That is, if you had some shell pattern in the commit subject, bisect
would happily put all matching file names into the log.

Noticed by Frans Pop.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-bisect.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 5385249..0bb51d7 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -131,7 +131,7 @@ bisect_write() {
 		*)		die "Bad bisect_write argument: $state" ;;
 	esac
 	git update-ref "refs/bisect/$tag" "$rev"
-	echo "# $state: "$(git show-branch $rev) >>"$GIT_DIR/BISECT_LOG"
+	echo "# $state: $(git show-branch $rev)" >>"$GIT_DIR/BISECT_LOG"
 	test -z "$nolog" && echo "git-bisect $state $rev" >>"$GIT_DIR/BISECT_LOG"
 }
 
-- 
1.5.4.18.gb6d712
