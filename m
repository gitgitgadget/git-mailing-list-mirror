From: Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
Subject: [PATCH 1/2] git-bisect.sh : create a file if the bisection is in old/new mode, named "BISECT_OLDNEWMODE", so it can easily be seen outside the program without having to read BISECT_TERMS. This will have to be changed in further versions if new terms are introduced.
Date: Fri,  5 Jun 2015 18:34:20 +0200
Message-ID: <1433522061-14532-1-git-send-email-stuberl@ensimag.grenoble-inp.fr>
Cc: remi.galan-alfonso@ensimag.grenoble-inp.fr,
	remi.lespinet@ensimag.grenoble-inp.fr,
	matthieu.moy@grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr, j_franck7@msn.com,
	valentinduperray@gmail.com, thomasxnguy@gmail.com,
	lucienkong@hotmail.com, chriscool@tuxfamily.org,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 18:34:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0uZo-0002QE-Ug
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 18:34:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422747AbbFEQec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 12:34:32 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:54351 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422669AbbFEQeb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2015 12:34:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 1C3FE2873;
	Fri,  5 Jun 2015 18:34:29 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9L7E1ATb5ODl; Fri,  5 Jun 2015 18:34:29 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 099BA2870;
	Fri,  5 Jun 2015 18:34:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id F07F620E4;
	Fri,  5 Jun 2015 18:34:28 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jyE90Jgx2jT6; Fri,  5 Jun 2015 18:34:28 +0200 (CEST)
Received: from ensipc253.imag.fr (ensipc253.imag.fr [129.88.241.113])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id C601820DF;
	Fri,  5 Jun 2015 18:34:28 +0200 (CEST)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270852>


Signed-off-by: Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
Signed-off-by: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
---
 git-bisect.sh |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 109bd65..d3d19cb 100644
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -183,6 +183,10 @@ bisect_start() {
 	then
 		echo "$BISECT_BAD" >"$GIT_DIR/BISECT_TERMS" &&
 		echo "$BISECT_GOOD" >>"$GIT_DIR/BISECT_TERMS"
+		if test "$BISECT_BAD" = "new"
+		then
+			echo "" > "$GIT_DIR/BISECT_OLDNEWMODE"
+		fi
 	fi &&
 	echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
 	#
@@ -416,6 +420,7 @@ bisect_clean_state() {
 	rm -f "$GIT_DIR/BISECT_NAMES" &&
 	rm -f "$GIT_DIR/BISECT_RUN" &&
 	rm -f "$GIT_DIR/BISECT_TERMS" &&
+	rm -f "$GIT_DIR/BISECT_OLDNEWMODE" &&
 	# Cleanup head-name if it got left by an old version of git-bisect
 	rm -f "$GIT_DIR/head-name" &&
 	git update-ref -d --no-deref BISECT_HEAD &&
@@ -544,7 +549,8 @@ check_and_set_terms () {
 			if test ! -s "$GIT_DIR/BISECT_TERMS"
 			then
 				echo "new" >"$GIT_DIR/BISECT_TERMS" &&
-				echo "old" >>"$GIT_DIR/BISECT_TERMS"
+				echo "old" >>"$GIT_DIR/BISECT_TERMS" &&
+				echo "" > "$GIT_DIR/BISECT_OLDNEWMODE"
 			fi
 			BISECT_BAD="new"
 			BISECT_GOOD="old" ;;
-- 
1.7.1
