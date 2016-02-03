From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/20] worktree.c: add collect_per_worktree_git_paths()
Date: Wed,  3 Feb 2016 16:35:44 +0700
Message-ID: <1454492150-10628-15-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 10:37:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQtsH-0006DW-DH
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 10:37:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753487AbcBCJhP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2016 04:37:15 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35114 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753433AbcBCJhM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 04:37:12 -0500
Received: by mail-pa0-f48.google.com with SMTP id ho8so10763216pac.2
        for <git@vger.kernel.org>; Wed, 03 Feb 2016 01:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=AnRbssd7YktsuohbKsXTlQZMlj3BVyXLXjTbilsCePQ=;
        b=sJOEBfQyITKXdR2F3x0cV8q8xhKrH0fGZ5CHHr0Cg9UoLRC5wXsokqiTXVBGjFyOSG
         Oq7zy/XB/NvG9q+Pn0jtIbI43hQhNiFDk5ZlkjMH3TDidNm2ivK3F1bNxDoo4OYFNWVn
         LoKOzKwpxY7ApOMHHUNQ+yBxqdYP/3bm4g5nlE85tCNjtPNRssMnlVvtnC/khxrRJU0u
         vILpxgj8qZyISqmfTPljXvyIr3/sLb2pWFieZtAmJy6Vf7DhBBBI9IBNkpQqx26CRALe
         lCY+wjuHIULXm1TI3TDWq0trW5UnK2Qk0ZfD4o+OfuxkhBDEKNeEixjosXs44SsBfAwG
         Si5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=AnRbssd7YktsuohbKsXTlQZMlj3BVyXLXjTbilsCePQ=;
        b=UeMpzJmdHDJW44flgZkY4pZ9udZaT4aumV2LE8kytE106d6H6+z9D4c5ekA5ZKMFsT
         1R+VNJimo+BaJuCdWgq45Tqhg1qdxN4uI2HXWMMgb5vtBXMhT0470Yf3lmuiBPuzOWKL
         mEbBOHoS8A7X4hFsSMKzurQKev9O4gjCjXH2LcCfIiHtVCmWyd3nH6nW/tohfsQCmDEV
         61qpUz7ESqThKad/MoEn/7deJpN/9Z0t6yTwC+ipD4Ek+u8m1AxX/7c4DVJ1TLcdqTAc
         bG3lBndfTDBEh7VS+ZoirsrgbCdXL3DRGv4aGpdDOjF3CYh8U97Z0yxatMNlD3lh8q3+
         dyPg==
X-Gm-Message-State: AG10YORv4vjIn1XgpgQ2uiaXA/bGTxwf39XccJIBiweIEA2KE9YnGpqzVN7m+gMEHM40Dg==
X-Received: by 10.66.139.166 with SMTP id qz6mr710825pab.148.1454492231841;
        Wed, 03 Feb 2016 01:37:11 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id v66sm3430473pfi.56.2016.02.03.01.37.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2016 01:37:10 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 03 Feb 2016 16:37:23 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285359>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 worktree.h |  6 ++++++
 2 files changed, 64 insertions(+)

diff --git a/worktree.c b/worktree.c
index d4513b1..047319b 100644
--- a/worktree.c
+++ b/worktree.c
@@ -257,6 +257,64 @@ int update_worktree_gitfile(const char *gitfile,
 	return 0;
 }
=20
+static int collect_per_worktree_1(struct strbuf *base, int commonlen,
+				  struct string_list *paths)
+{
+	int base_len =3D base->len;
+	struct dirent *d;
+	DIR *dir;
+	int ret =3D 0;
+
+	dir =3D opendir(base->buf);
+	if (!dir)
+		return sys_error(_("failed to open '%s'"), base->buf);
+
+	while ((d =3D readdir(dir))) {
+		struct stat st;
+
+		if (is_dot_or_dotdot(d->d_name))
+			continue;
+
+		strbuf_setlen(base, base_len);
+		strbuf_addstr(base, d->d_name);
+
+		if (stat(base->buf, &st)) {
+			if (errno =3D=3D ENOENT)
+				continue;
+			ret =3D sys_error(_("failed to stat '%s'"), base->buf);
+			break;
+		}
+		if (!S_ISDIR(st.st_mode)) {
+			const char *path =3D base->buf + commonlen;
+			if (!is_git_path_shared(path))
+				string_list_append(paths, path);
+			continue;
+		}
+
+		strbuf_addch(base, '/');
+		if ((ret =3D collect_per_worktree_1(base, commonlen, paths)))
+			break;
+	}
+	closedir(dir);
+	return ret;
+}
+
+int collect_per_worktree_git_paths(struct string_list *paths)
+{
+	struct strbuf base =3D STRBUF_INIT;
+	int ret;
+
+	/* force adjust_git_path() to always adjust paths */
+	git_common_dir_env =3D 1;
+
+	strbuf_addstr(&base, get_git_common_dir());
+	if (base.len && base.buf[base.len - 1] !=3D '/')
+		strbuf_addch(&base, '/');
+	ret =3D collect_per_worktree_1(&base, base.len, paths);
+	strbuf_release(&base);
+	return ret;
+}
+
 char *find_shared_symref(const char *symref, const char *target)
 {
 	char *existing =3D NULL;
diff --git a/worktree.h b/worktree.h
index 55f3449..8da1a13 100644
--- a/worktree.h
+++ b/worktree.h
@@ -52,6 +52,12 @@ extern int update_worktree_gitfile(const char *gitfi=
le,
 				   const char *id);
=20
 /*
+ * Given .git directory in "base", search all paths, collect the list
+ * of paths that are not shared in "paths".
+ */
+extern int collect_per_worktree_git_paths(struct string_list *paths);
+
+/*
  * Free up the memory for worktree
  */
 extern void clear_worktree(struct worktree *);
--=20
2.7.0.377.g4cd97dd
