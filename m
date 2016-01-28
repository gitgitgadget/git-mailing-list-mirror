From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 09/10] diffcore-pickaxe: "share" regex error handling code
Date: Thu, 28 Jan 2016 18:56:22 +0700
Message-ID: <1453982183-24124-10-git-send-email-pclouds@gmail.com>
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 12:57:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOlCc-0007LB-69
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 12:57:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935235AbcA1L5Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jan 2016 06:57:24 -0500
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36575 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932669AbcA1L5U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 06:57:20 -0500
Received: by mail-pa0-f68.google.com with SMTP id a20so1894804pag.3
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 03:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=lAHfluHYo7+scbjUCN/7XJgsfddre8cFPxUCbD+f8xQ=;
        b=IDMYMmRe26g9G2QmMQc7UCBkJRIUdcOneZmhuoqjDRNNn7DABGDMjFFtmz/aGlEWHS
         Z1XPzFLaE6hNb1puz2Z7Owr1y11pCtYmtwQn4qzSRkDNFx971NgwlU5w72o8O0TKoc0K
         /y2OvbHHq+Y3yMScQsuYXnSsQTmN455yz/cgLxXlzewLBf68GMjRDbBdQbwwoE8AJZQe
         QEkLH3tPrgGdlxYF9bnZiuMistlE+I58Eff1FtKwi872nRv1mOpvVw5nolwXvU+/da3L
         2QliyZpRQ2RAMa8jz+Rso4X6aGNok23bm9SfmjlcZh/dQEGGKSyB+We0LJ3K/qM5QQXi
         xWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=lAHfluHYo7+scbjUCN/7XJgsfddre8cFPxUCbD+f8xQ=;
        b=Rdi4nVM0d97bBMzkw+zm832z8cj0Jr0Wwcax67utZTk2CVdoyU6SMZNvWbCRLgNjik
         bcRt+bkDSZu21VVmwcFFq3M4VvtlOW2LyRBuS+jpYTp3p3KzvFDwzEIYvV7bht+VXv7n
         DnOpI+Xtku1Z53uMX2E3/iLkT+JndXAUS0G8Lch8ZWKOxuuwD8JDJXoxZhKKrGz8wgkr
         KRjVSC75iDv8ZAZgPZVe1TE828Hg95pZZ65mwOMlM91l6ZUqWju46U//qoGNWQZbEoLE
         ap7ny0JbE+wrdxo53lCHMVVtsHeSo4YX4Kbj3Yw1t3NUU0wKJTgcq//aJQTKFVgrjQFu
         WkXw==
X-Gm-Message-State: AG10YORivvjIGU+HGI0d0kkU84orG/htxPnmEfdcvVOGC0+UCKO+WGkTskbXK1ILP9NnLg==
X-Received: by 10.66.235.36 with SMTP id uj4mr3833285pac.85.1453982239823;
        Thu, 28 Jan 2016 03:57:19 -0800 (PST)
Received: from lanh ([115.76.235.75])
        by smtp.gmail.com with ESMTPSA id by2sm15992578pab.6.2016.01.28.03.57.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jan 2016 03:57:18 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 28 Jan 2016 18:57:25 +0700
X-Mailer: git-send-email 2.7.0.288.g1d8ad15
In-Reply-To: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285014>

There's another regcomp code block coming in this function. By moving
the error handling code out of this block, we don't have to add the
same error handling code in the new block.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diffcore-pickaxe.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 7715c13..69c6567 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -204,20 +204,13 @@ void diffcore_pickaxe(struct diff_options *o)
 	int opts =3D o->pickaxe_opts;
 	regex_t regex, *regexp =3D NULL;
 	kwset_t kws =3D NULL;
+	int err =3D 0;
=20
 	if (opts & (DIFF_PICKAXE_REGEX | DIFF_PICKAXE_KIND_G)) {
-		int err;
 		int cflags =3D REG_EXTENDED | REG_NEWLINE;
 		if (DIFF_OPT_TST(o, PICKAXE_IGNORE_CASE))
 			cflags |=3D REG_ICASE;
 		err =3D regcomp(&regex, needle, cflags);
-		if (err) {
-			/* The POSIX.2 people are surely sick */
-			char errbuf[1024];
-			regerror(err, &regex, errbuf, 1024);
-			regfree(&regex);
-			die("invalid regex: %s", errbuf);
-		}
 		regexp =3D &regex;
 	} else {
 		kws =3D kwsalloc(DIFF_OPT_TST(o, PICKAXE_IGNORE_CASE)
@@ -225,6 +218,13 @@ void diffcore_pickaxe(struct diff_options *o)
 		kwsincr(kws, needle, strlen(needle));
 		kwsprep(kws);
 	}
+	if (err) {
+		/* The POSIX.2 people are surely sick */
+		char errbuf[1024];
+		regerror(err, &regex, errbuf, 1024);
+		regfree(&regex);
+		die("invalid regex: %s", errbuf);
+	}
=20
 	/* Might want to warn when both S and G are on; I don't care... */
 	pickaxe(&diff_queued_diff, o, regexp, kws,
--=20
2.7.0.288.g1d8ad15
