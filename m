From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 3/4] t1300: fix the new --show-origin tests on Windows
Date: Tue, 22 Mar 2016 18:42:55 +0100 (CET)
Message-ID: <a43d6d1f46a90eea9083f329ad0dfb17915c38a1.1458668543.git.johannes.schindelin@gmx.de>
References: <cover.1458668543.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 18:43:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiQKw-0003NH-1d
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 18:43:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756561AbcCVRnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 13:43:16 -0400
Received: from mout.gmx.net ([212.227.17.20]:55356 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756494AbcCVRnP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 13:43:15 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LgeFd-1ZwlN71UDV-00nwon; Tue, 22 Mar 2016 18:42:56
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1458668543.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:klWhtnWFY4KJG50/wIHMDa+Mls063ERnMiqDiDaU7F4H1Os2jBs
 3Ptmp4DZQ2hHg1K8BGxtwNUc6zVd2vWgIxvt1GWpuDM9pk0Ac2WM4j2YMU4qFjnXwNPhMqk
 f/FK1b6WLuy7mE3eeH+LkF2rcPRB7kc6mm8fkDAkvho9UjHSN9M6PlRfdJw7Cxu+Vy5X7rL
 d1uentk4L157Qi26Ff4JA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jIOahvxedCg=:5r+mS8wBirXtDtslGm+ZA1
 n6KeIlaytOvym5YoGRrl51VBT5j7n52x+DEDS60eSAHf1wvVmTvh+sSJhs5HEc9Gb/EGukdEv
 hKQST6Npel1HcQ5P6QnMiBWkoSZcK6Ys2It9pUgIZY8uCyehhGXv+V1qq5Q1UjkJNKC049yaX
 0k0aVXMivJOnKEjhw3+1KBGYaBPaIzcJh+CDt9WNiNrqctHeKM0dJY3y73mESuA+wzvMh9qXR
 h6S6Wy8NRJPS3P/oDKdgwerXH9KLsF7EQEienr9bIMt+WrCCBWAejZo7RqZ+gC062JplWFpN7
 7BjYQMz2/Sv518+yX9Xi1sHCks8cpNrN+Wy27czwYJBahyXIU/Zoo173/FiE0EGnv/YwL+Ls6
 2bB5/aK0TmyVTmZ/jATNAg45a12p2O1B6e3tg5/SG3EnmioE7oQrzhYAgwjTZVCmuAajJk5zS
 cPauD/BgiuavlpoL2kkolriV/t9EVOHQCjdhbhFBvCEoRdsMWRHUFgj2fRdokabhkkG4SMX5n
 CVAoHSKCSYT27fOldOHtGfEjcj9BaWj15Q2piwuXwWs6+W9TpJA4VsWQmevyppIqwBEyvNS1a
 k5DoitMYFdOVFI+q7cAyxnGVA0hHBKJc4nBwRQVkwQTRkD6f8qud+phwDAjpetkOQZzl0MG3q
 bHguVyvbrVQ3AvPgIbUpmL+1dPlBx+vrcqu/uZ0F/qVsgInfLmPonEU1U+K4B3TZLn8SvZ68j
 FB9q49LYtB/6LAS1DAgXUKwb4MwS22nQ5bmSQqnqtNu8xysaz6UwXscAgV1fPpls9zief9ls 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289526>

On Windows, we have that funny situation where the test script can refer
to POSIX paths because it runs in a shell that uses a POSIX emulation
layer ("MSYS2 runtime"). Yet, git.exe does *not* understand POSIX paths
at all but only pure Windows paths.

So let's just convert the POSIX paths to Windows paths before passing
them on to Git, using `pwd` (which is already modified on Windows to
output Windows paths).

While fixing the new tests on Windows, we also have to exclude the tests
that want to write a file with a name that is illegal on Windows
(unfortunately, there is more than one test trying to make use of that
file).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1300-repo-config.sh | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 0236fe2..18eb769 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1232,6 +1232,15 @@ test_expect_success 'set up --show-origin tests' '
 	EOF
 '
 
+if test_have_prereq MINGW
+then
+	# convert to Windows paths
+	HOME="$(pwd)"
+	INCLUDE_DIR="$HOME/include"
+	export HOME INCLUDE_DIR
+	git config -f .gitconfig include.path "$INCLUDE_DIR/absolute.include"
+fi
+
 test_expect_success '--show-origin with --list' '
 	cat >expect <<-EOF &&
 		file:$HOME/.gitconfig	user.global=true
@@ -1304,7 +1313,7 @@ test_expect_success 'set up custom config file' '
 	EOF
 '
 
-test_expect_success '--show-origin escape special file name characters' '
+test_expect_success !MINGW '--show-origin escape special file name characters' '
 	cat >expect <<-\EOF &&
 		file:"file\" (dq) and spaces.conf"	user.custom=true
 	EOF
@@ -1333,7 +1342,7 @@ test_expect_success '--show-origin stdin with file include' '
 	test_cmp expect output
 '
 
-test_expect_success '--show-origin blob' '
+test_expect_success !MINGW '--show-origin blob' '
 	cat >expect <<-\EOF &&
 		blob:a9d9f9e555b5c6f07cbe09d3f06fe3df11e09c08	user.custom=true
 	EOF
@@ -1342,7 +1351,7 @@ test_expect_success '--show-origin blob' '
 	test_cmp expect output
 '
 
-test_expect_success '--show-origin blob ref' '
+test_expect_success !MINGW '--show-origin blob ref' '
 	cat >expect <<-\EOF &&
 		blob:"master:file\" (dq) and spaces.conf"	user.custom=true
 	EOF
-- 
2.7.4.windows.1
