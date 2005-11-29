From: Jan Andres <jandres@gmx.net>
Subject: [PATCH] Fix typo in http-push.c, take two
Date: Tue, 29 Nov 2005 16:30:46 +0100
Message-ID: <20051129153046.GA9091@pitr.home.jan>
References: <20051129005154.GA3076@pitr.home.jan> <Pine.LNX.4.63.0511290923390.16927@wbgn013.biozentrum.uni-wuerzburg.de> <20051129133537.GA490@pitr.home.jan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Nov 29 17:35:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eh8HC-0007US-44
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 17:24:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbVK2QYP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 11:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbVK2QYP
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 11:24:15 -0500
Received: from mail.gmx.de ([213.165.64.20]:63895 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751399AbVK2QYP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2005 11:24:15 -0500
Received: (qmail invoked by alias); 29 Nov 2005 16:24:12 -0000
Received: from e176049225.adsl.alicedsl.de (EHLO pitr.home.jan) [85.176.49.225]
  by mail.gmx.net (mp013) with SMTP; 29 Nov 2005 17:24:12 +0100
X-Authenticated: #11648398
Received: by pitr.home.jan (Postfix, from userid 500)
	id D59DB2135FE; Tue, 29 Nov 2005 16:30:46 +0100 (MET)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20051129133537.GA490@pitr.home.jan>
User-Agent: Mutt/1.4.2.1i
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12946>

Ok, so this is my final(?) proposal for the fix.

---

Fix a bug in handle_new_lock_ctx()'s memory allocation which may cause
segfaults.

Signed-off-by: Jan Andres <jandres@gmx.net>

---

diff --git a/http-push.c b/http-push.c
index 76c7886..bbb5118 100644
--- a/http-push.c
+++ b/http-push.c
@@ -784,7 +784,8 @@ static void handle_new_lock_ctx(struct x
 					strtol(ctx->cdata + 7, NULL, 10);
 		} else if (!strcmp(ctx->name, DAV_ACTIVELOCK_TOKEN)) {
 			if (!strncmp(ctx->cdata, "opaquelocktoken:", 16)) {
-				lock->token = xmalloc(strlen(ctx->cdata - 15));
+				lock->token =
+					xmalloc(strlen(ctx->cdata + 16) + 1);
 				strcpy(lock->token, ctx->cdata + 16);
 			}
 		}
---
0.99.9.GIT

-- 
Jan Andres <jandres@gmx.net>
