From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v6 09/11] grep/pcre: support utf-8
Date: Sat,  6 Feb 2016 09:03:08 +0700
Message-ID: <1454724190-14063-10-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sat Feb 06 03:04:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRsEY-0004OY-Oe
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 03:04:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbcBFCET convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 21:04:19 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36155 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbcBFCES (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 21:04:18 -0500
Received: by mail-pf0-f171.google.com with SMTP id n128so77476344pfn.3
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 18:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=YdBQgn/DRpQS3smsbdf86MAJfV4eDRR5ohHX8fNJf94=;
        b=PALyyXAjF6xrmWINKGu0Fmik7UgAdAnxI0Jl4wKLAoNLKOE2sOfbuldbUJKO7LDFu5
         7hDKkFcBoI4J5k4FcUwjRGTL0zHCjQ0dSpo8CXrfmDp2t9LEiaIElHaqAjA7F50PCsW5
         S0Xj6IsmCLiRFWz1H4iw1cn1nvLGbhxbq3NRwozys62LX2e0FZZmLxJzl46435y8zfRE
         3MBuaVOoa3cqwJbW+KxIKJeNt7rdqr3v81nsRpJZXaiIr+7LKBqXmdILRz+DZgFEwXMw
         ddURqFzZkQe5EjbodMrTBd4M4Kes/a4Gq4rn0OHyzJMweqofu8dVQhFQ2e5ncFUunOHa
         cCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=YdBQgn/DRpQS3smsbdf86MAJfV4eDRR5ohHX8fNJf94=;
        b=GMwme6/ZQ0TgUgfmqopIsM4e2nyCAw4uEdkuraQ0LB+X2Egwkl+UMLRpiGxgZliJkb
         t/LyjDueOIjY3OrhT7F6RFx04B8E9jU6exRDYsvKqY9ZJSBIxN2x+v4QcfZqYZf7/dLU
         UyGtPNaQ+biAYaKsy+EmF+qNO2ThZuw43KNyAqyj7+NUQ4SqboFYsJZNixDjq0zp27w4
         wHOD/RIVBnlj7OXrHCt5dhhpyV64hau/42jgsF+1cQvUBEnUzrepJEgffm+/PUtojGGH
         IYsyR7nEh4eNO+meNmPegYPRscWfcFnFWPIGsoEAJUNpgvA3terO2OKiGkNUiKuod48b
         VpIw==
X-Gm-Message-State: AG10YOSWtEEMFAV92uVSpmBlewORXo0znPGHaGty1xKXVC/qEmm48FH4SmLXWDguWgJIjA==
X-Received: by 10.98.87.80 with SMTP id l77mr24423426pfb.101.1454724257393;
        Fri, 05 Feb 2016 18:04:17 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id x1sm27213854pfi.42.2016.02.05.18.04.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2016 18:04:15 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 06 Feb 2016 09:04:31 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454724190-14063-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285674>

In the previous change in this function, we add locale support for
single-byte encodings only. It looks like pcre only supports utf-* as
multibyte encodings, the others are left in the cold (which is
fine).

We need to enable PCRE_UTF8 so pcre can find character boundary
correctly. It's needed for case folding (when --ignore-case is used)
or '*', '+' or similar syntax is used.

The "has_non_ascii()" check is to be on the conservative side. If
there's non-ascii in the pattern, the searched content could still be
in utf-8, but we can treat it just like a byte stream and everything
should work. If we force utf-8 based on locale only and pcre validates
utf-8 and the file content is in non-utf8 encoding, things break.

Noticed-by: Plamen Totev <plamen.totev@abv.bg>
Helped-by: Plamen Totev <plamen.totev@abv.bg>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 grep.c                          |  2 ++
 t/t7812-grep-icase-non-ascii.sh | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/grep.c b/grep.c
index 843e180..aed4fe0 100644
--- a/grep.c
+++ b/grep.c
@@ -329,6 +329,8 @@ static void compile_pcre_regexp(struct grep_pat *p,=
 const struct grep_opt *opt)
 			p->pcre_tables =3D pcre_maketables();
 		options |=3D PCRE_CASELESS;
 	}
+	if (is_utf8_locale() && has_non_ascii(p->pattern))
+		options |=3D PCRE_UTF8;
=20
 	p->pcre_regexp =3D pcre_compile(p->pattern, options, &error, &erroffs=
et,
 				      p->pcre_tables);
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-a=
scii.sh
index 5832684..842b26a 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -20,6 +20,21 @@ test_expect_success REGEX_LOCALE 'grep literal strin=
g, no -F' '
 	git grep -i "TILRAUN: HALL=C3=93 HEIMUR!"
 '
=20
+test_expect_success GETTEXT_LOCALE,LIBPCRE 'grep pcre utf-8 icase' '
+	git grep --perl-regexp    "TILRAUN: H.ll=C3=B3 Heimur!" &&
+	git grep --perl-regexp -i "TILRAUN: H.ll=C3=B3 Heimur!" &&
+	git grep --perl-regexp -i "TILRAUN: H.LL=C3=93 HEIMUR!"
+'
+
+test_expect_success GETTEXT_LOCALE,LIBPCRE 'grep pcre utf-8 string wit=
h "+"' '
+	printf "TILRAUN: Hall=C3=B3=C3=B3 Heimur!" >file2 &&
+	git add file2 &&
+	git grep -l --perl-regexp "TILRAUN: H.ll=C3=B3+ Heimur!" >actual &&
+	echo file >expected &&
+	echo file2 >>expected &&
+	test_cmp expected actual
+'
+
 test_expect_success REGEX_LOCALE 'grep literal string, with -F' '
 	git grep --debug -i -F "TILRAUN: Hall=C3=B3 Heimur!"  2>&1 >/dev/null=
 |
 		 grep fixed >debug1 &&
--=20
2.7.0.377.g4cd97dd
