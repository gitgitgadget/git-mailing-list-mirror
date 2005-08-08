From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 3/4] Plug memory leak in sha1close()
Date: Mon, 8 Aug 2005 22:46:13 +0400
Message-ID: <20050808184613.GD5789@procyon.home>
References: <20050808184332.GA5789@procyon.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 08 20:48:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2CeS-0000Wk-Mk
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 20:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbVHHSrG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 14:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbVHHSrG
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 14:47:06 -0400
Received: from mail.murom.net ([213.177.124.17]:47043 "EHLO ns1.murom.ru")
	by vger.kernel.org with ESMTP id S932191AbVHHSrF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2005 14:47:05 -0400
Received: from [172.17.7.8] (helo=procyon.home)
	by ns1.murom.ru with esmtp (Exim 4.42)
	id 1E2CeO-00087o-Ae; Mon, 08 Aug 2005 22:47:04 +0400
Received: by procyon.home (Postfix, from userid 500)
	id E7DBDE51111; Mon,  8 Aug 2005 22:46:13 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20050808184332.GA5789@procyon.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[PATCH] Plug memory leak in sha1close()

sha1create() and sha1fd() malloc the returned struct sha1file;
sha1close() should free it.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
---

 csum-file.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

2207ae4977cbaa84636487ca24bad9d1116f54e0
diff --git a/csum-file.c b/csum-file.c
--- a/csum-file.c
+++ b/csum-file.c
@@ -45,6 +45,7 @@ int sha1close(struct sha1file *f, unsign
 		sha1flush(f, 20);
 	if (close(f->fd))
 		die("%s: sha1 file error on close (%s)", f->name, strerror(errno));
+	free(f);
 	return 0;
 }
 
