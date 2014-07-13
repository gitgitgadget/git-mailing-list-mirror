From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 09/31] fast-import: use git_path() for accessing .git dir instead of get_git_dir()
Date: Sun, 13 Jul 2014 11:50:46 +0700
Message-ID: <1405227068-25506-10-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
 <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 13 06:54:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6BnU-0008Cy-15
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 06:54:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638AbaGMEx4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jul 2014 00:53:56 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:57194 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633AbaGMExz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 00:53:55 -0400
Received: by mail-pd0-f178.google.com with SMTP id r10so3517004pdi.9
        for <git@vger.kernel.org>; Sat, 12 Jul 2014 21:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=58m7rrTSRcB9PZVEtbz+P7B++cT4jWXTEZD/onMCVpo=;
        b=Ll4BKsqX34A4YiuCwlhsyaayipa81JDODEU1ueIWR4OuNpfYRLcHI0IVUgbWvT4nnE
         rYSBeRlyvaNMvrjtQvGacMfBn623RJsHCSfW4NZa0LkxYUzQzh3U/usi3KTAABNKUtxE
         0+3nb11mqbGM7gMLNte1XiDmjDyBrHJQcFA1ZH7C1myDKbG9Wy41r/Rv5ekmz7uW4Gik
         y2/IHQTTUEbXUuBjyeSuZOVRUcHoLFl8ece0bno0Ib3u7SomQ2EepMmz+uRldaMJ6mJO
         DJv2wFNxacTMBMtWTmp04L718D5petqFx8ogDSWDNtmFzCXIvIg2NtfGuHSBN9oLMPb/
         rOxw==
X-Received: by 10.70.48.205 with SMTP id o13mr8825935pdn.25.1405227234598;
        Sat, 12 Jul 2014 21:53:54 -0700 (PDT)
Received: from lanh ([115.73.227.1])
        by mx.google.com with ESMTPSA id q6sm816857pdp.5.2014.07.12.21.53.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jul 2014 21:53:53 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jul 2014 11:53:54 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253412>

This allows git_path() to redirect info/fast-import to another place
if needed

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
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
1.9.1.346.ga2b5940
