From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] setup_work_tree: adjust relative $GIT_WORK_TREE after moving cwd
Date: Sun, 26 Dec 2010 18:46:53 +0700
Message-ID: <1293364014-8463-1-git-send-email-pclouds@gmail.com>
References: <1293285457-11915-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 26 12:48:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWp5I-00084m-HK
	for gcvg-git-2@lo.gmane.org; Sun, 26 Dec 2010 12:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035Ab0LZLsP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Dec 2010 06:48:15 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:60058 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996Ab0LZLsN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Dec 2010 06:48:13 -0500
Received: by pxi15 with SMTP id 15so1526099pxi.19
        for <git@vger.kernel.org>; Sun, 26 Dec 2010 03:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=b0ZMR6HTRNlG+d5xtZ+/bZg04dvxVLRNE4LIM9P3YiU=;
        b=UuPsCp/Ww9GKDuAU4ryAXklc2uqbuGn2+SkKtrtNT97Rh/uyOPIPeBdggf0pEJqMRP
         0A7O07MA1EBmpkyXCdVE98SK5loncuz3fIjgn19J8wyz3ExlwuZd0+w7nmMJnCTzz8kq
         hUirgA0Zb4lfIFjXqjVtTuUZQ8mghX3l4BdbA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=kNS9J2Dvm9Fuxq7Az7dUTD9i6lf75oR0lXmcAmMm5ONVgq0rGKFSnppVmoLRH2YVHi
         3lSwPcCdw+3nDorYmDbrAkRjPq67OohvNkbvD7BBtTU4zCreIu4324G9YtBDRyvjbPPk
         hAE1oy92W9Cwr1us35tTpAFCFcvNPAt3pgJAc=
Received: by 10.142.49.10 with SMTP id w10mr9072613wfw.185.1293364091489;
        Sun, 26 Dec 2010 03:48:11 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.248.124])
        by mx.google.com with ESMTPS id e14sm15822084wfg.20.2010.12.26.03.48.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Dec 2010 03:48:10 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 26 Dec 2010 18:46:55 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
In-Reply-To: <1293285457-11915-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164191>

When setup_work_tree() is called, it moves cwd to $GIT_WORK_TREE and
makes internal copy of $GIT_WORK_TREE absolute. The environt variable,
if set by user, remains unchanged. If the variable is relative, it is
no longer correct because its base dir has changed.

Instead of making $GIT_WORK_TREE absolute too, we just say "." and let
subsequent git processes handle it.

Reported-by: Michel Briand <michelbriand@free.fr>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 This one is better, on top of master because the next one is on top
 of nd/setup.

 And I forgot to tell why I did not put the fault in real life [1]
 into tests: I don't like git-merge spawning another process just for
 resetting worktree. Sooner or later it should be replaced to use
 unpack_trees() directly. When that happens, the test would become
 invalid.

 [1] http://thread.gmane.org/gmane.comp.version-control.git/164066/focu=
s=3D164171

 .gitignore          |    1 +
 Makefile            |    1 +
 setup.c             |    8 ++++++++
 t/t1501-worktree.sh |   11 +++++++++++
 test-subprocess.c   |   21 +++++++++++++++++++++
 5 files changed, 42 insertions(+), 0 deletions(-)
 create mode 100644 test-subprocess.c

diff --git a/.gitignore b/.gitignore
index 87b833c..3dd6ef7 100644
--- a/.gitignore
+++ b/.gitignore
@@ -177,6 +177,7 @@
 /test-sha1
 /test-sigchain
 /test-string-pool
+/test-subprocess
 /test-svn-fe
 /test-treap
 /common-cmds.h
diff --git a/Makefile b/Makefile
index 57d9c65..bdf86a3 100644
--- a/Makefile
+++ b/Makefile
@@ -431,6 +431,7 @@ TEST_PROGRAMS_NEED_X +=3D test-run-command
 TEST_PROGRAMS_NEED_X +=3D test-sha1
 TEST_PROGRAMS_NEED_X +=3D test-sigchain
 TEST_PROGRAMS_NEED_X +=3D test-string-pool
+TEST_PROGRAMS_NEED_X +=3D test-subprocess
 TEST_PROGRAMS_NEED_X +=3D test-svn-fe
 TEST_PROGRAMS_NEED_X +=3D test-treap
 TEST_PROGRAMS_NEED_X +=3D test-index-version
diff --git a/setup.c b/setup.c
index 91887a4..3833569 100644
--- a/setup.c
+++ b/setup.c
@@ -239,6 +239,14 @@ void setup_work_tree(void)
 		git_dir =3D make_absolute_path(git_dir);
 	if (!work_tree || chdir(work_tree))
 		die("This operation must be run in a work tree");
+
+	/*
+	 * Make sure subsequent git processes find correct worktree
+	 * if $GIT_WORK_TREE is set relative
+	 */
+	if (getenv(GIT_WORK_TREE_ENVIRONMENT))
+		setenv(GIT_WORK_TREE_ENVIRONMENT, ".", 1);
+
 	set_git_dir(make_relative_path(git_dir, work_tree));
 	initialized =3D 1;
 }
diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index 2c8f01f..1f3b50d 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -340,4 +340,15 @@ test_expect_success 'make_relative_path handles do=
uble slashes in GIT_DIR' '
 	git --git-dir=3D"$(pwd)//repo.git" --work-tree=3D"$(pwd)" add dummy_f=
ile
 '
=20
+test_expect_success 'relative $GIT_WORK_TREE and git subprocesses' '
+	(
+	GIT_DIR=3Drepo.git &&
+	GIT_WORK_TREE=3Drepo.git/work &&
+	export GIT_DIR GIT_WORK_TREE &&
+	test-subprocess --setup-work-tree rev-parse --show-toplevel >actual &=
&
+	echo "`pwd`/repo.git/work" >expected &&
+	test_cmp expected actual
+	)
+'
+
 test_done
diff --git a/test-subprocess.c b/test-subprocess.c
new file mode 100644
index 0000000..667d3e5
--- /dev/null
+++ b/test-subprocess.c
@@ -0,0 +1,21 @@
+#include "cache.h"
+#include "run-command.h"
+
+int main(int argc, char **argv)
+{
+	const char *prefix;
+	struct child_process cp;
+	int nogit =3D 0;
+
+	prefix =3D setup_git_directory_gently(&nogit);
+	if (nogit)
+		die("No git repo found");
+	if (!strcmp(argv[1], "--setup-work-tree")) {
+		setup_work_tree();
+		argv++;
+	}
+	memset(&cp, 0, sizeof(cp));
+	cp.git_cmd =3D 1;
+	cp.argv =3D (const char **)argv+1;
+	return run_command(&cp);
+}
--=20
1.7.3.4.878.g439c7
