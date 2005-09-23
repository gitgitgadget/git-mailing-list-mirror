From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 2/6] fetch.c: Plug memory leak in process_tree()
Date: Fri, 23 Sep 2005 16:28:18 +0400 (MSD)
Message-ID: <20050923122818.39DFFE01C96@center4.mivlgu.local>
References: <20050923122754.GB2197@master.mivlgu.local>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 14:29:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EImf8-00077W-64
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 14:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbVIWM2U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 08:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbVIWM2U
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 08:28:20 -0400
Received: from mivlgu.ru ([81.18.140.87]:13776 "EHLO center4.mivlgu.local")
	by vger.kernel.org with ESMTP id S1750929AbVIWM2T (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2005 08:28:19 -0400
Received: by center4.mivlgu.local (Postfix, from userid 500)
	id 39DFFE01C96; Fri, 23 Sep 2005 16:28:18 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20050923122754.GB2197@master.mivlgu.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9182>

When freeing a tree entry, must free its name too.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>


---

 fetch.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

33e5d08bcd7c35725f704cb70ffcc7257df61bcb
diff --git a/fetch.c b/fetch.c
--- a/fetch.c
+++ b/fetch.c
@@ -48,6 +48,7 @@ static int process_tree(struct tree *tre
 		struct tree_entry_list *next = entry->next;
 		if (process(entry->item.any))
 			return -1;
+		free(entry->name);
 		free(entry);
 		entry = next;
 	}
