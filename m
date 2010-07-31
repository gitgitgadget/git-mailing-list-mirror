From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH 1/2 v2] test-lib.sh: introduce 4th argument to test_commit() specifying a tag name
Date: Sat, 31 Jul 2010 05:56:01 +0400
Message-ID: <20100731015601.GB19956@wo.int.altlinux.org>
References: <AANLkTimeQA2_fQ_f2pQchbo1coj3=mV9TRPnbET8SQ4F@mail.gmail.com> <20100731001845.GA24129@wo.int.altlinux.org> <AANLkTik3KBCh6Xn8r8odfdEfH=1Uf1bMKW6ic4UQPRsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 31 03:56:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of1JG-0004Mi-CM
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 03:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754518Ab0GaB4G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jul 2010 21:56:06 -0400
Received: from vint.altlinux.org ([194.107.17.35]:51327 "EHLO
	vint.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754475Ab0GaB4E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 21:56:04 -0400
Received: from wo.int.altlinux.org (wo.int.altlinux.org [192.168.1.4])
	by vint.altlinux.org (Postfix) with ESMTP id 2C2D43F80005
	for <git@vger.kernel.org>; Sat, 31 Jul 2010 01:56:02 +0000 (UTC)
Received: by wo.int.altlinux.org (Postfix, from userid 508)
	id 77233519000D; Sat, 31 Jul 2010 05:56:01 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <AANLkTik3KBCh6Xn8r8odfdEfH=1Uf1bMKW6ic4UQPRsw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152286>

When fourth argument to test_commit() is specified, use it as a tag
name, unless it equals to empty string.  In the latter case, skip tag
creation.

Suggested-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 t/README      |    8 ++++----
 t/test-lib.sh |   11 ++++++++---
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/t/README b/t/README
index 0d1183c..18f5810 100644
--- a/t/README
+++ b/t/README
@@ -388,13 +388,13 @@ library for your script to use.
    committer times to defined stated.  Subsequent calls will
    advance the times by a fixed amount.
=20
- - test_commit <message> [<filename> [<contents>]]
+ - test_commit <message> [<filename> [<contents> [<tagname>]]]
=20
    Creates a commit with the given message, committing the given
    file with the given contents (default for both is to reuse the
-   message string), and adds a tag (again reusing the message
-   string as name).  Calls test_tick to make the SHA-1s
-   reproducible.
+   message string), and adds a tag with the given name (default again
+   is to reuse the message string as name) unless this name is the
+   empty string.  Calls test_tick to make the SHA-1s reproducible.
=20
  - test_merge <message> <commit-or-tag>
=20
diff --git a/t/test-lib.sh b/t/test-lib.sh
index e5523dd..ebb6215 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -277,10 +277,12 @@ test_tick () {
 	export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
 }
=20
-# Call test_commit with the arguments "<message> [<file> [<contents>]]=
"
+# Call test_commit with the arguments
+# "<message> [<file> [<contents> [<tagname>]]]"
 #
 # This will commit a file with the given contents and the given commit
-# message.  It will also add a tag with <message> as name.
+# message.  It will also add a tag with the given name unless the latt=
er
+# is the empty string.
 #
 # Both <file> and <contents> default to <message>.
=20
@@ -290,7 +292,10 @@ test_commit () {
 	git add "$file" &&
 	test_tick &&
 	git commit -m "$1" &&
-	git tag "$1"
+	if test -n "${4-$1}"
+	then
+		git tag "${4-$1}"
+	fi
 }
=20
 # Call test_merge with the arguments "<message> <commit>", where <comm=
it>


--=20
ldv
