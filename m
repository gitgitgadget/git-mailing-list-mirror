From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 08/19] mingw: fix t5601-clone.sh
Date: Tue, 26 Jan 2016 15:34:57 +0100 (CET)
Message-ID: <88657a291f8c0c2d5acdf88bcfeb32c87cf443c9.1453818790.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <cover.1453818789.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 15:35:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO4ig-0004vz-VS
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 15:35:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966295AbcAZOfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 09:35:06 -0500
Received: from mout.gmx.net ([212.227.17.20]:51977 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966135AbcAZOfA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 09:35:00 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M7DVi-1a9Amd3YUY-00x3gU; Tue, 26 Jan 2016 15:34:57
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453818789.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:uEfEkrvRxCarwzCx7j++p5CHlnBM0NSJrMgyLvncsiymZHX8Skx
 16+IptP7Q76pSV9QxPnVXBmjttiaIgGB9QLIw65sOJmOI32OUJvg5EcRegPq2tdjEBa+FE3
 VR6P+aO/6GOXbmIpyWyIXmu0pL15E9Rvt4Pu19PQZPA2GG7T8GxKi68j50ceRByEAplalyS
 3rd5pHilgf0Ltb8j44Y8w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:t/qPNek1pb0=:9Yfhavr5ect7bA/HLNrLGv
 Cw26A2aFgrO6oMqfrcArgDv56CBdA5Ysp+Xd3FqJ7gMl4E6wBcpN1TYI7LW2YEhQbrmzdGSiq
 z4z1+rkby1morUANBmToNuDRTqxqyEP55ihCEzKUJXbJGgeddLWvOfwO/t4/8xavLtHi5leTw
 0/7XHuPqla29tXrpviZ8HvVZbtvBbkoQ4gFdk+ugil01BNzmYxWLu/IkgYra/xuDwG+hOsRF9
 CMu1L4Rb+DmaWoKPDc2vBSiH3w6juAJ3U29hG/eSPvBFzs7gLPh93224jdmZggEyvnDE+8u6n
 IR14GKkPi2XFL3pXLGV7ItlGHOFCmkrSl+BjZZ44AP0zCG4QgBkZ5asTW9V8xlhr63Dj3mpSX
 hfaF4Mw4R7w3YPunu3naWXJhIGfCEnzyc3kT1GqLBAIhSFhRns54NilQ0aOENI86DQLb2KePr
 4MrD8UldCnOOWlO9rmjBuwrqH4OzYsn+isgGBEm/dcyHkZRvbVSg95y9j0f0OzIP9mBgGC0MB
 nnD7Ag+0/f5IcG/aZhUN58T7BJGGCeQAfh2I9KxcENVig3Tk8dEJYl4OE3HE0L0TKdjFex/fO
 gTI9cbpUsjUiT/0Yzalw4U+nLAE2BHZgh1fwujYMh3L2PCSEZMoy+I0QB6C4BZZevoXzm5+jW
 LCSGm90Gj7XkX8S9trJuZPz7vKb73XLrE7QU2zDQMSgD6DX/y/aY3lEkI1qbA1YQ1qRjku7X0
 G+EwBl8qG7ad9FXezoA0GglgcoefXgWJb5DHi7Ru4GYf6yTgm7/FxR6Sh9VS/3T/ri6V4SQ9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284827>

Since baaf233 (connect: improve check for plink to reduce false
positives, 2015-04-26), t5601 writes out a `plink.exe` for testing that
is actually a shell script. So the assumption that the `.exe` extension
implies that the file is *not* a shell script is now wrong.

Since there was no love for the idea of allowing `.exe` files to be
shell scripts on Windows, let's go the other way round: *make*
`plink.exe` a real `.exe`.

This fixes t5601-clone.sh in Git for Windows' SDK.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile         |  1 +
 t/t5601-clone.sh | 18 ++++++++----------
 test-fake-ssh.c  | 30 ++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 10 deletions(-)
 create mode 100644 test-fake-ssh.c

diff --git a/Makefile b/Makefile
index fc2f1ab..10566d6 100644
--- a/Makefile
+++ b/Makefile
@@ -583,6 +583,7 @@ TEST_PROGRAMS_NEED_X += test-delta
 TEST_PROGRAMS_NEED_X += test-dump-cache-tree
 TEST_PROGRAMS_NEED_X += test-dump-split-index
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
+TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-genrandom
 TEST_PROGRAMS_NEED_X += test-hashmap
 TEST_PROGRAMS_NEED_X += test-index-version
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 669ec9b..2f4272a 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -4,6 +4,9 @@ test_description=clone
 
 . ./test-lib.sh
 
+X=
+! test_have_prereq MINGW || X=.exe
+
 test_expect_success setup '
 
 	rm -fr .git &&
@@ -305,14 +308,9 @@ test_expect_success 'clone checking out a tag' '
 
 setup_ssh_wrapper () {
 	test_expect_success 'setup ssh wrapper' '
-		write_script "$TRASH_DIRECTORY/ssh-wrapper" <<-\EOF &&
-		echo >>"$TRASH_DIRECTORY/ssh-output" "ssh: $*" &&
-		# throw away all but the last argument, which should be the
-		# command
-		while test $# -gt 1; do shift; done
-		eval "$1"
-		EOF
-		GIT_SSH="$TRASH_DIRECTORY/ssh-wrapper" &&
+		cp "$GIT_BUILD_DIR/test-fake-ssh$X" \
+			"$TRASH_DIRECTORY/ssh-wrapper$X" &&
+		GIT_SSH="$TRASH_DIRECTORY/ssh-wrapper$X" &&
 		export GIT_SSH &&
 		export TRASH_DIRECTORY &&
 		>"$TRASH_DIRECTORY"/ssh-output
@@ -320,8 +318,8 @@ setup_ssh_wrapper () {
 }
 
 copy_ssh_wrapper_as () {
-	cp "$TRASH_DIRECTORY/ssh-wrapper" "$1" &&
-	GIT_SSH="$1" &&
+	cp "$TRASH_DIRECTORY/ssh-wrapper$X" "${1%$X}$X" &&
+	GIT_SSH="${1%$X}$X" &&
 	export GIT_SSH
 }
 
diff --git a/test-fake-ssh.c b/test-fake-ssh.c
new file mode 100644
index 0000000..980de21
--- /dev/null
+++ b/test-fake-ssh.c
@@ -0,0 +1,30 @@
+#include "git-compat-util.h"
+#include "run-command.h"
+#include "strbuf.h"
+
+int main(int argc, char **argv)
+{
+	const char *trash_directory = getenv("TRASH_DIRECTORY");
+	struct strbuf buf = STRBUF_INIT;
+	FILE *f;
+	int i;
+	const char *child_argv[] = { NULL, NULL };
+
+	/* First, print all parameters into $TRASH_DIRECTORY/ssh-output */
+	if (!trash_directory)
+		die("Need a TRASH_DIRECTORY!");
+	strbuf_addf(&buf, "%s/ssh-output", trash_directory);
+	f = fopen(buf.buf, "w");
+	if (!f)
+		die("Could not write to %s", buf.buf);
+	for (i = 0; i < argc; i++)
+		fprintf(f, "%s%s", i > 0 ? " " : "", i > 0 ? argv[i] : "ssh:");
+	fprintf(f, "\n");
+	fclose(f);
+
+	/* Now, evaluate the *last* parameter */
+	if (argc < 2)
+		return 0;
+	child_argv[0] = argv[argc - 1];
+	return run_command_v_opt(child_argv, RUN_USING_SHELL);
+}
-- 
2.7.0.windows.1.7.g55a05c8
