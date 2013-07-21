From: Benoit Sigoure <tsunanet@gmail.com>
Subject: [PATCH] Revert "compat/unsetenv.c: Fix a sparse warning"
Date: Sun, 21 Jul 2013 12:54:08 -0700
Message-ID: <1374436448-8199-1-git-send-email-tsunanet@gmail.com>
References: <1374387454-27800-1-git-send-email-tsunanet@gmail.com>
Cc: tboegi@web.de, gitster@pobox.com,
	Benoit Sigoure <tsunanet@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 21 21:55:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0zj8-0008Iw-NC
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jul 2013 21:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756041Ab3GUTz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jul 2013 15:55:27 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:40987 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755934Ab3GUTz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jul 2013 15:55:26 -0400
Received: by mail-ee0-f46.google.com with SMTP id d41so3349085eek.19
        for <git@vger.kernel.org>; Sun, 21 Jul 2013 12:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=etCHht/aBZjY06VuMXmvSdgMOYjdIqCDRvhXoFGfltw=;
        b=dw/dlR8ry2VK/ffuautbS7IAeJX5TtelHowAwlONTVhF6D5QbxTSyGFZswF37IINo5
         GLXZz6suXeTqC8i6jwYznPhrYaEv54TVqKxBcM2pPKVzCPNMYjLVhHuNwMOk2NzarnK9
         hgWikSV4dJinFum+TI2hPpLp1h8AM4opQG2WZV0BOwRD0VzCg5nP2GScuOv5+c7Wr7fm
         6681duPBx0yig9CT/F1Z+rRadfore/VTRkPcfHkncXagsbwbhHDTlJHgwaOkvHs0bsH9
         VXgc0uYgQSd1r9ysxYRRP7KaAxbLPMgd90CNurCnOewlQDN7PS6Pkdauz6UTHAguPU4i
         LCuA==
X-Received: by 10.14.98.6 with SMTP id u6mr24435971eef.62.1374436525013;
        Sun, 21 Jul 2013 12:55:25 -0700 (PDT)
Received: from magrathea.tsunanet.net (magrathea.tsunanet.net. [142.4.212.106])
        by mx.google.com with ESMTPSA id b7sm45220276eef.16.2013.07.21.12.55.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Jul 2013 12:55:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1374387454-27800-1-git-send-email-tsunanet@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230941>

This reverts commit ec535cc27e6c4f5e0b1d157e04f5511f166ecd9d.

POSIX explicitly states "the [environ] variable, which
must be declared by the user if it is to be used directly".
Not declaring it causes compilation to fail on OS X.

Instead don't declare the variable on MinGW, as it causes
a spurious warning there.

Signed-off-by: Benoit Sigoure <tsunanet@gmail.com>
---

Resending as I forgot to Sign-off the previous patch.

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
