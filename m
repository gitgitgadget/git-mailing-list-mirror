From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 09/28] fast-import: use git_path() for accessing .git dir instead of get_git_dir()
Date: Sat,  8 Mar 2014 09:48:01 +0700
Message-ID: <1394246900-31535-10-git-send-email-pclouds@gmail.com>
References: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
 <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 03:49:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM7Js-000599-FH
	for gcvg-git-2@plane.gmane.org; Sat, 08 Mar 2014 03:49:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314AbaCHCsz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2014 21:48:55 -0500
Received: from mail-pb0-f54.google.com ([209.85.160.54]:49213 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305AbaCHCsw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 21:48:52 -0500
Received: by mail-pb0-f54.google.com with SMTP id ma3so4972133pbc.13
        for <git@vger.kernel.org>; Fri, 07 Mar 2014 18:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=e95zV1teH6E7O0ISmuYj7a56EXGzSBmXPZ+fKicGfB4=;
        b=QtzkZKaAlPPl0GWXDXMkTui8k8FlLXNvAsQe9ttqTnP3IUhpIZj4e6umEYrP+bvrok
         F57uG9O0Z6/qqpHsF7vrzLgzOL2o9nRyutx9sEo4Zkzm2hhZHuqAYvqgnAKPKtjISG5B
         e2eeTYctuIKWqsKPciVIfKQvUx4Yv94o+ubLuJx/d49QNMf2dVOJWSZvb/ydMHEDJ28J
         IEYMY+Mp5pjMYZiNJIFLOsJGguzHAiFYsxfeOkOfZGfknzQSnogBJCLX/LINEY+v9IQ9
         uPznh+2L8jp5muW8MjR+w5XiTPFMuke+hqGsnBV55iyO2jnX8m0pe/DSiRgyWYIliagt
         X/LQ==
X-Received: by 10.68.12.74 with SMTP id w10mr26306967pbb.39.1394246930735;
        Fri, 07 Mar 2014 18:48:50 -0800 (PST)
Received: from lanh ([115.73.205.153])
        by mx.google.com with ESMTPSA id bc4sm41579551pbb.2.2014.03.07.18.48.47
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 07 Mar 2014 18:48:49 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Mar 2014 09:49:23 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243650>

This allows git_path() to redirect info/fast-import to another place
if needed

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 fast-import.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index a9f328d..28e7a63 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3125,12 +3125,9 @@ static void parse_progress(void)
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
1.9.0.40.gaa8c3ea
