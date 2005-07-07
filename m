From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 2/2] Fix --topo-order, --max-age interaction issue
Date: Thu, 07 Jul 2005 12:38:47 +1000
Message-ID: <20050707023847.12938.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Thu Jul 07 04:43:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqMMY-0006ed-98
	for gcvg-git@gmane.org; Thu, 07 Jul 2005 04:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbVGGCnU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 22:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbVGGCkc
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 22:40:32 -0400
Received: from 203-217-64-103.dyn.iinet.net.au ([203.217.64.103]:54400 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262145AbVGGCiv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2005 22:38:51 -0400
Received: (qmail 12948 invoked by uid 500); 7 Jul 2005 02:38:47 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Applied the --merge-order, --max-age fix to fix
the --topo-order problem demonstrated by the test
case in the previous patch.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 rev-list.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

8238686fd422959dae50a908b3761aa545be1c4f
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -75,7 +75,7 @@ static int filter_commit(struct commit *
 		return CONTINUE;
 	if (max_age != -1 && (commit->date < max_age)) {
 		stop_traversal=1;
-		return merge_order?CONTINUE:STOP;
+		return (merge_order||topo_order)?CONTINUE:STOP;
 	}
 	if (max_count != -1 && !max_count--)
 		return STOP;
------------
