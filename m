From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/9] sha1_file: provide real packed type in object_info_extended
Date: Wed,  9 Oct 2013 21:46:08 +0700
Message-ID: <1381329976-32082-2-git-send-email-pclouds@gmail.com>
References: <1381329976-32082-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Oct 09 16:43:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTuyZ-000755-GU
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 16:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508Ab3JIOmy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Oct 2013 10:42:54 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:46662 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754338Ab3JIOmx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 10:42:53 -0400
Received: by mail-pd0-f169.google.com with SMTP id r10so1019443pdi.0
        for <git@vger.kernel.org>; Wed, 09 Oct 2013 07:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Lq2BUC9Mm1xYIEECGzZzEIv6f/SU9WughhTprgGAOII=;
        b=qtkXW1oSMwu/ZhxweWtYxfwQay5KGEtW9ExFnlijVV/EIUhDwrho4UoDlrs+fE1fPT
         CI37tkYebwf0CBDKpnPBSMJY0CQGdFA2QEazSHD4xF3V7Gc2iyMxL+QOmDO0IN34mgZE
         3XyA2AjkgykiMIjV/m6Cg7IaMm4caEfyIIc+YG9qg3XrZvhG2S5b0kZmHMXYCK8vssZT
         wuk56ppDdKX0iljskSuuo8wTNN/FwNc1DEjLBqDx3YxAEPUSyfkRqmkhKvJ+2lm/KL56
         YIqHzQIEhLHP10RxmQMrf4xksyw6YMkOuh70zk5yFs3bwiyn8CVCTK2BxDEFUyVqQxy8
         6B/A==
X-Received: by 10.66.235.106 with SMTP id ul10mr9773666pac.19.1381329772151;
        Wed, 09 Oct 2013 07:42:52 -0700 (PDT)
Received: from lanh ([115.73.225.201])
        by mx.google.com with ESMTPSA id dq3sm47034740pbc.35.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 09 Oct 2013 07:42:51 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 09 Oct 2013 21:46:31 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1381329976-32082-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235814>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h     | 2 +-
 sha1_file.c | 3 +--
 streaming.c | 9 ++++++++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 20c2d6d..5028ded 100644
--- a/cache.h
+++ b/cache.h
@@ -1168,7 +1168,7 @@ struct object_info {
 		struct {
 			struct packed_git *pack;
 			off_t offset;
-			unsigned int is_delta;
+			unsigned int real_type;
 		} packed;
 	} u;
 };
diff --git a/sha1_file.c b/sha1_file.c
index ef6ecc8..5848008 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2557,8 +2557,7 @@ int sha1_object_info_extended(const unsigned char=
 *sha1, struct object_info *oi)
 		oi->whence =3D OI_PACKED;
 		oi->u.packed.offset =3D e.offset;
 		oi->u.packed.pack =3D e.p;
-		oi->u.packed.is_delta =3D (rtype =3D=3D OBJ_REF_DELTA ||
-					 rtype =3D=3D OBJ_OFS_DELTA);
+		oi->u.packed.real_type =3D rtype;
 	}
=20
 	return 0;
diff --git a/streaming.c b/streaming.c
index c7edebb..2cc4c03 100644
--- a/streaming.c
+++ b/streaming.c
@@ -104,6 +104,12 @@ ssize_t read_istream(struct git_istream *st, void =
*buf, size_t sz)
 	return st->vtbl->read(st, buf, sz);
 }
=20
+static int is_canonical(int type)
+{
+	return type !=3D OBJ_COMMIT && type !=3D OBJ_TREE &&
+		type !=3D OBJ_BLOB && type !=3D OBJ_TAG;
+}
+
 static enum input_source istream_source(const unsigned char *sha1,
 					enum object_type *type,
 					struct object_info *oi)
@@ -121,7 +127,8 @@ static enum input_source istream_source(const unsig=
ned char *sha1,
 	case OI_LOOSE:
 		return loose;
 	case OI_PACKED:
-		if (!oi->u.packed.is_delta && big_file_threshold < size)
+		if (is_canonical(oi->u.packed.real_type) &&
+		    big_file_threshold < size)
 			return pack_non_delta;
 		/* fallthru */
 	default:
--=20
1.8.2.83.gc99314b
