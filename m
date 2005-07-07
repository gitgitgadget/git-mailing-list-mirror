From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH] Remove use of SHOWN flag
Date: Thu, 07 Jul 2005 12:00:24 +1000
Message-ID: <20050707020024.7874.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Thu Jul 07 04:02:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqLi9-00035l-6D
	for gcvg-git@gmane.org; Thu, 07 Jul 2005 04:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbVGGCBZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 22:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbVGGCBZ
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 22:01:25 -0400
Received: from 203-217-64-103.dyn.iinet.net.au ([203.217.64.103]:47746 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262391AbVGGCA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2005 22:00:27 -0400
Received: (qmail 7884 invoked by uid 500); 7 Jul 2005 02:00:24 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Now that duplicates are elided early, there is no need for the
SHOWN flag.

This patch removes the SHOWN flag and its uses from rev-list.c

Signed-off-by: Jon Seymour <jon.seymour@gmail>
---

 rev-list.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

28294b1e139ea3f7c08814e022246e42f9ab9fa3
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -8,7 +8,6 @@
 #define SEEN		(1u << 0)
 #define INTERESTING	(1u << 1)
 #define COUNTED		(1u << 2)
-#define SHOWN		(1u << 3)
 
 static const char rev_list_usage[] =
 	"usage: git-rev-list [OPTION] commit-id <commit-id>\n"
@@ -42,7 +41,6 @@ static int topo_order = 0;
 
 static void show_commit(struct commit *commit)
 {
-	commit->object.flags |= SHOWN;
 	if (show_breaks) {
 		prefix = "| ";
 		if (commit->object.flags & DISCONTINUITY) {
@@ -72,7 +70,7 @@ static int filter_commit(struct commit *
 {
 	if (stop_traversal && (commit->object.flags & BOUNDARY))
 		return STOP;
-	if (commit->object.flags & (UNINTERESTING|SHOWN))
+	if (commit->object.flags & UNINTERESTING)
 		return CONTINUE;
 	if (min_age != -1 && (commit->date > min_age))
 		return CONTINUE;
------------
