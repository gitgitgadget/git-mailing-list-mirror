From: tboegi@web.de
Subject: [PATCH v2 1/7] Make it possible to get sha1 for a path from the index
Date: Fri,  1 Apr 2016 18:08:22 +0200
Message-ID: <1459526902-19790-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 01 18:05:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am1Zk-0006Ma-QP
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 18:05:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100AbcDAQFZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Apr 2016 12:05:25 -0400
Received: from mout.web.de ([212.227.17.11]:51719 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576AbcDAQFY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 12:05:24 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0McnqH-1aUlnt0rcv-00HxhU; Fri, 01 Apr 2016 18:05:20
 +0200
X-Mailer: git-send-email 2.8.0.rc2.2.g1a4d45a.dirty
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:g7J3CTlw1hXHN8gOA3Wh1g56b3tEMrZ4Nqp57cZLaSDiJG5ju+e
 OiytQ27JSyHGCdQNgFQ3yVj63s4d/pLPcol9RELWEvNtc5X4cOzQIIShqL7PMAYjOWhIfMZ
 n+cfNIbEh4iaULL9qLMIv5pdPyFQo180LZfImy9Vy8l91WqSh1OaKZfJvRMKO8hoV04UDZ4
 ymAOxikahKy0dBwJosC+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+k0yUmHhfi0=:6VI4Ai1w/kUdHRLjwdPwz5
 hP96BK4fwI7wFfnxiantPUrLUDNu4u+gqyL3uKCZ9YmyhTPDVAm1pF9hWa50lYpNSqIrbjUN4
 a/AGtfLyOfewEqov96/8tDha9nTPFIK0fH8f3CGSWDCjEJiI+ASu9Z7xrdweebwgi0vjcLJfh
 Ms/KHrTK6uG82yHaXlNUZAR63LjXqFQU6EQ9G8CTUYP4lkEgO7sqBdW3dBZ3cUsF2XTgtDMdg
 d3Qg/TnEhgvvVkVHZd+PROvcukFS836S2ghyLcUEYozYnN9UxbilH66L5OTyVHj9ialy3pq5S
 5xHuA07TNoxzneCsTnMSqTHBuix9igUX6rH1qsMrXVU8jmazxFRdXOegG56jZiCspBTXvOENq
 7BFT+6odW+eH6pZUp33dv8z5nYytlDY80fXRJm4chj2TSZkCETMuMPSBnWHrXlcy2ugGkIyu7
 t6xH69PncHC48YpByLh6eg4/SnprfAKIXQaPoRpo8fIIPevX6rO6MRdMlyWE6frlzQE2GykyA
 jiGpNeDsOgsheQ6rxtNvZzB8RN9imnDW/2DBSQntze9V8a7/Ia/HhTkqkCHdw0VkWeqknz3ap
 UCg+/GLR3wxCEpkFZdxZkKMSFsk3AvoJHGaTZz0BpeGpp26gas28XGaa3kKdlKw5cKswI4wLg
 MAKXfum413D0EEigaWgc6nI5JzaVxAtHK73i4dJeGNM/jnPXDren1z5meKhohHFX9TMj+IAij
 CD92iHse+j4BEqADGYTYN59uKxewfL+1UBQJhLCaoT/X7LUcMW7kWcfra5TFj5GV+nvm0v0f 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290548>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

=46actor out the retrieval of the sha1 for a given path in
read_blob_data_from_index() into the function get_sha1_from_index().

This will be used in the next commit, when convert.c can do the analyze
for "text=3Dauto" without slurping the whole blob into memory at once.

Add a wrapper definition get_sha1_from_cache().

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
- Changes against v1:
  Fixed typos, thanks Eric
  Corrected gitattributes.txt, "auto" will no longer normalize
  Rework of 7/7: Show the eol mismatch to the user when committing
---
 cache.h      |  3 +++
 read-cache.c | 29 ++++++++++++++++++-----------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/cache.h b/cache.h
index b829410..bd1210a 100644
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
@@ -1008,6 +1009,8 @@ static inline void *read_sha1_file(const unsigned=
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
