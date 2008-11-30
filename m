From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 7/8] Introduce default sparse patterns (core.defaultsparse)
Date: Sun, 30 Nov 2008 17:54:37 +0700
Message-ID: <1228042478-1886-8-git-send-email-pclouds@gmail.com>
References: <1228042478-1886-1-git-send-email-pclouds@gmail.com>
 <1228042478-1886-2-git-send-email-pclouds@gmail.com>
 <1228042478-1886-3-git-send-email-pclouds@gmail.com>
 <1228042478-1886-4-git-send-email-pclouds@gmail.com>
 <1228042478-1886-5-git-send-email-pclouds@gmail.com>
 <1228042478-1886-6-git-send-email-pclouds@gmail.com>
 <1228042478-1886-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 11:57:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6jzn-0005sQ-8A
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 11:57:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbYK3Kz5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2008 05:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbYK3Kz5
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 05:55:57 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:45771 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412AbYK3Kzz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 05:55:55 -0500
Received: by wa-out-1112.google.com with SMTP id v27so952230wah.21
        for <git@vger.kernel.org>; Sun, 30 Nov 2008 02:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=CseePG8gqoU3MRWaAdjq+NYBzdCg3KN3DW9y768C254=;
        b=Ybi8tZdWL83hoABGwewY4i3G6a0k/MuOaiCDQBxU3x2+M6lna2O/N+7rQRIPPXJIBp
         keVtUZr8nBGI3dye85h5BP89hL8PF0NhOC1OvU7jsJZFjN+OBm3VXscPHExka/TblAqT
         kIR2dW+n/eOZlDEvi34vKJEPftYhmuXXfBNTE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=qraRyG3lJgvWP8fowIGeEtMSmadWViGC5ARZptbqDIrywm7auGPi6Yz5vuDcD/I3zL
         cPJ1HiXXuuzEBhX0iknItTGTITRyeiptsuc/VkGaKsRc64WD+PgMa/CNE3yUi5NFlSvB
         KMDs28SCcvik/JhtF3/1m/gbBtNPPyuW0LMAg=
Received: by 10.114.199.3 with SMTP id w3mr5690525waf.181.1228042554773;
        Sun, 30 Nov 2008 02:55:54 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.32])
        by mx.google.com with ESMTPS id t1sm3167461poh.16.2008.11.30.02.55.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 30 Nov 2008 02:55:53 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 30 Nov 2008 17:55:38 +0700
X-Mailer: git-send-email 1.6.0.3.890.g95457
In-Reply-To: <1228042478-1886-7-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101969>

As noted in the previous commit message, new files will always get adde=
d into
working directory by unpack_trees(). This can be annoying so we keep
track of the sparse patterns people use to form their checkout area
and apply the patterns on new files. Those files that get filtered out
by this will be reported if verbose_update is TRUE.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt       |   10 +++++++
 Documentation/git-checkout.txt |   21 ++++++++++++++-
 Documentation/git-clone.txt    |    1 +
 builtin-checkout.c             |   54 ++++++++++++++++++++++++++++++++=
++++++++
 builtin-clone.c                |    2 +
 cache.h                        |    2 +
 config.c                       |    5 +++
 environment.c                  |    1 +
 t/t2011-checkout-sparse.sh     |   19 ++++++++++++++
 t/t5703-clone-narrow.sh        |    1 +
 unpack-trees.c                 |   52 ++++++++++++++++++++++++++++++++=
++++++
 unpack-trees.h                 |    1 +
 12 files changed, 167 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b233fe5..2b2dad1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -422,6 +422,16 @@ relatively high IO latencies.  With this set to 't=
rue', git will do the
 index comparison to the filesystem data in parallel, allowing
 overlapping IO's.
=20
+core.defaultsparse::
+	The default sparse patterns that will be used to decide
+	whether a new file should be added into working
+	directory. If a new file matches the default sparse
+	patterns, then it will be checked out. Otherwise it will
+	be ignored and marked "no-checkout" in index.
+	Sparse update operations via "git clone" or "git checkout" will
+	automatically update this config. See linkgit:git-clone[1] and
+	linkgit:git-checkout[1] for more information.
+
 alias.*::
 	Command aliases for the linkgit:git[1] command wrapper - e.g.
 	after defining "alias.last =3D cat-file commit HEAD", the invocation
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index b32043f..892a4bb 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -125,6 +125,7 @@ the conflicted merge in the specified paths.
=20
 --full::
 	Quit sparse checkout mode. Return to full checkout.
+	`core.defaultsparse` will be removed.
 	This option cannot be used with either --sparse,
 	--include-sparse, --exclude-sparse or <paths>.
=20
@@ -133,6 +134,7 @@ the conflicted merge in the specified paths.
 	Re-apply new sparse patterns on current working directory to
 	form new checkout area. All no-checkout bits will be wiped
 	out before applying the patterns.
+	`core.defaultsparse` will be set with the given patterns.
 	This option cannot be used with --full, --include-sparse,
 	--exclude-sparse or <paths>. Multiple --sparse is not allowed.
=20
@@ -140,6 +142,11 @@ the conflicted merge in the specified paths.
 --include-sparse=3D<sparse patterns>::
 	Checkout more areas specified by sparse patterns to current
 	checkout area. Already checked out entries are not affected.
+	`core.defaultsparse` will be appended with the given patterns.
+	Repetitive use of --include-sparse and --exclude-sparse may
+	leave cruft in `core.defaultsparse`, and may slow down
+	checkout operations. You may want to clean up
+	`core.defaultsparse` with --sparse.
 	This option cannot be used with --full, --sparse,
 	--exclude-sparse or <paths>. Multiple --include-sparse is not allowed=
=2E
=20
@@ -149,6 +156,11 @@ the conflicted merge in the specified paths.
 	from current checkout area. This operation will fail if there
 	are unmerged or modified files in the removing areas. No-checkout
 	entries are not affected.
+	`core.defaultsparse` will be appended with the negated version of the=
 given patterns.
+	Repetitive use of --include-sparse and --exclude-sparse may
+	leave cruft in `core.defaultsparse`, and may slow down
+	checkout operations. You may want to clean up
+	`core.defaultsparse` with --sparse.
 	This option cannot be used with --full, --sparse,
 	--include-sparse or <paths>. Multiple --exclude-sparse is not allowed=
=2E
=20
@@ -230,8 +242,11 @@ In sparse checkout mode, checkout status of every =
files in your
 working directory will be recorded in index. If a file is marked
 "no-checkout", it means that file is not needed to be present in
 working directory by user or any git command. When a new file is added
-to index, it will be marked "checkout" unless sparse patterns are
-applied.  Unmerged files are always "checkout". When you checkout new
+to index, it will be checked with default sparse pattern (see
+`core.defaultsparse` in linkgit:git-config.txt[1]). If the file
+matches the pattern, it will be marked "checkout" and added to
+working directory. Otherwise it will be marked "no-checkout" in
+index.  Unmerged files are always "checkout". When you checkout new
 files using "git checkout <file>" they will be automatically marked
 "checkout". Other commands such as "git apply" can also checkout new
 files if they are needed. linkgit:git-update-index[1] can be used to
@@ -311,6 +326,8 @@ the sparse patterns. Modified entries will refuse t=
o become "no-checkout".
=20
 You can form your checkout area in one go with --sparse option,
 or do it incrementally with --include-sparse and --exclude-sparse.
+Patterns used in those options will be automatically recorded in
+`core.defaultsparse`.
=20
 EXAMPLES
 --------
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index acdced2..f7ccf15 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -103,6 +103,7 @@ then the cloned repository will become corrupt.
 -S=3D<sparse patterns>::
 --sparse-checkout=3D<sparse patterns>::
 	Make a sparse checkout instead of a full one.
+	`core.defaultsparse` will be set with the given sparse patterns.
 	This option will not work with either --no-checkout or --bare.
 	Please refer to linkgit:git-checkout[1] for more detail on
 	sparse checkout and sparse patterns.
diff --git a/builtin-checkout.c b/builtin-checkout.c
index be4cd3a..8c6d5c5 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -592,6 +592,60 @@ static int switch_branches(struct checkout_opts *o=
pts, struct branch_info *new)
=20
 	update_refs_for_switch(opts, &old, new);
=20
+	/* Update core.defaultsparse */
+	if (opts->all_path ||
+	    (opts->new_path && !opts->prefix)) /* optimization when prefix is=
 NULL */
+		git_config_set("core.defaultsparse", opts->new_path);
+	else if (opts->new_path || opts->add_path || opts->remove_path) {
+		const char *narrow_spec;
+		struct narrow_spec *spec;
+		struct strbuf sb;
+		int i;
+
+		if (opts->new_path)
+			narrow_spec =3D opts->new_path;
+		else if (opts->add_path)
+			narrow_spec =3D opts->add_path;
+		else
+			narrow_spec =3D opts->remove_path;
+		spec =3D parse_narrow_spec(narrow_spec, NULL) ;
+		strbuf_init(&sb, 0);
+
+		/*
+		 * --sparse does not save old core.defaultsparse
+		 * --include-sparse and --exclude-sparse on the other hand
+		 * append to the old core.defaultsparse
+		 */
+		if (core_default_sparse && !opts->new_path) {
+			strbuf_addstr(&sb, core_default_sparse);
+			strbuf_addch(&sb, ':');
+		}
+
+		/*
+		 * This happens when we do full checkout,
+		 * then --exclude-sparse.
+		 * Add full pattern first so the next
+		 *  pattern has something to negate
+		 */
+		if (!core_default_sparse && opts->remove_path)
+			strbuf_addstr(&sb, "/:");
+
+		for (i =3D 0; i < spec->nr; i++) {
+			struct narrow_pattern *p =3D spec->patterns[i];
+
+			if (i)
+				strbuf_addch(&sb, ':');
+			if (!p->prefix && opts->prefix)
+				p->prefix =3D xstrdup(opts->prefix);
+			if (opts->remove_path)
+				p->negative =3D !p->negative;
+			narrow_spec_to_strbuf(p, &sb);
+		}
+		git_config_set("core.defaultsparse", sb.buf);
+		free_narrow_spec(spec);
+		strbuf_release(&sb);
+	}
+
 	ret =3D post_checkout_hook(old.commit, new->commit, 1);
 	return ret || opts->writeout_error;
 }
diff --git a/builtin-clone.c b/builtin-clone.c
index ea341a1..209030a 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -619,6 +619,8 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 		if (write_cache(fd, active_cache, active_nr) ||
 		    commit_locked_index(lock_file))
 			die("unable to write new index file");
+
+		git_config_set("core.defaultsparse", option_narrow_path);
 	}
=20
 	strbuf_release(&reflog_msg);
diff --git a/cache.h b/cache.h
index b13df06..a3366da 100644
--- a/cache.h
+++ b/cache.h
@@ -175,6 +175,7 @@ struct cache_entry {
=20
 /* Only remove in work directory, not index */
 #define CE_WT_REMOVE (0x400000)
+#define CE_NEW       (0x800000)
=20
 /*
  * Extended on-disk flags
@@ -522,6 +523,7 @@ extern size_t delta_base_cache_limit;
 extern int auto_crlf;
 extern int fsync_object_files;
 extern int core_preload_index;
+extern const char *core_default_sparse;
=20
 enum safe_crlf {
 	SAFE_CRLF_FALSE =3D 0,
diff --git a/config.c b/config.c
index d2fc8f5..ca2cf03 100644
--- a/config.c
+++ b/config.c
@@ -495,6 +495,11 @@ static int git_default_core_config(const char *var=
, const char *value)
 		return 0;
 	}
=20
+	if (!strcmp(var, "core.defaultsparse")) {
+		core_default_sparse =3D xstrdup(value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. *=
/
 	return 0;
 }
diff --git a/environment.c b/environment.c
index e278bce..5a66e30 100644
--- a/environment.c
+++ b/environment.c
@@ -30,6 +30,7 @@ int zlib_compression_level =3D Z_BEST_SPEED;
 int core_compression_level;
 int core_compression_seen;
 int fsync_object_files;
+const char *core_default_sparse;
 size_t packed_git_window_size =3D DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit =3D DEFAULT_PACKED_GIT_LIMIT;
 size_t delta_base_cache_limit =3D 16 * 1024 * 1024;
diff --git a/t/t2011-checkout-sparse.sh b/t/t2011-checkout-sparse.sh
index 67aea96..15f3761 100755
--- a/t/t2011-checkout-sparse.sh
+++ b/t/t2011-checkout-sparse.sh
@@ -45,6 +45,7 @@ test_expect_success 'limit worktree to work1 and work=
2' '
=20
 test_expect_success 'exit sparse checkout' '
 	git checkout --full &&
+	test -z "$(git config core.defaultsparse)" &&
 	test -f work1/one &&
 	test -f work2/two &&
 	test -f work3/three &&
@@ -125,4 +126,22 @@ test_expect_success 'removal outside checkout area=
' '
 	git checkout --sparse=3Dwork2/ HEAD^
 '
=20
+test_expect_success 'core.defaultsparse, new files get filtered' '
+	git checkout --sparse=3Dwork2/ $WORK2 &&
+	git config core.defaultsparse "./*:work2/"
+	git checkout $WORK3 &&
+	test -f three &&
+	! test -f work3/three &&
+	git config --unset core.defaultsparse
+'
+
+test_expect_success 'save core.defaultsparse' '
+	git checkout --sparse=3D"./*:work2/" $WORK2 &&
+	test "$(git config core.defaultsparse)" =3D "./*:work2/" &&
+	cd work3 && git checkout --include-sparse=3D1 $WORK2 && cd .. &&
+	test "$(git config core.defaultsparse)" =3D "./*:work2/:work3//1" &&
+	git checkout --exclude-sparse=3Dwork3/ $WORK2 &&
+	test "$(git config core.defaultsparse)" =3D "./*:work2/:work3//1:!wor=
k3/"
+'
+
 test_done
diff --git a/t/t5703-clone-narrow.sh b/t/t5703-clone-narrow.sh
index e34246d..691bb40 100755
--- a/t/t5703-clone-narrow.sh
+++ b/t/t5703-clone-narrow.sh
@@ -34,6 +34,7 @@ test_expect_success 'clone with --sparse-checkout' '
 	rm -fr dst &&
 	git clone --sparse-checkout=3Dwork/ src dst &&
 	cd dst &&
+	test "$(git config core.defaultsparse)" =3D "work/" &&
 	test -z "$(git ls-files --sparse | grep -v ^work/)"
 	)
 '
diff --git a/unpack-trees.c b/unpack-trees.c
index a2794b8..ad26987 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -151,6 +151,7 @@ static int verify_absent_sparse(struct cache_entry =
*ce, const char *action, stru
 static int apply_narrow_spec(struct unpack_trees_options *o)
 {
 	struct index_state *index =3D &o->result;
+	static struct narrow_spec *default_spec =3D NULL;
 	int i, len, namelen;
 	int header =3D 0;
 	char *special_files[] =3D { ".gitignore", GITATTRIBUTES_FILE, NULL };
@@ -188,6 +189,25 @@ static int apply_narrow_spec(struct unpack_trees_o=
ptions *o)
 			if (o->remove_narrow_path && match)
 				ce_mark_no_checkout(ce);
 		}
+		/*
+		 * Default spec only applies if no directive is given
+		 * and it only applies to new files
+		 */
+		else if (ce->ce_flags & CE_NEW) {
+			if (!default_spec && core_default_sparse)
+				default_spec =3D parse_narrow_spec(core_default_sparse, NULL);
+
+			if (default_spec && !match_narrow_spec(default_spec, ce->name)) {
+				if (o->update && o->verbose_update) {
+					if (!header) {
+						fprintf(stderr, "New files get filtered out by default sparse pa=
tterns:\n");
+						header =3D 1;
+					}
+					fprintf(stderr, " %s\n", ce->name);
+				}
+				ce_mark_no_checkout(ce);
+			}
+		}
=20
 		/* Update worktree, add/remove entries if needed */
=20
@@ -805,6 +825,8 @@ static int merged_entry(struct cache_entry *merge, =
struct cache_entry *old,
 	else {
 		if (verify_absent(merge, "overwritten", o))
 			return -1;
+		if (!o->has_unmerged)
+			update |=3D CE_NEW;
 		invalidate_ce_path(merge, o);
 	}
=20
@@ -957,6 +979,36 @@ void free_narrow_spec(struct narrow_spec *spec)
 	free(spec);
 }
=20
+void narrow_spec_to_strbuf(struct narrow_pattern *p, struct strbuf *sb=
)
+{
+	const char *s;
+	if (p->prefix && !p->has_root) {
+		s =3D p->prefix;
+		while (*s) {
+			if (*s =3D=3D ':')
+				strbuf_addch(sb, '\\');
+			strbuf_addch(sb, *s);
+			s++;
+		}
+		strbuf_addch(sb, '/'); /* double slashes to end prefix */
+	}
+	if (p->negative)
+		strbuf_addch(sb, '!');
+	if (p->has_root)
+		strbuf_addch(sb, '/');
+	else if (p->has_slashes && strchr(p->pattern, '/') =3D=3D NULL) {
+		strbuf_addch(sb, '.');
+		strbuf_addch(sb, '/');
+	}
+	s =3D p->pattern;
+	while (*s) {
+		if (*s =3D=3D ':')
+			strbuf_addch(sb, '\\');
+		strbuf_addch(sb, *s);
+		s++;
+	}
+}
+
 int match_narrow_spec(struct narrow_spec *spec, const char *path)
 {
 	int i, match;
diff --git a/unpack-trees.h b/unpack-trees.h
index 7e9febd..c5b19e7 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -75,6 +75,7 @@ extern int unpack_trees(unsigned n, struct tree_desc =
*t,
=20
 struct narrow_spec *parse_narrow_spec(const char *spec, const char *pr=
efix);
 void free_narrow_spec(struct narrow_spec *spec);
+void narrow_spec_to_strbuf(struct narrow_pattern *p, struct strbuf *sb=
);
 int match_narrow_spec(struct narrow_spec *spec, const char *path);
 int threeway_merge(struct cache_entry **stages, struct unpack_trees_op=
tions *o);
 int twoway_merge(struct cache_entry **src, struct unpack_trees_options=
 *o);
--=20
1.6.0.3.890.g95457
