From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Bisect: Improve error message in "bisect_next_check".
Date: Thu, 29 Mar 2007 09:42:35 +0200
Message-ID: <20070329094235.816d15e9.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 09:34:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWp9j-0003vy-Qf
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 09:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292AbXC2Hea (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 03:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753300AbXC2Hea
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 03:34:30 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:50933 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753298AbXC2Hea (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 03:34:30 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id C2678B6242;
	Thu, 29 Mar 2007 09:34:24 +0200 (CEST)
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43406>

So we can remove the specific message in "bisect_run".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---

Junio C Hamano wrote:

> Doesn't that suggest the existing messages from "git bisect good/bad"
> can use the same improvement you added only to "bisect run"?

You mean something like this patch ?
(It does not print a long message any more.)


 git-bisect.sh |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 57d6754..7fcdc74 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -123,7 +123,15 @@ bisect_next_check() {
 	case "$next_ok,$1" in
 	no,) false ;;
 	no,fail)
-	    echo >&2 'You need to give me at least one good and one bad revisions.'
+	    ALSO=''
+	    test -d "$GIT_DIR/refs/bisect" || {
+		echo >&2 'You need to start by "git bisect start".'
+		ALSO='also '
+	    }
+	    echo >&2 'You '$ALSO'need to give me at least one good' \
+		'and one bad revisions.'
+	    echo >&2 '(You can use "git bisect bad" and' \
+		'"git bisect good" for that.)'
 	    exit 1 ;;
 	*)
 	    true ;;
@@ -223,12 +231,6 @@ bisect_replay () {
 }
 
 bisect_run () {
-    # Check that we have everything to run correctly.
-    test -d "$GIT_DIR/refs/bisect" || {
-	echo >&2 'You need to start by "git bisect start".'
-	echo >&2 'And then by "git bisect bad" and "git bisect good".'
-	exit 1
-    }
     bisect_next_check fail
 
     while true
-- 
1.5.1.rc2.15.g465b3-dirty
