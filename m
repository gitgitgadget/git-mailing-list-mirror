From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] Kill off get_relative_cwd()
Date: Sat, 26 Mar 2011 16:04:25 +0700
Message-ID: <1301130265-27287-2-git-send-email-pclouds@gmail.com>
References: <1301130265-27287-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Matthijs Kooijman <matthijs@stdin.nl>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 26 10:05:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3PQY-0001NZ-7Z
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 10:04:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786Ab1CZJEx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Mar 2011 05:04:53 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53864 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752583Ab1CZJEu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2011 05:04:50 -0400
Received: by iwn34 with SMTP id 34so1855658iwn.19
        for <git@vger.kernel.org>; Sat, 26 Mar 2011 02:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=ngrmnNVN+cJSSggRLD+nVAsexi9RFIMOP5tUVzn0pn0=;
        b=spAiPNtNV+QO038iOwT9xFdjq1V7BwaPscuhAkBVjgi9fWC8wxx/Bnx/5fzxYsKvgQ
         yQHBPMUSW/6hWc68URvzU46qqzs5J9U6eFx0lD73wNn9Qdkjv+kC3EeVMh8bbzDuBrmx
         CtszdXY8W8iVFPc1rWDB8qdRSdHyp6MVpGZYg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=PSvWo4oF9+UNAcluiiL4NY6Frk1y3bVxHioB2Mvy4RCfmDjCeuMbPdUVJrPOIMOSfa
         7BByTgluo2kEZ0hm3cFV1ssgi0+HZhi8jaJphLvub7MdkrzMhVD2m/NSxim8kzlbw1s2
         qWrp9YvOtvGBSKiFPWOF0cVIZc8P+nJ1mzTlg=
Received: by 10.42.230.133 with SMTP id jm5mr2767920icb.488.1301130289439;
        Sat, 26 Mar 2011 02:04:49 -0700 (PDT)
Received: from tre ([115.73.209.201])
        by mx.google.com with ESMTPS id o3sm1266056ibd.27.2011.03.26.02.04.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 26 Mar 2011 02:04:48 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Sat, 26 Mar 2011 16:04:38 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1301130265-27287-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170046>

=46unction dir_inside_of() does something similar (correctly), but look=
s
easier to understand and does not bundle cwd to its business. Given
get_relative_cwd's only user is is_inside_dir, we can kill it for
good.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 2011/3/25 Michael J Gruber <git@drmicha.warpmail.net>:
 > get_relative_cwd() tries to determine a common prefix for dir and
 > cwd.
 > The fix in
 > 490544b (get_cwd_relative(): do not misinterpret suffix as
 > subdirectory, 2010-05-22)
 > made the logic less naive (so that foo-bar is not misdetected as
 > being
 > within foo) but broke some other cases, in particular foo not being
 > detected as being within foo/ any more.
 >
 > Fix it by taking into a account that a directory name may or may
 > not end
 > in /.

 OK I stared at the code long enough and have come to the conclusion
 that your fix is essentially fbbb4e1 (get_cwd_relative(): do not
 misinterpret root path - 2010-11-20) but the structure is similar to
 my old is_subdir_or_same() (now dir_inside_of). So let's kill that
 cryptic switch.

 dir.c |   55 ++++++-------------------------------------------------
 dir.h |    1 -
 2 files changed, 6 insertions(+), 50 deletions(-)

diff --git a/dir.c b/dir.c
index 6c49a73..bd9e989 100644
--- a/dir.c
+++ b/dir.c
@@ -1105,53 +1105,6 @@ int file_exists(const char *f)
 }
=20
 /*
- * get_relative_cwd() gets the prefix of the current working directory
- * relative to 'dir'.  If we are not inside 'dir', it returns NULL.
- *
- * As a convenience, it also returns NULL if 'dir' is already NULL.  T=
he
- * reason for this behaviour is that it is natural for functions retur=
ning
- * directory names to return NULL to say "this directory does not exis=
t"
- * or "this directory is invalid".  These cases are usually handled th=
e
- * same as if the cwd is not inside 'dir' at all, so get_relative_cwd(=
)
- * returns NULL for both of them.
- *
- * Most notably, get_relative_cwd(buffer, size, get_git_work_tree())
- * unifies the handling of "outside work tree" with "no work tree at a=
ll".
- */
-char *get_relative_cwd(char *buffer, int size, const char *dir)
-{
-	char *cwd =3D buffer;
-
-	if (!dir)
-		return NULL;
-	if (!getcwd(buffer, size))
-		die_errno("can't find the current directory");
-
-	if (!is_absolute_path(dir))
-		dir =3D real_path(dir);
-
-	while (*dir && *dir =3D=3D *cwd) {
-		dir++;
-		cwd++;
-	}
-	if (*dir)
-		return NULL;
-	switch (*cwd) {
-	case '\0':
-		return cwd;
-	case '/':
-		return cwd + 1;
-	default:
-		/*
-		 * dir can end with a path separator when it's root
-		 * directory. Return proper prefix in that case.
-		 */
-		if (dir[-1] =3D=3D '/')
-			return cwd;
-		return NULL;
-	}
-}
-
  * Given two normalized paths (a trailing slash is ok), if subdir is
  * outside dir, return -1.  Otherwise return the offset in subdir that
  * can be used as relative path to dir.
@@ -1185,8 +1138,12 @@ int dir_inside_of(const char *subdir, const char=
 *dir)
=20
 int is_inside_dir(const char *dir)
 {
-	char buffer[PATH_MAX];
-	return get_relative_cwd(buffer, sizeof(buffer), dir) !=3D NULL;
+	char cwd[PATH_MAX];
+	if (!dir)
+		return 0;
+	if (!getcwd(cwd, sizeof(cwd)))
+		die_errno("can't find the current directory");
+	return dir_inside_of(cwd, dir) >=3D 0;
 }
=20
 int is_empty_dir(const char *path)
diff --git a/dir.h b/dir.h
index 83e2992..433b5b4 100644
--- a/dir.h
+++ b/dir.h
@@ -85,7 +85,6 @@ extern void add_exclude(const char *string, const cha=
r *base,
 extern void free_excludes(struct exclude_list *el);
 extern int file_exists(const char *);
=20
-extern char *get_relative_cwd(char *buffer, int size, const char *dir)=
;
 extern int is_inside_dir(const char *dir);
 extern int dir_inside_of(const char *subdir, const char *dir);
=20
--=20
1.7.4.74.g639db
