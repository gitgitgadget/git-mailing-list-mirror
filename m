From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] xmalloc: include size in the failure message
Date: Fri, 20 Aug 2010 15:01:12 +0200
Message-ID: <1282309272-20906-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 20 15:05:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmRHd-0006J8-S1
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 15:05:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887Ab0HTNFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 09:05:15 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33951 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751580Ab0HTNFN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 09:05:13 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o7KCnw06009452
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 20 Aug 2010 14:49:58 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OmRDh-0004Us-3z; Fri, 20 Aug 2010 15:01:17 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OmRDg-0005S2-UN; Fri, 20 Aug 2010 15:01:16 +0200
X-Mailer: git-send-email 1.7.2.1.83.ge0227
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 20 Aug 2010 14:49:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o7KCnw06009452
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1282913399.07611@VB7iWWRH0awFi1jPOrLL3w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154030>

Out-of-memory errors can either be actual lack of memory, or bugs (like
code trying to call xmalloc(-1) by mistake). A little more information
may help tracking bugs reported by users.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
This kind of thing may help for cases like

Subject: Out of memory error during git push
http://thread.gmane.org/gmane.comp.version-control.git/153988

 wrapper.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index afb4f6f..7057cbd 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -40,7 +40,7 @@ void *xmalloc(size_t size)
 		if (!ret && !size)
 			ret = malloc(1);
 		if (!ret)
-			die("Out of memory, malloc failed");
+			die("Out of memory, malloc failed (tried to allocate %u bytes)", size);
 	}
 #ifdef XMALLOC_POISON
 	memset(ret, 0xA5, size);
-- 
1.7.2.1.83.ge0227
