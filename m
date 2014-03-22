From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 10/10] pickaxe: simplify kwset loop in contains()
Date: Sat, 22 Mar 2014 18:16:00 +0100
Message-ID: <1395508560-19893-11-git-send-email-l.s.r@web.de>
References: <1395508560-19893-1-git-send-email-l.s.r@web.de>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 22 18:17:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRPYA-00030i-D6
	for gcvg-git-2@plane.gmane.org; Sat, 22 Mar 2014 18:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbaCVRQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2014 13:16:56 -0400
Received: from mout.web.de ([212.227.17.11]:62776 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751616AbaCVRQg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2014 13:16:36 -0400
Received: from debian.fritz.box ([79.253.149.120]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0LgHKO-1Wv1FR3XgS-00ne6D; Sat, 22 Mar 2014 18:16:29
 +0100
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1395508560-19893-1-git-send-email-l.s.r@web.de>
X-Provags-ID: V03:K0:kiN7kl9hdfpSWkpdQoELhV9fYW92Pgs/w/tHRrPpqdmdd4QpPCN
 51nP1I9v9twZRY3Z6LrV3UbbjobGwpJgVexMcYmJcgyrHEs0gHsjMMHUzyEtZ+Tlqxf9+z3
 /HNc150J4d+WbnAcROzBtryY7t1OsrbkyC8GxECTo3ks3Mo+d6HM/KBhnL+i95V/U9pNSy/
 lAQs589qC59jOBzU4j1kg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244782>

Inlining the variable "found" actually makes the code shorter and
easier to read.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 diffcore-pickaxe.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 70753d0..185f86b 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -94,13 +94,10 @@ static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kws)
 		while (sz) {
 			struct kwsmatch kwsm;
 			size_t offset = kwsexec(kws, data, sz, &kwsm);
-			const char *found;
 			if (offset == -1)
 				break;
-			else
-				found = data + offset;
-			sz -= found - data + kwsm.size[0];
-			data = found + kwsm.size[0];
+			sz -= offset + kwsm.size[0];
+			data += offset + kwsm.size[0];
 			cnt++;
 		}
 	}
-- 
1.9.1
