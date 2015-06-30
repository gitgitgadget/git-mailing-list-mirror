From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/3] fixup! git rebase -i: add static check for commands and SHA-1
Date: Tue, 30 Jun 2015 11:19:19 +0200
Message-ID: <1435655961-31263-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1435609232-14232-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
 <1435655961-31263-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr, sunshine@sunshineco.com,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jun 30 11:29:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9rqo-00058x-AC
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 11:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbbF3J3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 05:29:07 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50114 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750913AbbF3J27 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 05:28:59 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5U9Sorv031020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Jun 2015 11:28:50 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5U9SpBx018305;
	Tue, 30 Jun 2015 11:28:51 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Z9rqV-0000VK-BT; Tue, 30 Jun 2015 11:28:51 +0200
X-Mailer: git-send-email 2.5.0.rc0.10.g7792c2a
In-Reply-To: <1435655961-31263-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 30 Jun 2015 11:28:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5U9Sorv031020
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1436261331.56712@YjiiCwEVoosAxNPmfxrJuQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273037>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 git-rebase--interactive.sh | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index ec4a068..9041d15 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -871,8 +871,7 @@ check_bad_cmd_and_sha () {
 		while read -r line
 		do
 			IFS=' '
-			set x $line
-			shift
+			set -- $line
 			command=$1
 			sha1=$2
 
@@ -881,8 +880,7 @@ check_bad_cmd_and_sha () {
 				# Doesn't expect a SHA-1
 				;;
 			pick|p|drop|d|reword|r|edit|e|squash|s|fixup|f)
-				check_commit_sha $sha1 "$line"
-				if test $? -ne 0
+				if ! check_commit_sha $sha1 "$line"
 				then
 					retval=1
 				fi
@@ -988,8 +986,7 @@ check_todo_list () {
 		;;
 	esac
 
-	check_bad_cmd_and_sha <"$todo"
-	if test $? -ne 0
+	if ! check_bad_cmd_and_sha <"$todo"
 	then
 		raise_error=t
 	fi
-- 
2.5.0.rc0.10.g7792c2a
