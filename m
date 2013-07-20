From: Benoit Sigoure <tsunanet@gmail.com>
Subject: [PATCH] Fix compilation on OS X.
Date: Sat, 20 Jul 2013 00:49:27 -0700
Message-ID: <1374306567-16640-1-git-send-email-tsunanet@gmail.com>
Cc: Benoit Sigoure <tsunanet@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 20 09:50:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0Rvm-00078u-Fz
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 09:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209Ab3GTHuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jul 2013 03:50:13 -0400
Received: from mail-ee0-f47.google.com ([74.125.83.47]:64269 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760Ab3GTHuM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jul 2013 03:50:12 -0400
Received: by mail-ee0-f47.google.com with SMTP id e49so2739287eek.6
        for <git@vger.kernel.org>; Sat, 20 Jul 2013 00:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=2UnUzdnHOENwI0CrVJKBy46cASmCfO26RUWoeGhZ9xY=;
        b=CO9BT3EG/k+H6I5chcsb11ogTc08zeQV28vWSbKcaCtnhKP31GJT3dW4z6Ha0RGqBm
         YdUROz2V8H4GBeD7xLD3dwArRhM7rjYNks3LWIJc8xuIsyBoljzJOD3t6MdU8rKRjuib
         6/tNWMtlPWYF5xn8CL8IqB8yNR6/pV2vkax4GJY4mHfo3pjrknMSl05cayvi0zAnSz5o
         vW1QqsD8z/87LztpS4cPvJizl6sxnmgbgWO2F7w1tfasiQt6nDo8S7O17GEegebo1sUn
         3CrGMeEoakPatkufhb7myOT1KBao170/qzyuQE0Cu7KrX+kDwQ4R5kIjta15yAEgeGvx
         x9AQ==
X-Received: by 10.14.149.141 with SMTP id x13mr19324640eej.77.1374306610595;
        Sat, 20 Jul 2013 00:50:10 -0700 (PDT)
Received: from magrathea.tsunanet.net (magrathea.tsunanet.net. [142.4.212.106])
        by mx.google.com with ESMTPSA id ci50sm33265772eeb.12.2013.07.20.00.50.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Jul 2013 00:50:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230875>

On OS X libc headers don't define `environ', and since ec535cc2 removed
the redundant declaration this code no longer builds on OS X.
---
 compat/unsetenv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/compat/unsetenv.c b/compat/unsetenv.c
index 4ea1856..addf3dc 100644
--- a/compat/unsetenv.c
+++ b/compat/unsetenv.c
@@ -1,5 +1,10 @@
 #include "../git-compat-util.h"
 
+#ifdef __APPLE__
+// On OS X libc headers don't define this symbol.
+extern char **environ;
+#endif
+
 void gitunsetenv (const char *name)
 {
      int src, dst;
-- 
1.8.2.1.539.g4196a96
