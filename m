From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 4/8] fetch.c: Remove redundant TO_FETCH flag
Date: Wed, 21 Sep 2005 20:19:01 +0400 (MSD)
Message-ID: <20050921161901.A512FE010FC@center4.mivlgu.local>
References: <20050921161829.GA20944@master.mivlgu.local>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 18:22:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EI7JN-0006Bd-B2
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 18:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbVIUQTE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 12:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbVIUQTE
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 12:19:04 -0400
Received: from mivlgu.ru ([81.18.140.87]:2182 "EHLO center4.mivlgu.local")
	by vger.kernel.org with ESMTP id S1751121AbVIUQTC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 12:19:02 -0400
Received: by center4.mivlgu.local (Postfix, from userid 500)
	id A512FE010FC; Wed, 21 Sep 2005 20:19:01 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20050921161829.GA20944@master.mivlgu.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9054>

The TO_FETCH flag also became redundant after adding the SEEN flag -
it was set and checked in process() to prevent adding the same object
to process_queue multiple times, but now SEEN guards against this.

---

 fetch.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

92ef6ee593199b80e01ebe93a48c03508941a340
diff --git a/fetch.c b/fetch.c
--- a/fetch.c
+++ b/fetch.c
@@ -55,7 +55,6 @@ static int process_tree(struct tree *tre
 }
 
 #define COMPLETE	1U
-#define TO_FETCH	2U
 #define TO_SCAN		4U
 #define SEEN		16U
 
@@ -144,11 +143,10 @@ static int process(struct object *obj)
 		obj->flags |= TO_SCAN;
 		return 0;
 	}
-	if (obj->flags & (COMPLETE | TO_FETCH))
+	if (obj->flags & COMPLETE)
 		return 0;
 	object_list_insert(obj, process_queue_end);
 	process_queue_end = &(*process_queue_end)->next;
-	obj->flags |= TO_FETCH;
 
 	prefetch(obj->sha1);
 		
