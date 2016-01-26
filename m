From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 14/19] mingw: work around pwd issues in the tests
Date: Tue, 26 Jan 2016 15:35:21 +0100 (CET)
Message-ID: <f273fbbaaaaa8340626e879665d538c13b8e3fcd.1453818790.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <cover.1453818789.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1262943292-1453818922=:2964"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 15:35:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO4ih-0004vz-Hb
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 15:35:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966127AbcAZOfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 09:35:39 -0500
Received: from mout.gmx.net ([212.227.17.21]:56418 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966201AbcAZOfa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 09:35:30 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M2tKM-1a4kwe1w7q-00sfiz; Tue, 26 Jan 2016 15:35:22
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453818789.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:cBAr4PXYnygliqzb3Y0tPF+1Mi/RjUWUWTpPRFt6S+xCDOl/qFb
 Sm+LGrz7kbVvv5FDyIIG0mDZFPS4BAZ0vcF6FJt9OI+gdZCxtMnh60qa84KCKstB5i8sVLQ
 G0TFN4k8sNjYB1C9ue3yfv6T43vDJaJuywGPcsgzbb/tYg9P2qeIDwzbLZyHQ3YH2ZstliV
 LH+HbpEHgb4X5/DPehk0Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oTITZKWpm3Y=:4ujpdNakao7dmULl9wAMjd
 bsKbO5wC9esUoUoAp+My1BVEXWBE62mxeUZ4MXzspV5MLbZdTK7csx7UmIU8XOuaVXSQ5IChM
 uCEwSImawRcDRF0AfDYpSYo06HBOAR9n5V1IBgwzuA5/BtAQ0BIT4g3f7H7Qdel9RnSKdDgdG
 EOKBa4VK+tWF7FWJhUb5KiqQwWHUoGRQb/LWN7cIB+fmufZw1ae/VyzJbUKlxxcOSf7Ot61e6
 LBl16FewOUdYjS2DeC6skIJ+rRa+VuTUVkYxKEahJW+hq9NY8v8ZK/j5muNx2+ZD6iZZ9PRDz
 rfx/aajFxCd8MeowKvfiSqRPQI8QH1b/Av6JPwReqkasSOBSbqeF8XHGmv7WrMAS6+RGsmx6W
 eryfbVrIEuUKjtCSyBiaHHxzHPBnGkyVqep2atfzh4/jnSyKixXvTY8AlWf1s9iuR8p+69Z9m
 XTjht/W6eSP6bkuW17cLIennNjuCEhgxGbQEolxooQdsrUwTnSUje5wt0veXxW0uKQrQs7mGC
 NWBpk9xYP1HTccizqX/dE5gIaZ6eqHUdm6Tf6L6GqtdHT8ewGzWzzIA7t8iXkHrojs/BSR2WP
 TwXVHIpDAsHlmpMKQ6OB7G1a+kE26Mej4jEj9WG2Zs0mn5gtZA13d7U5g7NN/ZirF5xH+Ieba
 gch22QE1QlZ5jufoTUIgTNVK+n9ACR8FYDIAf4lBPCUuYrdrkfBgdsVikyRgK+LLU5pJ76Z9X
 R5LVobbPIcT9u6sKWx8C75Eu3/IIRD1ACAdHJRjOStNhOm2eSWNFWIzJ3R777Y+DRODPgOSO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284826>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1262943292-1453818922=:2964
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE

In Git for Windows' SDK, the tests are run using a Bash that relies on
the POSIX emulation layer MSYS2 (itself a friendly fork of Cygwin). As
such, paths in tests can be POSIX paths. As soon as those paths are
passed to git.exe (which does *not* use the POSIX emulation layer),
those paths are converted into Windows paths, though. This happens
for command-line parameters, but not when reading, say, config variables.

To help with that, the `pwd` command is overridden to return the Windows
path of the current working directory when testing Git on Windows.

However, when talking to anything using the POSIX emulation layer, it is
really much better to use POSIX paths because Windows paths contain a
colon after the drive letter that will easily be mistaken for the common
separator in path lists.

So let's just use the $PWD variable when the POSIX path is needed.

This lets t7800-difftool.sh, t9400-git-cvsserver-server.sh,
t9402-git-cvsserver-refs.sh and t9401-git-cvsserver-crlf.sh pass in Git
for Windows' SDK.

Note: the cvsserver tests require not only the `cvs` package (install
it into Git for Windows' SDK via `pacman -S cvs`) but also the Perl
SQLite bindings (install them into Git for Windows' SDK via
`cpan DBD::SQLite`).

This patch is based on earlier work by =B8=B6=B4=A9=BF=A4 and Karsten Blees=
=2E

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t7800-difftool.sh             | 14 +++++++-------
 t/t9400-git-cvsserver-server.sh |  6 +++---
 t/t9401-git-cvsserver-crlf.sh   |  6 +++---
 t/t9402-git-cvsserver-refs.sh   |  6 +++---
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index ec8bc8c..4e713f7 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -430,11 +430,11 @@ EOF
 test_expect_success PERL,SYMLINKS 'difftool --dir-diff --symlink without u=
nstaged changes' '
 =09cat >expect <<-EOF &&
 =09file
-=09$(pwd)/file
+=09$PWD/file
 =09file2
-=09$(pwd)/file2
+=09$PWD/file2
 =09sub/sub
-=09$(pwd)/sub/sub
+=09$PWD/sub/sub
 =09EOF
 =09git difftool --dir-diff --symlink \
 =09=09--extcmd "./.git/CHECK_SYMLINKS" branch HEAD &&
@@ -448,14 +448,14 @@ EOF
 run_dir_diff_test 'difftool --dir-diff syncs worktree with unstaged change=
' '
 =09test_when_finished git reset --hard &&
 =09echo "orig content" >file &&
-=09git difftool -d $symlinks --extcmd "$(pwd)/modify-right-file" branch &&
+=09git difftool -d $symlinks --extcmd "$PWD/modify-right-file" branch &&
 =09echo "new content" >expect &&
 =09test_cmp expect file
 '
=20
 run_dir_diff_test 'difftool --dir-diff syncs worktree without unstaged cha=
nge' '
 =09test_when_finished git reset --hard &&
-=09git difftool -d $symlinks --extcmd "$(pwd)/modify-right-file" branch &&
+=09git difftool -d $symlinks --extcmd "$PWD/modify-right-file" branch &&
 =09echo "new content" >expect &&
 =09test_cmp expect file
 '
@@ -466,7 +466,7 @@ EOF
=20
 test_expect_success PERL 'difftool --no-symlinks does not overwrite workin=
g tree file ' '
 =09echo "orig content" >file &&
-=09git difftool --dir-diff --no-symlinks --extcmd "$(pwd)/modify-file" bra=
nch &&
+=09git difftool --dir-diff --no-symlinks --extcmd "$PWD/modify-file" branc=
h &&
 =09echo "new content" >expect &&
 =09test_cmp expect file
 '
@@ -482,7 +482,7 @@ test_expect_success PERL 'difftool --no-symlinks detect=
s conflict ' '
 =09=09TMPDIR=3D$TRASH_DIRECTORY &&
 =09=09export TMPDIR &&
 =09=09echo "orig content" >file &&
-=09=09test_must_fail git difftool --dir-diff --no-symlinks --extcmd "$(pwd=
)/modify-both-files" branch &&
+=09=09test_must_fail git difftool --dir-diff --no-symlinks --extcmd "$PWD/=
modify-both-files" branch &&
 =09=09echo "wt content" >expect &&
 =09=09test_cmp expect file &&
 =09=09echo "tmp content" >expect &&
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server=
=2Esh
index 6146c3f..d708cbf 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -25,11 +25,11 @@ perl -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
     test_done
 }
=20
-WORKDIR=3D$(pwd)
-SERVERDIR=3D$(pwd)/gitcvs.git
+WORKDIR=3D$PWD
+SERVERDIR=3D$PWD/gitcvs.git
 git_config=3D"$SERVERDIR/config"
 CVSROOT=3D":fork:$SERVERDIR"
-CVSWORK=3D"$(pwd)/cvswork"
+CVSWORK=3D"$PWD/cvswork"
 CVS_SERVER=3Dgit-cvsserver
 export CVSROOT CVS_SERVER
=20
diff --git a/t/t9401-git-cvsserver-crlf.sh b/t/t9401-git-cvsserver-crlf.sh
index 5a4ed28..f324b9f 100755
--- a/t/t9401-git-cvsserver-crlf.sh
+++ b/t/t9401-git-cvsserver-crlf.sh
@@ -74,11 +74,11 @@ perl -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
 }
=20
 unset GIT_DIR GIT_CONFIG
-WORKDIR=3D$(pwd)
-SERVERDIR=3D$(pwd)/gitcvs.git
+WORKDIR=3D$PWD
+SERVERDIR=3D$PWD/gitcvs.git
 git_config=3D"$SERVERDIR/config"
 CVSROOT=3D":fork:$SERVERDIR"
-CVSWORK=3D"$(pwd)/cvswork"
+CVSWORK=3D"$PWD/cvswork"
 CVS_SERVER=3Dgit-cvsserver
 export CVSROOT CVS_SERVER
=20
diff --git a/t/t9402-git-cvsserver-refs.sh b/t/t9402-git-cvsserver-refs.sh
index d00df08..6d2d3c8 100755
--- a/t/t9402-git-cvsserver-refs.sh
+++ b/t/t9402-git-cvsserver-refs.sh
@@ -82,11 +82,11 @@ perl -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
 }
=20
 unset GIT_DIR GIT_CONFIG
-WORKDIR=3D$(pwd)
-SERVERDIR=3D$(pwd)/gitcvs.git
+WORKDIR=3D$PWD
+SERVERDIR=3D$PWD/gitcvs.git
 git_config=3D"$SERVERDIR/config"
 CVSROOT=3D":fork:$SERVERDIR"
-CVSWORK=3D"$(pwd)/cvswork"
+CVSWORK=3D"$PWD/cvswork"
 CVS_SERVER=3Dgit-cvsserver
 export CVSROOT CVS_SERVER
=20
--=20
2.7.0.windows.1.7.g55a05c8


--8323329-1262943292-1453818922=:2964--
