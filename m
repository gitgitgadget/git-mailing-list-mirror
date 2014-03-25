From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 060/144] t5500-fetch-pack.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:05 -0700
Message-ID: <1395735989-3396-61-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:32:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMmn-000557-EU
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:32:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753867AbaCYI1q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:27:46 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:44523 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753850AbaCYI1o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:44 -0400
Received: by mail-pb0-f45.google.com with SMTP id uo5so135425pbc.4
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=PqZdkybCZkv1Ctkn/706c9vfR75x/gK6kSRIr328ACs=;
        b=XGz9o4JdA1aYv2HiZdaVMGWCgKdYW7Nmic4ZSylKxh5EKXv/hRMZ4ZQOxlMAkRX1MX
         tpUzVxTqbLnUm4pVPkRGPUkcD0Qo2OQh6zOGZNsj4BsntpHF2gpjhD/fDrzsxKCNJ4G+
         0QNrmHEF97+p/dbculd0iPXCR3vOdRl26dNZsyANZMAVQiGSB2Q+BwNwOEv55UfzmYYF
         MoTPGyGlGFOX323H7CWpGksdmfXvYkX/MIJzkmKB7nWSi3+Lc6Is5zHPnZ/I+WnAslsu
         x5cG5nSqHcKxVFCAuQI3PrRirlnHjVQQikI1WW+uG5GyNmhZ9qfLVD00SiztBiMOJJvS
         JruA==
X-Received: by 10.66.141.231 with SMTP id rr7mr75840044pab.41.1395736064095;
        Tue, 25 Mar 2014 01:27:44 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244972>

The Git CodingGuidelines prefer the $( ... ) construct for command
substitution instead of using the back-quotes, or grave accents (`..`).

The backquoted form is the historical method for command substitution,
and is supported by POSIX. However,all but the simplest uses become
complicated quickly. In particular,embedded command substitutions
and/or the use of double quotes require careful escaping with the backs=
lash
character. Because of this the POSIX shell adopted the $(=E2=80=A6) fea=
ture from
the Korn shell.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t5500-fetch-pack.sh |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 5b2b1c2..99b81e2 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -14,7 +14,7 @@ test_description=3D'Testing multi_ack pack fetching'
 add () {
 	name=3D$1 &&
 	text=3D"$@" &&
-	branch=3D`echo $name | sed -e 's/^\(.\).*$/\1/'` &&
+	branch=3D$(echo $name | sed -e 's/^\(.\).*$/\1/') &&
 	parents=3D"" &&
=20
 	shift &&
@@ -56,12 +56,12 @@ pull_to_client () {
 			git fsck --full &&
=20
 			mv .git/objects/pack/pack-* . &&
-			p=3D`ls -1 pack-*.pack` &&
+			p=3D$(ls -1 pack-*.pack) &&
 			git unpack-objects <$p &&
 			git fsck --full &&
=20
-			idx=3D`echo pack-*.idx` &&
-			pack_count=3D`git show-index <$idx | wc -l` &&
+			idx=3D$(echo pack-*.idx) &&
+			pack_count=3D$(git show-index <$idx | wc -l) &&
 			test $pack_count =3D $count &&
 			rm -f pack-*
 		)
@@ -132,13 +132,13 @@ test_expect_success 'single given branch clone' '
=20
 test_expect_success 'clone shallow depth 1' '
 	git clone --no-single-branch --depth 1 "file://$(pwd)/." shallow0 &&
-	test "`git --git-dir=3Dshallow0/.git rev-list --count HEAD`" =3D 1
+	test "$(git --git-dir=3Dshallow0/.git rev-list --count HEAD)" =3D 1
 '
=20
 test_expect_success 'clone shallow depth 1 with fsck' '
 	git config --global fetch.fsckobjects true &&
 	git clone --no-single-branch --depth 1 "file://$(pwd)/." shallow0fsck=
 &&
-	test "`git --git-dir=3Dshallow0fsck/.git rev-list --count HEAD`" =3D =
1 &&
+	test "$(git --git-dir=3Dshallow0fsck/.git rev-list --count HEAD)" =3D=
 1 &&
 	git config --global --unset fetch.fsckobjects
 '
=20
@@ -147,7 +147,7 @@ test_expect_success 'clone shallow' '
 '
=20
 test_expect_success 'clone shallow depth count' '
-	test "`git --git-dir=3Dshallow/.git rev-list --count HEAD`" =3D 2
+	test "$(git --git-dir=3Dshallow/.git rev-list --count HEAD)" =3D 2
 '
=20
 test_expect_success 'clone shallow object count' '
@@ -273,7 +273,7 @@ test_expect_success 'additional simple shallow deep=
enings' '
 '
=20
 test_expect_success 'clone shallow depth count' '
-	test "`git --git-dir=3Dshallow/.git rev-list --count HEAD`" =3D 11
+	test "$(git --git-dir=3Dshallow/.git rev-list --count HEAD)" =3D 11
 '
=20
 test_expect_success 'clone shallow object count' '
--=20
1.7.10.4
