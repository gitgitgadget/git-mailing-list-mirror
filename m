From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 19/21] list-files -F: show submodules with the new indicator '&'
Date: Sun,  8 Feb 2015 16:01:37 +0700
Message-ID: <1423386099-19994-20-git-send-email-pclouds@gmail.com>
References: <1423386099-19994-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 10:04:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKNmp-0006Uc-PS
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 10:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755964AbbBHJEH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 04:04:07 -0500
Received: from mail-pd0-f169.google.com ([209.85.192.169]:36451 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755866AbbBHJED (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 04:04:03 -0500
Received: by pdjp10 with SMTP id p10so14337639pdj.3
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 01:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9AqqYp3Mz9EPnJjSNJCJ3z5wAIgcmvG61THdlPNmSQ4=;
        b=ANOnEIcbe+qbOITN45rSnxL1qWw+yuW1YZeRsmV5w64yR3oEMdEhGG2afYLpaHvMcR
         jvzXAarZjX36n1F8xwHFnTvPZmW4GMvLibL8nPfkvcStfQo/gvsR6mSPkxV+wCrkNYeX
         iRwi+Rx8ukpSWQWdUkDe9tgRvuvZeNntNJrlF9xC9Nd7R6PddFowBDCjKD/PeW5FCsqP
         jdOIGUafKJ9jSrjO9tXJZv8xnahg14SCHfwlGMC0FHmtpPFYhcA8jPQBJ1NsLN3Sxuve
         DrhKmI1WbXltBRoSjrjR0r11NcborW5wFDUjeZt8oQUUCBesgp61+AnBezdcpVtflbWN
         CrGw==
X-Received: by 10.70.102.35 with SMTP id fl3mr19135546pdb.30.1423386242928;
        Sun, 08 Feb 2015 01:04:02 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id jd10sm1256447pbd.23.2015.02.08.01.04.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 01:04:02 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 16:04:10 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1423386099-19994-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263506>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-list-files.txt | 4 ++--
 builtin/ls-files.c               | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-list-files.txt b/Documentation/git-list-=
files.txt
index 475c6da..223f6fd 100644
--- a/Documentation/git-list-files.txt
+++ b/Documentation/git-list-files.txt
@@ -54,8 +54,8 @@ OPTIONS
=20
 -F::
 --classify::
-	Append indicator (one of `*/=3D>@|`, which is executable,
-	directory, socket, Solaris door, symlink, or fifo
+	Append indicator (one of `*/=3D>@|&`, which is executable,
+	directory, socket, Solaris door, symlink, fifo, or submodule
 	respectively) to entries.
=20
 -R::
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 9e444ff..d3540d1 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -92,6 +92,8 @@ static void append_indicator(struct strbuf *sb, mode_=
t mode)
 		c =3D '|';
 	else if (S_ISSOCK(mode))
 		c =3D '=3D';
+	else if (S_ISGITLINK(mode))
+		c =3D '&';
 #ifdef S_ISDOOR
 	else if (S_ISDOOR(mode))
 		c =3D '>';
--=20
2.3.0.rc1.137.g477eb31
