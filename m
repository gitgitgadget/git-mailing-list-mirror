From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 3/7] Fixes problem with --merge-order head ^head
Date: Mon, 20 Jun 2005 12:29:31 +1000
Message-ID: <20050620022931.28578.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com, paulus@samba.org
X-From: git-owner@vger.kernel.org Mon Jun 20 04:25:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkBye-0006rc-BR
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 04:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbVFTCbK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 22:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVFTCbJ
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 22:31:09 -0400
Received: from 203-166-247-224.dyn.iinet.net.au ([203.166.247.224]:6272 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261402AbVFTC3d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2005 22:29:33 -0400
Received: (qmail 28588 invoked by uid 500); 20 Jun 2005 02:29:31 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


git-rev-list --merge-order HEAD ^HEAD was faulting rather than generating an empty output.

This patch fixes that problem.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 epoch.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/epoch.c b/epoch.c
--- a/epoch.c
+++ b/epoch.c
@@ -606,7 +606,9 @@ int sort_list_in_merge_order(struct comm
 		}
 	}
 
-	if (!reversed->next) {
+	if (!reversed)
+		return ret;
+	else if (!reversed->next) {
 		/*
 		 * If there is only one element in the list, we can sort it
 		 * using sort_in_merge_order.
------------
