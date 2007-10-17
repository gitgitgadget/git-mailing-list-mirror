From: Jonathan del Strother <maillist@steelskies.com>
Subject: [PATCH 1/2] Fixing path quoting in git-rebase
Date: Wed, 17 Oct 2007 10:31:35 +0100
Message-ID: <11926134961549-git-send-email-maillist@steelskies.com>
References: <B495731E-C854-450B-943B-B96248B8F609@steelskies.com>
 <11926134961610-git-send-email-maillist@steelskies.com>
Cc: Jonathan del Strother <jon.delStrother@bestbefore.tv>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 17 11:31:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii5Fn-0004q0-79
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 11:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757742AbXJQJbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 05:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757637AbXJQJbk
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 05:31:40 -0400
Received: from gir.office.bestbefore.tv ([89.105.122.147]:53719 "EHLO
	gir.office.bestbefore.tv" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754932AbXJQJbi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 05:31:38 -0400
Received: by gir.office.bestbefore.tv (Postfix, from userid 501)
	id 68A742B97FE; Wed, 17 Oct 2007 10:31:36 +0100 (BST)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <11926134961610-git-send-email-maillist@steelskies.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61357>

From: Jonathan del Strother <jon.delStrother@bestbefore.tv>

git-rebase used to fail when run from a path with a space in.

Signed-off-by: Jonathan del Strother <jon.delStrother@bestbefore.tv>
---
 git-rebase.sh |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 1583402..224cca9 100755
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
+	eval GITHEAD_$hd='$(cat "$dotest/onto_name")'
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
