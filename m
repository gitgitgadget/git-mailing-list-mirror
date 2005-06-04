From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH 1/10] Cleanup conversion to human readable date
Date: Sat, 4 Jun 2005 16:39:06 +0200
Message-ID: <20050604143906.GE12615@diku.dk>
References: <20050604143831.GD12615@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 16:36:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeZkh-0005Mx-A5
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 16:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVFDOjN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Jun 2005 10:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVFDOjN
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jun 2005 10:39:13 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:62206 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261351AbVFDOjH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Jun 2005 10:39:07 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 64E2A6E1DC1; Sat,  4 Jun 2005 16:38:26 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 2C54F6E19BA; Sat,  4 Jun 2005 16:38:26 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 491DD61FE0; Sat,  4 Jun 2005 16:39:06 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050604143831.GD12615@diku.dk>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Simplify the date substitution to reduce code duplication.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

 cg-log     |    8 ++------
 cg-mkpatch |    7 ++-----
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/cg-log b/cg-log
--- a/cg-log
+++ b/cg-log
@@ -188,12 +188,8 @@ $revls | $revsort | while read time comm
 
 				date=(${rest#*> })
 				pdate="$(showdate $date)"
-				if [ "$pdate" ]; then
-					echo -n $color$key $rest | sed "s/>.*/> $pdate/"
-					echo $coldefault
-				else
-					echo $color$key $rest $coldefault
-				fi
+				[ "$pdate" ] && rest="${rest%> *}> $pdate"
+				echo $color$key $rest $coldefault
 				;;
 			"tree"|"parent")
 				if [ -z $tree1 ]; then
diff --git a/cg-mkpatch b/cg-mkpatch
--- a/cg-mkpatch
+++ b/cg-mkpatch
@@ -53,11 +53,8 @@ showpatch () {
 		"author"|"committer")
 			date=(${rest#*> })
 			pdate="$(showdate $date)"
-			if [ "$pdate" ]; then
-				echo $key $rest | sed "s/>.*/> $pdate/" >>$header
-			else
-				echo $key $rest >>$header
-			fi
+			[ "$pdate" ] && rest="${rest%> *}> $pdate"
+			echo $key $rest >>$header
 			;;
 		"")
 			cat

-- 
Jonas Fonseca
