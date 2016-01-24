From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 08/19] mingw: fix t5601-clone.sh
Date: Sun, 24 Jan 2016 16:44:42 +0100 (CET)
Message-ID: <d93a4be1aef3560841305d9c279ea470bc22538c.1453650173.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 16:44:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNMqR-00014O-SN
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 16:44:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571AbcAXPor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 10:44:47 -0500
Received: from mout.gmx.net ([212.227.17.21]:61457 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752149AbcAXPoq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 10:44:46 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LpwZn-1Zs9641XTL-00ffDS; Sun, 24 Jan 2016 16:44:43
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453650173.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:PerBRpH4y5wAowfZfl6g47GG+lxRbqX0yFFl3kJikXinxs8QYM6
 BdkYwhTUKRctdvje8qqeGh5kJRvR5+FbuyzkoDWTIkkMFwMHfVEHgRTnpuiDt/mORJTvJBL
 rtUUB0PyhsdbimLog8ohWyBk1m/ElBqfMezdGL/MTzZ02Ga/oa176TfGtLFjhaOPfSjZEXG
 DWP2hqErMlb8oRtE3aSJQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GBDTHktta1o=:AGsTpycDRJvgaMQFQFhpQe
 ROSl6BFrm1zZC81tMlrcqmgL706lnP815CNBOUoxaZuHHo7zUfkdayLX+1mfH3GHtK+C0T4Yw
 9mFiXv2kirXKmu+d9GvRST8hKc3g062DFcJauI2ci7vFgvwPlnqy8ZibWT4nUYkE1EbCDUWtc
 jT6IRHs6N40uuhUrH8/uZ5u8RNJPIKRzM7rJx/qE87OD2jJaV4cRHneSMPNsdXLCS5qFDNNYC
 OA3UE/uMkOSrY6dwAWsZIzbrYC2WVKuQGyHKbpw2CsRln0RlN2ZRQLGqB1ztjjNAN/mhxTk1P
 RzMI0nPPBOafROM4j/QNF/KlnhXkqmbKwT3IeixshNmVacNx1uCJrrOLMxi7e+lupdgFP4HFo
 OrhK89bseUVRUWtTDJkCjhFrjnUAV+yM8pt6i8oa7hskfRBQDHazDgB0yAJoPGFdoYeqNpq4A
 zAwARAacFhIZ7oIbtACljOCEGTiAMpS0KXxukB38+gIH0/RVdok7mx/GcNb4ChepadOhgmKON
 6RjD+jKd3w2f3JfKSs0tbyPiVbahS1LwZqtz2NUOF0gwSbVMZ3kSpHRvue114jG2fio5R8/pv
 4d8ehzOolKm2oN273/3qEVY/k8NSaTqofl+TJ/nznptihGOi+FhHLwSpjAon5LoG4aR8ipmGS
 q1XV9VkMjfm6j2S1TPiiqoLlRgivTyXP6O6fRT6BI4Ue73P3ypfD5OyUNurGgJHgQq3WZg2Il
 fya61guTD0SRo4TBbGdnZpmDL7SDgWKsgD9aHors1umLB6qr0dSpxnI9j2KAPaajZfbgxzMx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284672>

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
