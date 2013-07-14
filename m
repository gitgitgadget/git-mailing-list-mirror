From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 28/46] Convert unmerge_cache to take struct pathspec
Date: Sun, 14 Jul 2013 15:35:51 +0700
Message-ID: <1373790969-13000-29-git-send-email-pclouds@gmail.com>
References: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 10:39:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyHpl-0002lS-K7
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 10:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752440Ab3GNIjF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 04:39:05 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:64786 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419Ab3GNIjE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 04:39:04 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp16so10424905pbb.28
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 01:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=mCmCO6wZKfaUygsUuOKCtHPeiqdePQUJ1HL8O2RmCBI=;
        b=wHrWFe7IUAn7LU9Wa9ysc+FWqG1Y1UX27D9yOy5I7xPPUiOhgaz5wTL5z/Nq1s3pyY
         E5czpUY3s2+0xEVIoIPZzRoubV6ig2BkF4L8D1eV1+K5sGSFF/PlabuY6qXAQdXLfOwU
         kn4AH+15oxlHgiyWDmJ5DzNt1fr0tNERZd58XL0mbo6e7kpTYWy3hplVIW/h6Itw4Fbv
         ilsxl7lua+eEFzhpRw/alilSM8M+WGG6MWKYFkb03uljmvAuKhH4MXaY0GumfU3YWsJy
         kgJAnh2IabvtqPFZTVCIbC/vwYMJkcTv3vr1ScFATyj0K5q6ntl3jrRwyBcvweOVlV+i
         herA==
X-Received: by 10.68.163.131 with SMTP id yi3mr49272377pbb.55.1373791142766;
        Sun, 14 Jul 2013 01:39:02 -0700 (PDT)
Received: from lanh ([115.73.210.100])
        by mx.google.com with ESMTPSA id td4sm57796302pac.20.2013.07.14.01.38.59
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 01:39:02 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Jul 2013 15:39:14 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230340>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 rerere.c       | 2 +-
 resolve-undo.c | 4 ++--
 resolve-undo.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/rerere.c b/rerere.c
index 27afbfe..4105bca 100644
--- a/rerere.c
+++ b/rerere.c
@@ -668,7 +668,7 @@ int rerere_forget(struct pathspec *pathspec)
=20
 	fd =3D setup_rerere(&merge_rr, RERERE_NOAUTOUPDATE);
=20
-	unmerge_cache(pathspec->raw);
+	unmerge_cache(pathspec);
 	find_conflict(&conflict);
 	for (i =3D 0; i < conflict.nr; i++) {
 		struct string_list_item *it =3D &conflict.items[i];
diff --git a/resolve-undo.c b/resolve-undo.c
index 639eb9c..4b78e6f 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -173,7 +173,7 @@ void unmerge_marked_index(struct index_state *istat=
e)
 	}
 }
=20
-void unmerge_index(struct index_state *istate, const char **pathspec)
+void unmerge_index(struct index_state *istate, const struct pathspec *=
pathspec)
 {
 	int i;
=20
@@ -182,7 +182,7 @@ void unmerge_index(struct index_state *istate, cons=
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
index 7a30206..4630645 100644
--- a/resolve-undo.h
+++ b/resolve-undo.h
@@ -11,7 +11,7 @@ extern void resolve_undo_write(struct strbuf *, struc=
t string_list *);
 extern struct string_list *resolve_undo_read(const char *, unsigned lo=
ng);
 extern void resolve_undo_clear_index(struct index_state *);
 extern int unmerge_index_entry_at(struct index_state *, int);
-extern void unmerge_index(struct index_state *, const char **);
+extern void unmerge_index(struct index_state *, const struct pathspec =
*);
 extern void unmerge_marked_index(struct index_state *);
=20
 #endif
--=20
1.8.2.83.gc99314b
