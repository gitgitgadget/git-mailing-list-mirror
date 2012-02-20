From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 6/8 v6] merge --stat: use the full terminal width
Date: Mon, 20 Feb 2012 22:57:12 +0100
Message-ID: <1329775034-21551-7-git-send-email-zbyszek@in.waw.pl>
References: <1329775034-21551-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, pclouds@gmail.com,
	j.sixt@viscovery.net,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 20 22:58:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzbFS-0004Tj-4V
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 22:58:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754285Ab2BTV6F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Feb 2012 16:58:05 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:52858 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754195Ab2BTV6E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 16:58:04 -0500
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1RzbFD-0007o6-Lo; Mon, 20 Feb 2012 22:58:03 +0100
X-Mailer: git-send-email 1.7.9.1.353.g684b4
In-Reply-To: <1329775034-21551-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191114>

Make merge --stat behave like diff --stat and use the full terminal
width.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 builtin/merge.c        | 1 +
 t/t4052-stat-output.sh | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git builtin/merge.c builtin/merge.c
index ed0f959..7b368e7 100644
--- builtin/merge.c
+++ builtin/merge.c
@@ -399,6 +399,7 @@ static void finish(struct commit *head_commit,
 	if (new_head && show_diffstat) {
 		struct diff_options opts;
 		diff_setup(&opts);
+		opts.stat_width =3D -1; /* use full terminal width */
 		opts.output_format |=3D
 			DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
 		opts.detect_rename =3D DIFF_DETECT_RENAME;
diff --git t/t4052-stat-output.sh t/t4052-stat-output.sh
index acc54cd..2b4510c 100755
--- t/t4052-stat-output.sh
+++ t/t4052-stat-output.sh
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
1.7.9.1.353.g684b4
