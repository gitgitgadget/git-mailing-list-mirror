From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 072/144] t5550-http-fetch-dumb.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:17 -0700
Message-ID: <1395735989-3396-73-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:28:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMiX-0008K0-CH
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909AbaCYI2A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:28:00 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:39981 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896AbaCYI15 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:57 -0400
Received: by mail-pd0-f169.google.com with SMTP id fp1so131143pdb.28
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=EsIHhNCbMa+I8X9xASGZGtWg2DLs90pHTSNYcZ9iGTg=;
        b=wqXq+/lrFOwx9bYaQ1vUTRohYOK4zbZcHIt1nvtn45P86QUMr/0TeB0KgB2CjIAGQ1
         D1c1MT1YOzX8R7mHgNhRM6m9wGdkJDtgNTXyb0kvvCu+iVZ9Jm4NtHFApdg3hCMBinWl
         /yr2AQrRAJ1fcrqbQkt7zq5yQ+dibS1/dq+8g0nd/y8K4Xyyin4790XyvYEz8uSJw4sz
         IT3isO/x5+gu2wKMdsfpEz8xs3PWT/JeaiovQZaMFGxYN06HL0pe5+eIrRjhK8wE0PTp
         ik2mn3n9iX43NGjqo81KPomXZju9hHbra/jhOZCeuh4PYqIQW+pCQE44SpGJJV/eeff5
         XEOQ==
X-Received: by 10.67.22.100 with SMTP id hr4mr77271146pad.112.1395736076645;
        Tue, 25 Mar 2014 01:27:56 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.55
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244930>

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
 t/t5550-http-fetch-dumb.sh |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 1a3a2b6..5ccb271 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -138,7 +138,7 @@ test_expect_success 'fetch packed objects' '
 test_expect_success 'fetch notices corrupt pack' '
 	cp -R "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git "$HTTPD_DOCUMENT_ROOT=
_PATH"/repo_bad1.git &&
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad1.git &&
-	 p=3D`ls objects/pack/pack-*.pack` &&
+	 p=3D$(ls objects/pack/pack-*.pack) &&
 	 chmod u+w $p &&
 	 printf %0256d 0 | dd of=3D$p bs=3D256 count=3D1 seek=3D1 conv=3Dnotr=
unc
 	) &&
@@ -146,14 +146,14 @@ test_expect_success 'fetch notices corrupt pack' =
'
 	(cd repo_bad1.git &&
 	 git --bare init &&
 	 test_must_fail git --bare fetch $HTTPD_URL/dumb/repo_bad1.git &&
-	 test 0 =3D `ls objects/pack/pack-*.pack | wc -l`
+	 test 0 =3D $(ls objects/pack/pack-*.pack | wc -l)
 	)
 '
=20
 test_expect_success 'fetch notices corrupt idx' '
 	cp -R "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git "$HTTPD_DOCUMENT_ROOT=
_PATH"/repo_bad2.git &&
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad2.git &&
-	 p=3D`ls objects/pack/pack-*.idx` &&
+	 p=3D$(ls objects/pack/pack-*.idx) &&
 	 chmod u+w $p &&
 	 printf %0256d 0 | dd of=3D$p bs=3D256 count=3D1 seek=3D1 conv=3Dnotr=
unc
 	) &&
@@ -161,7 +161,7 @@ test_expect_success 'fetch notices corrupt idx' '
 	(cd repo_bad2.git &&
 	 git --bare init &&
 	 test_must_fail git --bare fetch $HTTPD_URL/dumb/repo_bad2.git &&
-	 test 0 =3D `ls objects/pack | wc -l`
+	 test 0 =3D $(ls objects/pack | wc -l)
 	)
 '
=20
--=20
1.7.10.4
