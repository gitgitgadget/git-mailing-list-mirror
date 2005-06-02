From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] git-tar-tree: cleanup write_trailer() (resent)
Date: Thu, 2 Jun 2005 20:50:48 +0200
Message-ID: <20050602185048.GA3726@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 20:49:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dduk1-00043X-P5
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 20:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVFBSv2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 14:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVFBSv1
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 14:51:27 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:16264 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261235AbVFBSut (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2005 14:50:49 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id 9149C54A; Thu,  2 Jun 2005 20:50:48 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

git-tar-tree: replace open-coded variants of get_record().

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

diff --git a/tar-tree.c b/tar-tree.c
--- a/tar-tree.c
+++ b/tar-tree.c
@@ -73,16 +73,13 @@ static char *get_record(void)
  */
 static void write_trailer(void)
 {
-	memset(block + offset, 0, RECORDSIZE);
-	offset += RECORDSIZE;
+	get_record();
 	write_if_needed();
-	memset(block + offset, 0, RECORDSIZE);
-	offset += RECORDSIZE;
+	get_record();
 	write_if_needed();
 	if (offset) {
-		memset(block + offset, 0, BLOCKSIZE - offset);
-		reliable_write(block, BLOCKSIZE);
-		offset = 0;
+		get_record();
+		write_if_needed();
 	}
 }
 
