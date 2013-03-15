From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 16/45] commit: convert to use parse_pathspec
Date: Fri, 15 Mar 2013 13:06:31 +0700
Message-ID: <1363327620-29017-17-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:26:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO5q-0005F5-QI
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:26:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342Ab3COGZw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:25:52 -0400
Received: from mail-ia0-f182.google.com ([209.85.210.182]:56672 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276Ab3COGZv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:25:51 -0400
Received: by mail-ia0-f182.google.com with SMTP id b35so2874417iac.41
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=BePftLEWC5AobtlGFKlTjU67Ri3VGkmohCSjefaTm/g=;
        b=Dscu5ba4HZYTvey7CVI5ak/qlM3iSQOj/XR7zhqxdTfagCpKYfNFlRysR/1GAFCAP7
         sxKV3Ye2eLzRHK0UakxJVLC8bCsQkbCYU1pOXPXrM2oysyVxokFgt+whYI2V9FC1IUsi
         TDAg8tfFXvYp2hmaj87WBvKAFD+E7hopWv1wzsx6gKflBZdp1VfK61rdSxefFyUS7bqu
         jh5oQgNbSs0Mlm/uPwBSdKZX594DXNGHqc25whnYXZKO7JYxi+fSdDTJaBcKFQTYGrSR
         s5hqSn/Kx5dtQF5rjvvc6Zljw9YxadT0e1xXf16Sh+dgryetp1a2r9uX80tPuL2fhXhJ
         Ib/Q==
X-Received: by 10.50.153.165 with SMTP id vh5mr486332igb.48.1363328751347;
        Thu, 14 Mar 2013 23:25:51 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id g6sm622178ign.4.2013.03.14.23.25.47
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:25:50 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:08:52 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218203>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 3348aa1..ba6731b 100644
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
1.8.0.rc0.19.g7bbb31d
