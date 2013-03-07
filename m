From: Lukas Fleischer <git@cryptocrack.de>
Subject: [PATCH 1/2] bundle: Fix "verify" output if history is complete
Date: Thu,  7 Mar 2013 01:56:35 +0100
Message-ID: <1362617796-4120-1-git-send-email-git@cryptocrack.de>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Lukas Fleischer <git@cryptocrack.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 07 05:57:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDStF-00008r-PI
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 05:57:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757650Ab3CGE4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 23:56:46 -0500
Received: from elnino.cryptocrack.de ([46.165.227.75]:12734 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754492Ab3CGE4p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 23:56:45 -0500
Received: from localhost (p57B45C6D.dip.t-dialin.net [87.180.92.109])
	by elnino.cryptocrack.de (OpenSMTPD) with ESMTP id 59373010
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128);
	Thu, 7 Mar 2013 01:56:37 +0100 (CET)
X-Mailer: git-send-email 1.8.2.rc2.352.g908df73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217572>

A more informative message for "complete" bundles was added in commit
8c3710fd. However, the prerequisites ref list is currently read *after*
we check if it equals zero, which means we never actually print the
newly introduced message.

Move the code that reads the prerequisites ref list before the check to
fix this.

Signed-off-by: Lukas Fleischer <git@cryptocrack.de>
---
I am not sure whether we should add a test case for such a simple "bug".
If you think we should, just let me know and I will add one.

 bundle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bundle.c b/bundle.c
index 8d12816..65db53b 100644
--- a/bundle.c
+++ b/bundle.c
@@ -188,10 +188,10 @@ int verify_bundle(struct bundle_header *header, int verbose)
 			     r->nr),
 			  r->nr);
 		list_refs(r, 0, NULL);
+		r = &header->prerequisites;
 		if (!r->nr) {
 			printf_ln(_("The bundle records a complete history."));
 		} else {
-			r = &header->prerequisites;
 			printf_ln(Q_("The bundle requires this ref",
 				     "The bundle requires these %d refs",
 				     r->nr),
-- 
1.8.2.rc2.352.g908df73
