From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: [PATCH] Make git-check-format-ref a builtin.
Date: Thu, 18 May 2006 14:15:55 +0200
Organization: Chalmers
Message-ID: <446C657B.7020100@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 18 14:16:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FghQI-0005Yl-03
	for gcvg-git@gmane.org; Thu, 18 May 2006 14:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWERMQE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 18 May 2006 08:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWERMQE
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 08:16:04 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:39080 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1751190AbWERMQC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 May 2006 08:16:02 -0400
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout2-sn1.fre.skanova.net (7.2.072.1)
        id 446C456E00012B68; Thu, 18 May 2006 14:15:58 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.2) Gecko/20060501 Thunderbird/1.5.0.2 Mnenhy/0.7.4.666
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20283>


Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>

---
It was already written in C, but now it's 219k less in my ~/bin dir.

 Makefile                   |    4 ++--
 builtin-check-ref-format.c |   13 +++++++++++++
 builtin.h                  |    2 ++
 git.c                      |    1 +
 4 files changed, 18 insertions(+), 2 deletions(-)
 create mode 100644 builtin-check-ref-format.c

2e18872b12d1635a6814053f3cfc3c9e433db428
diff --git a/Makefile b/Makefile
index 3a28580..b737cb8 100644
--- a/Makefile
+++ b/Makefile
@@ -170,7 +170,7 @@ PROGRAMS =3D \
=20
 BUILT_INS =3D git-log$X git-whatchanged$X git-show$X \
 	git-count-objects$X git-diff$X git-push$X \
-	git-grep$X git-add$X
+	git-grep$X git-add$X git-check-ref-format$X
=20
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS =3D $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
@@ -218,7 +218,7 @@ LIB_OBJS =3D \
=20
 BUILTIN_OBJS =3D \
 	builtin-log.o builtin-help.o builtin-count.o builtin-diff.o builtin-p=
ush.o \
-	builtin-grep.o builtin-add.o
+	builtin-grep.o builtin-add.o builtin-check-ref-format.o
=20
 GITLIBS =3D $(LIB_FILE) $(XDIFF_LIB)
 LIBS =3D $(GITLIBS) -lz
diff --git a/builtin-check-ref-format.c b/builtin-check-ref-format.c
new file mode 100644
index 0000000..ac29383
--- /dev/null
+++ b/builtin-check-ref-format.c
@@ -0,0 +1,13 @@
+/*
+ * GIT - The information manager from hell
+ */
+
+#include "cache.h"
+#include "refs.h"
+
+int cmd_check_ref_format(int argc, const char **argv, char **envp)
+{
+	if (argc !=3D 2)
+		usage("git check-ref-format refname");
+	return check_ref_format(argv[1]) =3D=3D 0 ? 0 : 1;
+}
diff --git a/builtin.h b/builtin.h
index ccd0e31..a26f2c2 100644
--- a/builtin.h
+++ b/builtin.h
@@ -27,4 +27,6 @@ extern int cmd_push(int argc, const char
 extern int cmd_grep(int argc, const char **argv, char **envp);
 extern int cmd_add(int argc, const char **argv, char **envp);
=20
+extern int cmd_check_ref_format(int argc, const char **argv, char **en=
vp);
+
 #endif
diff --git a/git.c b/git.c
index 6a470cf..62baf25 100644
--- a/git.c
+++ b/git.c
@@ -52,6 +52,7 @@ static void handle_internal_command(int=20
 		{ "diff", cmd_diff },
 		{ "grep", cmd_grep },
 		{ "add", cmd_add },
+		{ "check-ref-format", cmd_check_ref_format }
 	};
 	int i;
=20
--=20
1.3.2.g3c45-dirty
