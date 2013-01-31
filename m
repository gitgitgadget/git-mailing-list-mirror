From: Fraser Tweedale <frase@frase.id.au>
Subject: [PATCH] push: fix segfault when HEAD points nowhere
Date: Thu, 31 Jan 2013 22:22:51 +1000
Message-ID: <1359634971-79036-1-git-send-email-frase@frase.id.au>
Cc: Fraser Tweedale <frase@frase.id.au>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 31 13:50:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0tb5-0006KQ-6Z
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 13:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398Ab3AaMuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 07:50:09 -0500
Received: from 110-174-235-130.static.tpgi.com.au ([110.174.235.130]:64428
	"EHLO bacardi.hollandpark.frase.id.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753327Ab3AaMuI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Jan 2013 07:50:08 -0500
X-Greylist: delayed 1581 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Jan 2013 07:50:07 EST
Received: from bacardi.hollandpark.frase.id.au (localhost [127.0.0.1])
	by bacardi.hollandpark.frase.id.au (8.14.5/8.14.5) with ESMTP id r0VCNddq079082;
	Thu, 31 Jan 2013 22:23:39 +1000 (EST)
	(envelope-from fraser@bacardi.hollandpark.frase.id.au)
Received: (from fraser@localhost)
	by bacardi.hollandpark.frase.id.au (8.14.5/8.14.5/Submit) id r0VCNcEX079081;
	Thu, 31 Jan 2013 22:23:38 +1000 (EST)
	(envelope-from fraser)
X-Mailer: git-send-email 1.8.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215114>

When reporting the outcome of a push, a segfault occurs if HEAD does
not point somewhere.  Check that HEAD points somewhere before trying
to strcmp it.

Signed-off-by: Fraser Tweedale <frase@frase.id.au>
---
 transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport.c b/transport.c
index 9932f40..b9306ef 100644
--- a/transport.c
+++ b/transport.c
@@ -741,7 +741,7 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 			n += print_one_push_status(ref, dest, n, porcelain);
 		if (ref->status == REF_STATUS_REJECT_NONFASTFORWARD &&
 		    *nonfastforward != NON_FF_HEAD) {
-			if (!strcmp(head, ref->name))
+			if (head != NULL && !strcmp(head, ref->name))
 				*nonfastforward = NON_FF_HEAD;
 			else
 				*nonfastforward = NON_FF_OTHER;
-- 
1.8.1.1
