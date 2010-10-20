From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 4/4] builtins: check for startup_info->help, print and exit early
Date: Wed, 20 Oct 2010 10:12:00 +0700
Message-ID: <1287544320-8499-4-git-send-email-pclouds@gmail.com>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 20 05:12:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8P6Z-0007M5-QI
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 05:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757484Ab0JTDMj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Oct 2010 23:12:39 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:50920 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757327Ab0JTDMi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 23:12:38 -0400
Received: by mail-px0-f174.google.com with SMTP id 16so789834pxi.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 20:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=osnf40Bqym5nnneC8RRvku4xFojGSftMLBnvDuboOJE=;
        b=ii5lLcgySmT0Xv6/tXgcOiwafjeB/aut/39OsynFFsjgxxnCxj0hTrNKDBhYk0bATW
         BFnVpyUwfY2+b5v75mlzb6ne1Y83ILcvQdCblIYCCeEXqquzsY75PNHxpkpjLTVYAWZn
         38JCIEB/4INF3WY8i4BTJZV1M9An+bMMvnD/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=KmnajOdv8lnm7v9Bo0+VKyOXrZUxMwmCpnF8HRYmAbz1d/Y6d0tSwKa2/tQHWTnFXD
         zJd2NGWa5AcjX0k9pnCoA3wRe6IOhwD+6JLCe4U7YYQhbG/5hFIOXeGdTHZJMIlf8mQW
         SQvJUWoTamDVga65wtSolXoWz1TN1hfK48//s=
Received: by 10.142.232.20 with SMTP id e20mr5381579wfh.372.1287544358141;
        Tue, 19 Oct 2010 20:12:38 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.198.15])
        by mx.google.com with ESMTPS id e14sm19917118wfg.8.2010.10.19.20.12.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 20:12:36 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 20 Oct 2010 10:12:28 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159389>

By ensuring no access to repo is done in "git foo -h" case, the command=
s
have better chance of really printing out help usage. Access to repo is=
 not
necessary and may terminate program if it finds something wrong.

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
 t/t3905-help.sh          |   16 ++++++++--------
 9 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 87976f0..9f152ed 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -667,6 +667,9 @@ int cmd_branch(int argc, const char **argv, const c=
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
index 66fdd22..8b086f2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1070,6 +1070,9 @@ int cmd_status(int argc, const char **argv, const=
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
@@ -1255,6 +1258,9 @@ int cmd_commit(int argc, const char **argv, const=
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
index c304638..5a9d0da 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -189,6 +189,9 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
 		OPT_END()
 	};
=20
+	if (startup_info->help)
+		usage_with_options(builtin_gc_usage, builtin_gc_options);
+
 	git_config(gc_config, NULL);
=20
 	if (pack_refs < 0)
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index bb4f612..814da51 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -530,6 +530,9 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 		OPT_END()
 	};
=20
+	if (startup_info->help)
+		usage_with_options(ls_files_usage, builtin_ls_files_options);
+
 	memset(&dir, 0, sizeof(dir));
 	prefix =3D cmd_prefix;
 	if (prefix)
diff --git a/builtin/merge.c b/builtin/merge.c
index 2dba3b9..0169694 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -917,6 +917,9 @@ int cmd_merge(int argc, const char **argv, const ch=
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
diff --git a/t/t3905-help.sh b/t/t3905-help.sh
index 0dcbedf..6cab6b9 100755
--- a/t/t3905-help.sh
+++ b/t/t3905-help.sh
@@ -12,13 +12,13 @@ test_help() {
 	"
 }
=20
-test_help failure branch
-test_help failure checkout-index
-test_help failure commit
-test_help failure gc
-test_help failure ls-files
-test_help failure merge
-test_help failure update-index
-test_help failure upload-archive
+test_help success branch
+test_help success checkout-index
+test_help success commit
+test_help success gc
+test_help success ls-files
+test_help success merge
+test_help success update-index
+test_help success upload-archive
=20
 test_done
--=20
1.7.0.2.445.gcbdb3
