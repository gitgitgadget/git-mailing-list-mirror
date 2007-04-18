From: Jas <jasampler@gmail.com>
Subject: [PATCH] Use const qualifier for 'sha1' parameter in delete_ref function
Date: Wed, 18 Apr 2007 05:34:34 +0200
Message-ID: <1b46aba20704172034k3b55fe9eye84b6ce1207238aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 05:34:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1He0wY-0003zj-TI
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 05:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031328AbXDRDeg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 23:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031331AbXDRDeg
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 23:34:36 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:59136 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031328AbXDRDeg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 23:34:36 -0400
Received: by wr-out-0506.google.com with SMTP id 76so23964wra
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 20:34:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Yziewwje+h4aDpV6mrg/p7Ijk46dZiH1tsHn1V7h7yokBApo4q6GYfpVKAFDD1IqNl7IE3lka7W1aQuoRRGaR6Z2zFhAJpdyirPwnuM4I9tTGex8mbf/rK2CHqcfJ6+MFITRoopu4NH8iQ7T7tu2Fy3d9TXN0uTu47D2cW85Xjs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hMvl8TcJv9AAf555pOtbPz1M14UvqiYbjtn706ULbPOh0bl/bAJLbaYD9HiL6js249l6V4sevEQiHMOPXecBBGbJ1O+1ZY4sy+6cyuCTp02MnvRDanrTvR2WEsU4icm44KIBSbMCf/e4IRq25+iDVoITgMIwipwnl59FK0goPC0=
Received: by 10.114.180.1 with SMTP id c1mr2729306waf.1176867274906;
        Tue, 17 Apr 2007 20:34:34 -0700 (PDT)
Received: by 10.114.57.15 with HTTP; Tue, 17 Apr 2007 20:34:34 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44859>

delete_ref function does not change the 'sha1' parameter. Non-const pointer
causes a compiler warning if you call to the function using a const argument.

Signed-off-by: Carlos Rica <jasampler@gmail.com>

---
 cache.h |    2 +-
 refs.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index eb57507..db8ea48 100644
--- a/cache.h
+++ b/cache.h
@@ -217,7 +217,7 @@ extern int commit_locked_index(struct lock_file *);
 extern void set_alternate_index_output(const char *);

 extern void rollback_lock_file(struct lock_file *);
-extern int delete_ref(const char *, unsigned char *sha1);
+extern int delete_ref(const char *, const unsigned char *sha1);

 /* Environment bits from configuration mechanism */
 extern int use_legacy_headers;
diff --git a/refs.c b/refs.c
index d2b7b7f..d7be284 100644
--- a/refs.c
+++ b/refs.c
@@ -705,7 +705,7 @@ static int repack_without_ref(const char *refname)
 	return commit_lock_file(&packlock);
 }

-int delete_ref(const char *refname, unsigned char *sha1)
+int delete_ref(const char *refname, const unsigned char *sha1)
 {
 	struct ref_lock *lock;
 	int err, i, ret = 0, flag = 0;
-- 
1.5.0
