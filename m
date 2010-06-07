From: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
Subject: [PATCH v2 3/3] t/t8006: test textconv support for blame
Date: Mon,  7 Jun 2010 17:23:38 +0200
Message-ID: <1275924218-20154-3-git-send-email-axel.bonnet@ensimag.imag.fr>
References: <1275921713-3277-1-git-send-email-axel.bonnet@ensimag.imag.fr>
 <1275924218-20154-1-git-send-email-axel.bonnet@ensimag.imag.fr>
 <1275924218-20154-2-git-send-email-axel.bonnet@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 07 17:24:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLeBM-0006II-6s
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 17:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982Ab0FGPYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 11:24:00 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from mx2.imag.fr ([129.88.30.17]:42699 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751628Ab0FGPXv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 11:23:51 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o57FG8HQ028006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 7 Jun 2010 17:16:08 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o57FNl1C016003;
	Mon, 7 Jun 2010 17:23:47 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id o57FNlAe021002;
	Mon, 7 Jun 2010 17:23:47 +0200
Received: (from bonneta@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id o57FNlcJ021001;
	Mon, 7 Jun 2010 17:23:47 +0200
X-Mailer: git-send-email 1.6.6.7.ga5fe3
In-Reply-To: <1275924218-20154-2-git-send-email-axel.bonnet@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 07 Jun 2010 17:16:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o57FG8HQ028006
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: axel.bonnet@ensimag.imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148605>

Test the correct functionning of textconv with blame <file> and blame H=
EAD^ <file>.
Test the case when no driver is specified.

Signed-off-by: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
Signed-off-by: Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.fr>
Signed-off-by: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
---
 t/t8006-blame-textconv.sh |   80 +++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 80 insertions(+), 0 deletions(-)
 create mode 100755 t/t8006-blame-textconv.sh

diff --git a/t/t8006-blame-textconv.sh b/t/t8006-blame-textconv.sh
new file mode 100755
index 0000000..db51d4c
--- /dev/null
+++ b/t/t8006-blame-textconv.sh
@@ -0,0 +1,80 @@
+#!/bin/sh
+
+test_description=3D'git blame textconv support'
+. ./test-lib.sh
+
+find_blame() {
+	sed -e 's/^.*(/(/g'
+}
+
+cat >helper <<'EOF'
+#!/bin/sh
+sed 's/^/converted: /' "$@"
+EOF
+chmod +x helper
+
+test_expect_success 'setup ' '
+	echo test 1 >one.bin &&
+	echo test number 2 >two.bin &&
+	git add . &&
+	GIT_AUTHOR_NAME=3DNumber1 git commit -a -m First --date=3D"2010-01-01=
 18:00:00" &&
+	echo test 1 version 2 >one.bin &&
+	echo test number 2 version 2 >>two.bin &&
+	GIT_AUTHOR_NAME=3DNumber2 git commit -a -m Second --date=3D"2010-01-0=
1 20:00:00"
+'
+
+cat >expected <<EOF
+(Number2 2010-01-01 20:00:00 +0000 1) test 1 version 2
+EOF
+
+test_expect_success 'no filter specified' '
+	git blame one.bin >blame &&
+	find_blame Number2 <blame >result &&
+	test_cmp expected result
+'
+
+test_expect_success 'setup textconv filters' '
+	echo "*.bin diff=3Dtest" >.gitattributes &&
+	git config diff.test.textconv ./helper &&
+	git config diff.test.cachetextconv false
+'
+
+test_expect_success 'blame with --no-textconv' '
+	git blame --no-textconv one.bin >blame &&
+	find_blame <blame> result &&
+	test_cmp expected result
+'
+
+cat >expected <<EOF
+(Number2 2010-01-01 20:00:00 +0000 1) converted: test 1 version 2
+EOF
+
+test_expect_success 'basic blame on last commit' '
+	git blame one.bin >blame &&
+	find_blame  <blame >result &&
+	test_cmp expected result
+'
+
+cat >expected <<EOF
+(Number1 2010-01-01 18:00:00 +0000 1) converted: test number 2
+(Number2 2010-01-01 20:00:00 +0000 2) converted: test number 2 version=
 2
+EOF
+
+test_expect_success 'blame --textconv going through revisions' '
+	git blame --textconv two.bin >blame &&
+	find_blame <blame >result &&
+	test_cmp expected result
+'
+
+test_expect_success 'make a new commit' '
+	echo "test number 2 version 3" >>two.bin &&
+	GIT_AUTHOR_NAME=3DNumber3 git commit -a -m Third --date=3D"2010-01-01=
 22:00:00"
+'
+
+test_expect_success 'blame from previous revision' '
+	git blame HEAD^ two.bin >blame &&
+	find_blame <blame >result &&
+	test_cmp expected result
+'
+
+test_done
--=20
1.6.6.7.ga5fe3
