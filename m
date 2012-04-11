From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 5/5] i18n: mark @{upstream} error messages for translation
Date: Wed, 11 Apr 2012 18:17:15 +0200
Message-ID: <1334161035-26355-6-git-send-email-zbyszek@in.waw.pl>
References: <1334161035-26355-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Apr 11 18:18:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI0Fc-0008Nq-TV
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 18:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353Ab2DKQS2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 12:18:28 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:34685 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756719Ab2DKQS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 12:18:27 -0400
Received: from optyk25.fuw.edu.pl ([193.0.81.79] helo=ameba.fuw.edu.pl)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SI0FW-00065L-Dc; Wed, 11 Apr 2012 18:18:26 +0200
X-Mailer: git-send-email 1.7.10.344.g387ed
In-Reply-To: <1334161035-26355-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195204>

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 sha1_name.c                   | 11 ++++++-----
 t/t1507-rev-parse-upstream.sh | 10 +++++-----
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 5b1b0f9..bd1769e 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -861,15 +861,16 @@ int interpret_branch_name(const char *name, struc=
t strbuf *buf)
 	 * points to something different than a branch.
 	 */
 	if (!upstream)
-		return error("HEAD does not point to a branch");
+		return error(_("HEAD does not point to a branch"));
 	if (!upstream->merge || !upstream->merge[0]->dst) {
 		if (!ref_exists(upstream->refname))
-			return error("No such branch: '%s'", cp);
+			return error(_("No such branch: '%s'"), cp);
 		if (!upstream->merge)
-			return error("No upstream configured for branch '%s'",
+			return error(_("No upstream configured for branch '%s'"),
 				     upstream->name);
-		return error("Upstream branch '%s' not fetched from remote '%s'",
-			     upstream->merge[0]->src, upstream->remote_name);
+		return error(
+			_("Upstream branch '%s' not fetched from remote '%s'"),
+			upstream->merge[0]->src, upstream->remote_name);
 	}
 	free(cp);
 	cp =3D shorten_unambiguous_ref(upstream->merge[0]->dst, 0);
diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream=
=2Esh
index 112025f..a827f98 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -130,7 +130,7 @@ test_expect_success 'branch@{u} error message when =
no upstream' '
 	EOF
 	(cd clone &&
 	 test_must_fail git rev-parse --verify non-tracking@{u}) 2>actual &&
-	test_cmp expect actual
+	test_i18ncmp expect actual
 '
=20
 test_expect_success '@{u} error message when no upstream' '
@@ -139,7 +139,7 @@ test_expect_success '@{u} error message when no ups=
tream' '
 	fatal: Needed a single revision
 	EOF
 	test_must_fail git rev-parse --verify @{u} 2>actual &&
-	test_cmp expect actual
+	test_i18ncmp expect actual
 '
=20
 test_expect_success 'branch@{u} error message with misspelt branch' '
@@ -148,7 +148,7 @@ test_expect_success 'branch@{u} error message with =
misspelt branch' '
 	fatal: Needed a single revision
 	EOF
 	error_message no-such-branch@{u} 2>actual &&
-	test_cmp expect actual
+	test_i18ncmp expect actual
 '
=20
 test_expect_success '@{u} error message when not on a branch' '
@@ -158,7 +158,7 @@ test_expect_success '@{u} error message when not on=
 a branch' '
 	EOF
 	git checkout HEAD^0 &&
 	test_must_fail git rev-parse --verify @{u} 2>actual &&
-	test_cmp expect actual
+	test_i18ncmp expect actual
 '
=20
 test_expect_success 'branch@{u} error message if upstream branch not f=
etched' '
@@ -167,7 +167,7 @@ test_expect_success 'branch@{u} error message if up=
stream branch not fetched' '
 	fatal: Needed a single revision
 	EOF
 	error_message bad-upstream@{u} 2>actual &&
-	test_cmp expect actual
+	test_i18ncmp expect actual
 '
=20
 test_expect_success 'pull works when tracking a local branch' '
--=20
1.7.10.344.g387ed
