From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v6 04/11] test-regex: expose full regcomp() to the command line
Date: Sat,  6 Feb 2016 09:03:03 +0700
Message-ID: <1454724190-14063-5-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sat Feb 06 03:03:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRsE3-0003eH-7p
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 03:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbcBFCDs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 21:03:48 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34055 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbcBFCDr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 21:03:47 -0500
Received: by mail-pa0-f49.google.com with SMTP id uo6so43737101pac.1
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 18:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=QQhd+UZLUTU8+cihV7ci/f2eZ42BrWLcwHUzDoguvZw=;
        b=i4XXSV0+tXV48ojmBzUKV7Q+atTlgbx/8IUaroTFmjhG6AmOdRaa5mGrcJSz7WXW1U
         LSj+cY4UVD2uaoE2ANIwzDsQkW8895pL0EtI1sWO3dlE4p6Tz6F77UTicWrvnJ1aGALn
         gmdFpS5MHBvaqVpAXJR4oDKcCJjWb9CxuNVRzG6TNBrSXLB+ieouxX4lzH0nO7f7fQ7d
         7RNvlBgAQXzjhDc8cDA9WQIJ5ewCrfrqxfVOH+Cm0tXd0QZCa6FtCgcaR7InbIOSl2aD
         +ee3l6Sk7EX6krFbi1Hj55Zaki2PxWvqyGSq/kaiX7ZvLuUdjw4uG0P2I4Bpzlzz7Ctc
         AiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=QQhd+UZLUTU8+cihV7ci/f2eZ42BrWLcwHUzDoguvZw=;
        b=QVB/+QGG4bm6PcOhD7t8YBqCW6dPpGinTDrvm/Pt4gVYQJYPn/KKSbB3kYHWf+NlUk
         Jl0dCrxujtJHSHCkCohF0yqoAyJx3OrcZIpFn46r0c5I3W5g6X1sbxv/j4EEQ9LJ5Lli
         nU90VkVAXgiVexf/9G4xNEH+A6CY3JGgMqv3/Efk8tFhUDpKOwSn1Xxavht4cSoqvgu2
         Dldhed2r3EI3L+ar2dD4Kvtvpu/ZIGXghbt5KvTbdDzOYQxp54A67xMpIHxIvjlZoenA
         xFJGg+RFt0yvCYvn6kgMvFR3tYiIicz3oS7ooUhq19VOJdV572FW1AodhRm0lDJ7EkxR
         hR/A==
X-Gm-Message-State: AG10YOT3rhdwa3RImY1uzFxdqV/KxkeQEEjf5m/eERGTcukjkZ4n3ojM7Bw61mE9rXZqBw==
X-Received: by 10.66.63.104 with SMTP id f8mr24467865pas.41.1454724226776;
        Fri, 05 Feb 2016 18:03:46 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id r77sm27197637pfa.47.2016.02.05.18.03.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2016 18:03:45 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 06 Feb 2016 09:04:01 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454724190-14063-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285669>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 test-regex.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/test-regex.c b/test-regex.c
index 8c51f5a..d1a952c 100644
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
-		die("must be used with --bug");
+	else if (argc < 3)
+		die("usage: test-regex --bug\n"
+		    "       test-regex <pattern> <string> [<options>]");
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
