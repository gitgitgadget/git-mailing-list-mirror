From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH 1/3] Makefile: Fix APPLE_COMMON_CRYPTO with BLK_SHA1
Date: Mon,  5 Aug 2013 11:59:22 -0400
Message-ID: <1375718364-13824-2-git-send-email-brian@gernhardtsoftware.com>
References: <1375718364-13824-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeremy Huddleston <jeremyhu@apple.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 05 17:59:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6NCE-0000qi-Lc
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 17:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753935Ab3HEP7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 11:59:43 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:48882 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753686Ab3HEP7m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 11:59:42 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 4AA3E27362D2; Mon,  5 Aug 2013 15:59:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (cpe-142-105-190-134.rochester.res.rr.com [142.105.190.134])
	by silverinsanity.com (Postfix) with ESMTPA id DFB9D27361E4;
	Mon,  5 Aug 2013 15:59:35 +0000 (UTC)
X-Mailer: git-send-email 1.8.4.rc1.384.g0976a17.dirty
In-Reply-To: <1375718364-13824-1-git-send-email-brian@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231663>

It used to be that APPLE_COMMON_CRYPTO did nothing when BLK_SHA1 was
set.  But APPLE_COMMON_CRYPTO is now used for more than just SHA1 (see
3ef2bca) so make sure that the appropriate libraries are always set.

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---
 Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 82f2e22..7051956 100644
--- a/Makefile
+++ b/Makefile
@@ -1182,6 +1182,9 @@ ifdef NEEDS_SSL_WITH_CRYPTO
 else
 	LIB_4_CRYPTO = $(OPENSSL_LINK) -lcrypto
 endif
+ifdef APPLE_COMMON_CRYPTO
+	LIB_4_CRYPTO += -framework Security -framework CoreFoundation
+endif
 endif
 ifdef NEEDS_LIBICONV
 	ifdef ICONVDIR
@@ -1413,7 +1416,6 @@ ifdef PPC_SHA1
 	LIB_H += ppc/sha1.h
 else
 ifdef APPLE_COMMON_CRYPTO
-	LIB_4_CRYPTO += -framework Security -framework CoreFoundation
 	COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
 	SHA1_HEADER = <CommonCrypto/CommonDigest.h>
 else
-- 
1.8.4.rc1.384.g0976a17.dirty
