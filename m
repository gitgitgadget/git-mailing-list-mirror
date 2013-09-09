From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 05/16] pack_write: tighten valid object type check in encode_in_pack_object_header
Date: Mon,  9 Sep 2013 20:57:56 +0700
Message-ID: <1378735087-4813-6-git-send-email-pclouds@gmail.com>
References: <1378652660-6731-1-git-send-email-pclouds@gmail.com>
 <1378735087-4813-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Sep 09 15:55:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ1wU-0002kL-DU
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 15:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753415Ab3IINzo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Sep 2013 09:55:44 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:40147 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364Ab3IINzl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 09:55:41 -0400
Received: by mail-pd0-f171.google.com with SMTP id g10so6208694pdj.16
        for <git@vger.kernel.org>; Mon, 09 Sep 2013 06:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=fjeN9RgNcOK9TyIREi8NlP1+EYZ3MF4Ge0ssDqhlXRw=;
        b=SAam+hdgNV8uAsEhUr0u0XagKXrhS+SWQbgxtCNxmTgY7o15F9DFiyt1njZ4s3/3ow
         6svaqgmvYKD6agaLvuiDKeaDw8tSRggqm3PXqOB3abd0JiOdfDYzkBO/326ZerM48qME
         STn353vI48F9SYrTatsd+oF2piGFhJbz0aDNwmMmKKRuCL2e+vLA+Vw6iI+TRmXtgkA0
         5veYDMJ5tCZ1dn3GPrz4vQKopRz7XoBERcnrqKjv1GzsTkzIq3ITQr8DD/djmCDeSsjp
         E8+xMjcr30HTCnjYFjNiHnJbRwtRK/Wg+H3qqI5LrUgTBBqKNJFvGo6L4Ts1pkDNQv5D
         BOQA==
X-Received: by 10.68.164.161 with SMTP id yr1mr7543907pbb.40.1378734941212;
        Mon, 09 Sep 2013 06:55:41 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id qa9sm16452618pbc.7.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 09 Sep 2013 06:55:40 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 09 Sep 2013 20:58:50 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378735087-4813-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234332>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 pack-write.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/pack-write.c b/pack-write.c
index 88e4788..36b88a3 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -325,8 +325,17 @@ int encode_in_pack_object_header(enum object_type =
type, uintmax_t size, unsigned
 	int n =3D 1;
 	unsigned char c;
=20
-	if (type < OBJ_COMMIT || type > OBJ_REF_DELTA)
+	switch (type) {
+	case OBJ_COMMIT:
+	case OBJ_TREE:
+	case OBJ_BLOB:
+	case OBJ_TAG:
+	case OBJ_OFS_DELTA:
+	case OBJ_REF_DELTA:
+		break;
+	default:
 		die("bad type %d", type);
+	}
=20
 	c =3D (type << 4) | (size & 15);
 	size >>=3D 4;
--=20
1.8.2.83.gc99314b
