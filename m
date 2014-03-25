From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 053/144] t5100-mailinfo.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:58 -0700
Message-ID: <1395735989-3396-54-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:28:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMiF-0007wX-9t
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:27:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842AbaCYI1k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:27:40 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:49766 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831AbaCYI1g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:36 -0400
Received: by mail-pa0-f48.google.com with SMTP id hz1so132943pad.7
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=JtbYrj3vRZJ7qe5L3XCF4OtV1TP5+XA/6NFdbIkDc00=;
        b=JcfoM+9hOPkRe0OP/79g9Lj6g8q6HoHmVoTkg5Dkio7sO/kHuYZY3qys1gqv52dkdI
         7JSk0NVdnCssvxe/2MPBp1+9xuB3+tLBiGafZ/xJpf/fOsVRp9pTkPO7XpxSisDN+o+i
         Mwvh2G9ZcD9j3WRucGeQRKRicInnCTIPEKGZfsVkvM628tM6/D0pNSjgVIhleLYFGzEc
         LOpYcMauzo2y/O33kPigqRwSHXtICY+CuM+VJ88Nw5ndGEXtl3psiwUmGc4l2OIYfzjq
         5T+XcK1HBU/iuNePJcpwBExHKVmgmisAXiCF4mK/Viy/IsCPKbZtXAUDiENyu3fiZo3q
         UEew==
X-Received: by 10.66.159.233 with SMTP id xf9mr9376024pab.139.1395736056179;
        Tue, 25 Mar 2014 01:27:36 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.35
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244925>

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
 t/t5100-mailinfo.sh |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 3e64a7a..c279410 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -9,9 +9,9 @@ test_description=3D'git mailinfo and git mailsplit test=
'
=20
 test_expect_success 'split sample box' \
 	'git mailsplit -o. "$TEST_DIRECTORY"/t5100/sample.mbox >last &&
-	last=3D`cat last` &&
+	last=3D$(cat last) &&
 	echo total is $last &&
-	test `cat last` =3D 17'
+	test $(cat last) =3D 17'
=20
 check_mailinfo () {
 	mail=3D$1 opt=3D$2
@@ -23,7 +23,7 @@ check_mailinfo () {
 }
=20
=20
-for mail in `echo 00*`
+for mail in $(echo 00*)
 do
 	test_expect_success "mailinfo $mail" '
 		check_mailinfo $mail "" &&
@@ -43,11 +43,11 @@ test_expect_success 'split box with rfc2047 samples=
' \
 	'mkdir rfc2047 &&
 	git mailsplit -orfc2047 "$TEST_DIRECTORY"/t5100/rfc2047-samples.mbox =
\
 	  >rfc2047/last &&
-	last=3D`cat rfc2047/last` &&
+	last=3D$(cat rfc2047/last) &&
 	echo total is $last &&
-	test `cat rfc2047/last` =3D 11'
+	test $(cat rfc2047/last) =3D 11'
=20
-for mail in `echo rfc2047/00*`
+for mail in $(echo rfc2047/00*)
 do
 	test_expect_success "mailinfo $mail" '
 		git mailinfo -u $mail-msg $mail-patch <$mail >$mail-info &&
--=20
1.7.10.4
