From: Benoit Sigoure <tsunanet@gmail.com>
Subject: [PATCH] Revert "compat/unsetenv.c: Fix a sparse warning"
Date: Sat, 20 Jul 2013 23:17:34 -0700
Message-ID: <1374387454-27800-1-git-send-email-tsunanet@gmail.com>
References: <7vr4essbkv.fsf@alter.siamese.dyndns.org>
Cc: tboegi@web.de, gitster@pobox.com,
	Benoit Sigoure <tsunanet@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 21 08:19:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0mzL-0006aD-0H
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jul 2013 08:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213Ab3GUGTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jul 2013 02:19:19 -0400
Received: from mail-ea0-f171.google.com ([209.85.215.171]:35937 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676Ab3GUGTS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jul 2013 02:19:18 -0400
Received: by mail-ea0-f171.google.com with SMTP id m14so3131208eaj.16
        for <git@vger.kernel.org>; Sat, 20 Jul 2013 23:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=X+1JVbyq7meFQo3rYriITczX3uIg8UdQF2+uPt9362I=;
        b=0fSpqs+ym1HoT2UFr+KlbrKsF0dOL6hGNpH6c25vsTUNk9/xkCz7Dr3Yz54xZRvbAu
         LdeugeN4VgQ4bqvsMksHiT+EqVgy2sKaFm0k6IJ8f3Z3VOE7Dp4Wfi6xI+kpxTlKO69+
         9EuQ0C6mhVGaBhjtKWGK535/z3jzQjBZyMsbnqpU7B0hn+8DKZM871rGhKc231GoLOiI
         ruiEnX1WhyxmXYkO3Uffm1SFWXs1Dm6hPOL2RTwd5GwwllUm3hNwosY/4Bl1MSTK1Ktr
         oBMfgWHGU5tvamVNAsOaUXS5VPziJAG5HUC3CN5Utx4Nfe66uGhilflhR/MwvthpGLjI
         E+yg==
X-Received: by 10.14.219.6 with SMTP id l6mr21426331eep.152.1374387557564;
        Sat, 20 Jul 2013 23:19:17 -0700 (PDT)
Received: from magrathea.tsunanet.net (magrathea.tsunanet.net. [142.4.212.106])
        by mx.google.com with ESMTPSA id cg12sm40534542eeb.7.2013.07.20.23.19.15
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Jul 2013 23:19:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <7vr4essbkv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230918>

This reverts commit ec535cc27e6c4f5e0b1d157e04f5511f166ecd9d.

POSIX explicitly states "the [environ] variable, which
must be declared by the user if it is to be used directly".
Not declaring it causes compilation to fail on OS X.

Instead don't declare the variable on MinGW, as it causes
a spurious warning there.
---
 compat/unsetenv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/compat/unsetenv.c b/compat/unsetenv.c
index 4ea1856..bf5fd70 100644
--- a/compat/unsetenv.c
+++ b/compat/unsetenv.c
@@ -2,6 +2,9 @@
 
 void gitunsetenv (const char *name)
 {
+#if !defined(__MINGW32__)
+     extern char **environ;
+#endif
      int src, dst;
      size_t nmln;
 
-- 
1.8.2.1.539.g4196a96
