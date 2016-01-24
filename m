From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 04/19] mingw: factor out Windows specific environment setup
Date: Sun, 24 Jan 2016 16:43:31 +0100 (CET)
Message-ID: <7edbc873fe214e1a49bbde4f040a35f9bccb151e.1453650173.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Karsten Blees <blees@dcon.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 16:44:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNMpf-0000ZT-DT
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 16:44:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142AbcAXPn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 10:43:59 -0500
Received: from mout.gmx.net ([212.227.15.19]:50077 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752544AbcAXPnh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 10:43:37 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LgHvY-1ZiU9x2bXo-00nfCi; Sun, 24 Jan 2016 16:43:33
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453650173.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:RoN3ZrdGX+wDuMDFhu5TOMfqqxmiHlwKSjzIgGKMRcPB8Fso0hr
 HwgZGzWDAtivkJFBCdL1yG+wgJqUnRCD5MjBzgvmz7mkj+G019Bri6l4AUE29yc/xGa3lgq
 ibuSQh66x+oTnbhdQEi7ApenUyRfBjdLiS7QWHuoYKPtz5xUBXO0bNeU4wC3qLKM9Lo65xH
 4Anl9BcZh5owv78p+xFJw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mAsfk0+URkg=:1XUqoaXyelfu/Pq5c+zkL0
 juVcdiCQiMmgT58AYursER22jMiTKuRb1JsW76A88VDZCzw0K552xehLSohRI1wwBgm+vOt6m
 pakuKFWR7JZO35qENJX7wO9S+S+1jBPzSHfxzC6jFo6woVs3tZ0W9cVUoB8wcV3B4o1/mmhIe
 GHp29J0416fQ9h1OSQdKcvG6dg6/mXBFQLECFrGdN+9YRydSushv3DJxDVVBpM6MY9teGIAX6
 N0M2psfeIbu7xASJct85By1vXP07ZAlLgc3tybJNCLbxAeU58kA7BXJALLtMhGWQtRtg0iur5
 uXqIEUl1E1QZa8oA9BNTbmnrH88K0K9vzmXfX/m1Yujn6YiD9SFYOC75ziIlcUQ6giYAHbN8p
 yHyRoSr5Js6Tnz7lOPo2HxZjoqNrLHUzF0qSUSQvIbNQSYGKUvMSY0JEKCypEkhqG7T09IWKo
 iJWbpKG4EkbtvzEFrvJscOSuiIXC38tkHp/F4ojf2TVCVYgMnJxxqTw5hEIibN+xP8qQ6XT3g
 xayiCj4pvnt5Do4Msz6LhdVakrVSN59O9szMOfH4szHOcUY3DR94D3FVDgdFTcQ0JwuP7w4Rq
 DCaSN5U9ZQJ1YWMy40tpFZDMN0E+8AGGTN3PbxWDt+xEQfuiJU6J15PuS1JqyjJ9W/D6i63yj
 LeaKKNkvCl0AHPcT6WH1Fso36v0SoDYfeMuN3gYSiwPs0whZVdTUqtLuA/ZuoJ2q3pC04BKUH
 ifv61lqlwEjZuoK+KILXtKRy1xYYhejsA1qZNwifKVeOFCBopVs2ol0ngLJe1PWR2bDAEvz3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284666>

From: Karsten Blees <blees@dcon.de>

We will add more environment-related code to that new function
in the next patch.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 8437c9a..a12197e 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2040,6 +2040,22 @@ int xwcstoutf(char *utf, const wchar_t *wcs, size_t utflen)
 	return -1;
 }
 
+static void setup_windows_environment()
+{
+	/* on Windows it is TMP and TEMP */
+	if (!getenv("TMPDIR")) {
+		const char *tmp = getenv("TMP");
+		if (!tmp)
+			tmp = getenv("TEMP");
+		if (tmp)
+			setenv("TMPDIR", tmp, 1);
+	}
+
+	/* simulate TERM to enable auto-color (see color.c) */
+	if (!getenv("TERM"))
+		setenv("TERM", "cygwin", 1);
+}
+
 /*
  * Disable MSVCRT command line wildcard expansion (__getmainargs called from
  * mingw startup code, see init.c in mingw runtime).
@@ -2118,19 +2134,7 @@ void mingw_startup()
 	qsort(environ, i, sizeof(char*), compareenv);
 
 	/* fix Windows specific environment settings */
-
-	/* on Windows it is TMP and TEMP */
-	if (!mingw_getenv("TMPDIR")) {
-		const char *tmp = mingw_getenv("TMP");
-		if (!tmp)
-			tmp = mingw_getenv("TEMP");
-		if (tmp)
-			setenv("TMPDIR", tmp, 1);
-	}
-
-	/* simulate TERM to enable auto-color (see color.c) */
-	if (!getenv("TERM"))
-		setenv("TERM", "cygwin", 1);
+	setup_windows_environment();
 
 	/* initialize critical section for waitpid pinfo_t list */
 	InitializeCriticalSection(&pinfo_cs);
-- 
2.7.0.windows.1.7.g55a05c8
