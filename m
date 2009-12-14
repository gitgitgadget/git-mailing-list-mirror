From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/23] dir.c: export excluded_1() and add_excludes_from_file_1()
Date: Mon, 14 Dec 2009 17:30:57 +0700
Message-ID: <1260786666-8405-15-git-send-email-pclouds@gmail.com>
References: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 11:33:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK8FL-0007wL-OS
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 11:33:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756250AbZLNKdb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 05:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756165AbZLNKdJ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 05:33:09 -0500
Received: from mail-px0-f174.google.com ([209.85.216.174]:39386 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756157AbZLNKdE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 05:33:04 -0500
Received: by pxi4 with SMTP id 4so1691452pxi.33
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 02:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=SnFVlZa9nxpzA6MZV7PXNRLtkdMJ/knamtRhq3CvjRM=;
        b=k5ieXF2zYO+GlzDcKy/jq+SIORs+O1UkIOV0z4OSbnvRP6epDF/PIxNIWppLT3MTNV
         Wso+7xO0aWauJUZBLoO6eMRQSRrSoX5KCdNrzce7Vi8hl78bugpqZN3kzxMc6OQTWROz
         A8yi7jzvK2X9CSwto/M4bPa+Ceye31UrBHyPA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=HdYX2sPnO6L1h2aCH/tSQa1EcAAuRBYVbqVpWvu+YSkhNhV/aHNL0AKe0quxf9EGZn
         jX+4lsjk5xJG6a4MgqWXhUQXOZetGy+n2cS2EhuhF+IuvX80SIsOz98kksgiOPlpmWtX
         BjBrjrSTQwkjkGDND2h6WbZJZL9RvMHyx4L60=
Received: by 10.115.38.30 with SMTP id q30mr3094428waj.184.1260786783196;
        Mon, 14 Dec 2009 02:33:03 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.233.253])
        by mx.google.com with ESMTPS id 21sm4904669pzk.7.2009.12.14.02.33.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Dec 2009 02:33:02 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 14 Dec 2009 17:32:21 +0700
X-Mailer: git-send-email 1.6.5.2.216.g9c1ec
In-Reply-To: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135180>

These functions are used to handle .gitignore. They are now exported
so that sparse checkout can reuse.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c |   32 ++++++++++++++++----------------
 dir.h |    4 ++++
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/dir.c b/dir.c
index 7735cea..6b1c478 100644
--- a/dir.c
+++ b/dir.c
@@ -223,12 +223,12 @@ static void *read_skip_worktree_file_from_index(c=
onst char *path, size_t *size)
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
@@ -274,8 +274,8 @@ static int add_excludes_from_file_1(const char *fna=
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
@@ -324,9 +324,9 @@ static void prep_exclude(struct dir_struct *dir, co=
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
@@ -336,9 +336,9 @@ static void prep_exclude(struct dir_struct *dir, co=
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
@@ -412,8 +412,8 @@ int excluded(struct dir_struct *dir, const char *pa=
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
1.6.5.2.216.g9c1ec
