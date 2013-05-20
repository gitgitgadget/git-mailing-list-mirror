From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 5/6] t5000: simplify tar-tree tests
Date: Mon, 20 May 2013 11:58:28 +0200
Message-ID: <1369043909-59207-6-git-send-email-rene.scharfe@lsrfire.ath.cx>
References: <1369043909-59207-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 20 11:58:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeMra-0004MQ-9i
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 11:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755359Ab3ETJ6i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 May 2013 05:58:38 -0400
Received: from india601.server4you.de ([85.25.151.105]:56483 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755042Ab3ETJ6h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 05:58:37 -0400
Received: from debian.Speedport_W_504V_Typ_A (p4FFDA8FE.dip0.t-ipconnect.de [79.253.168.254])
	by india601.server4you.de (Postfix) with ESMTPSA id EE1CC55C
	for <git@vger.kernel.org>; Mon, 20 May 2013 11:58:34 +0200 (CEST)
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1369043909-59207-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224945>

Just compare the archives created by git tar-tree with the ones created
using git archive with the equivalent options, whose contents are
checked already, instead of extracting them again.

Signed-off-by: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 t/t5000-tar-tree.sh | 31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 5a9b570..a1f35d2 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -115,14 +115,6 @@ test_expect_success 'git-archive --prefix=3Dolde-'=
 '
=20
 check_tar with_olde-prefix olde-
=20
-test_expect_success \
-    'git tar-tree' \
-    'git tar-tree HEAD >b2.tar'
-
-test_expect_success \
-    'git archive vs. git tar-tree' \
-    'test_cmp b.tar b2.tar'
-
 test_expect_success 'git archive on large files' '
     test_config core.bigfilethreshold 1 &&
     git archive HEAD >b3.tar &&
@@ -158,22 +150,15 @@ test_expect_success \
     'git get-tar-commit-id <b.tar >b.commitid &&
      test_cmp .git/$(git symbolic-ref HEAD) b.commitid'
=20
-test_expect_success \
-    'git tar-tree with prefix' \
-    'git tar-tree HEAD prefix >c.tar'
-
-test_expect_success \
-    'extract tar archive with prefix' \
-    '(mkdir c && cd c && "$TAR" xf -) <c.tar'
-
-test_expect_success \
-    'validate filenames with prefix' \
-    '(cd c/prefix/a && find .) | sort >c.lst &&
-     test_cmp a.lst c.lst'
+test_expect_success 'git tar-tree' '
+	git tar-tree HEAD >tar-tree.tar &&
+	test_cmp b.tar tar-tree.tar
+'
=20
-test_expect_success \
-    'validate file contents with prefix' \
-    'diff -r a c/prefix/a'
+test_expect_success 'git tar-tree with prefix' '
+	git tar-tree HEAD prefix >tar-tree_with_prefix.tar &&
+	test_cmp with_prefix.tar tar-tree_with_prefix.tar
+'
=20
 test_expect_success 'git archive with --output, override inferred form=
at' '
 	git archive --format=3Dtar --output=3Dd4.zip HEAD &&
--=20
1.8.2.3
