From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1/2] rebase: check for errors from git-commit
Date: Wed, 28 Jun 2006 02:11:05 -0700
Message-ID: <11514858662929-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jun 28 11:11:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvW4m-00028J-Au
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 11:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030486AbWF1JLJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 05:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030489AbWF1JLJ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 05:11:09 -0400
Received: from hand.yhbt.net ([66.150.188.102]:25561 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1030486AbWF1JLI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jun 2006 05:11:08 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 521CA7DC022;
	Wed, 28 Jun 2006 02:11:06 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 28 Jun 2006 02:11:06 -0700
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-Mailer: git-send-email 1.4.1.rc1.g3cc8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22785>

commit does not always succeed, so we'll have to check for
it in the absence of set -e.  This fixes a regression
introduced in 9e4bc7dd1bb9d92491c475cec55147fa0b3f954d

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

 I've grown used to having 'set -e' at the beginning of my shell
 scripts.  IMHO it'd be a good idea to start moving towards this
 eventually (even though shell scripts seem to be getting phased-out
 somewhat).

 git-rebase.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 9ad1c44..47c8e8f 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -59,8 +59,8 @@ continue_merge () {
 
 	if test -n "`git-diff-index HEAD`"
 	then
+		git-commit -C "`cat $dotest/current`" || die 'Commit failed'
 		printf "Committed: %0${prec}d" $msgnum
-		git-commit -C "`cat $dotest/current`"
 	else
 		printf "Already applied: %0${prec}d" $msgnum
 	fi
-- 
1.4.1.rc1.g3cc8
