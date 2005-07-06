From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 1/6] Temporary fixup to rev-list.c to restore expected order of arguments presented to --merge-order sort.
Date: Wed, 06 Jul 2005 17:51:12 +1000
Message-ID: <20050706075112.3951.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Wed Jul 06 10:00:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dq4pS-0005LP-Vf
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 10:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbVGFH7x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 03:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbVGFH7w
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 03:59:52 -0400
Received: from 203-217-64-103.dyn.iinet.net.au ([203.217.64.103]:22659 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262164AbVGFHvU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2005 03:51:20 -0400
Received: (qmail 3962 invoked by uid 500); 6 Jul 2005 07:51:12 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This patch adds a hacky special case to the rev-list main to restore the order in which
the --merge-order sort algorithm receives arguments.

A subsequent patch will abstract this out more cleanly.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 rev-list.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

c63fe4678d33db15db076606f7a133868e91f1bc
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
