From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 4/5] Integrate wildmatch to git
Date: Sun, 16 Sep 2012 22:27:44 +0700
Message-ID: <1347809265-2457-5-git-send-email-pclouds@gmail.com>
References: <1347710524-15404-1-git-send-email-pclouds@gmail.com>
 <1347809265-2457-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 16 17:28:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDGln-0004Aq-3f
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 17:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302Ab2IPP2J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Sep 2012 11:28:09 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:48435 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389Ab2IPP2G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 11:28:06 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so352787dad.19
        for <git@vger.kernel.org>; Sun, 16 Sep 2012 08:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=aFdqEG1lKZDfSmd9RsFfji2uup8lyMgV5MbDuGpsPZ8=;
        b=nEBiXuy/NcyciRKM6f6hlApIN0pACToRCyasS0IQ8KVuf6DuQJdBQm4rDv8y0VSQY6
         W0BZzdEf40XzEOKr8phrXx5dw3vYjkRsphlk3D29syrZFqfQk4wr29G4ggY2hnpR/BsY
         CHDOqe8hwD9IrZ39SsSgTWl0GzATXprkVaoj2e+V20YVy/6kMcS3v47XczQmIEXh1DYg
         RsWMtjW7hqNEXcifABLW8OTRCwNqiL9kDx3JJQzGhpcQeC2HQQnKM0VgbkU7HmDl7SV7
         +3myOSYIIY8Zh8fkGcmgiNPd81w1rvQTDJvHJwQdxt7OZHTZ/tX8pBew+5EZM1SPMMQq
         MweQ==
Received: by 10.66.87.66 with SMTP id v2mr14676677paz.71.1347809286085;
        Sun, 16 Sep 2012 08:28:06 -0700 (PDT)
Received: from lanh ([115.74.50.93])
        by mx.google.com with ESMTPS id hr1sm5207239pbc.23.2012.09.16.08.28.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 16 Sep 2012 08:28:05 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 16 Sep 2012 22:28:09 +0700
X-Mailer: git-send-email 1.7.12.403.gce5cf6f.dirty
In-Reply-To: <1347809265-2457-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205623>

This makes wildmatch.c part of libgit.a and builds test-wildmatch

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 .gitignore           |  1 +
 Makefile             |  6 ++++++
 t/t3070-wildmatch.sh | 27 +++++++++++++++++++++++++++
 test-wildmatch.c     |  8 +++++++-
 wildmatch.c          |  8 +++++++-
 5 files changed, 48 insertions(+), 2 deletions(-)
 create mode 100755 t/t3070-wildmatch.sh

diff --git a/.gitignore b/.gitignore
index 68fe464..54b1b3b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -196,6 +196,7 @@
 /test-sigchain
 /test-subprocess
 /test-svn-fe
+/test-wildmatch
 /common-cmds.h
 *.tar.gz
 *.dsc
diff --git a/Makefile b/Makefile
index 56301dc..745e88c 100644
--- a/Makefile
+++ b/Makefile
@@ -511,6 +511,7 @@ TEST_PROGRAMS_NEED_X +=3D test-sha1
 TEST_PROGRAMS_NEED_X +=3D test-sigchain
 TEST_PROGRAMS_NEED_X +=3D test-subprocess
 TEST_PROGRAMS_NEED_X +=3D test-svn-fe
+TEST_PROGRAMS_NEED_X +=3D test-wildmatch
=20
 TEST_PROGRAMS =3D $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
=20
@@ -683,6 +684,7 @@ LIB_H +=3D userdiff.h
 LIB_H +=3D utf8.h
 LIB_H +=3D varint.h
 LIB_H +=3D walker.h
+LIB_H +=3D wildmatch.h
 LIB_H +=3D wt-status.h
 LIB_H +=3D xdiff-interface.h
 LIB_H +=3D xdiff/xdiff.h
@@ -814,6 +816,7 @@ LIB_OBJS +=3D utf8.o
 LIB_OBJS +=3D varint.o
 LIB_OBJS +=3D version.o
 LIB_OBJS +=3D walker.o
+LIB_OBJS +=3D wildmatch.o
 LIB_OBJS +=3D wrapper.o
 LIB_OBJS +=3D write_or_die.o
 LIB_OBJS +=3D ws.o
@@ -2586,6 +2589,9 @@ test-svn-fe$X: vcs-svn/lib.a
 test-%$X: test-%.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
) $(filter %.a,$^) $(LIBS)
=20
+test-wildmatch$X: test-wildmatch.o GIT-LDFLAGS
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
) -lpopt
+
 check-sha1:: test-sha1$X
 	./test-sha1.sh
=20
diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
new file mode 100755
index 0000000..7fb63ff
--- /dev/null
+++ b/t/t3070-wildmatch.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+
+test_description=3D'wildmatch tests'
+
+. ./test-lib.sh
+
+test_wildmatch() {
+    test_expect_success "wildmatch $*" "
+	test-wildmatch $* ../t3070-wildmatch/wildtest.txt >actual &&
+	echo 'No wildmatch errors found.' >expected &&
+	test_cmp expected actual
+    "
+}
+
+test_wildmatch -x1
+test_wildmatch -x1 -e1
+test_wildmatch -x1 -else
+test_wildmatch -x2
+test_wildmatch -x2 -ese
+test_wildmatch -x3
+test_wildmatch -x3 -e1
+test_wildmatch -x4
+test_wildmatch -x4 -e2e
+test_wildmatch -x5
+test_wildmatch -x5 -es
+
+test_done
diff --git a/test-wildmatch.c b/test-wildmatch.c
index 88585c2..828188a 100644
--- a/test-wildmatch.c
+++ b/test-wildmatch.c
@@ -20,7 +20,13 @@
 /*#define COMPARE_WITH_FNMATCH*/
=20
 #define WILD_TEST_ITERATIONS
-#include "lib/wildmatch.c"
+#include "wildmatch.c"
+
+#define MAXPATHLEN 1024
+#ifdef NO_STRLCPY
+#include "compat/strlcpy.c"
+#define strlcpy gitstrlcpy
+#endif
=20
 #include <popt.h>
=20
diff --git a/wildmatch.c b/wildmatch.c
index c7f7f9f..625cb0c 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -9,7 +9,13 @@
 **  work differently than '*', and to fix the character-class code.
 */
=20
-#include "rsync.h"
+#include <stddef.h>
+#include <ctype.h>
+#include <string.h>
+
+#include "wildmatch.h"
+
+typedef unsigned char uchar;
=20
 /* What character marks an inverted character class? */
 #define NEGATE_CLASS	'!'
--=20
1.7.12.403.gce5cf6f.dirty
