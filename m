From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH 14/13] test-wildmatch: avoid Windows path mangling
Date: Wed, 21 Nov 2012 07:41:45 +0100
Message-ID: <50AC77A9.90601@viscovery.net>
References: <7vvcdco1pf.fsf@alter.siamese.dyndns.org> <50AB2B0F.8090808@viscovery.net> <7vd2z8rq4y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4g?= =?UTF-8?B?VGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 07:42:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tb40g-0002qe-UC
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 07:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129Ab2KUGly convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Nov 2012 01:41:54 -0500
Received: from so.liwest.at ([212.33.55.13]:54113 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824Ab2KUGlx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Nov 2012 01:41:53 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Tb40I-0004pQ-5U; Wed, 21 Nov 2012 07:41:46 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id C12291660F;
	Wed, 21 Nov 2012 07:41:45 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
In-Reply-To: <7vd2z8rq4y.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210139>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

The MSYS bash mangles arguments that begin with a forward slash
when they are passed to test-wildmatch. This causes tests to fail.
Avoid mangling by prepending "XXX", which is removed by
test-wildmatch before further processing.

[J6t: reworded commit message]

Reported-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 11/20/2012 21:11, schrieb Junio C Hamano:
> Thanks, but you need to fix your format-patch somehow.

No, it was Thunderbird. It ate the blank lines when I said "Edit as new=
"
to forward the patch directly from the mailbox.

Sorry for the inconvenience.

 t/t3070-wildmatch.sh | 10 +++++-----
 test-wildmatch.c     |  8 ++++++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index e6ad6f4..3155eab 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -74,7 +74,7 @@ match 0 0 'foo/bar' 'foo[/]bar'
 match 0 0 'foo/bar' 'f[^eiu][^eiu][^eiu][^eiu][^eiu]r'
 match 1 1 'foo-bar' 'f[^eiu][^eiu][^eiu][^eiu][^eiu]r'
 match 1 0 'foo' '**/foo'
-match 1 x '/foo' '**/foo'
+match 1 x 'XXX/foo' '**/foo'
 match 1 0 'bar/baz/foo' '**/foo'
 match 0 0 'bar/baz/foo' '*/foo'
 match 0 0 'foo/bar/baz' '**/bar*'
@@ -95,8 +95,8 @@ match 0 0 ']' '[!]-]'
 match 1 x 'a' '[!]-]'
 match 0 0 '' '\'
 match 0 x '\' '\'
-match 0 x '/\' '*/\'
-match 1 x '/\' '*/\\'
+match 0 x 'XXX/\' '*/\'
+match 1 x 'XXX/\' '*/\\'
 match 1 1 'foo' 'foo'
 match 1 1 '@foo' '@foo'
 match 0 0 'foo' '@foo'
@@ -187,8 +187,8 @@ match 0 0 '-' '[[-\]]'
 match 1 1 '-adobe-courier-bold-o-normal--12-120-75-75-m-70-iso8859-1' =
'-*-*-*-*-*-*-12-*-*-*-m-*-*-*'
 match 0 0 '-adobe-courier-bold-o-normal--12-120-75-75-X-70-iso8859-1' =
'-*-*-*-*-*-*-12-*-*-*-m-*-*-*'
 match 0 0 '-adobe-courier-bold-o-normal--12-120-75-75-/-70-iso8859-1' =
'-*-*-*-*-*-*-12-*-*-*-m-*-*-*'
-match 1 1 '/adobe/courier/bold/o/normal//12/120/75/75/m/70/iso8859/1' =
'/*/*/*/*/*/*/12/*/*/*/m/*/*/*'
-match 0 0 '/adobe/courier/bold/o/normal//12/120/75/75/X/70/iso8859/1' =
'/*/*/*/*/*/*/12/*/*/*/m/*/*/*'
+match 1 1 'XXX/adobe/courier/bold/o/normal//12/120/75/75/m/70/iso8859/=
1' 'XXX/*/*/*/*/*/*/12/*/*/*/m/*/*/*'
+match 0 0 'XXX/adobe/courier/bold/o/normal//12/120/75/75/X/70/iso8859/=
1' 'XXX/*/*/*/*/*/*/12/*/*/*/m/*/*/*'
 match 1 0 'abcd/abcdefg/abcdefghijk/abcdefghijklmnop.txt' '**/*a*b*g*n=
*t'
 match 0 0 'abcd/abcdefg/abcdefghijk/abcdefghijklmnop.txtz' '**/*a*b*g*=
n*t'
=20
diff --git a/test-wildmatch.c b/test-wildmatch.c
index 74c0864..e384c8e 100644
--- a/test-wildmatch.c
+++ b/test-wildmatch.c
@@ -3,6 +3,14 @@
=20
 int main(int argc, char **argv)
 {
+	int i;
+	for (i =3D 2; i < argc; i++) {
+		if (argv[i][0] =3D=3D '/')
+			die("Forward slash is not allowed at the beginning of the\n"
+			    "pattern because Windows does not like it. Use `XXX/' instead."=
);
+		else if (!strncmp(argv[i], "XXX/", 4))
+			argv[i] +=3D 3;
+	}
 	if (!strcmp(argv[1], "wildmatch"))
 		return !!wildmatch(argv[3], argv[2], 0);
 	else if (!strcmp(argv[1], "iwildmatch"))
--=20
1.8.0.1417.gf6038d8
