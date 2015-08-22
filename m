From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/5] enter_repo: avoid duplicating logic, use is_git_directory() instead
Date: Sat, 22 Aug 2015 07:39:59 +0700
Message-ID: <1440204002-7638-3-git-send-email-pclouds@gmail.com>
References: <20150715132552.GA28574@lanh>
 <1440204002-7638-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: bjornar@snoksrud.no,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 02:41:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSws1-0005O0-Fj
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 02:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662AbbHVAlM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 20:41:12 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:32921 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476AbbHVAlL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 20:41:11 -0400
Received: by pacgr6 with SMTP id gr6so4503421pac.0
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 17:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=TEzWwn3y+v2vYW9YaUbLIvI6tDpKwOzI+amgITp7K+E=;
        b=d2QTgkz9whlA3Lq6Rdgp3bKvfGPGuIJ92R4nK4i2uwZbDNHFBSFN2pjrGg++VLkzqU
         NnhC2h/eKSZhX4JGArNJ3wsepv1rI2zttiBHG+c9vityxsdv/xnWU6ehHMZBd2ntDyVK
         GBPMUVdtyL9ovdNtD2HOU3YcsMghktUzUyydMbP3hXxDDe31H3Y+PJTcosNEfuKsRwZf
         Z7hXvDcpDp9nLknOvScD2pac4sHvzsewi+LruMlvOAFrk66yPNrIxXQmlDaZyHHEq2/a
         qHjPATsPXhgCrdYVYwn+v1CHaEyiNWRwCj51eL9q5ySoL9SREkaD6TU9hwmlRxl8wb+H
         0K4w==
X-Received: by 10.66.222.161 with SMTP id qn1mr22887193pac.66.1440204071013;
        Fri, 21 Aug 2015 17:41:11 -0700 (PDT)
Received: from lanh ([171.232.84.126])
        by smtp.gmail.com with ESMTPSA id e6sm9127792pas.35.2015.08.21.17.41.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2015 17:41:10 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 22 Aug 2015 07:41:07 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1440204002-7638-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276347>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 path.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/path.c b/path.c
index a536ee3..7340e11 100644
--- a/path.c
+++ b/path.c
@@ -441,8 +441,7 @@ const char *enter_repo(const char *path, int strict=
)
 	else if (chdir(path))
 		return NULL;
=20
-	if (access("objects", X_OK) =3D=3D 0 && access("refs", X_OK) =3D=3D 0=
 &&
-	    validate_headref("HEAD") =3D=3D 0) {
+	if (is_git_directory(".")) {
 		set_git_dir(".");
 		check_repository_format();
 		return path;
--=20
2.3.0.rc1.137.g477eb31
