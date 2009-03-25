From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] init: support --fast-import using "git fast-import" as backend
Date: Wed, 25 Mar 2009 22:01:39 +1100
Message-ID: <1237978899-2621-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 12:04:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmQu6-0000Pf-GS
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 12:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753961AbZCYLCn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2009 07:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753611AbZCYLCn
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 07:02:43 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:48162 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbZCYLCm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 07:02:42 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2794156rvb.1
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 04:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=iQrQGfP48Vz84arf7gjyGh+KXkoo9UhRu7ymkouhuQE=;
        b=cqCtJ6OuXPQzWMTK8HE0+f895bWJvXoBlq8qdAjgzfhqHTOB9bRB+URf4PuoprJqee
         1k3sCnFI5TxKVKEeWQRtS8dHfl/WeK1NWUDytg4wArINeCPFBQq9Pvcdmie7Uo/LEnIh
         FH+GroRoQiuflOyMp0IBuVSHX9hREPuwZC/ss=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=ksqxOr6RF2f8qyh0qSbGhbOowc3C9ALWuCGjNO/snaKMNdlDJregF+E2vCbqM6K2qr
         GeMszQ6ige7L2L2i9BGQHVjbFPwII8ynXtXdOr2JZ14HU2acKpqtT7tZKAlwAT3KwE5Y
         ETEJIdeg4UWG1oY/lIK/Vv9RBbIOrtXc0ZNIk=
Received: by 10.140.207.2 with SMTP id e2mr3518530rvg.148.1237978960156;
        Wed, 25 Mar 2009 04:02:40 -0700 (PDT)
Received: from dektop ([121.91.97.93])
        by mx.google.com with ESMTPS id k37sm16799455rvb.8.2009.03.25.04.02.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Mar 2009 04:02:39 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 25 Mar 2009 22:01:39 +1100
X-Mailer: git-send-email 1.6.1.446.gc7851
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114585>

I was curious to see how git-import script performed in C version.
The result is quite good (only tried once so might be incorrect).
The patch is not ready for submission though. Sorry for patch numbering=
,
forgot to add "-n".

Tests were performed with "echo 3 > /proc/sys/vm/drop_caches". Test rep=
o is
gentoo-x86, which consists of ~11k small text files.

~/t/gentoo-x86 $ time ~/git/git/git init -M
Initialized empty Git repository in /home/pclouds/t/gentoo-x86/.git/

real    7m30.663s
user    0m33.171s
sys     3m31.599s
~/t/gentoo-x86 $ du -s .git
73700   .git
~/t/gentoo-x86 $ find .git/|wc -l
31
~/t/gentoo-x86 $ git ls-files|wc -l
113012

~/t/gentoo-x86 $ rm .git/ -rf
~/t/gentoo-x86 $ time ~/git/git/git init -m
Initialized empty Git repository in /home/pclouds/t/gentoo-x86/.git/

real    10m5.114s
user    0m13.718s
sys     3m50.317s
~/t/gentoo-x86 $ du -s .git
521960  .git
~/t/gentoo-x86 $ find .git/|wc -l
123275

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-init-db.c |  108 +++++++++++++++++++++++++++++++++++++++++++++=
++++++-
 1 files changed, 105 insertions(+), 3 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 3ace4ca..42c126c 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -386,6 +386,105 @@ static int import_files(const char *import_messag=
e)
 	return run_command_v_opt(args, RUN_GIT_CMD);
 }
=20
+static void fast_import_recursive(int fdo, const char *path)
+{
+	DIR *fdir;
+	char fullname[PATH_MAX + 1];
+	int len, dtype, fdi;
+	struct dirent *de;
+	struct stat st;
+	const char *fdir_path;
+	char buf[4096];
+	int buflen;
+	struct strbuf s;
+
+	fdir_path =3D path ? path : ".";
+	fdir =3D opendir(fdir_path);
+	if (!fdir)
+		die("Could not open directory %s", fdir_path);
+
+	if (path) {
+		len =3D strlen(path);
+		memcpy(fullname, path, len);
+		fullname[len++] =3D '/';
+	}
+	else
+		len =3D 0;
+	strbuf_init(&s, 32);
+	while ((de =3D readdir(fdir)) !=3D NULL) {
+		if (!strcmp(de->d_name, ".") ||
+		    !strcmp(de->d_name, "..") ||
+		    !strcmp(de->d_name, ".git"))
+			continue;
+		dtype =3D DTYPE(de);
+		memcpy(fullname+len, de->d_name, de->d_reclen+1);
+		if (lstat(fullname, &st))
+			die("Could not stat %s", fullname);
+		if (dtype =3D=3D DT_UNKNOWN) {
+			if (S_ISREG(st.st_mode))
+				dtype =3D DT_REG;
+			if (S_ISDIR(st.st_mode))
+				dtype =3D DT_DIR;
+			if (S_ISLNK(st.st_mode))
+				dtype =3D DT_LNK;
+		}
+		switch (dtype) {
+		case DT_DIR:
+			fast_import_recursive(fdo, fullname);
+			break;
+		case DT_LNK:
+		case DT_REG:
+			fdi =3D open(fullname, O_RDONLY);
+			if (fdi =3D=3D -1)
+				die("Could not open %s", fullname);
+			strbuf_setlen(&s, 0);
+			strbuf_addf(&s,"M 100644 inline %s\n", fullname);
+			strbuf_addf(&s, "data %u\n", (unsigned int)st.st_size); /* FIXME: l=
arge file */
+			write_or_die(fdo, s.buf, s.len);
+			while ((buflen =3D xread(fdi, buf, sizeof(buf))) > 0)
+				write_or_die(fdo, buf, buflen);
+			close(fdi);
+			write_or_die(fdo, "\n", 1);
+			break;
+		}
+	}
+	strbuf_release(&s);
+	closedir(fdir);
+}
+
+#define FAST_IMPORT_DEBUG 0
+
+static int fast_import_files(const char *import_message)
+{
+	struct child_process p;
+	const char *argv[4] =3D {"fast-import", "--quiet", "--date-format=3Dr=
aw", NULL};
+	struct strbuf s;
+
+	memset(&p, 0, sizeof(p));
+	p.argv =3D argv;
+	p.in =3D -1;
+	p.git_cmd =3D 1;
+#if FAST_IMPORT_DEBUG
+	p.in =3D 1;
+#else
+	if (start_command(&p))
+		die("Could not spawn fast-import");
+#endif
+	strbuf_init(&s, 64);
+	strbuf_addstr(&s, "commit refs/heads/master\n");
+	strbuf_addf(&s,   "committer %s\n", git_committer_info(0));
+	strbuf_addf(&s,   "data <<MSGEND\n%s\nMSGEND\n", import_message);
+	write_or_die(p.in, s.buf, s.len);
+	strbuf_release(&s);
+	fast_import_recursive(p.in, NULL);
+#if !FAST_IMPORT_DEBUG
+	close(p.in);
+	if (finish_command(&p))
+		die("fast-import died");
+#endif
+	return 0;
+}
+
 static const char init_db_usage[] =3D
 "git init [-q | --quiet] [--bare] [--template=3D<template-directory>] =
[--shared[=3D<permissions>]] [-m|--import [<message>]]";
=20
@@ -401,7 +500,7 @@ int cmd_init_db(int argc, const char **argv, const =
char *prefix)
 	const char *template_dir =3D NULL;
 	unsigned int flags =3D 0;
 	const char *import_message =3D NULL;
-	int ret, i;
+	int ret, i, fast_import =3D 0;
=20
 	for (i =3D 1; i < argc; i++, argv++) {
 		const char *arg =3D argv[1];
@@ -416,7 +515,10 @@ int cmd_init_db(int argc, const char **argv, const=
 char *prefix)
 			init_shared_repository =3D PERM_GROUP;
 		else if (!prefixcmp(arg, "--shared=3D"))
 			init_shared_repository =3D git_config_perm("arg", arg+9);
-		else if (!strcmp(arg, "--import") || !strcmp(arg, "-m")) {
+		else if (!strcmp(arg, "--import") || !strcmp(arg, "-m") ||
+			 !strcmp(arg, "--fast-import") || !strcmp(arg, "-M")) {
+			if (!strcmp(arg, "--fast-import") || !strcmp(arg, "-M"))
+				fast_import =3D 1;
 			if (i+1 >=3D argc)
 				import_message =3D "Initial commit";
 			else {
@@ -481,5 +583,5 @@ int cmd_init_db(int argc, const char **argv, const =
char *prefix)
 		return ret;
 	if (reinit)
 		die("--import does not work with already initialized repository");
-	return import_files(import_message);
+	return fast_import ? fast_import_files(import_message) : import_files=
(import_message);
 }
--=20
1.6.1.446.gc7851
