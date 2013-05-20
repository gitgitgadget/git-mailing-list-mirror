From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 4/6] t5000: use check_tar for prefix test
Date: Mon, 20 May 2013 11:58:27 +0200
Message-ID: <1369043909-59207-5-git-send-email-rene.scharfe@lsrfire.ath.cx>
References: <1369043909-59207-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 20 11:58:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeMrm-0004UC-Lu
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 11:58:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755283Ab3ETJ6i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 May 2013 05:58:38 -0400
Received: from india601.server4you.de ([85.25.151.105]:56481 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754776Ab3ETJ6g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 05:58:36 -0400
Received: from debian.Speedport_W_504V_Typ_A (p4FFDA8FE.dip0.t-ipconnect.de [79.253.168.254])
	by india601.server4you.de (Postfix) with ESMTPSA id B4D3A553
	for <git@vger.kernel.org>; Mon, 20 May 2013 11:58:34 +0200 (CEST)
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1369043909-59207-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224947>

Perform the full range of checks against all archived files instead of
looking only at the file type of a few of them.  Also add a test of a
git archive with a prefix ending in with a slash, i.e. adding a full
directory level.

Signed-off-by: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 t/t5000-tar-tree.sh | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 8337a1f..5a9b570 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -103,6 +103,18 @@ test_expect_success \
=20
 check_tar b
=20
+test_expect_success 'git archive --prefix=3Dprefix/' '
+	git archive --prefix=3Dprefix/ HEAD >with_prefix.tar
+'
+
+check_tar with_prefix prefix/
+
+test_expect_success 'git-archive --prefix=3Dolde-' '
+	git archive --prefix=3Dolde- HEAD >with_olde-prefix.tar
+'
+
+check_tar with_olde-prefix olde-
+
 test_expect_success \
     'git tar-tree' \
     'git tar-tree HEAD >b2.tar'
@@ -180,18 +192,6 @@ test_expect_success 'clients cannot access unreach=
able commits' '
 	test_must_fail git archive --remote=3D. $sha1 >remote.tar
 '
=20
-test_expect_success 'git-archive --prefix=3Dolde-' '
-	git archive --prefix=3Dolde- >h.tar HEAD &&
-	(
-		mkdir h &&
-		cd h &&
-		"$TAR" xf - <../h.tar
-	) &&
-	test -d h/olde-a &&
-	test -d h/olde-a/bin &&
-	test -f h/olde-a/bin/sh
-'
-
 test_expect_success 'setup tar filters' '
 	git config tar.tar.foo.command "tr ab ba" &&
 	git config tar.bar.command "tr ab ba" &&
--=20
1.8.2.3
