From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH] git-grep: Fix problems with recently added tests
Date: Thu, 26 May 2011 23:50:22 +0200
Message-ID: <1306446622-12784-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 23:50:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPiS4-0003r6-48
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 23:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758218Ab1EZVuj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 May 2011 17:50:39 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54982 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440Ab1EZVui (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 17:50:38 -0400
Received: by wwa36 with SMTP id 36so1234319wwa.1
        for <git@vger.kernel.org>; Thu, 26 May 2011 14:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=re1WSlNb14PdMz2OdpuvSEoYc0g3BPtoJ6bfxFTprbk=;
        b=SP627IqlVDm4J0xM/Jyj/5Hm41S0UX/vefA5pqnZv6tC7UB6KOkLC8+kmJC5gDthkQ
         3XQVVofWcdwRtrDFs7ar5edeXLV/LOaOnvakF37BL5kj+a7V7ovI6iNRNTzMNPqyKSbq
         cBvwlS4bC79lApq2OLrFer45rWrvkDXClY7AY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=CIsNO7neZtSoOlo6deYp53Om06bXlwS1JYEmMf7gt/3Sh+Dc+Xa9hRjbCFbWaeTxB+
         NidcEUD+paQTC21BVX0XnGJXcwxS7D0OtyemMnz7ywZ6bsmE5LR2Wbv5YBDMN6CvFxFW
         wlP12KRLJzLcxdDzOTVNnQkQJ3IrzhSgF5kWQ=
Received: by 10.216.143.96 with SMTP id k74mr6224925wej.100.1306446637641;
        Thu, 26 May 2011 14:50:37 -0700 (PDT)
Received: from localhost (85-177-78-94.net.stream.pl [94.78.177.85])
        by mx.google.com with ESMTPS id b70sm627214wek.44.2011.05.26.14.50.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 May 2011 14:50:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174580>

Brian Gernhardt reported that test 'git grep -E -F -G a\\+b' fails on
OS X 10.6.7. This is because I assumed \+ is part of BRE, which isn't
true on all platforms.

The easiest way to make this test pass is to just update expected
output, but that would make the test pointless. Its real purpose is to
check whether 'git grep -E -F -G' is different from 'git grep -E -G -F'=
=2E
To check that, let's change pattern to "aa*b". 'git grep -F' should
return empty string and 'git grep -G' should match "aab".

I also made two small tweaks to the tests. First, I added path "ab" to
all calls to future-proof tests. Second, I updated last two tests to
better show that 'git grep -P -E' is different from 'git grep -E -P'.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
 t/t7810-grep.sh |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index e061108..0435740 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -234,13 +234,13 @@ do
 	'
 	test_expect_success "grep $L with grep.extendedRegexp=3Dfalse" '
 		echo "ab:a+b" >expected &&
-		git -c grep.extendedRegexp=3Dfalse grep "a+b" >actual &&
+		git -c grep.extendedRegexp=3Dfalse grep "a+b" ab >actual &&
 		test_cmp expected actual
 	'
=20
 	test_expect_success "grep $L with grep.extendedRegexp=3Dtrue" '
 		echo "ab:aab" >expected &&
-		git -c grep.extendedRegexp=3Dtrue grep "a+b" >actual &&
+		git -c grep.extendedRegexp=3Dtrue grep "a+b" ab >actual &&
 		test_cmp expected actual
 	'
 done
@@ -688,37 +688,37 @@ test_expect_success LIBPCRE 'grep -P invalidpatte=
rn properly dies ' '
=20
 test_expect_success 'grep -F -E -G pattern' '
 	echo ab:a+b >expected &&
-	git grep -F -E -G a+b >actual &&
+	git grep -F -E -G a+b ab >actual &&
 	test_cmp expected actual
 '
=20
 test_expect_success 'grep -F -G -E pattern' '
 	echo ab:aab >expected &&
-	git grep -F -G -E a+b >actual &&
+	git grep -F -G -E a+b ab >actual &&
 	test_cmp expected actual
 '
=20
 test_expect_success 'grep -E -F -G pattern' '
 	echo ab:aab >expected &&
-	git grep -E -F -G a\\+b >actual &&
+	git grep -E -F -G "aa*b" ab >actual &&
 	test_cmp expected actual
 '
=20
 test_expect_success 'grep -E -G -F pattern' '
-	echo ab:a\\+b >expected &&
-	git grep -E -G -F a\\+b >actual &&
-	test_cmp expected actual
+	:>empty &&
+	test_must_fail git grep -E -G -F "aa*b" ab >actual &&
+	test_cmp empty actual
 '
=20
-test_expect_success 'grep -G -F -E pattern' '
-	echo ab:a+b >expected &&
-	git grep -G -F -E a\\+b >actual &&
-	test_cmp expected actual
+test_expect_success 'grep -G -F -P -E pattern' '
+	:>empty &&
+	test_must_fail git grep -G -F -P -E "a\x{2b}b" ab >actual &&
+	test_cmp empty actual
 '
=20
-test_expect_success LIBPCRE 'grep -E -G -F -P pattern' '
+test_expect_success LIBPCRE 'grep -G -F -E -P pattern' '
 	echo ab:a+b >expected &&
-	git grep -E -G -F -P a\\+b >actual &&
+	git grep -G -F -E -P "a\x{2b}b" ab >actual &&
 	test_cmp expected actual
 '
=20
--=20
1.7.3.4
