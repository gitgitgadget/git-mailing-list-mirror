From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 06/10] grep/pcre: prepare locale-dependent tables for icase matching
Date: Thu, 28 Jan 2016 18:56:19 +0700
Message-ID: <1453982183-24124-7-git-send-email-pclouds@gmail.com>
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 12:57:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOlCI-000712-6L
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 12:57:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934823AbcA1L5G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jan 2016 06:57:06 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36036 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932669AbcA1L5E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 06:57:04 -0500
Received: by mail-pf0-f195.google.com with SMTP id n128so1970999pfn.3
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 03:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=tJzZ101v2xfWh/zPShzNzlrvyOfNCGtVSuzSjBdEvY4=;
        b=xEuwa4bxhEYDctEJy42qYYNBEZEapMh4KZ/clYhWO942NvLNh+0U+mTfwgv3zTOQNr
         iCrMB2mZv08ayIWhRvQFtAKML4KS9pTSqhvGKB5tIzEKm+DS9VlDAaU6gSp12YFqsgvY
         vnalVm6bfz9ih42es0mcSz/1H2MY48r/Vi9wu+oY0WpD+hSC15pPKNkdGvGgEkZx6/fs
         1ReUYqgNWawPQySv20wrvgc2rfn35Y8fQl5h/3eQzjUCcG6i7M7aj+jn3RyZ3uY+sed5
         b70cjtQiKnXfvxpZwN2bHN++ZvVwo+l3uMxSXFczrcTcIjkBKLuyPrj0h+mI4isk2/FP
         Mobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=tJzZ101v2xfWh/zPShzNzlrvyOfNCGtVSuzSjBdEvY4=;
        b=kKqY4x5RyB9/DD4Byb0PMiURpAHrEkXJGi853If2eoOy9k5u8+d3BVMe6wuBaO97Iq
         zT67q8YXyJ0nKtm9VhQnQ3NSQ6Cymzzew2kezxnC8uv/WQVIB8TIiFE5DZpBnn3oJaKs
         OoVGcGpuIyNNYszXzpCnD3Q5tCFRIazV8trxNCZDBhcg2gLzgCGF6qXtYfRKpPrIwBHz
         mKPCd7iZbcVUtIc2mICy+VTJCyLXZtmsBsIWdogeDumbNV2DpyrsJLsY8fd2uEL34395
         ojPJQmMOnfsWyVKrJGQGqidudSC4QisO9aH54p8FXouBJL/B2Hg4tXmfTuOr2r5f9SZ+
         V3gw==
X-Gm-Message-State: AG10YOQ86kcnb0+ED06hM7YvPyu2mBQWUiYdIjkKV0lfAyb0PYdnlJigfL3SKwcnCRRxqw==
X-Received: by 10.98.15.207 with SMTP id 76mr3908368pfp.60.1453982223554;
        Thu, 28 Jan 2016 03:57:03 -0800 (PST)
Received: from lanh ([115.76.235.75])
        by smtp.gmail.com with ESMTPSA id b63sm15971829pfj.25.2016.01.28.03.57.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jan 2016 03:57:02 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 28 Jan 2016 18:57:08 +0700
X-Mailer: git-send-email 2.7.0.288.g1d8ad15
In-Reply-To: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285012>

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
index fa96a29..921339a 100644
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
2.7.0.288.g1d8ad15
