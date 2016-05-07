From: tboegi@web.de
Subject: [PATCH v9 1/6] read-cache: factor out get_sha1_from_index() helper
Date: Sat,  7 May 2016 08:10:58 +0200
Message-ID: <1462601458-23498-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 08:06:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayvNX-0003Rf-Pg
	for gcvg-git-2@plane.gmane.org; Sat, 07 May 2016 08:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbcEGGGI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 May 2016 02:06:08 -0400
Received: from mout.web.de ([212.227.17.12]:51705 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750856AbcEGGGE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2016 02:06:04 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0LvBMs-1bhRG40zf0-010P55; Sat, 07 May 2016 08:06:02
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:bSppHw9SCS61HaMjZqOAe+LWMb4MOmCrmv5MQ7xYv30mYsSpZRl
 wOXpCJqQvI/KsDLvhZLBke315HgLbgxaJkR+zzV6zkpXRkKdmJ61ydGaG3Y41/kIKDoqk8t
 KR2lFWY7wnqrWfHbvxeYIGEe7rGhBh8xbKhCvzwz5/Q2t7a576fXpN1dhZsZ/znpTapN6jX
 izWBO1kgnn5SvMrW1eI6Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yvZwlWjQazg=:HbcLZPDKGY7zXMJFpgvyaD
 YYH+9w7PYUYoybisaic6zYgnMMihTL+AO6egLJKJWgonI19xJgHLTW+R4B3QtVjOIKdW+GmTR
 NgzLQzrOIVa4/rTTzzYnrT9LeUcmSjdZtoyDUjY6vb6Pl8MkPhk4JpjiOp2Bgi1XAzLgNiR1k
 BhWepd2zGI0iGZ4gXlPP5HUk4cL2/PjMz9haswVsZDGbIBQwuzQDi2JNS+k0jCkbSd+xee4Xk
 PkW/1p+jtPW8pJWMeqrjQApKR8mU9AeTlaz64jQoEtTMzJKM/gJiACSplETMuJPCwtnWfe/Zu
 TZMRdgpq25bmbJpM1nCDjOAMsRSyOw9gDNCQGdDq7xG+PE5SlHlJTkq2icr1TVUFg2Xw5Oa18
 s7va/QTZZR3vzTaUMabkxY+lVT2uQyIMhDYoRnIRSPx9fr3nRPGA4wcK66NvrjQpNPH0rIw8n
 ze3OK0DCEgCqPqy1Wgns1Jl6U88e2gMnCYSAPHzlAEWthdNMfA9CNfj1KDVkV6v2zXVgE0cdG
 B2hV2StNm5viadAacoJ591pTpb2UIXjEWbRXKHjP4xXuMWPs4w9F1y7kYDUMd7vHOP5g4CXuC
 gr3BLsQYZxobFMbQr0lOoAYnMVQMgTMRHhAcwi3iENasTHlHSwcXrJtSl+TSRkhiIdPBE6Ok+
 SyLVV71zNZ49j7J3m4ys91l8QJiPgl90dLueBO8zEUKu9iiNGPNwxBUT6EHf95kZGHaqQsbJ8
 D17/U6xJo0LvmO02Z+ICR/p1Ts5Kp04Qf6znSYkDs1x0XCG/BVWOSvwwqVoCwXsAO6qizWfw 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293876>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

=46actor out the retrieval of the sha1 for a given path in
read_blob_data_from_index() into the function get_sha1_from_index().

This will be used in the next commit, when convert.c can do the
analyze for "text=3Dauto" without slurping the whole blob into memory
at once.

Add a wrapper definition get_sha1_from_cache().

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 cache.h      |  3 +++
 read-cache.c | 29 ++++++++++++++++++-----------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/cache.h b/cache.h
index 1c60918..28f23d7 100644
--- a/cache.h
+++ b/cache.h
@@ -379,6 +379,7 @@ extern void free_name_hash(struct index_state *ista=
te);
 #define unmerge_cache_entry_at(at) unmerge_index_entry_at(&the_index, =
at)
 #define unmerge_cache(pathspec) unmerge_index(&the_index, pathspec)
 #define read_blob_data_from_cache(path, sz) read_blob_data_from_index(=
&the_index, (path), (sz))
+#define get_sha1_from_cache(path)  get_sha1_from_index (&the_index, (p=
ath))
 #endif
=20
 enum object_type {
@@ -1019,6 +1020,8 @@ static inline void *read_sha1_file(const unsigned=
 char *sha1, enum object_type *
 	return read_sha1_file_extended(sha1, type, size, LOOKUP_REPLACE_OBJEC=
T);
 }
=20
+const unsigned char *get_sha1_from_index(struct index_state *istate, c=
onst char *path);
+
 /*
  * This internal function is only declared here for the benefit of
  * lookup_replace_object().  Please do not call it directly.
diff --git a/read-cache.c b/read-cache.c
index d9fb78b..a3ef967 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2263,13 +2263,27 @@ int index_name_is_other(const struct index_stat=
e *istate, const char *name,
=20
 void *read_blob_data_from_index(struct index_state *istate, const char=
 *path, unsigned long *size)
 {
-	int pos, len;
+	const unsigned char *sha1;
 	unsigned long sz;
 	enum object_type type;
 	void *data;
=20
-	len =3D strlen(path);
-	pos =3D index_name_pos(istate, path, len);
+	sha1 =3D get_sha1_from_index(istate, path);
+	if (!sha1)
+		return NULL;
+	data =3D read_sha1_file(sha1, &type, &sz);
+	if (!data || type !=3D OBJ_BLOB) {
+		free(data);
+		return NULL;
+	}
+	if (size)
+		*size =3D sz;
+	return data;
+}
+
+const unsigned char *get_sha1_from_index(struct index_state *istate, c=
onst char *path)
+{
+	int pos =3D index_name_pos(istate, path, strlen(path));
 	if (pos < 0) {
 		/*
 		 * We might be in the middle of a merge, in which
@@ -2285,14 +2299,7 @@ void *read_blob_data_from_index(struct index_sta=
te *istate, const char *path, un
 	}
 	if (pos < 0)
 		return NULL;
-	data =3D read_sha1_file(istate->cache[pos]->sha1, &type, &sz);
-	if (!data || type !=3D OBJ_BLOB) {
-		free(data);
-		return NULL;
-	}
-	if (size)
-		*size =3D sz;
-	return data;
+	return (istate->cache[pos]->sha1);
 }
=20
 void stat_validity_clear(struct stat_validity *sv)
--=20
2.0.0.rc1.6318.g0c2c796
