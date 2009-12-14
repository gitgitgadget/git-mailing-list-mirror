From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 18/23] unpack-trees(): "enable" sparse checkout and load $GIT_DIR/info/sparse-checkout
Date: Mon, 14 Dec 2009 17:31:01 +0700
Message-ID: <1260786666-8405-19-git-send-email-pclouds@gmail.com>
References: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 11:33:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK8FM-0007wL-Pn
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 11:33:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756016AbZLNKdk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 05:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756254AbZLNKde
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 05:33:34 -0500
Received: from mail-px0-f174.google.com ([209.85.216.174]:39386 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756016AbZLNKdV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 05:33:21 -0500
Received: by mail-px0-f174.google.com with SMTP id 4so1691452pxi.33
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 02:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=YGq1w0OXI4suiQ8hT1sAoSEzSx9WohjDbGkdC6XIzu8=;
        b=ZZJtXnX4Fy1rz5jfH2KVqizEThXqR98TK7HMgJ8yBjm2G+Vo8vYFy3us53tE0BLXNV
         KzeiPBXr4W8uDUQ1vofkmSySMG3Bvxz9BFpb2frMocBOAOv1pvYQj4AvDYIrxHpy2hex
         mkJ9VkglqhNFbPkwfF0dLOQzWup6vDCPG4wjg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=CsGn2462rahb99MBmgPiW5PMQJq444DOlp0ZPwp52cPu3CVmY3D1EmDDDEujV1r5LE
         aiprznPkdvOAzHe/PtwTrtuMkJlD/zE44lxkQh0Ty6/GWMHHTl7W94skn1kR2yU8eNHG
         Yz47YAWkkZwxgiBHJsacdyG5PoUW3i8sqfW9c=
Received: by 10.143.26.38 with SMTP id d38mr3029306wfj.216.1260786801598;
        Mon, 14 Dec 2009 02:33:21 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.233.253])
        by mx.google.com with ESMTPS id 23sm4907991pzk.8.2009.12.14.02.33.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Dec 2009 02:33:20 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 14 Dec 2009 17:32:39 +0700
X-Mailer: git-send-email 1.6.5.2.216.g9c1ec
In-Reply-To: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135176>

This patch introduces core.sparseCheckout, which will control whether
sparse checkout support is enabled in unpack_trees()

It also loads sparse-checkout file that will be used in the next patch.
I split it out so the next patch will be shorter, easier to read.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt        |    4 ++++
 Documentation/git-read-tree.txt |    4 +++-
 cache.h                         |    1 +
 config.c                        |    5 +++++
 environment.c                   |    1 +
 unpack-trees.c                  |   36 ++++++++++++++++++++++++++++++-=
-----
 unpack-trees.h                  |    4 ++++
 7 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7791c32..5825c91 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -439,6 +439,10 @@ On some file system/operating system combinations,=
 this is unreliable.
 Set this config setting to 'rename' there; However, This will remove t=
he
 check that makes sure that existing object files will not get overwrit=
ten.
=20
+core.sparseCheckout::
+	Enable "sparse checkout" feature. See section "Sparse checkout" in
+	linkgit:git-read-tree[1] for more information.
+
 add.ignore-errors::
 	Tells 'git-add' to continue adding files when some files cannot be
 	added due to indexing errors. Equivalent to the '--ignore-errors'
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-t=
ree.txt
index 8b39716..fc3f08b 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -401,7 +401,9 @@ follows:
 ----------------
=20
 Then you can disable sparse checkout. Sparse checkout support in "git
-read-tree" and similar commands is disabled by default.
+read-tree" and similar commands is disabled by default. You need to
+turn `core.sparseCheckout` on in order to have sparse checkout
+support.
=20
=20
 SEE ALSO
diff --git a/cache.h b/cache.h
index 3a37469..f51b285 100644
--- a/cache.h
+++ b/cache.h
@@ -528,6 +528,7 @@ extern size_t delta_base_cache_limit;
 extern int auto_crlf;
 extern int fsync_object_files;
 extern int core_preload_index;
+extern int core_apply_sparse_checkout;
=20
 enum safe_crlf {
 	SAFE_CRLF_FALSE =3D 0,
diff --git a/config.c b/config.c
index e87edea..abd762e 100644
--- a/config.c
+++ b/config.c
@@ -503,6 +503,11 @@ static int git_default_core_config(const char *var=
, const char *value)
 		return 0;
 	}
=20
+	if (!strcmp(var, "core.sparsecheckout")) {
+		core_apply_sparse_checkout =3D git_config_bool(var, value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. *=
/
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 8f5eaa7..020422c 100644
--- a/environment.c
+++ b/environment.c
@@ -48,6 +48,7 @@ enum push_default_type push_default =3D PUSH_DEFAULT_=
MATCHING;
 #endif
 enum object_creation_mode object_creation_mode =3D OBJECT_CREATION_MOD=
E;
 int grafts_replace_parents =3D 1;
+int core_apply_sparse_checkout;
=20
 /* Parallel index stat data preload? */
 int core_preload_index =3D 0;
diff --git a/unpack-trees.c b/unpack-trees.c
index 5467265..56f1a30 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -378,6 +378,7 @@ int unpack_trees(unsigned len, struct tree_desc *t,=
 struct unpack_trees_options
 {
 	int ret;
 	static struct cache_entry *dfc;
+	struct exclude_list el;
=20
 	if (len > MAX_UNPACK_TREES)
 		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
@@ -387,6 +388,16 @@ int unpack_trees(unsigned len, struct tree_desc *t=
, struct unpack_trees_options
 	state.quiet =3D 1;
 	state.refresh_cache =3D 1;
=20
+	memset(&el, 0, sizeof(el));
+	if (!core_apply_sparse_checkout || !o->update)
+		o->skip_sparse_checkout =3D 1;
+	if (!o->skip_sparse_checkout) {
+		if (add_excludes_from_file_to_list(git_path("info/sparse-checkout"),=
 "", 0, NULL, &el, 0) < 0)
+			o->skip_sparse_checkout =3D 1;
+		else
+			o->el =3D &el;
+	}
+
 	memset(&o->result, 0, sizeof(o->result));
 	o->result.initialized =3D 1;
 	if (o->src_index) {
@@ -407,26 +418,39 @@ int unpack_trees(unsigned len, struct tree_desc *=
t, struct unpack_trees_options
 		info.fn =3D unpack_callback;
 		info.data =3D o;
=20
-		if (traverse_trees(len, t, &info) < 0)
-			return unpack_failed(o, NULL);
+		if (traverse_trees(len, t, &info) < 0) {
+			ret =3D unpack_failed(o, NULL);
+			goto done;
+		}
 	}
=20
 	/* Any left-over entries in the index? */
 	if (o->merge) {
 		while (o->pos < o->src_index->cache_nr) {
 			struct cache_entry *ce =3D o->src_index->cache[o->pos];
-			if (unpack_index_entry(ce, o) < 0)
-				return unpack_failed(o, NULL);
+			if (unpack_index_entry(ce, o) < 0) {
+				ret =3D unpack_failed(o, NULL);
+				goto done;
+			}
 		}
 	}
=20
-	if (o->trivial_merges_only && o->nontrivial_merge)
-		return unpack_failed(o, "Merge requires file-level merging");
+	if (o->trivial_merges_only && o->nontrivial_merge) {
+		ret =3D unpack_failed(o, "Merge requires file-level merging");
+		goto done;
+	}
=20
 	o->src_index =3D NULL;
 	ret =3D check_updates(o) ? (-2) : 0;
 	if (o->dst_index)
 		*o->dst_index =3D o->result;
+
+done:
+	for (i =3D 0;i < el.nr;i++)
+		free(el.excludes[i]);
+	if (el.excludes)
+		free(el.excludes);
+
 	return ret;
 }
=20
diff --git a/unpack-trees.h b/unpack-trees.h
index d19df44..5c9e98a 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -4,6 +4,7 @@
 #define MAX_UNPACK_TREES 8
=20
 struct unpack_trees_options;
+struct exclude_list;
=20
 typedef int (*merge_fn_t)(struct cache_entry **src,
 		struct unpack_trees_options *options);
@@ -28,6 +29,7 @@ struct unpack_trees_options {
 		     skip_unmerged,
 		     initial_checkout,
 		     diff_index_cached,
+		     skip_sparse_checkout,
 		     gently;
 	const char *prefix;
 	int pos;
@@ -44,6 +46,8 @@ struct unpack_trees_options {
 	struct index_state *dst_index;
 	struct index_state *src_index;
 	struct index_state result;
+
+	struct exclude_list *el; /* for internal use */
 };
=20
 extern int unpack_trees(unsigned n, struct tree_desc *t,
--=20
1.6.5.2.216.g9c1ec
