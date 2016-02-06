From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v6 07/11] grep/pcre: prepare locale-dependent tables for icase matching
Date: Sat,  6 Feb 2016 09:03:06 +0700
Message-ID: <1454724190-14063-8-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sat Feb 06 03:04:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRsEN-00047R-LG
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 03:04:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbcBFCEH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 21:04:07 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36787 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbcBFCEF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 21:04:05 -0500
Received: by mail-pa0-f48.google.com with SMTP id yy13so42942454pab.3
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 18:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=bp28JDl2g1as/ohyH7J4CAGqreCWjbIPiZsn22cc6Bk=;
        b=gYWmgcnxkWTtGnpY+9Y9hBy4My2dMdKg3yVf5r6zMVWeWllMrb+NLMtkfyqqNi0HqX
         Oi3JxrdiDPjD+G/58HPa+x57ovFGher2bJ2tD6Coj+FuQJdAIwwAuB0xsX1XQBVL1Gr5
         lzaC6yj39AAY/SBpbvttFDWafgoxAZBMYlq0ox4I1UG2U3COrRMd6Jwqpcz/3xHPgq+h
         kDOyStFC5GSh9CvNrWaZwuSPOxeAqazqoyRoSqOV4H6HrPzqflyoS/66G3VyXId/Dy2L
         PuXRJBsXxCsQK8ViNe4wMySJAC/eBfhxAZ9K4VTn9DhomNkl2yEoESleQINxh4qaD8JN
         oK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=bp28JDl2g1as/ohyH7J4CAGqreCWjbIPiZsn22cc6Bk=;
        b=LFXCved5jcSMbatM5vX+5uwJKXSAQK3A1mQobHqUDNTgElir0+nxrX+UdcWiZ2CTSi
         efRm8cmQkcMHgXUUyJ+XP243nAfAx4Vj51x9y7/VIFbiyUJM/j8UB3cfBIbLU+NzxSZY
         vBpn+oJhQideaEhnKqnyi0bEt5qklkrD02M6gdbFMI1eiGXFyiblwxOA4Ln+l0blCeoT
         8/3L5/Z00WRigohmXbh5nC51L/0xsYklhctM45Dc5y9o5EJrWikgG1fMC1DWr5j5ulAt
         LWNpj8zIHjU5QB/OolaeDX0nR1sHf4dyzNrZdLmeBgziW8BRMfXIJkcdgT+I/6ECUOc5
         XT5Q==
X-Gm-Message-State: AG10YOQSLmZAWNRzo/7iMXsjTtjE1oXoI+UsPrMP+EeoSz++F/hbHo3O4eihFsaJaOQbTQ==
X-Received: by 10.67.14.105 with SMTP id ff9mr24576666pad.150.1454724245230;
        Fri, 05 Feb 2016 18:04:05 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id fc8sm27226578pab.21.2016.02.05.18.04.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2016 18:04:03 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 06 Feb 2016 09:04:19 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454724190-14063-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285673>

The default tables are usually built with C locale and only suitable
for LANG=3DC or similar.  This should make case insensitive search work
correctly for all single-byte charsets.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 grep.c                             |  8 ++++++--
 grep.h                             |  1 +
 t/t7813-grep-icase-iso.sh (new +x) | 19 +++++++++++++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)
 create mode 100755 t/t7813-grep-icase-iso.sh

diff --git a/grep.c b/grep.c
index 6d34479..843e180 100644
--- a/grep.c
+++ b/grep.c
@@ -324,11 +324,14 @@ static void compile_pcre_regexp(struct grep_pat *=
p, const struct grep_opt *opt)
 	int erroffset;
 	int options =3D PCRE_MULTILINE;
=20
-	if (opt->ignore_case)
+	if (opt->ignore_case) {
+		if (has_non_ascii(p->pattern))
+			p->pcre_tables =3D pcre_maketables();
 		options |=3D PCRE_CASELESS;
+	}
=20
 	p->pcre_regexp =3D pcre_compile(p->pattern, options, &error, &erroffs=
et,
-			NULL);
+				      p->pcre_tables);
 	if (!p->pcre_regexp)
 		compile_regexp_failed(p, error);
=20
@@ -362,6 +365,7 @@ static void free_pcre_regexp(struct grep_pat *p)
 {
 	pcre_free(p->pcre_regexp);
 	pcre_free(p->pcre_extra_info);
+	pcre_free((void *)p->pcre_tables);
 }
 #else /* !USE_LIBPCRE */
 static void compile_pcre_regexp(struct grep_pat *p, const struct grep_=
opt *opt)
diff --git a/grep.h b/grep.h
index 95f197a..cee4357 100644
--- a/grep.h
+++ b/grep.h
@@ -48,6 +48,7 @@ struct grep_pat {
 	regex_t regexp;
 	pcre *pcre_regexp;
 	pcre_extra *pcre_extra_info;
+	const unsigned char *pcre_tables;
 	kwset_t kws;
 	unsigned fixed:1;
 	unsigned ignore_case:1;
diff --git a/t/t7813-grep-icase-iso.sh b/t/t7813-grep-icase-iso.sh
new file mode 100755
index 0000000..efef7fb
--- /dev/null
+++ b/t/t7813-grep-icase-iso.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+
+test_description=3D'grep icase on non-English locales'
+
+. ./lib-gettext.sh
+
+test_expect_success GETTEXT_ISO_LOCALE 'setup' '
+	printf "TILRAUN: Hall=F3 Heimur!" >file &&
+	git add file &&
+	LC_ALL=3D"$is_IS_iso_locale" &&
+	export LC_ALL
+'
+
+test_expect_success GETTEXT_ISO_LOCALE,LIBPCRE 'grep pcre string' '
+	git grep --perl-regexp -i "TILRAUN: H.ll=F3 Heimur!" &&
+	git grep --perl-regexp -i "TILRAUN: H.LL=D3 HEIMUR!"
+'
+
+test_done
--=20
2.7.0.377.g4cd97dd
