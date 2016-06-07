From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v4 07/38] i18n: merge-octopus: mark messages for translation
Date: Tue,  7 Jun 2016 11:52:06 +0000
Message-ID: <1465300357-7557-8-git-send-email-vascomalmeida@sapo.pt>
References: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 13:54:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAFaD-00071x-FG
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 13:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754725AbcFGLyB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 07:54:01 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:53895 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754542AbcFGLxz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 07:53:55 -0400
Received: (qmail 23337 invoked from network); 7 Jun 2016 11:53:54 -0000
Received: (qmail 11501 invoked from network); 7 Jun 2016 11:53:53 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 7 Jun 2016 11:53:48 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296635>

Mark messages in git-merge-octopus.sh for translation.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-merge-octopus.sh | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/git-merge-octopus.sh b/git-merge-octopus.sh
index dc2fd1b..89e967a 100755
--- a/git-merge-octopus.sh
+++ b/git-merge-octopus.sh
@@ -5,6 +5,8 @@
 # Resolve two or more trees.
 #
 
+. git-sh-i18n
+
 LF='
 '
 
@@ -46,7 +48,7 @@ esac
 
 if ! git diff-index --quiet --cached HEAD --
 then
-    echo "Error: Your local changes to the following files would be overwritten by merge"
+    gettextln "Error: Your local changes to the following files would be overwritten by merge"
     git diff-index --cached --name-only HEAD -- | sed -e 's/^/    /'
     exit 2
 fi
@@ -61,8 +63,8 @@ do
 		# We allow only last one to have a hand-resolvable
 		# conflicts.  Last round failed and we still had
 		# a head to merge.
-		echo "Automated merge did not work."
-		echo "Should not be doing an Octopus."
+		gettextln "Automated merge did not work."
+		gettextln "Should not be doing an Octopus."
 		exit 2
 	esac
 
@@ -73,11 +75,11 @@ do
 		eval pretty_name=\${GITHEAD_$SHA1_UP:-$pretty_name}
 	fi
 	common=$(git merge-base --all $SHA1 $MRC) ||
-		die "Unable to find common commit with $pretty_name"
+		die "$(eval_gettext "Unable to find common commit with \$pretty_name")"
 
 	case "$LF$common$LF" in
 	*"$LF$SHA1$LF"*)
-		echo "Already up-to-date with $pretty_name"
+		eval_gettextln "Already up-to-date with \$pretty_name"
 		continue
 		;;
 	esac
@@ -89,7 +91,7 @@ do
 		# tree as the intermediate result of the merge.
 		# We still need to count this as part of the parent set.
 
-		echo "Fast-forwarding to: $pretty_name"
+		eval_gettextln "Fast-forwarding to: \$pretty_name"
 		git read-tree -u -m $head $SHA1 || exit
 		MRC=$SHA1 MRT=$(git write-tree)
 		continue
@@ -97,12 +99,12 @@ do
 
 	NON_FF_MERGE=1
 
-	echo "Trying simple merge with $pretty_name"
+	eval_gettextln "Trying simple merge with \$pretty_name"
 	git read-tree -u -m --aggressive  $common $MRT $SHA1 || exit 2
 	next=$(git write-tree 2>/dev/null)
 	if test $? -ne 0
 	then
-		echo "Simple merge did not work, trying automatic merge."
+		gettextln "Simple merge did not work, trying automatic merge."
 		git-merge-index -o git-merge-one-file -a ||
 		OCTOPUS_FAILURE=1
 		next=$(git write-tree 2>/dev/null)
-- 
2.7.3
