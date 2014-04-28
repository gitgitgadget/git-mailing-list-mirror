From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/32] ewah: fix constness of ewah_read_mmap
Date: Mon, 28 Apr 2014 17:55:22 +0700
Message-ID: <1398682553-11634-2-git-send-email-pclouds@gmail.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 12:55:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WejD5-0000ox-Dw
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 12:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755268AbaD1Kyt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 06:54:49 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:42636 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755140AbaD1Kyi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 06:54:38 -0400
Received: by mail-pb0-f54.google.com with SMTP id rp16so2287122pbb.27
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 03:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=gBL4GdJHn2XylZQigZBjOotoY63SQYD5XGoJg2X0NcU=;
        b=iW5711xV0XWBv0JLbjJv1LEo2GZ8Vbk8noAvTzKsAwEoTq7O7pPpHln1k4hqjtb7gr
         h9Ye7iYwQwE53VI8juq0b2hUo2V0AAxU86cfo7v4ISzqVETcha0qKMlbvFbzWHTNwK6D
         rs28Eyxcn+wZbnLLhEZtPCvbjipFKCc3NPdTsyrpDJfhot9u8F12E1CiD2qWkm58Fxrh
         6LCt/IJo2QXaM+KXE2vjfcmanEG2LJH793G8gpfWRm5AT7Qh2Pd2/6AsTMytYzOfFywS
         tQcHfZz8cCNJTdHuWl4aO0FxDC3VYZaL0380EV57qERe7WSC9dhtDzmTWsiSaKzE7DFu
         f1VA==
X-Received: by 10.66.219.68 with SMTP id pm4mr24689649pac.21.1398682478241;
        Mon, 28 Apr 2014 03:54:38 -0700 (PDT)
Received: from lanh ([115.73.231.31])
        by mx.google.com with ESMTPSA id qc8sm34165021pbc.68.2014.04.28.03.54.35
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 03:54:37 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Apr 2014 17:56:06 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247269>

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
