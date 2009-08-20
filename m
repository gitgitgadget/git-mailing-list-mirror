From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH v4 07/19] Read .gitignore from index if it is skip-worktree
Date: Thu, 20 Aug 2009 20:47:01 +0700
Message-ID: <1250776033-12395-8-git-send-email-pclouds@gmail.com>
References: <1250776033-12395-1-git-send-email-pclouds@gmail.com>
 <1250776033-12395-2-git-send-email-pclouds@gmail.com>
 <1250776033-12395-3-git-send-email-pclouds@gmail.com>
 <1250776033-12395-4-git-send-email-pclouds@gmail.com>
 <1250776033-12395-5-git-send-email-pclouds@gmail.com>
 <1250776033-12395-6-git-send-email-pclouds@gmail.com>
 <1250776033-12395-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 20 15:49:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me81G-0007ZS-3k
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 15:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754662AbZHTNsA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2009 09:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754659AbZHTNr7
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 09:47:59 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:44339 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754655AbZHTNr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 09:47:58 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1591323rvb.1
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 06:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=wqRDTl2oGF3RjBi+yLPzOY2rh31SVBOTZLnbmdyI7rM=;
        b=N+bMkzLKdKCrr886jOeWk1fdJD/YUjZfPKvIAQP/2UMw1iNpSq9j01rent96E7TsQO
         FvSaW0NX105nNYql8AV4hCWsPfZRgjk+7EWBQ7ULQnBjKNg3nlW8PVbTAib/t2JxOYmm
         q05lg0wyDNz4lDvwsvxpqwt0EPc+bOiPaEx48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=fHXlZjNfTVgauTNASzvZqGHorUFP98Y/2HcCXKLk3absv74Dneni5ULhr7zrO9shHx
         sQh10HUFBjhl4adPw2xqcOAuIsZWRfSslU3sEnMONQ9g29XN2HNYqNI+ueaIwJ/odDoQ
         nP5Kna08Il5mx0gAW/xeRefxFZJ2rIVPEicNM=
Received: by 10.141.41.16 with SMTP id t16mr4631309rvj.258.1250776080718;
        Thu, 20 Aug 2009 06:48:00 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.241.222])
        by mx.google.com with ESMTPS id b39sm4614393rvf.30.2009.08.20.06.47.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Aug 2009 06:48:00 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 20 Aug 2009 20:47:54 +0700
X-Mailer: git-send-email 1.6.3.GIT
In-Reply-To: <1250776033-12395-7-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126629>

This adds index as a prerequisite for directory listing (with
exclude).  At the moment directory listing is used by "git clean",
"git add", "git ls-files" and "git status"/"git commit" and
unpack_trees()-related commands.  These commands have been
checked/modified to populate index before doing directory listing.

add_excludes_from_file() does not enable this feature, because it
is used to read .git/info/exclude and some explicit files specified
by "git ls-files".

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/technical/api-directory-listing.txt |    3 +
 builtin-clean.c                                   |    4 +-
 builtin-ls-files.c                                |    4 +-
 dir.c                                             |   65 +++++++++++++=
+------
 t/t3001-ls-files-others-exclude.sh                |   22 +++++++
 t/t7300-clean.sh                                  |   19 ++++++
 6 files changed, 95 insertions(+), 22 deletions(-)

diff --git a/Documentation/technical/api-directory-listing.txt b/Docume=
ntation/technical/api-directory-listing.txt
index 5bbd18f..add6f43 100644
--- a/Documentation/technical/api-directory-listing.txt
+++ b/Documentation/technical/api-directory-listing.txt
@@ -58,6 +58,9 @@ The result of the enumeration is left in these fields=
::
 Calling sequence
 ----------------
=20
+Note: index may be looked at for .gitignore files that are CE_SKIP_WOR=
KTREE
+marked. If you to exclude files, make sure you have loaded index first=
=2E
+
 * Prepare `struct dir_struct dir` and clear it with `memset(&dir, 0,
   sizeof(dir))`.
=20
diff --git a/builtin-clean.c b/builtin-clean.c
index 05c763c..96ada75 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -75,11 +75,13 @@ int cmd_clean(int argc, const char **argv, const ch=
ar *prefix)
=20
 	dir.flags |=3D DIR_SHOW_OTHER_DIRECTORIES;
=20
+	if (read_cache() < 0)
+		die("index file corrupt");
+
 	if (!ignored)
 		setup_standard_excludes(&dir);
=20
 	pathspec =3D get_pathspec(prefix, argv);
-	read_cache();
=20
 	fill_directory(&dir, pathspec);
=20
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index ad7e447..2e47242 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -485,6 +485,9 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *prefix)
 		prefix_offset =3D strlen(prefix);
 	git_config(git_default_config, NULL);
=20
+	if (read_cache() < 0)
+		die("index file corrupt");
+
 	argc =3D parse_options(argc, argv, prefix, builtin_ls_files_options,
 			ls_files_usage, 0);
 	if (show_tag || show_valid_bit) {
@@ -513,7 +516,6 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *prefix)
 	pathspec =3D get_pathspec(prefix, argv);
=20
 	/* be nice with submodule paths ending in a slash */
-	read_cache();
 	if (pathspec)
 		strip_trailing_slash_from_submodules();
=20
diff --git a/dir.c b/dir.c
index e9254d6..cda2556 100644
--- a/dir.c
+++ b/dir.c
@@ -200,11 +200,35 @@ void add_exclude(const char *string, const char *=
base,
 	which->excludes[which->nr++] =3D x;
 }
=20
+static void *read_skip_worktree_file_from_index(const char *path, size=
_t *size)
+{
+	int pos, len;
+	unsigned long sz;
+	enum object_type type;
+	void *data;
+	struct index_state *istate =3D &the_index;
+
+	len =3D strlen(path);
+	pos =3D index_name_pos(istate, path, len);
+	if (pos < 0)
+		return NULL;
+	if (!ce_skip_worktree(istate->cache[pos]))
+		return NULL;
+	data =3D read_sha1_file(istate->cache[pos]->sha1, &type, &sz);
+	if (!data || type !=3D OBJ_BLOB) {
+		free(data);
+		return NULL;
+	}
+	*size =3D xsize_t(sz);
+	return data;
+}
+
 static int add_excludes_from_file_1(const char *fname,
 				    const char *base,
 				    int baselen,
 				    char **buf_p,
-				    struct exclude_list *which)
+				    struct exclude_list *which,
+				    int check_index)
 {
 	struct stat st;
 	int fd, i;
@@ -212,20 +236,26 @@ static int add_excludes_from_file_1(const char *f=
name,
 	char *buf, *entry;
=20
 	fd =3D open(fname, O_RDONLY);
-	if (fd < 0 || fstat(fd, &st) < 0)
-		goto err;
-	size =3D xsize_t(st.st_size);
-	if (size =3D=3D 0) {
-		close(fd);
-		return 0;
+	if (fd < 0 || fstat(fd, &st) < 0) {
+		if (0 <=3D fd)
+			close(fd);
+		if (!check_index ||
+		    (buf =3D read_skip_worktree_file_from_index(fname, &size)) =3D=3D=
 NULL)
+			return -1;
 	}
-	buf =3D xmalloc(size+1);
-	if (read_in_full(fd, buf, size) !=3D size)
-	{
-		free(buf);
-		goto err;
+	else {
+		size =3D xsize_t(st.st_size);
+		if (size =3D=3D 0) {
+			close(fd);
+			return 0;
+		}
+		buf =3D xmalloc(size);
+		if (read_in_full(fd, buf, size) !=3D size) {
+			close(fd);
+			return -1;
+		}
+		close(fd);
 	}
-	close(fd);
=20
 	if (buf_p)
 		*buf_p =3D buf;
@@ -240,17 +270,12 @@ static int add_excludes_from_file_1(const char *f=
name,
 		}
 	}
 	return 0;
-
- err:
-	if (0 <=3D fd)
-		close(fd);
-	return -1;
 }
=20
 void add_excludes_from_file(struct dir_struct *dir, const char *fname)
 {
 	if (add_excludes_from_file_1(fname, "", 0, NULL,
-				     &dir->exclude_list[EXC_FILE]) < 0)
+				     &dir->exclude_list[EXC_FILE], 0) < 0)
 		die("cannot use %s as an exclude file", fname);
 }
=20
@@ -301,7 +326,7 @@ static void prep_exclude(struct dir_struct *dir, co=
nst char *base, int baselen)
 		strcpy(dir->basebuf + stk->baselen, dir->exclude_per_dir);
 		add_excludes_from_file_1(dir->basebuf,
 					 dir->basebuf, stk->baselen,
-					 &stk->filebuf, el);
+					 &stk->filebuf, el, 1);
 		dir->exclude_stack =3D stk;
 		current =3D stk->baselen;
 	}
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-othe=
rs-exclude.sh
index c65bca8..132c476 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -64,6 +64,8 @@ two/*.4
 echo '!*.2
 !*.8' >one/two/.gitignore
=20
+allignores=3D'.gitignore one/.gitignore one/two/.gitignore'
+
 test_expect_success \
     'git ls-files --others with various exclude options.' \
     'git ls-files --others \
@@ -85,6 +87,26 @@ test_expect_success \
        >output &&
      test_cmp expect output'
=20
+test_expect_success 'setup skip-worktree gitignore' '
+	git add $allignores &&
+	git update-index --skip-worktree $allignores &&
+	rm $allignores
+'
+
+test_expect_success \
+    'git ls-files --others with various exclude options.' \
+    'git ls-files --others \
+       --exclude=3D\*.6 \
+       --exclude-per-directory=3D.gitignore \
+       --exclude-from=3D.git/ignore \
+       >output &&
+     test_cmp expect output'
+
+test_expect_success 'restore gitignore' '
+	git checkout $allignores &&
+	rm .git/index
+'
+
 cat > excludes-file <<\EOF
 *.[1-8]
 e*
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 118c6eb..7d8ed68 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -22,6 +22,25 @@ test_expect_success 'setup' '
=20
 '
=20
+test_expect_success 'git clean with skip-worktree .gitignore' '
+	git update-index --skip-worktree .gitignore &&
+	rm .gitignore &&
+	mkdir -p build docs &&
+	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
+	git clean &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test ! -f a.out &&
+	test ! -f src/part3.c &&
+	test -f docs/manual.txt &&
+	test -f obj.o &&
+	test -f build/lib.so &&
+	git update-index --no-skip-worktree .gitignore &&
+	git checkout .gitignore
+'
+
 test_expect_success 'git clean' '
=20
 	mkdir -p build docs &&
--=20
1.6.3.GIT
