From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH] Silence iconv warnings on Leopard
Date: Thu,  6 Dec 2007 20:07:03 +0100
Message-ID: <1196968023-45284-1-git-send-email-win@wincent.com>
Cc: jnareb@gmail.com, blaker@gmail.com,
	Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 06 20:09:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0M6E-0004NA-GR
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 20:09:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755182AbXLFTHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 14:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754168AbXLFTHP
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 14:07:15 -0500
Received: from wincent.com ([72.3.236.74]:40147 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755161AbXLFTHN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 14:07:13 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lB6J75r8025145;
	Thu, 6 Dec 2007 13:07:07 -0600
X-Mailer: git-send-email 1.5.3.7.1067.gaa51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67324>

Apple ships a newer version of iconv with Leopard (Mac OS X 10.5/Darwin
9). Ensure that OLD_ICONV is not set on any version of Darwin in the
9.x series; this should be good for at least a couple of years, when
Darwin 10 comes out and we can invert the sense of the test to
specifically check for Darwin 7 or 8.

A more sophisticated and robust check is possible for those who use
autoconf, but not everybody does that.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 Makefile |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 999391e..4dda340 100644
--- a/Makefile
+++ b/Makefile
@@ -406,7 +406,9 @@ endif
 ifeq ($(uname_S),Darwin)
 	NEEDS_SSL_WITH_CRYPTO = YesPlease
 	NEEDS_LIBICONV = YesPlease
-	OLD_ICONV = UnfortunatelyYes
+	ifneq ($(shell expr "$(uname_R)" : '9\.'),2)
+		OLD_ICONV = UnfortunatelyYes
+	endif
 	NO_STRLCPY = YesPlease
 	NO_MEMMEM = YesPlease
 endif
-- 
1.5.3.7.1067.gaa51
