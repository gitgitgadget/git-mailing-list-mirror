From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/2] t8005: convert CP1251 character set to ISO8859-5
Date: Fri, 22 May 2009 18:47:06 -0500
Message-ID: <p2A1PR1KFf_G_uMMwQZtVXPPBSNcQqEAV1ZnkoQLMJaPzWwJrkH_HCs5Kbt70yQlltZJxs4WxXo@cipher.nrlssc.navy.mil>
References: <7vhbzd85ux.fsf@alter.siamese.dyndns.org> <p2A1PR1KFf_G_uMMwQZtVeaDE_VcBr8lFjs9Jsg_OIkeypNbwPPRHP32EUHJ4leCZsycUOhFjHc@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat May 23 01:47:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7eSn-00050Q-TD
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 01:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758213AbZEVXrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 19:47:23 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758036AbZEVXrX
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 19:47:23 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:36837 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758173AbZEVXrV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 19:47:21 -0400
Received: by mail.nrlssc.navy.mil id n4MNlIYV002710; Fri, 22 May 2009 18:47:20 -0500
In-Reply-To: <p2A1PR1KFf_G_uMMwQZtVeaDE_VcBr8lFjs9Jsg_OIkeypNbwPPRHP32EUHJ4leCZsycUOhFjHc@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 22 May 2009 23:47:19.0149 (UTC) FILETIME=[A4CF19D0:01C9DB37]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119753>

On IRIX 6.5 CP1251 is unknown, but WIN1251 (which seems to be a
non-standard name) is known.  On Solaris 10, the opposite is true.  Sol=
aris
also knows CP1251 as WINDOWS-1251, but this too is not recognized on IR=
IX.
I could not find a name that both platforms recognized for this charact=
er
set.

An alternative character set which covers the same alphabet seems to be=
 the
ISO8859-5 character set.  Both platforms support this character set, so=
 use
it instead.

This allows t8005.4 to pass on Solaris 7, and part of the test to pass =
on
IRIX. (My IRIX can't convert SJIS to UTF-8 :(

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


This should still provide the same breadth of testing: a russian code s=
et,
a japanese code set, and unicode.  Wikipedia says that ISO8859-5 is not
as commonly used as either CP1251 or KOI8-R, but it is available on the=
se
old platforms.  You'd think that if Solaris 7 has it _and_ IRIX has it,
then everything else would too, but still feel free to drop this anyway=
=2E
Neither of those platforms, or Solaris 10 (for me) can convert between
any of the russian and japanese encodings, so t8005.[23] still fail, an=
d I
doubt there is any hope.

-brandon


 t/t8005-blame-i18n.sh |   26 +++++++++++++-------------
 t/t8005/cp1251.txt    |    2 --
 t/t8005/iso8859-5.txt |    2 ++
 3 files changed, 15 insertions(+), 15 deletions(-)
 delete mode 100644 t/t8005/cp1251.txt
 create mode 100644 t/t8005/iso8859-5.txt

diff --git a/t/t8005-blame-i18n.sh b/t/t8005-blame-i18n.sh
index 75cbced..4460975 100755
--- a/t/t8005-blame-i18n.sh
+++ b/t/t8005-blame-i18n.sh
@@ -4,7 +4,7 @@ test_description=3D'git blame encoding conversion'
 . ./test-lib.sh
=20
 . "$TEST_DIRECTORY"/t8005/utf8.txt
-. "$TEST_DIRECTORY"/t8005/cp1251.txt
+. "$TEST_DIRECTORY"/t8005/iso8859-5.txt
 . "$TEST_DIRECTORY"/t8005/sjis.txt
=20
 test_expect_success 'setup the repository' '
@@ -13,10 +13,10 @@ test_expect_success 'setup the repository' '
 	git add file &&
 	git commit --author "$UTF8_NAME <utf8@localhost>" -m "$UTF8_MSG" &&
=20
-	echo "CP1251 LINE" >> file &&
+	echo "KOI8-R LINE" >> file &&
 	git add file &&
-	git config i18n.commitencoding cp1251 &&
-	git commit --author "$CP1251_NAME <cp1251@localhost>" -m "$CP1251_MSG=
" &&
+	git config i18n.commitencoding ISO8859-5 &&
+	git commit --author "$ISO8859_5_NAME <iso8859-5@localhost>" -m "$ISO8=
859_5_MSG" &&
=20
 	echo "SJIS LINE" >> file &&
 	git add file &&
@@ -41,17 +41,17 @@ test_expect_success \
 '
=20
 cat >expected <<EOF
-author $CP1251_NAME
-summary $CP1251_MSG
-author $CP1251_NAME
-summary $CP1251_MSG
-author $CP1251_NAME
-summary $CP1251_MSG
+author $ISO8859_5_NAME
+summary $ISO8859_5_MSG
+author $ISO8859_5_NAME
+summary $ISO8859_5_MSG
+author $ISO8859_5_NAME
+summary $ISO8859_5_MSG
 EOF
=20
 test_expect_success \
 	'blame respects i18n.logoutputencoding' '
-	git config i18n.logoutputencoding cp1251 &&
+	git config i18n.logoutputencoding ISO8859-5 &&
 	git blame --incremental file | \
 		egrep "^(author|summary) " > actual &&
 	test_cmp actual expected
@@ -76,8 +76,8 @@ test_expect_success \
 cat >expected <<EOF
 author $SJIS_NAME
 summary $SJIS_MSG
-author $CP1251_NAME
-summary $CP1251_MSG
+author $ISO8859_5_NAME
+summary $ISO8859_5_MSG
 author $UTF8_NAME
 summary $UTF8_MSG
 EOF
diff --git a/t/t8005/cp1251.txt b/t/t8005/cp1251.txt
deleted file mode 100644
index ce41e98..0000000
--- a/t/t8005/cp1251.txt
+++ /dev/null
@@ -1,2 +0,0 @@
-CP1251_NAME=3D"=C8=E2=E0=ED =CF=E5=F2=F0=EE=E2=E8=F7 =D1=E8=E4=EE=F0=EE=
=E2"
-CP1251_MSG=3D"=D2=E5=F1=F2=EE=E2=EE=E5 =F1=EE=EE=E1=F9=E5=ED=E8=E5"
diff --git a/t/t8005/iso8859-5.txt b/t/t8005/iso8859-5.txt
new file mode 100644
index 0000000..2e4b80c
--- /dev/null
+++ b/t/t8005/iso8859-5.txt
@@ -0,0 +1,2 @@
+ISO8859_5_NAME=3D"=B8=D2=D0=DD =BF=D5=E2=E0=DE=D2=D8=E7 =C1=D8=D4=DE=E0=
=DE=D2"
+ISO8859_5_MSG=3D"=C2=D5=E1=E2=DE=D2=DE=D5 =E1=DE=DE=D1=E9=D5=DD=D8=D5"
--=20
1.6.3.1.24.g152f4
