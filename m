From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 08/20] mingw: fix t5601-clone.sh
Date: Wed, 27 Jan 2016 17:19:37 +0100 (CET)
Message-ID: <0beebb376eebae00be2e82aa7ffe7cc3835c2740.1453911367.git.johannes.schindelin@gmx.de>
References: <cover.1453818789.git.johannes.schindelin@gmx.de> <cover.1453911367.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 17:19:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOSov-0002FK-PK
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 17:19:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932907AbcA0QTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 11:19:45 -0500
Received: from mout.gmx.net ([212.227.17.22]:55844 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932176AbcA0QTn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 11:19:43 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MUUWN-1aXz5u2tAh-00RG0H; Wed, 27 Jan 2016 17:19:37
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453911367.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:D83dLQPuAf7Y3THoM4Tna1ooF3DV40yJRN/XNiMof7ZvZoH7c64
 bq3YNmPKrfolga2mW2tB+PHnmVlE0moZHcGVLaD6JAsjlzJtPerzuNJdiAprXttB0z6mCS5
 jIYHzV5G5KHVHBOXxF0o+DSAGduoo3QFZmrNNxhVWYdHBBV8n4Aw/YpGRm38trapVh4lhlk
 1C+osIzQPl0n8yqFw2noA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CYuNn6LP0Z8=:70FoY4p1vwaZjaLEwJPB+7
 0MBNpah6f9/CTXmRrEGIN6PNAhrSmxZDj3MDlb+iCYq+GIg+vVJBTxEnCD62pTXzyQ8MUIOZf
 zsUXE7o6eySmJxH+URwl2HcaL9Tc9MeTk/653yA7uuNGeEYIXO+XKWbSCSsnkK5ulZ+/BVPn2
 KmoaAjyC89kjxC9XslGjempeIoFyjDru70JGD3+mZWm1JKe8AeVZLccHr2Qz+uqCOSj+FkMjS
 qExw5+7lxazokDNrKm6SlQ/sdq8uPyydJ9R57wGerW11p5KRO8YiUrdJfMdv0eRngTXJ69rx6
 PuLnM8aVHvH+ilc9omvDD1Ocfec+KSMQ8qGhMP36LcEnXBFwDDhSsPslM2HTC4q8rgMOAtNQN
 FXKxZwh9+dLhv1rI/evaYeHZytJxSPVReRYFBBEEzz555Jhy+JbG203AbXFtT74wO7xkSU5JX
 7ag3yA2cOMLS684AsbcZbReHk1dTfQc2lSbqlxzYKL3MHONMfOEuksF8730gddAxtpGHEpsEM
 k5mHokM0sS4/9+OYiOOlioIfk4B0VaVJKXAdyDDmbOwZlM4ZSpoabwQCOjoNIwacokqb03Sl2
 34j9LPiG+WvZkIe3Wv6di+i/+cHW1Jn53i15jInqVniD7PuUIOK4U7eJ/2SkT9otDvCjKwpAX
 VmnjBcQ6FUWu65Jhoak9KAqqxXxUbBGdQ4ldrFE6CXxtozLprF56nrpK0taIw1vm8RMY5zMhC
 9Ll3V87a+F11e5kPlQgzhl/uEieX3Sh1io7yF5qxj2OYh4cr8yl2qbGnKmOEcfsexuq9ZWku 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284926>

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
index 669ec9b..c1efb8e 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -4,6 +4,9 @@ test_description=clone
 
 . ./test-lib.sh
 
+X=
+test_have_prereq !MINGW || X=.exe
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
