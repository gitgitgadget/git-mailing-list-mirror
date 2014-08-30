From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/32] setup.c: detect $GIT_COMMON_DIR in is_git_directory()
Date: Sat, 30 Aug 2014 15:33:46 +0700
Message-ID: <1409387642-24492-17-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 10:35:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNe8A-0002Nh-Od
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 10:35:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbaH3IfY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2014 04:35:24 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:55214 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327AbaH3IfV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 04:35:21 -0400
Received: by mail-pa0-f50.google.com with SMTP id kq14so8173142pab.9
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 01:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=TNk5RNMHNeT6KhZsTiLinh3qTBZ/uHSqxNdlYVkyaek=;
        b=aVrI85L55cFAYkLSihP1NU0veUCwHnzcVsrN0DnUPafF4Ke7wWpiIhitjMEnMmVOsr
         Ep0TFFR0UXvoJczOve/aswPfQfnBJ3G6w7K3HrNfMGzzIk5A9m+e+TpBzCEauJepjr0j
         Vch8kTRMfM9KwJW4boDsf87QSay1GdYuBzhsz0FIRMSWosJH4gsuakK2K1/faTCmSbEN
         zzIfOG+9AedhuEFStjV6M66nBZSsFYFNB/8RK6e5P4VMuHuOvcKc0VkdbMvjkhqzh8SB
         pUYQyxF9bu7N3+1S63U2bxU29UrIo2MwVYTiqMDJvYCNnREr9mPHX6594lQCKoaIRkA6
         mDSQ==
X-Received: by 10.70.36.162 with SMTP id r2mr22351545pdj.97.1409387721511;
        Sat, 30 Aug 2014 01:35:21 -0700 (PDT)
Received: from lanh ([115.73.195.142])
        by mx.google.com with ESMTPSA id ga1sm2058385pbd.78.2014.08.30.01.35.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Aug 2014 01:35:20 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 30 Aug 2014 15:35:30 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256225>

If the file "$GIT_DIR/commondir" exists, it contains the value of
$GIT_COMMON_DIR.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/gitrepository-layout.txt |  7 ++++++
 setup.c                                | 43 ++++++++++++++++++++++++++=
+++-----
 2 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/Documentation/gitrepository-layout.txt b/Documentation/git=
repository-layout.txt
index b88ac65..58d1087 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -236,6 +236,13 @@ shallow::
 	file is ignored if $GIT_COMMON_DIR is set and
 	"$GIT_COMMON_DIR/shallow" will be used instead.
=20
+commondir::
+	If this file exists, $GIT_COMMON_DIR (see linkgit:git[1]) will
+	be set to the path specified in this file if it is not
+	explicitly set. If the specified path is relative, it is
+	relative to $GIT_DIR. The repository with commondir is
+	incomplete without the repository pointed by "commondir".
+
 modules::
 	Contains the git-repositories of the submodules. This
 	directory is ignored if $GIT_COMMON_DIR is set and
diff --git a/setup.c b/setup.c
index 425fd79..176d505 100644
--- a/setup.c
+++ b/setup.c
@@ -224,6 +224,33 @@ void verify_non_filename(const char *prefix, const=
 char *arg)
 	    "'git <command> [<revision>...] -- [<file>...]'", arg);
 }
=20
+static void get_common_dir(struct strbuf *sb, const char *gitdir)
+{
+	struct strbuf data =3D STRBUF_INIT;
+	struct strbuf path =3D STRBUF_INIT;
+	const char *git_common_dir =3D getenv(GIT_COMMON_DIR_ENVIRONMENT);
+	if (git_common_dir) {
+		strbuf_addstr(sb, git_common_dir);
+		return;
+	}
+	strbuf_addf(&path, "%s/commondir", gitdir);
+	if (file_exists(path.buf)) {
+		if (strbuf_read_file(&data, path.buf, 0) <=3D 0)
+			die_errno(_("failed to read %s"), path.buf);
+		while (data.len && (data.buf[data.len - 1] =3D=3D '\n' ||
+				    data.buf[data.len - 1] =3D=3D '\r'))
+			data.len--;
+		data.buf[data.len] =3D '\0';
+		strbuf_reset(&path);
+		if (!is_absolute_path(data.buf))
+			strbuf_addf(&path, "%s/", gitdir);
+		strbuf_addbuf(&path, &data);
+		strbuf_addstr(sb, real_path(path.buf));
+	} else
+		strbuf_addstr(sb, gitdir);
+	strbuf_release(&data);
+	strbuf_release(&path);
+}
=20
 /*
  * Test if it looks like we're at a git directory.
@@ -242,13 +269,22 @@ int is_git_directory(const char *suspect)
 	int ret =3D 0;
 	size_t len;
=20
-	strbuf_addstr(&path, suspect);
+	/* Check worktree-related signatures */
+	strbuf_addf(&path, "%s/HEAD", suspect);
+	if (validate_headref(path.buf))
+		goto done;
+
+	strbuf_reset(&path);
+	get_common_dir(&path, suspect);
 	len =3D path.len;
+
+	/* Check non-worktree-related signatures */
 	if (getenv(DB_ENVIRONMENT)) {
 		if (access(getenv(DB_ENVIRONMENT), X_OK))
 			goto done;
 	}
 	else {
+		strbuf_setlen(&path, len);
 		strbuf_addstr(&path, "/objects");
 		if (access(path.buf, X_OK))
 			goto done;
@@ -259,11 +295,6 @@ int is_git_directory(const char *suspect)
 	if (access(path.buf, X_OK))
 		goto done;
=20
-	strbuf_setlen(&path, len);
-	strbuf_addstr(&path, "/HEAD");
-	if (validate_headref(path.buf))
-		goto done;
-
 	ret =3D 1;
 done:
 	strbuf_release(&path);
--=20
2.1.0.rc0.78.gc0d8480
