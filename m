From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Bisect visualize: use "for-each-ref" to list all good refs.
Date: Wed, 14 Nov 2007 05:50:36 +0100
Message-ID: <20071114055036.2c5ae793.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Nov 14 05:44:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsA6m-0000OR-3u
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 05:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755171AbXKNEnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 23:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755522AbXKNEnz
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 23:43:55 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:50677 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753617AbXKNEny (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 23:43:54 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 7A4341AB2B5;
	Wed, 14 Nov 2007 05:43:53 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 29F571AB2AC;
	Wed, 14 Nov 2007 05:43:51 +0100 (CET)
X-Mailer: Sylpheed 2.4.7 (GTK+ 2.12.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64946>

In bisect_visualize, "cd $GIT_DIR/refs && echo bisect/good-*" was
still used instead of "git for-each-ref". This patch fix it.

We now pass "refs/bisect/bad" and "--not refs/bisect/good-<rev>"
instead of "bisect/bad" and "--not bisect/good-<rev>" to gitk,
but it seems to work.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 1ed44e5..8d75d91 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -326,8 +326,8 @@ bisect_next() {
 
 bisect_visualize() {
 	bisect_next_check fail
-	not=`cd "$GIT_DIR/refs" && echo bisect/good-*`
-	eval gitk bisect/bad --not $not -- $(cat "$GIT_DIR/BISECT_NAMES")
+	not=$(git for-each-ref --format='%(refname)' "refs/bisect/good-*")
+	eval gitk refs/bisect/bad --not $not -- $(cat "$GIT_DIR/BISECT_NAMES")
 }
 
 bisect_reset() {
-- 
1.5.3.5.629.g807b3
