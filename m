From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 04/12] test-regex: expose full regcomp() to the command line
Date: Sun, 14 Feb 2016 18:49:48 +0700
Message-ID: <1455450596-11904-5-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun Feb 14 12:51:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUvDR-0001LX-Ql
	for gcvg-git-2@plane.gmane.org; Sun, 14 Feb 2016 12:51:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860AbcBNLvl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2016 06:51:41 -0500
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33610 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbcBNLva (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2016 06:51:30 -0500
Received: by mail-pa0-f67.google.com with SMTP id zv9so190069pab.0
        for <git@vger.kernel.org>; Sun, 14 Feb 2016 03:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=TH+uajkDjM/4EtH3/sh9jUhyQk5NwXlNxC4hLmGFySg=;
        b=YmvdTZs21yzYFudASJuDwg8wOYEvYDk5KRoPlGYJfeDFq7La8ZB3xDoEU7WQrT9DKI
         A2IZSo+oNDa4wLnUqMxCMipl6+xHbIJubhpQebYCZkVw5gTX53AgRmUb4zEmrW7jESaB
         W92y6ktYz2INY1JeC7kSOH+d4dcBIEyB/GIY+ciKpWgHI6AD7yvutV6NnXvWRFDIj0xD
         551IZvccykkGXDNprrwC2W50uhSL8Yt7lrncpy8wuSJaotS6jaunhpRQCskk8SarfeIb
         1s2nK6wABlOftYA0GGivi0tq8F+5fxjIMpPqzdrPCVty/7H+/uSyOqZzyq6KmRSP8De9
         3bTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=TH+uajkDjM/4EtH3/sh9jUhyQk5NwXlNxC4hLmGFySg=;
        b=dbhrwKXgDmTlIgTmRNMrpLIiqzFCAfGbcjzoQJKDazIOjjFS4XwrZzZgSoKi6NyJFX
         QfDtb2IVnjaQcvSxy6qgtD2s3rOfEpq0WRl1/MR84gbmTRF79d9KI0v+kuD3jMxUX47L
         IvYB0gfjFXgexLYlXuZcvuhRQbwwIsk5kaJ635oQezdcG3E7WqlNNU4vdW2uVp5+ZmpI
         jQz26Xvnwe1TFyfSn9n8TQDzMGCsN3JTxYB7apfmFQyM54FuGMyB1N7JIMJtFSmNOEGy
         WSBMdE9LMfhFKnol1lJ361W5X44c7wq319G6B4NFv7bDycaxjNF1M8D6VM02vNteFDMg
         +EaQ==
X-Gm-Message-State: AG10YOS5w90lRoHfjjzq1eMeJ51RyiOvjXSLqCCBeo73EmBcfc9b6V2DbowCyxajs90vGg==
X-Received: by 10.66.191.104 with SMTP id gx8mr15664812pac.21.1455450690447;
        Sun, 14 Feb 2016 03:51:30 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id v75sm31306555pfa.39.2016.02.14.03.51.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Feb 2016 03:51:28 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Feb 2016 18:51:51 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455450596-11904-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286138>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 test-regex.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/test-regex.c b/test-regex.c
index 67a1a65..eff26f5 100644
--- a/test-regex.c
+++ b/test-regex.c
@@ -1,4 +1,21 @@
 #include "git-compat-util.h"
+#include "gettext.h"
+
+struct reg_flag {
+	const char *name;
+	int flag;
+};
+
+static struct reg_flag reg_flags[] =3D {
+	{ "EXTENDED",	 REG_EXTENDED	},
+	{ "NEWLINE",	 REG_NEWLINE	},
+	{ "ICASE",	 REG_ICASE	},
+	{ "NOTBOL",	 REG_NOTBOL	},
+#ifdef REG_STARTEND
+	{ "STARTEND",	 REG_STARTEND	},
+#endif
+	{ NULL, 0 }
+};
=20
 static int test_regex_bug(void)
 {
@@ -21,8 +38,38 @@ static int test_regex_bug(void)
=20
 int main(int argc, char **argv)
 {
+	const char *pat;
+	const char *str;
+	int flags =3D 0;
+	regex_t r;
+	regmatch_t m[1];
+
 	if (argc =3D=3D 2 && !strcmp(argv[1], "--bug"))
 		return test_regex_bug();
-	else
-		usage("test-regex --bug");
+	else if (argc < 3)
+		usage("test-regex --bug\n"
+		      "test-regex <pattern> <string> [<options>]");
+
+	argv++;
+	pat =3D *argv++;
+	str =3D *argv++;
+	while (*argv) {
+		struct reg_flag *rf;
+		for (rf =3D reg_flags; rf->name; rf++)
+			if (!strcmp(*argv, rf->name)) {
+				flags |=3D rf->flag;
+				break;
+			}
+		if (!rf->name)
+			die("do not recognize %s", *argv);
+		argv++;
+	}
+	git_setup_gettext();
+
+	if (regcomp(&r, pat, flags))
+		die("failed regcomp() for pattern '%s'", pat);
+	if (regexec(&r, str, 1, m, 0))
+		return 1;
+
+	return 0;
 }
--=20
2.7.0.377.g4cd97dd
