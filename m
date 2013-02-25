From: Mike Gorchak <mike.gorchak.qnx@gmail.com>
Subject: [PATCH 1/1] Add pthread support in QNX. Do not declare NO_ macros if
 they can be autodetected.
Date: Mon, 25 Feb 2013 10:39:27 +0200
Message-ID: <CAHXAxrPTe6Q4BPtsGjiRnfFjZjUjwY6qXSAtZCzzAthODzA6EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 09:39:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9tbH-0005Tk-BW
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 09:39:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757877Ab3BYIja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 03:39:30 -0500
Received: from mail-qc0-f178.google.com ([209.85.216.178]:45337 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757499Ab3BYIj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 03:39:29 -0500
Received: by mail-qc0-f178.google.com with SMTP id j34so1189718qco.23
        for <git@vger.kernel.org>; Mon, 25 Feb 2013 00:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=wgWpc/q+mmREywT31RLulZVCAml9HmQB8eT7w580r6A=;
        b=TSMbfaNP7kzWzZk0sGyWRxSWX4PWZl/DkNTiUujhuekbSAysU1a7GBRU/BjVsU9Okq
         tVrqkmJY3XlABs1B5c6OpSuD75aeKuQjGB4rpnGBRISVC8653rJowfrYye+3+wBydJIn
         aIRqLLwEArZBgG8dXTbL1OxPKU3eATLsvO91XHIMq1WYX8bmzrQjnYtKDNljeyvPPtMT
         ZrEPIZYaz7UiSTi11kcRRegLFtgebkz8BkkhP+5JmTtEXNbg6/u2/QLXQ0fOnyZFo9AF
         G4GD+X+lXMYJxcN4D6lpbOKatJkLA5WQilf6Dnyo+OZJ6ieFWKfDX0oFoGg5j9MgF5Xb
         7bPg==
X-Received: by 10.229.252.208 with SMTP id mx16mr2248117qcb.37.1361781567878;
 Mon, 25 Feb 2013 00:39:27 -0800 (PST)
Received: by 10.49.71.68 with HTTP; Mon, 25 Feb 2013 00:39:27 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217050>

Add pthread support in QNX. Do not declare NO_ macros if they can be
autodetected.

From: Mike Gorchak <mike.gorchak.qnx@gmail.com>
Signed-off-by: Mike Gorchak <mike.gorchak.qnx@gmail.com>
---
 config.mak.uname | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index 8743a6d..d33aac6 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -527,14 +527,22 @@ ifeq ($(uname_S),QNX)
 	HAVE_STRINGS_H = YesPlease
 	NEEDS_SOCKET = YesPlease
 	NO_FNMATCH_CASEFOLD = YesPlease
-	NO_GETPAGESIZE = YesPlease
-	NO_ICONV = YesPlease
 	NO_MEMMEM = YesPlease
-	NO_MKDTEMP = YesPlease
-	NO_MKSTEMPS = YesPlease
 	NO_NSEC = YesPlease
-	NO_PTHREADS = YesPlease
 	NO_R_TO_GCC_LINKER = YesPlease
-	NO_STRCASESTR = YesPlease
-	NO_STRLCPY = YesPlease
+	# All QNX 6.x versions have pthread functions in libc
+	# and getpagesize. Leave mkstemps/mkdtemp/strcasestr/
+	# strlcpy for autodetection.
+	ifeq ($(shell expr "$(uname_R)" : '6\.[0-9]\.[0-9]'),5)
+		PTHREAD_LIBS = ""
+	else
+		NO_PTHREADS = YesPlease
+		NO_GETPAGESIZE = YesPlease
+		NO_STRCASESTR = YesPlease
+		NO_MKSTEMPS = YesPlease
+		NO_MKDTEMP = YesPlease
+		NO_STRLCPY = YesPlease
+		NO_ICONV = YesPlease
+		NO_GETTEXT = YesPlease
+	endif
 endif
-- 
1.8.2-rc0
