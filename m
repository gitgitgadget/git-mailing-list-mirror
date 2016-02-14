From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 03/12] test-regex: isolate the bug test code
Date: Sun, 14 Feb 2016 18:49:47 +0700
Message-ID: <1455450596-11904-4-git-send-email-pclouds@gmail.com>
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
	id 1aUvDR-0001LX-88
	for gcvg-git-2@plane.gmane.org; Sun, 14 Feb 2016 12:51:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbcBNLvk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2016 06:51:40 -0500
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36510 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbcBNLvY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2016 06:51:24 -0500
Received: by mail-pa0-f66.google.com with SMTP id gc2so45592pab.3
        for <git@vger.kernel.org>; Sun, 14 Feb 2016 03:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ay6O8bmY4y0MJHTJk+OiOvmUJe4Q9qX41pX+dNCRjhM=;
        b=wDQ5KonIhvkv26d+EHqsn2MQVUgbSxNtUKYRXTWVd8cc3n0APeO8sFw/xVnTMgbxgy
         dASINX5VtsFiHmQXCBjMUA+2PfKAP0lWNc5zNW0Iog6aKuOn2nez2i+CHNXkM2dSb5zo
         WwQsB0aOQKtUXdsRBTm6q7mkgYGIPIjrMWYEHht92tGia9qdhnQv9vtXLXNUTSWrc54H
         rlVc6toBM47c9nH5HfhxMwpuQGr+EqRrAFPnIEmi2R1LAP67FiteYXe6rs+I8g1HeGBl
         MXCMoXjLzZE9Xro/82ARFD2oV7bp9hPADKzhpY+4LDjOx3X6R8IqrxjdcvufTsuMdaov
         wLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=ay6O8bmY4y0MJHTJk+OiOvmUJe4Q9qX41pX+dNCRjhM=;
        b=RkTN1lppXqUBoU27h0LyrHY3kE2c+uBRKAMNS78A98udejZPIyo57dGpGlbY+TI+7V
         qjcRoSVk3H8X7S1JwKP6xd0q/stbBN2xJ2WFEy+7dFjCkwL18SNGh9ztwlPXewK1WBdC
         nR72+AoR1hjCyeQL/yFYyJ/WnqHUVamocjnJGAd+vhd8hsQv+hNYVJOsBSuTYeFJSAIi
         XRD6sYUHhPYdUQ0gdJbmGIMn1alrFiOfOSwv1IEJKKYLhlETZMb04W3bDjShxARTX30q
         3duL1BgPrxMvWdUgUR/20b+5VC8XydAtlvpeaxqJelxTH+Evb8UKGSASxZN9fh3Wrfv7
         39mg==
X-Gm-Message-State: AG10YOT8RTUI0rjwusvaC7T2oDMw3D6lDwziH1XlBWhVPao412EBTpfZdRKiPxDxHJLjwQ==
X-Received: by 10.66.124.131 with SMTP id mi3mr15578347pab.7.1455450684187;
        Sun, 14 Feb 2016 03:51:24 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id s197sm31273756pfs.62.2016.02.14.03.51.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Feb 2016 03:51:20 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Feb 2016 18:51:42 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455450596-11904-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286139>

This is in preparation to turn test-regex into some generic regex
testing command.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t0070-fundamental.sh |  2 +-
 test-regex.c           | 12 ++++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 5ed69a6..991ed2a 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -31,7 +31,7 @@ test_expect_success 'git_mkstemps_mode does not fail =
if fd 0 is not open' '
=20
 test_expect_success 'check for a bug in the regex routines' '
 	# if this test fails, re-build git with NO_REGEX=3D1
-	test-regex
+	test-regex --bug
 '
=20
 test_done
diff --git a/test-regex.c b/test-regex.c
index 0dc598e..67a1a65 100644
--- a/test-regex.c
+++ b/test-regex.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
=20
-int main(int argc, char **argv)
+static int test_regex_bug(void)
 {
 	char *pat =3D "[^=3D{} \t]+";
 	char *str =3D "=3D{}\nfred";
@@ -16,5 +16,13 @@ int main(int argc, char **argv)
 	if (m[0].rm_so =3D=3D 3) /* matches '\n' when it should not */
 		die("regex bug confirmed: re-build git with NO_REGEX=3D1");
=20
-	exit(0);
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	if (argc =3D=3D 2 && !strcmp(argv[1], "--bug"))
+		return test_regex_bug();
+	else
+		usage("test-regex --bug");
 }
--=20
2.7.0.377.g4cd97dd
