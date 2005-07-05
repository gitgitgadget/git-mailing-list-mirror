From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH] Restore expected list order for --merge-order switch
Date: Tue, 05 Jul 2005 11:06:19 +1000
Message-ID: <20050705010619.13581.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Tue Jul 05 03:07:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dpbtg-0003Zu-Ff
	for gcvg-git@gmane.org; Tue, 05 Jul 2005 03:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbVGEBGg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jul 2005 21:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbVGEBGe
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jul 2005 21:06:34 -0400
Received: from 203-173-52-158.dyn.iinet.net.au ([203.173.52.158]:128 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261737AbVGEBGW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2005 21:06:22 -0400
Received: (qmail 13592 invoked by uid 500); 5 Jul 2005 01:06:19 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


A recent change to rev-list altered the order in which start points
are presented to the merge-order sort algorithm. This caused
breaks in the t/t6001 unit tests.

This change restores the order in which start points are presented to the
the merge-order sort algorithm (but leaves the order unchanged from
the immediately preceding behaviour for non --merge-order sorts).

The order in which arguments are presented to the merge-order
sort algorithm is significant, since left-most arguments
are expected to sort last so as to be consistent with
how left-most parents sort.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 rev-list.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

ed4451af196ea31ec0c6c7f663290a9b325482cd
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -482,7 +482,10 @@ int main(int argc, char **argv)
 		commit = get_commit_reference(arg, flags);
 		if (!commit)
 			continue;
-		insert_by_date(&list, commit);
+		if (!merge_order) 
+			insert_by_date(&list, commit);
+		else
+			commit_list_insert(commit, &list);
 	}
 
 	if (!merge_order) {		
------------
