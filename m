From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] Makefile: reenable install with NO_CURL
Date: Wed, 26 May 2010 16:24:34 +0200
Message-ID: <4f12dca01c2e72c5ba38ce5230422b394c1297d9.1274883851.git.git@drmicha.warpmail.net>
References: <8E0CE121-DB2F-4017-AB46-282562B072FB@aol.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Walker <PWalker752@aol.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 26 16:24:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHHXT-0000lk-Gx
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 16:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755281Ab0EZOYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 10:24:50 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:45392 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755017Ab0EZOYt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 May 2010 10:24:49 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4B441F80F3;
	Wed, 26 May 2010 10:24:49 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 26 May 2010 10:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=EdRAtPtm2Pvvf6TJAzTlhZyR2Lw=; b=KnstMPuEfQCMRM5fa2IjF8BIExkynhEQmVLUiF4twRyHcndlpkfNv1G7z6No1KVGTphuYQPThioRlot1qt550RHw+cV2k3Q1k/hvyr2Z1lFpJkMDLJCT5SRRcz+K6CvGSBAYHMtWxYu28a1uC9axIQhkGg3nyKxdwv1Gygfl2Zs=
X-Sasl-enc: SvhECqJTTtZf8QMFZXs30Qtpf5yVouKL0sFf7+eSXFqp 1274883888
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A5A41589A0;
	Wed, 26 May 2010 10:24:48 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.232.g2311e.dirty
In-Reply-To: <8E0CE121-DB2F-4017-AB46-282562B072FB@aol.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147801>

Setting NO_CURL leaves some variables like REMOTE_CURL_ALIASES
empty, which creates no fun when for-looping over
$(REMOTE_CURL_ALIASES) unconditionally. Make it conditional.

Reported-by: Paul Walker <PWalker752@aol.com>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Against master but suggested for maint.
Note that the problem occurs during "make install", not "make".

 Makefile |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 07cab8f..d5d6565 100644
--- a/Makefile
+++ b/Makefile
@@ -2008,12 +2008,13 @@ endif
 		ln -s "git$X" "$$execdir/$$p" 2>/dev/null || \
 		cp "$$execdir/git$X" "$$execdir/$$p" || exit; \
 	  done; } && \
-	{ for p in $(REMOTE_CURL_ALIASES); do \
+	{ test x"$(REMOTE_CURL_ALIASES)" = x || \
+		{ for p in $(REMOTE_CURL_ALIASES); do \
 		$(RM) "$$execdir/$$p" && \
 		ln "$$execdir/git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
 		ln -s "git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
 		cp "$$execdir/git-remote-http$X" "$$execdir/$$p" || exit; \
-	  done; } && \
+	  done; } ; } && \
 	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
 
 install-gitweb:
-- 
1.7.1.232.g2311e.dirty
