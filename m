From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH v3 5/8] dir.c: export excluded_1() and add_excludes_from_file_1()
Date: Tue, 11 Aug 2009 22:44:03 +0700
Message-ID: <1250005446-12047-6-git-send-email-pclouds@gmail.com>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com>
 <1250005446-12047-2-git-send-email-pclouds@gmail.com>
 <1250005446-12047-3-git-send-email-pclouds@gmail.com>
 <1250005446-12047-4-git-send-email-pclouds@gmail.com>
 <1250005446-12047-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 17:45:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MatWt-0006wH-4h
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 17:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753583AbZHKPoo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Aug 2009 11:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753572AbZHKPon
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 11:44:43 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:29186 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529AbZHKPon (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 11:44:43 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1344620rvb.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 08:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=FkX8orMSsguLyXsbOftb5O/GFi09zgvf3dpFXNxbLLs=;
        b=KLM59KiWjegq2pgY1kaWDmmRnqIhfTwWk4tBB+l8SxaRzwCnqQ7J4eLV7D7tNPiUoe
         ahKWNEjieLPIg6QWPkqeDZYPbBd3kIOJeN1m/8ZGVl9BgujVRftR/qzCMiBk8u++0Tzv
         HceiD/Wi+SlHjr0WbrI3A4sqaG8na7nuqAr6k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=tStQQuCBlQnHs4bzd2NLjHnCZFdRwKvJpeYYL0pR6+QcpfGQ7riCmosCvIJMFwABGr
         LtK1KDJaJvO0N/nvPn7YdZo1d7TTfpdbXABPiwTICEmKLmn0oUv3ES+/R4O/qd06YCyr
         I5bAr8t4TPoHYxrneE9tzCGqW1I77UVi0cLv8=
Received: by 10.141.51.11 with SMTP id d11mr2179185rvk.87.1250005484566;
        Tue, 11 Aug 2009 08:44:44 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.239.0])
        by mx.google.com with ESMTPS id g31sm5902068rvb.46.2009.08.11.08.44.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 Aug 2009 08:44:43 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 11 Aug 2009 22:44:38 +0700
X-Mailer: git-send-email 1.6.3.GIT
In-Reply-To: <1250005446-12047-5-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125580>

These functions are used to handle .gitignore. They are now exported
so that sparse checkout can reuse.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c |   32 ++++++++++++++++----------------
 dir.h |    4 ++++
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/dir.c b/dir.c
index c990938..bc35586 100644
--- a/dir.c
+++ b/dir.c
@@ -224,12 +224,12 @@ static void *read_assume_unchanged_from_index(con=
st char *path, size_t *size)
 	return data;
 }
=20
-static int add_excludes_from_file_1(const char *fname,
-				    const char *base,
-				    int baselen,
-				    char **buf_p,
-				    struct exclude_list *which,
-				    int check_index)
+int add_excludes_from_file_to_list(const char *fname,
+				   const char *base,
+				   int baselen,
+				   char **buf_p,
+				   struct exclude_list *which,
+				   int check_index)
 {
 	struct stat st;
 	int fd, i;
@@ -275,8 +275,8 @@ static int add_excludes_from_file_1(const char *fna=
me,
=20
 void add_excludes_from_file(struct dir_struct *dir, const char *fname)
 {
-	if (add_excludes_from_file_1(fname, "", 0, NULL,
-				     &dir->exclude_list[EXC_FILE], 0) < 0)
+	if (add_excludes_from_file_to_list(fname, "", 0, NULL,
+					   &dir->exclude_list[EXC_FILE], 0) < 0)
 		die("cannot use %s as an exclude file", fname);
 }
=20
@@ -325,9 +325,9 @@ static void prep_exclude(struct dir_struct *dir, co=
nst char *base, int baselen)
 		memcpy(dir->basebuf + current, base + current,
 		       stk->baselen - current);
 		strcpy(dir->basebuf + stk->baselen, dir->exclude_per_dir);
-		add_excludes_from_file_1(dir->basebuf,
-					 dir->basebuf, stk->baselen,
-					 &stk->filebuf, el, 1);
+		add_excludes_from_file_to_list(dir->basebuf,
+					       dir->basebuf, stk->baselen,
+					       &stk->filebuf, el, 1);
 		dir->exclude_stack =3D stk;
 		current =3D stk->baselen;
 	}
@@ -337,9 +337,9 @@ static void prep_exclude(struct dir_struct *dir, co=
nst char *base, int baselen)
 /* Scan the list and let the last match determine the fate.
  * Return 1 for exclude, 0 for include and -1 for undecided.
  */
-static int excluded_1(const char *pathname,
-		      int pathlen, const char *basename, int *dtype,
-		      struct exclude_list *el)
+int excluded_from_list(const char *pathname,
+		       int pathlen, const char *basename, int *dtype,
+		       struct exclude_list *el)
 {
 	int i;
=20
@@ -413,8 +413,8 @@ int excluded(struct dir_struct *dir, const char *pa=
thname, int *dtype_p)
=20
 	prep_exclude(dir, pathname, basename-pathname);
 	for (st =3D EXC_CMDL; st <=3D EXC_FILE; st++) {
-		switch (excluded_1(pathname, pathlen, basename,
-				   dtype_p, &dir->exclude_list[st])) {
+		switch (excluded_from_list(pathname, pathlen, basename,
+					   dtype_p, &dir->exclude_list[st])) {
 		case 0:
 			return 0;
 		case 1:
diff --git a/dir.h b/dir.h
index a631446..472e11e 100644
--- a/dir.h
+++ b/dir.h
@@ -69,7 +69,11 @@ extern int match_pathspec(const char **pathspec, con=
st char *name, int namelen,
 extern int fill_directory(struct dir_struct *dir, const char **pathspe=
c);
 extern int read_directory(struct dir_struct *, const char *path, int l=
en, const char **pathspec);
=20
+extern int excluded_from_list(const char *pathname, int pathlen, const=
 char *basename,
+			      int *dtype, struct exclude_list *el);
 extern int excluded(struct dir_struct *, const char *, int *);
+extern int add_excludes_from_file_to_list(const char *fname, const cha=
r *base, int baselen,
+					  char **buf_p, struct exclude_list *which, int check_index);
 extern void add_excludes_from_file(struct dir_struct *, const char *fn=
ame);
 extern void add_exclude(const char *string, const char *base,
 			int baselen, struct exclude_list *which);
--=20
1.6.3.GIT
