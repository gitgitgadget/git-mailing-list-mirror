From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] cg-diff: Always refresh the cache before diffing
Date: Wed, 27 Apr 2005 01:01:57 +0200
Message-ID: <20050426230157.GC28560@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 00:57:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQYz2-0006jd-Ul
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 00:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbVDZXCC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 19:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVDZXCC
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 19:02:02 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:41956 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261836AbVDZXB6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 19:01:58 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 468186E108E; Wed, 27 Apr 2005 01:01:03 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 0F9E76E0DF8; Wed, 27 Apr 2005 01:01:03 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 8513661FDE; Wed, 27 Apr 2005 01:01:57 +0200 (CEST)
To: pasky@ucw.cz
Mail-Followup-To: pasky@ucw.cz, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Level: 
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Call update-cache --refresh before calling diff-cache so only modified
files are included in the diff.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
commit 580058cf4cbb6c95e5e84480499ca1c635d99376
tree 57a559984564e31e79db28d9ad62b8ea3a55dda1
parent 74f5ad9d566408b4d352570ccde67ece0f2650a7
author Jonas Fonseca <fonseca@diku.dk> 1114555427 +0200
committer Jonas Fonseca <fonseca@diku.dk> 1114555427 +0200

 cg-diff |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

Index: cg-diff
===================================================================
--- 7a6c485bceed70459c1855ab3c4d8ddfdeeb65d1/cg-diff  (mode:100755 sha1:b0c3e7389c06718c789e40b9a4fdce0afcb17917)
+++ 57a559984564e31e79db28d9ad62b8ea3a55dda1/cg-diff  (mode:100755 sha1:aecb9add527a72238f00c0581bf615625fec8663)
@@ -63,12 +63,14 @@
 		export GIT_INDEX_FILE=$(mktemp -t gitdiff.XXXXXX)
 		cp .git/index $GIT_INDEX_FILE
 		read-tree -m $(tree-id "$id1")
-		update-cache --refresh
 		tree=$(tree-id "$id1")
 	else
 		tree=$(tree-id)
 	fi
 
+	# Ensure to only diff modified files
+	update-cache --refresh
+
 	# FIXME: Update ret based on what did we match. And take "$@"
 	# to account after all.
 	ret=


-- 
Jonas Fonseca
