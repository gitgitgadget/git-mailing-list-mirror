From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 5/5] strbuf: remove prefixcmp() and suffixcmp()
Date: Sun, 01 Dec 2013 08:49:18 +0100
Message-ID: <20131201074919.3042.68588.chriscool@tuxfamily.org>
References: <20131201074818.3042.57357.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Antoine Pelisse <apelisse@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Max Horn <max@quendi.de>,
	Andreas Ericsson <ae@op5.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 01 08:50:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vn1nr-0004Pp-1I
	for gcvg-git-2@plane.gmane.org; Sun, 01 Dec 2013 08:50:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387Ab3LAHuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Dec 2013 02:50:52 -0500
Received: from [194.158.98.45] ([194.158.98.45]:35570 "EHLO mail-3y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751058Ab3LAHub (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Dec 2013 02:50:31 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 7163A2BE;
	Sun,  1 Dec 2013 08:50:10 +0100 (CET)
X-git-sha1: 9ebdc9c9ae4bdf94d74fe7cd171fcd0ebeda55db 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131201074818.3042.57357.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238582>

As starts_with() and ends_with() have been used to
replace prefixcmp() and suffixcmp() respectively,
we can now remove them.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-compat-util.h |  2 --
 strbuf.c          | 18 ------------------
 2 files changed, 20 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index b73916b..c4c01e7 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -351,9 +351,7 @@ extern void set_error_routine(void (*routine)(const char *err, va_list params));
 extern void set_die_is_recursing_routine(int (*routine)(void));
 
 extern int starts_with(const char *str, const char *prefix);
-extern int prefixcmp(const char *str, const char *prefix);
 extern int ends_with(const char *str, const char *suffix);
-extern int suffixcmp(const char *str, const char *suffix);
 
 static inline const char *skip_prefix(const char *str, const char *prefix)
 {
diff --git a/strbuf.c b/strbuf.c
index 83caf4a..ee96dcf 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -10,15 +10,6 @@ int starts_with(const char *str, const char *prefix)
 			return 0;
 }
 
-int prefixcmp(const char *str, const char *prefix)
-{
-	for (; ; str++, prefix++)
-		if (!*prefix)
-			return 0;
-		else if (*str != *prefix)
-			return (unsigned char)*prefix - (unsigned char)*str;
-}
-
 int ends_with(const char *str, const char *suffix)
 {
 	int len = strlen(str), suflen = strlen(suffix);
@@ -28,15 +19,6 @@ int ends_with(const char *str, const char *suffix)
 		return !strcmp(str + len - suflen, suffix);
 }
 
-int suffixcmp(const char *str, const char *suffix)
-{
-	int len = strlen(str), suflen = strlen(suffix);
-	if (len < suflen)
-		return -1;
-	else
-		return strcmp(str + len - suflen, suffix);
-}
-
 /*
  * Used as the default ->buf value, so that people can always assume
  * buf is non NULL and ->buf is NUL terminated even for a freshly
-- 
1.8.4.1.561.g12affca
