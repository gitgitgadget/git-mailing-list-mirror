From: tboegi@web.de
Subject: [PATCH v6b 10/10] ce_compare_data() did not respect conversion
Date: Sun, 24 Apr 2016 17:11:32 +0200
Message-ID: <1461510692-21239-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 17:07:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auLdL-00069M-TW
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 17:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806AbcDXPHe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Apr 2016 11:07:34 -0400
Received: from mout.web.de ([212.227.15.4]:61320 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752635AbcDXPHS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 11:07:18 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0LZvrx-1bZA1B1Zfx-00llnz; Sun, 24 Apr 2016 17:07:16
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:TT1khBYmJKsHkKblz6pFiuU6cZOyc6ZjZmM7YbzSQaV+GKaDOpe
 AL+8dOxkgugfnPePh78mq1OmOLsTV7a1UEHAeSzxq5mCb+BEbFt4YrOR08pOUGTYy/NxEEx
 VSLw9Qt1za6Hb9oW69MjltTTROaFzfIrk90nOHv8+4tqndWBGNmvWUxO0RXQXKDy0NvIs/M
 g9FGk+SG7/eN1pSzi8s2g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EIBk/ba1FsQ=:N0Dg1up1sMRj7ekP2/OSNV
 KkbaxZXs19stanDRB6jIOm2l+FQwAXvsnQp/JhIXpngtABLR5ondCzyZLMMa4Gqk72NcB6NaO
 jPxdjWs9khA+dNSwi/bjqlmQZSMpyAb/dQsdxNT5rvLNr7+ozSZ5tM5U/X63Pk2cD+tImPoGf
 eAjrQ+YND5ihAf9ml4f4kcDny/dGGCZ7rDKvfGHZ4Dl24qJ8Jw4yZi53o5ZKHzzraAAnz69qP
 RX6/CiR5NbWaCkIIcZVj6gISjkelkOJ/rVPb8n+CpQxto7LM0MiH0HBTKsTQPnqC5919cNnjj
 ADJaVQijMyXJSWSBbM2DQDT5ZPy/1dvewd4Sj1W+UjcJDOmhUKFLd1dBlPUqPgQ137FFig4fy
 knrumnoiCsFlWaQFiWKniWRLd6KPbaktZQpJ/9xI0PiPQmXapa6nEV1xCeK1U8sAgn0VRXqjc
 2EnNnCdC7EPuURhBx1nIuOtBR1kwgaHu/iOQMJot/dTZm/db2TW3vnS81v+bEegFvsZ0aXjmt
 FhdBvct/q0RCS5reHm/WUxhnkTilgjasH05Ru8cOwFSFjhrbyuDeZbteAtYE8LCyWIRdiRKeE
 ZVQ0Ui/tfwr9hU0nyAlx1djEz+ffuJ9W3Na90xoy1SzAYNBEq+6Zta636rLPnSzeBI9+DjC0p
 oKRimE2XK3lvkVqx4oAZB+psu9mOfOX9rMJjItOruLTeqR/Og/BSdWt+iCxa4HOz5V7Fq2JtN
 uc4MfO1cbuP4mnF+NlTunLnw1hlu0vCJGqxy3p28AmKntE/Pfx4d2/5M0VciQMJqvVaVTViF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292413>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

We define the working tree file is clean if either:

  * the result of running convert_to_git() on the working tree
    contents matches what is in the index (because that would mean
    doing another "git add" on the path is a no-op); OR

  * the result of running convert_to_working_tree() on the content
    in the index matches what is in the working tree (because that
    would mean doing another "git checkout -f" on the path is a
    no-op).

Add an extra check in ce_compare_data() in read_cache.c.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 read-cache.c               | 61 ++++++++++++++++++++++++++++++++++++++=
++++++++
 t/t6038-merge-text-auto.sh | 14 +++++------
 2 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index a3ef967..48c4b31 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -156,17 +156,78 @@ void fill_stat_cache_info(struct cache_entry *ce,=
 struct stat *st)
 		ce_mark_uptodate(ce);
 }
=20
+/*
+ * Compare the data in buf with the data in the file pointed by fd and
+ * return 0 if they are identical, and non-zero if they differ.
+ */
+static int compare_with_fd(const char *input, ssize_t len, int fd)
+{
+	for (;;) {
+		char buf[1024 * 16];
+		ssize_t chunk_len, read_len;
+
+		chunk_len =3D sizeof(buf) < len ? sizeof(buf) : len;
+		read_len =3D xread(fd, buf, chunk_len ? chunk_len : 1);
+
+		if (!read_len)
+			/* EOF on the working tree file */
+			return !len ? 0 : -1;
+
+		if (!len)
+			/* we expected there is nothing left */
+			return -1;
+
+		if (memcmp(buf, input, read_len))
+			return -1;
+		input +=3D read_len;
+		len -=3D read_len;
+	}
+}
+
 static int ce_compare_data(const struct cache_entry *ce, struct stat *=
st)
 {
 	int match =3D -1;
 	int fd =3D open(ce->name, O_RDONLY);
=20
+	/*
+	 * Would another "git add" on the path change what is in the
+	 * index for the path?
+	 */
 	if (fd >=3D 0) {
 		unsigned char sha1[20];
 		if (!index_fd(sha1, fd, st, OBJ_BLOB, ce->name, 0))
 			match =3D hashcmp(sha1, ce->sha1);
 		/* index_fd() closed the file descriptor already */
 	}
+	if (!match)
+		return match;
+
+	/*
+	 * Would another "git checkout -f" out of the index change
+	 * what is in the working tree file?
+	 */
+	fd =3D open(ce->name, O_RDONLY);
+	if (fd >=3D 0) {
+		enum object_type type;
+		unsigned long size_long;
+		void *data =3D read_sha1_file(ce->sha1, &type, &size_long);
+
+		if (type =3D=3D OBJ_BLOB) {
+			struct strbuf worktree =3D STRBUF_INIT;
+			if (convert_to_working_tree(ce->name, data,
+						    size_long,
+						    &worktree)) {
+				size_t size;
+				free(data);
+				data =3D strbuf_detach(&worktree, &size);
+				size_long =3D size;
+			}
+			if (!compare_with_fd(data, size_long, fd))
+				match =3D 0;
+		}
+		free(data);
+		close(fd);
+	}
 	return match;
 }
=20
diff --git a/t/t6038-merge-text-auto.sh b/t/t6038-merge-text-auto.sh
index 0108ead..565daf3 100755
--- a/t/t6038-merge-text-auto.sh
+++ b/t/t6038-merge-text-auto.sh
@@ -108,9 +108,9 @@ test_expect_success 'Merge addition of text=3Dauto'=
 '
=20
 test_expect_success 'Detect CRLF/LF conflict after setting text=3Dauto=
' '
 	echo "<<<<<<<" >expected &&
-	echo first line | append_cr >>expected &&
-	echo same line | append_cr >>expected &&
-	echo =3D=3D=3D=3D=3D=3D=3D | append_cr >>expected &&
+	echo first line >>expected &&
+	echo same line >>expected &&
+	echo =3D=3D=3D=3D=3D=3D=3D >>expected &&
 	echo first line | append_cr >>expected &&
 	echo same line | append_cr >>expected &&
 	echo ">>>>>>>" >>expected &&
@@ -121,14 +121,13 @@ test_expect_success 'Detect CRLF/LF conflict afte=
r setting text=3Dauto' '
 	fuzz_conflict file >file.fuzzy &&
 	compare_files expected file.fuzzy
 '
-
 test_expect_success 'Detect LF/CRLF conflict from addition of text=3Da=
uto' '
 	echo "<<<<<<<" >expected &&
 	echo first line | append_cr >>expected &&
 	echo same line | append_cr >>expected &&
-	echo =3D=3D=3D=3D=3D=3D=3D | append_cr >>expected &&
-	echo first line | append_cr >>expected &&
-	echo same line | append_cr >>expected &&
+	echo =3D=3D=3D=3D=3D=3D=3D  >>expected &&
+	echo first line >>expected &&
+	echo same line  >>expected &&
 	echo ">>>>>>>" >>expected &&
 	git config merge.renormalize false &&
 	rm -f .gitattributes &&
@@ -138,6 +137,7 @@ test_expect_success 'Detect LF/CRLF conflict from a=
ddition of text=3Dauto' '
 	compare_files expected file.fuzzy
 '
=20
+
 test_expect_failure 'checkout -m after setting text=3Dauto' '
 	cat <<-\EOF >expected &&
 	first line
--=20
2.8.0.rc2.2.g1a4d45a.dirty
