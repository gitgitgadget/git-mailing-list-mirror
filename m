From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Make pull not assume anything about current objects
Date: Sun, 1 May 2005 13:33:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505011327160.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 19:28:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSIEL-0000PD-Iy
	for gcvg-git@gmane.org; Sun, 01 May 2005 19:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262621AbVEARdj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 13:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262628AbVEARdj
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 13:33:39 -0400
Received: from iabervon.org ([66.92.72.58]:19719 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262621AbVEARdh (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2005 13:33:37 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DSIJu-0001UO-00; Sun, 1 May 2005 13:33:30 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Previously, pull assumed that, if you have a commit, you either have or
don't want everything it references. Change this to actually check
locally on everything you want, to be completely sure.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
Index: pull.c
===================================================================
--- 6f0f1d99169f9d90aa44e47d1bcff7b1dd4d8ea0/pull.c  (mode:100644 sha1:86a7b6901fe69a82c12c3470b456982ef52cebd0)
+++ 661b090ca8652d2cfa299b4cac3ffceebdd2b43c/pull.c  (mode:100644 sha1:90d2d41ed2c56580f72f020bc93c3e1b8a3befa5)
@@ -48,8 +48,6 @@
 	if (get_history) {
 		struct commit_list *parents = obj->parents;
 		for (; parents; parents = parents->next) {
-			if (has_sha1_file(parents->item->object.sha1))
-				continue;
 			if (fetch(parents->item->object.sha1)) {
 				/* The server might not have it, and
 				 * we don't mind. 

