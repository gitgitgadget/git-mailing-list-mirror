From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 2/5] enter_repo: avoid duplicating logic, use is_git_directory() instead
Date: Sun, 13 Sep 2015 08:02:25 +0700
Message-ID: <1442106148-22895-3-git-send-email-pclouds@gmail.com>
References: <1440204002-7638-1-git-send-email-pclouds@gmail.com>
 <1442106148-22895-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, bjornar@snoksrud.no,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 03:02:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zavgj-0006lM-LP
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 03:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755025AbbIMBC2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Sep 2015 21:02:28 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35234 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754920AbbIMBCV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2015 21:02:21 -0400
Received: by pacfv12 with SMTP id fv12so110679323pac.2
        for <git@vger.kernel.org>; Sat, 12 Sep 2015 18:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=TEzWwn3y+v2vYW9YaUbLIvI6tDpKwOzI+amgITp7K+E=;
        b=yUKMQwnugyXVbsPIBIPai4xo7dKkAHujzP8Q5gSwMyr+zggbp+x5zaJ3l8Z3pmTJIY
         DnVkS3LwPmhiI+YbdECjJkf/HTSkltu9uTa8Zhgd1o41PeWnb6xXaufZds3x45T3TUZg
         RBqXvYOC01ygWW+zWC8sV+8/sNbcPmQGrzKZb0W+FhZnth0ZcrOl3wxxI67XytoU5vlz
         Ozpjt4VYorJ5cex9AX6WPbHV0fFatj+IcRzjjfENHZzfxjrtFhBieGH1BF/57XwTAfIa
         OxxrTgYSNyS3KT44jr2t2c1HlpnyRXCdbCzN8tR3efH5mglLZc0QR54saYXKpibod6ET
         pKCQ==
X-Received: by 10.69.27.37 with SMTP id jd5mr16156689pbd.76.1442106141039;
        Sat, 12 Sep 2015 18:02:21 -0700 (PDT)
Received: from lanh ([171.233.230.25])
        by smtp.gmail.com with ESMTPSA id fu4sm7955380pbb.59.2015.09.12.18.02.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Sep 2015 18:02:20 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Sep 2015 08:02:40 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1442106148-22895-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277745>

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
