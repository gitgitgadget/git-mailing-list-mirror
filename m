From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] attr: always treat the leading exclamation mark as literal
Date: Sat,  2 Mar 2013 11:18:33 +0700
Message-ID: <1362197913-313-1-git-send-email-pclouds@gmail.com>
References: <a1679159dbe67c34675bbe016e131260310db189.1362168366.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 02 05:18:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBdtY-0004AC-NL
	for gcvg-git-2@plane.gmane.org; Sat, 02 Mar 2013 05:18:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804Ab3CBERd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Mar 2013 23:17:33 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:64506 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566Ab3CBERd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 23:17:33 -0500
Received: by mail-pa0-f52.google.com with SMTP id fb1so2187420pad.25
        for <git@vger.kernel.org>; Fri, 01 Mar 2013 20:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=ib5oq59J6HpJZ/eGjgt/eNx7+4MGhE/RgOIHc5sCXZI=;
        b=MCnCvDzmMfN+uNq7DIZVCyfxY5lp0W793W8QGej6CdkC/EStGEi9wblTXYHqph9+Gi
         A0qhadNNiNPG8YhUKM6wLNWUe6oUvg1qSfU4jJ2/tfx9UiWrLHyJRNDRa/ypWE/XLdqG
         XyhujEm68u2T9jMY2h7Kft9digizT4/w5xmq+9TtFFZOwKYEdzs38dmb4KnpJfBsymSJ
         ZHaXgkNNYCgvpolAZiU/HrLK8dKb2jYC/rirGivgEgPd+4nQaNvbRTFL6lOItmK0Zmao
         S70JOyGj0JjJy4wfCqZ3bPyzrxeHKUPUAZSRWXX53VdhqeoPuiSuzE0zGE77bm9b533M
         1ruw==
X-Received: by 10.66.72.198 with SMTP id f6mr21778528pav.42.1362197852452;
        Fri, 01 Mar 2013 20:17:32 -0800 (PST)
Received: from lanh ([115.74.35.220])
        by mx.google.com with ESMTPS id g4sm15350490pax.4.2013.03.01.20.17.27
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 01 Mar 2013 20:17:31 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 02 Mar 2013 11:18:34 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <a1679159dbe67c34675bbe016e131260310db189.1362168366.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217320>

8b1bd02 (Make !pattern in .gitattributes non-fatal - 2013-03-01)
raises the fact that even though '!' should have been a negative
pattern indicator, people have been misusing for plain '!' and old Git
versions accept that. This makes the leading '!' a de facto
literal. We can't ever make it negative indicator again because we
can't distinguish the literal '!' in existing repos and the negative
'!'  in future repos.

Acknowledge it in document and code that the leading '!' is forever
literal.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Perhaps this on top of Thomas' patch? I see no way else that we can
 change the meaning of '!' again if such patterns are already stored
 in repositories.

 Documentation/gitattributes.txt | 3 ++-
 attr.c                          | 8 ++------
 dir.c                           | 7 ++++---
 dir.h                           | 6 +++++-
 t/t0003-attributes.sh           | 5 ++---
 5 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribu=
tes.txt
index 2698f63..02bff9d 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -56,7 +56,8 @@ When more than one pattern matches the path, a later =
line
 overrides an earlier line.  This overriding is done per
 attribute.  The rules how the pattern matches paths are the
 same as in `.gitignore` files; see linkgit:gitignore[5].
-Unlike `.gitignore`, negative patterns are forbidden.
+Unlike `.gitignore`, the leading `!` is treated as a literal
+exclamation, not an indicator of negative patterns.
=20
 When deciding what attributes are assigned to a path, git
 consults `$GIT_DIR/info/attributes` file (which has the highest
diff --git a/attr.c b/attr.c
index d181d98..838ec21 100644
--- a/attr.c
+++ b/attr.c
@@ -254,12 +254,8 @@ static struct match_attr *parse_attr_line(const ch=
ar *line, const char *src,
 		parse_exclude_pattern(&res->u.pat.pattern,
 				      &res->u.pat.patternlen,
 				      &res->u.pat.flags,
-				      &res->u.pat.nowildcardlen);
-		if (res->u.pat.flags & EXC_FLAG_NEGATIVE) {
-			warning(_("Negative patterns are ignored in git attributes\n"
-				  "Use '\\!' for literal leading exclamation."));
-			return NULL;
-		}
+				      &res->u.pat.nowildcardlen,
+				      1);
 	}
 	res->is_macro =3D is_macro;
 	res->num_attr =3D num_attr;
diff --git a/dir.c b/dir.c
index a473ca2..609ab99 100644
--- a/dir.c
+++ b/dir.c
@@ -311,13 +311,14 @@ static int no_wildcard(const char *string)
 void parse_exclude_pattern(const char **pattern,
 			   int *patternlen,
 			   int *flags,
-			   int *nowildcardlen)
+			   int *nowildcardlen,
+			   int gitattributes)
 {
 	const char *p =3D *pattern;
 	size_t i, len;
=20
 	*flags =3D 0;
-	if (*p =3D=3D '!') {
+	if (!gitattributes && *p =3D=3D '!') {
 		*flags |=3D EXC_FLAG_NEGATIVE;
 		p++;
 	}
@@ -354,7 +355,7 @@ void add_exclude(const char *string, const char *ba=
se,
 	int flags;
 	int nowildcardlen;
=20
-	parse_exclude_pattern(&string, &patternlen, &flags, &nowildcardlen);
+	parse_exclude_pattern(&string, &patternlen, &flags, &nowildcardlen, 0=
);
 	if (flags & EXC_FLAG_MUSTBEDIR) {
 		char *s;
 		x =3D xmalloc(sizeof(*x) + patternlen + 1);
diff --git a/dir.h b/dir.h
index f5c89e3..3aeb519 100644
--- a/dir.h
+++ b/dir.h
@@ -107,7 +107,11 @@ extern int path_excluded(struct path_exclude_check=
 *, const char *, int namelen,
 extern int add_excludes_from_file_to_list(const char *fname, const cha=
r *base, int baselen,
 					  char **buf_p, struct exclude_list *which, int check_index);
 extern void add_excludes_from_file(struct dir_struct *, const char *fn=
ame);
-extern void parse_exclude_pattern(const char **string, int *patternlen=
, int *flags, int *nowildcardlen);
+extern void parse_exclude_pattern(const char **string,
+				  int *patternlen,
+				  int *flags,
+				  int *nowildcardlen,
+				  int gitattributes);
 extern void add_exclude(const char *string, const char *base,
 			int baselen, struct exclude_list *which);
 extern void free_excludes(struct exclude_list *el);
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 1035a14..7ca283f 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -197,9 +197,8 @@ test_expect_success 'root subdir attribute test' '
 '
=20
 test_expect_success 'negative patterns' '
-	echo "!f test=3Dbar" >.gitattributes &&
-	git check-attr test -- '"'"'!f'"'"' 2>errors &&
-	test_i18ngrep "Negative patterns are ignored" errors
+	echo "!f test=3Dfoo" >.gitattributes &&
+	attr_check "!f" foo
 '
=20
 test_expect_success 'patterns starting with exclamation' '
--=20
1.8.1.2.536.gf441e6d
