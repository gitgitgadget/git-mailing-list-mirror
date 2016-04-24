From: tboegi@web.de
Subject: [PATCH v6b 05/10] read-cache: factor out get_sha1_from_index() helper
Date: Sun, 24 Apr 2016 17:11:24 +0200
Message-ID: <1461510684-21044-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 17:07:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auLd6-000605-3w
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 17:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801AbcDXPHU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Apr 2016 11:07:20 -0400
Received: from mout.web.de ([212.227.15.14]:60543 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752659AbcDXPHL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 11:07:11 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0Lhedd-1bY4691LI9-00mpzp; Sun, 24 Apr 2016 17:07:08
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:Diw3cth9z0Sv+QhsrRJIyrwZ1lvAqu71VRCetiUy57kZqrbLS5j
 rUm24n9o+IQW0nXuixe6S/eLXyGdzvU1QT/Im/2OZA6Jcmf/rWErIoSN8R7uQo3bMp4ck7h
 eYMrJjkykWLRXFcmigujN1vEBQgj/cTuLZJZC5AJBbmE6zpwEpG4SDpH8x1I6luC8qBQPvO
 vJfRSXWgd6hDnkzJDberQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aWCU7LwnvZU=:7pRxuhy5AUOmVuaUOO2cXV
 BYCJ8YM0rN1oFFUGJpHyyais6FuMp9aDUhEVnAMSRWEMbCOxxEZNgOwQ761sPL8zczA2Q5aKT
 Q6G5rFOrLVrl3EBlOaPJwrMcbhOl817ZMJVZn2DL7IrApxMPi+d6QYpJtjvOpA+1GOHt6oTxd
 36DL9DXDPZDI5vIOGQkHB1izVMD9AVlswt0SWDdIybzrgTe2FJomAAb8ZGuhZIRCiAt0BhAjV
 U4vDSHSjvx3nO2hFJrMWahhZ60AP0MNRab44vhJfJxK9TXv8m/mWGAXK8Nne88gpQpGFrBDzg
 ZBTkLfIzJ9WsMqmwAwpVIt4WiFUlwVQ4/FLd7wlUwlJWozCQTxkP1EGVg/zstYw//ViVfjK7j
 fTUf+ZrtsAgTJPPzr5zdexg62ZDBBeh1KbvzaUrg43fJL2PYqz6Gon1LbJN86VrDkzdTVTaYK
 tDQxOQOEuh8TL/9gJjlVvMxCxreNgSdm5ST6D1dyuTERqFepyYEklQcyktD+EXmtgO3LFEYTj
 YjQNSyEn9iuNxQi5XIaVf/JWuNWrELmY0YJ+d7kFCDyKd55a1KRIYjcD13n59P+3cRTyPDWQe
 y5mlIuY7XEu/x4SpSdAWyftx9ziV6g/z0d8B4rZYUEVVb3t0n9LIXYtHJ5BUnih3VM8KVbUPq
 G1izjxNYqB67DagevpSd17xEHFbHI2WlWoU+76qZiYacihqzAP/mQ9OSM6kScHrcfr/Sx0FAN
 Cjija18D3u+N2xqYLG/bE/8PnBAxOAR1L6l2mFozVWIQbtmCiWiVDZ2vVLCje1gBMwg+T8Uy 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292410>

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
index 2711048..867ceb5 100644
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
@@ -1040,6 +1041,8 @@ static inline void *read_sha1_file(const unsigned=
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
2.8.0.rc2.2.g1a4d45a.dirty
