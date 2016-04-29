From: tboegi@web.de
Subject: [PATCH v8 10/10] ce_compare_data() did not respect conversion
Date: Fri, 29 Apr 2016 17:02:06 +0200
Message-ID: <1461942126-16296-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 16:57:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw9rY-0006yu-Fr
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 16:57:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753948AbcD2O5n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Apr 2016 10:57:43 -0400
Received: from mout.web.de ([212.227.15.14]:50313 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753910AbcD2O5l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 10:57:41 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0MBkal-1anasz1Ef9-00Ajo2; Fri, 29 Apr 2016 16:57:34
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:lbbv/tKkBAqkm611OVmh9koL5ZWvKhBtDW7By0nequTEQ0J3K2O
 f+qOgjBQs/XGUA+8y5+ihxL6m07hpEGlElFLqRkcwWOwuRIA2snovpGSRSONOV2J0LfBjYw
 Kqu5l+ktYisFIZJJQPEN11QU0ujjx3f1aa1hpYLNOtwbXx4hFBjNJMot1wHcbNoFo5Asz4n
 a4mpTPEzTs3UDqg1Tm1XQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0+cD92HKoHY=:+2T7hx540FXU5xq+ZvZk6x
 Bmsmx61l3NwCqG+9EFwzBamWjs2voy1ZyBK82FPtvl0eGOmBavH/os6zWzBZicc39RM3cK0mi
 gmZY5jdI/FmAglZa9+xKBwnkYxit+7gJKFUdvY3A2PlqGRxh49DcjLsSbQGmJw4kQWrFp5D0s
 snKbS1pvAJAhRaVHQCF5ai4964QCgDppHD3qFCEBTuF/DZQC4DjfyRUeaI3eafWJ98X4kFG2J
 72wx43Pq/vBPF34Xa/ywtxv4tDQ2vg9tghKTmlhB5/AkaZDCOUcIvsHWhDjcrKYHnRAJQQeai
 uvig6ynylHVl8wEwYlhPzMlj8UW354cYQ7fUzA5XqROFJ9wNi460Ic8KjC7Qu+bt/FMhhcNjQ
 gdqDopQQv1qME2UL+Pp5+ccMCxzhicEirs+a+LsUlFQZaF2GmEYDHLrf4rFFnqbcHUqEuZ3zY
 q5XmFdmlLjJgxol6gJsU8Lgg3CMIX1VYQxrQ5MRmEFVneGli6wBWKZDnZrF2BBnpVkxJjxJDP
 jd9BKSdlF8pEcrmgpdnjw42sqWvZ555eDRfFiST5dnOqj2/2QYB15Rvh24LOi8NmD7cJNYjFk
 AZ37hu2uI3mMhNIpXfvbLsCSn3SIa4bZ2x/IgfPgkuLNqy0GeCl7GLT5Fs2wPNEa8tl/Tn47X
 bBiU2VfiTDa6/wAz1OlHGudz/H7J85PSpeVyX0ZL4ZfND6fNYQq9BxGeforUD1S9omNSZ1ck2
 q07IvFxmzpGliR6T1LiJ+B7xYXkjNIMbwxGQHrdWeCxAhGAwicC0K+Y+bFwyhatMfMBk2uSU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293015>

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
2.7.0.992.g0c2c796
