From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 042/144] t4012-diff-binary.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:47 -0700
Message-ID: <1395735989-3396-43-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:34:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMoN-00073A-4W
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753797AbaCYI11 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:27:27 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:36693 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753771AbaCYI1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:25 -0400
Received: by mail-pd0-f176.google.com with SMTP id r10so129950pdi.21
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=hi1+hdElbYAgT+krP9plbXj0otzZkI3cXw/u4Vps4Ho=;
        b=A3sYvRlLV/8TrZfbKgW+YSfwodjNh4hvmV5gMRXc8Pa1/wGbWwdTQE71GBB4DcoUzC
         TNzvK+7VpK+W1CwB1kKHgkM0dp7NE5/Gwfe6LCrlSqu43I+60QAkrQ3lNklQrW8QWAyq
         aiMUHn2HOXtGzDHHQX4yJ24turtPull1ke5VU6qG+2mAE1Cod+PEaJGPQE59zSEHAc/r
         vRaCruN8dIFAvJIMqfXq1tRHZFBump5kLpTnZ9m5WglPbfdk6Qnm7Bp6qcDTmgntyZpP
         VSXylgl7NfxNhEKg7XjUf0enDB/S9fD53piktxQfzxNBH9gD1To8vclPMg5Fc3ZAdfbR
         GtzQ==
X-Received: by 10.68.224.195 with SMTP id re3mr76803114pbc.93.1395736044899;
        Tue, 25 Mar 2014 01:27:24 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244983>

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
 t/t4012-diff-binary.sh |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index 1215ae5..643d729 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -67,18 +67,18 @@ test_expect_success C_LOCALE_OUTPUT 'apply detectin=
g corrupt patch correctly' '
 	git diff >output &&
 	sed -e "s/-CIT/xCIT/" <output >broken &&
 	test_must_fail git apply --stat --summary broken 2>detected &&
-	detected=3D`cat detected` &&
-	detected=3D`expr "$detected" : "fatal.*at line \\([0-9]*\\)\$"` &&
-	detected=3D`sed -ne "${detected}p" broken` &&
+	detected=3D$(cat detected) &&
+	detected=3D$(expr "$detected" : "fatal.*at line \\([0-9]*\\)\$") &&
+	detected=3D$(sed -ne "${detected}p" broken) &&
 	test "$detected" =3D xCIT
 '
=20
 test_expect_success C_LOCALE_OUTPUT 'apply detecting corrupt patch cor=
rectly' '
 	git diff --binary | sed -e "s/-CIT/xCIT/" >broken &&
 	test_must_fail git apply --stat --summary broken 2>detected &&
-	detected=3D`cat detected` &&
-	detected=3D`expr "$detected" : "fatal.*at line \\([0-9]*\\)\$"` &&
-	detected=3D`sed -ne "${detected}p" broken` &&
+	detected=3D$(cat detected) &&
+	detected=3D$(expr "$detected" : "fatal.*at line \\([0-9]*\\)\$") &&
+	detected=3D$(sed -ne "${detected}p" broken) &&
 	test "$detected" =3D xCIT
 '
=20
@@ -88,7 +88,7 @@ test_expect_success 'initial commit' 'git commit -a -=
m initial'
 test_expect_success 'diff-index with --binary' '
 	echo AIT >a && mv b e && echo CIT >c && cat e >d &&
 	git update-index --add --remove a b c d e &&
-	tree0=3D`git write-tree` &&
+	tree0=3D$(git write-tree) &&
 	git diff --cached --binary >current &&
 	git apply --stat --summary current
 '
@@ -96,7 +96,7 @@ test_expect_success 'diff-index with --binary' '
 test_expect_success 'apply binary patch' '
 	git reset --hard &&
 	git apply --binary --index <current &&
-	tree1=3D`git write-tree` &&
+	tree1=3D$(git write-tree) &&
 	test "$tree1" =3D "$tree0"
 '
=20
--=20
1.7.10.4
