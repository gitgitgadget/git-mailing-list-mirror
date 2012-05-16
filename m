From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 4/5] gc: add --dry-run
Date: Wed, 16 May 2012 19:29:36 +0700
Message-ID: <1337171377-26960-5-git-send-email-pclouds@gmail.com>
References: <1336810134-3103-1-git-send-email-pclouds@gmail.com>
 <1337171377-26960-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Nicolas Pitre <nico@fluxnic.net>,
	Fernando Vezzosi <buccia@repnz.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 16 14:34:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUdQp-0002r1-AI
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 14:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933037Ab2EPMeN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 May 2012 08:34:13 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45919 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932118Ab2EPMeM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2012 08:34:12 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so927067dad.19
        for <git@vger.kernel.org>; Wed, 16 May 2012 05:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=oWT9DM0ieh4wNIUPMjmVvZCYqLxyjDNgV0IPuWWMd/0=;
        b=HPeNOTYpP+khyOCaTsyEBYZXzdh6WzJL6We/L+11nEqWFhfo34k+hAsUYNxxWUE5Zm
         cdMzsPsDOAwJ2ZsecAlq2qINsuc0BCDl7QPpxDl/Xx6bB8+N0rbgqffVh5Oty3tQJNVs
         u03l1Kj5nIbqO6M4Hww5tZBcFPeQ9+aRGLfPs2/gMuM8KJwm96Mc7U6hjpdakP/PCFJg
         Ed5B00BCDvfD5FaX8HCwfV8hYW4ppSDbAinLinOyWX6ukJTq4ON7lXuTuRdRot8y0lWS
         3NGlRPdMzJFu500qTWvTv0p1uXfv8jD6YGm0n38jbaboJ++R1uPtubTFwEhaWnv18RGq
         Y5QQ==
Received: by 10.68.228.106 with SMTP id sh10mr6692669pbc.107.1337171651761;
        Wed, 16 May 2012 05:34:11 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.61.104])
        by mx.google.com with ESMTPS id oy8sm5331034pbc.52.2012.05.16.05.34.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 May 2012 05:34:10 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 16 May 2012 19:30:20 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1337171377-26960-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197877>

"git gc --auto --dry-run" will print instead of doing
housekeeping. This option is to be called by other commands rather
than by user and will not print more than one warning every hour. gc()
function also behaves this way.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-gc.txt |    7 ++++++-
 builtin/gc.c             |   19 +++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index b370b02..f69f5e1 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -9,7 +9,7 @@ git-gc - Cleanup unnecessary files and optimize the loc=
al repository
 SYNOPSIS
 --------
 [verse]
-'git gc' [--aggressive] [--auto] [--quiet] [--prune=3D<date> | --no-pr=
une]
+'git gc' [--aggressive] [--auto [--dry-run]] [--quiet] [--prune=3D<dat=
e> | --no-prune]
=20
 DESCRIPTION
 -----------
@@ -60,6 +60,11 @@ are consolidated into a single pack by using the `-A=
` option of
 'git repack'. Setting `gc.autopacklimit` to 0 disables
 automatic consolidation of packs.
=20
+--dry-run::
+	Only show warning if housekeeping is required. The warning
+	is only shown at most once every hour even if
+	"gc --auto --dry-run" is run continuously.
+
 --prune=3D<date>::
 	Prune loose objects older than date (default is 2 weeks ago,
 	overridable by the config variable `gc.pruneExpire`).  This
diff --git a/builtin/gc.c b/builtin/gc.c
index ce60225..f82b9ef 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -150,6 +150,8 @@ static void add_repack_all_option(void)
=20
 static int need_to_gc(void)
 {
+	struct stat st;
+
 	/*
 	 * Setting gc.auto to 0 or negative can disable the
 	 * automatic gc.
@@ -168,6 +170,13 @@ static int need_to_gc(void)
 	else if (!too_many_loose_objects())
 		return 0;
=20
+	if (stat(git_path("gc_needed"), &st))
+		open(git_path("gc_needed"), O_CREAT | O_RDWR, 0644);
+	else if (time(NULL) - st.st_mtime < 3600)
+		return 0;
+	else
+		utime(git_path("gc_needed"), NULL);
+
 	return 1;
 }
=20
@@ -190,6 +199,7 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
 {
 	int aggressive =3D 0;
 	int auto_gc =3D 0;
+	int check_gc =3D 0;
 	int quiet =3D 0;
=20
 	struct option builtin_gc_options[] =3D {
@@ -199,12 +209,16 @@ int cmd_gc(int argc, const char **argv, const cha=
r *prefix)
 			PARSE_OPT_OPTARG, NULL, (intptr_t)prune_expire },
 		OPT_BOOLEAN(0, "aggressive", &aggressive, "be more thorough (increas=
ed runtime)"),
 		OPT_BOOLEAN(0, "auto", &auto_gc, "enable auto-gc mode"),
+		OPT_BOOLEAN(0, "dry-run", &check_gc, "warn if auto gc is needed"),
 		OPT_END()
 	};
=20
 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_gc_usage, builtin_gc_options);
=20
+	if (!auto_gc && check_gc)
+		die(_("--dry-run is useless without --auto"));
+
 	argv_array_pushl(&pack_refs_cmd, "pack-refs", "--all", "--prune", NUL=
L);
 	argv_array_pushl(&reflog, "reflog", "expire", "--all", NULL);
 	argv_array_pushl(&repack, "repack", "-d", "-l", NULL);
@@ -240,6 +254,11 @@ int cmd_gc(int argc, const char **argv, const char=
 *prefix)
 		if (run_hook(NULL, "pre-auto-gc", NULL))
 			return 0;
=20
+		if (check_gc) {
+			warning(_("This repository needs maintenance. "
+				  "Please run \"git gc\" as soon as possible."));
+			return 0;
+		}
 		if (quiet)
 			fprintf(stderr, _("Auto packing the repository for optimum performa=
nce.\n"));
 		else
--=20
1.7.8.36.g69ee2
