From: Mike Ralphson <mike@abacus.co.uk>
Subject: [JGIT PATCH] Allow make_jgit.sh compilation under Cygwin or Mingw (MsysGit) with Windows JDK
Date: Thu, 21 Aug 2008 10:33:11 +0100
Message-ID: <1219311191-10984-1-git-send-email-mike@abacus.co.uk>
Cc: git@vger.kernel.org, Mike Ralphson <mike.ralphson@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 21 11:27:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW6RO-0007NL-Pk
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 11:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbYHUJZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 05:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbYHUJZr
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 05:25:47 -0400
Received: from [82.109.193.99] ([82.109.193.99]:49334 "EHLO orson.abacus.co.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751364AbYHUJZq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 05:25:46 -0400
Received: by orson.abacus.co.uk (Postfix, from userid 1006)
	id E70DF1BD26D; Thu, 21 Aug 2008 10:33:11 +0100 (BST)
X-Mailer: git-send-email 1.5.5.1.1.g75d5.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93129>

Signed-off-by: Mike Ralphson <mike@abacus.co.uk>
---
 make_jgit.sh |   24 +++++++++++++++++-------
 1 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/make_jgit.sh b/make_jgit.sh
index 13d0e32..c119202 100755
--- a/make_jgit.sh
+++ b/make_jgit.sh
@@ -10,14 +10,24 @@ JARS="
 	org.spearce.jgit.pgm/lib/args4j-2.0.9.jar
 "
 
-if [ -n "$JAVA_HOME" ]
-then
-	PATH=$JAVA_HOME/bin:$PATH
-fi
-
+PSEP=":"
 T=".temp$$.$O"
 T_MF="$T.MF"
 R=`pwd`
+if [ "$OSTYPE" = "cygwin" ]
+then
+	R=`cygpath -m $R`
+	PSEP=";"
+fi
+if [ "$MSYSTEM" = "MINGW" ]
+then
+	PSEP=";"
+fi
+
+if [ -n "$JAVA_HOME" ]
+then
+	PATH=${JAVA_HOME}/bin${PSEP}${PATH}
+fi
 
 cleanup_bin() {
 	rm -f $T $O+ $T_MF
@@ -44,7 +54,7 @@ do
 	then
 		CLASSPATH="$R/$j"
 	else
-		CLASSPATH="$CLASSPATH:$R/$j"
+		CLASSPATH="${CLASSPATH}${PSEP}$R/$j"
 	fi
 done
 export CLASSPATH
@@ -61,7 +71,7 @@ do
 		-encoding UTF-8 \
 		-g \
 		-d ../bin2) || die "Building $p failed."
-	CLASSPATH="$CLASSPATH:$R/$p/bin2"
+	CLASSPATH="${CLASSPATH}${PSEP}$R/$p/bin2"
 done
 
 echo Manifest-Version: 1.0 >$T_MF &&
-- 
1.5.6.4
