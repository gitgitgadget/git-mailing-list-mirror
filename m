From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH maint] builtin-merge.c: fix memory under-allocation
Date: Wed, 08 Oct 2008 19:07:54 -0500
Message-ID: <ZuhLzndR5Uvj7-_NyasP-FHF3AqTyLx-0sjNHMd0BC3LXC8LdLqBeQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 09 02:11:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Knj5a-0005T8-85
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 02:09:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754899AbYJIAH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 20:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754142AbYJIAH6
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 20:07:58 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:44507 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbYJIAH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 20:07:57 -0400
Received: by mail.nrlssc.navy.mil id m9907txO031086; Wed, 8 Oct 2008 19:07:55 -0500
X-OriginalArrivalTime: 09 Oct 2008 00:07:55.0171 (UTC) FILETIME=[142D9730:01C929A3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97812>

While we're at it, change the allocation to reference the variable it is
allocating memory for to try to prevent a similar mistake if the type is
changed in the future.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


This causes segfault on IRIX64. I guess the irix compiler doesn't
over-allocate memory as aggressively as gcc.

-brandon


 builtin-merge.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index dcaf368..d0bf1fc 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -651,12 +651,12 @@ static void add_strategies(const char *string, unsigned attr)
 static int merge_trivial(void)
 {
 	unsigned char result_tree[20], result_commit[20];
-	struct commit_list *parent = xmalloc(sizeof(struct commit_list *));
+	struct commit_list *parent = xmalloc(sizeof(*parent));
 
 	write_tree_trivial(result_tree);
 	printf("Wonderful.\n");
 	parent->item = lookup_commit(head);
-	parent->next = xmalloc(sizeof(struct commit_list *));
+	parent->next = xmalloc(sizeof(*parent->next));
 	parent->next->item = remoteheads->item;
 	parent->next->next = NULL;
 	commit_tree(merge_msg.buf, result_tree, parent, result_commit);
-- 
1.6.0.2.446.ge243d
