From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 01/19] Move enter_repo() to setup.c
Date: Sun, 21 Mar 2010 17:30:28 +0700
Message-ID: <1269167446-7799-2-git-send-email-pclouds@gmail.com>
References: <1269167446-7799-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 21 11:34:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtIUX-00036U-Vz
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 11:34:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828Ab0CUKef convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Mar 2010 06:34:35 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55912 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681Ab0CUKee (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 06:34:34 -0400
Received: by gyg8 with SMTP id 8so2223392gyg.19
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 03:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=JaafNqYnv40usgdPZ7bS4YTytoot4YP1pgSTfqtKFbs=;
        b=SrFGTZwvLhCpoYYlOJfHkqAa+cMqkHu8RxnGB9SVyy5M8HyrnUKEXBgy2hBQDe9qhj
         1oc0QgwsKEMalA7IKHIQvQ72qzXrE1IbtTAGNgU9Vm5OrTKztFHaD3HPg48klnKHMbwB
         j+nwiPZFRPDQyPJZNZu9P0TnvBMONuo0HZYkY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=BTrPX2z5aHLrYQOGmMRow3XzHU34IK+Blh0w9bWGpyVrdHR2xWzZdnMB1PW/suvFf0
         Sbnh4VLkKlD4J8F06vRDjmN8IxW88FVG0m77nk4AUpXqbbpFdpFWfQSuEIUUOJrTZpZh
         /B4c8AJP+BIMeDP3gHi9xLA79zqHAzmlL9Hs4=
Received: by 10.150.184.8 with SMTP id h8mr5785115ybf.310.1269167673344;
        Sun, 21 Mar 2010 03:34:33 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.230.17])
        by mx.google.com with ESMTPS id 22sm1874609iwn.8.2010.03.21.03.34.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Mar 2010 03:34:32 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 21 Mar 2010 17:30:53 +0700
X-Mailer: git-send-email 1.7.0.2.425.gb99f1
In-Reply-To: <1269167446-7799-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142797>

enter_repo() is to set up a repository, it fits better in setup.c

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
1.7.0.2.425.gb99f1
