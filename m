From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/16] list-files: add --max-depth and -R
Date: Mon,  9 Mar 2015 17:18:24 +0700
Message-ID: <1425896314-10941-7-git-send-email-pclouds@gmail.com>
References: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@drmicha.warpmail.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 09 11:19:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUumm-00023S-EJ
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 11:19:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbbCIKTc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2015 06:19:32 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35484 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932181AbbCIKT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 06:19:29 -0400
Received: by pabli10 with SMTP id li10so71734036pab.2
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 03:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=WLRQNH0GoivNC8BgPL3huTJPhaGAZGctGOTcBFAqVpQ=;
        b=BAuC4mHy+PKmGCwZA3TPER2wM9mKMEFR9iUMuDtan5ENunw2EkKV9/7iuXIJadtKPJ
         uTvBKuUGjzOZLuNtG71R5FnHu5QGWaquQ+ciPUE9H6wpSHSaWaXfNd4RxxPbbkFzWolG
         34wzQ6WoA4pG+FzyXHcRLJNnFcN4xdfiw+760J/vxIvoWndXVhpMHUJU/qRdmmLswq0d
         yvXa1rKdo4p7XBNLYzGL2m/yTznwPAYHveStqBN3xAs7RTIfPaqJ/u/ADdvafa7nM927
         uWA1Rxdt4Ncxxiwvpznwkwu7v2EPB35+Pj6msjM0AIXHGNC7eOvvWTNd+6umtN/xu9FY
         679g==
X-Received: by 10.70.55.65 with SMTP id q1mr13140572pdp.35.1425896368420;
        Mon, 09 Mar 2015 03:19:28 -0700 (PDT)
Received: from lanh ([115.73.245.123])
        by mx.google.com with ESMTPSA id 7sm10863255pdj.16.2015.03.09.03.19.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2015 03:19:27 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 09 Mar 2015 17:19:24 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265148>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/list-files.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/list-files.c b/builtin/list-files.c
index 95a2e19..9a55ea6 100644
--- a/builtin/list-files.c
+++ b/builtin/list-files.c
@@ -10,6 +10,7 @@ static struct pathspec pathspec;
 static const char *prefix;
 static int prefix_length;
 static unsigned int colopts;
+static int max_depth;
=20
 static const char * const ls_usage[] =3D {
 	N_("git list-files [options] [<pathspec>...]"),
@@ -20,6 +21,11 @@ struct option ls_options[] =3D {
 	OPT_COLUMN('C', "column", &colopts, N_("show files in columns")),
 	OPT_SET_INT('1', NULL, &colopts,
 		    N_("shortcut for --no-column"), COL_PARSEOPT),
+	{ OPTION_INTEGER, 0, "max-depth", &max_depth, N_("depth"),
+	  N_("descend at most <depth> levels"), PARSE_OPT_NONEG,
+	  NULL, 1 },
+	OPT_SET_INT('R', "recursive", &max_depth,
+		    N_("shortcut for --max-depth=3D-1"), -1),
 	OPT_END()
 };
=20
@@ -134,9 +140,10 @@ int cmd_list_files(int argc, const char **argv, co=
nst char *cmd_prefix)
=20
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_CWD |
+		       (max_depth !=3D -1 ? PATHSPEC_MAXDEPTH_VALID : 0) |
 		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
 		       cmd_prefix, argv);
-	pathspec.max_depth =3D 0;
+	pathspec.max_depth =3D max_depth;
 	pathspec.recursive =3D 1;
 	finalize_colopts(&colopts, -1);
=20
--=20
2.3.0.rc1.137.g477eb31
