From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] cg-mkpatch: use git-apply --stat
Date: Mon, 30 May 2005 22:34:37 +0200
Message-ID: <20050530203437.GA13961@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 22:33:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dcqvf-0003RJ-DP
	for gcvg-git@gmane.org; Mon, 30 May 2005 22:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVE3Uem (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 16:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbVE3Uem
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 16:34:42 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:34032 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261736AbVE3Uej (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2005 16:34:39 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 623F06E0B59; Mon, 30 May 2005 22:34:05 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 2D5DF6E016C; Mon, 30 May 2005 22:34:05 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 1E3C261FE0; Mon, 30 May 2005 22:34:38 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Change cg-mkpatch to use git-apply --stat instead of optional diffstat.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

 cg-mkpatch |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/cg-mkpatch b/cg-mkpatch
--- a/cg-mkpatch
+++ b/cg-mkpatch
@@ -42,7 +42,6 @@ USAGE="cg-mkpatch [-s] [-r REVISION[:REV
 . ${COGITO_LIB}cg-Xlib
 
 omit_header=
-has_diffstat=
 log_start=
 log_end=
 mergebase=
@@ -71,11 +70,8 @@ showpatch () {
 
 				echo commit $id
 				cat $header
-
-				if [ "$has_diffstat" ]; then
-					echo
-					cat $patch | diffstat -p1
-				fi
+				echo
+				cat $patch | git-apply --stat
 			fi
 			;;
 		*)
@@ -116,10 +112,6 @@ while [ "$1" ]; do
 	shift
 done
 
-if ! [ "$omit_header" ]; then
-	which diffstat >/dev/null 2>&1 && has_diffstat=1
-fi
-
 if [ "$mergebase" ]; then
 	[ "$log_start" ] || log_start="origin"
 	[ "$log_end" ] || log_end="master"
-- 
Jonas Fonseca
