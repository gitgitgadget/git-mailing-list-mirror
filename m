From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/12] connect.c: replace some use of starts_with() with skip_prefix()
Date: Wed, 18 Dec 2013 21:53:52 +0700
Message-ID: <1387378437-20646-8-git-send-email-pclouds@gmail.com>
References: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 18 15:54:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtIWS-0003nN-Kv
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 15:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755188Ab3LROys convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Dec 2013 09:54:48 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34402 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754693Ab3LROyr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 09:54:47 -0500
Received: by mail-pa0-f53.google.com with SMTP id hz1so6040270pad.40
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 06:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=iBAy06e8OHJBaEav6kxiSlhKwTC81RCPSmGQGTyIdsg=;
        b=Oqs19k4TQytmChgEeSamm2tTmpdbqnGyzDtA8bGVVm3nsVgIL4MOIfdtTZqjaGis8s
         O2CQ5ok2OGw+vkUITokeFhz01M4OnSSUJn9wBaj5VJgxK5mJNI2eahJ3VStL3aDKR7ze
         rqi30wqSdJcfewpmMNChVv0u9Mkw4PPpH+CmtThe66Uu+XkdcNMoukg9Xu8NaAptotaj
         upB4k5mzOxed9thNT/F1ZZpTLTYgAcAGZNahUwAZjlLqDmVx6maNs71WYUMvwPh2SOJJ
         +nKdxymm2wqNTYRYsBfcTAt0QNCpF9W9m3rC+ojwP211ycc2IXpShAtBlFSWNyMLhojv
         /e7w==
X-Received: by 10.68.91.3 with SMTP id ca3mr34327467pbb.20.1387378486996;
        Wed, 18 Dec 2013 06:54:46 -0800 (PST)
Received: from lanh ([115.73.220.136])
        by mx.google.com with ESMTPSA id q7sm550691pbc.20.2013.12.18.06.54.43
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Dec 2013 06:54:46 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 18 Dec 2013 21:54:43 +0700
X-Mailer: git-send-email 1.8.5.1.208.g019362e
In-Reply-To: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239445>

"name" will be reset unconditionally soon after skip_prefix() returns
NULL.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 connect.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/connect.c b/connect.c
index c763eed..1bb70aa 100644
--- a/connect.c
+++ b/connect.c
@@ -131,7 +131,7 @@ struct ref **get_remote_heads(int in, char *src_buf=
, size_t src_len,
 	for (;;) {
 		struct ref *ref;
 		unsigned char old_sha1[20];
-		char *name;
+		const char *name;
 		int len, name_len;
 		char *buffer =3D packet_buffer;
=20
@@ -145,8 +145,8 @@ struct ref **get_remote_heads(int in, char *src_buf=
, size_t src_len,
 		if (!len)
 			break;
=20
-		if (len > 4 && starts_with(buffer, "ERR "))
-			die("remote error: %s", buffer + 4);
+		if ((name =3D skip_prefix(buffer, "ERR ")) !=3D NULL)
+			die("remote error: %s", name);
=20
 		if (len < 42 || get_sha1_hex(buffer, old_sha1) || buffer[40] !=3D ' =
')
 			die("protocol error: expected sha/ref, got '%s'", buffer);
--=20
1.8.5.1.208.g019362e
