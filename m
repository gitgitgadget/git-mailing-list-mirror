From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/17] fixup! packv4-parse.c: add tree offset caching
Date: Sat, 21 Sep 2013 20:57:48 +0700
Message-ID: <1379771883-10278-3-git-send-email-pclouds@gmail.com>
References: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Sep 21 15:55:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNNeI-00083I-7W
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 15:55:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137Ab3IUNy4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Sep 2013 09:54:56 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:45470 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929Ab3IUNyy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 09:54:54 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so1466019pdj.8
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 06:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=XiuG5TYChHz7Jgkj2IeF6B6tYL8DXUSPpbj4VMlqRkE=;
        b=Q9P5Px7vvj1mfKNmzI68Y5hbcNB5gShHjkWiwtLyuWXeN7Er20hzeuzVSNvnGOKsln
         LioXFY5nNxOtERVwRXzIFEoyucsAC1tmqz1DXhjFaNq1/8IeVLIIqSKCv7aqtNjtLu6c
         jHq/P5hK71BxQ6DBDkWkJIRgmneI2tRhhAOdXJ5iI6ec7BKJAWsORXGSkK+ireZVNLPf
         I4MCVwibEzzUSvTE2nOrxZLOfoCUrbJmSgy/+ez25hVWqGTOmBURwf4o9qjJVIQniEAh
         Z0UHy1qOlUgJbWNlvvy6AAXgezYKsjiQXb1qI2I8L+LNRoy2jyRdY1XdsDVnfAIEGvSc
         yTjA==
X-Received: by 10.68.25.170 with SMTP id d10mr13864718pbg.78.1379771693932;
        Sat, 21 Sep 2013 06:54:53 -0700 (PDT)
Received: from lanh ([115.73.252.65])
        by mx.google.com with ESMTPSA id xe9sm25724462pab.0.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 06:54:53 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 21 Sep 2013 20:58:16 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235102>

we need to pass an offset pointing to the header because
unpack_entry() needs that..

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 packv4-parse.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/packv4-parse.c b/packv4-parse.c
index 6abd62e..e833cd2 100644
--- a/packv4-parse.c
+++ b/packv4-parse.c
@@ -470,8 +470,7 @@ static int decode_entries(struct packed_git *p, str=
uct pack_window **w_curs,
=20
 		/* is this a canonical tree object? */
 		if ((*scp & 0xf) =3D=3D OBJ_TREE) {
-			offset =3D obj_offset + (scp - src);
-			return copy_canonical_tree_entries(p, offset,
+			return copy_canonical_tree_entries(p, obj_offset,
 							   start, count,
 							   dstp, sizep);
 		}
@@ -647,7 +646,7 @@ static int decode_entries(struct packed_git *p, str=
uct pack_window **w_curs,
 		c->offset =3D offset;
 		c->last_copy_base =3D copy_objoffset;
 	}
-					=09
+
 	return 0;
 }
=20
--=20
1.8.2.83.gc99314b
