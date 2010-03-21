From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 16/19] builtins: check for startup_info->help, print and exit early
Date: Sun, 21 Mar 2010 17:30:43 +0700
Message-ID: <1269167446-7799-17-git-send-email-pclouds@gmail.com>
References: <1269167446-7799-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 21 11:36:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtIWF-0003rh-5j
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 11:36:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753290Ab0CUKgX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Mar 2010 06:36:23 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42974 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108Ab0CUKgW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 06:36:22 -0400
Received: by mail-gy0-f174.google.com with SMTP id 8so2223660gyg.19
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 03:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=5r1RChsBPIbjMRy8JE4/pUfj7N5y6zSLhoF5sSJexwE=;
        b=EJtrIdjYArJv1G3JMdPD6ZBbYAvsYN672nImkr3pin7wPbru+WN4GDQK4qPOyH+abb
         fqjxKI5D2+OIm4VpJlq7uKgTcffURNW0apWMNiY9a0M/5qy1F25gLJNTqSbZFILewgz5
         tszL6vZY+AsJNW1DAb8pyCFkIkEbT+OOS0nSg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ZqGzCnNM6f7OgxQUoM+VbR9T8BAU9ymArEM6Ubbplnod4KUp2xrAgd1oXrqXqVUrVI
         fk57bS5E5OAv2qTa20wSs5+h6pDnP98QAwjpeTmQ+7cnM7Ok03UGugizW7oUJ74Xeqo8
         Wxs9F61JyGWA4ZcTkpzNlpJAbK98vNI9EMAnA=
Received: by 10.100.27.9 with SMTP id a9mr12761825ana.0.1269167766021;
        Sun, 21 Mar 2010 03:36:06 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.230.17])
        by mx.google.com with ESMTPS id 23sm3351037iwn.6.2010.03.21.03.36.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Mar 2010 03:36:05 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 21 Mar 2010 17:32:24 +0700
X-Mailer: git-send-email 1.7.0.2.425.gb99f1
In-Reply-To: <1269167446-7799-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142814>

These commands need more than just git_config() before parsing
commmand line arguments. Some of these activities will unconditionally
look into a repository. When startup_info->help is TRUE, no repository
is set up and the caller expects callees to print help usage and exit,
no more.

Do as expected.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/branch.c         |    3 +++
 builtin/checkout-index.c |    3 +++
 builtin/commit.c         |    6 ++++++
 builtin/gc.c             |    3 +++
 builtin/ls-files.c       |    3 +++
 builtin/merge.c          |    3 +++
 builtin/update-index.c   |    3 +++
 builtin/upload-archive.c |    7 ++++---
 8 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 6cf7e72..cc0053b 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -651,6 +651,9 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
 		OPT_END(),
 	};
=20
+	if (startup_info->help)
+		usage_with_options(builtin_branch_usage, options);
+
 	git_config(git_branch_config, NULL);
=20
 	if (branch_use_color =3D=3D -1)
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index a7a5ee1..7f25cd7 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -241,6 +241,9 @@ int cmd_checkout_index(int argc, const char **argv,=
 const char *prefix)
 		OPT_END()
 	};
=20
+	if (startup_info->help)
+		usage_with_options(builtin_checkout_index_usage, builtin_checkout_in=
dex_options);
+
 	git_config(git_default_config, NULL);
 	state.base_dir =3D "";
 	prefix_length =3D prefix ? strlen(prefix) : 0;
diff --git a/builtin/commit.c b/builtin/commit.c
index f4c7344..b1a496e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1032,6 +1032,9 @@ int cmd_status(int argc, const char **argv, const=
 char *prefix)
 		OPT_END(),
 	};
=20
+	if (startup_info->help)
+		usage_with_options(builtin_status_usage, builtin_status_options);
+
 	if (null_termination && status_format =3D=3D STATUS_FORMAT_LONG)
 		status_format =3D STATUS_FORMAT_PORCELAIN;
=20
@@ -1172,6 +1175,9 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 	int allow_fast_forward =3D 1;
 	struct wt_status s;
=20
+	if (startup_info->help)
+		usage_with_options(builtin_commit_usage, builtin_commit_options);
+
 	wt_status_prepare(&s);
 	git_config(git_commit_config, &s);
 	in_merge =3D file_exists(git_path("MERGE_HEAD"));
diff --git a/builtin/gc.c b/builtin/gc.c
index c304638..f040171 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -191,6 +191,9 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
=20
 	git_config(gc_config, NULL);
=20
+	if (startup_info->help)
+		usage_with_options(builtin_gc_usage, builtin_gc_options);
+
 	if (pack_refs < 0)
 		pack_refs =3D !is_bare_repository();
=20
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index b065061..5125560 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -518,6 +518,9 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *prefix)
 		OPT_END()
 	};
=20
+	if (startup_info->help)
+		usage_with_options(ls_files_usage, builtin_ls_files_options);
+
 	memset(&dir, 0, sizeof(dir));
 	if (prefix)
 		prefix_offset =3D strlen(prefix);
diff --git a/builtin/merge.c b/builtin/merge.c
index 3aaec7b..11fadac 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -886,6 +886,9 @@ int cmd_merge(int argc, const char **argv, const ch=
ar *prefix)
 	const char *best_strategy =3D NULL, *wt_strategy =3D NULL;
 	struct commit_list **remotes =3D &remoteheads;
=20
+	if (startup_info->help)
+		usage_with_options(builtin_merge_usage, builtin_merge_options);
+
 	if (read_cache_unmerged()) {
 		die_resolve_conflict("merge");
 	}
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 3ab214d..46a53f5 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -589,6 +589,9 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
 	int lock_error =3D 0;
 	struct lock_file *lock_file;
=20
+	if (startup_info->help)
+		usage(update_index_usage);
+
 	git_config(git_default_config, NULL);
=20
 	/* We can't free this memory, it becomes part of a linked list parsed=
 atexit() */
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 73f788e..d4f4741 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -26,9 +26,6 @@ static int run_upload_archive(int argc, const char **=
argv, const char *prefix)
 	int sent_argc;
 	int len;
=20
-	if (argc !=3D 2)
-		usage(upload_archive_usage);
-
 	if (strlen(argv[1]) + 1 > sizeof(buf))
 		die("insanely long repository name");
=20
@@ -98,6 +95,10 @@ int cmd_upload_archive(int argc, const char **argv, =
const char *prefix)
 {
 	pid_t writer;
 	int fd1[2], fd2[2];
+
+	if (startup_info->help || argc !=3D 2)
+		usage(upload_archive_usage);
+
 	/*
 	 * Set up sideband subprocess.
 	 *
--=20
1.7.0.2.425.gb99f1
