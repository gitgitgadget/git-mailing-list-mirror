From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 1/4] Plug memory leak in read_object_with_reference()
Date: Mon, 8 Aug 2005 22:44:43 +0400
Message-ID: <20050808184443.GB5789@procyon.home>
References: <20050808184332.GA5789@procyon.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 08 20:47:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2Ccz-0000GK-HQ
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 20:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbVHHSpf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 14:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbVHHSpf
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 14:45:35 -0400
Received: from mail.murom.net ([213.177.124.17]:43459 "EHLO ns1.murom.ru")
	by vger.kernel.org with ESMTP id S932188AbVHHSpe (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2005 14:45:34 -0400
Received: from [172.17.7.8] (helo=procyon.home)
	by ns1.murom.ru with esmtp (Exim 4.42)
	id 1E2Ccv-0007vm-Md; Mon, 08 Aug 2005 22:45:33 +0400
Received: by procyon.home (Postfix, from userid 500)
	id 5769EE51111; Mon,  8 Aug 2005 22:44:43 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20050808184332.GA5789@procyon.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[PATCH] Plug memory leak in read_object_with_reference()

When following a reference, read_object_with_reference() did not free the
intermediate object data.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
---

 sha1_file.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

f7d16d6b83698fd7858ad28340b3e87780322261
diff --git a/sha1_file.c b/sha1_file.c
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1165,6 +1165,7 @@ void *read_object_with_reference(const u
 			free(buffer);
 			return NULL;
 		}
+		free(buffer);
 		/* Now we have the ID of the referred-to object in
 		 * actual_sha1.  Check again. */
 	}
