From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 09/32] fast-import: use git_path() for accessing .git dir instead of get_git_dir()
Date: Thu, 11 Sep 2014 05:41:45 +0700
Message-ID: <1410388928-32265-10-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
 <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 00:42:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRqbI-0001Uc-Pw
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 00:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126AbaIJWmx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Sep 2014 18:42:53 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33674 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063AbaIJWmw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 18:42:52 -0400
Received: by mail-pd0-f179.google.com with SMTP id g10so13144466pdj.38
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 15:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=RExKQLWiE7oFXqwo6kBLTU76R9VguhtxvOGMVg7kWlY=;
        b=Fe8P4uN4lghvgQty8jIMpx2l0sxLn/ZwW8E3dAbIMZiRXkKYcDyab4oAt/hkt+lO7/
         3Ct7DROijK7+uTUmg5USxDtLt++36ICSCrCEQN53qMPvr9pOexLXA/Zikj/vUBYfeaHY
         yXAa6MC3UDE0rjOivJfyphS5wcCHjI8M1/kApcWHnz689PPkj0ldJbgDuLWB4OtZQr8E
         BXh5Ko0S0BVFgh1noUfy0uE17FkWA9r7VIDRKT56ff47SVksONpaFTr9DnS2TU43yBVb
         F7CNMMxIZLazpsvMUv97LZcGz4WRYOcbBqgbiQPLSkrzX4Tz74MOEls/Z2jNc67HJ+3z
         MnSA==
X-Received: by 10.70.19.166 with SMTP id g6mr69765114pde.99.1410388971451;
        Wed, 10 Sep 2014 15:42:51 -0700 (PDT)
Received: from lanh ([115.73.197.210])
        by mx.google.com with ESMTPSA id hp1sm15415203pbb.77.2014.09.10.15.42.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Sep 2014 15:42:50 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 11 Sep 2014 05:43:11 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256786>

This allows git_path() to redirect info/fast-import to another place
if needed

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 fast-import.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index d9c068b..ea426c4 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3103,12 +3103,9 @@ static void parse_progress(void)
=20
 static char* make_fast_import_path(const char *path)
 {
-	struct strbuf abs_path =3D STRBUF_INIT;
-
 	if (!relative_marks_paths || is_absolute_path(path))
 		return xstrdup(path);
-	strbuf_addf(&abs_path, "%s/info/fast-import/%s", get_git_dir(), path)=
;
-	return strbuf_detach(&abs_path, NULL);
+	return xstrdup(git_path("info/fast-import/%s", path));
 }
=20
 static void option_import_marks(const char *marks,
--=20
2.1.0.rc0.78.gc0d8480
