From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 3/4] t1300: fix the new --show-origin tests on Windows
Date: Wed, 23 Mar 2016 11:55:13 +0100 (CET)
Message-ID: <86f6c23e500867f403c33c2716826dc0c5db0cdb.1458730457.git.johannes.schindelin@gmx.de>
References: <cover.1458668543.git.johannes.schindelin@gmx.de> <cover.1458730457.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 11:55:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aigS7-0006Vd-B6
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:55:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754703AbcCWKzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:55:32 -0400
Received: from mout.gmx.net ([212.227.17.21]:61389 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751925AbcCWKz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 06:55:26 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MVNWU-1aGW9V3RLK-00YlYn; Wed, 23 Mar 2016 11:55:15
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1458730457.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:NreZN0xpYC2fsMd94b1z94grD7LRIXh9n1JEV83WbQ/bxHwpGDO
 SEzggfgp8nFz1kGOOkngZmJejaGkbJ956hbnVww0jYoylUSoXZTeQx9P7clhjm7H16vVcoG
 e1mft5RwVmsp2mKrh81bPyioBwuTG2gyeGzrRdl+VDk8irXv1NEQkrfTp/9V0PYu8yVs3uc
 1TJeGRq7vQFzB0jQyZuag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EgcbYEhiyD0=:UUh/G5i1SLKFAt1IjtCyyR
 x13sLMoq43PKq22eLnZYq3P73S31V3XfaHt7rz3j+xk4UX7eFfm35qrimXoO98W9R8waq+Yz3
 fUFBUkSHx5QQW7B50s68JOuSCr+ipQZQ7S4JgIYg6rGwUck1XPSpW3kXerJ1tiet3lk847Ank
 eRF6xYMSFsmS9MD/7mjOiykQRKVxh4akVKRLwgFLQbduNxIOy3eu28dpWq5hmSItqdu9GL4EH
 OLE4XGFQwSIAbFTaQPQ+uqEJ+fjC4UTFxkP94g4ZihJSAwbsmdk8KE/xx3B2hLjaL+AaBIADh
 cKIGMMyUSb6hr1hLUv8UlwXl/f1HG0NaPFqbwMe3IhGnp+7ukpO1BfnhHpQX4rF3S+0Ln+Eiy
 j9DOwZN9szUJCXwf0TTpOjMqw9Pg2021kPwT1FtlA6KUYr+rR92y3CtGZa8LlYWbSu+Kb0VUS
 6eMoelz8bi/2onjDNQW2+uVKOnvzJHXsl5Am/Vh6M1kCmDMr7TYIOadzq4QGGX+UJF9gCntYz
 lKP6kOtrKtzqMxD3FgYALqA0SsVxjVJj0Jw97FSip9QisaEnGg0nAjHmPrsJIgctaIkf/NyJT
 M7bzyR3EqwSTI9BKFVkAPpkY5vasUK2eIObs5kNev3Hz2gTMcD8Z20a6Ua8DQLp+KZxy7RQRi
 5RBiFtG4iDtddF4pLL8Ls267hNoJvPLxZJa8LWWoSOoCIgfeolLZWV0B/KHzAricyksdm3as6
 Y5kX017/hIhHuC0Kg3xwR3vjHP4QfzSLnNLOCiUgAqQmy6szR8zG0MtWm9xsinnR1xkG11Be 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289641>

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
 t/t1300-repo-config.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index dca27a3..a37ebb2 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1205,6 +1205,9 @@ test_expect_success POSIXPERM,PERL 'preserves existing permissions' '
 	  "die q(badrename) if ((stat(q(.git/config)))[2] & 07777) != 0600"
 '
 
+! test_have_prereq MINGW ||
+HOME="$(pwd)" # convert to Windows path
+
 test_expect_success 'set up --show-origin tests' '
 	INCLUDE_DIR="$HOME/include" &&
 	mkdir -p "$INCLUDE_DIR" &&
@@ -1232,6 +1235,7 @@ test_expect_success 'set up --show-origin tests' '
 	EOF
 '
 
+
 test_expect_success '--show-origin with --list' '
 	cat >expect <<-EOF &&
 		file:$HOME/.gitconfig	user.global=true
@@ -1304,7 +1308,7 @@ test_expect_success 'set up custom config file' '
 	EOF
 '
 
-test_expect_success '--show-origin escape special file name characters' '
+test_expect_success !MINGW '--show-origin escape special file name characters' '
 	cat >expect <<-\EOF &&
 		file:"file\" (dq) and spaces.conf"	user.custom=true
 	EOF
@@ -1333,7 +1337,7 @@ test_expect_success '--show-origin stdin with file include' '
 	test_cmp expect output
 '
 
-test_expect_success '--show-origin blob' '
+test_expect_success !MINGW '--show-origin blob' '
 	cat >expect <<-\EOF &&
 		blob:a9d9f9e555b5c6f07cbe09d3f06fe3df11e09c08	user.custom=true
 	EOF
@@ -1342,7 +1346,7 @@ test_expect_success '--show-origin blob' '
 	test_cmp expect output
 '
 
-test_expect_success '--show-origin blob ref' '
+test_expect_success !MINGW '--show-origin blob ref' '
 	cat >expect <<-\EOF &&
 		blob:"master:file\" (dq) and spaces.conf"	user.custom=true
 	EOF
-- 
2.7.4.windows.1
