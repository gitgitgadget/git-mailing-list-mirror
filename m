From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] setup.c: make check_filename() return 0 on ENAMETOOLONG
Date: Sun,  7 Feb 2016 06:23:12 +0700
Message-ID: <1454800992-15953-1-git-send-email-pclouds@gmail.com>
References: <CA+4vN7w2=JWusWDhhGNzAkJbE-s44G4WoXdvf26yzvtYfpktfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: ole@tange.dk,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 07 00:24:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSCCy-0003pF-Eh
	for gcvg-git-2@plane.gmane.org; Sun, 07 Feb 2016 00:24:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbcBFXXZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Feb 2016 18:23:25 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36125 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbcBFXXY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2016 18:23:24 -0500
Received: by mail-pf0-f170.google.com with SMTP id n128so88370004pfn.3
        for <git@vger.kernel.org>; Sat, 06 Feb 2016 15:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=gdyX1w3oQ9PfbKEHRSR7Czcwh+Uwkw18+kPj9+VAVps=;
        b=E73HUYomlQ/CAoGtdDz+R43m+5pVbfGeykV6RZdYqz5fESAjBEPsGAEJony1rWoD39
         VHFQPl+ruT9oyMQlDvKjBpcS5LOguUUlwMD2blgNyZf3BrPtV5PydNKdz9MmVy8S4hxg
         Cft1wnmldZUob4xnkC31xDxqYzbXjV0ZyZRnQx6x8ZafIjsC5zA3UbzxnuZV9+yPyWfJ
         7e0E9kRi6/qxlYoNXpnhgcZQno4eAiB5ChzVGqMCFmPl10IbP/axnp8i9fTyDQu5l9Qu
         0/6AjYAq22LHIpZYgD6RWMoQWLRt8rJgg6HXmO4OPqlZXFz8dvRqu9ks5bZsdDcN0GZf
         HV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=gdyX1w3oQ9PfbKEHRSR7Czcwh+Uwkw18+kPj9+VAVps=;
        b=M3R/mQU9d5BhcI2Y69DI616EKdGyr0a+OXRKWYnAE3Ghrq8NCra/CjYm/ZX5D4iWLH
         lrjCzs0TibyiFMIhpxz0uTVXVwqtdXKa5rmuJbI8Yzxzdq465cRyMjFqwOoQnMDrNP7b
         EvTODLqXjjOcR0Yx5KDGMD9LDqSBiY1SdR5dJnJxejgrebjKlen0LGT6qQH7Ih7feZWs
         xMTZm/gBM6wkXjWk0fxV7lgY4QV3y+G62uRLu0Aw4xY0WSJC3BuR+tZqek1CU7p9MqUM
         eG6Bt75YVXlDUaF6OwqEcL9mAxPkwzEYnrE9XN136fo0Adj30uq+yrSMaT0LHPargRQi
         7Gtg==
X-Gm-Message-State: AG10YOQcP5L9heNjamPJmY122brx4+qc5BbNAo5u02v2XFfPpDkz4TaDzhW/PRVKQCC3mA==
X-Received: by 10.98.34.25 with SMTP id i25mr31128325pfi.26.1454801003886;
        Sat, 06 Feb 2016 15:23:23 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id f12sm33418885pfd.87.2016.02.06.15.23.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Feb 2016 15:23:22 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 07 Feb 2016 06:23:38 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <CA+4vN7w2=JWusWDhhGNzAkJbE-s44G4WoXdvf26yzvtYfpktfQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285706>

Noticed-by: Ole Tange <ole@tange.dk>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Sun, Feb 7, 2016 at 4:56 AM, Ole Tange <ole@tange.dk> wrote:
 > If file name too long it should just try to see if it is a reference
 > to a revision.

 Looks easy enough to fix.

 setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 2c4b22c..ab8f85d 100644
--- a/setup.c
+++ b/setup.c
@@ -147,7 +147,7 @@ int check_filename(const char *prefix, const char *=
arg)
 		name =3D arg;
 	if (!lstat(name, &st))
 		return 1; /* file exists */
-	if (errno =3D=3D ENOENT || errno =3D=3D ENOTDIR)
+	if (errno =3D=3D ENOENT || errno =3D=3D ENOTDIR || errno =3D=3D ENAME=
TOOLONG)
 		return 0; /* file does not exist */
 	die_errno("failed to stat '%s'", arg);
 }
--=20
2.7.0.377.g4cd97dd
