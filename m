From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 07/31] clean: convert to use parse_pathspec
Date: Sun, 13 Jan 2013 19:35:15 +0700
Message-ID: <1358080539-17436-8-git-send-email-pclouds@gmail.com>
References: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:36:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuMnq-00069I-RE
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755001Ab3AMMgX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:36:23 -0500
Received: from mail-pb0-f53.google.com ([209.85.160.53]:55162 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755022Ab3AMMgW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:36:22 -0500
Received: by mail-pb0-f53.google.com with SMTP id jt11so1691674pbb.12
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=vY466Wag6w7uAIa/txfuTVa02s7VMGLwFpWSwfiEmCo=;
        b=kVWn97yvesK9C2uDi25+VftxqdkUBu6921+u4qMuDbLqNXHuBzuA612M1SURsIjKcX
         0Q4Kd9KJ1vGhj8Y7Y5KW8ZhMuUT6Z1u3cdMUz8ghqSGmChkoIMjLDO76WWOAKxDUpGql
         5ZLOoWgnd98BQEbkMg1FIGnbZG7BkhpI5LpacpC21aUAENaXwnFQDKEmCihuquF3nmQk
         W8RCjuYhb32y+1uaDawfExihtfNSfF1vE1czFRqBR4qkPAv50Z+4X3Hho7KaS2P6ARvP
         fiYiW+WDmvIGA6jiZ13jS1EwDtttg6XYl7JON5vyooP3+lYCL7X21J5fvA0VdupsamNh
         iz/g==
X-Received: by 10.68.238.165 with SMTP id vl5mr247570163pbc.0.1358080582044;
        Sun, 13 Jan 2013 04:36:22 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id wg3sm6290206pbc.28.2013.01.13.04.36.18
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:36:21 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:36:35 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213347>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clean.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 4cdabe0..fb0fe9a 100644
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
@@ -100,9 +100,9 @@ int cmd_clean(int argc, const char **argv, const ch=
ar *prefix)
 		add_exclude(exclude_list.items[i].string, "", 0,
 			    &dir.exclude_list[EXC_CMDL]);
=20
-	pathspec =3D get_pathspec(prefix, argv);
+	parse_pathspec(&pathspec, PATHSPEC_FROMTOP, 0, prefix, argv);
=20
-	fill_directory(&dir, pathspec);
+	fill_directory(&dir, pathspec.raw);
=20
 	for (i =3D 0; i < dir.nr; i++) {
 		struct dir_entry *ent =3D dir.entries[i];
@@ -137,9 +137,9 @@ int cmd_clean(int argc, const char **argv, const ch=
ar *prefix)
 		if (lstat(ent->name, &st))
 			continue;
=20
-		if (pathspec)
-			matches =3D match_pathspec(pathspec, ent->name, len,
-						 0, NULL);
+		if (pathspec.nr)
+			matches =3D match_pathspec_depth(&pathspec, ent->name,
+						       len, 0, NULL);
=20
 		if (S_ISDIR(st.st_mode)) {
 			strbuf_addstr(&directory, ent->name);
@@ -163,7 +163,7 @@ int cmd_clean(int argc, const char **argv, const ch=
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
