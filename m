From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/4] dir.c: don't exclude whole dir prematurely
Date: Mon, 15 Feb 2016 16:03:39 +0700
Message-ID: <1455527019-7787-5-git-send-email-pclouds@gmail.com>
References: <1455527019-7787-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 10:04:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVF4e-0006GL-5u
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 10:04:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510AbcBOJDx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2016 04:03:53 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34084 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752454AbcBOJDp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 04:03:45 -0500
Received: by mail-pf0-f195.google.com with SMTP id 71so7261736pfv.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 01:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2CiOwjlV6zemIY9Ds/0865tdz32Mv4LuOgWETQSbOGQ=;
        b=bq4NBhZ6NiDdG8rtK/QtAU4NqG9SJiLfeRGm8xJAvKv+K3I/j6DaopSE+6b72zgK8W
         YCBG+OHJYS1FpQDSdrjcrqeVFvhsQGlzaCryBrlxfSbpYsCbqOAzU+iwT6ZBlyyD6RZK
         5ioj52OnEEGRo1C1nn0mnWp6sdjHJqPk3v7UKoxVAb/o/+/zjt4A4qZMpCHQqjSGwqbg
         20Qiu6o+7xYh1V0cFmOLxJNBAhNglgPbTw+bp4ugGNx4RQ/sbeOPLbNHQkCqWAxWpvPW
         GWyM4vNLAzVbKI1J6Ip/OFIWNBWILQQkcFyFkMBXcWgybHPDfP4OzTnaCowS0qMiYZVV
         UVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=2CiOwjlV6zemIY9Ds/0865tdz32Mv4LuOgWETQSbOGQ=;
        b=KwS2iwvYHfYmIqjIgB+Fg6DaxqcdR+O2STmit7fQVtaaqB3W47riAte/rLE4ffjTIc
         sw2S6j5Wl+NmPfoPPScah7QQ9bYomoCirrKRCtJ55DegFOkO00Nkf75/IjUSlhIpK9dE
         ybHWKwEMT41/NaYe4D7mhNbgbuES8SYdeBxJdWXNqYTy+m1RiPH4wNf2/MomT8PvhVdm
         exWw3Y6SccH1fZxImFILwOt3WG8l5L7LURRcWgIbmy1PJXtradU5IG0hgn3tXPsQz3Zn
         EzGnzmLJdk5o390t4L+l8kF4dbI9+vhbUUuMnraAmKKikMPKsfBy4/3nhoT/x6L28HD/
         0TIQ==
X-Gm-Message-State: AG10YOTCsj1U/X+9C4C48jbmcaZP4ed7FAMWnzew/amTOkjJppQ9xFMX86m+Y0TeUq4Qyw==
X-Received: by 10.98.13.86 with SMTP id v83mr21944007pfi.162.1455527025322;
        Mon, 15 Feb 2016 01:03:45 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id s23sm36793710pfi.12.2016.02.15.01.03.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2016 01:03:43 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 15 Feb 2016 16:04:07 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455527019-7787-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286188>

If there is a pattern "!foo/bar", this patch makes it not exclude
"foo" right away. This gives us a chance to examine "foo" and
re-include "foo/bar".

Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
Helped-by: Micha Wiedenmann <mw-u2@gmx.de>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/gitignore.txt                 |  17 +++-
 dir.c                                       | 109 +++++++++++++++++++-
 t/t3001-ls-files-others-exclude.sh          |   7 +-
 t/t3007-ls-files-other-negative.sh (new +x) | 153 ++++++++++++++++++++=
++++++++
 4 files changed, 276 insertions(+), 10 deletions(-)
 create mode 100755 t/t3007-ls-files-other-negative.sh

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 473623d..3ded6fd 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -82,12 +82,12 @@ PATTERN FORMAT
=20
  - An optional prefix "`!`" which negates the pattern; any
    matching file excluded by a previous pattern will become
-   included again. It is not possible to re-include a file if a parent
-   directory of that file is excluded. Git doesn't list excluded
-   directories for performance reasons, so any patterns on contained
-   files have no effect, no matter where they are defined.
+   included again.
    Put a backslash ("`\`") in front of the first "`!`" for patterns
    that begin with a literal "`!`", for example, "`\!important!.txt`".
+   It is possible to re-include a file if a parent directory of that
+   file is excluded if certain conditions are met. See section NOTES
+   for detail.
=20
  - If the pattern ends with a slash, it is removed for the
    purpose of the following description, but it would only find
@@ -141,6 +141,15 @@ not tracked by Git remain untracked.
 To stop tracking a file that is currently tracked, use
 'git rm --cached'.
=20
+To re-include files or directories when their parent directory is
+excluded, the following conditions must be met:
+
+ - The rules to exclude a directory and re-include a subset back must
+   be in the same .gitignore file.
+
+ - The directory part in the re-include rules must be literal (i.e. no
+   wildcards)
+
 EXAMPLES
 --------
=20
diff --git a/dir.c b/dir.c
index 8a9d8c0..552af23 100644
--- a/dir.c
+++ b/dir.c
@@ -930,6 +930,75 @@ static int match_sticky(struct exclude *exc, const=
 char *pathname, int pathlen,
 	return 0;
 }
=20
+static inline int different_decisions(const struct exclude *a,
+				      const struct exclude *b)
+{
+	return (a->flags & EXC_FLAG_NEGATIVE) !=3D (b->flags & EXC_FLAG_NEGAT=
IVE);
+}
+
+/*
+ * Return non-zero if pathname is a directory and an ancestor of the
+ * literal path in a pattern.
+ */
+static int match_directory_part(const char *pathname, int pathlen,
+				int *dtype, struct exclude *x)
+{
+	const char	*base	    =3D x->base;
+	int		 baselen    =3D x->baselen ? x->baselen - 1 : 0;
+	const char	*pattern    =3D x->pattern;
+	int		 prefix	    =3D x->nowildcardlen;
+	int		 patternlen =3D x->patternlen;
+
+	if (*dtype =3D=3D DT_UNKNOWN)
+		*dtype =3D get_dtype(NULL, pathname, pathlen);
+	if (*dtype !=3D DT_DIR)
+		return 0;
+
+	if (*pattern =3D=3D '/') {
+		pattern++;
+		patternlen--;
+		prefix--;
+	}
+
+	if (baselen) {
+		if (((pathlen < baselen && base[pathlen] =3D=3D '/') ||
+		     pathlen =3D=3D baselen) &&
+		    !strncmp_icase(pathname, base, pathlen))
+			return 1;
+		pathname +=3D baselen + 1;
+		pathlen  -=3D baselen + 1;
+	}
+
+
+	if (prefix &&
+	    (((pathlen < prefix && pattern[pathlen] =3D=3D '/') ||
+	      pathlen =3D=3D prefix) &&
+	     !strncmp_icase(pathname, pattern, pathlen)))
+		return 1;
+
+	return 0;
+}
+
+static struct exclude *should_descend(const char *pathname, int pathle=
n,
+				      int *dtype, struct exclude_list *el,
+				      struct exclude *exc)
+{
+	int i;
+
+	for (i =3D el->nr - 1; 0 <=3D i; i--) {
+		struct exclude *x =3D el->excludes[i];
+
+		if (x =3D=3D exc)
+			break;
+
+		if (!(x->flags & EXC_FLAG_NODIR) &&
+		    different_decisions(x, exc) &&
+		    match_directory_part(pathname, pathlen, dtype, x))
+			return x;
+	}
+	return NULL;
+}
+
 /*
  * Scan the given exclude list in reverse to see whether pathname
  * should be ignored.  The first match (i.e. the last on the list), if
@@ -943,7 +1012,7 @@ static struct exclude *last_exclude_matching_from_=
list(const char *pathname,
 						       struct exclude_list *el)
 {
 	struct exclude *exc =3D NULL; /* undecided */
-	int i;
+	int i, maybe_descend =3D 0;
=20
 	if (!el->nr)
 		return NULL;	/* undefined */
@@ -955,6 +1024,10 @@ static struct exclude *last_exclude_matching_from=
_list(const char *pathname,
 		const char *exclude =3D x->pattern;
 		int prefix =3D x->nowildcardlen;
=20
+		if (!maybe_descend && i < el->nr - 1 &&
+		    different_decisions(x, el->excludes[i+1]))
+			maybe_descend =3D 1;
+
 		if (x->sticky_paths.nr) {
 			if (*dtype =3D=3D DT_UNKNOWN)
 				*dtype =3D get_dtype(NULL, pathname, pathlen);
@@ -998,6 +1071,34 @@ static struct exclude *last_exclude_matching_from=
_list(const char *pathname,
 		return NULL;
 	}
=20
+	/*
+	 * We have found a matching pattern "exc" that may exclude whole
+	 * directory. We also found that there may be a pattern that matches
+	 * something inside the directory and reincludes stuff.
+	 *
+	 * Go through the patterns again, find that pattern and double check.
+	 * If it's true, return "undecided" and keep descending in. "exc" is
+	 * marked sticky so that it continues to match inside the directory.
+	 */
+	if (!(exc->flags & EXC_FLAG_NEGATIVE) && maybe_descend) {
+		struct exclude *x;
+
+		if (*dtype =3D=3D DT_UNKNOWN)
+			*dtype =3D get_dtype(NULL, pathname, pathlen);
+
+		if (*dtype =3D=3D DT_DIR &&
+		    (x =3D should_descend(pathname, pathlen, dtype, el, exc))) {
+			add_sticky(exc, pathname, pathlen);
+			trace_printf_key(&trace_exclude,
+					 "exclude: %.*s vs %s at line %d =3D> %s,"
+					 " forced open by %s at line %d =3D> n/a\n",
+					 pathlen, pathname, exc->pattern, exc->srcpos,
+					 exc->flags & EXC_FLAG_NEGATIVE ? "no" : "yes",
+					 x->pattern, x->srcpos);
+			return NULL;
+		}
+	}
+
 	trace_printf_key(&trace_exclude, "exclude: %.*s vs %s at line %d =3D>=
 %s%s\n",
 			 pathlen, pathname, exc->pattern, exc->srcpos,
 			 exc->flags & EXC_FLAG_NEGATIVE ? "no" : "yes",
@@ -2097,6 +2198,12 @@ int read_directory(struct dir_struct *dir, const=
 char *path, int len, const stru
 		return dir->nr;
=20
 	/*
+	 * Stay on the safe side. if read_directory() has run once on
+	 * "dir", some sticky flag may have been left. Clear them all.
+	 */
+	clear_sticky(dir);
+
+	/*
 	 * exclude patterns are treated like positive ones in
 	 * create_simplify. Usually exclude patterns should be a
 	 * subset of positive ones, which has no impacts on
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-othe=
rs-exclude.sh
index 3fc484e..d043078 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -175,13 +175,10 @@ test_expect_success 'negated exclude matches can =
override previous ones' '
 	grep "^a.1" output
 '
=20
-test_expect_success 'excluded directory overrides content patterns' '
+test_expect_success 'excluded directory does not override content patt=
erns' '
=20
 	git ls-files --others --exclude=3D"one" --exclude=3D"!one/a.1" >outpu=
t &&
-	if grep "^one/a.1" output
-	then
-		false
-	fi
+	grep "^one/a.1" output
 '
=20
 test_expect_success 'negated directory doesn'\''t affect content patte=
rns' '
diff --git a/t/t3007-ls-files-other-negative.sh b/t/t3007-ls-files-othe=
r-negative.sh
new file mode 100755
index 0000000..0797b86
--- /dev/null
+++ b/t/t3007-ls-files-other-negative.sh
@@ -0,0 +1,153 @@
+#!/bin/sh
+
+test_description=3D'test re-include patterns'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir -p fooo foo/bar tmp &&
+	touch abc foo/def foo/bar/ghi foo/bar/bar
+'
+
+test_expect_success 'no match, do not enter subdir and waste cycles' '
+	cat >.gitignore <<-\EOF &&
+	/tmp
+	/foo
+	!fooo/bar/bar
+	EOF
+	GIT_TRACE_EXCLUDE=3D"$(pwd)/tmp/trace" git ls-files -o --exclude-stan=
dard >tmp/actual &&
+	! grep "enter .foo/.\$" tmp/trace &&
+	cat >tmp/expected <<-\EOF &&
+	.gitignore
+	abc
+	EOF
+	test_cmp tmp/expected tmp/actual
+'
+
+test_expect_success 'match, excluded by literal pathname pattern' '
+	cat >.gitignore <<-\EOF &&
+	/tmp
+	/fooo
+	/foo
+	!foo/bar/bar
+	EOF
+	cat >fooo/.gitignore <<-\EOF &&
+	!/*
+	EOF	git ls-files -o --exclude-standard >tmp/actual &&
+	cat >tmp/expected <<-\EOF &&
+	.gitignore
+	abc
+	foo/bar/bar
+	EOF
+	test_cmp tmp/expected tmp/actual
+'
+
+test_expect_success 'match, excluded by wildcard pathname pattern' '
+	cat >.gitignore <<-\EOF &&
+	/tmp
+	/fooo
+	/fo?
+	!foo/bar/bar
+	EOF
+	git ls-files -o --exclude-standard >tmp/actual &&
+	cat >tmp/expected <<-\EOF &&
+	.gitignore
+	abc
+	foo/bar/bar
+	EOF
+	test_cmp tmp/expected tmp/actual
+'
+
+test_expect_success 'match, excluded by literal basename pattern' '
+	cat >.gitignore <<-\EOF &&
+	/tmp
+	/fooo
+	foo
+	!foo/bar/bar
+	EOF
+	git ls-files -o --exclude-standard >tmp/actual &&
+	cat >tmp/expected <<-\EOF &&
+	.gitignore
+	abc
+	foo/bar/bar
+	EOF
+	test_cmp tmp/expected tmp/actual
+'
+
+test_expect_success 'match, excluded by wildcard basename pattern' '
+	cat >.gitignore <<-\EOF &&
+	/tmp
+	/fooo
+	fo?
+	!foo/bar/bar
+	EOF
+	git ls-files -o --exclude-standard >tmp/actual &&
+	cat >tmp/expected <<-\EOF &&
+	.gitignore
+	abc
+	foo/bar/bar
+	EOF
+	test_cmp tmp/expected tmp/actual
+'
+
+test_expect_success 'match, excluded by literal mustbedir, basename pa=
ttern' '
+	cat >.gitignore <<-\EOF &&
+	/tmp
+	/fooo
+	foo/
+	!foo/bar/bar
+	EOF
+	git ls-files -o --exclude-standard >tmp/actual &&
+	cat >tmp/expected <<-\EOF &&
+	.gitignore
+	abc
+	foo/bar/bar
+	EOF
+	test_cmp tmp/expected tmp/actual
+'
+
+test_expect_success 'match, excluded by literal mustbedir, pathname pa=
ttern' '
+	cat >.gitignore <<-\EOF &&
+	/tmp
+	/fooo
+	/foo/
+	!foo/bar/bar
+	EOF
+	git ls-files -o --exclude-standard >tmp/actual &&
+	cat >tmp/expected <<-\EOF &&
+	.gitignore
+	abc
+	foo/bar/bar
+	EOF
+	test_cmp tmp/expected tmp/actual
+'
+
+test_expect_success 'prepare for nested negatives' '
+	cat >.git/info/exclude <<-\EOF &&
+	/.gitignore
+	/tmp
+	/foo
+	/abc
+	EOF
+	git ls-files -o --exclude-standard >tmp/actual &&
+	test_must_be_empty tmp/actual &&
+	mkdir -p 1/2/3/4 &&
+	touch 1/f 1/2/f 1/2/3/f 1/2/3/4/f
+'
+
+test_expect_success 'match, literal pathname, nested negatives' '
+	cat >.gitignore <<-\EOF &&
+	/1
+	!1/2
+	1/2/3
+	!1/2/3/4
+	EOF
+	git ls-files -o --exclude-standard >tmp/actual &&
+	cat >tmp/expected <<-\EOF &&
+	1/2/3/4/f
+	1/2/f
+	EOF
+	test_cmp tmp/expected tmp/actual
+'
+
+test_done
--=20
2.7.0.377.g4cd97dd
