From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/16] Move enter_repo() to setup.c
Date: Thu, 11 Mar 2010 20:22:19 +0700
Message-ID: <1268313754-28179-2-git-send-email-pclouds@gmail.com>
References: <1268313754-28179-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 11 14:23:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpiMd-0001K7-0x
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 14:23:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412Ab0CKNWs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Mar 2010 08:22:48 -0500
Received: from mail-pz0-f194.google.com ([209.85.222.194]:40589 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932388Ab0CKNWq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 08:22:46 -0500
Received: by mail-pz0-f194.google.com with SMTP id 32so11276pzk.4
        for <git@vger.kernel.org>; Thu, 11 Mar 2010 05:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=KvI6n97AmG/Lt1MKN66TbED3Rdbcrt7+AYc1lSLs6S0=;
        b=QfjxX4Z+GzFGvTHjXm47cPXMtmu5LIlcE7Q1aZLlSmE3GlymhYaGrYbH8AGCIN+Tpf
         bw5RJXvUuMICYLcKu6V3AbqMTQl3ig5VoERwshQpKGPS7VDewKFCb+N9blQL1Gc3Dvh3
         OlFVjBzGc8Oew24tL/WFKOtbNBeojGIZH1grY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=kL+vo67bhGCR+q+sCC7SbKaIw3YNjM1xNmkY5GZNUp4MAC5bC4ejHtFjNBKZEdEk7I
         PMZVdJtPSLuocWeiz+Gsk58KFfstCfeG7nuQDAtcpwyv2b+pzy0T4UdDdJPPWK+h5m9F
         qsB+K65Oge/bddqK1UlEXMK41JFcX1pYMu1PI=
Received: by 10.142.74.20 with SMTP id w20mr1378037wfa.94.1268313766532;
        Thu, 11 Mar 2010 05:22:46 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.196.130])
        by mx.google.com with ESMTPS id 23sm8862530pzk.14.2010.03.11.05.22.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Mar 2010 05:22:45 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 11 Mar 2010 20:22:40 +0700
X-Mailer: git-send-email 1.7.0.1.384.g6abcaa
In-Reply-To: <1268313754-28179-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141968>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
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
1.7.0.1.384.g6abcaa
