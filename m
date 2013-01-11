From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 04/21] clean: convert to use parse_pathspec
Date: Fri, 11 Jan 2013 18:20:58 +0700
Message-ID: <1357903275-16804-5-git-send-email-pclouds@gmail.com>
References: <1357903275-16804-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 12:21:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtcgD-0006XB-GI
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 12:21:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753290Ab3AKLV1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jan 2013 06:21:27 -0500
Received: from mail-pb0-f45.google.com ([209.85.160.45]:45378 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098Ab3AKLV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 06:21:26 -0500
Received: by mail-pb0-f45.google.com with SMTP id mc8so906637pbc.32
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 03:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=KyrAgOU1VovZjMHabjC9DWTlOrbp2GLiSTbi9A6INmU=;
        b=KdHnCNw3l18aj5HJgD9PUD49o+9olqs0amouUQQb25s+c4uUDGWnbefXvAR9nIVViN
         n8HZTO5FIPfqglp8JA7Njx5StgaYuOw7S5cuQPHRoa+o5KdOZJYw6T6fmnFfB2au/XP/
         4Ie5jOgSX0Dy2fJoWjAeXMTvKrbrZLsCcQaq7NHmEAGTAgqPihEaWVs+ioRU9y3voe8f
         1d1uA1s5wrDI87wNhzEMaHTrOzlv8jr4ftmIqDgZP/XKzhuk92PzDQuiQ0wCzLBGFbot
         KwZoBXcc+Ai/FMDXr4DSQ6Iy7DY3bXYkhJYJaZGlbzO5oXeJZZ4k1Y2uvU4olyrBN4/i
         F38g==
X-Received: by 10.66.88.198 with SMTP id bi6mr206279835pab.54.1357903286072;
        Fri, 11 Jan 2013 03:21:26 -0800 (PST)
Received: from lanh ([115.74.46.148])
        by mx.google.com with ESMTPS id kb3sm2638319pbc.27.2013.01.11.03.21.23
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jan 2013 03:21:25 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 11 Jan 2013 18:21:40 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357903275-16804-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213195>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clean.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 69c1cda..788ad8c 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -42,7 +42,7 @@ int cmd_clean(int argc, const char **argv, const char=
 *prefix)
 	int rm_flags =3D REMOVE_DIR_KEEP_NESTED_GIT;
 	struct strbuf directory =3D STRBUF_INIT;
 	struct dir_struct dir;
-	static const char **pathspec;
+	struct pathspec pathspec;
 	struct strbuf buf =3D STRBUF_INIT;
 	struct string_list exclude_list =3D STRING_LIST_INIT_NODUP;
 	const char *qname;
@@ -101,12 +101,12 @@ int cmd_clean(int argc, const char **argv, const =
char *prefix)
 		add_exclude(exclude_list.items[i].string, "", 0,
 			    &dir.exclude_list[EXC_CMDL]);
=20
-	pathspec =3D get_pathspec(prefix, argv);
+	parse_pathspec(&pathspec, PATHSPEC_FROMTOP, 0, prefix, argv);
=20
-	fill_directory(&dir, pathspec);
+	fill_directory(&dir, pathspec.raw);
=20
-	if (pathspec)
-		seen =3D xmalloc(argc > 0 ? argc : 1);
+	if (pathspec.nr)
+		seen =3D xmalloc(pathspec.nr);
=20
 	for (i =3D 0; i < dir.nr; i++) {
 		struct dir_entry *ent =3D dir.entries[i];
@@ -141,10 +141,10 @@ int cmd_clean(int argc, const char **argv, const =
char *prefix)
 		if (lstat(ent->name, &st))
 			continue;
=20
-		if (pathspec) {
-			memset(seen, 0, argc > 0 ? argc : 1);
-			matches =3D match_pathspec(pathspec, ent->name, len,
-						 0, seen);
+		if (pathspec.nr) {
+			memset(seen, 0, pathspec.nr);
+			matches =3D match_pathspec_depth(&pathspec, ent->name, len,
+						       0, seen);
 		}
=20
 		if (S_ISDIR(st.st_mode)) {
@@ -169,7 +169,7 @@ int cmd_clean(int argc, const char **argv, const ch=
ar *prefix)
 			}
 			strbuf_reset(&directory);
 		} else {
-			if (pathspec && !matches)
+			if (pathspec.nr && !matches)
 				continue;
 			qname =3D quote_path_relative(ent->name, -1, &buf, prefix);
 			if (show_only) {
--=20
1.8.0.rc2.23.g1fb49df
