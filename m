From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH] bisect: take advantage of gettextln, eval_gettextln.
Date: Wed, 31 Aug 2011 09:09:47 +1000
Message-ID: <1314745788-5060-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 31 01:10:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyXRg-0001J2-R3
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 01:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870Ab1H3XKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 19:10:07 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41386 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752989Ab1H3XKG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 19:10:06 -0400
Received: by ywf7 with SMTP id 7so132249ywf.19
        for <git@vger.kernel.org>; Tue, 30 Aug 2011 16:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=arN2vMu/R2X5ZyEuZIIm3OHa+oh46Th06GzM9SK1FF8=;
        b=bOdO5YtXp8Nrz055WgAki7p6L5vy6XpMVHf+pP074vWU+xVP7PAUsOq4MybvDGOHc/
         /WKEruCKqucHweEx2zjZbMUkJzcseSUeiKuH6z60zMRdfBLw8mBMDwmKLOemK5qLKaeH
         P07DDAHjnL9H5AYoPhe/4IXi8OIOziBU00Afs=
Received: by 10.150.187.8 with SMTP id k8mr6678105ybf.64.1314745805440;
        Tue, 30 Aug 2011 16:10:05 -0700 (PDT)
Received: from localhost.localdomain (124-149-177-137.dyn.iinet.net.au [124.149.177.137])
        by mx.google.com with ESMTPS id e8sm20408ybg.8.2011.08.30.16.10.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 30 Aug 2011 16:10:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.44.gdbb64d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180447>

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-bisect.sh |   49 ++++++++++++++-----------------------------------
 1 files changed, 14 insertions(+), 35 deletions(-)

Now that both dependencies have been merged into master, this patch is ready
to be merged.

diff --git a/git-bisect.sh b/git-bisect.sh
index e0ca3fb..2524060 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -45,10 +45,7 @@ bisect_head()
 
 bisect_autostart() {
 	test -s "$GIT_DIR/BISECT_START" || {
-		(
-			gettext "You need to start by \"git bisect start\"" &&
-			echo
-		) >&2
+		gettextln "You need to start by \"git bisect start\"" >&2
 		if test -t 0
 		then
 			# TRANSLATORS: Make sure to include [Y] and [n] in your
@@ -272,10 +269,7 @@ bisect_next_check() {
 	t,,good)
 		# have bad but not good.  we could bisect although
 		# this is less optimum.
-		(
-			gettext "Warning: bisecting only with a bad commit." &&
-			echo
-		) >&2
+		gettextln "Warning: bisecting only with a bad commit." >&2
 		if test -t 0
 		then
 			# TRANSLATORS: Make sure to include [Y] and [n] in your
@@ -291,18 +285,12 @@ bisect_next_check() {
 
 		if test -s "$GIT_DIR/BISECT_START"
 		then
-			(
-				gettext "You need to give me at least one good and one bad revisions.
-(You can use \"git bisect bad\" and \"git bisect good\" for that.)" &&
-				echo
-			) >&2
+			gettextln "You need to give me at least one good and one bad revisions.
+(You can use \"git bisect bad\" and \"git bisect good\" for that.)" >&2
 		else
-			(
-				gettext "You need to start by \"git bisect start\".
+			gettextln "You need to start by \"git bisect start\".
 You then need to give me at least one good and one bad revisions.
-(You can use \"git bisect bad\" and \"git bisect good\" for that.)" &&
-				echo
-			) >&2
+(You can use \"git bisect bad\" and \"git bisect good\" for that.)" >&2
 		fi
 		exit 1 ;;
 	esac
@@ -355,7 +343,7 @@ bisect_visualize() {
 
 bisect_reset() {
 	test -s "$GIT_DIR/BISECT_START" || {
-		gettext "We are not bisecting."; echo
+		gettextln "We are not bisecting."
 		return
 	}
 	case "$#" in
@@ -428,18 +416,15 @@ bisect_run () {
 	while true
 	do
 		command="$@"
-		eval_gettext "running \$command"; echo
+		eval_gettextln "running \$command"
 		"$@"
 		res=$?
 
 		# Check for really bad run error.
 		if [ $res -lt 0 -o $res -ge 128 ]
 		then
-			(
-				eval_gettext "bisect run failed:
-exit code \$res from '\$command' is < 0 or >= 128" &&
-				echo
-			) >&2
+			eval_gettextln "bisect run failed:
+exit code \$res from '\$command' is < 0 or >= 128" >&2
 			exit $res
 		fi
 
@@ -464,26 +449,20 @@ exit code \$res from '\$command' is < 0 or >= 128" &&
 		if sane_grep "first bad commit could be any of" "$GIT_DIR/BISECT_RUN" \
 			> /dev/null
 		then
-			(
-				gettext "bisect run cannot continue any more" &&
-				echo
-			) >&2
+			gettextln "bisect run cannot continue any more" >&2
 			exit $res
 		fi
 
 		if [ $res -ne 0 ]
 		then
-			(
-				eval_gettext "bisect run failed:
-'bisect_state \$state' exited with error code \$res" &&
-				echo
-			) >&2
+			eval_gettextln "bisect run failed:
+'bisect_state \$state' exited with error code \$res" >&2
 			exit $res
 		fi
 
 		if sane_grep "is the first bad commit" "$GIT_DIR/BISECT_RUN" > /dev/null
 		then
-			gettext "bisect run success"; echo
+			gettextln "bisect run success"
 			exit 0;
 		fi
 
-- 
1.7.6.44.gdbb64d
