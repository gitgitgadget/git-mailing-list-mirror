From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v5 1/3] test: use unambigous leading path (/foo) for MSYS
Date: Mon, 14 Oct 2013 10:29:38 +0800
Message-ID: <4a078e41976b25488571b1478a51e287ffdd55c8.1381717700.git.worldhello.net@gmail.com>
References: <cover.1381717700.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 14 04:30:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVXvD-0002ht-3c
	for gcvg-git-2@plane.gmane.org; Mon, 14 Oct 2013 04:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755672Ab3JNCaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Oct 2013 22:30:07 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:45742 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755662Ab3JNCaF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Oct 2013 22:30:05 -0400
Received: by mail-pb0-f43.google.com with SMTP id md4so6648173pbc.30
        for <git@vger.kernel.org>; Sun, 13 Oct 2013 19:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=sR8HrstrmALE5BVQV7nUHYLCFvfTKzClSDRfi+EscJI=;
        b=SEGvXkTemFjdn+/9+pqAEUG+ndC9ig5cuumf981LFgEXLbDWuKHeBTR8kFEkEITbnt
         5JclMzlu/tS2ftenWTry/9Qju2LiFA0wID45Io6km8SnO8z/VlGubUa0/nV//wy/1Eyj
         RNZjziEZuhkLPxaogTmwOlsO0co/Hvrh3b9FLMhha9Ea/lP5a78YYB569dQ5e4ZlVbOJ
         78z9TqEEqU7HfrERwWaMalRHpFIIhsbyoJyAi0EpQhZTZLUyNaxOn4loU3tvlXWmpEK2
         6qs4aP+3awyAXM3hPEKC+Ut6ByeqFH751txBjY0xrZyK/nHtDZYUIEzTysh67Rg1euXp
         jMHQ==
X-Received: by 10.66.146.42 with SMTP id sz10mr35545659pab.100.1381717804732;
        Sun, 13 Oct 2013 19:30:04 -0700 (PDT)
Received: from localhost.localdomain ([114.248.133.111])
        by mx.google.com with ESMTPSA id gh2sm74692626pbc.40.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 13 Oct 2013 19:30:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.4
In-Reply-To: <cover.1381717700.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1381717700.git.worldhello.net@gmail.com>
References: <52570EC8.3050207@gmail.com> <cover.1381717700.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236087>

In test cases for relative_path, path with one leading character
(such as /a, /x) may be recogonized as "a:/" or "x:/" if there is
such DOS drive on MSYS platform. Use an umambigous leading path
"/foo" instead.

Also change two leading slashes (//) to three leading slashes (///),
otherwize it will be recognized as UNC name on MSYS platform.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
1.8.4
