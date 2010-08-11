From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 5/7] t/t4016-diff-quote: change from skip_all=* to prereq skip
Date: Wed, 11 Aug 2010 19:04:08 +0000
Message-ID: <1281553450-26467-6-git-send-email-avarab@gmail.com>
References: <7vd3tpxao1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 11 21:04:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjGbV-00034v-Rn
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 21:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758476Ab0HKTEn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 15:04:43 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51867 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755853Ab0HKTEb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 15:04:31 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so479718wwj.1
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 12:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=L7+RTpRXACk8VzXoi5QQTk0vvpld5DI33GCKWT2SWto=;
        b=iC4uFS+YismXb0CBEuLPTc84x9EC6/ztdXA/KaqLuUHK3hN551vmk+p4LKuG/YeGuu
         yHX6MZ/blTkWHm2AUkTnIo7Uuuc4jfqm3QlPLW/nLQT9oRSZx2RQPgrGHrWmVV/jHoUw
         7IiLY+gzcDM2uMU0ILJRwVKGixEF/+6YCItKc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=K5vOnV3q+BlD1k09OFXtnqdJH57ePl+otOjemQh4gFpe8fQhoiOITzzaj72rJ8OvrO
         VvhpvAJWtQPzViUtcySx+b9fmvckOX3B9L2Pfad/RtoXObfTKttScT0mh4Q4xT8Fplx+
         6eYYkdFOEMs/NgbIKyxqbNm1s8dsThfmZp0xY=
Received: by 10.227.142.208 with SMTP id r16mr16971170wbu.140.1281553470694;
        Wed, 11 Aug 2010 12:04:30 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id b18sm369379wbb.19.2010.08.11.12.04.30
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 12:04:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.295.gdf931
In-Reply-To: <7vd3tpxao1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153285>

Change this test to skip test with test prerequisites, and to do setup
work in tests. This improves the skipped statistics on platforms where
the test isn't run.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t4016-diff-quote.sh |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/t/t4016-diff-quote.sh b/t/t4016-diff-quote.sh
index 34e5144..ab0c2f0 100755
--- a/t/t4016-diff-quote.sh
+++ b/t/t4016-diff-quote.sh
@@ -13,12 +13,14 @@ P1=3D'pathname	with HT'
 P2=3D'pathname with SP'
 P3=3D'pathname
 with LF'
-: 2>/dev/null >"$P1" && test -f "$P1" && rm -f "$P1" || {
-	skip_all=3D'Your filesystem does not allow tabs in filenames, test sk=
ipped.'
-	test_done
-}
+if : 2>/dev/null >"$P1" && test -f "$P1" && rm -f "$P1"
+then
+	test_set_prereq TABS_IN_FILENAMES
+else
+	say 'Your filesystem does not allow tabs in filenames'
+fi
=20
-test_expect_success setup '
+test_expect_success TABS_IN_FILENAMES setup '
 	echo P0.0 >"$P0.0" &&
 	echo P0.1 >"$P0.1" &&
 	echo P0.2 >"$P0.2" &&
@@ -38,6 +40,7 @@ test_expect_success setup '
 	:
 '
=20
+test_expect_success TABS_IN_FILENAMES 'setup expected files' '
 cat >expect <<\EOF
  rename pathname.1 =3D> "Rpathname\twith HT.0" (100%)
  rename pathname.3 =3D> "Rpathname\nwith LF.0" (100%)
@@ -47,11 +50,14 @@ cat >expect <<\EOF
  rename pathname.0 =3D> Rpathname.0 (100%)
  rename "pathname\twith HT.0" =3D> Rpathname.1 (100%)
 EOF
-test_expect_success 'git diff --summary -M HEAD' '
+'
+
+test_expect_success TABS_IN_FILENAMES 'git diff --summary -M HEAD' '
 	git diff --summary -M HEAD >actual &&
 	test_cmp expect actual
 '
=20
+test_expect_success TABS_IN_FILENAMES 'setup expected files' '
 cat >expect <<\EOF
  pathname.1 =3D> "Rpathname\twith HT.0"            |    0
  pathname.3 =3D> "Rpathname\nwith LF.0"            |    0
@@ -62,7 +68,9 @@ cat >expect <<\EOF
  "pathname\twith HT.0" =3D> Rpathname.1            |    0
  7 files changed, 0 insertions(+), 0 deletions(-)
 EOF
-test_expect_success 'git diff --stat -M HEAD' '
+'
+
+test_expect_success TABS_IN_FILENAMES 'git diff --stat -M HEAD' '
 	git diff --stat -M HEAD >actual &&
 	test_cmp expect actual
 '
--=20
1.7.2.1.295.gdf931
