From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 7/10] Remove unused "zeropad" entry from tree_list_entry
Date: Mon, 29 May 2006 12:19:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605291219120.5623@g5.osdl.org>
References: <Pine.LNX.4.64.0605291145360.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon May 29 21:20:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FknHc-0000ir-HS
	for gcvg-git@gmane.org; Mon, 29 May 2006 21:20:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWE2TUF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 15:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWE2TUE
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 15:20:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64217 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751227AbWE2TUC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 15:20:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4TJJe2g015139
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 29 May 2006 12:19:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4TJJcBc015560;
	Mon, 29 May 2006 12:19:38 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605291145360.5623@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20962>


That was a hack, only needed because 'git fsck-objects' didn't look at
the raw tree format.  Now that fsck traverses the tree itself, we can
drop it.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
 tree.c |    3 +--
 tree.h |    1 -
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/tree.c b/tree.c
index db6e59f..47318ef 100644
--- a/tree.c
+++ b/tree.c
@@ -217,6 +217,7 @@ struct tree_entry_list *create_tree_entr
 		struct tree_entry_list *entry;
 
 		sha1 = tree_entry_extract(&desc, &path, &mode);
+		update_tree_entry(&desc);
 
 		entry = xmalloc(sizeof(struct tree_entry_list));
 		entry->name = path;
@@ -225,10 +226,8 @@ struct tree_entry_list *create_tree_entr
 		entry->directory = S_ISDIR(mode) != 0;
 		entry->executable = (mode & S_IXUSR) != 0;
 		entry->symlink = S_ISLNK(mode) != 0;
-		entry->zeropad = *(const char *)(desc.buf) == '0';
 		entry->next = NULL;
 
-		update_tree_entry(&desc);
 		*list_p = entry;
 		list_p = &entry->next;
 	}
diff --git a/tree.h b/tree.h
index c7b5248..6a87546 100644
--- a/tree.h
+++ b/tree.h
@@ -10,7 +10,6 @@ struct tree_entry_list {
 	unsigned directory : 1;
 	unsigned executable : 1;
 	unsigned symlink : 1;
-	unsigned zeropad : 1;
 	unsigned int mode;
 	const char *name;
 	const unsigned char *sha1;
-- 
1.3.3.gcd01d
