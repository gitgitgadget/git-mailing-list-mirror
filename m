From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/11] pack v4: add version argument to write_pack_header
Date: Sun,  8 Sep 2013 22:04:13 +0700
Message-ID: <1378652660-6731-5-git-send-email-pclouds@gmail.com>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378652660-6731-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Sep 08 17:01:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIgUo-0003F0-5u
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 17:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822Ab3IHPBr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Sep 2013 11:01:47 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:35449 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719Ab3IHPBq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 11:01:46 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc17so5124886pbc.32
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 08:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=uLI4ppxRmrHDpuqr2AKtylqc1obH39oNSwf0JBltk5s=;
        b=Jr1elzDJe2YvSohGRV1kWWfzwHrzTVN22+LEScHcyVFHodQ3YtZx7jEVYQXsCJu9R9
         lwyJ8o/3HhFtbmNsJ7Ld46IQtaVLARLCQUKq/gg0D2J5UdbaqdP8VlrKP9EFvotNNW3s
         R0dakSf/bNiJzLJ0e2/Mi9EmQxla3pFgdKc7dovyTjDCxp9YSl4EhqFw921JOXbtxycK
         uU7bALfm/v51e7MaPLHax6B5Wg0AGuqS5kylSjTMvinzU0qbRKaZv+7JiM/APuLwvEuV
         tBYXcUQ6djurCphR1YbpRfL/D985vc75XOoJaDcKoPR0Z7SZvpqNl4wzk4vKeYspbEBj
         Gzqw==
X-Received: by 10.66.27.143 with SMTP id t15mr1174587pag.171.1378652506343;
        Sun, 08 Sep 2013 08:01:46 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id fy4sm10495887pbb.1.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 08:01:45 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Sep 2013 22:04:55 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378652660-6731-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234243>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/pack-objects.c | 2 +-
 bulk-checkin.c         | 2 +-
 pack-write.c           | 7 +++++--
 pack.h                 | 3 +--
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f069462..33faea8 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -735,7 +735,7 @@ static void write_pack_file(void)
 		else
 			f =3D create_tmp_packfile(&pack_tmp_name);
=20
-		offset =3D write_pack_header(f, nr_remaining);
+		offset =3D write_pack_header(f, 2, nr_remaining);
 		if (!offset)
 			die_errno("unable to write pack header");
 		nr_written =3D 0;
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 6b0b6d4..9d8f0d0 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -176,7 +176,7 @@ static void prepare_to_stream(struct bulk_checkin_s=
tate *state,
 	reset_pack_idx_option(&state->pack_idx_opts);
=20
 	/* Pretend we are going to write only one object */
-	state->offset =3D write_pack_header(state->f, 1);
+	state->offset =3D write_pack_header(state->f, 2, 1);
 	if (!state->offset)
 		die_errno("unable to write pack header");
 }
diff --git a/pack-write.c b/pack-write.c
index 631007e..88e4788 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -186,12 +186,15 @@ const char *write_idx_file(const char *index_name=
, struct pack_idx_entry **objec
 	return index_name;
 }
=20
-off_t write_pack_header(struct sha1file *f, uint32_t nr_entries)
+off_t write_pack_header(struct sha1file *f,
+			int version, uint32_t nr_entries)
 {
 	struct pack_header hdr;
=20
 	hdr.hdr_signature =3D htonl(PACK_SIGNATURE);
-	hdr.hdr_version =3D htonl(PACK_VERSION);
+	hdr.hdr_version =3D htonl(version);
+	if (!pack_version_ok(hdr.hdr_version))
+		die(_("pack version %d is not supported"), version);
 	hdr.hdr_entries =3D htonl(nr_entries);
 	if (sha1write(f, &hdr, sizeof(hdr)))
 		return 0;
diff --git a/pack.h b/pack.h
index aa6ee7d..855f6c6 100644
--- a/pack.h
+++ b/pack.h
@@ -8,7 +8,6 @@
  * Packed object header
  */
 #define PACK_SIGNATURE 0x5041434b	/* "PACK" */
-#define PACK_VERSION 2
 #define pack_version_ok(v) ((v) =3D=3D htonl(2) || (v) =3D=3D htonl(3)=
)
 struct pack_header {
 	uint32_t hdr_signature;
@@ -80,7 +79,7 @@ extern const char *write_idx_file(const char *index_n=
ame, struct pack_idx_entry
 extern int check_pack_crc(struct packed_git *p, struct pack_window **w=
_curs, off_t offset, off_t len, unsigned int nr);
 extern int verify_pack_index(struct packed_git *);
 extern int verify_pack(struct packed_git *, verify_fn fn, struct progr=
ess *, uint32_t);
-extern off_t write_pack_header(struct sha1file *f, uint32_t);
+extern off_t write_pack_header(struct sha1file *f, int, uint32_t);
 extern void fixup_pack_header_footer(int, unsigned char *, const char =
*, uint32_t, unsigned char *, off_t);
 extern char *index_pack_lockfile(int fd);
 extern int encode_in_pack_object_header(enum object_type, uintmax_t, u=
nsigned char *);
--=20
1.8.2.83.gc99314b
