From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] git-rebase.sh: Add check if rebase is in progress
Date: Sun, 22 Jun 2008 16:07:02 +0200
Message-ID: <1214143622-28897-1-git-send-email-s-beyer@gmx.net>
References: <485DC551.9020807@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Stephan Beyer <s-beyer@gmx.net>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 22 16:08:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAQEb-0008FS-6T
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 16:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610AbYFVOHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 10:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752566AbYFVOHF
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 10:07:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:36107 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752587AbYFVOHE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 10:07:04 -0400
Received: (qmail invoked by alias); 22 Jun 2008 14:07:03 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp043) with SMTP; 22 Jun 2008 16:07:03 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+Zn4Z8UreZy9+0ObgoYiurcRRTlr14HDesxKt86G
	4iN9I3tZxmVRJw
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KAQDe-0007WS-6w; Sun, 22 Jun 2008 16:07:02 +0200
X-Mailer: git-send-email 1.5.6.310.g344d
In-Reply-To: <485DC551.9020807@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85775>

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 git-rebase.sh |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index dd7dfe1..74f9c25 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -150,6 +150,9 @@ while test $# != 0
 do
 	case "$1" in
 	--continue)
+		test -d "$dotest" -o -d .dotest ||
+			die "No rebase in progress?"
+		
 		git diff-files --quiet --ignore-submodules || {
 			echo "You must edit all merge conflicts and then"
 			echo "mark them as resolved using git add"
@@ -178,6 +181,9 @@ do
 		exit
 		;;
 	--skip)
+		test -d "$dotest" -o -d .dotest ||
+			die "No rebase in progress?"
+		
 		git reset --hard HEAD || exit $?
 		if test -d "$dotest"
 		then
@@ -203,16 +209,16 @@ do
 		exit
 		;;
 	--abort)
+		test -d "$dotest" -o -d .dotest ||
+			die "No rebase in progress?"
+		
 		git rerere clear
 		if test -d "$dotest"
 		then
 			move_to_original_branch
-		elif test -d .dotest
-		then
+		else
 			dotest=.dotest
 			move_to_original_branch
-		else
-			die "No rebase in progress?"
 		fi
 		git reset --hard $(cat "$dotest/orig-head")
 		rm -r "$dotest"
-- 
1.5.6.310.g344d
