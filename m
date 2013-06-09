From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 15/45] commit: convert to use parse_pathspec
Date: Sun,  9 Jun 2013 13:25:48 +0700
Message-ID: <1370759178-1709-16-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:26:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ5F-0000MQ-RS
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:26:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070Ab3FIG0a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:26:30 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:35170 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913Ab3FIG03 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:26:29 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so1896009pde.37
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=r7O1ONGuYdUGPhCShPMyX7li6vhaX6XPea2YquffUJM=;
        b=lgGtVYkN/OouKOxsQdBogbpXEYy4VTx8V5r4nqrHsZyrI8t/i16n4ll1zzqPP96GPd
         PIrUnZkZBAvAs5kv+DggL1u0mE2drGto7WtLDbOjqm+0DLQqimwPuIecjJt0jrll4KPX
         5hY+HcpSSOHUpEOpDpw07wQSHGnlO27gN1jHz2ZbX2UWbUy7lQfzZ2hNnlnzF0ehsVNb
         Y4RwvjqXpTWTwd9o8KulthbYf29Ubnmk3s9xMWQ+DeCnunwYuarKLOdmN1XAlzyGRtB4
         folnYIO4PRHsTg9zxlJX29xfXB+mm5vNtX8hVP//3WGxSyUQa814bBQHMOpWEwlEzWyF
         C2Iw==
X-Received: by 10.68.27.9 with SMTP id p9mr4986165pbg.139.1370759189016;
        Sat, 08 Jun 2013 23:26:29 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id de14sm10241552pac.10.2013.06.08.23.26.25
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:26:28 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:28:00 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226907>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d2f30d9..0efe269 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -279,17 +279,17 @@ static char *prepare_index(int argc, const char *=
*argv, const char *prefix,
 {
 	int fd;
 	struct string_list partial;
-	const char **pathspec =3D NULL;
+	struct pathspec pathspec;
 	char *old_index_env =3D NULL;
 	int refresh_flags =3D REFRESH_QUIET;
=20
 	if (is_status)
 		refresh_flags |=3D REFRESH_UNMERGED;
+	parse_pathspec(&pathspec, 0,
+		       PATHSPEC_PREFER_FULL,
+		       prefix, argv);
=20
-	if (*argv)
-		pathspec =3D get_pathspec(prefix, argv);
-
-	if (read_cache_preload(pathspec) < 0)
+	if (read_cache_preload(pathspec.raw) < 0)
 		die(_("index file corrupt"));
=20
 	if (interactive) {
@@ -331,9 +331,9 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix,
 	 * (A) if all goes well, commit the real index;
 	 * (B) on failure, rollback the real index.
 	 */
-	if (all || (also && pathspec && *pathspec)) {
+	if (all || (also && pathspec.nr)) {
 		fd =3D hold_locked_index(&index_lock, 1);
-		add_files_to_cache(also ? prefix : NULL, pathspec, 0);
+		add_files_to_cache(also ? prefix : NULL, pathspec.raw, 0);
 		refresh_cache_or_die(refresh_flags);
 		update_main_cache_tree(WRITE_TREE_SILENT);
 		if (write_cache(fd, active_cache, active_nr) ||
@@ -352,7 +352,7 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix,
 	 * and create commit from the_index.
 	 * We still need to refresh the index here.
 	 */
-	if (!only && (!pathspec || !*pathspec)) {
+	if (!only && !pathspec.nr) {
 		fd =3D hold_locked_index(&index_lock, 1);
 		refresh_cache_or_die(refresh_flags);
 		if (active_cache_changed) {
@@ -397,7 +397,7 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix,
=20
 	memset(&partial, 0, sizeof(partial));
 	partial.strdup_strings =3D 1;
-	if (list_paths(&partial, !current_head ? NULL : "HEAD", prefix, paths=
pec))
+	if (list_paths(&partial, !current_head ? NULL : "HEAD", prefix, paths=
pec.raw))
 		exit(1);
=20
 	discard_cache();
--=20
1.8.2.83.gc99314b
