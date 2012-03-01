From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH v7a 5/9] merge --stat: use the full terminal width
Date: Thu,  1 Mar 2012 13:26:42 +0100
Message-ID: <1330604806-30288-5-git-send-email-zbyszek@in.waw.pl>
References: <7vfwdts6wj.fsf@alter.siamese.dyndns.org>
 <1330604806-30288-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, j.sixt@viscovery.net,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 01 13:29:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S358W-0005n2-Ay
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 13:29:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759055Ab2CAM33 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Mar 2012 07:29:29 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:55383 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758949Ab2CAM32 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 07:29:28 -0500
Received: from optyk25.fuw.edu.pl ([193.0.81.79] helo=ameba.fuw.edu.pl)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S358R-00026K-Qb; Thu, 01 Mar 2012 13:29:27 +0100
X-Mailer: git-send-email 1.7.9.2.399.gdf4d.dirty
In-Reply-To: <1330604806-30288-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191923>

Make merge --stat behave like diff --stat and use the full terminal
width.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c        |    1 +
 t/t4052-stat-output.sh |    8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index b4fbc60..b1cd90c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -399,6 +399,7 @@ static void finish(struct commit *head_commit,
 	if (new_head && show_diffstat) {
 		struct diff_options opts;
 		diff_setup(&opts);
+		opts.stat_width =3D -1; /* use full terminal width */
 		opts.output_format |=3D
 			DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
 		opts.detect_rename =3D DIFF_DETECT_RENAME;
diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index f81d427..954c16f 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -168,9 +168,9 @@ respects expect200 log -1 --stat
 EOF
=20
 cat >expect <<'EOF'
- abcd | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
+ abcd | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++
 EOF
-test_expect_success 'merge --stat ignores COLUMNS (big change)' '
+test_expect_success 'merge --stat respects COLUMNS (big change)' '
 	git checkout -b branch HEAD^^ &&
 	COLUMNS=3D100 git merge --stat --no-ff master^ >output &&
 	grep " | " output >actual
@@ -178,9 +178,9 @@ test_expect_success 'merge --stat ignores COLUMNS (=
big change)' '
 '
=20
 cat >expect <<'EOF'
- ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 +++++++++++=
+++++++++
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 +++++++++++=
+++++++++++++++++++++++++++++
 EOF
-test_expect_success 'merge --stat ignores COLUMNS (long filename)' '
+test_expect_success 'merge --stat respects COLUMNS (long filename)' '
 	COLUMNS=3D100 git merge --stat --no-ff master >output &&
 	grep " | " output >actual
 	test_cmp expect actual
--=20
1.7.9.2.399.gdf4d.dirty
