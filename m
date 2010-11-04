From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] attr: support quoting pathname patterns in C style
Date: Thu,  4 Nov 2010 20:55:44 +0700
Message-ID: <1288878944-14066-1-git-send-email-pclouds@gmail.com>
References: <AANLkTinNctmWpshBeSTzZRm6+EJ=Cjdpoaj4Aon+52_b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marc Strapetz <marc.strapetz@syntevo.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 14:56:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE0J5-0000rs-PF
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 14:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340Ab0KDN4m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Nov 2010 09:56:42 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:53579 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945Ab0KDN4l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 09:56:41 -0400
Received: by pzk28 with SMTP id 28so156785pzk.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 06:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=3XDnSRlJgkmWbeIClqqcWt/Vfpm3svuX1oxUuhjmLFQ=;
        b=GLx2xXjRMAXpQFJXcfepvObJHGCUu7+mnHSw7MRngM/288qcOYWLFCgKf1pWWX5EmP
         jRyxXNeqQJwlIl4A1ExhOJLmUyzuVhr8drKC29uBXEFgnV/negqQzga+SPW3G0mJVbZz
         +3oV1WWe5ZQkEn+RUX0BelKbW+ZeiOiHeaUM8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=q/wDSBGyI2kMbHFwixEFEV2Lgu/A6qHEFrU5Bh6GMZo6fdDVimLtNBED3P4AI9syCm
         7Lg5k5h1g7nS10Fhdw6blWRX56AUVCo6zt+1ZwZiCmn/RxEDGeUf6Rnv8bdk+aZkkoLA
         pviZhUh5TGBJ7WPAgdUTAdxOeWvcEqp3zPRYQ=
Received: by 10.143.41.8 with SMTP id t8mr654932wfj.89.1288879000720;
        Thu, 04 Nov 2010 06:56:40 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.226.181])
        by mx.google.com with ESMTPS id w23sm3738625wfd.9.2010.11.04.06.56.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Nov 2010 06:56:39 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 04 Nov 2010 20:56:45 +0700
X-Mailer: git-send-email 1.7.3.2.210.g045198
In-Reply-To: <AANLkTinNctmWpshBeSTzZRm6+EJ=Cjdpoaj4Aon+52_b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160720>

=46ull pattern must be quoted. So 'pat"t"ern attr' will give exactly
'pat"t"ern', not 'pattern'. Also clarify that leading whitespaces are
not part of the pattern and document comment syntax.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Obvious regression: patterns that begin with double quote will
 now work differently.

 Documentation/gitattributes.txt |    8 +++++---
 attr.c                          |   25 +++++++++++++++++++++----
 t/t0003-attributes.sh           |   25 ++++++++++++++++++++++++-
 3 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribu=
tes.txt
index c80ca5d..bc6c65c 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -21,9 +21,11 @@ Each line in `gitattributes` file is of form:
 	pattern	attr1 attr2 ...
=20
 That is, a pattern followed by an attributes list,
-separated by whitespaces.  When the pattern matches the
-path in question, the attributes listed on the line are given to
-the path.
+separated by whitespaces. Leading and trailing whitespaces are
+ignored. Lines that begin with '#' are ignored. Patterns
+that begin with a double quote are quoted in C style.
+When the pattern matches the path in question, the attributes
+listed on the line are given to the path.
=20
 Each attribute can be in one of these states for a given path:
=20
diff --git a/attr.c b/attr.c
index 6aff695..f3063d8 100644
--- a/attr.c
+++ b/attr.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "exec_cmd.h"
 #include "attr.h"
+#include "quote.h"
=20
 const char git_attr__true[] =3D "(builtin)true";
 const char git_attr__false[] =3D "\0(builtin)false";
@@ -181,21 +182,33 @@ static struct match_attr *parse_attr_line(const c=
har *line, const char *src,
 {
 	int namelen;
 	int num_attr;
-	const char *cp, *name;
+	const char *cp, *name, *ep;
 	struct match_attr *res =3D NULL;
 	int pass;
 	int is_macro;
+	struct strbuf pattern =3D STRBUF_INIT;
=20
 	cp =3D line + strspn(line, blank);
 	if (!*cp || *cp =3D=3D '#')
 		return NULL;
 	name =3D cp;
-	namelen =3D strcspn(name, blank);
+	if (*cp =3D=3D '"') {
+		if (unquote_c_style(&pattern, name, &ep))
+			die("Broken attribute line: %s", line);
+		namelen =3D ep - name;
+		name =3D pattern.buf;
+	}
+	else {
+		namelen =3D strcspn(name, blank);
+		ep =3D name + namelen;
+	}
+
 	if (strlen(ATTRIBUTE_MACRO_PREFIX) < namelen &&
 	    !prefixcmp(name, ATTRIBUTE_MACRO_PREFIX)) {
 		if (!macro_ok) {
 			fprintf(stderr, "%s not allowed: %s:%d\n",
 				name, src, lineno);
+			strbuf_release(&pattern);
 			return NULL;
 		}
 		is_macro =3D 1;
@@ -206,6 +219,7 @@ static struct match_attr *parse_attr_line(const cha=
r *line, const char *src,
 			fprintf(stderr,
 				"%.*s is not a valid attribute name: %s:%d\n",
 				namelen, name, src, lineno);
+			strbuf_release(&pattern);
 			return NULL;
 		}
 	}
@@ -215,12 +229,14 @@ static struct match_attr *parse_attr_line(const c=
har *line, const char *src,
 	for (pass =3D 0; pass < 2; pass++) {
 		/* pass 0 counts and allocates, pass 1 fills */
 		num_attr =3D 0;
-		cp =3D name + namelen;
+		cp =3D ep;
 		cp =3D cp + strspn(cp, blank);
 		while (*cp) {
 			cp =3D parse_attr(src, lineno, cp, &num_attr, res);
-			if (!cp)
+			if (!cp) {
+				strbuf_release(&pattern);
 				return NULL;
+			}
 		}
 		if (pass)
 			break;
@@ -238,6 +254,7 @@ static struct match_attr *parse_attr_line(const cha=
r *line, const char *src,
 		res->is_macro =3D is_macro;
 		res->num_attr =3D num_attr;
 	}
+	strbuf_release(&pattern);
 	return res;
 }
=20
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 25205ac..a57f358 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -10,17 +10,37 @@ attr_check () {
 	expect=3D"$2"
=20
 	git check-attr test -- "$path" >actual &&
-	echo "$path: test: $2" >expect &&
+	echo "$path: test: $expect" >expect &&
 	test_cmp expect actual
=20
 }
=20
+attr_check_quote () {
+
+	path=3D"$1"
+	quoted_path=3D"$2"
+	expect=3D"$3"
+
+	git check-attr test -- "$path" >actual &&
+	echo "\"$quoted_path\": test: $expect" >expect &&
+	test_cmp expect actual
+
+}
+
+test_expect_success 'open-quoted pathname' '
+	echo "\"a test=3Da" >.gitattributes &&
+	test_must_fail attr_check a a
+'
+
=20
 test_expect_success 'setup' '
=20
 	mkdir -p a/b/d a/c &&
 	(
 		echo "[attr]notest !test"
+		echo "\" d \"	test=3Dd"
+		echo " e	test=3De"
+		echo " e\"	test=3De"
 		echo "f	test=3Df"
 		echo "a/i test=3Da/i"
 		echo "onoff test -test"
@@ -44,6 +64,9 @@ test_expect_success 'setup' '
=20
 test_expect_success 'attribute test' '
=20
+	attr_check " d " d &&
+	attr_check e e &&
+	attr_check_quote e\" e\\\" e &&
 	attr_check f f &&
 	attr_check a/f f &&
 	attr_check a/c/f f &&
--=20
1.7.3.2.210.g045198
