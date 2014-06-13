From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/32] cache-tree: mark istate->cache_changed on prime_cache_tree()
Date: Fri, 13 Jun 2014 19:19:33 +0700
Message-ID: <1402661991-14977-15-git-send-email-pclouds@gmail.com>
References: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 14:21:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvQUB-0003aI-P2
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 14:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372AbaFMMVc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 08:21:32 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:57661 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098AbaFMMVb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 08:21:31 -0400
Received: by mail-pd0-f178.google.com with SMTP id r10so2088728pdi.37
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 05:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=MkggNOXf4NZE6oHT8XUlgxaYhUWgYNKayh5Wxp1JeHs=;
        b=csNSWHEsGt3oCr8tP3dXXnEMqsl6j+Zwyxs0TSOtzE2toSPR9hDOtyg2TS2iNVvWwq
         rJlkeQVlRMuUFrF+O4kBCbUd1fFf5e6zxQLAbkGRf4yI6ZjWyY8w8SPhmR5gcnQlqroI
         EOOBmFKwugbJFgxVbT29iAxqQ5oGDk4rtsqyKN/ABvLgHHlO67Rw1jxKfimwNBtKh+yw
         y8AcwsJedtpGPgpAzHMwuetWZtSoljp9+f+ImLkg2xKcU84mI3pzSZEiTlpXIW4MBfbQ
         h8CM8B+/N6dYK2asJC6Pi7ftiRyVnkFWRIFazfxF0wfbW2Bq7oxheWoUl7ugL5DSSs44
         3fog==
X-Received: by 10.68.253.73 with SMTP id zy9mr2981087pbc.114.1402662090835;
        Fri, 13 Jun 2014 05:21:30 -0700 (PDT)
Received: from lanh ([115.73.228.145])
        by mx.google.com with ESMTPSA id co3sm3375902pbb.89.2014.06.13.05.21.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jun 2014 05:21:30 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 13 Jun 2014 19:21:28 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251570>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/read-tree.c | 2 +-
 builtin/reset.c     | 2 +-
 cache-tree.c        | 9 +++++----
 cache-tree.h        | 2 +-
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index f26d90f..3204c62 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -231,7 +231,7 @@ int cmd_read_tree(int argc, const char **argv, cons=
t char *unused_prefix)
 	 * what came from the tree.
 	 */
 	if (nr_trees =3D=3D 1 && !opts.prefix)
-		prime_cache_tree(&active_cache_tree, trees[0]);
+		prime_cache_tree(&the_index, trees[0]);
=20
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die("unable to write new index file");
diff --git a/builtin/reset.c b/builtin/reset.c
index 0c56d28..234b2eb 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -84,7 +84,7 @@ static int reset_index(const unsigned char *sha1, int=
 reset_type, int quiet)
=20
 	if (reset_type =3D=3D MIXED || reset_type =3D=3D HARD) {
 		tree =3D parse_tree_indirect(sha1);
-		prime_cache_tree(&active_cache_tree, tree);
+		prime_cache_tree(&the_index, tree);
 	}
=20
 	return 0;
diff --git a/cache-tree.c b/cache-tree.c
index 18055f1..c53f7de 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -654,11 +654,12 @@ static void prime_cache_tree_rec(struct cache_tre=
e *it, struct tree *tree)
 	it->entry_count =3D cnt;
 }
=20
-void prime_cache_tree(struct cache_tree **it, struct tree *tree)
+void prime_cache_tree(struct index_state *istate, struct tree *tree)
 {
-	cache_tree_free(it);
-	*it =3D cache_tree();
-	prime_cache_tree_rec(*it, tree);
+	cache_tree_free(&istate->cache_tree);
+	istate->cache_tree =3D cache_tree();
+	prime_cache_tree_rec(istate->cache_tree, tree);
+	istate->cache_changed |=3D CACHE_TREE_CHANGED;
 }
=20
 /*
diff --git a/cache-tree.h b/cache-tree.h
index 154b357..b47ccec 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -46,7 +46,7 @@ int update_main_cache_tree(int);
 #define WRITE_TREE_PREFIX_ERROR (-3)
=20
 int write_cache_as_tree(unsigned char *sha1, int flags, const char *pr=
efix);
-void prime_cache_tree(struct cache_tree **, struct tree *);
+void prime_cache_tree(struct index_state *, struct tree *);
=20
 extern int cache_tree_matches_traversal(struct cache_tree *, struct na=
me_entry *ent, struct traverse_info *info);
=20
--=20
1.9.1.346.ga2b5940
