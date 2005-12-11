From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] cg-status: handle subdirs when listing heads
Date: Sun, 11 Dec 2005 20:49:26 +0100
Message-ID: <20051211194926.GG2960@diku.dk>
References: <20051211190305.GD2960@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Dec 11 20:51:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElXCO-0003xS-Pl
	for gcvg-git@gmane.org; Sun, 11 Dec 2005 20:49:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbVLKTt3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Dec 2005 14:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbVLKTt2
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Dec 2005 14:49:28 -0500
Received: from nhugin.diku.dk ([130.225.96.140]:55290 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S1750848AbVLKTt1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Dec 2005 14:49:27 -0500
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 7E6716DFC1C; Sun, 11 Dec 2005 20:48:27 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 482916DFB78; Sun, 11 Dec 2005 20:48:27 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id B77CD615B4; Sun, 11 Dec 2005 20:49:26 +0100 (CET)
To: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20051211190305.GD2960@diku.dk>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13507>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---

 And here's one which handles empty directories and is cleaner.

diff --git a/cg-status b/cg-status
index a4c5e7a..bd4d0ce 100755
--- a/cg-status
+++ b/cg-status
@@ -123,9 +123,9 @@ if [ "$gitstatus" ]; then
 	fi
 
 	echo "Heads:"
-	for head in $_git/refs/heads/*; do
+	find "$_git/refs/heads" ! -type d | sort | while read head; do 
 		headsha1=$(cat "$head")
-		headname=$(basename "$head")
+		headname=${head#$_git/refs/heads/}
 		[ "$headname" = "cg-seek-point" ] && continue
 		cf=" "; rf=" "
 		[ "$headname" = "$_git_head" ] && cf=">"

-- 
Jonas Fonseca
