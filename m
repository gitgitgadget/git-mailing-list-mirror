From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] git-fsck-cache: Gracefully handle non-commit IDs
Date: Sat, 30 Apr 2005 02:28:09 +0200
Message-ID: <20050430002809.GB32339@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 02:23:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRflT-0003zD-AJ
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 02:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263086AbVD3A20 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 20:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263090AbVD3A20
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 20:28:26 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:8187 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S263086AbVD3A2N (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 20:28:13 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 8A7F36E2D7A; Sat, 30 Apr 2005 02:27:11 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 544646E2D76; Sat, 30 Apr 2005 02:27:11 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id B89CB61FDE; Sat, 30 Apr 2005 02:28:09 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org
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

Gracefully handle non-commit IDs instead of segfaulting.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

--- 09465be469eef9711e93b583f4cd1092baa58f90/fsck-cache.c  (mode:100644 sha1:280a104050b665515418c00c33af8e6b0b0e2101)
+++ uncommitted/fsck-cache.c  (mode:100644)
@@ -174,7 +216,14 @@
 			continue;
 
 		if (!get_sha1_hex(arg, head_sha1)) {
-			struct object *obj = &lookup_commit(head_sha1)->object;
+			struct commit *commit = lookup_commit(head_sha1);
+			struct object *obj;
+
+			/* Error is printed by lookup_commit(). */
+			if (!commit)
+				continue;
+
+			obj = &commit->object;
 			obj->used = 1;
 			mark_reachable(obj, REACHABLE);
 			heads++;
-- 
Jonas Fonseca
