From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 28/45] Convert unmerge_cache to take struct pathspec
Date: Fri, 15 Mar 2013 13:06:43 +0700
Message-ID: <1363327620-29017-29-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:27:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO7F-0006j2-Nn
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:27:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170Ab3COG1T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:27:19 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:59152 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741Ab3COG1S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:27:18 -0400
Received: by mail-ie0-f171.google.com with SMTP id 10so3995894ied.16
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=oFjeUGzTpNUamhKriI+hC4WGxo3zJPLQWGc1Y+3itYE=;
        b=DElP6gxt/8NyLeCaVpKwwkEXH9m2wPmG/NOeIXxL3cJbn2FZ7V2q1M1hkDfrq1ZnGP
         dFW4cNZ9dlrqjpgeCli0IAe/5Lc4EoXo+hGqSf6YHDhKIa0h3TBwKFRe74hMrIzMSeYd
         UggedQzge8TW8zNM51yjWdwwLc/6FyoiVyf+GuII45hyzU7HwZHRsfCiya2tBMPDj1m5
         liGn26WehSQuGggPAu7JVguO9fV6CqSd9Ofi23xEQvAo3ASKsUaLs6pq6EmuLAx5n+62
         Z8vURSU1/uJFX02fqnNPJxGhTRnbbYM5dAWKHWO1Oioj0UNBjTlF+0AdjVT0uzbh1cc9
         aVfA==
X-Received: by 10.50.196.130 with SMTP id im2mr418719igc.90.1363328838036;
        Thu, 14 Mar 2013 23:27:18 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id a3sm748532igq.5.2013.03.14.23.27.14
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:27:17 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:10:15 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218215>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c | 2 +-
 rerere.c           | 2 +-
 resolve-undo.c     | 4 ++--
 resolve-undo.h     | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2ddff95..ba5a5c0 100644
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
index c52c1f2..ac02eb8 100644
--- a/rerere.c
+++ b/rerere.c
@@ -667,7 +667,7 @@ int rerere_forget(struct pathspec *pathspec)
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
1.8.0.rc0.19.g7bbb31d
