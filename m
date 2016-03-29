From: tboegi@web.de
Subject: [PATCH v1 1/7] Make it possible to get sha1 for a path from the index
Date: Tue, 29 Mar 2016 15:25:30 +0200
Message-ID: <1459257930-17193-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 15:22:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aktbc-0001FM-JL
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 15:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671AbcC2NWm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2016 09:22:42 -0400
Received: from mout.web.de ([212.227.15.3]:50779 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752393AbcC2NWl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 09:22:41 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0Lz2vo-1Zgsms1s4e-014EvQ; Tue, 29 Mar 2016 15:22:38
 +0200
X-Mailer: git-send-email 2.8.0.rc2.2.g1a4d45a.dirty
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:yvWQGWNzeP+JPN8Z0Tlx+ZICBaMdL4IK7Oeafr/uO2avrAfvHBy
 9LgqAG5KCaIjEwqb3b3jrD7GcxdGWq3CelSEiG2kQLyvOYW1A9/hUn4jjXkKu7QkI06MfNj
 1UBt+L86HpomL4u5ps/XAPVmEXy2uXtw4nnk53kKSqFW6k7GiZxDhs5HbuEL7Jyhqd3Id8+
 f4UpHxg0UQJTKzbJ98/og==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9pQcPyEHDGg=:0UJ5EfCYseH7bqj/eSCo0l
 OnyKMYXrhi2EcnbF3BxOsKzWp5EdVl1RbJArnvibRyUf7PFjaedte+W6Ww216LMXEnwthWEyn
 eN3RA8qCG5bhFCe44j2msE6vlcmGKM71PWw0YxJBtQM7si1blha/CMCOPG29FtQVgezJ1bsxz
 kzNjNO/7+W1I4jNTp0BQsavD/i7FnXwIy1w52XlpfV/pFCMwghtfUcyNzSZnF3YS7L71uNE1d
 qtYICTurgrxpK0mwrlGwpjZp1T17P/kgZNmO2sk5V+lV6WI54pGrvBjIkl+XIuBJt2IjY60GC
 5Cw1WTJs9JM3/le0c3UfY4oLLrm8aBBZAc0bzxgqoAnUj2J146JNJwUVLwUJBCCNCQqtEUYvd
 0hkdcJ8SBZ7lfXash0r47QlpkkhjD6sGVT1gD4j+z42aN3ksMoNyMI3j8Z841TtQoExe4RjQ+
 O5j2Xz9vqnceoEH/iCAfmZS2DOTGvtH2RGDM5A1tgUANQJsz9NIhG9Lr1/Wk0/TdrPBmDy9cd
 2TQNTJKn+O0EKYp9HwZjhLhi8KRa2qXYM2vbJvQ42WG+e/Hc+x+cEaGFoOPthNchFXCsuzX3x
 FkTDnJYYpqY0riXOR5halqDEGJqpgkvEJz9kwwe3m7Ajg4BrqzVapPXONYTJWEEh7t/XwYlaM
 FVF/oq86cCznk8y4LkA/FtdS6PTwKQPu0H/LyiCauX6mBsTmx8JsYin7kd+yox+eE3diCfi1X
 e3PQxAytyRrVRZobeQEfT+ZhDzFH8QuBfbTjX5ENG7p+ioP8026zP3j1Uc0WCZrttvNfGY0D 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290126>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

=46actor out the retrival of the sha1 for a given path in
read_blob_data_from_index() into the function get_sha1_from_index().

This will be used in the next commit, when convert.c can do the analyze
for "text=3Dauto" without slurping the whole blob into memory at once.

Add a wrapper definition get_sha1_from_cache().

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
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
2.8.0.rc2.6.g3847ccb
