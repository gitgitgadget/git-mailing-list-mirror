From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/17] fixup! pack-objects: recognize v4 as pack source
Date: Sat, 21 Sep 2013 20:57:50 +0700
Message-ID: <1379771883-10278-5-git-send-email-pclouds@gmail.com>
References: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Sep 21 15:55:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNNeg-0000Pe-3X
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 15:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256Ab3IUNzH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Sep 2013 09:55:07 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:38918 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183Ab3IUNzF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 09:55:05 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj1so1824567pad.14
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 06:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=lItmPLew8ZusksnUuiZpZLzPd6KFkZ8BinvppuoQ/is=;
        b=bs2TtWMwWmYMcl4Twzgn5y5Y1y+NBp7TkuR9/HSsXKtcM555kcQMJIWzEWT5BVbnUC
         btUGZx7EdL76i7ozwrg9k+w5YZOFz/oZAatjRVOn7zT3ojgPeAmH0rZCMUNADSZbZ63A
         re2WldykIn5Bo2y/e8Rgf47SLyReWuXXWSeTcwewQOIiZSgaGVJo5KhxJFOw+hTT0aJn
         fT5gCMJwWoOfhpA+u0Z7Nt9+waRFar0Iidvpm7kCgOvkJmdyEq4toDOqAdIHpMTuktHV
         5KDvtJgEKnUzXVUqTXGhqBqzNhTTf1NKd8dWMvgUBM54bTa5p0bAC+FH8w6DMxKO2aQz
         KLIw==
X-Received: by 10.66.219.233 with SMTP id pr9mr14424234pac.45.1379771705302;
        Sat, 21 Sep 2013 06:55:05 -0700 (PDT)
Received: from lanh ([115.73.252.65])
        by mx.google.com with ESMTPSA id ct4sm22135440pbb.41.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 06:55:04 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 21 Sep 2013 20:58:28 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235106>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/pack-objects.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 30559e8..8e2e5e9 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1436,7 +1436,7 @@ static void check_object(struct object_entry *ent=
ry)
 				const unsigned char *sha1, *cp;
 				cp =3D buf + used;
 				sha1 =3D get_sha1ref(p, &cp);
-				entry->in_pack_header_size =3D cp - buf;;
+				entry->in_pack_header_size =3D cp - buf;
 				if (reuse_delta && !entry->preferred_base)
 					base_ref =3D sha1;
 				break;
@@ -1490,6 +1490,9 @@ static void check_object(struct object_entry *ent=
ry)
 			 * never consider reused delta as the base object to
 			 * deltify other objects against, in order to avoid
 			 * circular deltas.
+			 *
+			 * OBJ_TREE is kept in entry->type in v4 so we
+			 * know to when to write OBJ_PV4_TREE.
 			 */
 			if (pack_version < 4 || entry->type !=3D OBJ_TREE)
 				entry->type =3D entry->in_pack_type;
--=20
1.8.2.83.gc99314b
