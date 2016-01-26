From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 04/19] mingw: factor out Windows specific environment
 setup
Date: Tue, 26 Jan 2016 15:34:38 +0100 (CET)
Message-ID: <8704a46662d0c2e9086c9a000cb8ead95594803c.1453818790.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <cover.1453818789.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Karsten Blees <blees@dcon.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 15:35:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO4hw-0004XC-9G
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 15:35:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966280AbcAZOet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 09:34:49 -0500
Received: from mout.gmx.net ([212.227.17.20]:56918 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966092AbcAZOeq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 09:34:46 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LyB6P-1a0gcE0yjV-015cE6; Tue, 26 Jan 2016 15:34:39
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453818789.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:zeR+8gqx913BsXgPZlPnBS5WaN8brkpFGgNwZd0R0R1wx+rwa0I
 7C5D/kfvAqAU0S7L79JdfGDCAWPQoCrs5loDjLSa5VeVp0zP0euGf4xtaXEY9JciaYnDZ4v
 mpDJialb0fdOJtOGyQu3YLhUHIrNNFlGlZ0WihQ+FR+TqkpzjsjvpqqvdLUMSbvMxVi6HpX
 vFEx8YtgUeNB7rfr60Zpg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+3Q1s7kFgPU=:nSS9pI4fzmPXVYYV8LmJ/v
 GJcXQmUweVnSNqZdSLqMKxwd4VLOpZn4eFrzINgHBmen6zWz9nArK7hiwgOxQ6iP9WBOn6b2r
 6IkFzGWa6R+9VyGDoVMSLyZAbP/FGBB4WxgrIC2ufHjw/5eiCpntjCFf8Zj3XSmVZkE6xnypk
 9MxqK02zSh08qOAjZGS9jerc05QKzGSEmfxD8Yqp6MnEatwqKoBQ/f9fnY0Jhd5ghnikn6jb9
 R/NTrJzCTJLyLl04YTMluwqdhW++UWK8pCQs3XjbsIP7E8OxDjLTI/W6/uPeFOvuKbJLkYbkA
 JrYWhET/Jzf+802nozLsYy5UxarP6Mtbg7rR+DaEDskwszkw+py/+yVO5VJevKASTpjiNpPss
 CuO74dnBHxoA/aBlTX9xdDQOmgFbRwkA5NFm5E+2qLyjxxLLS67KSpoBICgiEDq8eKvUD73D/
 dmVvetI+iA/nucdSMsw9MonIVdd/wjwKPNIEiQZNNF0vcxyn085cMGyl3ELS8RK9v9f4MoMZI
 nwhT/2yMRqRqk2fmD8r80oA/8zZ92AobsHgf8iHH2bsEB4ljSpNSiuGtQm2TiK4acc+0nb3u1
 ea9ZdxXkNTWvQbOw+irmAExAd/oQ8AcS4wjiIeVlM9YDYPqt0mmMw8QsMfOZe2h/0wxIPhjQV
 bvXP8T462h/QbfN6jT8JPWVa9k9/cZ/1mNWaUT7Co6ge3o6w2/b5WHIksuagsLy+kGkf9H8MN
 kMl48YA6fGGYU5ptFrmK+EqZaTAXK3gpVoYIKPwkkt9/kf766UZGHHz45lc6tDYPdGaG9D3c 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284816>

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
