From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 18/19] list-files -F: show submodules with the new indicator '&'
Date: Sun, 30 Nov 2014 15:56:06 +0700
Message-ID: <1417337767-4505-19-git-send-email-pclouds@gmail.com>
References: <1417337767-4505-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 09:58:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xv0LC-0003Tg-1k
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 09:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186AbaK3I6q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 03:58:46 -0500
Received: from mail-pd0-f171.google.com ([209.85.192.171]:49159 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbaK3I6p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 03:58:45 -0500
Received: by mail-pd0-f171.google.com with SMTP id y13so8973956pdi.16
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 00:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=sK7DZX0yQdUx5+E+D3pi8V+NQCP261WZ+pAiB0e8UNo=;
        b=INK1OmIBQPn7xkRF3wucybDcwAho8oTobgfXLiyracv0HFr4dN/iKsQpkV21K5KZ1V
         J+lCXWtLuYEwD+PKGHZzIslEkfLwVR23D5e6CdYBX9OCpzTZORYT8hdW2XAQThruOKnR
         Si1KWpJ/I2snPeE6DkHwWZ7FRvRhPA4NRf9hEnVkbuJ6fJYF0Iak918lww72I9qXX0ZR
         OkqArb2P2alO857ytkzM6TSkV056otUVSCrs1WMj4w1jFBgoRBw6/PcgabF7bu9eyWyx
         kDh17S5GKcTmyE0dqvaY2cDPselvFMBbJzmw9sFX4pQBD/yjGzo0baMq39z2EGt3/uLo
         StJw==
X-Received: by 10.68.218.231 with SMTP id pj7mr86962978pbc.163.1417337925565;
        Sun, 30 Nov 2014 00:58:45 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id wl10sm14306173pbc.58.2014.11.30.00.58.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 00:58:45 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Nov 2014 15:58:43 +0700
X-Mailer: git-send-email 2.2.0.60.gb7b3c64
In-Reply-To: <1417337767-4505-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260441>

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
index 28737cb..5b5a068 100644
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
2.2.0.60.gb7b3c64
