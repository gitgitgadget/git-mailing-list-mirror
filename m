From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 10/10] Makefile: add USE_WILDMATCH to use wildmatch as fnmatch
Date: Tue,  1 Jan 2013 09:44:11 +0700
Message-ID: <1357008251-10014-11-git-send-email-pclouds@gmail.com>
References: <1357008251-10014-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 01 03:45:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TprrG-0000gC-Jh
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 03:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918Ab3AACpU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Dec 2012 21:45:20 -0500
Received: from mail-pb0-f50.google.com ([209.85.160.50]:60017 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889Ab3AACpS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 21:45:18 -0500
Received: by mail-pb0-f50.google.com with SMTP id wz7so7259421pbc.37
        for <git@vger.kernel.org>; Mon, 31 Dec 2012 18:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=9EQqKPFc/ocDVxxb2DPQdytTAoMqBQXmMk/X//ESjcI=;
        b=zrBebeIaQtrUs89vioc1NK0q4BSCHfcyWaWjkjm9WwO558n/bpcCLC6lL1sSVwfCpb
         K+7lSapXJiSZ5nJRtiiR+HBFGrs9PcKnnMxBFNoSjBRaV+ZYlqKa7hbLgtYtUTSwbr+q
         NcAyaZzRXPX3T6c99Peoo/wjdz0561q4L+xHVVAT28efkcy8+t13d6PlCa0hFZ5TPUyt
         tn5/De5YPqY4xovUueLcCWPT7JmVE/az1HemzBxlm5LlwYQHlZURwBSlFxu187iRAZsG
         Fa1MNJ7vbu16Fk4wgohIO+DwcrEczHXii2ByDpcc7NaxVTAQZcPF9Boxi8lTbu8dSb3l
         nPHw==
X-Received: by 10.66.88.37 with SMTP id bd5mr125183986pab.75.1357008317954;
        Mon, 31 Dec 2012 18:45:17 -0800 (PST)
Received: from lanh ([115.74.57.25])
        by mx.google.com with ESMTPS id qb3sm25819250pbb.35.2012.12.31.18.45.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 31 Dec 2012 18:45:17 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 01 Jan 2013 09:45:21 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357008251-10014-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212393>

This is similar to NO_FNMATCH but it uses wildmatch instead of
compat/fnmatch. This is an intermediate step to let wildmatch be used
as fnmatch replacement for wider audience before it replaces fnmatch
completely and compat/fnmatch is removed.

fnmatch in test-wildmatch is not impacted by this and is the only
place that NO_FNMATCH or NO_FNMATCH_CASEFOLD remain active when
USE_WILDMATCH is set.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile          |  6 ++++++
 git-compat-util.h | 13 +++++++++++++
 test-wildmatch.c  |  3 +++
 3 files changed, 22 insertions(+)

diff --git a/Makefile b/Makefile
index bc868d1..24e2774 100644
--- a/Makefile
+++ b/Makefile
@@ -99,6 +99,9 @@ all::
 # Define NO_FNMATCH_CASEFOLD if your fnmatch function doesn't have the
 # FNM_CASEFOLD GNU extension.
 #
+# Define USE_WILDMATCH if you want to use Git's wildmatch
+# implementation as fnmatch
+#
 # Define NO_GECOS_IN_PWENT if you don't have pw_gecos in struct passwd
 # in the C library.
 #
@@ -1625,6 +1628,9 @@ ifdef NO_FNMATCH_CASEFOLD
 	COMPAT_OBJS +=3D compat/fnmatch/fnmatch.o
 endif
 endif
+ifdef USE_WILDMATCH
+	COMPAT_CFLAGS +=3D -DUSE_WILDMATCH
+endif
 ifdef NO_SETENV
 	COMPAT_CFLAGS +=3D -DNO_SETENV
 	COMPAT_OBJS +=3D compat/setenv.o
diff --git a/git-compat-util.h b/git-compat-util.h
index 02f48f6..b2c7638 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -106,7 +106,9 @@
 #include <sys/time.h>
 #include <time.h>
 #include <signal.h>
+#ifndef USE_WILDMATCH
 #include <fnmatch.h>
+#endif
 #include <assert.h>
 #include <regex.h>
 #include <utime.h>
@@ -238,6 +240,17 @@ extern char *gitbasename(char *);
=20
 #include "compat/bswap.h"
=20
+#ifdef USE_WILDMATCH
+#include "wildmatch.h"
+#define FNM_PATHNAME WM_PATHNAME
+#define FNM_CASEFOLD WM_CASEFOLD
+#define FNM_NOMATCH  WM_NOMATCH
+static inline int fnmatch(const char *pattern, const char *string, int=
 flags)
+{
+	return wildmatch(pattern, string, flags, NULL);
+}
+#endif
+
 /* General helper functions */
 extern void vreportf(const char *prefix, const char *err, va_list para=
ms);
 extern void vwritef(int fd, const char *prefix, const char *err, va_li=
st params);
diff --git a/test-wildmatch.c b/test-wildmatch.c
index ac86800..a3e2643 100644
--- a/test-wildmatch.c
+++ b/test-wildmatch.c
@@ -1,3 +1,6 @@
+#ifdef USE_WILDMATCH
+#undef USE_WILDMATCH  /* We need real fnmatch implementation here */
+#endif
 #include "cache.h"
 #include "wildmatch.h"
=20
--=20
1.8.0.rc2.23.g1fb49df
