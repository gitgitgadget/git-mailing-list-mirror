From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 3/4] Provide a dirname() function when
 NO_LIBGEN_H=YesPlease
Date: Fri, 8 Jan 2016 17:21:18 +0100 (CET)
Message-ID: <4e1b6c602e0adccfc11152b00aa23d14b1bbd4a8.1452270051.git.johannes.schindelin@gmx.de>
References: <25a2598e756959f55f06ae6b4dc6f448e3b6b127.1443624188.git.johannes.schindelin@gmx.de> <cover.1452270051.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 17:21:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHZnG-00076w-EA
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 17:21:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755877AbcAHQV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 11:21:28 -0500
Received: from mout.gmx.net ([212.227.17.22]:58913 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755450AbcAHQVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 11:21:25 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MGzwE-1aUD5p2fq6-00Dmlf; Fri, 08 Jan 2016 17:21:19
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452270051.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:hGmF4p2Rx9DyIIckNpJAljI4UCSFjVeyVdRaHAmZ2a39lAOuJnO
 64udKMqoTQ5zthfGJzNCMBcdfW4aTeP+SAchs6HqUvnbRMh3ZF6w2nJwlZTXOoehUclUT5m
 XNHiA+njLabbRMET9joqTWffxD3Pyu2Xy/TAnD8AQ6UPonHuPg9fL9sXWGnp2c0t61yEkI6
 ar8VwXtSdkHlJIiNYG9UQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Oc4sB/xaZiM=:IRjhPOs9ipu5CozGhhQ/Kl
 BG8PbBK8LiR8wzX7c4KmF9nk4qUxQZth7MkawmRdE6aodvZCnIxV1K3ES3fXr8UT5egrUBnrT
 D4jOcHDSK7O8WCicO//FEZZhyzKWKsMtOF25VKkD5ORD65dUPVmpP2FN23qfcehsofQm+aD4q
 L8Mm8/hlE1f62uayVRrPLJwQbdK7+iUxczP/4jUZNo0EOkkNMe8oCIZ1o1i3MOBklRyf8fHLB
 XyiNgetrHsVVi04mflinE4LnJQRNUukQheHabVp56B8VKN4UEVv38Nn5ExWEP88UJxfPmotFT
 PMd7/gRzijRSRx3986ytKlsh2MJxi3C/IbeVOPXFGca95NW4etCsHLiAsVS39WRbq276u2qah
 qPzzCDV2ThMya/t10QJpqTGdIOqbASbwQ2RG5y3UdlzdJAp1NIDUiN92QkVyG3+yXEUn+3Hl6
 NT70uFTN/d099h6aze3+Jkf3wB0bWwVxkHnCbOLN1sl6OILk+OKRWBMdjgAEAWMlxH91F4uWW
 PgPfoNj3J1wKtd5qFq+4LKVfvqJeBMyJrvrsjJO7Cz5qE7oIdCj+hO9+lOLsTSxzVnBNnvsRR
 avp4MmxAsH3x+R1oR1QR2XulPgtuRer5+YXBbZ72sDfP+WLFlIsyb1kqgJDZXC/8ND2HMK4oI
 I+G/qLJSQil/+77dqd+XR1sOq1MilbgJVbvazk9FNQE6lP6zsQ2Is4xERqMKxaI0QG8UWSbBD
 eX/iFSIllAVisfhLGPBO3LwI7PTlYqdExkKQh4VUlazLja8mBMgZMYe2sEDEiKouLtM9rLfG 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283564>

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
