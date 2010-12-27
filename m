From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] setup_work_tree: adjust relative $GIT_WORK_TREE after moving cwd
Date: Mon, 27 Dec 2010 08:26:04 +0700
Message-ID: <1293413164-14684-1-git-send-email-pclouds@gmail.com>
References: <1293364014-8463-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 27 02:30:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PX1uS-0007O3-S9
	for gcvg-git-2@lo.gmane.org; Mon, 27 Dec 2010 02:30:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258Ab0L0B1X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Dec 2010 20:27:23 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:65261 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171Ab0L0B1W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Dec 2010 20:27:22 -0500
Received: by pwj3 with SMTP id 3so846060pwj.19
        for <git@vger.kernel.org>; Sun, 26 Dec 2010 17:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=lqX1al4TdSGu0QnlUkSznSEBVJjW21DPxkR11jYdtVM=;
        b=Y01ApJ2aVGpC4AOlyD6s4waYjhlXwdL+wD1qzXWRNg8Ey/6fx8OO4H0CyA87wkF2U5
         U7HSV/sxfW+3S2yuGx+xcwVaCxICMZJf0hHEM3hh1rqmtQbJDPHfFcNjlImXVagG+7xZ
         G5SBCmPZYeElsEs6mfF/QekHc4X/wQ6jikm9g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=SVtbXamTAkZvi6pCR4ANkw4hATSpuDs79ZifMdt9xnqQSOFsqVDv0Kb1N/JPcwhYdA
         Ec77kHAS5vmZoxUyvjB8radSViRVaMKi1+NJo2ACxMSaBBbj9Xzy+8NrBVk14z0ph8Fh
         JQFI9Em3YxI9gXa3G/J8UbSP45p3YKFWaLAhc=
Received: by 10.142.148.18 with SMTP id v18mr9573266wfd.209.1293413241423;
        Sun, 26 Dec 2010 17:27:21 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.248.124])
        by mx.google.com with ESMTPS id x18sm16917943wfa.23.2010.12.26.17.27.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Dec 2010 17:27:20 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 27 Dec 2010 08:26:05 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
In-Reply-To: <1293364014-8463-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164207>

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
 Third round. Remove subshell and `pwd` in t1501.31

 .gitignore          |    1 +
 Makefile            |    1 +
 setup.c             |    8 ++++++++
 t/t1501-worktree.sh |    7 +++++++
 test-subprocess.c   |   21 +++++++++++++++++++++
 5 files changed, 38 insertions(+), 0 deletions(-)
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
index 2c8f01f..f072a8e 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -340,4 +340,11 @@ test_expect_success 'make_relative_path handles do=
uble slashes in GIT_DIR' '
 	git --git-dir=3D"$(pwd)//repo.git" --work-tree=3D"$(pwd)" add dummy_f=
ile
 '
=20
+test_expect_success 'relative $GIT_WORK_TREE and git subprocesses' '
+	GIT_DIR=3Drepo.git GIT_WORK_TREE=3Drepo.git/work \
+	test-subprocess --setup-work-tree rev-parse --show-toplevel >actual &=
&
+	echo "$TRASH_DIRECTORY/repo.git/work" >expected &&
+	test_cmp expected actual
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
