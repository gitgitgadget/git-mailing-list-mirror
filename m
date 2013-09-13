From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 1/3] test: use unambigous leading path (/foo) for mingw
Date: Fri, 13 Sep 2013 13:08:12 +0800
Message-ID: <6533cbb59cd4de1d616ef62898f64a5cd144a561.1379048276.git.worldhello.net@gmail.com>
References: <cover.1379048276.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>, Tvangeste <i.4m.l33t@yandex.ru>,
	Johannes Sixt <j6t@kdbg.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 07:11:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKLes-00074c-Kc
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 07:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264Ab3IMFK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 01:10:59 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:48517 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752222Ab3IMFK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 01:10:58 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj1so2065860pad.0
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 22:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Jc1lcZoEBAbDTb7EAcSi8NaB3Uxb8thoS+3HCAsrHf8=;
        b=OfADWABE8NTIGuuqxcy+ly3xKn0O9sKM7Ox6T/DoEZ3XV4BDiJcoys/c3ADU1iOhvy
         3EaS9lpbLKET70wwLeVQ3b1VGyHKoE7wCrRZbIF4PzkjJCIqQOiy6YvsdanhJGy81fEA
         LnC++APoWGS8/uSmY3C7D/3Lkv6/gLESuklJlGvwxdRtoxSb6dLe/OICAObBrUlVTejy
         u1XQKTqhJ5x14PV2PVOcTDmXWhAAz+hATYiN18cNDD0roIEw97tUQhv3wHHDod1r0TlJ
         L2NwUR7SyoR75C7JqL5OC2EVsFS/3Jxgt230a3wYC3LSOM4BmS2DRhHPZD/PjFqRLMdU
         22Jg==
X-Received: by 10.66.25.70 with SMTP id a6mr13162231pag.68.1379049058381;
        Thu, 12 Sep 2013 22:10:58 -0700 (PDT)
Received: from localhost.localdomain ([114.248.145.187])
        by mx.google.com with ESMTPSA id qa9sm8985593pbc.7.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 12 Sep 2013 22:10:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.459.gd80d422
In-Reply-To: <cover.1379048276.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1379048276.git.worldhello.net@gmail.com>
References: <xmqq38pczjw6.fsf@gitster.dls.corp.google.com> <cover.1379048276.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234726>

In test cases for relative_path, path with one leading character
(such as /a, /x) may be recogonized as "a:/" or "x:/" if there is
such doc drive on MINGW platform. Use an umambigous leading path
"/foo" instead.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 t/t0060-path-utils.sh | 56 +++++++++++++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 3a48de2..82a6f21 100755
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
+relative_path /foo/a//b//c/	//foo/a/b//	c/		POSIX
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
1.8.4.459.gd80d422
