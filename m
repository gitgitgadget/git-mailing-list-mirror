From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/12] dir.c: rename excluded_from_list() to is_excluded_from_list()
Date: Mon, 15 Oct 2012 13:27:57 +0700
Message-ID: <1350282486-4646-3-git-send-email-pclouds@gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
 <1350282486-4646-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Spiers <git@adamspiers.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 08:28:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNeAV-0000oR-D8
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 08:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037Ab2JOG2l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 02:28:41 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60685 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976Ab2JOG2k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 02:28:40 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so4626454pbb.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 23:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=AkYtvNr4mYF+MJXAUpcI5oc5PPRf+4+JCIr0JvZK0r0=;
        b=1EIou9tluvXUUwlI7iRpsz7DkuR7N1Bwh1GgAxT9I0IrHSusghfYP9c/mrSPsSHsPJ
         XieM/3ec9QNnsPbl4tvmMkr9wtw/mOOYrDSnzpN3UqZ5WiY2hc4hwzana8zDFeM1NIpe
         HEmHI5ae9v1nEJSOg1KBZvAr/JWb9WFN9fKqxmnPfGc91pf5Pa1nILsmNgzrr4PBj5RP
         SCRRiQsQpLX8YDKK/0/nUcCfIB3bvu8LTCbsAN/R2ljEKyN3VzXj2ATVHgWD2EoExuar
         /+qsQqKPCnp+nBE8MUVAb46c1CDrt0G15bO+kXKDSIR/DEfsvqJw7mIu7Z7fIuxPR/3e
         Gn5A==
Received: by 10.68.202.6 with SMTP id ke6mr34042422pbc.82.1350282520161;
        Sun, 14 Oct 2012 23:28:40 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id ky5sm5335639pbc.40.2012.10.14.23.28.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 23:28:39 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Oct 2012 13:28:30 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1350282486-4646-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207714>

=46rom: Adam Spiers <git@adamspiers.org>

Continue adopting clearer names for exclude functions.  This 'is_*'
naming pattern for functions returning booleans was discussed here:

http://thread.gmane.org/gmane.comp.version-control.git/204661/focus=3D2=
04924

Also adjust their callers as necessary.

Signed-off-by: Adam Spiers <git@adamspiers.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c          | 11 ++++++-----
 dir.h          |  4 ++--
 unpack-trees.c |  8 +++++---
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/dir.c b/dir.c
index 6dfb815..7e1a23b 100644
--- a/dir.c
+++ b/dir.c
@@ -599,9 +599,9 @@ int match_pathname(const char *pathname, int pathle=
n,
 /* Scan the list and let the last match determine the fate.
  * Return 1 for exclude, 0 for include and -1 for undecided.
  */
-int excluded_from_list(const char *pathname,
-		       int pathlen, const char *basename, int *dtype,
-		       struct exclude_list *el)
+int is_excluded_from_list(const char *pathname,
+			  int pathlen, const char *basename, int *dtype,
+			  struct exclude_list *el)
 {
 	int i;
=20
@@ -648,8 +648,9 @@ static int excluded(struct dir_struct *dir, const c=
har *pathname, int *dtype_p)
=20
 	prep_exclude(dir, pathname, basename-pathname);
 	for (st =3D EXC_CMDL; st <=3D EXC_FILE; st++) {
-		switch (excluded_from_list(pathname, pathlen, basename,
-					   dtype_p, &dir->exclude_list[st])) {
+		switch (is_excluded_from_list(pathname, pathlen,
+					      basename, dtype_p,
+					      &dir->exclude_list[st])) {
 		case 0:
 			return 0;
 		case 1:
diff --git a/dir.h b/dir.h
index d40aeea..2fce4bf 100644
--- a/dir.h
+++ b/dir.h
@@ -76,8 +76,8 @@ extern int within_depth(const char *name, int namelen=
, int depth, int max_depth)
 extern int fill_directory(struct dir_struct *dir, const char **pathspe=
c);
 extern int read_directory(struct dir_struct *, const char *path, int l=
en, const char **pathspec);
=20
-extern int excluded_from_list(const char *pathname, int pathlen, const=
 char *basename,
-			      int *dtype, struct exclude_list *el);
+extern int is_excluded_from_list(const char *pathname, int pathlen, co=
nst char *basename,
+				 int *dtype, struct exclude_list *el);
 struct dir_entry *dir_add_ignored(struct dir_struct *dir, const char *=
pathname, int len);
=20
 /*
diff --git a/unpack-trees.c b/unpack-trees.c
index 3ac6370..c0da094 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -836,7 +836,8 @@ static int clear_ce_flags_dir(struct cache_entry **=
cache, int nr,
 {
 	struct cache_entry **cache_end;
 	int dtype =3D DT_DIR;
-	int ret =3D excluded_from_list(prefix, prefix_len, basename, &dtype, =
el);
+	int ret =3D is_excluded_from_list(prefix, prefix_len,
+					basename, &dtype, el);
=20
 	prefix[prefix_len++] =3D '/';
=20
@@ -855,7 +856,7 @@ static int clear_ce_flags_dir(struct cache_entry **=
cache, int nr,
 	 * with ret (iow, we know in advance the incl/excl
 	 * decision for the entire directory), clear flag here without
 	 * calling clear_ce_flags_1(). That function will call
-	 * the expensive excluded_from_list() on every entry.
+	 * the expensive is_excluded_from_list() on every entry.
 	 */
 	return clear_ce_flags_1(cache, cache_end - cache,
 				prefix, prefix_len,
@@ -938,7 +939,8 @@ static int clear_ce_flags_1(struct cache_entry **ca=
che, int nr,
=20
 		/* Non-directory */
 		dtype =3D ce_to_dtype(ce);
-		ret =3D excluded_from_list(ce->name, ce_namelen(ce), name, &dtype, e=
l);
+		ret =3D is_excluded_from_list(ce->name, ce_namelen(ce),
+					    name, &dtype, el);
 		if (ret < 0)
 			ret =3D defval;
 		if (ret > 0)
--=20
1.8.0.rc0.29.g1fdd78f
