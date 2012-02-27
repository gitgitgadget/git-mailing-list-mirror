From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH] grep -P: add tests for matching ^ and $
Date: Mon, 27 Feb 2012 17:45:49 +0100
Message-ID: <1330361149-26741-1-git-send-email-zbyszek@in.waw.pl>
References: <7vlinpdxsu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: michal.kiedrowicz@gmail.com,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 27 17:46:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S23iL-0000Am-Lg
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 17:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754007Ab2B0QqM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 11:46:12 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:55266 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753654Ab2B0QqL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 11:46:11 -0500
Received: from optyk25.fuw.edu.pl ([193.0.81.79] helo=ameba.fuw.edu.pl)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S23iB-0007UR-Bf; Mon, 27 Feb 2012 17:46:07 +0100
X-Mailer: git-send-email 1.7.9.2.396.ga883d.dirty
In-Reply-To: <7vlinpdxsu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191629>

=46rom: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>

When a fix for matching ^ and $ with -P was commited to master in
fba4f1 (grep -P: Fix matching ^ and $), the tests were missing the
LIBPCRE prerequisite check and were dropped from the patch. Here are
the tests guarded with LIBPCRE.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 t/t7810-grep.sh |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 75f4716..d9ad633 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -47,6 +47,13 @@ test_expect_success setup '
 	echo vvv >t/v &&
 	mkdir t/a &&
 	echo vvv >t/a/v &&
+	{
+		echo "line without leading space1"
+		echo " line with leading space1"
+		echo " line with leading space2"
+		echo " line with leading space3"
+		echo "line without leading space2"
+	} >space &&
 	git add . &&
 	test_tick &&
 	git commit -m initial
@@ -893,4 +900,20 @@ test_expect_success 'mimic ack-grep --group' '
 	test_cmp expected actual
 '
=20
+cat >expected <<EOF
+space: line with leading space1
+space: line with leading space2
+space: line with leading space3
+EOF
+
+test_expect_success LIBPCRE 'grep -E "^ "' '
+	git grep -E "^ " space >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success LIBPCRE 'grep -P "^ "' '
+	git grep -P "^ " space >actual &&
+	test_cmp expected actual
+'
+
 test_done
--=20
1.7.9.2.396.ga883d.dirty
