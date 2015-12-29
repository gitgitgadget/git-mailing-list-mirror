From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/20] upload-pack: remove unused variable "backup"
Date: Tue, 29 Dec 2015 19:10:26 +0700
Message-ID: <1451391043-28093-4-git-send-email-pclouds@gmail.com>
References: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 13:11:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDt7Y-0006A2-KD
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 13:11:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286AbbL2MLQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Dec 2015 07:11:16 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35714 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248AbbL2MLO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 07:11:14 -0500
Received: by mail-pa0-f48.google.com with SMTP id do7so4705333pab.2
        for <git@vger.kernel.org>; Tue, 29 Dec 2015 04:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=cNV+Q8e5wMY1wkanxPCJ1hDp7T2UzT3VJsKqFsoFi7I=;
        b=fvf26Bi/bWxHSUMq5UUABUb7p2hCZaaTGWBCL/adtv45GqGr2Cd1EtCaFvS6khA2Iv
         MzBZjzB1I1XyVFDo8eOQqv/lTOKcVv2fkUH8fPz1/wKAS9JvQXeLSW0IzAUD2QgTHWcm
         98+wxoWGa8f6hADslkg4NtDek052RkFTy4OiaKHml+OV5og9BvtTLv2eDd9rABWp8pp4
         7+DgehpLsCN1XWbRTBzyfvAeHI2d6Vkrg+jeuU7Icb8qGNlw1gfn1ZmLfSXHAxRM5NTX
         HYNdbgaLxzzOEPuPQX3OyWZ5tdjSx/EwIS3CqHBercCUkgMV7fnjBvGzVyHruQKD+BSl
         a5FA==
X-Received: by 10.66.55.6 with SMTP id n6mr85427216pap.33.1451391074524;
        Tue, 29 Dec 2015 04:11:14 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id ah10sm87893089pad.23.2015.12.29.04.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Dec 2015 04:11:13 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 29 Dec 2015 19:11:09 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283114>

After the last patch, "result" and "backup" are the same. "result" used
to move, but the movement is now contained in send_shallow(). Delete
this redundant variable.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 0eb9a0b..4774f78 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -554,7 +554,7 @@ static void send_shallow(struct commit_list *result=
)
=20
 static void deepen(int depth, const struct object_array *shallows)
 {
-	struct commit_list *result =3D NULL, *backup =3D NULL;
+	struct commit_list *result =3D NULL;
 	int i;
 	if (depth =3D=3D INFINITE_DEPTH && !is_repository_shallow())
 		for (i =3D 0; i < shallows->nr; i++) {
@@ -562,11 +562,11 @@ static void deepen(int depth, const struct object=
_array *shallows)
 			object->flags |=3D NOT_SHALLOW;
 		}
 	else
-		backup =3D result =3D
+		result =3D
 			get_shallow_commits(&want_obj, depth,
 					    SHALLOW, NOT_SHALLOW);
 	send_shallow(result);
-	free_commit_list(backup);
+	free_commit_list(result);
 	for (i =3D 0; i < shallows->nr; i++) {
 		struct object *object =3D shallows->objects[i].item;
 		if (object->flags & NOT_SHALLOW) {
--=20
2.3.0.rc1.137.g477eb31
