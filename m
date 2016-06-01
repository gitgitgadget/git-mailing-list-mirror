From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/4] revision.c: move read_cache() out of add_index_objects_to_pending()
Date: Wed,  1 Jun 2016 17:45:16 +0700
Message-ID: <20160601104519.16563-2-pclouds@gmail.com>
References: <574D382A.8030809@kdbg.org>
 <20160601104519.16563-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	mhagger@alum.mit.edu, dturner@twopensource.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 12:45:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b83ef-0001iF-8u
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 12:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbcFAKph convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jun 2016 06:45:37 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34728 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbcFAKpf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 06:45:35 -0400
Received: by mail-pf0-f195.google.com with SMTP id c84so3175334pfc.1
        for <git@vger.kernel.org>; Wed, 01 Jun 2016 03:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sbzMtIh9LiiPoRM5i5g5bDt2WoysEsx+FyS5/rniXtw=;
        b=MZ/ZmbOLSWWOWMzc+v1r6J9THR5S8P4sXDHZCryoiw+EuZFDekf+fRsHM10QxzRKRN
         vZZYe12d4Jgxw7wqV69xydoCMaoR5o3UPFWEqQWkifrHlAxQuqV+y9UmItc6/lT8WJ4G
         stWnDF1nWoiBZWIwKWCIKJpPWWCIVLDkVIdwq8zRbcZux/dWuJPKN0Nt0PMwmCQ/Lr3T
         xGqx1SVjHR9DjfX4ugeoiWMSLm04KPYbywk4xTCi3quvpIZB02O76mTssalQCcDWz1Ea
         2ZFF3O69fqGNhVW5oShjecad/j6K8NcH/jvQKjUGOW6PMfvliSonTdHcj3KM8anQ65Az
         wFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sbzMtIh9LiiPoRM5i5g5bDt2WoysEsx+FyS5/rniXtw=;
        b=DLQLosa4pWCzEIkSF6paKiEskFZpl4uxuylWH5RznmdT13qkrkMjSR24RuXF/E4reb
         O6SkEixcS02on75HeAqysbl9GePBM0Lgn2bIkUChyGO8U4Nimuvq0wSfqIrI/LMg2Nnb
         T/Gwix5soaXOgxawd6gVKNGfVSf4zCcBhr/ye2j0lxezDpaSTES7d5SF7hR64pVSaHyW
         bT3Uot/VEvTfvMP2UH0ycw054nlvvs9UWmKCaVyqOPmZwJ+dIsvla7/qSSiXsGyZlZjS
         uXwHDh/LzJbRTVsFIMBvNokV4+3aThLt+AWrdMW2AQNA3UjS9svvGzUhNVCDXlXm3qX3
         NL1A==
X-Gm-Message-State: ALyK8tJE9YqVz7U2uzMUP6l1h48qHGi0V4opD5OLUvB/BDiqr5lE50VQVjGsR6HOqc+Jfw==
X-Received: by 10.98.34.25 with SMTP id i25mr7390730pfi.35.1464777934726;
        Wed, 01 Jun 2016 03:45:34 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id q127sm18760461pfb.34.2016.06.01.03.45.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jun 2016 03:45:34 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 01 Jun 2016 17:45:29 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160601104519.16563-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296075>

A library function like this should not change global state like
the_index. Granted, read_cache() will not re-read from $GIT_DIR/index
and lose all in-core changes if the index is dirty (i.e. no bad side
effects). But that sort of detail should not be relied on here.

Make the function take the index object from outside instead. The
caller will be responsible for reading index files if necessary.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 reachable.c |  3 ++-
 revision.c  | 15 ++++++++-------
 revision.h  |  4 +++-
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/reachable.c b/reachable.c
index d0199ca..15dbe60 100644
--- a/reachable.c
+++ b/reachable.c
@@ -170,7 +170,8 @@ void mark_reachable_objects(struct rev_info *revs, =
int mark_reflog,
 	revs->tree_objects =3D 1;
=20
 	/* Add all refs from the index file */
-	add_index_objects_to_pending(revs, 0);
+	read_cache();
+	add_index_objects_to_pending(revs, 0, &the_index);
=20
 	/* Add all external refs */
 	for_each_ref(add_one_ref, revs);
diff --git a/revision.c b/revision.c
index d30d1c4..bbb6ff1 100644
--- a/revision.c
+++ b/revision.c
@@ -1275,13 +1275,13 @@ static void add_cache_tree(struct cache_tree *i=
t, struct rev_info *revs,
=20
 }
=20
-void add_index_objects_to_pending(struct rev_info *revs, unsigned flag=
s)
+void add_index_objects_to_pending(struct rev_info *revs, unsigned flag=
s,
+				  const struct index_state *istate)
 {
 	int i;
=20
-	read_cache();
-	for (i =3D 0; i < active_nr; i++) {
-		struct cache_entry *ce =3D active_cache[i];
+	for (i =3D 0; i < istate->cache_nr; i++) {
+		const struct cache_entry *ce =3D istate->cache[i];
 		struct blob *blob;
=20
 		if (S_ISGITLINK(ce->ce_mode))
@@ -1294,9 +1294,9 @@ void add_index_objects_to_pending(struct rev_info=
 *revs, unsigned flags)
 					     ce->ce_mode, ce->name);
 	}
=20
-	if (active_cache_tree) {
+	if (istate->cache_tree) {
 		struct strbuf path =3D STRBUF_INIT;
-		add_cache_tree(active_cache_tree, revs, &path);
+		add_cache_tree(istate->cache_tree, revs, &path);
 		strbuf_release(&path);
 	}
 }
@@ -2106,7 +2106,8 @@ static int handle_revision_pseudo_opt(const char =
*submodule,
 	} else if (!strcmp(arg, "--reflog")) {
 		add_reflogs_to_pending(revs, *flags);
 	} else if (!strcmp(arg, "--indexed-objects")) {
-		add_index_objects_to_pending(revs, *flags);
+		read_cache();
+		add_index_objects_to_pending(revs, *flags, &the_index);
 	} else if (!strcmp(arg, "--not")) {
 		*flags ^=3D UNINTERESTING | BOTTOM;
 	} else if (!strcmp(arg, "--no-walk")) {
diff --git a/revision.h b/revision.h
index 9fac1a6..d06d098 100644
--- a/revision.h
+++ b/revision.h
@@ -29,6 +29,7 @@ struct rev_info;
 struct log_info;
 struct string_list;
 struct saved_parents;
+struct index_state;
=20
 struct rev_cmdline_info {
 	unsigned int nr;
@@ -271,7 +272,8 @@ extern void add_pending_sha1(struct rev_info *revs,
=20
 extern void add_head_to_pending(struct rev_info *);
 extern void add_reflogs_to_pending(struct rev_info *, unsigned int fla=
gs);
-extern void add_index_objects_to_pending(struct rev_info *, unsigned i=
nt flags);
+extern void add_index_objects_to_pending(struct rev_info *, unsigned i=
nt flags,
+					 const struct index_state *);
=20
 enum commit_action {
 	commit_ignore,
--=20
2.8.2.524.g6ff3d78
