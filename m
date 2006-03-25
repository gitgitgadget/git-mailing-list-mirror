From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Do not print header in diff-tree --root unless asked to
Date: Sun, 26 Mar 2006 00:28:07 +0100
Message-ID: <20060325232807.9146.12846.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 26 00:28:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNIBN-0004eI-Rk
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 00:28:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968AbWCYX2A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 18:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969AbWCYX2A
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 18:28:00 -0500
Received: from w241.dkm.cz ([62.24.88.241]:4559 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751968AbWCYX17 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Mar 2006 18:27:59 -0500
Received: (qmail 9165 invoked from network); 26 Mar 2006 00:28:07 +0100
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 26 Mar 2006 00:28:07 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18006>

Currently cg-log -f is broken (shows sha1 in files list for the initial
commit) since git-diff-tree would always return the sha1 of the commit
when --root was passed. I assume it should do this only when -v was also
passed; I'm certain that I don't want it when processing the output.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 diff-tree.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/diff-tree.c b/diff-tree.c
index f55a35a..8d82b5b 100644
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -107,7 +107,8 @@ static int diff_tree_commit(struct commi
 
 	/* Root commit? */
 	if (show_root_diff && !commit->parents) {
-		header = generate_header(sha1, NULL, commit);
+		if (verbose_header)
+			header = generate_header(sha1, NULL, commit);
 		diff_root_tree(sha1, "");
 	}
 
