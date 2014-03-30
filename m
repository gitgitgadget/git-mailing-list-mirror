From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 18/18] list-files -F: show submodules with the new indicator '&'
Date: Sun, 30 Mar 2014 20:56:09 +0700
Message-ID: <1396187769-30863-19-git-send-email-pclouds@gmail.com>
References: <1395841697-11742-1-git-send-email-pclouds@gmail.com>
 <1396187769-30863-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 30 15:57:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUGEr-0003hB-7A
	for gcvg-git-2@plane.gmane.org; Sun, 30 Mar 2014 15:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384AbaC3N5Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Mar 2014 09:57:25 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:49902 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbaC3N5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2014 09:57:24 -0400
Received: by mail-pa0-f53.google.com with SMTP id ld10so6963771pab.26
        for <git@vger.kernel.org>; Sun, 30 Mar 2014 06:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=IsS7FxI6pY+MuFJRXQX4GeAtTygRw2XvD3YakR7O6A8=;
        b=ag3LuDkQmCti3YilbJu9Oztm8qAxObPFpwj+r3ppfUisP6QI7nbhsLdC/NGGQ0c7Os
         zzoTy/CGIZCCokOa6ZF3FhO79L7FAo/SA/eU/VEcl2fezK9AFcLUuh5aXWvzqZ8YMg55
         iFIKk6LvvjdqusHQgL+B+MMwRHInE5y81leRNb/zChwfd5XgYpRu1+IGTGWv03xZPlC5
         1nEsZCeuUcc7xQlcncM1pSEh2G05PmGn7iTzWlPP84C08lcIE3qaYbuhnmfGbhkk50Vx
         0bf7olPRSVGBBxFAVkTUpkM6LGgDODhxvU/lVNBV4IwpnNFgQ3yKk7Zvne/TwUjCIMdD
         Y2jQ==
X-Received: by 10.68.237.133 with SMTP id vc5mr19451670pbc.92.1396187843292;
        Sun, 30 Mar 2014 06:57:23 -0700 (PDT)
Received: from lanh ([115.73.202.240])
        by mx.google.com with ESMTPSA id iu10sm37329868pbd.71.2014.03.30.06.57.20
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 30 Mar 2014 06:57:22 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Mar 2014 20:58:20 +0700
X-Mailer: git-send-email 1.9.1.345.ga1a145c
In-Reply-To: <1396187769-30863-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245482>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-list-files.txt | 4 ++--
 builtin/ls-files.c               | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-list-files.txt b/Documentation/git-list-=
files.txt
index 22084eb..c57129b 100644
--- a/Documentation/git-list-files.txt
+++ b/Documentation/git-list-files.txt
@@ -53,8 +53,8 @@ OPTIONS
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
index 2d475f0..f3e34db 100644
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
1.9.1.345.ga1a145c
