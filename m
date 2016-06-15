From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH v7 06/11] merge --stat: use the full terminal width
Date: Fri, 24 Feb 2012 21:32:13 +0100
Message-ID: <1330115538-1576-6-git-send-email-zbyszek@in.waw.pl>
References: <4F47F394.5070007@in.waw.pl>
 <1330115538-1576-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, pclouds@gmail.com,
	j.sixt@viscovery.net,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 24 21:35:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S11rx-0001zK-Od
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 21:35:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755710Ab2BXUfx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Feb 2012 15:35:53 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:55110 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755178Ab2BXUfw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 15:35:52 -0500
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S11rs-00042s-0S; Fri, 24 Feb 2012 21:35:52 +0100
X-Mailer: git-send-email 1.7.9.2.332.g05f13
In-Reply-To: <1330115538-1576-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191466>

Make merge --stat behave like diff --stat and use the full terminal
width.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 builtin/merge.c        | 1 +
 t/t4052-stat-output.sh | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index ed0f959..7b368e7 100644
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
index acc54cd..2b4510c 100755
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
1.7.9.2.332.g05f13
