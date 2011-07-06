From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 1/3] xdiff/xprepare: use memset
Date: Wed,  6 Jul 2011 14:15:43 +0800
Message-ID: <1309932945-5048-2-git-send-email-rctay89@gmail.com>
References: <1309932945-5048-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 06 08:16:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeLPK-0003Pf-5s
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 08:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754191Ab1GFGQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 02:16:05 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39687 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753920Ab1GFGQE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 02:16:04 -0400
Received: by gyh3 with SMTP id 3so2529682gyh.19
        for <git@vger.kernel.org>; Tue, 05 Jul 2011 23:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=qIouiJRNsn5ezTF3g3DfHIGyuDY268aDMC6M1Zgq1OU=;
        b=sdY2VViLSYW9zJbieWQpY26TMWDYSTtR6YJCW/jLxC79VmbVtNpRgT/Ea6ssXXLL0B
         il+a2qN3qwKVJEKxvvQTyweg9WUaQvRqo0y3+iPqS9JwS8mXeXjvBpi4h2kr8kvFHmka
         KErjFwBFyLClmhq7z2lmLxqfoAFU38Iviz+rs=
Received: by 10.236.173.7 with SMTP id u7mr9509855yhl.267.1309932962979;
        Tue, 05 Jul 2011 23:16:02 -0700 (PDT)
Received: from localhost (cm119.beta238.maxonline.com.sg [116.86.238.119])
        by mx.google.com with ESMTPS id v25sm1989711yhk.50.2011.07.05.23.16.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Jul 2011 23:16:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.msysgit.0
In-Reply-To: <1309932945-5048-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176638>

---
 xdiff/xprepare.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 1689085..783631a 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -64,8 +64,6 @@ static int xdl_optimize_ctxs(xdfile_t *xdf1, xdfile_t *xdf2);
 
 
 static int xdl_init_classifier(xdlclassifier_t *cf, long size, long flags) {
-	long i;
-
 	cf->flags = flags;
 
 	cf->hbits = xdl_hashbits((unsigned int) size);
@@ -80,8 +78,7 @@ static int xdl_init_classifier(xdlclassifier_t *cf, long size, long flags) {
 		xdl_cha_free(&cf->ncha);
 		return -1;
 	}
-	for (i = 0; i < cf->hsize; i++)
-		cf->rchash[i] = NULL;
+	memset(cf->rchash, 0, cf->hsize * sizeof(xdlclass_t *));
 
 	cf->count = 0;
 
@@ -136,7 +133,7 @@ static int xdl_classify_record(xdlclassifier_t *cf, xrecord_t **rhash, unsigned
 static int xdl_prepare_ctx(mmfile_t *mf, long narec, xpparam_t const *xpp,
 			   xdlclassifier_t *cf, xdfile_t *xdf) {
 	unsigned int hbits;
-	long i, nrec, hsize, bsize;
+	long nrec, hsize, bsize;
 	unsigned long hav;
 	char const *blk, *cur, *top, *prev;
 	xrecord_t *crec;
@@ -164,8 +161,7 @@ static int xdl_prepare_ctx(mmfile_t *mf, long narec, xpparam_t const *xpp,
 		xdl_cha_free(&xdf->rcha);
 		return -1;
 	}
-	for (i = 0; i < hsize; i++)
-		rhash[i] = NULL;
+	memset(rhash, 0, hsize * sizeof(xrecord_t *));
 
 	nrec = 0;
 	if ((cur = blk = xdl_mmfile_first(mf, &bsize)) != NULL) {
-- 
1.7.3.4.678.g170bd
