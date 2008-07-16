From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] rebase-i: keep old parents when preserving merges
Date: Wed, 16 Jul 2008 03:51:49 +0200
Message-ID: <1216173109-11155-1-git-send-email-s-beyer@gmx.net>
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 16 03:52:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIwCL-00056c-BF
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 03:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753790AbYGPBvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 21:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755175AbYGPBvz
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 21:51:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:40099 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752424AbYGPBvy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 21:51:54 -0400
Received: (qmail invoked by alias); 16 Jul 2008 01:51:52 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp021) with SMTP; 16 Jul 2008 03:51:53 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19P/cchLJBPkdl0fHiF93/eXDl37fF3/jGKloUnXv
	NVNhER8yS5fscm
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KIwBJ-0002uJ-10; Wed, 16 Jul 2008 03:51:49 +0200
X-Mailer: git-send-email 1.5.6.3.357.ge6ecd
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88628>

This patch fixes two issues for rebase -i with preserving
merges of unrelated branches.

Merge parents that are part of an unrelated branch have not been
kept as a parent in some cases.
That means, a rewritten merge commit has either lost a parent
or rebase tried to cherry-pick this merge commit which resulted
in an error.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 git-rebase--interactive.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a35212d..0df7640 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -174,6 +174,8 @@ pick_one_preserving_merges () {
 				new_parents="$new_parents $new_p"
 				;;
 			esac
+		else
+			new_parents="$new_parents $p"
 		fi
 	done
 	case $fast_forward in
-- 
1.5.6.3.357.ge6ecd
