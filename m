From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v6 06/11] grep/icase: avoid kwsset when -F is specified
Date: Sat,  6 Feb 2016 09:03:05 +0700
Message-ID: <1454724190-14063-7-git-send-email-pclouds@gmail.com>
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
 <1454724190-14063-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 06 03:04:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRsEG-0003yo-PC
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 03:04:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbcBFCEA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 21:04:00 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34128 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbcBFCD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 21:03:59 -0500
Received: by mail-pa0-f50.google.com with SMTP id uo6so43739180pac.1
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 18:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=IdTGr4sTPrh6cvf44Cb0oPL8reIE9tjPeaU4h1F4Tfw=;
        b=N1tXUNady0FhhfyifbfRXlB4iht4D3ZdeYwuE37/SJntiw9m+UTYr/kwQ4KnZq7Sk5
         pNjHdhROnFEeJBXKk+GsQ5W7+iAT+/vNawpUjuVwxm0ybqaoke5eUOuvDfI7LHyxygCG
         L8gyaKmQJ4+P4w4qt3vMWILPeIYzrQKYltkljLfqq2/+9KJ/VATkTdf5F4BFLrZsMDdM
         u1SaYs2xcLXx48o3m1djSLwPrR8urgsYU9VaPj91evHdvjBEyLC8HYXrBrOkmVCL42ks
         euBrTVl+AoovfY4WbDbYmEICfl/Xk5ubRC+rHHpuc5y8OUNEkeWYl9ft4oqgCnjiKZ1u
         FKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=IdTGr4sTPrh6cvf44Cb0oPL8reIE9tjPeaU4h1F4Tfw=;
        b=RLRs9wJFrBJFB+2U9PCVMJmFRUwNWHeSAVeZO8OpRfR0LT67Quxn5OtrUYrr4loLL3
         y3oZ0kTxov8BAt231iwp4GORqtfoXyNGg/TKheqhGn3V4H3GWEckszCKBRXoxjxn2w3l
         KzyEdBlVqKrW/KHTrxVjDbqYUyAKcH8fbvk3AxWBIFcvZhOy8gSkXo8EXm0og3CKLq/o
         sQrzT2aauy4Y3y8YNwtjbVtYf4RMHhpuvVhgiJovrEqy6oZw/1kbylIuJe6XcdZpoI/D
         dpo3jngySHTKHyhqexmS3DBF5EkFqUA7iGkYKffRkSo8OzL2BjGToNQ8YLEYEnW9jfg2
         SS/Q==
X-Gm-Message-State: AG10YOSlCDLgzMhcoMvwvefCeLBMCpslO9tNAgr2EdQkE2D4+NXt/4lh/XEmKv1lAyxtkQ==
X-Received: by 10.66.191.104 with SMTP id gx8mr24378816pac.21.1454724238937;
        Fri, 05 Feb 2016 18:03:58 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id r77sm27198175pfa.47.2016.02.05.18.03.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2016 18:03:57 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 06 Feb 2016 09:04:13 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454724190-14063-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285671>

Similar to the previous commit, we can't use kws on icase search
outside ascii range. But we can't simply pass the pattern to
regcomp/pcre like the previous commit because it may contain regex
special characters, so we need to quote the regex first.

To avoid misquote traps that could lead to undefined behavior, we
always stick to basic regex engine in this case. We don't need fancy
features for grepping a literal string anyway.

basic_regex_quote_buf() assumes that if the pattern is in a multibyte
encoding, ascii chars must be unambiguously encoded as single
bytes. This is true at least for UTF-8. For others, let's wait until
people yell up. Chances are nobody uses multibyte, non utf-8 charsets
anymore.

Noticed-by: Plamen Totev <plamen.totev@abv.bg>
Helped-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 grep.c                          | 25 ++++++++++++++++++++++++-
 quote.c                         | 37 +++++++++++++++++++++++++++++++++=
++++
 quote.h                         |  1 +
 t/t7812-grep-icase-non-ascii.sh | 26 ++++++++++++++++++++++++++
 4 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index 44817ce..6d34479 100644
--- a/grep.c
+++ b/grep.c
@@ -5,6 +5,7 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "commit.h"
+#include "quote.h"
=20
 static int grep_source_load(struct grep_source *gs);
 static int grep_source_is_binary(struct grep_source *gs);
@@ -397,6 +398,24 @@ static int is_fixed(const char *s, size_t len)
 	return 1;
 }
=20
+static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *=
opt)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	int err;
+
+	basic_regex_quote_buf(&sb, p->pattern);
+	err =3D regcomp(&p->regexp, sb.buf, opt->regflags & ~REG_EXTENDED);
+	if (opt->debug)
+		fprintf(stderr, "fixed %s\n", sb.buf);
+	strbuf_release(&sb);
+	if (err) {
+		char errbuf[1024];
+		regerror(err, &p->regexp, errbuf, sizeof(errbuf));
+		regfree(&p->regexp);
+		compile_regexp_failed(p, errbuf);
+	}
+}
+
 static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
 	int icase, ascii_only;
@@ -410,7 +429,11 @@ static void compile_regexp(struct grep_pat *p, str=
uct grep_opt *opt)
 	if ((!icase || ascii_only) && is_fixed(p->pattern, p->patternlen))
 		p->fixed =3D 1;
 	else if (opt->fixed) {
-		p->fixed =3D 1;
+		p->fixed =3D !icase || ascii_only;
+		if (!p->fixed) {
+			compile_fixed_regexp(p, opt);
+			return;
+		}
 	} else
 		p->fixed =3D 0;
=20
diff --git a/quote.c b/quote.c
index fe884d2..c67adb7 100644
--- a/quote.c
+++ b/quote.c
@@ -440,3 +440,40 @@ void tcl_quote_buf(struct strbuf *sb, const char *=
src)
 	}
 	strbuf_addch(sb, '"');
 }
+
+void basic_regex_quote_buf(struct strbuf *sb, const char *src)
+{
+	char c;
+
+	if (*src =3D=3D '^') {
+		/* only beginning '^' is special and needs quoting */
+		strbuf_addch(sb, '\\');
+		strbuf_addch(sb, *src++);
+	}
+	if (*src =3D=3D '*')
+		/* beginning '*' is not special, no quoting */
+		strbuf_addch(sb, *src++);
+
+	while ((c =3D *src++)) {
+		switch (c) {
+		case '[':
+		case '.':
+		case '\\':
+		case '*':
+			strbuf_addch(sb, '\\');
+			strbuf_addch(sb, c);
+			break;
+
+		case '$':
+			/* only the end '$' is special and needs quoting */
+			if (*src =3D=3D '\0')
+				strbuf_addch(sb, '\\');
+			strbuf_addch(sb, c);
+			break;
+
+		default:
+			strbuf_addch(sb, c);
+			break;
+		}
+	}
+}
diff --git a/quote.h b/quote.h
index 99e04d3..362d315 100644
--- a/quote.h
+++ b/quote.h
@@ -67,5 +67,6 @@ extern char *quote_path_relative(const char *in, cons=
t char *prefix,
 extern void perl_quote_buf(struct strbuf *sb, const char *src);
 extern void python_quote_buf(struct strbuf *sb, const char *src);
 extern void tcl_quote_buf(struct strbuf *sb, const char *src);
+extern void basic_regex_quote_buf(struct strbuf *sb, const char *src);
=20
 #endif
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-a=
scii.sh
index 6eff490..5832684 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -20,4 +20,30 @@ test_expect_success REGEX_LOCALE 'grep literal strin=
g, no -F' '
 	git grep -i "TILRAUN: HALL=C3=93 HEIMUR!"
 '
=20
+test_expect_success REGEX_LOCALE 'grep literal string, with -F' '
+	git grep --debug -i -F "TILRAUN: Hall=C3=B3 Heimur!"  2>&1 >/dev/null=
 |
+		 grep fixed >debug1 &&
+	echo "fixed TILRAUN: Hall=C3=B3 Heimur!" >expect1 &&
+	test_cmp expect1 debug1 &&
+
+	git grep --debug -i -F "TILRAUN: HALL=C3=93 HEIMUR!"  2>&1 >/dev/null=
 |
+		 grep fixed >debug2 &&
+	echo "fixed TILRAUN: HALL=C3=93 HEIMUR!" >expect2 &&
+	test_cmp expect2 debug2
+'
+
+test_expect_success REGEX_LOCALE 'grep string with regex, with -F' '
+	printf "^*TILR^AUN:.* \\Hall=C3=B3 \$He[]imur!\$" >file &&
+
+	git grep --debug -i -F "^*TILR^AUN:.* \\Hall=C3=B3 \$He[]imur!\$" 2>&=
1 >/dev/null |
+		 grep fixed >debug1 &&
+	echo "fixed \\^*TILR^AUN:\\.\\* \\\\Hall=C3=B3 \$He\\[]imur!\\\$" >ex=
pect1 &&
+	test_cmp expect1 debug1 &&
+
+	git grep --debug -i -F "^*TILR^AUN:.* \\HALL=C3=93 \$HE[]IMUR!\$"  2>=
&1 >/dev/null |
+		 grep fixed >debug2 &&
+	echo "fixed \\^*TILR^AUN:\\.\\* \\\\HALL=C3=93 \$HE\\[]IMUR!\\\$" >ex=
pect2 &&
+	test_cmp expect2 debug2
+'
+
 test_done
--=20
2.7.0.377.g4cd97dd
