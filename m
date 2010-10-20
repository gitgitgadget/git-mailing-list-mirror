From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/4] builtins: utilize startup_info->help where possible
Date: Wed, 20 Oct 2010 10:11:59 +0700
Message-ID: <1287544320-8499-3-git-send-email-pclouds@gmail.com>
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
	id 1P8P6Z-0007M5-9v
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 05:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757457Ab0JTDMc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Oct 2010 23:12:32 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37959 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757327Ab0JTDMb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 23:12:31 -0400
Received: by pzk3 with SMTP id 3so591609pzk.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 20:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Cg5QmpAhhNngtX92y7zwIUwRP+X02lJHm5joaXGZUl8=;
        b=Hn+YD3odRmX4jjq1OCNFP5itKnzBnGoU+dwzwPf0CLqTfaFOmFCTsgsDSvnbMdHeKr
         vb79APICE3t7ViISnUjToATX/giaqx0Xi9bWLCCnRQWL2+RaJY/gkzqU2Klucs3zGmbP
         JnyN1HWrwYipE0tmPjM2JATHITRaNSSZLKcHg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=OmMkwyRHYiE5uqy4RnLuCq15/cvvNxzvGeYlkAX+1gbCr7XMEOWIO7UD+vwXU597xM
         +nrzTbKJdQjH4slloIs+ZozcaW2SWWLjMrD8GKAQ69Yhoj7FwkCSVVDVJhEMvkLTQqwJ
         MHcvTWVgAVAynP8fXfuSv4Aaa0eq8UlADSLv0=
Received: by 10.143.14.21 with SMTP id r21mr5369434wfi.127.1287544350825;
        Tue, 19 Oct 2010 20:12:30 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.198.15])
        by mx.google.com with ESMTPS id t38sm26354397wfc.21.2010.10.19.20.12.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 20:12:29 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 20 Oct 2010 10:12:21 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159388>

It helps reduce false alarms while I'm looking for "git foo -h" code
path that accesses repository. Anyway it looks like a good thing to
do. If one day people like to have "git foo --help" as an alternative
to "git foo -h", it would be easy.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/check-ref-format.c |    2 +-
 builtin/grep.c             |    2 +-
 builtin/index-pack.c       |    2 +-
 builtin/log.c              |    6 +-----
 builtin/merge-ours.c       |    2 +-
 builtin/pack-redundant.c   |    2 +-
 builtin/show-ref.c         |    2 +-
 7 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index ae3f281..c6511e3 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -58,7 +58,7 @@ static int check_ref_format_print(const char *arg)
=20
 int cmd_check_ref_format(int argc, const char **argv, const char *pref=
ix)
 {
-	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
+	if (startup_info->help)
 		usage(builtin_check_ref_format_usage);
=20
 	if (argc =3D=3D 3 && !strcmp(argv[1], "--branch"))
diff --git a/builtin/grep.c b/builtin/grep.c
index da32f3d..ec39909 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -934,7 +934,7 @@ int cmd_grep(int argc, const char **argv, const cha=
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
index e243d9d..649ad18 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -881,7 +881,7 @@ int cmd_index_pack(int argc, const char **argv, con=
st char *prefix)
 	struct pack_idx_entry **idx_objects;
 	unsigned char pack_sha1[20];
=20
-	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
+	if (startup_info->help)
 		usage(index_pack_usage);
=20
 	read_replace_refs =3D 0;
diff --git a/builtin/log.c b/builtin/log.c
index 22d1290..a7ba9ed 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -69,11 +69,7 @@ static void cmd_log_init(int argc, const char **argv=
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
 	argc =3D setup_revisions(argc, argv, rev, opt);
=20
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
index be9b512..7083fa9 100644
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
1.7.0.2.445.gcbdb3
