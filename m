From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 17/26] worktree.c: add validate_worktree()
Date: Tue, 16 Feb 2016 20:29:18 +0700
Message-ID: <1455629367-26193-18-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
 <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 14:31:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfiW-0003Sz-9z
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:31:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbcBPNa5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 08:30:57 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34456 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932384AbcBPNaz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 08:30:55 -0500
Received: by mail-pa0-f43.google.com with SMTP id fy10so64111170pac.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 05:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Ly4ewBI4BsmDqwJLXQ6kBZWOpXGSOX8BhwTg9gGUPX0=;
        b=NHltgionif6Jb/kcwXMED/AEkMKtq5AMIMX61XrrT8iYS9UyhcA3xSRsTPxGecExc6
         ivyIbNfr2VLLzR26ORdcKi6KSGK2Bb45gJ+usiyQl+6x6KMYgiaBc0xsUB86uC3/ECZs
         qxLl2Mn7vIxpXIBZrabt6OFPw780fgZOsHtqDvz8ohVPV98dV5nZgnKZ3WUkODGWqHGk
         4Fsf22Dxn/n2m8p6qpmtwN8g8lq/jV1cRIoog3LoEOYRUfBKF73DY28hGrdVEl8/9Ynj
         Ow+VwA46xw1mk1fbWmP3ziPF8yh5kfMi8zO/ok7wigzxP7qwyxFP1UTjXAw7v2iT24gx
         g2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=Ly4ewBI4BsmDqwJLXQ6kBZWOpXGSOX8BhwTg9gGUPX0=;
        b=Gz6w9mu5vQi9BT9893NZHOBkiX4z4iFKUsp7L0OM4sHnAz2rpe4Vh/4sjiloNmCYXe
         xjVfolDDcF+KnT7Q2FuxTZTlAJ5AgyO51r6FAdOM+6SGvn6Djs9JFvVYEjoZ7drjP1AC
         52Vx5s1qunM7zXC1PUxg6PnwHSH3QFcfYH3SOl4u416+OM7N6/moccAHiF4+TvWiogjh
         PSSMbwqq7lsQ+a3k/FH+LWDfIdIdZr7DtuKz0nm2JriCGpkE0nLIyTmhNxxlCYH57YTN
         zYe7phXXe8DAx5Nxrznyp5E7zgwBkqZAeQIuCiQgEACbcV1JbEW4P0/Rc8Q9hti17BNP
         Y4DQ==
X-Gm-Message-State: AG10YOSikmNMrJ+GawaxR3TI68jpOUOPS8RRMYugWacs+UfRSOkxCqABb/PogMt2qNbn+w==
X-Received: by 10.66.55.73 with SMTP id q9mr30969284pap.50.1455629455035;
        Tue, 16 Feb 2016 05:30:55 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id k65sm46005554pfb.30.2016.02.16.05.30.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 05:30:53 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 16 Feb 2016 20:31:18 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286384>

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
2.7.0.377.g4cd97dd
