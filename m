From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH] Fix git-add argument parsing
Date: Wed, 28 Sep 2005 17:27:53 +0300
Message-ID: <20050928172753.0e883738.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 28 16:31:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKcun-0002cQ-PO
	for gcvg-git@gmane.org; Wed, 28 Sep 2005 16:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbVI1O2H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Sep 2005 10:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbVI1O2G
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Sep 2005 10:28:06 -0400
Received: from marski.suomi.net ([212.50.131.142]:63430 "EHLO marski.suomi.net")
	by vger.kernel.org with ESMTP id S1751318AbVI1O2F (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Sep 2005 10:28:05 -0400
Received: from spam1.suomi.net (spam1.suomi.net [212.50.131.165])
 by marski.suomi.net (Sun Java System Messaging Server 6.2 (built Dec  2 2004))
 with ESMTP id <0INJ004536UNJ260@marski.suomi.net> for git@vger.kernel.org;
 Wed, 28 Sep 2005 17:27:59 +0300 (EEST)
Received: from garlic.home.net (addr-213-216-219-96.suomi.net [213.216.219.96])
	by spam1.suomi.net (Postfix) with SMTP id 541CE1AA2B4; Wed,
 28 Sep 2005 17:27:54 +0300 (EEST)
To: junkio@cox.net
X-Mailer: Sylpheed version 2.0.1 (GTK+ 2.8.3; i686-pc-linux-gnu)
X-OPOY-MailScanner-Information: Please contact the OPOY for more information
X-OPOY-MailScanner: Not virus scanned: please contact OPOY for details
X-OPOY-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.553,	required 5,
 autolearn=not spam, AWL 2.35, BAYES_00 -4.90)
X-MailScanner-From: tihirvon@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9429>

Complain if no arguments given instead of adding all files
to the index.

Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>

---

 git-add.sh |   44 ++++++++++++++++++++++++++++++--------------
 1 files changed, 30 insertions(+), 14 deletions(-)

60d2803555831a9a9bfa2d97cec5ab2fbed1fb2c
diff --git a/git-add.sh b/git-add.sh
--- a/git-add.sh
+++ b/git-add.sh
@@ -1,23 +1,39 @@
 #!/bin/sh
 
+usage()
+{
+	echo "usage: git add [-n] [-v] <file>..."
+	exit 1
+}
+
 show_only=
 verbose=
-while : ; do
-  case "$1" in
-    -n)
-	show_only=true
-	verbose=true
-	;;
-    -v)
-	verbose=true
-	;;
-    *)
-	break
-	;;
-  esac
-  shift
+while test $# -gt 0
+do
+	case "$1" in
+	-n)
+		show_only=true
+		verbose=true
+		;;
+	-v)
+		verbose=true
+		;;
+	--)
+		shift
+		break
+		;;
+	-*)
+		usage
+		;;
+	*)
+		break
+		;;
+	esac
+	shift
 done
 
+test $# -eq 0 && usage
+
 GIT_DIR=$(git-rev-parse --git-dir) || exit
 global_exclude=
 if [ -f "$GIT_DIR/info/exclude" ]; then
