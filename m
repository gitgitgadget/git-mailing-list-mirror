From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 3/4] Provide a dirname() function when
 NO_LIBGEN_H=YesPlease
Date: Mon, 11 Jan 2016 19:30:00 +0100 (CET)
Message-ID: <0bab11634c8f05751b2ed5879bc4100441bba4b9.1452536924.git.johannes.schindelin@gmx.de>
References: <cover.1452270051.git.johannes.schindelin@gmx.de> <cover.1452536924.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 19:30:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIhEq-0008S0-9V
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 19:30:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933355AbcAKSaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 13:30:12 -0500
Received: from mout.gmx.net ([212.227.17.21]:63541 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933337AbcAKSaI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 13:30:08 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M3MAG-1a0tIH0hs0-00r1MK; Mon, 11 Jan 2016 19:30:01
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452536924.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:UfwdqZDC6RPkyGlF7nUqU4cEM30vmMMsOt8Uvvh3YCLYZTQD7bx
 gjsYBUUMiSVZUHbVJIIhXKIzvU7/3GUzNQ+iTl1wOtNFfSIpn6C/d7E67HDO6l1L1s1HXws
 O1XEzBUJG5NOI1JtFQtjBtlyag5qB9MF5pQK8XR2eHNuHDGzMcWzjG2XruXoQ0phgT6N+Ki
 faZ4v0fKvXkuYN98WMBXQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0vaTQ4boCwc=:i02lALcqaUgb2iA/laDXPS
 NnKzGhhuODDgvqK0JIUvDSbcysWbxp081vGpLe0RuZuryXF1HNYOveFH8FY6cF/yoXYk3PNFe
 kmcl5ic7+3OxJK+dDubXGyyobwBY97ozvW2SVtxnuG16BDxPTieqeNl4QhRKWq8RL8v68fY67
 Z3R61NyIEzKzEj7XIGAh/sFUHsB0bOXX3MN9VEYiKKXLe89OVDp8WE7BWSTj7iiPrQaIav5z0
 KDZ8YM8U9L7bK/UwPU1KeEd5K7R5hXXXQBBAuHjxDSGkIqQMARIZdet6gVpkAFtN5nmF55vUD
 PBQFX2gOlR9IvHIzd+dkxD3ZXSMcnb4qiIGeYYXLx5LI89vY4+LFS4tsYF1/gZOJG8gqatHrn
 z0S24G2LId0ffnsf548vB4/YJlZElKpr5kPwWJmZe7Y/xCiGZsTaYPMnvyqZ4QohpEgkHW6an
 ACWFUXrCIWedGSGvfbtN2GupEr1lWf1cDaqUx9qNoDU5aT7HwJqG3KbPXn7lswfzyKKJ7szrH
 k8mvPvHRd7dBxEe5kSYb06D+7AoiZajLEcb1EhQvDHM4DoLd4aZNzalM0zI6t9Jsmp4BLVJnc
 LsT+Jjsxombd67cSA0r41qXwvUfz3SpHAmZlToZQbyXrCouaGjnEV1MwA7LoSutx/Rm7eGDwi
 TFM/YxyTEy6842rHW9t1BgoA1j6pVseeDrBaHxqY6fq+E+A7f5wWVgAUGQgxTvmGcsVKkyxZ+
 BZHZYdchXHFjhEQgjKXdtuyRQi4J2jM7NPsoXMNT5fXpG0dg1fh0vP3OYwGDSJbJw+0sv16Y 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283694>

When there is no `libgen.h` to our disposal, we miss the `dirname()`
function.

So far, we only had one user of that function: credential-cache--daemon
(which was only compiled when Unix sockets are available, anyway). But
now we also have `builtin/am.c` as user, so we need it.

Since `dirname()` is a sibling of `basename()`, we simply put our very
own `gitdirname()` implementation next to `gitbasename()` and use it
if `NO_LIBGEN_H` has been set.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/basename.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 git-compat-util.h |  2 ++
 2 files changed, 46 insertions(+)

diff --git a/compat/basename.c b/compat/basename.c
index 0f1b0b0..0a2ed25 100644
--- a/compat/basename.c
+++ b/compat/basename.c
@@ -1,4 +1,5 @@
 #include "../git-compat-util.h"
+#include "../strbuf.h"
 
 /* Adapted from libiberty's basename.c.  */
 char *gitbasename (char *path)
@@ -25,3 +26,46 @@ char *gitbasename (char *path)
 	}
 	return (char *)base;
 }
+
+char *gitdirname(char *path)
+{
+	char *p = path, *slash = NULL, c;
+	int dos_drive_prefix;
+
+	if (!p)
+		return ".";
+
+	if ((dos_drive_prefix = skip_dos_drive_prefix(&p)) && !*p) {
+		static struct strbuf buf = STRBUF_INIT;
+
+dot:
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "%.*s.", dos_drive_prefix, path);
+		return buf.buf;
+	}
+
+	/*
+	 * POSIX.1-2001 says dirname("/") should return "/", and dirname("//")
+	 * should return "//", but dirname("///") should return "/" again.
+	 */
+	if (is_dir_sep(*p)) {
+		if (!p[1] || (is_dir_sep(p[1]) && !p[2]))
+			return path;
+		slash = ++p;
+	}
+	while ((c = *(p++)))
+		if (is_dir_sep(c)) {
+			char *tentative = p - 1;
+
+			/* POSIX.1-2001 says to ignore trailing slashes */
+			while (is_dir_sep(*p))
+				p++;
+			if (*p)
+				slash = tentative;
+		}
+
+	if (!slash)
+		goto dot;
+	*slash = '\0';
+	return path;
+}
diff --git a/git-compat-util.h b/git-compat-util.h
index 0d66f3a..94f311a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -253,6 +253,8 @@ struct itimerval {
 #else
 #define basename gitbasename
 extern char *gitbasename(char *);
+#define dirname gitdirname
+extern char *gitdirname(char *);
 #endif
 
 #ifndef NO_ICONV
-- 
2.6.3.windows.1.300.g1c25e49
