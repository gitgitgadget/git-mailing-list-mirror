From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 05/10] grep/icase: avoid kwsset when -F is specified
Date: Thu, 28 Jan 2016 18:56:18 +0700
Message-ID: <1453982183-24124-6-git-send-email-pclouds@gmail.com>
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 12:57:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOlCF-0006xQ-QU
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 12:57:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934738AbcA1L5A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jan 2016 06:57:00 -0500
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35304 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932669AbcA1L46 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 06:56:58 -0500
Received: by mail-pa0-f65.google.com with SMTP id gi1so1901131pac.2
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 03:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=KosyzfTdAO5u7h6eZATKE+oLIyooIU8QFH7WbSrm8Ec=;
        b=G/TweVFhvNYO+dVyuKbN00e+f0FvlD2QnZJ1yA9phc49ng5SfgULvytrIQP0bBEcHf
         EA7qgO0cYTIRsRqXKhLW3A3v4wGte4dKazD6e/BFuF60PtqHjy0bHhEl1cQcZVAsb6oH
         0Aku++YXKSeBCiEeQX6nYEG07ykv8vb4jS9LaXy4iqFPQr7KjIoyyyaCI/E9+TEpnE7W
         5F7WsQZ9LgnSUCHvKdfoF2aM3wGlLrgrnsSoae2xgEgl7EITb2gRfK4gmbhXeuoeKASA
         P05WP7QjxTCQvbYwxbIiQSFrhnMzCAhkJRqVKwbQO+s6YL9WOdzqtnw3mmGiniIrj04s
         MQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=KosyzfTdAO5u7h6eZATKE+oLIyooIU8QFH7WbSrm8Ec=;
        b=iSq4l7nPmzTfXbqG4RUdRKsao8Mgs0zGPZFVAFIMlWnqRXXPFhI72ZRqee0PVb6Xx3
         V/EnJ0OZhOFRwIX3Kd0UWpF9U/XQkOQcCjKuOwyrEn+hSytxD+AF/NojanGzh+OlMm55
         kH00Y+qh2GuS3QL1mnZ0ncpLCaWiBuw2uU80o2DTCI8Cimg0t01BsRKLrXXAq/XnV4ge
         fiASUnk4WvRz+ppeUiBFFWZ0kZA6cb7Zwvf41i3daPTswHeBgfXnWcAMoGN+X+WEJAsw
         zPQ+mJ3NtVeC6Fj/hLKrAko93Sgc3DNn1tIeAah9rs+qlsAh5m8retFGtO2U8sb+IXwb
         PGCQ==
X-Gm-Message-State: AG10YOSK18ZoJJYo920bdZxRCr9wVxO6TgCDQl0d8PhNrM8l245A0oeSHbsxlHw6L90iwQ==
X-Received: by 10.66.54.102 with SMTP id i6mr3805872pap.71.1453982217741;
        Thu, 28 Jan 2016 03:56:57 -0800 (PST)
Received: from lanh ([115.76.235.75])
        by smtp.gmail.com with ESMTPSA id x18sm15921643pfa.65.2016.01.28.03.56.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jan 2016 03:56:56 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 28 Jan 2016 18:57:02 +0700
X-Mailer: git-send-email 2.7.0.288.g1d8ad15
In-Reply-To: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285011>

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
any more..

Helped-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
Noticed-by: Plamen Totev <plamen.totev@abv.bg>
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
index f2180a2..fa96a29 100644
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
+		fprintf(stderr, "fixed%s\n", sb.buf);
+	strbuf_release(&sb);
+	if (err) {
+		char errbuf[1024];
+		regerror(err, &p->regexp, errbuf, 1024);
+		regfree(&p->regexp);
+		compile_regexp_failed(p, errbuf);
+	}
+}
+
 static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
 	int icase_non_ascii;
@@ -411,7 +430,11 @@ static void compile_regexp(struct grep_pat *p, str=
uct grep_opt *opt)
 	if (!icase_non_ascii && is_fixed(p->pattern, p->patternlen))
 		p->fixed =3D 1;
 	else if (opt->fixed) {
-		p->fixed =3D 1;
+		p->fixed =3D !icase_non_ascii;
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
index 6eff490..aba6b15 100755
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
+	echo "fixedTILRAUN: Hall=C3=B3 Heimur!" >expect1 &&
+	test_cmp expect1 debug1 &&
+
+	git grep --debug -i -F "TILRAUN: HALL=C3=93 HEIMUR!"  2>&1 >/dev/null=
 |
+		 grep fixed >debug2 &&
+	echo "fixedTILRAUN: HALL=C3=93 HEIMUR!" >expect2 &&
+	test_cmp expect2 debug2
+'
+
+test_expect_success REGEX_LOCALE 'grep string with regex, with -F' '
+	printf "^*TILR^AUN:.* \\Hall=C3=B3 \$He[]imur!\$" >file &&
+
+	git grep --debug -i -F "^*TILR^AUN:.* \\Hall=C3=B3 \$He[]imur!\$" 2>&=
1 >/dev/null |
+		 grep fixed >debug1 &&
+	echo "fixed\\^*TILR^AUN:\\.\\* \\\\Hall=C3=B3 \$He\\[]imur!\\\$" >exp=
ect1 &&
+	test_cmp expect1 debug1 &&
+
+	git grep --debug -i -F "^*TILR^AUN:.* \\HALL=C3=93 \$HE[]IMUR!\$"  2>=
&1 >/dev/null |
+		 grep fixed >debug2 &&
+	echo "fixed\\^*TILR^AUN:\\.\\* \\\\HALL=C3=93 \$HE\\[]IMUR!\\\$" >exp=
ect2 &&
+	test_cmp expect2 debug2
+'
+
 test_done
--=20
2.7.0.288.g1d8ad15
