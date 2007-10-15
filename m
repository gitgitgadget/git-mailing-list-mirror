From: Jonathan del Strother <maillist@steelskies.com>
Subject: [PATCH 1/3] Fixing path quoting in git-rebase
Date: Mon, 15 Oct 2007 14:13:47 +0100
Message-ID: <11924540292687-git-send-email-maillist@steelskies.com>
References: <4711486B.1050301@op5.se>
Cc: Jonathan del Strother <jon.delStrother@bestbefore.tv>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 15:16:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhPlw-0005j7-3d
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 15:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761082AbXJONNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 09:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760956AbXJONNx
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 09:13:53 -0400
Received: from gir.office.bestbefore.tv ([89.105.122.147]:54116 "EHLO
	gir.office.bestbefore.tv" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760802AbXJONNv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 09:13:51 -0400
Received: by gir.office.bestbefore.tv (Postfix, from userid 501)
	id CA06D2A41C9; Mon, 15 Oct 2007 14:13:49 +0100 (BST)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <4711486B.1050301@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60991>

From: Jonathan del Strother <jon.delStrother@bestbefore.tv>

git-rebase used to fail when run from a path with a space in.

Signed-off-by: Jonathan del Strother <jon.delStrother@bestbefore.tv>
---
 git-rebase.sh |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 1583402..9995d9d 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -59,7 +59,7 @@ continue_merge () {
 		die "$RESOLVEMSG"
 	fi
 
-	cmt=`cat $dotest/current`
+	cmt=`cat "$dotest/current"`
 	if ! git diff-index --quiet HEAD
 	then
 		if ! git-commit -C "$cmt"
@@ -84,14 +84,14 @@ continue_merge () {
 }
 
 call_merge () {
-	cmt="$(cat $dotest/cmt.$1)"
+	cmt="$(cat "$dotest/cmt.$1")"
 	echo "$cmt" > "$dotest/current"
 	hd=$(git rev-parse --verify HEAD)
 	cmt_name=$(git symbolic-ref HEAD)
-	msgnum=$(cat $dotest/msgnum)
-	end=$(cat $dotest/end)
+	msgnum=$(cat "$dotest/msgnum")
+	end=$(cat "$dotest/end")
 	eval GITHEAD_$cmt='"${cmt_name##refs/heads/}~$(($end - $msgnum))"'
-	eval GITHEAD_$hd='"$(cat $dotest/onto_name)"'
+	eval GITHEAD_$hd='"$(cat \"$dotest/onto_name\")"'
 	export GITHEAD_$cmt GITHEAD_$hd
 	git-merge-$strategy "$cmt^" -- "$hd" "$cmt"
 	rv=$?
@@ -140,10 +140,10 @@ do
 		}
 		if test -d "$dotest"
 		then
-			prev_head="`cat $dotest/prev_head`"
-			end="`cat $dotest/end`"
-			msgnum="`cat $dotest/msgnum`"
-			onto="`cat $dotest/onto`"
+			prev_head=$(cat "$dotest/prev_head")
+			end=$(cat "$dotest/end")
+			msgnum=$(cat "$dotest/msgnum")
+			onto=$(cat "$dotest/onto")
 			continue_merge
 			while test "$msgnum" -le "$end"
 			do
@@ -160,11 +160,11 @@ do
 		if test -d "$dotest"
 		then
 			git rerere clear
-			prev_head="`cat $dotest/prev_head`"
-			end="`cat $dotest/end`"
-			msgnum="`cat $dotest/msgnum`"
+			prev_head=$(cat "$dotest/prev_head")
+			end=$(cat "$dotest/end")
+			msgnum=$(cat "$dotest/msgnum")
 			msgnum=$(($msgnum + 1))
-			onto="`cat $dotest/onto`"
+			onto=$(cat "$dotest/onto")
 			while test "$msgnum" -le "$end"
 			do
 				call_merge "$msgnum"
-- 
1.5.3.1
