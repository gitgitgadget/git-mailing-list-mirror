From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH v4 04/19] Teach Git to respect skip-worktree bit (reading part)
Date: Thu, 20 Aug 2009 20:46:58 +0700
Message-ID: <1250776033-12395-5-git-send-email-pclouds@gmail.com>
References: <1250776033-12395-1-git-send-email-pclouds@gmail.com>
 <1250776033-12395-2-git-send-email-pclouds@gmail.com>
 <1250776033-12395-3-git-send-email-pclouds@gmail.com>
 <1250776033-12395-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 20 15:49:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me81D-0007ZS-KW
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 15:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754643AbZHTNro convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2009 09:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754640AbZHTNro
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 09:47:44 -0400
Received: from mail-px0-f196.google.com ([209.85.216.196]:54197 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754634AbZHTNrm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 09:47:42 -0400
Received: by mail-px0-f196.google.com with SMTP id 34so3268834pxi.4
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 06:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=QnD1Gube6/dOGlBf7hNYTR7HvPB0dpMHipitJjPOyrw=;
        b=J7IUvRSrMobo8IGBDn/4pBvx+EfSEm14sow1YfdxuD9H4EDzcKE95CJqODTp281HQ8
         S7ChCEy9c5LNbx65LaBISOUiTf+6hq1tt67cJ/Ki6k1D1SwFaQ/Olw6QOBCavzcAPBwy
         pbIpTcxqZRxGtX1+ptMMBp12Vp+kzlf2benPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=e16kflSE7v31coSqt3PEjShOT1tWhT5rBIff+c4MHMzWxezagkxacKLbWz6zwkCXe6
         +D4UU3GiMh/oREA/79cyns4gpCZtDCKmSZ40GSOBe4Ef19Kdtq/D9cs4b8J+tLPef/bS
         H9PLLK4Nr1fIYkTW53Hltkq/GgF25YGs7GLMI=
Received: by 10.115.101.1 with SMTP id d1mr9434963wam.40.1250776064383;
        Thu, 20 Aug 2009 06:47:44 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.241.222])
        by mx.google.com with ESMTPS id 23sm186419pzk.12.2009.08.20.06.47.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Aug 2009 06:47:43 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 20 Aug 2009 20:47:38 +0700
X-Mailer: git-send-email 1.6.3.GIT
In-Reply-To: <1250776033-12395-4-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126626>

grep: turn on --cached for files that is marked skip-worktree
ls-files: do not check for deleted file that is marked skip-worktree
update-index: ignore update request if it's skip-worktree, while still =
allows removing
diff*: skip worktree version

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-commit.c                 |    5 +
 builtin-grep.c                   |    2 +-
 builtin-ls-files.c               |    2 +
 builtin-update-index.c           |   38 +++++----
 diff-lib.c                       |    5 +-
 diff.c                           |    2 +-
 read-cache.c                     |    8 +--
 t/t7011-skip-worktree-reading.sh |  163 ++++++++++++++++++++++++++++++=
++++++++
 8 files changed, 199 insertions(+), 26 deletions(-)
 create mode 100755 t/t7011-skip-worktree-reading.sh

diff --git a/builtin-commit.c b/builtin-commit.c
index 200ffda..cb64cde 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -181,6 +181,11 @@ static void add_remove_files(struct string_list *l=
ist)
 	for (i =3D 0; i < list->nr; i++) {
 		struct stat st;
 		struct string_list_item *p =3D &(list->items[i]);
+		int pos =3D index_name_pos(&the_index, p->string, strlen(p->string))=
;
+		struct cache_entry *ce =3D pos < 0 ? NULL : active_cache[pos];
+
+		if (ce && ce_skip_worktree(ce))
+			continue;
=20
 		if (!lstat(p->string, &st)) {
 			if (add_to_cache(p->string, &st, 0))
diff --git a/builtin-grep.c b/builtin-grep.c
index ad0e0a5..813fe97 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -517,7 +517,7 @@ static int grep_cache(struct grep_opt *opt, const c=
har **paths, int cached,
 		 * are identical, even if worktree file has been modified, so use
 		 * cache version instead
 		 */
-		if (cached || (ce->ce_flags & CE_VALID)) {
+		if (cached || (ce->ce_flags & CE_VALID) || ce_skip_worktree(ce)) {
 			if (ce_stage(ce))
 				continue;
 			hit |=3D grep_sha1(opt, ce->sha1, ce->name, 0);
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index c1afbad..ad7e447 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -194,6 +194,8 @@ static void show_files(struct dir_struct *dir, cons=
t char *prefix)
 				continue;
 			if (ce->ce_flags & CE_UPDATE)
 				continue;
+			if (ce_skip_worktree(ce))
+				continue;
 			err =3D lstat(ce->name, &st);
 			if (show_deleted && err)
 				show_ce_entry(tag_removed, ce);
diff --git a/builtin-update-index.c b/builtin-update-index.c
index 5e97d09..97b9ea6 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -172,29 +172,29 @@ static int process_directory(const char *path, in=
t len, struct stat *st)
 	return error("%s: is a directory - add files inside instead", path);
 }
=20
-/*
- * Process a regular file
- */
-static int process_file(const char *path, int len, struct stat *st)
-{
-	int pos =3D cache_name_pos(path, len);
-	struct cache_entry *ce =3D pos < 0 ? NULL : active_cache[pos];
-
-	if (ce && S_ISGITLINK(ce->ce_mode))
-		return error("%s is already a gitlink, not replacing", path);
-
-	return add_one_path(ce, path, len, st);
-}
-
 static int process_path(const char *path)
 {
-	int len;
+	int pos, len;
 	struct stat st;
+	struct cache_entry *ce;
=20
 	len =3D strlen(path);
 	if (has_symlink_leading_path(path, len))
 		return error("'%s' is beyond a symbolic link", path);
=20
+	pos =3D cache_name_pos(path, len);
+	ce =3D pos < 0 ? NULL : active_cache[pos];
+	if (ce && ce_skip_worktree(ce)) {
+		/*
+		 * working directory version is assumed "good"
+		 * so updating it does not make sense.
+		 * On the other hand, removing it from index should work
+		 */
+		if (allow_remove && remove_file_from_cache(path))
+			return error("%s: cannot remove from the index", path);
+		return 0;
+	}
+
 	/*
 	 * First things first: get the stat information, to decide
 	 * what to do about the pathname!
@@ -205,7 +205,13 @@ static int process_path(const char *path)
 	if (S_ISDIR(st.st_mode))
 		return process_directory(path, len, &st);
=20
-	return process_file(path, len, &st);
+	/*
+	 * Process a regular file
+	 */
+	if (ce && S_ISGITLINK(ce->ce_mode))
+		return error("%s is already a gitlink, not replacing", path);
+
+	return add_one_path(ce, path, len, &st);
 }
=20
 static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
diff --git a/diff-lib.c b/diff-lib.c
index e7e8e88..fc98678 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -159,7 +159,7 @@ int run_diff_files(struct rev_info *revs, unsigned =
int option)
 				continue;
 		}
=20
-		if (ce_uptodate(ce))
+		if (ce_uptodate(ce) || ce_skip_worktree(ce))
 			continue;
=20
 		changed =3D check_removed(ce, &st);
@@ -321,6 +321,8 @@ static void do_oneway_diff(struct unpack_trees_opti=
ons *o,
 	struct rev_info *revs =3D o->unpack_data;
 	int match_missing, cached;
=20
+	/* if the entry is not checked out, don't examine work tree */
+	cached =3D o->index_only || (idx && ce_skip_worktree(idx));
 	/*
 	 * Backward compatibility wart - "diff-index -m" does
 	 * not mean "do not ignore merges", but "match_missing".
@@ -328,7 +330,6 @@ static void do_oneway_diff(struct unpack_trees_opti=
ons *o,
 	 * But with the revision flag parsing, that's found in
 	 * "!revs->ignore_merges".
 	 */
-	cached =3D o->index_only;
 	match_missing =3D !revs->ignore_merges;
=20
 	if (cached && idx && ce_stage(idx)) {
diff --git a/diff.c b/diff.c
index 91d6ea2..215e6b3 100644
--- a/diff.c
+++ b/diff.c
@@ -1805,7 +1805,7 @@ static int reuse_worktree_file(const char *name, =
const unsigned char *sha1, int
 	 * If ce is marked as "assume unchanged", there is no
 	 * guarantee that work tree matches what we are looking for.
 	 */
-	if (ce->ce_flags & CE_VALID)
+	if ((ce->ce_flags & CE_VALID) || ce_skip_worktree(ce))
 		return 0;
=20
 	/*
diff --git a/read-cache.c b/read-cache.c
index 4e3e272..5ee7d9d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -265,7 +265,7 @@ int ie_match_stat(const struct index_state *istate,
 	 * If it's marked as always valid in the index, it's
 	 * valid whatever the checked-out copy says.
 	 */
-	if (!ignore_valid && (ce->ce_flags & CE_VALID))
+	if (!ignore_valid && ((ce->ce_flags & CE_VALID) || ce_skip_worktree(c=
e)))
 		return 0;
=20
 	/*
@@ -1004,11 +1004,7 @@ static struct cache_entry *refresh_cache_ent(str=
uct index_state *istate,
 	if (ce_uptodate(ce))
 		return ce;
=20
-	/*
-	 * CE_VALID means the user promised us that the change to
-	 * the work tree does not matter and told us not to worry.
-	 */
-	if (!ignore_valid && (ce->ce_flags & CE_VALID)) {
+	if (!ignore_valid && ((ce->ce_flags & CE_VALID) || ce_skip_worktree(c=
e))) {
 		ce_mark_uptodate(ce);
 		return ce;
 	}
diff --git a/t/t7011-skip-worktree-reading.sh b/t/t7011-skip-worktree-r=
eading.sh
new file mode 100755
index 0000000..e996928
--- /dev/null
+++ b/t/t7011-skip-worktree-reading.sh
@@ -0,0 +1,163 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
+#
+
+test_description=3D'skip-worktree bit test'
+
+. ./test-lib.sh
+
+cat >expect.full <<EOF
+H 1
+H 2
+H init.t
+H sub/1
+H sub/2
+EOF
+
+cat >expect.skip <<EOF
+S 1
+H 2
+H init.t
+S sub/1
+H sub/2
+EOF
+
+NULL_SHA1=3De69de29bb2d1d6434b8b29ae775ad8c2e48c5391
+ZERO_SHA0=3D0000000000000000000000000000000000000000
+setup_absent() {
+	test -f 1 && rm 1
+	git update-index --remove 1 &&
+	git update-index --add --cacheinfo 100644 $NULL_SHA1 1 &&
+	git update-index --skip-worktree 1
+}
+
+test_absent() {
+	echo "100644 $NULL_SHA1 0	1" > expected &&
+	git ls-files --stage 1 > result &&
+	test_cmp expected result &&
+	test ! -f 1
+}
+
+setup_dirty() {
+	git update-index --force-remove 1 &&
+	echo dirty > 1 &&
+	git update-index --add --cacheinfo 100644 $NULL_SHA1 1 &&
+	git update-index --skip-worktree 1
+}
+
+test_dirty() {
+	echo "100644 $NULL_SHA1 0	1" > expected &&
+	git ls-files --stage 1 > result &&
+	test_cmp expected result &&
+	echo dirty > expected
+	test_cmp expected 1
+}
+
+test_expect_success 'setup' '
+	test_commit init &&
+	mkdir sub &&
+	touch ./1 ./2 sub/1 sub/2 &&
+	git add 1 2 sub/1 sub/2 &&
+	git update-index --skip-worktree 1 sub/1 &&
+	git ls-files -t > result &&
+	test_cmp expect.skip result
+'
+
+test_expect_success 'update-index' '
+	setup_absent &&
+	git update-index 1 &&
+	test_absent
+'
+
+test_expect_success 'update-index' '
+	setup_dirty &&
+	git update-index 1 &&
+	test_dirty
+'
+
+test_expect_success 'update-index --remove' '
+	setup_absent &&
+	git update-index --remove 1 &&
+	test -z "$(git ls-files 1)" &&
+	test ! -f 1
+'
+
+test_expect_success 'update-index --remove' '
+	setup_dirty &&
+	git update-index --remove 1 &&
+	test -z "$(git ls-files 1)" &&
+	echo dirty > expected &&
+	test_cmp expected 1
+'
+
+test_expect_success 'ls-files --delete' '
+	setup_absent &&
+	test -z "$(git ls-files -d)"
+'
+
+test_expect_success 'ls-files --delete' '
+	setup_dirty &&
+	test -z "$(git ls-files -d)"
+'
+
+test_expect_success 'ls-files --modified' '
+	setup_absent &&
+	test -z "$(git ls-files -m)"
+'
+
+test_expect_success 'ls-files --modified' '
+	setup_dirty &&
+	test -z "$(git ls-files -m)"
+'
+
+test_expect_success 'grep with skip-worktree file' '
+	git update-index --no-skip-worktree 1 &&
+	echo test > 1 &&
+	git update-index 1 &&
+	git update-index --skip-worktree 1 &&
+	rm 1 &&
+	test "$(git grep --no-ext-grep test)" =3D "1:test"
+'
+
+echo ":000000 100644 $ZERO_SHA0 $NULL_SHA1 A	1" > expected
+test_expect_success 'diff-index does not examine skip-worktree absent =
entries' '
+	setup_absent &&
+	git diff-index HEAD -- 1 > result &&
+	test_cmp expected result
+'
+
+test_expect_success 'diff-index does not examine skip-worktree dirty e=
ntries' '
+	setup_dirty &&
+	git diff-index HEAD -- 1 > result &&
+	test_cmp expected result
+'
+
+test_expect_success 'diff-files does not examine skip-worktree absent =
entries' '
+	setup_absent &&
+	test -z "$(git diff-files -- one)"
+'
+
+test_expect_success 'diff-files does not examine skip-worktree dirty e=
ntries' '
+	setup_dirty &&
+	test -z "$(git diff-files -- one)"
+'
+
+test_expect_success 'git-rm succeeds on skip-worktree absent entries' =
'
+	setup_absent &&
+	git rm 1
+'
+
+test_expect_failure 'commit on skip-worktree absent entries' '
+	git reset &&
+	setup_absent &&
+	test_must_fail git commit -m null 1
+'
+
+test_expect_failure 'commit on skip-worktree dirty entries' '
+	git reset &&
+	setup_dirty &&
+	test_must_fail git commit -m null 1
+'
+
+test_done
--=20
1.6.3.GIT
