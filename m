From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v6 05/11] grep/icase: avoid kwsset on literal non-ascii strings
Date: Sat,  6 Feb 2016 09:03:04 +0700
Message-ID: <1454724190-14063-6-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sat Feb 06 03:03:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRsE9-0003qf-Kk
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 03:03:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbcBFCDy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 21:03:54 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36009 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbcBFCDx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 21:03:53 -0500
Received: by mail-pf0-f180.google.com with SMTP id n128so77472333pfn.3
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 18:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=tzuIOSAAILYWPYxN2QFyJdlzNT1uGX1oFv2qwTPGV1A=;
        b=nvGED8iL5Q1AzD2brDRHEbxbr1cU+mLe6aSC1WRacISMeVkSIWc8RREadF/mDJCwsD
         8dy5WwoA/FyMnyUJSg6X1VYfK8miRZp1J85qgEUZnEdzl+5A0wDS4zL6YxX22lkDyhY7
         HFD2KWJHxX+SihkSIukFzbZcpC5rW6UbjTIUW3b2oBYn4IWlhzC1rJtJTboDWQw1F3QR
         Grt7VCU87ZQQF4MveiaQm5Rtp4gPb+ZkszuJSXmAS/vOolY/TAUjEYglS1D894kqmClT
         zBfGqkg2ZSabRBv0L/rNapChlIQo37QfkLdUKmB0G5WdGDVQkY1nAkZa6mJQTWHtW8EB
         yBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=tzuIOSAAILYWPYxN2QFyJdlzNT1uGX1oFv2qwTPGV1A=;
        b=eh/ES7iicLtgtgJrnDDb8Yt9lFS0Gsacc73AOr7nD7fdrsrI3brBCEJ+K19rOCNB1B
         QfBKe25WAB0PfhXqSwgiX4W9KZq7B+6pyuQl+mSaSCGm3Y8OMFWwvYsFVcE+w1fBI/WQ
         urcMXFtxsELkiLF6te8mfqXn4HU9j/Hk8XioD6dA1LqFFtf59IFJZvg4LbvcQhcM1BiM
         F2hiIcjUjRsoCXDFAgtfAtdSGbptUCUGC30tMT1v3e/5+thdMg1h5AICbCRzfQX1kwu/
         PUD2bkuj0lhZSgXWkD9S1T69RXdQTgajRw4SiwnSxfsiq9Xw/E7xeOZnXm7O8CwRiFTE
         EyrA==
X-Gm-Message-State: AG10YOS9j9mWc5rXXdApZs1EF1pTziig6TxJXfBtBTTyAA76jnqRKV0Q+3CiqhkTxzKcHg==
X-Received: by 10.98.67.67 with SMTP id q64mr24533390pfa.133.1454724232959;
        Fri, 05 Feb 2016 18:03:52 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id 79sm27247933pfr.22.2016.02.05.18.03.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2016 18:03:51 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 06 Feb 2016 09:04:07 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454724190-14063-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285670>

When we detect the pattern is just a literal string, we avoid heavy
regex engine and use fast substring search implemented in kwsset.c.
But kws uses git-ctype which is locale-independent so it does not know
how to fold case properly outside ascii range. Let regcomp or pcre
take care of this case instead. Slower, but accurate.

Noticed-by: Plamen Totev <plamen.totev@abv.bg>
Helped-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 grep.c                                   |  6 +++++-
 t/t7812-grep-icase-non-ascii.sh (new +x) | 23 +++++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)
 create mode 100755 t/t7812-grep-icase-non-ascii.sh

diff --git a/grep.c b/grep.c
index e739d20..44817ce 100644
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
@@ -398,12 +399,15 @@ static int is_fixed(const char *s, size_t len)
=20
 static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
+	int icase, ascii_only;
 	int err;
=20
 	p->word_regexp =3D opt->word_regexp;
 	p->ignore_case =3D opt->ignore_case;
+	icase	       =3D opt->regflags & REG_ICASE || p->ignore_case;
+	ascii_only     =3D !has_non_ascii(p->pattern);
=20
-	if (is_fixed(p->pattern, p->patternlen))
+	if ((!icase || ascii_only) && is_fixed(p->pattern, p->patternlen))
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
2.7.0.377.g4cd97dd
