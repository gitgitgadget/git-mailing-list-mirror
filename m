From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 07/12] grep/pcre: prepare locale-dependent tables for icase matching
Date: Sun, 14 Feb 2016 18:49:51 +0700
Message-ID: <1455450596-11904-8-git-send-email-pclouds@gmail.com>
References: <1454724190-14063-1-git-send-email-pclouds@gmail.com>
 <1455450596-11904-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 14 12:51:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUvDX-0001OQ-PG
	for gcvg-git-2@plane.gmane.org; Sun, 14 Feb 2016 12:51:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbcBNLvw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2016 06:51:52 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34485 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869AbcBNLvv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2016 06:51:51 -0500
Received: by mail-pf0-f195.google.com with SMTP id 71so6245048pfv.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2016 03:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ItgL5BehzWPRxAewASYG4OAmaSBJm1yC+Cst37X2Bws=;
        b=CB+Vnnvxt2Qo6mxU8zhGC3EEHY+HjDlJTxLVSc7ed8rNfAAxvDZdNu2P8UxnzfdZOk
         yR824ocj/hBFChENuTQLmtDfHJZlIGzxP9o7Ng5M3jXwYzaCNRJ/d7lNvnEXcVu6QlMy
         VFOfE7GqvRLwlyJOcfgvzG0AYAvqV00jsNwN9Lj0UuDZ3SuZHPlLIxtCvpq6piU5rqWW
         FEasQ4R9yPKV3F0uBB5e8bEvFqO9R2lobkZYBqnjw/I7iQ9+KjB46MmU+jJfo09imY/l
         GLlGqCyfQffl9UnWlmNASogrjcHqTzqVT2e1VeArd484eIYg42I+Pl+mn69DjCXmfBWp
         EanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=ItgL5BehzWPRxAewASYG4OAmaSBJm1yC+Cst37X2Bws=;
        b=PAKD2B72jL4j3/kTBirgUMGx1U75PvNvNX38MRDVSSHJb0OAaktGieX2eTL5E/PqY+
         8TcWgBfRoLBijo8w1M2EpJcSqEtiFXdfbFXNBtpdoQ8F4aU5uri9mWIyVTDdaOZ8ALqO
         ktkRH7jaYIO+CDIPQXnQaKXbajylDIspbJLjmywv40tQEpZyw1k3e1rDGEerFfS37Y60
         tVfrmZZ6WndhFRNRyUy2mygMBrY8hzrzUvvqP/PkNHpG33rNQWNijZQTGUItH+K0bnDs
         UpDmctDCxTYdsVZlapYJPSdCEbH/mZ3kgcw6SyWooJ/K15Jo1C5ifR8vxCcMJ5XQE5cK
         4PxA==
X-Gm-Message-State: AG10YOQ/mV1rhnRZsgiS2eFBkBiGcU3GSwM6bT0c42DKhqjezqF71DhaxJ4o5azVVg+E3w==
X-Received: by 10.98.67.92 with SMTP id q89mr15767827pfa.137.1455450710771;
        Sun, 14 Feb 2016 03:51:50 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id 74sm31309038pfs.33.2016.02.14.03.51.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Feb 2016 03:51:49 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Feb 2016 18:52:11 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455450596-11904-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286141>

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
index 6de58f3..22f4d99 100644
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
