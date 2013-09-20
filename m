From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v4 1/3] test: use unambigous leading path (/foo) for mingw
Date: Fri, 20 Sep 2013 10:38:46 +0800
Message-ID: <15724e27cbef5067902ebebb93aa77d3605402c8.1379644482.git.worldhello.net@gmail.com>
References: <cover.1379644482.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>, Tvangeste <i.4m.l33t@yandex.ru>,
	Johannes Sixt <j6t@kdbg.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 20 04:41:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMqf8-0002kk-5H
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 04:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753504Ab3ITClf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 22:41:35 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:55330 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771Ab3ITCle (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 22:41:34 -0400
Received: by mail-pb0-f51.google.com with SMTP id jt11so9085713pbb.38
        for <git@vger.kernel.org>; Thu, 19 Sep 2013 19:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ldoR3yrvoR9cMPZ+EaEL2huWhfnd5kGKlorn0Nt5w8g=;
        b=vo9WGhhjrO9UP2C5QSsfRcZBgy3KJu5NK2zmcLc65FXzcljKE9pswqqMzaxTkI6ZTv
         iY77EikXtf53+LWkmhiHs5a0NrGGTxMxJfsR6b5i9QNhlIXok1tJybPepqYFKAwnL4I6
         4ytvZ/DxvItTjYNfRTC7aK8MI1upLJ6LuHsiFYiJOuDTCISjTCmCfdzP5WIhslofS8bl
         CHyl/M6DqICGoRhNZ9XKfVAiJzokm6RGvZ4+7ckIrsxcWu/hMiElgCFjbWJ45ip/+uFP
         m0OCwY1aCmNvunIFQkakPx/CLgpPfTKIn0bFGHr8bT1gODYFL9UsQiboJJrIfMz0AifG
         WeeA==
X-Received: by 10.68.134.98 with SMTP id pj2mr5309402pbb.110.1379644894527;
        Thu, 19 Sep 2013 19:41:34 -0700 (PDT)
Received: from localhost.localdomain ([114.248.149.94])
        by mx.google.com with ESMTPSA id wp8sm12412723pbc.26.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 19 Sep 2013 19:41:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.460.gbed9cb4
In-Reply-To: <cover.1379644482.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1379644482.git.worldhello.net@gmail.com>
References: <CANYiYbGK_KdF5Yvcus5C_cGz3EyGTaFvirsUH5q4Eu=3VC4=Wg@mail.gmail.com> <cover.1379644482.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235049>

In test cases for relative_path, path with one leading character
(such as /a, /x) may be recogonized as "a:/" or "x:/" if there is
such DOS drive on MINGW platform. Use an umambigous leading path
"/foo" instead.

Also change two leading slashes (//) to three leading slashes (///),
otherwize it will be recognized as UNC name on MINGW platform.

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
1.8.4.460.gbed9cb4
