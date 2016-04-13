From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/25] worktree.c: add validate_worktree()
Date: Wed, 13 Apr 2016 20:15:37 +0700
Message-ID: <1460553346-12985-17-git-send-email-pclouds@gmail.com>
References: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 15:17:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKfj-0004bM-4U
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 15:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760659AbcDMNRR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 09:17:17 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35121 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756725AbcDMNRP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 09:17:15 -0400
Received: by mail-pf0-f193.google.com with SMTP id r187so4128109pfr.2
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 06:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KtajZeNW0kcqXw18/ruaLc3vXuxhBIsxO6ENnuIi8a0=;
        b=rc4LNDGhIAe3W2hWSeUIvyLFdUFcRRc6hKNq3FZrGzgohJhAxiXoWh1sLQVapzMlLG
         fbTYvEGj3Zs0heKjvhfW8w9mCctrT8soaCANqyJeRvpLtywYsoqd1tLQ1bDu++Eujmi8
         KtW3VQYZnNhjYySudm4VvgldPP+13FCp8AmP7P1FflhGAwLZGog691SGHON2oG68AUlg
         hQscu+3x+u8BIGt3nLIP6+yhvyfFqq84aCUNdvMMZSxB8G3ye8qS6GxB/l1Agoguj3NI
         jHvB2Lbu4CJk3+5IFbKlq1WtRzNCDvwC2dhhapntfE6Nj1RAYILdc1TyZfXdDLTlUBW7
         yK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KtajZeNW0kcqXw18/ruaLc3vXuxhBIsxO6ENnuIi8a0=;
        b=EVUc9nP5Ys5Y6idAgCB+IDKz9tOKXqs6LbikKEG07S9Wfr1XVwfiPOHtTAFsn36wbB
         UZ8Ta1EoxDv0y9uHS7oL6crcIGP762pDag6EfR+Ew/OU+4LerAOAItteemPukKsHtpgV
         m8D9nfWHXBpYwssHuQ+PXhYR3FsQXqOm3TnR0hCX5p96LZ4I3lhs+iqMxND6J/JuinB5
         Oek4/YnYUh/v9hk54EbaknC/8XDPeolT+LuEjccldgL2N0fm5XDcc8/9HAY0iil7fZqC
         E+hYWIncda4jOIaKp6q07Q/ihAx4V29CMfU+oo/8jyy7ojpVuG/jaE6NJODG0UXUtegJ
         oIbQ==
X-Gm-Message-State: AOPr4FWf6QrrzEn4jw5ldH0Z55UieZBxPO7ufQrvEL6C7imxOoO9MWV6ODjW07xuJXVW6w==
X-Received: by 10.98.17.78 with SMTP id z75mr13030614pfi.40.1460553435052;
        Wed, 13 Apr 2016 06:17:15 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id to9sm51311657pab.27.2016.04.13.06.17.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 06:17:13 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 20:17:21 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291438>

This function is later used by "worktree move" and "worktree remove"
to ensure that we have a good connection between the repository and
the worktree.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 worktree.h |  5 +++++
 2 files changed, 68 insertions(+)

diff --git a/worktree.c b/worktree.c
index e878f49..28195b1 100644
--- a/worktree.c
+++ b/worktree.c
@@ -219,6 +219,69 @@ int is_main_worktree(const struct worktree *wt)
 	return wt && !wt->id;
 }
=20
+static int report(int quiet, const char *fmt, ...)
+{
+	va_list params;
+
+	if (quiet)
+		return -1;
+
+	va_start(params, fmt);
+	vfprintf(stderr, fmt, params);
+	fputc('\n', stderr);
+	va_end(params);
+	return -1;
+}
+
+int validate_worktree(const struct worktree *wt, int quiet)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	const char *path;
+	int err;
+
+	if (is_main_worktree(wt)) {
+		/*
+		 * Main worktree using .git file to point to the
+		 * repository would make it impossible to know where
+		 * the actual worktree is if this function is executed
+		 * from another worktree. No .git file support for now.
+		 */
+		strbuf_addf(&sb, "%s/.git", wt->path);
+		if (!is_directory(sb.buf)) {
+			strbuf_release(&sb);
+			return report(quiet, _("'%s/.git' at main worktree is not the repos=
itory directory"),
+				      wt->path);
+		}
+		return 0;
+	}
+
+	/*
+	 * Make sure "gitdir" file points to a real .git file and that
+	 * file points back here.
+	 */
+	if (!is_absolute_path(wt->path))
+		return report(quiet, _("'%s' file does not contain absolute path to =
the worktree location"),
+			      git_common_path("worktrees/%s/gitdir", wt->id));
+
+	strbuf_addf(&sb, "%s/.git", wt->path);
+	if (!file_exists(sb.buf)) {
+		strbuf_release(&sb);
+		return report(quiet, _("'%s/.git' does not exist"), wt->path);
+	}
+
+	path =3D read_gitfile_gently(sb.buf, &err);
+	strbuf_release(&sb);
+	if (!path)
+		return report(quiet, _("'%s/.git' is not a .git file, error code %d"=
),
+			      wt->path, err);
+
+	if (strcmp_icase(path, real_path(git_common_path("worktrees/%s", wt->=
id))))
+		return report(quiet, _("'%s' does not point back to"),
+			      wt->path, git_common_path("worktrees/%s", wt->id));
+
+	return 0;
+}
+
 char *find_shared_symref(const char *symref, const char *target)
 {
 	char *existing =3D NULL;
diff --git a/worktree.h b/worktree.h
index c7a4d20..0d6be18 100644
--- a/worktree.h
+++ b/worktree.h
@@ -39,6 +39,11 @@ extern struct worktree *find_worktree_by_path(struct=
 worktree **list,
 extern int is_main_worktree(const struct worktree *wt);
=20
 /*
+ * Return zero if the worktree is in good condition.
+ */
+extern int validate_worktree(const struct worktree *wt, int quiet);
+
+/*
  * Free up the memory for worktree
  */
 extern void clear_worktree(struct worktree *);
--=20
2.8.0.rc0.210.gd302cd2
