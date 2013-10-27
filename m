From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v4 12/10] git-remote-testgit:  support the new 'force' option
Date: Sun, 27 Oct 2013 17:16:28 -0400
Message-ID: <1382908589-7000-1-git-send-email-rhansen@bbn.com>
References: <1382857521-7005-1-git-send-email-felipe.contreras@gmail.com>
Cc: srabbelier@gmail.com, felipe.contreras@gmail.com,
	Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 27 22:16:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaXhZ-0007Co-Bf
	for gcvg-git-2@plane.gmane.org; Sun, 27 Oct 2013 22:16:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754332Ab3J0VQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Oct 2013 17:16:45 -0400
Received: from smtp.bbn.com ([128.33.0.80]:43857 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753605Ab3J0VQp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Oct 2013 17:16:45 -0400
Received: from socket.bbn.com ([192.1.120.102]:57064)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VaXhU-0002BG-CF; Sun, 27 Oct 2013 17:16:44 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 852FE4007B
X-Mailer: git-send-email 1.8.4.1.614.ga09cf56
In-Reply-To: <1382857521-7005-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236811>

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 git-remote-testgit.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/git-remote-testgit.sh b/git-remote-testgit.sh
index 6d2f282..80546c1 100755
--- a/git-remote-testgit.sh
+++ b/git-remote-testgit.sh
@@ -6,6 +6,7 @@ url=$2
 
 dir="$GIT_DIR/testgit/$alias"
 prefix="refs/testgit/$alias"
+forcearg=
 
 default_refspec="refs/heads/*:${prefix}/heads/*"
 
@@ -39,6 +40,7 @@ do
 		fi
 		test -n "$GIT_REMOTE_TESTGIT_SIGNED_TAGS" && echo "signed-tags"
 		test -n "$GIT_REMOTE_TESTGIT_NO_PRIVATE_UPDATE" && echo "no-private-update"
+		echo 'option'
 		echo
 		;;
 	list)
@@ -93,6 +95,7 @@ do
 		before=$(git for-each-ref --format=' %(refname) %(objectname) ')
 
 		git fast-import \
+			${forcearg} \
 			${testgitmarks:+"--import-marks=$testgitmarks"} \
 			${testgitmarks:+"--export-marks=$testgitmarks"} \
 			--quiet
@@ -115,6 +118,21 @@ do
 
 		echo
 		;;
+	option\ *)
+		read cmd opt val <<EOF
+${line}
+EOF
+		case ${opt} in
+		    force)
+			case ${val} in
+			    true) forcearg=--force; echo 'ok';;
+			    false) forcearg=; echo 'ok';;
+			    *) printf %s\\n "error '${val}'\
+ is not a valid value for option ${opt}";;
+			esac;;
+		    *) echo "unsupported";;
+		esac
+		;;
 	'')
 		exit
 		;;
-- 
1.8.4.1.614.ga09cf56
