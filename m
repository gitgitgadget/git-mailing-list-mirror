From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 04/20] mingw: factor out Windows specific environment
 setup
Date: Wed, 27 Jan 2016 17:19:21 +0100 (CET)
Message-ID: <8cd3fc74bbbd012b10f8fbb275fc2f64bd3b6195.1453911367.git.johannes.schindelin@gmx.de>
References: <cover.1453818789.git.johannes.schindelin@gmx.de> <cover.1453911367.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Karsten Blees <blees@dcon.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 17:19:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOSof-00021T-In
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 17:19:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933739AbcA0QTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 11:19:30 -0500
Received: from mout.gmx.net ([212.227.15.18]:64912 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933700AbcA0QT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 11:19:26 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LjrDd-1ZnCFf2K9R-00bpdS; Wed, 27 Jan 2016 17:19:22
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453911367.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:0xI4SvAK3ZsOpACiJ0P5gFW/slBKjnFr7mz0E1SPZoVfEIY/U/2
 oL+e6avSXKNv2DjajPyP2OHxxTcgmD/azFn9MD8lGWlK+FooKMwSJWLtr8wnZS1cKttYsP/
 v0dh0Wd4PQkLPvXCEnEpRfhcRm3As2gvSP46hsU7T1j9IjatP9VpMu5fgth4JkIi4fzcJZJ
 kjH+1cwFOXuVURRiFIl9w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Vuqa7VURqlU=:0n78BH6q2T/RLHqVjYqpA0
 xUowlKpyzjgx/pyiogp28G3I7R88UunIoPs9nW7+kuOBzqv3KwEcepvdoocHXxY/By6jsXG2w
 69ivk3VvH+78qcAMz+xSwGNRv4/dQhp3XceZG5zaD2R5ySAjaCbKvxsRiyjkZb3pT07uAStdS
 uYuEsvOsmiwCRQ+1LKRJNnTe0AticDIvbG2YJMtgU5iP0l9E/m8LlD/Q6x9RXQAxUSk2WLwB6
 2dQTzAfPHD50bPzLEswxz27D9dtWU8+7dXcxEVp4YkdPBQzrfaBvdTPUi8uPryfWimaDq/Ust
 DQpNkQ0kvtz3GSVGqWbxOdTJ8i300UtoUniXxL3AR4YxU3yRhEpN28SwOtTBjCdls3Yo5O3tA
 jNs45NC6bC5U306l+y7aOtaRwOX275s1pB3ApM0iiAs0r6FLoIg5SEQQNiPBnSLRzAl4olyJh
 zLxBB1qdS56s8nZH7Ru24q//qm/H924FlCSlxGHu0Py6qK9LI0fQznjJQy8QFAJUTbruuTgmM
 YyXb4yIVIB97R3AktKCNRp8qWoZ/gqQws/zuYOUqKCKNgUgVfjraCxDvzTkyB8gtf/lPqyfiY
 LfEE50k4wmkdmgMgQVICiJjIhC/o4qvnfZfDDvwol6Cg+BEoY9kySWFLiaS9XODgrKaFCa0q+
 u0FX4SDbw0FL9W/d7zHsx6LYzG7NPj9Kqv1sTj+4nkG75wo9IfBsDlbhFCg0pFTKlGF9VTvIv
 +NaPib31L6QVHRJNl6J2X00jstr7QtK+rMnQ+0apbuOROHN2ZLX6faj4CT3MtQNDsJuGVCuq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284923>

From: Karsten Blees <blees@dcon.de>

We will add more environment-related code to that new function
in the next patch.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 77a51d3..8d52c73 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2047,6 +2047,22 @@ int xwcstoutf(char *utf, const wchar_t *wcs, size_t utflen)
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
@@ -2125,19 +2141,7 @@ void mingw_startup()
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
