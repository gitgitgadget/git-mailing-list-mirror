From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 20/31] Convert unmerge_cache to take struct pathspec
Date: Sun, 13 Jan 2013 19:35:28 +0700
Message-ID: <1358080539-17436-21-git-send-email-pclouds@gmail.com>
References: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:38:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuMpW-0007h1-9z
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755100Ab3AMMiF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:38:05 -0500
Received: from mail-pb0-f44.google.com ([209.85.160.44]:51540 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754807Ab3AMMiE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:38:04 -0500
Received: by mail-pb0-f44.google.com with SMTP id uo1so1700293pbc.17
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=en1nzci8m6ZUBjPA4Wi8YNx5yFguBM4g+Ff0hzw58L4=;
        b=qJxk5o02yu+D2X05LVCkMcPcYvllSNgyMbSLzHam5CEjmzSZaKFrg540YJgf1vEbLG
         x3yIyWMGekP0/47acZK2Pu6xyccFPjtXTv8LflZsfY+gDnOTJwJMcGitXfKIoLZBhyg3
         4Bs8heXf7Ku7WU1wR0XesO/4o97tFoUDs7XqXSAMmxy1G6dTUTgFS8+O6ZJ0ZOPuLCPw
         uttG6oV3ghe+rZcBvfhVH9w+LY9Q79SVUUQeUkwV1Ji7DxC+QMcD/7He5VWYedrXQi2q
         bfazUC/VoSjwPsum7TInbZEdWwBwQLigjSFvrr+Tfn2Ux+M9aU6gbxsFPrbAxhSt7YAu
         Wqog==
X-Received: by 10.66.89.199 with SMTP id bq7mr223345709pab.26.1358080684435;
        Sun, 13 Jan 2013 04:38:04 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id bi2sm2694725pab.18.2013.01.13.04.38.01
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:38:03 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:38:19 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213360>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c | 2 +-
 rerere.c           | 2 +-
 resolve-undo.c     | 4 ++--
 resolve-undo.h     | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 7ec5472..92b11ea 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -281,7 +281,7 @@ static int checkout_paths(const struct checkout_opt=
s *opts,
=20
 	/* "checkout -m path" to recreate conflicted state */
 	if (opts->merge)
-		unmerge_cache(opts->pathspec.raw);
+		unmerge_cache(&opts->pathspec);
=20
 	/* Any unmerged paths? */
 	for (pos =3D 0; pos < active_nr; pos++) {
diff --git a/rerere.c b/rerere.c
index f8ddf85..9d149fa 100644
--- a/rerere.c
+++ b/rerere.c
@@ -666,7 +666,7 @@ int rerere_forget(struct pathspec *pathspec)
=20
 	fd =3D setup_rerere(&merge_rr, RERERE_NOAUTOUPDATE);
=20
-	unmerge_cache(pathspec->raw);
+	unmerge_cache(pathspec);
 	find_conflict(&conflict);
 	for (i =3D 0; i < conflict.nr; i++) {
 		struct string_list_item *it =3D &conflict.items[i];
diff --git a/resolve-undo.c b/resolve-undo.c
index 72b4612..1bfece2 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -156,7 +156,7 @@ int unmerge_index_entry_at(struct index_state *ista=
te, int pos)
 	return unmerge_index_entry_at(istate, pos);
 }
=20
-void unmerge_index(struct index_state *istate, const char **pathspec)
+void unmerge_index(struct index_state *istate, const struct pathspec *=
pathspec)
 {
 	int i;
=20
@@ -165,7 +165,7 @@ void unmerge_index(struct index_state *istate, cons=
t char **pathspec)
=20
 	for (i =3D 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce =3D istate->cache[i];
-		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, NULL))
+		if (!match_pathspec_depth(pathspec, ce->name, ce_namelen(ce), 0, NUL=
L))
 			continue;
 		i =3D unmerge_index_entry_at(istate, i);
 	}
diff --git a/resolve-undo.h b/resolve-undo.h
index 8458769..81e8803 100644
--- a/resolve-undo.h
+++ b/resolve-undo.h
@@ -11,6 +11,6 @@ extern void resolve_undo_write(struct strbuf *, struc=
t string_list *);
 extern struct string_list *resolve_undo_read(const char *, unsigned lo=
ng);
 extern void resolve_undo_clear_index(struct index_state *);
 extern int unmerge_index_entry_at(struct index_state *, int);
-extern void unmerge_index(struct index_state *, const char **);
+extern void unmerge_index(struct index_state *, const struct pathspec =
*);
=20
 #endif
--=20
1.8.0.rc2.23.g1fb49df
