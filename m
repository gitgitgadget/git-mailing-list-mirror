From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] cg-log: make -r id:id show the given id instead of nothing
Date: Fri, 20 May 2005 17:04:00 +0200
Message-ID: <20050520150400.GC27395@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 17:05:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZ91z-0006Cz-DT
	for gcvg-git@gmane.org; Fri, 20 May 2005 17:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVETPEK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 11:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVETPEK
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 11:04:10 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:44255 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261462AbVETPEC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 11:04:02 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 2EC796DFFB2; Fri, 20 May 2005 17:03:44 +0200 (CEST)
Received: from brok.diku.dk (brok.diku.dk [130.225.96.163])
	by nhugin.diku.dk (Postfix) with ESMTP
	id BD2746E2261; Fri, 20 May 2005 17:03:42 +0200 (CEST)
Received: by brok.diku.dk (Postfix, from userid 3873)
	id 7246461DDD; Fri, 20 May 2005 17:04:00 +0200 (CEST)
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

If cg-log is passed -r cogito-0.10 -r cogito-0.10 no log entries are
shown. This patch make it show the log for the given ID.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

Index: cg-log
===================================================================
--- ca5fef50fb68a3afbb35e1a48ac622f7a964f021/cg-log  (mode:100755)
+++ uncommitted/cg-log  (mode:100755)
@@ -113,6 +113,9 @@
 if [ "$log_end" ]; then
 	id1="$(commit-id $log_start)" || exit 1
 	id2="$(commit-id $log_end)" || exit 1
+	if [ "$id1" = "$id2" ]; then
+		id1=$(git-cat-file commit $id1 | sed -n '/^parent /,0s/parent //p')
+	fi
 	revls="git-rev-tree $id2 ^$id1"
 	revsort="sort -rn"
 	revfmt="git-rev-tree"
-- 
Jonas Fonseca
