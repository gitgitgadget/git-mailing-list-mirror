From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 09/31] commit: convert to use parse_pathspec
Date: Sun, 13 Jan 2013 19:35:17 +0700
Message-ID: <1358080539-17436-10-git-send-email-pclouds@gmail.com>
References: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:37:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuMo8-0006Og-G1
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:37:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755063Ab3AMMgk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:36:40 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:37409 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755054Ab3AMMgj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:36:39 -0500
Received: by mail-pa0-f50.google.com with SMTP id hz10so1766393pad.23
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=+IDehZop+ZjlVKLej+UxbVPIviYWX3radVBg8kBZWQo=;
        b=vtYviuKDPz4/N0MujX+Jr/42/7juENbaoZ3o6PmWvP5VFR4AjJeQVhvKzn6TO6yLyy
         4QaZUQ2YdhHVmoB6IAMDUcxiSd6N/n1bbNiMO7oCOXFWoZaHQuwpNZdgGE7jH8s9aW2y
         VcWFMQxA17C0h0bGUP/W2HP1JVFvvomAv+SJkxLRv7rH/bfu7CxgLgASD+7KkE/v7jsT
         0cFhZRP9wjeC/AtgUJ7dTtEv8h6UpxsFeSEJ7ovXJEKudpgMIs1qUCiySglTSyY1mBOw
         sSfuOZ8iU3fdpzkJOUHvBA3Xy9yIHRGsFFyCLzYK99AbagxQ4yfx/l8c3kzKSrkI72EP
         JhVA==
X-Received: by 10.66.77.201 with SMTP id u9mr223176066paw.80.1358080599126;
        Sun, 13 Jan 2013 04:36:39 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id l5sm6760127paz.14.2013.01.13.04.36.36
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:36:38 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:36:54 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213349>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d6dd3df..444ae1d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -277,17 +277,17 @@ static char *prepare_index(int argc, const char *=
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
+	parse_pathspec(&pathspec, PATHSPEC_FROMTOP,
+		       PATHSPEC_EMPTY_MATCH_ALL,
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
@@ -329,9 +329,9 @@ static char *prepare_index(int argc, const char **a=
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
@@ -350,7 +350,7 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix,
 	 * and create commit from the_index.
 	 * We still need to refresh the index here.
 	 */
-	if (!only && (!pathspec || !*pathspec)) {
+	if (!only && !pathspec.nr) {
 		fd =3D hold_locked_index(&index_lock, 1);
 		refresh_cache_or_die(refresh_flags);
 		if (active_cache_changed) {
@@ -395,7 +395,7 @@ static char *prepare_index(int argc, const char **a=
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
1.8.0.rc2.23.g1fb49df
