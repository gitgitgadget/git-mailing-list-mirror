From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 22/43] Move enter_repo() to setup.c
Date: Mon,  5 Apr 2010 20:41:07 +0200
Message-ID: <1270492888-26589-23-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:43:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrH4-0000ps-Em
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756086Ab0DESmy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:42:54 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:62876 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756061Ab0DESmp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:42:45 -0400
Received: by mail-fx0-f227.google.com with SMTP id 27so1250782fxm.28
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ZX3wUauUXbzPzrXrYkMZpN+kkuaKl+vqo7ZJc1xROGI=;
        b=x7/X99UvjiEtL9My349BlDKKA2A7QWvqAHYDQfs3PjK6TMxTt57YvgA6H0yHgdl8zb
         oSBqi7DDkaDpag15BJb5/QfJ3xSa9PKYTSXF6qKEehj+a/bQAKuJt7C81hAncBnPU+Gq
         NXCgSwn6KfJYuz+AUu/JbCe8kGRiYMGOVmEn8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=uoN0vKPBrhokDU8BbVRCBe0cYlGoNADTbMYnB72k/AGsgJONSkVOUWjNOg2IOA8kGy
         gBF1purSNBDD3sxgTxNQJfJRP33gvJU3eDWGEZatwgkWuUdOYw3/dKix4QeTWTK8EoCm
         T7260+faF8FvhsZpQOGm6c1eXdD7OzgBsJckw=
Received: by 10.223.144.77 with SMTP id y13mr6001448fau.86.1270492964875;
        Mon, 05 Apr 2010 11:42:44 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id 16sm8201706fxm.0.2010.04.05.11.42.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:42:44 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:42:41 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144018>

enter_repo() is to set up a repository, it fits better in setup.c

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 path.c  |   91 -------------------------------------------------------=
--------
 setup.c |   91 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 91 insertions(+), 91 deletions(-)

diff --git a/path.c b/path.c
index b4c8d91..f42eb1b 100644
--- a/path.c
+++ b/path.c
@@ -332,97 +332,6 @@ return_null:
 	return NULL;
 }
=20
-/*
- * First, one directory to try is determined by the following algorith=
m.
- *
- * (0) If "strict" is given, the path is used as given and no DWIM is
- *     done. Otherwise:
- * (1) "~/path" to mean path under the running user's home directory;
- * (2) "~user/path" to mean path under named user's home directory;
- * (3) "relative/path" to mean cwd relative directory; or
- * (4) "/absolute/path" to mean absolute directory.
- *
- * Unless "strict" is given, we try access() for existence of "%s.git/=
=2Egit",
- * "%s/.git", "%s.git", "%s" in this order.  The first one that exists=
 is
- * what we try.
- *
- * Second, we try chdir() to that.  Upon failure, we return NULL.
- *
- * Then, we try if the current directory is a valid git repository.
- * Upon failure, we return NULL.
- *
- * If all goes well, we return the directory we used to chdir() (but
- * before ~user is expanded), avoiding getcwd() resolving symbolic
- * links.  User relative paths are also returned as they are given,
- * except DWIM suffixing.
- */
-char *enter_repo(char *path, int strict)
-{
-	static char used_path[PATH_MAX];
-	static char validated_path[PATH_MAX];
-
-	if (!path)
-		return NULL;
-
-	if (!strict) {
-		static const char *suffix[] =3D {
-			".git/.git", "/.git", ".git", "", NULL,
-		};
-		int len =3D strlen(path);
-		int i;
-		while ((1 < len) && (path[len-1] =3D=3D '/')) {
-			path[len-1] =3D 0;
-			len--;
-		}
-		if (PATH_MAX <=3D len)
-			return NULL;
-		if (path[0] =3D=3D '~') {
-			char *newpath =3D expand_user_path(path);
-			if (!newpath || (PATH_MAX - 10 < strlen(newpath))) {
-				free(newpath);
-				return NULL;
-			}
-			/*
-			 * Copy back into the static buffer. A pity
-			 * since newpath was not bounded, but other
-			 * branches of the if are limited by PATH_MAX
-			 * anyway.
-			 */
-			strcpy(used_path, newpath); free(newpath);
-			strcpy(validated_path, path);
-			path =3D used_path;
-		}
-		else if (PATH_MAX - 10 < len)
-			return NULL;
-		else {
-			path =3D strcpy(used_path, path);
-			strcpy(validated_path, path);
-		}
-		len =3D strlen(path);
-		for (i =3D 0; suffix[i]; i++) {
-			strcpy(path + len, suffix[i]);
-			if (!access(path, F_OK)) {
-				strcat(validated_path, suffix[i]);
-				break;
-			}
-		}
-		if (!suffix[i] || chdir(path))
-			return NULL;
-		path =3D validated_path;
-	}
-	else if (chdir(path))
-		return NULL;
-
-	if (access("objects", X_OK) =3D=3D 0 && access("refs", X_OK) =3D=3D 0=
 &&
-	    validate_headref("HEAD") =3D=3D 0) {
-		set_git_dir(".");
-		check_repository_format();
-		return path;
-	}
-
-	return NULL;
-}
-
 int set_shared_perm(const char *path, int mode)
 {
 	struct stat st;
diff --git a/setup.c b/setup.c
index 8796c6f..3019da2 100644
--- a/setup.c
+++ b/setup.c
@@ -452,6 +452,97 @@ const char *setup_git_directory_gently(int *nongit=
_ok)
 	return prefix;
 }
=20
+/*
+ * First, one directory to try is determined by the following algorith=
m.
+ *
+ * (0) If "strict" is given, the path is used as given and no DWIM is
+ *     done. Otherwise:
+ * (1) "~/path" to mean path under the running user's home directory;
+ * (2) "~user/path" to mean path under named user's home directory;
+ * (3) "relative/path" to mean cwd relative directory; or
+ * (4) "/absolute/path" to mean absolute directory.
+ *
+ * Unless "strict" is given, we try access() for existence of "%s.git/=
=2Egit",
+ * "%s/.git", "%s.git", "%s" in this order.  The first one that exists=
 is
+ * what we try.
+ *
+ * Second, we try chdir() to that.  Upon failure, we return NULL.
+ *
+ * Then, we try if the current directory is a valid git repository.
+ * Upon failure, we return NULL.
+ *
+ * If all goes well, we return the directory we used to chdir() (but
+ * before ~user is expanded), avoiding getcwd() resolving symbolic
+ * links.  User relative paths are also returned as they are given,
+ * except DWIM suffixing.
+ */
+char *enter_repo(char *path, int strict)
+{
+	static char used_path[PATH_MAX];
+	static char validated_path[PATH_MAX];
+
+	if (!path)
+		return NULL;
+
+	if (!strict) {
+		static const char *suffix[] =3D {
+			".git/.git", "/.git", ".git", "", NULL,
+		};
+		int len =3D strlen(path);
+		int i;
+		while ((1 < len) && (path[len-1] =3D=3D '/')) {
+			path[len-1] =3D 0;
+			len--;
+		}
+		if (PATH_MAX <=3D len)
+			return NULL;
+		if (path[0] =3D=3D '~') {
+			char *newpath =3D expand_user_path(path);
+			if (!newpath || (PATH_MAX - 10 < strlen(newpath))) {
+				free(newpath);
+				return NULL;
+			}
+			/*
+			 * Copy back into the static buffer. A pity
+			 * since newpath was not bounded, but other
+			 * branches of the if are limited by PATH_MAX
+			 * anyway.
+			 */
+			strcpy(used_path, newpath); free(newpath);
+			strcpy(validated_path, path);
+			path =3D used_path;
+		}
+		else if (PATH_MAX - 10 < len)
+			return NULL;
+		else {
+			path =3D strcpy(used_path, path);
+			strcpy(validated_path, path);
+		}
+		len =3D strlen(path);
+		for (i =3D 0; suffix[i]; i++) {
+			strcpy(path + len, suffix[i]);
+			if (!access(path, F_OK)) {
+				strcat(validated_path, suffix[i]);
+				break;
+			}
+		}
+		if (!suffix[i] || chdir(path))
+			return NULL;
+		path =3D validated_path;
+	}
+	else if (chdir(path))
+		return NULL;
+
+	if (access("objects", X_OK) =3D=3D 0 && access("refs", X_OK) =3D=3D 0=
 &&
+	    validate_headref("HEAD") =3D=3D 0) {
+		set_git_dir(".");
+		check_repository_format();
+		return path;
+	}
+
+	return NULL;
+}
+
 int git_config_perm(const char *var, const char *value)
 {
 	int i;
--=20
1.7.0.rc1.541.g2da82.dirty
