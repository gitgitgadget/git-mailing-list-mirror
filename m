From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Better error message from git-ssh-push
Date: Mon, 4 Jul 2005 16:12:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0507041609550.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 04 22:16:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpXMg-00087q-U9
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 22:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVGDUPo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jul 2005 16:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbVGDUPm
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jul 2005 16:15:42 -0400
Received: from iabervon.org ([66.92.72.58]:9989 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261644AbVGDUNy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jul 2005 16:13:54 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DpXIT-0003lW-00; Mon, 4 Jul 2005 16:12:05 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

If git-ssh-push can't interpret the commit-id, there are various possible
issues. Just giving the usage message makes it hard to identify what could
be wrong.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

---
commit 7a274ce1f93e6092dcf226d546a58d2d6df9d13c
tree 1f045fa8aa017cabbac613cf8c1ea2bd63ccc46c
parent 8934c88118c900fe38abbf60f893ee9ef4e83b3c
author Daniel Barkalow <barkalow@iabervon.org> 1120507167 -0400
committer Daniel Barkalow <barkalow@silva-tulga.(none)> 1120507167 -0400

Index: ssh-push.c
===================================================================
--- 62a74516551505e5fd2b5c2fd14486f3ac8a400e/ssh-push.c  (mode:100644 sha1:10390948efacfa06f4f6fc6b2f3631cec6fcb876)
+++ 1f045fa8aa017cabbac613cf8c1ea2bd63ccc46c/ssh-push.c  (mode:100644 sha1:6b1406b527ba6ede8602a04ab031003edb7da2b0)
@@ -257,8 +257,12 @@
 		usage(ssh_push_usage);
 	commit_id = argv[arg];
 	url = argv[arg + 1];
-	if (get_sha1(commit_id, sha1))
-		usage(ssh_push_usage);
+	if (get_sha1(commit_id, sha1)) {
+		fprintf(stderr, 
+			"Unable to interpret %s as something to push.\n",
+			commit_id);
+		return 1;
+	}
 	memcpy(hex, sha1_to_hex(sha1), sizeof(hex));
 	argv[arg] = hex;
 
