From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 3/4] Appease Sun Studio by renaming "tmpfile"
Date: Wed, 21 Dec 2011 01:18:21 +0000
Message-ID: <1324430302-22441-4-git-send-email-avarab@gmail.com>
References: <1324430302-22441-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Jason Evans <jasone@canonware.com>,
	David Barr <david.barr@cordelta.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 02:18:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdApU-0001Wn-Cq
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 02:18:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030Ab1LUBSo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Dec 2011 20:18:44 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:52700 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753571Ab1LUBSn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 20:18:43 -0500
Received: by mail-ee0-f46.google.com with SMTP id c4so7119243eek.19
        for <git@vger.kernel.org>; Tue, 20 Dec 2011 17:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=a50Wzb3bISa0aXHd9RGL7JHkjiUeurJjR9hwtBTuH4w=;
        b=txLiL85hB7WFJsSr+A9EFvsgLXxgVncA2CK9A8/DLX7Hhmmq6iraEUOxulZW2qBMeX
         r8h+xWpC6v61y1v/VAP0BXWlcUd9N3cDJdW7O2fLfOMaz0+P5Cz+QMzrU12WkqA+o5V+
         DWAoCIc4LvJYJgmktAy0isLzoM0yojJemQLIo=
Received: by 10.14.127.197 with SMTP id d45mr1860511eei.91.1324430322384;
        Tue, 20 Dec 2011 17:18:42 -0800 (PST)
Received: from w.nix.is (w.nix.is. [188.40.98.140])
        by mx.google.com with ESMTPS id z43sm14054237eef.7.2011.12.20.17.18.41
        (version=SSLv3 cipher=OTHER);
        Tue, 20 Dec 2011 17:18:41 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1324430302-22441-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187543>

On Solaris the system headers define the "tmpfile" name, which'll
cause Git compiled with Sun Studio 12 Update 1 to whine about us
redefining the name:

    "pack-write.c", line 76: warning: name redefined by pragma redefine=
_extname declared static: tmpfile     (E_PRAGMA_REDEFINE_STATIC)
    "sha1_file.c", line 2455: warning: name redefined by pragma redefin=
e_extname declared static: tmpfile    (E_PRAGMA_REDEFINE_STATIC)
    "fast-import.c", line 858: warning: name redefined by pragma redefi=
ne_extname declared static: tmpfile   (E_PRAGMA_REDEFINE_STATIC)
    "builtin/index-pack.c", line 175: warning: name redefined by pragma=
 redefine_extname declared static: tmpfile    (E_PRAGMA_REDEFINE_STATIC=
)

Just renaming the "tmpfile" variable to "tmp_file" in the relevant
places is the easiest way to fix this.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/index-pack.c |    6 +++---
 fast-import.c        |    8 ++++----
 pack-write.c         |    6 +++---
 sha1_file.c          |   12 ++++++------
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 98025da..af7dc37 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -172,10 +172,10 @@ static const char *open_pack_file(const char *pac=
k_name)
 	if (from_stdin) {
 		input_fd =3D 0;
 		if (!pack_name) {
-			static char tmpfile[PATH_MAX];
-			output_fd =3D odb_mkstemp(tmpfile, sizeof(tmpfile),
+			static char tmp_file[PATH_MAX];
+			output_fd =3D odb_mkstemp(tmp_file, sizeof(tmp_file),
 						"pack/tmp_pack_XXXXXX");
-			pack_name =3D xstrdup(tmpfile);
+			pack_name =3D xstrdup(tmp_file);
 		} else
 			output_fd =3D open(pack_name, O_CREAT|O_EXCL|O_RDWR, 0600);
 		if (output_fd < 0)
diff --git a/fast-import.c b/fast-import.c
index 4b9c4b7..6cd19e5 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -855,15 +855,15 @@ static struct tree_content *dup_tree_content(stru=
ct tree_content *s)
=20
 static void start_packfile(void)
 {
-	static char tmpfile[PATH_MAX];
+	static char tmp_file[PATH_MAX];
 	struct packed_git *p;
 	struct pack_header hdr;
 	int pack_fd;
=20
-	pack_fd =3D odb_mkstemp(tmpfile, sizeof(tmpfile),
+	pack_fd =3D odb_mkstemp(tmp_file, sizeof(tmp_file),
 			      "pack/tmp_pack_XXXXXX");
-	p =3D xcalloc(1, sizeof(*p) + strlen(tmpfile) + 2);
-	strcpy(p->pack_name, tmpfile);
+	p =3D xcalloc(1, sizeof(*p) + strlen(tmp_file) + 2);
+	strcpy(p->pack_name, tmp_file);
 	p->pack_fd =3D pack_fd;
 	p->do_not_close =3D 1;
 	pack_file =3D sha1fd(pack_fd, p->pack_name);
diff --git a/pack-write.c b/pack-write.c
index de2bd01..ca9e63b 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -73,9 +73,9 @@ const char *write_idx_file(const char *index_name, st=
ruct pack_idx_entry **objec
 		f =3D sha1fd_check(index_name);
 	} else {
 		if (!index_name) {
-			static char tmpfile[PATH_MAX];
-			fd =3D odb_mkstemp(tmpfile, sizeof(tmpfile), "pack/tmp_idx_XXXXXX")=
;
-			index_name =3D xstrdup(tmpfile);
+			static char tmp_file[PATH_MAX];
+			fd =3D odb_mkstemp(tmp_file, sizeof(tmp_file), "pack/tmp_idx_XXXXXX=
");
+			index_name =3D xstrdup(tmp_file);
 		} else {
 			unlink(index_name);
 			fd =3D open(index_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
diff --git a/sha1_file.c b/sha1_file.c
index f291f3f..88f2151 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2452,15 +2452,15 @@ static int write_loose_object(const unsigned ch=
ar *sha1, char *hdr, int hdrlen,
 	git_SHA_CTX c;
 	unsigned char parano_sha1[20];
 	char *filename;
-	static char tmpfile[PATH_MAX];
+	static char tmp_file[PATH_MAX];
=20
 	filename =3D sha1_file_name(sha1);
-	fd =3D create_tmpfile(tmpfile, sizeof(tmpfile), filename);
+	fd =3D create_tmpfile(tmp_file, sizeof(tmp_file), filename);
 	if (fd < 0) {
 		if (errno =3D=3D EACCES)
 			return error("insufficient permission for adding an object to repos=
itory database %s\n", get_object_directory());
 		else
-			return error("unable to create temporary sha1 filename %s: %s\n", t=
mpfile, strerror(errno));
+			return error("unable to create temporary sha1 filename %s: %s\n", t=
mp_file, strerror(errno));
 	}
=20
 	/* Set it up */
@@ -2505,12 +2505,12 @@ static int write_loose_object(const unsigned ch=
ar *sha1, char *hdr, int hdrlen,
 		struct utimbuf utb;
 		utb.actime =3D mtime;
 		utb.modtime =3D mtime;
-		if (utime(tmpfile, &utb) < 0)
+		if (utime(tmp_file, &utb) < 0)
 			warning("failed utime() on %s: %s",
-				tmpfile, strerror(errno));
+				tmp_file, strerror(errno));
 	}
=20
-	return move_temp_to_file(tmpfile, filename);
+	return move_temp_to_file(tmp_file, filename);
 }
=20
 int write_sha1_file(const void *buf, unsigned long len, const char *ty=
pe, unsigned char *returnsha1)
--=20
1.7.7.3
