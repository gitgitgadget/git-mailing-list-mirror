From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 074/144] t5570-git-daemon.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:19 -0700
Message-ID: <1395735989-3396-75-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:31:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMlI-0003Dg-5O
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:31:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999AbaCYIao convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:30:44 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:51744 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001AbaCYI17 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:59 -0400
Received: by mail-pa0-f42.google.com with SMTP id fb1so130541pad.15
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Hjz58Lm24jC/iYWbTz2sG6fcnQAdLADa3SBFhzYE9ME=;
        b=VSYXRD8lRghHYbGmquHdJNIrMaZZwe+oRIKnSUxDqsJBjk6fU8/yUxgglxCnvj2nXC
         he04nkrG3mekPm5/rvekkbAEefQHhjl1HlMhiOUq7AR+SEZQze0qP+cBOT6eCBI7veld
         oYFAy90kZ8RzRq8K/8TY6V5VPxKOU2WoCeCOZlqpxMbHUFQSzw5Kk5pS53TXKORbvBil
         jy5tHl60ARImuoA3MPjOsHAhsf3eakhANaZkI6CM6BpDj6czml06jaqNCPUaI0iOudXa
         URHXgdNS9H6FmUzPlGJLsV6b8iW9bewI3dC78d7qKXjWLnwyo2bCxyfZotWpvVQMaXjd
         hrjw==
X-Received: by 10.66.122.72 with SMTP id lq8mr78401683pab.69.1395736078869;
        Tue, 25 Mar 2014 01:27:58 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.57
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244961>

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
 t/t5570-git-daemon.sh |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index 6b16379..eb07dbe 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -57,7 +57,7 @@ test_expect_success 'prepare pack objects' '
 test_expect_success 'fetch notices corrupt pack' '
 	cp -R "$GIT_DAEMON_DOCUMENT_ROOT_PATH"/repo_pack.git "$GIT_DAEMON_DOC=
UMENT_ROOT_PATH"/repo_bad1.git &&
 	(cd "$GIT_DAEMON_DOCUMENT_ROOT_PATH"/repo_bad1.git &&
-	 p=3D`ls objects/pack/pack-*.pack` &&
+	 p=3D$(ls objects/pack/pack-*.pack) &&
 	 chmod u+w $p &&
 	 printf %0256d 0 | dd of=3D$p bs=3D256 count=3D1 seek=3D1 conv=3Dnotr=
unc
 	) &&
@@ -65,14 +65,14 @@ test_expect_success 'fetch notices corrupt pack' '
 	(cd repo_bad1.git &&
 	 git --bare init &&
 	 test_must_fail git --bare fetch "$GIT_DAEMON_URL/repo_bad1.git" &&
-	 test 0 =3D `ls objects/pack/pack-*.pack | wc -l`
+	 test 0 =3D $(ls objects/pack/pack-*.pack | wc -l)
 	)
 '
=20
 test_expect_success 'fetch notices corrupt idx' '
 	cp -R "$GIT_DAEMON_DOCUMENT_ROOT_PATH"/repo_pack.git "$GIT_DAEMON_DOC=
UMENT_ROOT_PATH"/repo_bad2.git &&
 	(cd "$GIT_DAEMON_DOCUMENT_ROOT_PATH"/repo_bad2.git &&
-	 p=3D`ls objects/pack/pack-*.idx` &&
+	 p=3D$(ls objects/pack/pack-*.idx) &&
 	 chmod u+w $p &&
 	 printf %0256d 0 | dd of=3D$p bs=3D256 count=3D1 seek=3D1 conv=3Dnotr=
unc
 	) &&
@@ -80,7 +80,7 @@ test_expect_success 'fetch notices corrupt idx' '
 	(cd repo_bad2.git &&
 	 git --bare init &&
 	 test_must_fail git --bare fetch "$GIT_DAEMON_URL/repo_bad2.git" &&
-	 test 0 =3D `ls objects/pack | wc -l`
+	 test 0 =3D $(ls objects/pack | wc -l)
 	)
 '
=20
--=20
1.7.10.4
