From: Eric Lesh <eclesh@ucla.edu>
Subject: [GUILT PATCH] guilt-help: Make guilt-cmd --help show the right man page
Date: Sun, 29 Jul 2007 19:11:18 -0700
Message-ID: <87y7gyd4jd.fsf@hubert.paunchy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>
To: Josef Sipek <jsipek@cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Mon Jul 30 04:11:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFKjc-0006xI-Jn
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 04:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbXG3CLf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 22:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765730AbXG3CLf
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 22:11:35 -0400
Received: from smtp-1.smtp.ucla.edu ([169.232.46.136]:36591 "EHLO
	smtp-1.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764282AbXG3CLe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 22:11:34 -0400
Received: from mail.ucla.edu (mail.ucla.edu [169.232.46.157])
	by smtp-1.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l6U2BOZN027816;
	Sun, 29 Jul 2007 19:11:24 -0700
Received: from localhost (adsl-75-26-192-134.dsl.scrm01.sbcglobal.net [75.26.192.134])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l6U2BOh5002030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 29 Jul 2007 19:11:24 -0700
Received: by localhost (Postfix, from userid 1000)
	id EDEC71E80A8; Sun, 29 Jul 2007 19:11:18 -0700 (PDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.0 (gnu/linux)
X-Probable-Spam: no
X-Spam-Report: none
X-Scanned-By: smtp.ucla.edu on 169.232.46.136
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54168>


Signed-off-by: Eric Lesh <eclesh@ucla.edu>
---
 guilt      |    8 +++++++-
 guilt-help |    3 ++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/guilt b/guilt
index f67bfb5..6a69261 100755
--- a/guilt
+++ b/guilt
@@ -11,7 +11,13 @@ GUILT_NAME="Los"
 case $1 in
 	-h|--h|--he|--hel|--help)
 	shift
-	exec "guilt-help" "$@"
+        if [ -z "$@" ]; then
+		# guilt-cmd --help or guilt cmd --help
+		exec "guilt-help" `basename $0`
+	else
+		# guilt --help cmd
+		exec "guilt-help" "$@"
+	fi
 	exit
 	;;
 	-V|--ver|--versi|--versio|--version)
diff --git a/guilt-help b/guilt-help
index 274246b..e2340d9 100755
--- a/guilt-help
+++ b/guilt-help
@@ -14,7 +14,8 @@ case $# in
 		;;
 	1)
 		if [ "$1" != "guilt" ]; then
-			page="guilt-$1"
+			cmd=$(echo "$1" | sed -e 's/guilt-//')
+			page="guilt-$cmd"
 		else
 			page="guilt"
 		fi
-- 
1.5.2
