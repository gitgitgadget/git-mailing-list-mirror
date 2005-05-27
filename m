From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] git-tar-tree: cleanup trailer writing
Date: Fri, 27 May 2005 23:16:24 +0200
Message-ID: <20050527211624.GA17478@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 23:14:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbmA5-00009u-UC
	for gcvg-git@gmane.org; Fri, 27 May 2005 23:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbVE0VQe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 17:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262597AbVE0VQe
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 17:16:34 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:29601 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S262596AbVE0VQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 17:16:26 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id E072539F; Fri, 27 May 2005 23:16:24 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Replace open-coded variants of get_record().

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

Index: tar-tree.c
===================================================================
--- ba1de5878d8e0cd1c7c728379e033ea6bf8567e5/tar-tree.c  (mode:100644)
+++ fa5c736eeabbead4a4c024051d104930d836092a/tar-tree.c  (mode:100644)
@@ -73,16 +73,13 @@
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
-	if (offset) {
-		memset(block + offset, 0, BLOCKSIZE - offset);
-		reliable_write(block, BLOCKSIZE);
-		offset = 0;
+	while (offset) {
+		get_record();
+		write_if_needed();
 	}
 }
 
