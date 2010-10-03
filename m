From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 03/16] t4017 (diff-retval): replace manual exit code check with test_expect_code
Date: Sun,  3 Oct 2010 14:00:01 -0600
Message-ID: <1286136014-7728-4-git-send-email-newren@gmail.com>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, avarab@gmail.com, jrnieder@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 21:58:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Uhz-0002r3-VM
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 21:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754756Ab0JCT6v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 15:58:51 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:52092 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754755Ab0JCT6u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 15:58:50 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so1157426pxi.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 12:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=OyzAzjhLxgqmYHFA30bVxMYrNPvPRVGaUyLkC+WZos0=;
        b=Tnfs01Wb8Rxos6LAZtCDRs/fz7VuEV+E3lBGh/QFDUlgCMPfXHO97lCNwgP18v9P2S
         e1VvDZ7cfGUccAB86Kt14ohbLIcBF8vFHOQlfCvMwyBGB3MVkArkOnKR+vC469JGgyFk
         tpwrpw6cIC7IqhivsvWhpAZF8+BK9fWppuRzc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=LFBlqlWdrDGHPuneC3cdxuI3b8AHCuVv4C+0Lf10qHcn5A3yolIu2zCfe6hs2yl0aJ
         wrJYdenNqkdetqpYx3435+7IYHMz2Ub6gkn83X6uv9lPpAMYOzuusRZHFzNw5JWKXs2t
         QId82Z+XXMAgm5pV1rjPeVgPHR30wvoXg0Rfw=
Received: by 10.114.72.14 with SMTP id u14mr10082296waa.205.1286135929741;
        Sun, 03 Oct 2010 12:58:49 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id d2sm7661138wam.14.2010.10.03.12.58.47
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 12:58:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.66.gab790
In-Reply-To: <1286136014-7728-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157900>

This commit takes advantage of =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason's=
 recent change
to test_expect_code (test-lib: make test_expect_code a test command) to
simplify several testcases.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t4017-diff-retval.sh |   69 ++++++++++++++--------------------------=
--------
 1 files changed, 20 insertions(+), 49 deletions(-)

diff --git a/t/t4017-diff-retval.sh b/t/t4017-diff-retval.sh
index 6158985..95a7ca7 100755
--- a/t/t4017-diff-retval.sh
+++ b/t/t4017-diff-retval.sh
@@ -29,66 +29,49 @@ test_expect_success 'git diff --quiet -w  HEAD^ HEA=
D' '
 '
=20
 test_expect_success 'git diff-tree HEAD^ HEAD' '
-	git diff-tree --exit-code HEAD^ HEAD
-	test $? =3D 1
+	test_expect_code 1 git diff-tree --exit-code HEAD^ HEAD
 '
 test_expect_success 'git diff-tree HEAD^ HEAD -- a' '
 	git diff-tree --exit-code HEAD^ HEAD -- a
-	test $? =3D 0
 '
 test_expect_success 'git diff-tree HEAD^ HEAD -- b' '
-	git diff-tree --exit-code HEAD^ HEAD -- b
-	test $? =3D 1
+	test_expect_code 1 git diff-tree --exit-code HEAD^ HEAD -- b
 '
 test_expect_success 'echo HEAD | git diff-tree --stdin' '
-	echo $(git rev-parse HEAD) | git diff-tree --exit-code --stdin
-	test $? =3D 1
+	echo $(git rev-parse HEAD) | test_expect_code 1 git diff-tree --exit-=
code --stdin
 '
 test_expect_success 'git diff-tree HEAD HEAD' '
 	git diff-tree --exit-code HEAD HEAD
-	test $? =3D 0
 '
 test_expect_success 'git diff-files' '
 	git diff-files --exit-code
-	test $? =3D 0
 '
 test_expect_success 'git diff-index --cached HEAD' '
 	git diff-index --exit-code --cached HEAD
-	test $? =3D 0
 '
 test_expect_success 'git diff-index --cached HEAD^' '
-	git diff-index --exit-code --cached HEAD^
-	test $? =3D 1
+	test_expect_code 1 git diff-index --exit-code --cached HEAD^
 '
 test_expect_success 'git diff-index --cached HEAD^' '
 	echo text >>b &&
 	echo 3 >c &&
-	git add . && {
-		git diff-index --exit-code --cached HEAD^
-		test $? =3D 1
-	}
+	git add . &&
+	test_expect_code 1 git diff-index --exit-code --cached HEAD^
 '
 test_expect_success 'git diff-tree -Stext HEAD^ HEAD -- b' '
-	git commit -m "text in b" && {
-		git diff-tree -p --exit-code -Stext HEAD^ HEAD -- b
-		test $? =3D 1
-	}
+	git commit -m "text in b" &&
+	test_expect_code 1 git diff-tree -p --exit-code -Stext HEAD^ HEAD -- =
b
 '
 test_expect_success 'git diff-tree -Snot-found HEAD^ HEAD -- b' '
 	git diff-tree -p --exit-code -Snot-found HEAD^ HEAD -- b
-	test $? =3D 0
 '
 test_expect_success 'git diff-files' '
-	echo 3 >>c && {
-		git diff-files --exit-code
-		test $? =3D 1
-	}
+	echo 3 >>c &&
+	test_expect_code 1 git diff-files --exit-code
 '
 test_expect_success 'git diff-index --cached HEAD' '
-	git update-index c && {
-		git diff-index --exit-code --cached HEAD
-		test $? =3D 1
-	}
+	git update-index c &&
+	test_expect_code 1 git diff-index --exit-code --cached HEAD
 '
=20
 test_expect_success '--check --exit-code returns 0 for no difference' =
'
@@ -100,30 +83,26 @@ test_expect_success '--check --exit-code returns 0=
 for no difference' '
 test_expect_success '--check --exit-code returns 1 for a clean differe=
nce' '
=20
 	echo "good" > a &&
-	git diff --check --exit-code
-	test $? =3D 1
+	test_expect_code 1 git diff --check --exit-code
=20
 '
=20
 test_expect_success '--check --exit-code returns 3 for a dirty differe=
nce' '
=20
 	echo "bad   " >> a &&
-	git diff --check --exit-code
-	test $? =3D 3
+	test_expect_code 3 git diff --check --exit-code
=20
 '
=20
 test_expect_success '--check with --no-pager returns 2 for dirty diffe=
rence' '
=20
-	git --no-pager diff --check
-	test $? =3D 2
+	test_expect_code 2 git --no-pager diff --check
=20
 '
=20
 test_expect_success 'check should test not just the last line' '
 	echo "" >>a &&
-	git --no-pager diff --check
-	test $? =3D 2
+	test_expect_code 2 git --no-pager diff --check
=20
 '
=20
@@ -133,10 +112,8 @@ test_expect_success 'check detects leftover confli=
ct markers' '
 	echo binary >>b &&
 	git commit -m "side" b &&
 	test_must_fail git merge master &&
-	git add b && (
-		git --no-pager diff --cached --check >test.out
-		test $? =3D 2
-	) &&
+	git add b &&
+	test_expect_code 2 git --no-pager diff --cached --check >test.out &&
 	test 3 =3D $(grep "conflict marker" test.out | wc -l) &&
 	git reset --hard
 '
@@ -146,19 +123,13 @@ test_expect_success 'check honors conflict marker=
 length' '
 	echo ">>>>>>> boo" >>b &&
 	echo "=3D=3D=3D=3D=3D=3D" >>a &&
 	git diff --check a &&
-	(
-		git diff --check b
-		test $? =3D 2
-	) &&
+	test_expect_code 2 git diff --check b &&
 	git reset --hard &&
 	echo ">>>>>>>> boo" >>b &&
 	echo "=3D=3D=3D=3D=3D=3D=3D=3D" >>a &&
 	git diff --check &&
 	echo "b conflict-marker-size=3D8" >.gitattributes &&
-	(
-		git diff --check b
-		test $? =3D 2
-	) &&
+	test_expect_code 2 git diff --check b &&
 	git diff --check a &&
 	git reset --hard
 '
--=20
1.7.3.1.66.gab790
