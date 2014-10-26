From: David Michael <fedora.dm0@gmail.com>
Subject: [PATCH 2/3] Makefile: Reorder linker flags in the git executable rule
Date: Sun, 26 Oct 2014 13:33:53 -0400
Message-ID: <87mw8iag72.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 26 18:33:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiRhS-0006o1-5A
	for gcvg-git-2@plane.gmane.org; Sun, 26 Oct 2014 18:33:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbaJZRdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2014 13:33:51 -0400
Received: from mail-qa0-f47.google.com ([209.85.216.47]:49372 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbaJZRdu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2014 13:33:50 -0400
Received: by mail-qa0-f47.google.com with SMTP id dc16so2891096qab.6
        for <git@vger.kernel.org>; Sun, 26 Oct 2014 10:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:mime-version:content-type;
        bh=w7kk/P3Eo1M/OPKnyhqX5Zw7nDfEOG+Z/kMFFbaaQo0=;
        b=LSOjhuzhivtoNY2N3b4aF2er0L89MMT+iKQCU/OzPtSwDNvJ7T/2baxtd6dcA5kkZO
         41neRAZJtMU3lK6mjhD8Ed4HC+54eR8xi7uNPqD+fMzctRMCGiWk4tjIAXI+3ZZA1ySr
         gCzWm0LElWaRs3WqZO5auqLDf2ikE7/wYWeGiWTPIJLf6h2xNgp0iqozU6OFZL98KMHi
         rM+mqUwz4N4yVMLsPApaiRucZkU+3daYxZO3rkpryryYmURCeLDH9x/K6Av+yRoiYgS+
         cDGP4SU2QVnGBvt5Drd0uyGKNzms0J43PdSVaEQ0OxK9Q8TPKteGNOR4aWu1A8GXM6fe
         xdjA==
X-Received: by 10.140.102.7 with SMTP id v7mr24349157qge.68.1414344829612;
        Sun, 26 Oct 2014 10:33:49 -0700 (PDT)
Received: from callisto (c-68-81-204-146.hsd1.pa.comcast.net. [68.81.204.146])
        by mx.google.com with ESMTPSA id c3sm9154560qga.47.2014.10.26.10.33.48
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Oct 2014 10:33:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The XL C compiler can fail due to mixing library path and object
file arguments, for example when linking git while building with
"gmake LDFLAGS=-L$prefix/lib".  This moves the ALL_LDFLAGS variable
expansion in the git executable rule to be consistent with all the
other linking rules.

Signed-off-by: David Michael <fedora.dm0@gmail.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index fcd51ac..827006b 100644
--- a/Makefile
+++ b/Makefile
@@ -1610,8 +1610,8 @@ git.sp git.s git.o: EXTRA_CPPFLAGS = \
 	'-DGIT_INFO_PATH="$(infodir_relative_SQ)"'
 
 git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ git.o \
-		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) git.o \
+		$(BUILTIN_OBJS) $(LIBS)
 
 help.sp help.s help.o: common-cmds.h
 
-- 
1.9.3
