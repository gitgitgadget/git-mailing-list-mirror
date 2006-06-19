From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Initialize lock_file struct to all zero.
Date: Tue, 20 Jun 2006 00:55:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606200054290.26329@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Jun 20 00:55:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsSeS-0005sB-La
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 00:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbWFSWzW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 18:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbWFSWzW
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 18:55:22 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:32183 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964966AbWFSWzV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jun 2006 18:55:21 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id C85B11D7D;
	Tue, 20 Jun 2006 00:55:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id BB5C72060;
	Tue, 20 Jun 2006 00:55:20 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id A5FD71FAE;
	Tue, 20 Jun 2006 00:55:20 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22143>


hold_lock_file_for_update() relies on that.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	Bugs like this drive you crazy. You make a little change elsewhere,
	and all of a sudden, a test of git-update-index fails (since the 
	lock file is never removed).

 builtin-update-index.c |    2 +-
 builtin-write-tree.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-update-index.c b/builtin-update-index.c
index 325cd09..829ed23 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -490,7 +490,7 @@ int cmd_update_index(int argc, const cha
 	git_config(git_default_config);
 
 	/* We can't free this memory, it becomes part of a linked list parsed atexit() */
-	lock_file = xmalloc(sizeof(struct lock_file));
+	lock_file = xcalloc(1, sizeof(struct lock_file));
 
 	newfd = hold_lock_file_for_update(lock_file, get_index_file());
 	if (newfd < 0)
diff --git a/builtin-write-tree.c b/builtin-write-tree.c
index c3aac36..8c151da 100644
--- a/builtin-write-tree.c
+++ b/builtin-write-tree.c
@@ -16,7 +16,7 @@ int write_tree(unsigned char *sha1, int 
 	int entries, was_valid, newfd;
 
 	/* We can't free this memory, it becomes part of a linked list parsed atexit() */
-	struct lock_file *lock_file = xmalloc(sizeof(struct lock_file));
+	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
 
 	newfd = hold_lock_file_for_update(lock_file, get_index_file());
 
-- 
1.4.0.g9833
