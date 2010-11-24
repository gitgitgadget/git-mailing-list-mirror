From: =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@gmail.com>
Subject: [PATCH] imap-send: link against libcrypto for HMAC and others
Date: Wed, 24 Nov 2010 14:55:16 +0100
Message-ID: <1290606916-14550-1-git-send-email-flameeyes@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 24 14:56:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLFpB-0004Sx-CC
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 14:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755163Ab0KXNze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 08:55:34 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54453 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754923Ab0KXNzd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 08:55:33 -0500
Received: by wyb28 with SMTP id 28so9493944wyb.19
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 05:55:32 -0800 (PST)
Received: by 10.227.135.85 with SMTP id m21mr9482045wbt.227.1290606930836;
        Wed, 24 Nov 2010 05:55:30 -0800 (PST)
Received: from localhost (host249-252-static.95-94-b.business.telecomitalia.it [94.95.252.249])
        by mx.google.com with ESMTPS id x15sm3462514weq.31.2010.11.24.05.55.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Nov 2010 05:55:29 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162062>

When using stricter linkers, such as GNU gold or Darwin ld, transitive
dependencies are not counted towards symbol resolution. If we don't link
imap-send to libcrypto, we'll have undefined references to the HMAC_*,
EVP_* and ERR_* functions families.
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 1f1ce04..c8377d4 100644
--- a/Makefile
+++ b/Makefile
@@ -1927,7 +1927,7 @@ git-%$X: %.o $(GITLIBS)
 
 git-imap-send$X: imap-send.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
-		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL)
+		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
 
 git-http-fetch$X: revision.o http.o http-walker.o http-fetch.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
-- 
1.7.3.2
