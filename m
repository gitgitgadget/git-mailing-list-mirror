From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 11/12] Support "**" wildcard in .gitignore and .gitattributes
Date: Wed, 10 Oct 2012 17:40:50 +0700
Message-ID: <1349865651-31889-12-git-send-email-pclouds@gmail.com>
References: <1349865651-31889-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 10 12:42:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLtk7-000375-2x
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 12:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755737Ab2JJKmN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 06:42:13 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:65220 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755725Ab2JJKmL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 06:42:11 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so576624pbb.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2012 03:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=nCTTBfC8dh8Asmc3TcFrGXNu69n5WpgH7drsCtVZV9Q=;
        b=KU5rln2AKdj0FpnXy7GCq4TowWc6QT+0blBga2pKnJzmIYuMl6gGkh4zx4A+sqGnpV
         E5IucMTAQSzsTFKwaBhbICPsrdAfvg/rz021ATmShk6PG6SnugluGaURe0YowMrWY53u
         Hd4j9KYJA3HDFdW350yvTlWwpzzmNr5bdZ9yhNbNVbVnbsHMzdulHcEyhTNjHA7wkP1q
         utHLnTfh4IqcGIYVUPuMXWectkhorFbBp4Ah4dJkJ4V1YEoe3IqtMe3cAPRjvzgy1gjm
         P+BBgZx2rFmDDX1ekRWxPPC3N0uPqZXrRAEs+XtDczgAlQuguzJPlIGYueepntNPV+TL
         JAhg==
Received: by 10.66.81.138 with SMTP id a10mr32933459pay.53.1349865730010;
        Wed, 10 Oct 2012 03:42:10 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id oe5sm853099pbb.8.2012.10.10.03.42.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Oct 2012 03:42:09 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 10 Oct 2012 17:42:01 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
In-Reply-To: <1349865651-31889-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207396>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/gitattributes.txt    |  6 ++++++
 Documentation/gitignore.txt        | 19 +++++++++++++++++++
 attr.c                             |  4 +++-
 dir.c                              |  4 +++-
 t/t0003-attributes.sh              | 38 ++++++++++++++++++++++++++++++=
++++++++
 t/t3001-ls-files-others-exclude.sh | 19 +++++++++++++++++++
 6 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribu=
tes.txt
index 99ed04d..93c542b 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -57,6 +57,12 @@ overrides an earlier line.  This overriding is done =
per
 attribute.  The rules how the pattern matches paths are the
 same as in `.gitignore` files; see linkgit:gitignore[5].
=20
+Note that if a .gitignore rule matches a directory, the directory
+is ignored, which may be seen as "ignore" attribute propagated to
+to all files and directories inside. If a .gitattributes rule
+matches a directory, it manipulates attributes on that directory
+only, not files and directories inside.
+
 When deciding what attributes are assigned to a path, git
 consults `$GIT_DIR/info/attributes` file (which has the highest
 precedence), `.gitattributes` file in the same directory as the
diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 96639e0..b564b4b 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -104,6 +104,25 @@ PATTERN FORMAT
    For example, "/{asterisk}.c" matches "cat-file.c" but not
    "mozilla-sha1/sha1.c".
=20
+Two consecutive asterisks ("`**`") in patterns matched against
+full pathname may have special meaning:
+
+ - A leading "`**`" followed by a slash means match in all
+   directories. For example, "`**/foo`" matches file or directory
+   "`foo`" anywhere, the same as pattern "`foo`". "**/foo/bar"
+   matches file or directory "`bar`" anywhere that is directly
+   under directory "`foo`".
+
+ - A trailing "/**" matches everything inside. For example,
+   "abc/**" matches all files inside directory "abc", relative
+   to the location of the `.gitignore` file, with infinite depth.
+
+ - A slash followed by two consecutive asterisks then a slash
+   matches zero or more directories. For example, "`a/**/b`"
+   matches "`a/b`", "`a/x/b`", "`a/x/y/b`" and so on.
+
+ - Other consecutive asterisks are considered invalid.
+
 NOTES
 -----
=20
diff --git a/attr.c b/attr.c
index 887a9ae..8010429 100644
--- a/attr.c
+++ b/attr.c
@@ -12,6 +12,7 @@
 #include "exec_cmd.h"
 #include "attr.h"
 #include "dir.h"
+#include "wildmatch.h"
=20
 const char git_attr__true[] =3D "(builtin)true";
 const char git_attr__false[] =3D "\0(builtin)false";
@@ -666,7 +667,8 @@ static int path_matches(const char *pathname, int p=
athlen,
 		return 0;
 	if (baselen !=3D 0)
 		baselen++;
-	return fnmatch_icase(pattern, pathname + baselen, FNM_PATHNAME) =3D=3D=
 0;
+	return wildmatch(pattern, pathname + baselen,
+			 ignore_case ? FNM_CASEFOLD : 0) =3D=3D 0;
 }
=20
 static int macroexpand_one(int attr_nr, int rem);
diff --git a/dir.c b/dir.c
index 4868339..442db1c 100644
--- a/dir.c
+++ b/dir.c
@@ -8,6 +8,7 @@
 #include "cache.h"
 #include "dir.h"
 #include "refs.h"
+#include "wildmatch.h"
=20
 struct path_simplify {
 	int len;
@@ -575,7 +576,8 @@ int excluded_from_list(const char *pathname,
 			namelen -=3D prefix;
 		}
=20
-		if (!namelen || !fnmatch_icase(exclude, name, FNM_PATHNAME))
+		if (!namelen ||
+		    wildmatch(exclude, name, ignore_case ? FNM_CASEFOLD : 0) =3D=3D =
0)
 			return to_exclude;
 	}
 	return -1; /* undecided */
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index febc45c..67a5694 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -232,4 +232,42 @@ test_expect_success 'bare repository: test info/at=
tributes' '
 	attr_check subdir/a/i unspecified
 '
=20
+test_expect_success '"**" test' '
+	cd .. &&
+	echo "**/f foo=3Dbar" >.gitattributes &&
+	cat <<\EOF >expect &&
+f: foo: bar
+a/f: foo: bar
+a/b/f: foo: bar
+a/b/c/f: foo: bar
+EOF
+	git check-attr foo -- "f" >actual 2>err &&
+	git check-attr foo -- "a/f" >>actual 2>>err &&
+	git check-attr foo -- "a/b/f" >>actual 2>>err &&
+	git check-attr foo -- "a/b/c/f" >>actual 2>>err &&
+	test_cmp expect actual &&
+	test_line_count =3D 0 err
+'
+
+test_expect_success '"**" with no slashes test' '
+	echo "a**f foo=3Dbar" >.gitattributes &&
+	git check-attr foo -- "f" >actual &&
+	cat <<\EOF >expect &&
+f: foo: unspecified
+af: foo: bar
+axf: foo: bar
+a/f: foo: unspecified
+a/b/f: foo: unspecified
+a/b/c/f: foo: unspecified
+EOF
+	git check-attr foo -- "f" >actual 2>err &&
+	git check-attr foo -- "af" >>actual 2>err &&
+	git check-attr foo -- "axf" >>actual 2>err &&
+	git check-attr foo -- "a/f" >>actual 2>>err &&
+	git check-attr foo -- "a/b/f" >>actual 2>>err &&
+	git check-attr foo -- "a/b/c/f" >>actual 2>>err &&
+	test_cmp expect actual &&
+	test_line_count =3D 0 err
+'
+
 test_done
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-othe=
rs-exclude.sh
index c8fe978..278315d 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -214,4 +214,23 @@ test_expect_success 'subdirectory ignore (l1)' '
 	test_cmp expect actual
 '
=20
+
+test_expect_success 'ls-files with "**" patterns' '
+	cat <<\EOF >expect &&
+a.1
+one/a.1
+one/two/a.1
+three/a.1
+EOF
+	git ls-files -o -i --exclude "**/a.1" >actual
+	test_cmp expect actual
+'
+
+
+test_expect_success 'ls-files with "**" patterns and no slashes' '
+	: >expect &&
+	git ls-files -o -i --exclude "one**a.1" >actual &&
+	test_cmp expect actual
+'
+
 test_done
--=20
1.7.12.1.406.g6ab07c4
