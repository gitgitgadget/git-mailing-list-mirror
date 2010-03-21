From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 15/19] builtins: utilize startup_info->help where possible
Date: Sun, 21 Mar 2010 17:30:42 +0700
Message-ID: <1269167446-7799-16-git-send-email-pclouds@gmail.com>
References: <1269167446-7799-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 21 11:36:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtIVs-0003ig-VV
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 11:36:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255Ab0CUKgD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Mar 2010 06:36:03 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42974 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223Ab0CUKgA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 06:36:00 -0400
Received: by gyg8 with SMTP id 8so2223660gyg.19
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 03:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=YnlozICI8QmwgoDDNieXO2k6PlmNCSC5o3yQQ+qg0SI=;
        b=cdOJJ8oeTZsAFH2uHaWhFwhDk8ljxAmbNaK7VJVgTYa7PIfJ1qULuqVYyVzswq4fbO
         ebFih8VfjZerXFMW6x+1Xf2Hq1buS7JTi81UFwWAdZYKOKQBIq+HQERBzMeZErEoA6ha
         BMkwV3/a5ry3kJc+JPThJfEzSWl3UzTyZlfkM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ZhJRDxl+vM5pfazLzLc73m+oqNYgfDjcZNzdCaTuFkrahRwzblz4xS7Bs0G1vHWs/l
         Ylg7I2UaePkO+uzv4B+Mw+lObzAAj5C2AsVHPOfp8WUBPzEh2jt4hQ9BxlO1DRMRmRf7
         ZS136fPfopoLNVZ5B6pX6HWHnUvCHoG2eXRo8=
Received: by 10.151.117.1 with SMTP id u1mr1139197ybm.200.1269167759487;
        Sun, 21 Mar 2010 03:35:59 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.230.17])
        by mx.google.com with ESMTPS id 21sm2426047iwn.11.2010.03.21.03.35.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Mar 2010 03:35:58 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 21 Mar 2010 17:32:17 +0700
X-Mailer: git-send-email 1.7.0.2.425.gb99f1
In-Reply-To: <1269167446-7799-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142811>

It helps reduce false alarms while I'm looking for "git foo -h" code
path that accesses repository. Anyway it looks like a good thing to
do.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/check-ref-format.c |    2 +-
 builtin/grep.c             |    2 +-
 builtin/index-pack.c       |    2 +-
 builtin/log.c              |    7 ++-----
 builtin/merge-ours.c       |    2 +-
 builtin/pack-redundant.c   |    2 +-
 builtin/show-ref.c         |    2 +-
 7 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index b106c65..c13f90a 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -35,7 +35,7 @@ static void collapse_slashes(char *dst, const char *s=
rc)
=20
 int cmd_check_ref_format(int argc, const char **argv, const char *pref=
ix)
 {
-	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
+	if (startup_info->help)
 		usage(builtin_check_ref_format_usage);
=20
 	if (argc =3D=3D 3 && !strcmp(argv[1], "--branch")) {
diff --git a/builtin/grep.c b/builtin/grep.c
index fb82ff8..a7bdd7b 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -857,7 +857,7 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 	 * 'git grep -h', unlike 'git grep -h <pattern>', is a request
 	 * to show usage information and exit.
 	 */
-	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
+	if (startup_info->help)
 		usage_with_options(grep_usage, options);
=20
 	memset(&opt, 0, sizeof(opt));
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 9aa6a13..44375a2 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -880,7 +880,7 @@ int cmd_index_pack(int argc, const char **argv, con=
st char *prefix)
 	struct pack_idx_entry **idx_objects;
 	unsigned char pack_sha1[20];
=20
-	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
+	if (startup_info->help)
 		usage(index_pack_usage);
=20
 	/*
diff --git a/builtin/log.c b/builtin/log.c
index e0d5caa..382d4a3 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -50,12 +50,9 @@ static void cmd_log_init(int argc, const char **argv=
, const char *prefix,
 	if (default_date_mode)
 		rev->date_mode =3D parse_date_format(default_date_mode);
=20
-	/*
-	 * Check for -h before setup_revisions(), or "git log -h" will
-	 * fail when run without a git directory.
-	 */
-	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
+	if (startup_info->help)
 		usage(builtin_log_usage);
+
 	argc =3D setup_revisions(argc, argv, rev, "HEAD");
=20
 	if (!rev->show_notes_given && !rev->pretty_given)
diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
index 6844116..8e0777b 100644
--- a/builtin/merge-ours.c
+++ b/builtin/merge-ours.c
@@ -20,7 +20,7 @@ static const char *diff_index_args[] =3D {
=20
 int cmd_merge_ours(int argc, const char **argv, const char *prefix)
 {
-	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
+	if (startup_info->help)
 		usage(builtin_merge_ours_usage);
=20
 	/*
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 41e1615..3f090b2 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -601,7 +601,7 @@ int cmd_pack_redundant(int argc, const char **argv,=
 const char *prefix)
 	unsigned char *sha1;
 	char buf[42]; /* 40 byte sha1 + \n + \0 */
=20
-	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
+	if (startup_info->help)
 		usage(pack_redundant_usage);
=20
 	for (i =3D 1; i < argc; i++) {
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 17ada88..59f90df 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -204,7 +204,7 @@ static const struct option show_ref_options[] =3D {
=20
 int cmd_show_ref(int argc, const char **argv, const char *prefix)
 {
-	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
+	if (startup_info->help)
 		usage_with_options(show_ref_usage, show_ref_options);
=20
 	argc =3D parse_options(argc, argv, prefix, show_ref_options,
--=20
1.7.0.2.425.gb99f1
