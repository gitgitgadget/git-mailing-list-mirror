From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 08/26] file-watcher: add --detach
Date: Mon,  3 Feb 2014 11:28:56 +0700
Message-ID: <1391401754-15347-9-git-send-email-pclouds@gmail.com>
References: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
 <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 03 05:30:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WABAh-00015S-Dw
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 05:30:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869AbaBCEaE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Feb 2014 23:30:04 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:40590 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859AbaBCEaD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 23:30:03 -0500
Received: by mail-pa0-f51.google.com with SMTP id ld10so6624627pab.38
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 20:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=21ECveRW2DS3gi4DRjCnXtMw4h/befjT5aBbCs+OnX4=;
        b=PaDuVoYlMcZkOhMuQRbmP76hEo+/+hRNkBqWCAc+PiDa2QS8i7aMLbqohwLwq+iC1T
         NDLmxW+rRJh9/n/xvfzmcXqCtFVP0oMJYOaZbpH2wv0abQKb3e2V4nJn5nPQAxcwxNFW
         UVDwi7ghC2BryiW8H/R4k6GtA/kD26h+iU5kTi82xNs7y5O40YKdCsAKxzyEEu/1+3Li
         UyX09cP5XWvgF0CR6kVuI1oKE74DA+TiEK6GBF4SMlmcpq8FoFi6x+uO224rHBBI5Q+Q
         2dpYLm1Kz1HG2ZtZ6zeGBEDMA1NUj0OJYiDVxZ8KhA9F7dC8vIqdFROFherkUDi+xvoB
         BMoQ==
X-Received: by 10.68.138.165 with SMTP id qr5mr35422709pbb.123.1391401802966;
        Sun, 02 Feb 2014 20:30:02 -0800 (PST)
Received: from lanh ([115.73.226.68])
        by mx.google.com with ESMTPSA id ug2sm134273761pac.21.2014.02.02.20.30.00
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Feb 2014 20:30:02 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 03 Feb 2014 11:30:01 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241403>

In daemon mode, stdout and stderr are saved in $WATCHER/log.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-file-watcher.txt |  2 ++
 cache.h                            |  1 +
 daemon.c                           | 30 ++++--------------------------
 file-watcher.c                     | 17 +++++++++++++++++
 setup.c                            | 25 +++++++++++++++++++++++++
 5 files changed, 49 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-file-watcher.txt b/Documentation/git-fil=
e-watcher.txt
index 625a389..ec81f18 100644
--- a/Documentation/git-file-watcher.txt
+++ b/Documentation/git-file-watcher.txt
@@ -18,6 +18,8 @@ lstat(2) to detect that itself.
=20
 OPTIONS
 -------
+--detach::
+	Run in background.
=20
 SEE ALSO
 --------
diff --git a/cache.h b/cache.h
index 939db46..7a836b1 100644
--- a/cache.h
+++ b/cache.h
@@ -434,6 +434,7 @@ extern int set_git_dir_init(const char *git_dir, co=
nst char *real_git_dir, int);
 extern int init_db(const char *template_dir, unsigned int flags);
=20
 extern void sanitize_stdfds(void);
+extern int daemonize(int *);
=20
 #define alloc_nr(x) (((x)+16)*3/2)
=20
diff --git a/daemon.c b/daemon.c
index 503e039..2650504 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1056,11 +1056,6 @@ static void drop_privileges(struct credentials *=
cred)
 	/* nothing */
 }
=20
-static void daemonize(void)
-{
-	die("--detach not supported on this platform");
-}
-
 static struct credentials *prepare_credentials(const char *user_name,
     const char *group_name)
 {
@@ -1102,24 +1097,6 @@ static struct credentials *prepare_credentials(c=
onst char *user_name,
=20
 	return &c;
 }
-
-static void daemonize(void)
-{
-	switch (fork()) {
-		case 0:
-			break;
-		case -1:
-			die_errno("fork failed");
-		default:
-			exit(0);
-	}
-	if (setsid() =3D=3D -1)
-		die_errno("setsid failed");
-	close(0);
-	close(1);
-	close(2);
-	sanitize_stdfds();
-}
 #endif
=20
 static void store_pid(const char *path)
@@ -1333,9 +1310,10 @@ int main(int argc, char **argv)
 	if (inetd_mode || serve_mode)
 		return execute();
=20
-	if (detach)
-		daemonize();
-	else
+	if (detach) {
+		if (daemonize(NULL))
+			die("--detach not supported on this platform");
+	} else
 		sanitize_stdfds();
=20
 	if (pid_file)
diff --git a/file-watcher.c b/file-watcher.c
index 9c639ef..1e1ccad 100644
--- a/file-watcher.c
+++ b/file-watcher.c
@@ -111,7 +111,10 @@ int main(int argc, const char **argv)
 {
 	struct strbuf sb =3D STRBUF_INIT;
 	int i, new_nr, fd, quit =3D 0, nr_common;
+	int daemon =3D 0;
 	struct option options[] =3D {
+		OPT_BOOL(0, "detach", &daemon,
+			 N_("run in background")),
 		OPT_END()
 	};
=20
@@ -135,6 +138,20 @@ int main(int argc, const char **argv)
 	atexit(cleanup);
 	sigchain_push_common(cleanup_on_signal);
=20
+	if (daemon) {
+		int err;
+		strbuf_addf(&sb, "%s/log", socket_path);
+		err =3D open(sb.buf, O_CREAT | O_TRUNC | O_WRONLY, 0600);
+		adjust_shared_perm(sb.buf);
+		if (err =3D=3D -1)
+			die_errno(_("unable to create %s"), sb.buf);
+		if (daemonize(&do_not_clean_up))
+			die(_("--detach not supported on this platform"));
+		dup2(err, 1);
+		dup2(err, 2);
+		close(err);
+	}
+
 	nr_common =3D 1;
 	pfd_alloc =3D pfd_nr =3D nr_common;
 	pfd =3D xmalloc(sizeof(*pfd) * pfd_alloc);
diff --git a/setup.c b/setup.c
index 6c3f85f..757c45f 100644
--- a/setup.c
+++ b/setup.c
@@ -787,3 +787,28 @@ void sanitize_stdfds(void)
 	if (fd > 2)
 		close(fd);
 }
+
+int daemonize(int *flag)
+{
+#ifndef NO_POSIX_GOODIES
+	switch (fork()) {
+		case 0:
+			break;
+		case -1:
+			die_errno("fork failed");
+		default:
+			if (flag)
+				*flag =3D 1;
+			exit(0);
+	}
+	if (setsid() =3D=3D -1)
+		die_errno("setsid failed");
+	close(0);
+	close(1);
+	close(2);
+	sanitize_stdfds();
+	return 0;
+#else
+	return -1;
+#endif
+}
--=20
1.8.5.2.240.g8478abd
