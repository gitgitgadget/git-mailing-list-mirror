From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/13] test-wildmatch: fix tests that fail on Windows due to path mangling
Date: Sun, 11 Nov 2012 17:13:56 +0700
Message-ID: <1352628837-5784-1-git-send-email-pclouds@gmail.com>
References: <5096D76F.5090907@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 11:16:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXUaU-0005Xw-RE
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 11:16:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562Ab2KKKOH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Nov 2012 05:14:07 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:59544 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854Ab2KKKOF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 05:14:05 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so2311368dak.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 02:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ZeP+jVq905EJGtttsJigVsoH/IW3ENDFDo7rgX39Xjw=;
        b=l9OKFjMZHbPko3fmTX5QXdGrOeT4/9u9r78ewfRx9t04PXGoBryhFUS9Sof/7ipfa6
         nqbVWqv601mHLTcdsHiX66h4lnQH18OjvXp4I+SghseYhB+GoKDBusArB0x+rXDxE6yF
         8OGbyqTLemfjmHkUJUs0X+5BwMMnTgbxSlJgu3fakf5j7tc+vNGiMNGioy1zQkpPgBHE
         VpBPP2SzEf5pFgdjfjjqA1s65Ohyf2z7RkD/3e7M8QFgCpAhhmCYhKw/tspwo1jBfxZh
         9D4aGLaqb612NKi5NnJCC5QIalNOCqrWORH/q157SRRKmjBT3MfSrO0hUZL1KPyym3iF
         UNZw==
Received: by 10.68.130.197 with SMTP id og5mr48222458pbb.138.1352628844594;
        Sun, 11 Nov 2012 02:14:04 -0800 (PST)
Received: from lanh ([115.74.37.170])
        by mx.google.com with ESMTPS id jw10sm2328568pbb.20.2012.11.11.02.13.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 02:14:02 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 11 Nov 2012 17:14:02 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <5096D76F.5090907@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209329>

Patterns beginning with a slash are converted to Windows paths before
test-wildmatch gets to see them. Avoid this case by always writing
XXX/abc instead of /abc. The leading XXX will be removed by
test-wildmatch itself before processing.

Any patterns beginning with a forward slash is rejected by
test-wildmatch to avoid the same fault in future.

Reported-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On top of nd/wildmatch, apparently.

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
1.8.0.rc2.23.g1fb49df
