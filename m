From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 5/6] git_mkstemps_mode: don't set errno to EINVAL for any error.
Date: Sat, 20 Feb 2010 00:21:57 +0100
Message-ID: <1266621718-4879-5-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq7hq8stjt.fsf@bauges.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 20 00:25:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NicDk-0008U1-5Y
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 00:25:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756169Ab0BSXZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 18:25:10 -0500
Received: from imag.imag.fr ([129.88.30.1]:41473 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755745Ab0BSXZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 18:25:09 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o1JNMA1N004023
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 20 Feb 2010 00:22:10 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NicAk-0001DL-8Y; Sat, 20 Feb 2010 00:22:10 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NicAk-0001HX-7D; Sat, 20 Feb 2010 00:22:10 +0100
X-Mailer: git-send-email 1.7.0.rc2.92.gb6a04
In-Reply-To: <vpq7hq8stjt.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sat, 20 Feb 2010 00:22:10 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140499>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 path.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/path.c b/path.c
index 005b836..2886eb6 100644
--- a/path.c
+++ b/path.c
@@ -222,7 +222,9 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
 	}
 	/* We return the null string if we can't find a unique file name.  */
 	pattern[0] = '\0';
-	errno = EINVAL;
+	/* Make sure errno signals an error on failure */
+	if (errno <= 0)
+		errno = EINVAL;
 	return -1;
 }
 
-- 
1.7.0.rc2.92.gb6a04
