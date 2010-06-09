From: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Subject: [RFC/ PATCH 5/5] t7609: test merge and checkout error messages
Date: Wed,  9 Jun 2010 14:44:06 +0200
Message-ID: <1276087446-25112-7-git-send-email-diane.gasselin@ensimag.imag.fr>
References: <1276087446-25112-1-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276087446-25112-2-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276087446-25112-3-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276087446-25112-4-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276087446-25112-5-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276087446-25112-6-git-send-email-diane.gasselin@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Diane <diane.gasselin@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 09 15:20:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMLCz-00011z-9O
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 15:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757577Ab0FINUi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jun 2010 09:20:38 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33559 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757094Ab0FINUg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 09:20:36 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o59Cb6DE022385
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 9 Jun 2010 14:37:07 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o59Cio6Z010568;
	Wed, 9 Jun 2010 14:44:50 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id o59CioAw025424;
	Wed, 9 Jun 2010 14:44:50 +0200
Received: (from gasselid@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id o59Ciomc025423;
	Wed, 9 Jun 2010 14:44:50 +0200
X-Mailer: git-send-email 1.6.6.7.ga5fe3
In-Reply-To: <1276087446-25112-6-git-send-email-diane.gasselin@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 09 Jun 2010 14:37:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o59Cb6DE022385
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: diane.gasselin@ensimag.imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148773>

=46rom: Diane <diane.gasselin@ensimag.imag.fr>

Test porcelain and plumbing error messages for different types of error=
s
of merge and checkout.

Signed-off-by: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Signed-off-by: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
Signed-off-by: Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.fr>
---
 t/t7609-merge-co-error-msgs.sh |  122 ++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 122 insertions(+), 0 deletions(-)
 create mode 100755 t/t7609-merge-co-error-msgs.sh

diff --git a/t/t7609-merge-co-error-msgs.sh b/t/t7609-merge-co-error-ms=
gs.sh
new file mode 100755
index 0000000..8461e10
--- /dev/null
+++ b/t/t7609-merge-co-error-msgs.sh
@@ -0,0 +1,122 @@
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
+cat> expect <<EOF
+error: Untracked working tree files:
+	two
+	three
+	four
+	five
+would be overwritten by merge.
+EOF
+
+test_expect_success 'untracked files overwritten by merge' '
+	! git merge branch 2> out &&
+	test_cmp out expect
+'
+
+cat> expect <<EOF
+error: Your local changes to the files:
+	two
+	three
+	four
+would be overwritten by merge.
+Please, commit your changes or stash them before you can merge.
+error: Untracked working tree files:
+	five
+would be overwritten by merge.
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
+cat> expect <<EOF
+error: You have local changes to:
+	rep/two
+	rep/one
+cannot switch branches.
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
+cat> expect <<EOF
+error: Entry 'rep/one' would be overwritten by merge. Cannot merge.
+error: Entry 'rep/two' would be overwritten by merge. Cannot merge.
+EOF
+
+test_expect_success 'not uptodate file plumbing error' '
+	git add rep/one rep/two &&
+	! git checkout branch 2> out &&
+	test_cmp out expect
+'
+
+cat> expect <<EOF
+error: Updating 'rep' would lose untracked files in it
+error: Updating 'rep2' would lose untracked files in it
+EOF
+
+test_expect_success 'not_uptodate_dir plumbing error' '
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
+	touch rep &&
+	touch rep2 &&
+	git add rep rep2&&
+	git commit -m "added test as a file" &&
+	git checkout master &&
+	touch rep/untracked-file &&
+	touch rep2/untracked-file &&
+	! git checkout branch 2> out &&
+	test_cmp out ../expect
+'
+
+test_done
--=20
1.6.6.7.ga5fe3
