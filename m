From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 08/10] grep/pcre: support utf-8
Date: Thu, 28 Jan 2016 18:56:21 +0700
Message-ID: <1453982183-24124-9-git-send-email-pclouds@gmail.com>
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 12:57:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOlCW-0007FW-1Q
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 12:57:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935216AbcA1L5S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jan 2016 06:57:18 -0500
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33967 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932669AbcA1L5P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 06:57:15 -0500
Received: by mail-pa0-f67.google.com with SMTP id yy13so1880883pab.1
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 03:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Jd6OIn5Nrv39jpg2TqMiJ2HHkxzeb9NfcVhoEOBbrDQ=;
        b=IhKh1jG8D5G2PKAuyVPLA5hLDzTs2m/6ZYh7wJRK15Udc0M5LIDHLHPSndFJ95QtWA
         jQFmBo/hbAiYJKnEYywAVjEGTclG5TmTVmEhdBu2Le4XIhHJVZcJG1YMJmpJYnChoyNQ
         RE1Qz+yodWe95sAJg8/CDGDcZ0RuBDx3TIAcRWkKqcD4OAf8/eQDKV+kgglc/0trNKAH
         GiwkuyVF8VOgUv+0Y29j2l5IYRrszRgfkQPwN42LF5frncOLV3CfViDLoPDyo1pzE5Tb
         Bz3i88pVL+UpQF5ep3agTy4Fe62yMh3/DboaRlmkFzI11jdN4eEk933pa1ZEIA4cH6W6
         WpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=Jd6OIn5Nrv39jpg2TqMiJ2HHkxzeb9NfcVhoEOBbrDQ=;
        b=M8BfgsQInmYcG3iu+O5WPWR4NxGZWgeGlJn8eBjsXSPSfLhF7uWe2J8JZFaHt+piC3
         pGQEelJcxAPeeWIXzczxL2bblPFjb1QRjO+SnrPn9JVnb8yhBJCemnphWDrbYJs+4gRz
         i+FaFtO46VioYWe9TrFrA1xiQhscV1Np8GHpk4ZD8DFy86MrtI/7xI2SdpT3gxr58x8h
         skQqza5zgDsl4bDLypJw9GfDFdLCieRkxugIOlBQpicqUEIuqtxeBA2khEauV7gQQiRL
         d5rlluARmfudFsToUM7rm+7983+EpCbEGcmkUeBJVu/g3slyxCPgMP0kybDpFkoNGsX9
         U52w==
X-Gm-Message-State: AG10YORHRl7O22UlBkkGbK8mKtZVlgKSjX6uzZzY83OU1bAkD+EFRsFm1zfffYUDR/7nGQ==
X-Received: by 10.66.62.195 with SMTP id a3mr3948330pas.8.1453982234364;
        Thu, 28 Jan 2016 03:57:14 -0800 (PST)
Received: from lanh ([115.76.235.75])
        by smtp.gmail.com with ESMTPSA id 76sm3719592pft.44.2016.01.28.03.57.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jan 2016 03:57:13 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 28 Jan 2016 18:57:20 +0700
X-Mailer: git-send-email 2.7.0.288.g1d8ad15
In-Reply-To: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285013>

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
index 921339a..2e4f71d 100644
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
index aba6b15..8896410 100755
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
2.7.0.288.g1d8ad15
