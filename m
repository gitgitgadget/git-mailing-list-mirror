From: Thiago Farina <tfransosi@gmail.com>
Subject: [Patch v2] help.c: Pull cmd_version out of this file.
Date: Wed,  1 Sep 2010 00:10:32 -0300
Message-ID: <dc636803969cfa958d76ec2461ebdbe79b335ee3.1283310520.git.tfransosi@gmail.com>
Cc: jrnieder@gmail.com, gitster@pobox.com, pclouds@gmail.com,
	Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 01 05:11:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oqdj9-0000Lc-BE
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 05:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744Ab0IADKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 23:10:51 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49554 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828Ab0IADKu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 23:10:50 -0400
Received: by gyd8 with SMTP id 8so2823680gyd.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 20:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=9Z5HDAECNPfaQ8uwgVsF3NdrD2Unst52/oMLHxp7Vpc=;
        b=pyivMhfUbJk2E9KVOu5jeZvYVixSr+IaTvyFi6E2jC3kn8ZVVx8SZP/WbPO8h9SKTS
         cBxmB5l0hh402mh27sIrEL52HWLxgtx65uM3kdYocTchRwwTMz3tOw0zQNokhcaPTyrv
         07sxB0O8M0XfGgYKKgI544xRWjMFHHPzH0sgs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=SBGoGzR3BsJ1mymV4mCgHpSrKZj5VDAIPXDZjN764nZ3owmVAxR7XGSQCTZHBD0PEL
         la4wRKT1cgB3KXpB5EjHc/fj/C4NdYaxW5j+lbl6qIMum0BekTWM1sVl6kzZNZXwuDNj
         e/+fIk5d8GQLJTkwnvGTsDJ3Wy6woug50h2po=
Received: by 10.150.58.5 with SMTP id g5mr245799yba.340.1283310648043;
        Tue, 31 Aug 2010 20:10:48 -0700 (PDT)
Received: from localhost ([186.205.0.204])
        by mx.google.com with ESMTPS id f6sm273443yba.7.2010.08.31.20.10.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 20:10:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.95.g3d045
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155009>

Promote cmd_version to a builtin, by moving it to its own file
in builtin/version.c

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 .gitignore        |    1 +
 Makefile          |    1 +
 builtin/version.c |    7 +++++++
 help.c            |    6 ------
 4 files changed, 9 insertions(+), 6 deletions(-)
 create mode 100644 builtin/version.c

diff --git a/.gitignore b/.gitignore
index fcdd822..5bdddc4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -151,6 +151,7 @@
 /git-var
 /git-verify-pack
 /git-verify-tag
+/git-version
 /git-web--browse
 /git-whatchanged
 /git-write-tree
diff --git a/Makefile b/Makefile
index b4745a5..0f3b6d8 100644
--- a/Makefile
+++ b/Makefile
@@ -738,6 +738,7 @@ BUILTIN_OBJS += builtin/upload-archive.o
 BUILTIN_OBJS += builtin/var.o
 BUILTIN_OBJS += builtin/verify-pack.o
 BUILTIN_OBJS += builtin/verify-tag.o
+BUILTIN_OBJS += builtin/version.o
 BUILTIN_OBJS += builtin/write-tree.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
diff --git a/builtin/version.c b/builtin/version.c
new file mode 100644
index 0000000..d98e260
--- /dev/null
+++ b/builtin/version.c
@@ -0,0 +1,7 @@
+#include "builtin.h"
+
+int cmd_version(int argc, const char **argv, const char *prefix)
+{
+	printf("git version %s\n", git_version_string);
+	return 0;
+}
diff --git a/help.c b/help.c
index 7f4928e..ad4f923 100644
--- a/help.c
+++ b/help.c
@@ -362,9 +362,3 @@ const char *help_unknown_cmd(const char *cmd)
 
 	exit(1);
 }
-
-int cmd_version(int argc, const char **argv, const char *prefix)
-{
-	printf("git version %s\n", git_version_string);
-	return 0;
-}
-- 
1.7.2.1.95.g3d045
