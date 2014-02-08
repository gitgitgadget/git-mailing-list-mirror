From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] dir: ignore trailing spaces in exclude patterns
Date: Sat,  8 Feb 2014 15:10:04 +0700
Message-ID: <1391847004-22810-3-git-send-email-pclouds@gmail.com>
References: <1391847004-22810-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 08 09:10:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WC2ze-0007E1-CB
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 09:10:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbaBHIKV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Feb 2014 03:10:21 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:59467 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbaBHIKS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Feb 2014 03:10:18 -0500
Received: by mail-pa0-f43.google.com with SMTP id rd3so4162480pab.30
        for <git@vger.kernel.org>; Sat, 08 Feb 2014 00:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=QSsnqLcLgk/yBITVGRax5V6CLFrtZ59ut9NTWTkdh+8=;
        b=Let8xwK+aWKael0WDqY8dkAE7AhoBAxgwcdQYomNxt+0dVO5t28DrjaBLaSYPFRY1m
         v1wcjhDCiiFNduClIL4wg1NonOLMqUSHB4GyvJVRnPBaxjr+NdnsoAMtAwPEaVF+634f
         3ixHEXf7z2ArijNsw4iVgxQnNFrkdcxPDh4TYmbcvmzpw9z7kbgypKksObP4G+9cwZbt
         muloBR+Qu2iUTuydjF1yf0nQsR3RbVmYQZhBzjqG4JppVYrc2Yg+F0FoxEKwEVFIIzvm
         Sx7l5Vwo14YgqG7dhEUkDVdybrYa4Xcu3RZwhyuIhgzuvSIGysknvl2U1gFc8D/cEt3E
         WVSg==
X-Received: by 10.66.144.227 with SMTP id sp3mr13039513pab.100.1391847017541;
        Sat, 08 Feb 2014 00:10:17 -0800 (PST)
Received: from lanh ([115.73.239.36])
        by mx.google.com with ESMTPSA id qf7sm53618796pac.14.2014.02.08.00.10.14
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Feb 2014 00:10:16 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Feb 2014 15:10:21 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391847004-22810-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241827>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/gitignore.txt | 3 +++
 dir.c                       | 4 +---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index b08d34d..8734c15 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -77,6 +77,9 @@ PATTERN FORMAT
    Put a backslash ("`\`") in front of the first hash for patterns
    that begin with a hash.
=20
+ - Trailing spaces are ignored unless they are quoted with backlash
+   ("`\`").
+
  - An optional prefix "`!`" which negates the pattern; any
    matching file excluded by a previous pattern will become
    included again. It is not possible to re-include a file if a parent
diff --git a/dir.c b/dir.c
index 9edde44..7dee5ca 100644
--- a/dir.c
+++ b/dir.c
@@ -496,9 +496,7 @@ static void check_trailing_spaces(const char *fname=
, char *buf)
 	int len =3D strlen(buf);
 	while (len && buf[len - 1] =3D=3D ' ')
 		len--;
-	if (buf[len] !=3D '\0')
-		warning(_("%s: trailing spaces in '%s'. Please quote them."),
-			fname, buf);
+	buf[len] =3D '\0';
 }
=20
 int add_excludes_from_file_to_list(const char *fname,
--=20
1.8.5.2.240.g8478abd
