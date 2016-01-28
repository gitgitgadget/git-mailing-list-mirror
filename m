From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 04/10] grep/icase: avoid kwsset on literal non-ascii strings
Date: Thu, 28 Jan 2016 18:56:17 +0700
Message-ID: <1453982183-24124-5-git-send-email-pclouds@gmail.com>
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 12:56:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOlC4-0006qT-Nt
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 12:56:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934662AbcA1L4x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jan 2016 06:56:53 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33491 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932669AbcA1L4w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 06:56:52 -0500
Received: by mail-pf0-f196.google.com with SMTP id x125so2006295pfb.0
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 03:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=jFCsxqHGPGkyzl4JeUl5IOELIdbPtq6xKCjNMvi9mUo=;
        b=Tt4yfWdwfqd8ZGRNmJY8cC5UF2FlrgeIU70UVd9ZIVI3Rko5jtngA9E8qCgqWuCacc
         cZcuZ9PE7ScUrYpeIlDVI+bexBVG3x6ETraPQ23dzp0IpHdTnUCUSy+fPLejN0t/P3Ni
         cpUpFoImN4sKxSPHJ/JHS9wyc8oQNW3r2jlj5KAKDdEryNhDzUHq1E6yECaoGf+qJWfH
         9fBUeTUCtIe6mHsT/Iz5F891YYKNvnuKeJ0r5cgiSfONTe+YDuxy8hU8QhcucfxShrEg
         NIoa2oEXVWGjWcYpBjWl3+H7F7NaLSrHdjE4SuK7/zN5JCKgBAiO257o8ePMnHJavIhP
         5hZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=jFCsxqHGPGkyzl4JeUl5IOELIdbPtq6xKCjNMvi9mUo=;
        b=FFtX6xfCsqYZvQEkVR4zNkZkG7P1pJQdwgX2Js7hTpA6mmXFFcNZCL8+ZFr6WptYp1
         09pVDqi10y3nfO3RsITTR7Aevmi+vSnumvM0GFjlIfw2fbItVXbZibyw29wS1JqOupHd
         YOd8XzwYHdciWLJFJ9Jg/APhLEMbflRptSraoHgAIu4KxMqz/3RWSdki8BZYsOwqjqg0
         SAS9TswG/yiXRVjppAIJpSzKbPBCEpeNN688rHL5OyBnNGJ/7W8s1T3/mR0kMuM6dA+X
         3Ry/JdoFs0gWm0w4cTpnI6jsjFcD2ErNlE7hepJczxBH5i08jkSZbgDAKg2TYBrBHO17
         FUjg==
X-Gm-Message-State: AG10YOSWvuP91N+idDcyDbAOPmQb401mvDkKSbjc4uV6owPF0Fsy2V6nwySBtYdJFIU+Gw==
X-Received: by 10.98.19.215 with SMTP id 84mr2507067pft.22.1453982211902;
        Thu, 28 Jan 2016 03:56:51 -0800 (PST)
Received: from lanh ([115.76.235.75])
        by smtp.gmail.com with ESMTPSA id ux2sm15907483pac.46.2016.01.28.03.56.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jan 2016 03:56:49 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 28 Jan 2016 18:56:56 +0700
X-Mailer: git-send-email 2.7.0.288.g1d8ad15
In-Reply-To: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285010>

When we detect the pattern is just a literal string, we avoid heavy
regex engine and use fast substring search implemented in kwsset.c.
But kws uses git-ctype which is locale-independent so it does not know
how to fold case properly outside ascii range. Let regcomp or pcre
take care of this case instead. Slower, but accurate.

Helped-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
Noticed-by: Plamen Totev <plamen.totev@abv.bg>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 grep.c                                   |  7 ++++++-
 t/t7812-grep-icase-non-ascii.sh (new +x) | 23 +++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100755 t/t7812-grep-icase-non-ascii.sh

diff --git a/grep.c b/grep.c
index e739d20..f2180a2 100644
--- a/grep.c
+++ b/grep.c
@@ -4,6 +4,7 @@
 #include "xdiff-interface.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "commit.h"
=20
 static int grep_source_load(struct grep_source *gs);
 static int grep_source_is_binary(struct grep_source *gs);
@@ -398,12 +399,16 @@ static int is_fixed(const char *s, size_t len)
=20
 static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
+	int icase_non_ascii;
 	int err;
=20
 	p->word_regexp =3D opt->word_regexp;
 	p->ignore_case =3D opt->ignore_case;
+	icase_non_ascii =3D
+		(opt->regflags & REG_ICASE || p->ignore_case) &&
+		has_non_ascii(p->pattern);
=20
-	if (is_fixed(p->pattern, p->patternlen))
+	if (!icase_non_ascii && is_fixed(p->pattern, p->patternlen))
 		p->fixed =3D 1;
 	else if (opt->fixed) {
 		p->fixed =3D 1;
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-a=
scii.sh
new file mode 100755
index 0000000..6eff490
--- /dev/null
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+
+test_description=3D'grep icase on non-English locales'
+
+. ./lib-gettext.sh
+
+test_expect_success GETTEXT_LOCALE 'setup' '
+	printf "TILRAUN: Hall=C3=B3 Heimur!" >file &&
+	git add file &&
+	LC_ALL=3D"$is_IS_locale" &&
+	export LC_ALL
+'
+
+test_have_prereq GETTEXT_LOCALE &&
+test-regex "HALL=C3=93" "Hall=C3=B3" ICASE &&
+test_set_prereq REGEX_LOCALE
+
+test_expect_success REGEX_LOCALE 'grep literal string, no -F' '
+	git grep -i "TILRAUN: Hall=C3=B3 Heimur!" &&
+	git grep -i "TILRAUN: HALL=C3=93 HEIMUR!"
+'
+
+test_done
--=20
2.7.0.288.g1d8ad15
