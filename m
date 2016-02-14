From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 10/12] diffcore-pickaxe: "share" regex error handling code
Date: Sun, 14 Feb 2016 18:49:54 +0700
Message-ID: <1455450596-11904-11-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun Feb 14 12:52:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUvDr-0001as-7y
	for gcvg-git-2@plane.gmane.org; Sun, 14 Feb 2016 12:52:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956AbcBNLwL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2016 06:52:11 -0500
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34665 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbcBNLwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2016 06:52:09 -0500
Received: by mail-pa0-f67.google.com with SMTP id yy13so5977526pab.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2016 03:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=PXvfHdRJTWkbnNzkRMExruyoNoc3Ac0XhRKUYFyLbMI=;
        b=SYjZQYyEkl0SP0GKWbGeOpI1moVHhh/UnGtW3+nbBB3UXc67XCkDL370hFWfMPLNM9
         bEmT3XzIDxLaDllGkhJUNyyg9zPkRqk0dAHDJVHzLBB8TwqbPsGk7+LCcS98LNZ2hUkk
         xh7HucX8ONEJk6bfGHNR+EgYQMZ+Hq55ekM5usaak+nlcLl0HgA7gRhLUOzPdqPtciQz
         KmPSDzvuhDdQdBf+vb9Jsys1rJ+3HyG8Y5AeMKw52y4nYXq1XBF8LV84S9GqpQdhoPFL
         izn/Y6gnN9u4B5Og6yvkmcKrFHgCFLkK3KM5o/IaA6EHRDWvwGiMMowm2oWGf2XFczPQ
         lB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=PXvfHdRJTWkbnNzkRMExruyoNoc3Ac0XhRKUYFyLbMI=;
        b=cQzQJWLJqFYuuhdAXl459NDl1cPsot4WrlPIQjVgFSQ1ol1udeIw+pf7HUndNg+4LP
         LnhbCpmkk6RcNz6CSIdU4ATYLQhyPXbObiHrKfgdSO/zLtHeRLZVyHXx9qk+vF6ZsHlk
         qJSd1pOphTqYe7KfmirymehIoDIGCv4qbW/TKuGlc6sOV3KgyuNXGpLrSnuUnvI7VZ/s
         w8WMjdsJiPf0Vv+hOPARpVtwqiOvj63FC8HlYwRBj/W2cVlyeRyIgvglcwOG+7+Q93Gx
         fOQ6wUENGpwTDNdlNe8mSoQX0aqDHp3hjuhQjWfB+TkeUXjKrZ5cr1a4/tOVUbqC1Z3l
         fulg==
X-Gm-Message-State: AG10YOQqW0+xjxyaCu2gqFeGIxSXZe2fdWTUuv+sWhD3aOd6PkQnu7CkZ4GpCMKXSjsgTw==
X-Received: by 10.66.146.100 with SMTP id tb4mr15065243pab.99.1455450729605;
        Sun, 14 Feb 2016 03:52:09 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id z7sm31289424pfi.19.2016.02.14.03.52.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Feb 2016 03:52:08 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Feb 2016 18:52:30 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455450596-11904-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286145>

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
2.7.0.377.g4cd97dd
