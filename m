From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3 1/3] test: use unambigous leading path (/foo) for mingw
Date: Tue, 17 Sep 2013 16:30:22 +0800
Message-ID: <1c0d845aca9a9ca65a7e1d481a75a0f6f4220a89.1379406453.git.worldhello.net@gmail.com>
References: <CANYiYbH9pLMx4gu1qONhy-+++ojUhPSd9F=sdRTmGWH3pSUTqQ@mail.gmail.com>
Cc: Git List <git@vger.kernel.org>, Tvangeste <i.4m.l33t@yandex.ru>,
	Johannes Sixt <j6t@kdbg.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 10:32:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLqhp-0004S3-2N
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 10:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418Ab3IQIcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 04:32:17 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35472 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134Ab3IQIcP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 04:32:15 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld10so6427154pab.8
        for <git@vger.kernel.org>; Tue, 17 Sep 2013 01:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EYvNPcbtmfYuXc59UiAJGBNarb1l3OELO1pBYmA8Kdc=;
        b=ETXdMog9WHomOjV+S2858tatILIBs9pce8yy1vhk8rzL0wWrJT1GFNTtEUYo2keoMb
         NhqDH0nUuJ9jH06Z1P5TseHXLSi8gmCUJ5Yl/ADmqfxNGv0twI/gX20J8bzbA2H7nCqT
         LcNuffQYEwL7rnmpRC0hb0w2mxB5QDCRdHEvVODK16iNxmFg/urRLU9NZZ1YSwIELIYK
         vUaw7G2u8kWz2ZBc+rCFVAji9OmFXqPxmKvlKcsQ1vxy8kB21MrqVVT8/tiUgCWbLsg0
         gu9IjVcUrtSC2EuhtZiCR8fAAIPq8jGmNzwulw6zkKp4NXDa2utWyHPPFl/AE42Oakn0
         ponA==
X-Received: by 10.68.239.168 with SMTP id vt8mr12137376pbc.125.1379406734879;
        Tue, 17 Sep 2013 01:32:14 -0700 (PDT)
Received: from localhost.localdomain ([114.248.149.94])
        by mx.google.com with ESMTPSA id im2sm36572935pbd.31.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 17 Sep 2013 01:32:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.460.g2f083d1
In-Reply-To: <CANYiYbH9pLMx4gu1qONhy-+++ojUhPSd9F=sdRTmGWH3pSUTqQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234861>

In test cases for relative_path, path with one leading character
(such as /a, /x) may be recogonized as "a:/" or "x:/" if there is
such DOS drive on MINGW platform. Use an umambigous leading path
"/foo" instead.

Also change two leading slashes (//) to three leading slashes (///),
otherwize it will be recognized as UNC path on MINGW platform.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 t/t0060-path-utils.sh | 56 +++++++++++++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 3a48de2..92976e0 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -190,33 +190,33 @@ test_expect_success SYMLINKS 'real path works on symlinks' '
 	test "$sym" = "$(test-path-utils real_path "$dir2/syml")"
 '
 
-relative_path /a/b/c/	/a/b/		c/
-relative_path /a/b/c/	/a/b		c/
-relative_path /a//b//c/	//a/b//		c/	POSIX
-relative_path /a/b	/a/b		./
-relative_path /a/b/	/a/b		./
-relative_path /a	/a/b		../
-relative_path /		/a/b/		../../
-relative_path /a/c	/a/b/		../c
-relative_path /a/c	/a/b		../c
-relative_path /x/y	/a/b/		../../x/y
-relative_path /a/b	"<empty>"	/a/b
-relative_path /a/b 	"<null>"	/a/b
-relative_path a/b/c/	a/b/		c/
-relative_path a/b/c/	a/b		c/
-relative_path a/b//c	a//b		c
-relative_path a/b/	a/b/		./
-relative_path a/b/	a/b		./
-relative_path a		a/b		../
-relative_path x/y	a/b		../../x/y
-relative_path a/c	a/b		../c
-relative_path a/b	"<empty>"	a/b
-relative_path a/b 	"<null>"	a/b
-relative_path "<empty>"	/a/b		./
-relative_path "<empty>"	"<empty>"	./
-relative_path "<empty>"	"<null>"	./
-relative_path "<null>"	"<empty>"	./
-relative_path "<null>"	"<null>"	./
-relative_path "<null>"	/a/b		./
+relative_path /foo/a/b/c/	/foo/a/b/	c/
+relative_path /foo/a/b/c/	/foo/a/b	c/
+relative_path /foo/a//b//c/	///foo/a/b//	c/		POSIX
+relative_path /foo/a/b		/foo/a/b	./
+relative_path /foo/a/b/		/foo/a/b	./
+relative_path /foo/a		/foo/a/b	../
+relative_path /			/foo/a/b/	../../../
+relative_path /foo/a/c		/foo/a/b/	../c
+relative_path /foo/a/c		/foo/a/b	../c
+relative_path /foo/x/y		/foo/a/b/	../../x/y
+relative_path /foo/a/b		"<empty>"	/foo/a/b
+relative_path /foo/a/b 		"<null>"	/foo/a/b
+relative_path foo/a/b/c/	foo/a/b/	c/
+relative_path foo/a/b/c/	foo/a/b		c/
+relative_path foo/a/b//c	foo/a//b	c
+relative_path foo/a/b/		foo/a/b/	./
+relative_path foo/a/b/		foo/a/b		./
+relative_path foo/a		foo/a/b		../
+relative_path foo/x/y		foo/a/b		../../x/y
+relative_path foo/a/c		foo/a/b		../c
+relative_path foo/a/b		"<empty>"	foo/a/b
+relative_path foo/a/b 		"<null>"	foo/a/b
+relative_path "<empty>"		/foo/a/b	./
+relative_path "<empty>"		"<empty>"	./
+relative_path "<empty>"		"<null>"	./
+relative_path "<null>"		"<empty>"	./
+relative_path "<null>"		"<null>"	./
+relative_path "<null>"		/foo/a/b	./
 
 test_done
-- 
1.8.4.460.g2f083d1
