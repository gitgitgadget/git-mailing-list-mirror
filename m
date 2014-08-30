From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/32] fast-import: use git_path() for accessing .git dir instead of get_git_dir()
Date: Sat, 30 Aug 2014 15:33:39 +0700
Message-ID: <1409387642-24492-10-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 10:34:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNe7U-0001hb-FZ
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 10:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbaH3Iep convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2014 04:34:45 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:61246 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbaH3Ieo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 04:34:44 -0400
Received: by mail-pd0-f169.google.com with SMTP id g10so2074096pdj.0
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 01:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=RExKQLWiE7oFXqwo6kBLTU76R9VguhtxvOGMVg7kWlY=;
        b=qY4DhDXNGWST4DlwqzwpoqR5nE2M7mDKZwGnI2a7OdoD4llxGmi1glzIL60J9mxGIr
         sVPsSfQ4sRMOhjHld4f5s3zGT6zWV55wd2REFdySsRTVIXMKAO/UqeZuegot8R7jT7US
         PQTgoECyqRo5NZue84yjYcQ/aXYtM/dY2QukL9Yw0HlUcdXI6sI9dU1mx4LgQ1tpH+cx
         be6FrYHRjsjoP3xV1UWjAFJDdTBWdsvXUR4ZMWjAymsTaEua5lTmt7JjerqN3Y3gYGSR
         bCwTGJkREU+fI89vOywV+i6vWJBT1Gw9lSyyT3rxO79kndo45AnLqzrc10fmk/bjem4C
         Mm9Q==
X-Received: by 10.66.193.37 with SMTP id hl5mr22093372pac.135.1409387684226;
        Sat, 30 Aug 2014 01:34:44 -0700 (PDT)
Received: from lanh ([115.73.195.142])
        by mx.google.com with ESMTPSA id to4sm2103446pbc.39.2014.08.30.01.34.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Aug 2014 01:34:43 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 30 Aug 2014 15:34:53 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256219>

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
