From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/32] ewah: fix constness of ewah_read_mmap
Date: Fri, 13 Jun 2014 19:19:20 +0700
Message-ID: <1402661991-14977-2-git-send-email-pclouds@gmail.com>
References: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 14:20:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvQSz-0002O2-Ao
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 14:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbaFMMUN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 08:20:13 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:48255 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbaFMMUL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 08:20:11 -0400
Received: by mail-pd0-f171.google.com with SMTP id ft15so2090167pdb.30
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 05:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=gBL4GdJHn2XylZQigZBjOotoY63SQYD5XGoJg2X0NcU=;
        b=uW+LtANzy+qK8qwC6JPD5CslyBnxMjbQof/WUd9RvFYrHq+VJqDLkXjBMrUqKc5IF/
         Fcf5siaw5X81ZrHnBx2+1YUn2v/HA1bq6L2Z+7ke2T828NuBA1bEMzyoQ8//P1gzoZ8i
         0XfNfeqwMU3sPkWYL0vYWNqIR4Sy9cY0J+QR7ZmpgQmCqTaipG1klu4YK+vOnMO/FLr4
         lqeSBPRihjn7XOc2C7ZMUtIgsnCznNeh7APxUPUdJdy6lo4ytYah/eS+gRSuF/1Ob+L6
         zQZflg2D2QyFFEPzb1xf52ZUTEquDcHxEwsq7zS8uHnGWK66O/j2gR3Zi+xxURDQNYjn
         ifnw==
X-Received: by 10.68.226.197 with SMTP id ru5mr2856474pbc.77.1402662011344;
        Fri, 13 Jun 2014 05:20:11 -0700 (PDT)
Received: from lanh ([115.73.228.145])
        by mx.google.com with ESMTPSA id ek2sm3394751pbd.30.2014.06.13.05.20.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jun 2014 05:20:10 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 13 Jun 2014 19:20:11 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251557>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 ewah/ewah_io.c | 4 ++--
 ewah/ewok.h    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/ewah/ewah_io.c b/ewah/ewah_io.c
index f7f700e..1c2d7af 100644
--- a/ewah/ewah_io.c
+++ b/ewah/ewah_io.c
@@ -110,9 +110,9 @@ int ewah_serialize(struct ewah_bitmap *self, int fd=
)
 	return ewah_serialize_to(self, write_helper, (void *)(intptr_t)fd);
 }
=20
-int ewah_read_mmap(struct ewah_bitmap *self, void *map, size_t len)
+int ewah_read_mmap(struct ewah_bitmap *self, const void *map, size_t l=
en)
 {
-	uint8_t *ptr =3D map;
+	const uint8_t *ptr =3D map;
 	size_t i;
=20
 	self->bit_size =3D get_be32(ptr);
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 43adeb5..0556ca5 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -99,7 +99,7 @@ int ewah_serialize(struct ewah_bitmap *self, int fd);
 int ewah_serialize_native(struct ewah_bitmap *self, int fd);
=20
 int ewah_deserialize(struct ewah_bitmap *self, int fd);
-int ewah_read_mmap(struct ewah_bitmap *self, void *map, size_t len);
+int ewah_read_mmap(struct ewah_bitmap *self, const void *map, size_t l=
en);
 int ewah_read_mmap_native(struct ewah_bitmap *self, void *map, size_t =
len);
=20
 uint32_t ewah_checksum(struct ewah_bitmap *self);
--=20
1.9.1.346.ga2b5940
