From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 1/2] Move 'rev-parse --git-dir' test to t1500
Date: Sat, 14 Feb 2009 17:16:28 +0100
Message-ID: <1234628189-3635-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 17:19:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYNF2-0002Cu-Ff
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 17:19:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbZBNQQm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Feb 2009 11:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbZBNQQm
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 11:16:42 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:64611 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbZBNQQl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 11:16:41 -0500
Received: from [127.0.1.1] (p5B130271.dip0.t-ipconnect.de [91.19.2.113])
	by mrelayeu.kundenserver.de (node=mrelayeu8) with ESMTP (Nemesis)
	id 0ML31I-1LYNBs2d11-0007uG; Sat, 14 Feb 2009 17:16:32 +0100
X-Mailer: git-send-email 1.6.2.rc0.111.g246ed
X-Provags-ID: V01U2FsdGVkX1+C+ZUc0+C8Juan4kpKxQ9Ma53oxHAwjLK33E7
 MgZSRwk37bokoQ9DRgIf6RNA8XhnA6VVXwfasGmZ2wsOzT0tCO
 SuU0GkywDox/aWs0ohXXg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109877>

Commit 72183cb2 (Fix gitdir detection when in subdir of
gitdir, 2009-01-16) added a test to 't1501-worktree' to check the
behaviour of 'git rev-parse --git-dir' in a special case.  However,
t1501 is about testing separate work tree setups, and not about basic
'rev-parse' functionality, which is tested in t1500-rev-parse.
Therefore, this patch moves that test to t1500.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 t/t1500-rev-parse.sh |   11 +++++++++--
 t/t1501-worktree.sh  |    7 -------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 85da4ca..186792e 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -26,16 +26,23 @@ test_rev_parse() {
 	"test '$1' =3D \"\$(git rev-parse --show-prefix)\""
 	shift
 	[ $# -eq 0 ] && return
+
+	test_expect_success "$name: git-dir" \
+	"test '$1' =3D \"\$(git rev-parse --git-dir)\""
+	shift
+	[ $# -eq 0 ] && return
 }
=20
-# label is-bare is-inside-git is-inside-work prefix
+# label is-bare is-inside-git is-inside-work prefix git-dir
+
+ROOT=3D$(pwd)
=20
 test_rev_parse toplevel false false true ''
=20
 cd .git || exit 1
 test_rev_parse .git/ false true false ''
 cd objects || exit 1
-test_rev_parse .git/objects/ false true false ''
+test_rev_parse .git/objects/ false true false '' "$ROOT/.git"
 cd ../.. || exit 1
=20
 mkdir -p sub/dir || exit 1
diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index 27dc6c5..f6a6f83 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -92,13 +92,6 @@ cd sub/dir || exit 1
 test_rev_parse 'in repo.git/sub/dir' false true true sub/dir/
 cd ../../../.. || exit 1
=20
-test_expect_success 'detecting gitdir when cwd is in a subdir of gitdi=
r' '
-	(expected=3D$(pwd)/repo.git &&
-	 cd repo.git/refs &&
-	 unset GIT_DIR &&
-	 test "$expected" =3D "$(git rev-parse --git-dir)")
-'
-
 test_expect_success 'repo finds its work tree' '
 	(cd repo.git &&
 	 : > work/sub/dir/untracked &&
--=20
1.6.2.rc0.81.g79856
