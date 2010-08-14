From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/5] vcs-svn: Rename dirent pool to build on Windows
Date: Fri, 13 Aug 2010 19:01:34 -0500
Message-ID: <20100814000133.GE2153@burratino>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
 <4C63BD9B.6000608@viscovery.net>
 <20100813000848.GA8076@burratino>
 <4C65BA46.9010604@kdbg.org>
 <20100813234723.GC2153@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Aug 14 02:03:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok4Dg-0001HV-15
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 02:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172Ab0HNADX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 20:03:23 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53190 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756416Ab0HNADW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Aug 2010 20:03:22 -0400
Received: by vws3 with SMTP id 3so1672659vws.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 17:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=C4JOoaeTcuHfwFxK551rx/4U6Axca3B/WAYN1Hal0ts=;
        b=ZBfCWtxzJHTC6tTJ2s5l28mjIrDWhsgDlK8M5Qpzeu0fiAf/yJ8b7MNc4ijsGTzAvs
         YO84XOeFl1vA9y3hJaR5WLABgyQyFXMJC1YVvaHFEQ+glg0HWtJc/RYuH4hfuHySi7Ka
         9YT+xSnZdB7rKoGPMDZRVR6s9szm8vkfIxPuc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=M8iHFkj+8IC9SBTNwj+J9pguxdN2DDtaV1rI6dtLbQDUdclcOrGeIEIkUteLTaPnYw
         xHAqBleepl0FHyWMJCHGqiwKqldunL2zJGmVl755rP3O6enf11/br4gXv1G09LH31K8Q
         rErx+4DLeA9rSI0w229hPeT6uQBHw1nHWtsU8=
Received: by 10.220.71.136 with SMTP id h8mr1264097vcj.135.1281744201742;
        Fri, 13 Aug 2010 17:03:21 -0700 (PDT)
Received: from burratino ([64.134.175.141])
        by mx.google.com with ESMTPS id m11sm1229035vcg.6.2010.08.13.17.03.15
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 13 Aug 2010 17:03:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100813234723.GC2153@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153531>

dirent is #define=E2=80=99d to mingw_dirent in compat/mingw.h, with the
result that

 obj_pool_gen(dirent, struct repo_dirent, 4096)

creates functions with names like mingw_dirent_alloc and
references to dirent_alloc go unresolved.  Rename the functions
to dent_* to avoid this problem.

Reported-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/repo_tree.c |  146 +++++++++++++++++++++++++------------------=
-------
 1 files changed, 73 insertions(+), 73 deletions(-)

diff --git a/vcs-svn/repo_tree.c b/vcs-svn/repo_tree.c
index c3d7ee7..e94d91d 100644
--- a/vcs-svn/repo_tree.c
+++ b/vcs-svn/repo_tree.c
@@ -30,7 +30,7 @@ struct repo_commit {
 /* Memory pools for commit, dir and dirent */
 obj_pool_gen(commit, struct repo_commit, 4096)
 obj_pool_gen(dir, struct repo_dir, 4096)
-obj_pool_gen(dirent, struct repo_dirent, 4096)
+obj_pool_gen(dent, struct repo_dirent, 4096)
=20
 static uint32_t active_commit;
 static uint32_t mark;
@@ -38,7 +38,7 @@ static uint32_t mark;
 static int repo_dirent_name_cmp(const void *a, const void *b);
=20
 /* Treap for directory entries */
-trp_gen(static, dirent_, struct repo_dirent, children, dirent, repo_di=
rent_name_cmp);
+trp_gen(static, dent_, struct repo_dirent, children, dent, repo_dirent=
_name_cmp);
=20
 uint32_t next_blob_mark(void)
 {
@@ -52,27 +52,27 @@ static struct repo_dir *repo_commit_root_dir(struct=
 repo_commit *commit)
=20
 static struct repo_dirent *repo_first_dirent(struct repo_dir *dir)
 {
-	return dirent_first(&dir->entries);
+	return dent_first(&dir->entries);
 }
=20
 static int repo_dirent_name_cmp(const void *a, const void *b)
 {
-	const struct repo_dirent *dirent1 =3D a, *dirent2 =3D b;
-	uint32_t a_offset =3D dirent1->name_offset;
-	uint32_t b_offset =3D dirent2->name_offset;
+	const struct repo_dirent *dent1 =3D a, *dent2 =3D b;
+	uint32_t a_offset =3D dent1->name_offset;
+	uint32_t b_offset =3D dent2->name_offset;
 	return (a_offset > b_offset) - (a_offset < b_offset);
 }
=20
-static int repo_dirent_is_dir(struct repo_dirent *dirent)
+static int repo_dirent_is_dir(struct repo_dirent *dent)
 {
-	return dirent !=3D NULL && dirent->mode =3D=3D REPO_MODE_DIR;
+	return dent !=3D NULL && dent->mode =3D=3D REPO_MODE_DIR;
 }
=20
-static struct repo_dir *repo_dir_from_dirent(struct repo_dirent *diren=
t)
+static struct repo_dir *repo_dir_from_dirent(struct repo_dirent *dent)
 {
-	if (!repo_dirent_is_dir(dirent))
+	if (!repo_dirent_is_dir(dent))
 		return NULL;
-	return dir_pointer(dirent->content_offset);
+	return dir_pointer(dent->content_offset);
 }
=20
 static struct repo_dir *repo_clone_dir(struct repo_dir *orig_dir)
@@ -90,19 +90,19 @@ static struct repo_dir *repo_clone_dir(struct repo_=
dir *orig_dir)
 static struct repo_dirent *repo_read_dirent(uint32_t revision, uint32_=
t *path)
 {
 	uint32_t name =3D 0;
-	struct repo_dirent *key =3D dirent_pointer(dirent_alloc(1));
+	struct repo_dirent *key =3D dent_pointer(dent_alloc(1));
 	struct repo_dir *dir =3D NULL;
-	struct repo_dirent *dirent =3D NULL;
+	struct repo_dirent *dent =3D NULL;
 	dir =3D repo_commit_root_dir(commit_pointer(revision));
 	while (~(name =3D *path++)) {
 		key->name_offset =3D name;
-		dirent =3D dirent_search(&dir->entries, key);
-		if (dirent =3D=3D NULL || !repo_dirent_is_dir(dirent))
+		dent =3D dent_search(&dir->entries, key);
+		if (dent =3D=3D NULL || !repo_dirent_is_dir(dent))
 			break;
-		dir =3D repo_dir_from_dirent(dirent);
+		dir =3D repo_dir_from_dirent(dent);
 	}
-	dirent_free(1);
-	return dirent;
+	dent_free(1);
+	return dent;
 }
=20
 static void repo_write_dirent(uint32_t *path, uint32_t mode,
@@ -111,7 +111,7 @@ static void repo_write_dirent(uint32_t *path, uint3=
2_t mode,
 	uint32_t name, revision, dir_o =3D ~0, parent_dir_o =3D ~0;
 	struct repo_dir *dir;
 	struct repo_dirent *key;
-	struct repo_dirent *dirent =3D NULL;
+	struct repo_dirent *dent =3D NULL;
 	revision =3D active_commit;
 	dir =3D repo_commit_root_dir(commit_pointer(revision));
 	dir =3D repo_clone_dir(dir);
@@ -119,52 +119,52 @@ static void repo_write_dirent(uint32_t *path, uin=
t32_t mode,
 	while (~(name =3D *path++)) {
 		parent_dir_o =3D dir_offset(dir);
=20
-		key =3D dirent_pointer(dirent_alloc(1));
+		key =3D dent_pointer(dent_alloc(1));
 		key->name_offset =3D name;
=20
-		dirent =3D dirent_search(&dir->entries, key);
-		if (dirent =3D=3D NULL)
-			dirent =3D key;
+		dent =3D dent_search(&dir->entries, key);
+		if (dent =3D=3D NULL)
+			dent =3D key;
 		else
-			dirent_free(1);
+			dent_free(1);
=20
-		if (dirent =3D=3D key) {
-			dirent->mode =3D REPO_MODE_DIR;
-			dirent->content_offset =3D 0;
-			dirent_insert(&dir->entries, dirent);
+		if (dent =3D=3D key) {
+			dent->mode =3D REPO_MODE_DIR;
+			dent->content_offset =3D 0;
+			dent_insert(&dir->entries, dent);
 		}
=20
-		if (dirent_offset(dirent) < dirent_pool.committed) {
-			dir_o =3D repo_dirent_is_dir(dirent) ?
-					dirent->content_offset : ~0;
-			dirent_remove(&dir->entries, dirent);
-			dirent =3D dirent_pointer(dirent_alloc(1));
-			dirent->name_offset =3D name;
-			dirent->mode =3D REPO_MODE_DIR;
-			dirent->content_offset =3D dir_o;
-			dirent_insert(&dir->entries, dirent);
+		if (dent_offset(dent) < dent_pool.committed) {
+			dir_o =3D repo_dirent_is_dir(dent) ?
+					dent->content_offset : ~0;
+			dent_remove(&dir->entries, dent);
+			dent =3D dent_pointer(dent_alloc(1));
+			dent->name_offset =3D name;
+			dent->mode =3D REPO_MODE_DIR;
+			dent->content_offset =3D dir_o;
+			dent_insert(&dir->entries, dent);
 		}
=20
-		dir =3D repo_dir_from_dirent(dirent);
+		dir =3D repo_dir_from_dirent(dent);
 		dir =3D repo_clone_dir(dir);
-		dirent->content_offset =3D dir_offset(dir);
+		dent->content_offset =3D dir_offset(dir);
 	}
-	if (dirent =3D=3D NULL)
+	if (dent =3D=3D NULL)
 		return;
-	dirent->mode =3D mode;
-	dirent->content_offset =3D content_offset;
+	dent->mode =3D mode;
+	dent->content_offset =3D content_offset;
 	if (del && ~parent_dir_o)
-		dirent_remove(&dir_pointer(parent_dir_o)->entries, dirent);
+		dent_remove(&dir_pointer(parent_dir_o)->entries, dent);
 }
=20
 uint32_t repo_copy(uint32_t revision, uint32_t *src, uint32_t *dst)
 {
 	uint32_t mode =3D 0, content_offset =3D 0;
-	struct repo_dirent *src_dirent;
-	src_dirent =3D repo_read_dirent(revision, src);
-	if (src_dirent !=3D NULL) {
-		mode =3D src_dirent->mode;
-		content_offset =3D src_dirent->content_offset;
+	struct repo_dirent *src_dent;
+	src_dent =3D repo_read_dirent(revision, src);
+	if (src_dent !=3D NULL) {
+		mode =3D src_dent->mode;
+		content_offset =3D src_dent->content_offset;
 		repo_write_dirent(dst, mode, content_offset, 0);
 	}
 	return mode;
@@ -178,10 +178,10 @@ void repo_add(uint32_t *path, uint32_t mode, uint=
32_t blob_mark)
 uint32_t repo_replace(uint32_t *path, uint32_t blob_mark)
 {
 	uint32_t mode =3D 0;
-	struct repo_dirent *src_dirent;
-	src_dirent =3D repo_read_dirent(active_commit, path);
-	if (src_dirent !=3D NULL) {
-		mode =3D src_dirent->mode;
+	struct repo_dirent *src_dent;
+	src_dent =3D repo_read_dirent(active_commit, path);
+	if (src_dent !=3D NULL) {
+		mode =3D src_dent->mode;
 		repo_write_dirent(path, mode, blob_mark, 0);
 	}
 	return mode;
@@ -189,10 +189,10 @@ uint32_t repo_replace(uint32_t *path, uint32_t bl=
ob_mark)
=20
 void repo_modify(uint32_t *path, uint32_t mode, uint32_t blob_mark)
 {
-	struct repo_dirent *src_dirent;
-	src_dirent =3D repo_read_dirent(active_commit, path);
-	if (src_dirent !=3D NULL && blob_mark =3D=3D 0)
-		blob_mark =3D src_dirent->content_offset;
+	struct repo_dirent *src_dent;
+	src_dent =3D repo_read_dirent(active_commit, path);
+	if (src_dent !=3D NULL && blob_mark =3D=3D 0)
+		blob_mark =3D src_dent->content_offset;
 	repo_write_dirent(path, mode, blob_mark, 0);
 }
=20
@@ -203,13 +203,13 @@ void repo_delete(uint32_t *path)
=20
 static void repo_git_add_r(uint32_t depth, uint32_t *path, struct repo=
_dir *dir);
=20
-static void repo_git_add(uint32_t depth, uint32_t *path, struct repo_d=
irent *dirent)
+static void repo_git_add(uint32_t depth, uint32_t *path, struct repo_d=
irent *dent)
 {
-	if (repo_dirent_is_dir(dirent))
-		repo_git_add_r(depth, path, repo_dir_from_dirent(dirent));
+	if (repo_dirent_is_dir(dent))
+		repo_git_add_r(depth, path, repo_dir_from_dirent(dent));
 	else
 		fast_export_modify(depth, path,
-				   dirent->mode, dirent->content_offset);
+				   dent->mode, dent->content_offset);
 }
=20
 static void repo_git_add_r(uint32_t depth, uint32_t *path, struct repo=
_dir *dir)
@@ -218,7 +218,7 @@ static void repo_git_add_r(uint32_t depth, uint32_t=
 *path, struct repo_dir *dir)
 	while (de) {
 		path[depth] =3D de->name_offset;
 		repo_git_add(depth + 1, path, de);
-		de =3D dirent_next(&dir->entries, de);
+		de =3D dent_next(&dir->entries, de);
 	}
 }
=20
@@ -233,13 +233,13 @@ static void repo_diff_r(uint32_t depth, uint32_t =
*path, struct repo_dir *dir1,
 		if (de1->name_offset < de2->name_offset) {
 			path[depth] =3D de1->name_offset;
 			fast_export_delete(depth + 1, path);
-			de1 =3D dirent_next(&dir1->entries, de1);
+			de1 =3D dent_next(&dir1->entries, de1);
 			continue;
 		}
 		if (de1->name_offset > de2->name_offset) {
 			path[depth] =3D de2->name_offset;
 			repo_git_add(depth + 1, path, de2);
-			de2 =3D dirent_next(&dir2->entries, de2);
+			de2 =3D dent_next(&dir2->entries, de2);
 			continue;
 		}
 		path[depth] =3D de1->name_offset;
@@ -257,18 +257,18 @@ static void repo_diff_r(uint32_t depth, uint32_t =
*path, struct repo_dir *dir1,
 			fast_export_delete(depth + 1, path);
 			repo_git_add(depth + 1, path, de2);
 		}
-		de1 =3D dirent_next(&dir1->entries, de1);
-		de2 =3D dirent_next(&dir2->entries, de2);
+		de1 =3D dent_next(&dir1->entries, de1);
+		de2 =3D dent_next(&dir2->entries, de2);
 	}
 	while (de1) {
 		path[depth] =3D de1->name_offset;
 		fast_export_delete(depth + 1, path);
-		de1 =3D dirent_next(&dir1->entries, de1);
+		de1 =3D dent_next(&dir1->entries, de1);
 	}
 	while (de2) {
 		path[depth] =3D de2->name_offset;
 		repo_git_add(depth + 1, path, de2);
-		de2 =3D dirent_next(&dir2->entries, de2);
+		de2 =3D dent_next(&dir2->entries, de2);
 	}
 }
=20
@@ -286,7 +286,7 @@ void repo_commit(uint32_t revision, uint32_t author=
, char *log, uint32_t uuid,
 		 uint32_t url, unsigned long timestamp)
 {
 	fast_export_commit(revision, author, log, uuid, url, timestamp);
-	dirent_commit();
+	dent_commit();
 	dir_commit();
 	active_commit =3D commit_alloc(1);
 	commit_pointer(active_commit)->root_dir_offset =3D
@@ -297,10 +297,10 @@ static void mark_init(void)
 {
 	uint32_t i;
 	mark =3D 0;
-	for (i =3D 0; i < dirent_pool.size; i++)
-		if (!repo_dirent_is_dir(dirent_pointer(i)) &&
-		    dirent_pointer(i)->content_offset > mark)
-			mark =3D dirent_pointer(i)->content_offset;
+	for (i =3D 0; i < dent_pool.size; i++)
+		if (!repo_dirent_is_dir(dent_pointer(i)) &&
+		    dent_pointer(i)->content_offset > mark)
+			mark =3D dent_pointer(i)->content_offset;
 	mark++;
 }
=20
@@ -325,5 +325,5 @@ void repo_reset(void)
 	pool_reset();
 	commit_reset();
 	dir_reset();
-	dirent_reset();
+	dent_reset();
 }
--=20
1.7.2.1.544.ga752d.dirty
