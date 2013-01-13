From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP 10/10] Enable ls-files and ls-tree for testing PATHSPEC_ICASE
Date: Sun, 13 Jan 2013 19:49:39 +0700
Message-ID: <1358081379-17752-11-git-send-email-pclouds@gmail.com>
References: <1358081379-17752-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:51:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuN1d-0001U2-PS
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:50:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755019Ab3AMMuh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:50:37 -0500
Received: from mail-pb0-f43.google.com ([209.85.160.43]:44895 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754991Ab3AMMug (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:50:36 -0500
Received: by mail-pb0-f43.google.com with SMTP id um15so1706507pbc.30
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=pzH4E33HI2gcvD3vD7VpME7cTdtIouDL2UsLjXrsh2o=;
        b=KPFWRRfC0+Tw0jDDsF8c5BXjBy9YfOGwzTCcqVQjfNt0weJ0t67gq2B2sEo5pkkR6M
         /RPTGqTSUinEVwOmzjZLIHdMOwwj7Y+/3NgNGX56jQZYo30YPr5g3T1WbQuTMichplq6
         tPIkZ8CUegqBQKKkHqC2jDK/MsEPe0HY3JLs5ncUg9s+ZJG4bFoO6/+W0I1eFU62CvB3
         ejJP3vhbDFXO9DrRZMyccVgAOoDJ5GwM44ytxgHcstVfFSaRFAooatOJXEw/Oksk7P4t
         msxtcY5Iq2WiTOnzQQOkcwY8uhKzWcMnehtnEyXqZLNXIPR6aTup7Nt3aXmBGXTdn66W
         4Kew==
X-Received: by 10.68.137.131 with SMTP id qi3mr244798010pbb.114.1358081436249;
        Sun, 13 Jan 2013 04:50:36 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id s5sm6766593pay.31.2013.01.13.04.50.33
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:50:35 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:50:50 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358081379-17752-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213381>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/add.c      | 6 ++++--
 builtin/ls-files.c | 3 ++-
 builtin/ls-tree.c  | 3 ++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index a3ffa9d..b9a5432 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -421,12 +421,14 @@ int cmd_add(int argc, const char **argv, const ch=
ar *prefix)
 		GUARD_PATHSPEC(&pathspec,
 			       PATHSPEC_FROMTOP |
 			       PATHSPEC_LITERAL |
-			       PATHSPEC_GLOB);
+			       PATHSPEC_GLOB |
+			       PATHSPEC_ICASE);
=20
 		for (i =3D 0; i < pathspec.nr; i++) {
 			const char *path =3D pathspec.items[i].match;
 			if (!seen[i] &&
-			    ((pathspec.items[i].magic & PATHSPEC_GLOB) ||
+			    ((pathspec.items[i].magic &
+			      (PATHSPEC_GLOB | PATHSPEC_ICASE)) ||
 			     !file_exists(path))) {
 				if (ignore_missing) {
 					int dtype =3D DT_UNKNOWN;
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index feb4220..53b222d 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -538,7 +538,8 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 	parse_pathspec(&pathspec,
 		       PATHSPEC_FROMTOP |
 		       PATHSPEC_LITERAL |
-		       PATHSPEC_GLOB,
+		       PATHSPEC_GLOB |
+		       PATHSPEC_ICASE,
 		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
 		       prefix, argv);
=20
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 25d0590..cf943dd 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -175,7 +175,8 @@ int cmd_ls_tree(int argc, const char **argv, const =
char *prefix)
 	parse_pathspec(&pathspec,
 		       PATHSPEC_FROMTOP |
 		       PATHSPEC_LITERAL |
-		       PATHSPEC_GLOB,
+		       PATHSPEC_GLOB |
+		       PATHSPEC_ICASE,
 		       0, prefix, argv + 1);
 	for (i =3D 0; i < pathspec.nr; i++)
 		pathspec.items[i].nowildcard_len =3D pathspec.items[i].len;
--=20
1.8.0.rc2.23.g1fb49df
