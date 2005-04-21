From: Junio C Hamano <junkio@cox.net>
Subject: (rework) [PATCH 3/4] Accept commit in some places when tree is
 needed.
Date: Wed, 20 Apr 2005 17:23:00 -0700
Message-ID: <7vvf6hgeqj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 02:19:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOPPM-00033F-89
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 02:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbVDUAXT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 20:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbVDUAXT
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 20:23:19 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:3269 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261856AbVDUAXH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 20:23:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050421002301.TLEX13104.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 20 Apr 2005 20:23:01 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Updates ls-tree.c to use read_tree_with_tree_or_commit_sha1()
function.  The command can take either tree or commit IDs with
this patch.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 ls-tree.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

ls-tree.c: c063640c114634dc7cf950ce44863dd17ddf83c1
--- a/ls-tree.c
+++ b/ls-tree.c
@@ -24,9 +24,9 @@ static void print_path_prefix(struct pat
 }
 
 static void list_recursive(void *buffer,
-			  unsigned char *type,
-			  unsigned long size,
-			  struct path_prefix *prefix)
+			   const unsigned char *type,
+			   unsigned long size,
+			   struct path_prefix *prefix)
 {
 	struct path_prefix this_prefix;
 	this_prefix.prev = prefix;
@@ -72,12 +72,11 @@ static int list(unsigned char *sha1)
 {
 	void *buffer;
 	unsigned long size;
-	char type[20];
 
-	buffer = read_sha1_file(sha1, type, &size);
+	buffer = read_tree_with_tree_or_commit_sha1(sha1, &size, 0);
 	if (!buffer)
 		die("unable to read sha1 file");
-	list_recursive(buffer, type, size, NULL);
+	list_recursive(buffer, "tree", size, NULL);
 	return 0;
 }

