From: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Subject: [PATCH 5/5 v2] t7609: test merge and checkout error messages
Date: Tue, 15 Jun 2010 14:22:56 +0200
Message-ID: <1276604576-28092-6-git-send-email-diane.gasselin@ensimag.imag.fr>
References: <1276604576-28092-1-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276604576-28092-2-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276604576-28092-3-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276604576-28092-4-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276604576-28092-5-git-send-email-diane.gasselin@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	=?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 15 14:23:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOVAt-0006TW-T6
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 14:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093Ab0FOMXX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jun 2010 08:23:23 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56985 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754608Ab0FOMXP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 08:23:15 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o5FCFBYQ002492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 15 Jun 2010 14:15:11 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o5FCNCfS021144;
	Tue, 15 Jun 2010 14:23:12 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id o5FCNCF7028334;
	Tue, 15 Jun 2010 14:23:12 +0200
Received: (from gasselid@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id o5FCNCi2028333;
	Tue, 15 Jun 2010 14:23:12 +0200
X-Mailer: git-send-email 1.6.6.7.ga5fe3
In-Reply-To: <1276604576-28092-5-git-send-email-diane.gasselin@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 15 Jun 2010 14:15:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o5FCFBYQ002492
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: diane.gasselin@ensimag.imag.fr
MailScanner-NULL-Check: 1277208913.75995@ScbrBS+yXxqj6w7Tp8wXfw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149176>

Test porcelain and plumbing error messages for different types of error=
s
of merge and checkout.

Signed-off-by: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Signed-off-by: Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.fr>
Signed-off-by: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
---
 t/t7609-merge-co-error-msgs.sh |  125 ++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 125 insertions(+), 0 deletions(-)
 create mode 100755 t/t7609-merge-co-error-msgs.sh

diff --git a/t/t7609-merge-co-error-msgs.sh b/t/t7609-merge-co-error-ms=
gs.sh
new file mode 100755
index 0000000..b636b75
--- /dev/null
+++ b/t/t7609-merge-co-error-msgs.sh
@@ -0,0 +1,125 @@
+#!/bin/sh
+
+test_description=3D'unpack-trees error messages'
+
+. ./test-lib.sh
+
+
+test_expect_success 'setup' '
+	echo one >one &&
+	git add one &&
+	git commit -a -m First &&
+
+	git checkout -b branch &&
+	echo two>two &&
+	echo three>three &&
+	echo four>four &&
+	echo five>five &&
+	git add two three four five &&
+	git commit -m Second &&
+
+	git checkout master &&
+	echo other>two &&
+	echo other>three &&
+	echo other>four &&
+	echo other>five
+'
+
+cat> expect <<\EOF
+error: The following untracked working tree files would be overwritten=
 by merge:
+	two
+	three
+	four
+	five
+Please move or remove them before you can merge.
+EOF
+
+test_expect_success 'untracked files overwritten by merge' '
+	! git merge branch 2> out &&
+	test_cmp out expect
+'
+
+cat> expect <<\EOF
+error: Your local changes to the following files would be overwritten =
by merge:
+	two
+	three
+	four
+Please, commit your changes or stash them before you can merge.
+error: The following untracked working tree files would be overwritten=
 by merge:
+	five
+Please move or remove them before you can merge.
+EOF
+
+test_expect_success 'untracked files or local changes ovewritten by me=
rge' '
+	git add two &&
+	git add three &&
+	git add four &&
+	! git merge branch 2> out &&
+	test_cmp out expect
+'
+
+cat> expect <<\EOF
+error: You have local changes to the following files:
+	rep/two
+	rep/one
+Cannot switch branches.
+EOF
+
+test_expect_success 'cannot switch branches because of local changes' =
'
+	git add five &&
+	mkdir rep &&
+	echo one>rep/one &&
+	echo two>rep/two &&
+	git add rep/one rep/two &&
+	git commit -m Fourth &&
+	git checkout master &&
+	echo uno>rep/one &&
+	echo dos>rep/two &&
+	! git checkout branch 2> out &&
+	test_cmp out expect
+'
+
+cat> expect <<\EOF
+error: Your local changes to the following files would be overwritten =
by checkout:
+	rep/two
+	rep/one
+Please, commit your changes or stash them before you can swicth branch=
es.
+EOF
+
+test_expect_success 'not uptodate file porcelain checkout error' '
+	git add rep/one rep/two &&
+	! git checkout branch 2> out &&
+	test_cmp out expect
+'
+
+cat> expect <<\EOF
+error: Updating the following directories would lose untracked files i=
n it:
+	rep2
+	rep
+
+EOF
+
+test_expect_success 'not_uptodate_dir porcelain checkout error' '
+	git init uptodate &&
+	cd uptodate &&
+	mkdir rep &&
+	mkdir rep2 &&
+	touch rep/foo &&
+	touch rep2/foo &&
+	git add rep/foo rep2/foo &&
+	git commit -m init &&
+	git checkout -b branch &&
+	git rm rep -r &&
+	git rm rep2 -r &&
+	> rep &&
+	> rep2 &&
+	git add rep rep2&&
+	git commit -m "added test as a file" &&
+	git checkout master &&
+	> rep/untracked-file &&
+	> rep2/untracked-file &&
+	! git checkout branch 2> out &&
+	test_cmp out ../expect
+'
+
+test_done
--=20
1.6.6.7.ga5fe3
