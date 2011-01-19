From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/5] Build an svn-fi target in contrib/svn-fe
Date: Wed, 19 Jan 2011 11:14:57 +0530
Message-ID: <1295415899-1192-4-git-send-email-artagnon@gmail.com>
References: <1295415899-1192-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 19 06:44:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfQqX-0001OM-OQ
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 06:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429Ab1ASFo0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 00:44:26 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52990 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120Ab1ASFoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 00:44:25 -0500
Received: by mail-gw0-f46.google.com with SMTP id 20so126197gwj.19
        for <git@vger.kernel.org>; Tue, 18 Jan 2011 21:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=cLbMJ8ynFcSuzkRchB9lDX2Q7anUJyTuLnMZJvsMwuY=;
        b=f5KNbYXD/BqmVoYvzlWpt+jQ0HGzLPjY6zbS0Ky0yZggJfv/6KnHZ+58fWN/fYhoov
         4BnuahZDCfKA8h5GL9AgKG4N1utzHPVUsf1NjsUlzWHzpef9EQlcW4uMfG8JfQS8fKoL
         NTEBd36ILmhVwbVXpVSC68HQevVujfRRdvonk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uLPnjL76rboaiI54UPE2yh1LfnJK2sr1mH+cf5I945kSfxzftClBEfNp3QAEeNe3y1
         7ttX73x4+fPRWH6T9C4xYgl3gyia5myTYBO3ULO7+UxRw/51NJKLZPe+R5V8P5c+IIMd
         ocnr+/ZhOWFUO0UcQFMXLxfPqREdlyFDhk6+U=
Received: by 10.100.212.3 with SMTP id k3mr196565ang.84.1295415864880;
        Tue, 18 Jan 2011 21:44:24 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id d15sm7968646ana.35.2011.01.18.21.44.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 18 Jan 2011 21:44:24 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1295415899-1192-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165240>

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
