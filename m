From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/3] Build an svn-fi target in contrib/svn-fe
Date: Sat, 15 Jan 2011 12:21:12 +0530
Message-ID: <1295074272-19559-4-git-send-email-artagnon@gmail.com>
References: <1295074272-19559-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 15 07:51:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdzyV-0006Ei-Jh
	for gcvg-git-2@lo.gmane.org; Sat, 15 Jan 2011 07:50:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085Ab1AOGus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jan 2011 01:50:48 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56481 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059Ab1AOGuo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jan 2011 01:50:44 -0500
Received: by mail-iw0-f174.google.com with SMTP id 9so3205802iwn.19
        for <git@vger.kernel.org>; Fri, 14 Jan 2011 22:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=cLbMJ8ynFcSuzkRchB9lDX2Q7anUJyTuLnMZJvsMwuY=;
        b=tssOqIhbbWnOOWz+x+Rd/iDiio4lTzRhsljE60uDELNMfwGzC0gC9rxj+t9fpFoIdn
         Ny0uBy3j3j05IKUoSOEdryaVBYve+2EazFSojtZl4VZ8IzSMTdGfxoCJrco8OF/4OCOw
         xJaS6PtffLlpf9nCGTv3CaCfvkm70E2+R0nYI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bL0mgxYucucisE1A8LS8KIr/SFJI9z0KwHboq/QpC6ooRKFgkvGzypxxnVU7iP73Ir
         Wp+Y4hy9n+9wbN+Cf48pnJsX2ZyRuJA2J3rEMdh5kn03l9XKmWG4j9fVklrybvOfcPGv
         1kYwZ3BrUsCUW58Np42aE6Ai63HxOC1NcaB9A=
Received: by 10.42.229.1 with SMTP id jg1mr1812798icb.374.1295074244276;
        Fri, 14 Jan 2011 22:50:44 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id k38sm1484334ick.9.2011.01.14.22.50.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 Jan 2011 22:50:43 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1295074272-19559-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165137>

Build an svn-fi target for testing the dumpfile producer in vcs-svn/.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/svn-fe/Makefile   |   23 +++++++++++++++++++++--
 contrib/svn-fe/svn-fi.c   |   16 ++++++++++++++++
 contrib/svn-fe/svn-fi.txt |   28 ++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 2 deletions(-)
 create mode 100644 contrib/svn-fe/svn-fi.c
 create mode 100644 contrib/svn-fe/svn-fi.txt

diff --git a/contrib/svn-fe/Makefile b/contrib/svn-fe/Makefile
index 360d8da..555a8ff 100644
--- a/contrib/svn-fe/Makefile
+++ b/contrib/svn-fe/Makefile
@@ -37,7 +37,7 @@ svn-fe$X: svn-fe.o $(VCSSVN_LIB) $(GIT_LIB)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ svn-fe.o \
 		$(ALL_LDFLAGS) $(LIBS)
 
-svn-fe.o: svn-fe.c ../../vcs-svn/svndump.h
+svn-fe.o: svn-fe.c ../../vcs-svn/svnload.h
 	$(QUIET_CC)$(CC) -I../../vcs-svn -o $*.o -c $(ALL_CFLAGS) $<
 
 svn-fe.html: svn-fe.txt
@@ -51,6 +51,24 @@ svn-fe.1: svn-fe.txt
 		../contrib/svn-fe/$@
 	$(MV) ../../Documentation/svn-fe.1 .
 
+svn-fi$X: svn-fi.o $(VCSSVN_LIB) $(GIT_LIB)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ svn-fi.o \
+		$(ALL_LDFLAGS) $(LIBS)
+
+svn-fi.o: svn-fi.c ../../vcs-svn/svnload.h
+	$(QUIET_CC)$(CC) -I../../vcs-svn -o $*.o -c $(ALL_CFLAGS) $<
+
+svn-fi.html: svn-fi.txt
+	$(QUIET_SUBDIR0)../../Documentation $(QUIET_SUBDIR1) \
+		MAN_TXT=../contrib/svn-fe/svn-fi.txt \
+		../contrib/svn-fe/$@
+
+svn-fi.1: svn-fi.txt
+	$(QUIET_SUBDIR0)../../Documentation $(QUIET_SUBDIR1) \
+		MAN_TXT=../contrib/svn-fe/svn-fi.txt \
+		../contrib/svn-fe/$@
+	$(MV) ../../Documentation/svn-fi.1 .
+
 ../../vcs-svn/lib.a: FORCE
 	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) vcs-svn/lib.a
 
@@ -58,6 +76,7 @@ svn-fe.1: svn-fe.txt
 	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) libgit.a
 
 clean:
-	$(RM) svn-fe$X svn-fe.o svn-fe.html svn-fe.xml svn-fe.1
+	$(RM) svn-fe$X svn-fe.o svn-fe.html svn-fe.xml svn-fe.1 \
+	svn-fi$X svn-fi.o svn-fi.html svn-fi.xml svn-fi.1
 
 .PHONY: all clean FORCE
diff --git a/contrib/svn-fe/svn-fi.c b/contrib/svn-fe/svn-fi.c
new file mode 100644
index 0000000..81347b0
--- /dev/null
+++ b/contrib/svn-fe/svn-fi.c
@@ -0,0 +1,16 @@
+/*
+ * This file is in the public domain.
+ * You may freely use, modify, distribute, and relicense it.
+ */
+
+#include <stdlib.h>
+#include "svnload.h"
+
+int main(int argc, char **argv)
+{
+	if (svnload_init(NULL))
+		return 1;
+	svnload_read();
+	svnload_deinit();
+	return 0;
+}
diff --git a/contrib/svn-fe/svn-fi.txt b/contrib/svn-fe/svn-fi.txt
new file mode 100644
index 0000000..996a175
--- /dev/null
+++ b/contrib/svn-fe/svn-fi.txt
@@ -0,0 +1,28 @@
+svn-fe(1)
+=========
+
+NAME
+----
+svn-fi - convert fast-import stream to an SVN "dumpfile"
+
+SYNOPSIS
+--------
+[verse]
+svn-fi
+
+DESCRIPTION
+-----------
+
+Converts a git-fast-import(1) stream into a Subversion dumpfile.
+
+INPUT FORMAT
+-------------
+The fast-import format is documented by the git-fast-import(1)
+manual page.
+
+OUTPUT FORMAT
+------------
+Subversion's repository dump format is documented in full in
+`notes/dump-load-format.txt` from the Subversion source tree.
+Files in this format can be generated using the 'svnadmin dump' or
+'svk admin dump' command.
-- 
1.7.4.rc1.7.g2cf08.dirty
