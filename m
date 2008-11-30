From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/8] checkout: add new options to support sparse checkout
Date: Sun, 30 Nov 2008 17:54:36 +0700
Message-ID: <1228042478-1886-7-git-send-email-pclouds@gmail.com>
References: <1228042478-1886-1-git-send-email-pclouds@gmail.com>
 <1228042478-1886-2-git-send-email-pclouds@gmail.com>
 <1228042478-1886-3-git-send-email-pclouds@gmail.com>
 <1228042478-1886-4-git-send-email-pclouds@gmail.com>
 <1228042478-1886-5-git-send-email-pclouds@gmail.com>
 <1228042478-1886-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 11:57:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6jzm-0005sQ-4F
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 11:57:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbYK3Kzt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2008 05:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbYK3Kzt
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 05:55:49 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:45771 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbYK3Kzr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 05:55:47 -0500
Received: by wa-out-1112.google.com with SMTP id v27so952230wah.21
        for <git@vger.kernel.org>; Sun, 30 Nov 2008 02:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=6FIHVmGUd+JE70eudQRbOrnT1IIOA/7uDPhKpxYKxC8=;
        b=GvqI3cT2WRq28R2v4jm8wK5OQh7e8Tu9ZozF+Uw5ntH3CRrGQQqGw8s5VJvTcDQ13I
         mj5ImsR5ApsLVrHH++RvQlVF4dKPVfuotUcL7i0AsFxhMPqR03/WszsKa3S6LRORJlhv
         tYKM/AfcbuEHMTegX6AVFO+D/r1XYYJAKhv9c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=xcKnXo+d7693mW/AnvmP/W2pplCPuwOMA2n1QNtHQYLjTREDYdWjQ5bI7K42z7Iv5v
         4zFCK/4t067POzSf5AvxBHk3X8DJVvTycT8at5S7oL2g5WWl4tPgJpIACl07Epdts3Y2
         mFcqNJEVJKu3oA5kfqoIjqwu1UkdlsvkFHfsY=
Received: by 10.114.95.1 with SMTP id s1mr5706459wab.20.1228042545899;
        Sun, 30 Nov 2008 02:55:45 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.32])
        by mx.google.com with ESMTPS id z20sm3199835pod.20.2008.11.30.02.55.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 30 Nov 2008 02:55:43 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 30 Nov 2008 17:55:28 +0700
X-Mailer: git-send-email 1.6.0.3.890.g95457
In-Reply-To: <1228042478-1886-6-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101967>

This patch adds main interface to manipulate sparse checkout.
New options are added to support entering/updating/leaving sparse
checkout:

 --full: return to full checkout (default)
 --sparse: set checkout area according to given spec
 --{include,exclude}-sparse: adjust current sparse checkout area

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-checkout.txt |   55 ++++++++++++++++-
 builtin-checkout.c             |   39 ++++++++++++
 t/t2011-checkout-sparse.sh     |  128 ++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 219 insertions(+), 3 deletions(-)
 create mode 100755 t/t2011-checkout-sparse.sh

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index 0813d9f..b32043f 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -8,8 +8,10 @@ git-checkout - Checkout a branch or paths to the worki=
ng tree
 SYNOPSIS
 --------
 [verse]
-'git checkout' [-q] [-f] [--track | --no-track] [-b <new_branch> [-l]]=
 [-m] [<branch>]
-'git checkout' [-f|--ours|--theirs|-m|--conflict=3D<style>] [<tree-ish=
>] [--] <paths>...
+'git checkout' [-q] [-f] [--track | --no-track] [-b <new_branch> [-l]]=
 [-m]
+	  [<sparse checkout options>] [<branch>]
+'git checkout' [-f|--ours|--theirs|-m|--conflict=3D<style>] [<tree-ish=
>]
+	  [<sparse checkout options>] [--] <paths>...
=20
 DESCRIPTION
 -----------
@@ -34,6 +36,10 @@ used to specify a specific tree-ish (i.e. commit, ta=
g or tree)
 to update the index for the given paths before updating the
 working tree.
=20
+<sparse checkout options> include --full, --sparse, --include-sparse
+and --exclude-sparse. The last three require sparse patterns. Please r=
efer
+to "sparse checkout" section for more information about this mode.
+
 The index may contain unmerged entries after a failed merge.  By
 default, if you try to check out such an entry from the index, the
 checkout operation will fail and nothing will be checked out.
@@ -117,6 +123,35 @@ should result in deletion of the path).
 When checking out paths from the index, this option lets you recreate
 the conflicted merge in the specified paths.
=20
+--full::
+	Quit sparse checkout mode. Return to full checkout.
+	This option cannot be used with either --sparse,
+	--include-sparse, --exclude-sparse or <paths>.
+
+-S=3D<sparse patterns>::
+--sparse=3D<sparse patterns>::
+	Re-apply new sparse patterns on current working directory to
+	form new checkout area. All no-checkout bits will be wiped
+	out before applying the patterns.
+	This option cannot be used with --full, --include-sparse,
+	--exclude-sparse or <paths>. Multiple --sparse is not allowed.
+
+-I=3D<sparse patterns>::
+--include-sparse=3D<sparse patterns>::
+	Checkout more areas specified by sparse patterns to current
+	checkout area. Already checked out entries are not affected.
+	This option cannot be used with --full, --sparse,
+	--exclude-sparse or <paths>. Multiple --include-sparse is not allowed=
=2E
+
+-E=3D<sparse patterns>::
+--exclude-sparse=3D<sparse patterns>::
+	Narrow checkout area by removing files specified by sparse patterns
+	from current checkout area. This operation will fail if there
+	are unmerged or modified files in the removing areas. No-checkout
+	entries are not affected.
+	This option cannot be used with --full, --sparse,
+	--include-sparse or <paths>. Multiple --exclude-sparse is not allowed=
=2E
+
 --conflict=3D<style>::
 	The same as --merge option above, but changes the way the
 	conflicting hunks are presented, overriding the
@@ -186,7 +221,10 @@ Because sparse checkout uses a new index format, i=
t will be
 incompatible with git prior to 1.6.0 regarding worktree operations.
 Operations that only need access to the repository itself, such as
 clone, push, or pull/fetch from another (normal) repository... should
-not be affected by sparse checkout.
+not be affected by sparse checkout. In order to make your working
+directory work again with those versions, you can use
+`git checkout --full` to return to normal mode (and compatible index
+format).
=20
 In sparse checkout mode, checkout status of every files in your
 working directory will be recorded in index. If a file is marked
@@ -263,6 +301,17 @@ Patterns have the following format:
  - Sparse patterns do not apply to .gitignore and .gitattributes
    files. They are always checked out.
=20
+When you apply new sparse patterns to your working directory using eit=
her
+--sparse, --include-sparse or --exclude-sparse, it will update "checko=
ut" status
+in index accordingly. Moreover, if a file is marked "no-checkout" and
+is present in working directory, it will be removed. If a file is
+turned from "no-checkout" to "checkout", then it will be added again
+to working directory. Unmerged entries will always be "checkout" regar=
dless
+the sparse patterns. Modified entries will refuse to become "no-checko=
ut".
+
+You can form your checkout area in one go with --sparse option,
+or do it incrementally with --include-sparse and --exclude-sparse.
+
 EXAMPLES
 --------
=20
diff --git a/builtin-checkout.c b/builtin-checkout.c
index 7f3bd7b..be4cd3a 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -33,6 +33,12 @@ struct checkout_opts {
 	const char *new_branch;
 	int new_branch_log;
 	enum branch_track track;
+
+	const char *prefix;
+	char *new_path;
+	char *add_path;
+	char *remove_path;
+	int all_path;
 };
=20
 static int post_checkout_hook(struct commit *old, struct commit *new,
@@ -388,6 +394,7 @@ static int merge_working_tree(struct checkout_opts =
*opts,
 		topts.dst_index =3D &the_index;
=20
 		topts.msgs.not_uptodate_file =3D "You have local changes to '%s'; ca=
nnot switch branches.";
+		topts.msgs.sparse_not_uptodate_file =3D "You have local changes to '=
%s'; cannot update sparse checkout.";
=20
 		refresh_cache(REFRESH_QUIET);
=20
@@ -411,7 +418,25 @@ static int merge_working_tree(struct checkout_opts=
 *opts,
 		tree =3D parse_tree_indirect(new->commit->object.sha1);
 		init_tree_desc(&trees[1], tree->buffer, tree->size);
=20
+		if (opts->all_path) {
+			/* leave narrow_spec NULL */
+			topts.new_narrow_path =3D 1;
+		}
+		else if (opts->new_path) {
+			topts.narrow_spec =3D parse_narrow_spec(opts->new_path, opts->prefi=
x);
+			topts.new_narrow_path =3D 1;
+		}
+		else if (opts->add_path) {
+			topts.narrow_spec =3D parse_narrow_spec(opts->add_path, opts->prefi=
x);
+			topts.add_narrow_path =3D 1;
+		}
+		else if (opts->remove_path) {
+			topts.narrow_spec =3D parse_narrow_spec(opts->remove_path, opts->pr=
efix);
+			topts.remove_narrow_path =3D 1;
+		}
+
 		ret =3D unpack_trees(2, trees, &topts);
+		free_narrow_spec(topts.narrow_spec);
 		if (ret =3D=3D -1) {
 			/*
 			 * Unpack couldn't do a trivial merge; either
@@ -598,6 +623,10 @@ int cmd_checkout(int argc, const char **argv, cons=
t char *prefix)
 		OPT_BOOLEAN('m', "merge", &opts.merge, "merge"),
 		OPT_STRING(0, "conflict", &conflict_style, "style",
 			   "conflict style (merge or diff3)"),
+		OPT_BOOLEAN(0, "full", &opts.all_path, "quit sparse checkout"),
+		OPT_STRING('S', "sparse", &opts.new_path, "sparse patterns", "set ne=
w sparse checkout"),
+		OPT_STRING('I', "include-sparse", &opts.add_path, "sparse patterns",=
 "widen checkout area"),
+		OPT_STRING('E', "exclude-sparse", &opts.remove_path, "sparse pattern=
s", "narrow checkout area"),
 		OPT_END(),
 	};
 	int has_dash_dash;
@@ -608,6 +637,7 @@ int cmd_checkout(int argc, const char **argv, const=
 char *prefix)
 	git_config(git_checkout_config, NULL);
=20
 	opts.track =3D BRANCH_TRACK_UNSPECIFIED;
+	opts.prefix =3D prefix;
=20
 	argc =3D parse_options(argc, argv, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
@@ -634,6 +664,12 @@ int cmd_checkout(int argc, const char **argv, cons=
t char *prefix)
 		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
 	}
=20
+	if (((opts.all_path ? 1 : 0) +
+	     (opts.new_path ? 1 : 0) +
+	     (opts.add_path ? 1 : 0) +
+	     (opts.remove_path ? 1 : 0)) > 1)
+		die("git checkout: --full, --sparse, --include-sparse and --exclude-=
sparse are incompatible");
+
 	if (opts.force && opts.merge)
 		die("git checkout: -f and -m are incompatible");
=20
@@ -727,6 +763,9 @@ no_reference:
 		if (1 < !!opts.writeout_stage + !!opts.force + !!opts.merge)
 			die("git checkout: --ours/--theirs, --force and --merge are incompa=
tible when\nchecking out of the index.");
=20
+		if (opts.all_path || opts.new_path || opts.add_path || opts.remove_p=
ath)
+			die("git checkout: updating paths is incompatible with setting spar=
se checkout");
+
 		return checkout_paths(source_tree, pathspec, &opts);
 	}
=20
diff --git a/t/t2011-checkout-sparse.sh b/t/t2011-checkout-sparse.sh
new file mode 100755
index 0000000..67aea96
--- /dev/null
+++ b/t/t2011-checkout-sparse.sh
@@ -0,0 +1,128 @@
+#!/bin/sh
+
+test_description=3D'sparse checkout'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	mkdir work1 work2 work3
+	touch one two three
+	touch work1/one work2/two work3/three
+	touch .gitignore .gitattributes
+	touch work3/.gitignore work3/.gitattributes
+	git add .gitignore .gitattributes
+	git add work3/.gitignore work3/.gitattributes
+	git add one work1/one
+	git commit -m work1 && WORK1=3D$(git rev-parse HEAD)
+	echo conflict >> work1/one
+	git add work1/one
+	git commit -m "work1 conflict" && WORK1CONFLICT=3D$(git rev-parse HEA=
D)
+	git checkout $WORK1
+	echo one >> one
+	echo work1/1 >> work1/one
+	git add one work1/one
+	git commit -m "work1 modified" && WORK1MODIFIED=3D$(git rev-parse HEA=
D)
+	git add two work2/two
+	git commit -m work2 && WORK2=3D$(git rev-parse HEAD)
+	git add three work3/three
+	git commit -m work3 && WORK3=3D$(git rev-parse HEAD)
+'
+
+test_expect_success '--full on no-narrow checkout' '
+	git checkout --full
+'
+
+test_expect_success '--full and --sparse incompatible' '
+	test_must_fail git checkout --full --sparse=3Dwork1
+'
+
+test_expect_success 'limit worktree to work1 and work2' '
+	git checkout --sparse=3Dwork1/:work2/ &&
+	test -f work1/one &&
+	test -f work2/two &&
+	! test -f work3/three
+'
+
+test_expect_success 'exit sparse checkout' '
+	git checkout --full &&
+	test -f work1/one &&
+	test -f work2/two &&
+	test -f work3/three &&
+	test -f one
+'
+
+test_expect_success 'sparse checkout does not touch .git*' '
+	git checkout --sparse=3Dwork1/:work2/ &&
+	test -f .gitignore &&
+	test -f .gitattributes &&
+	test -f work3/.gitignore &&
+	test -f work3/.gitattributes
+'
+
+# merged_entry case with old !=3D NULL, same_entry =3D 1
+# work1/ turns to no-checkout
+# work3/ turns to checkout
+test_expect_success 'update worktree to work2 and work3' '
+	git checkout --sparse=3Dwork2/:work3/ &&
+	! test -f work1/one &&
+	test -f work2/two &&
+	test -f work3/three
+'
+
+test_expect_success 'update narrow prefix with modification' '
+	echo modified >> work2/two &&
+	git checkout --sparse=3Dwork1/:work2/ &&
+	test -f work1/one &&
+	test -f work2/two &&
+	! test -f work3/three &&
+	grep -q modified work2/two &&
+
+	! git checkout --sparse=3Dwork1/:work3/ &&
+	test -f work1/one &&
+	test -f work2/two &&
+	! test -f work3/three &&
+	grep -q modified work2/two &&
+	git checkout work2/two
+'
+
+test_expect_success 'widen checkout area' '
+	git checkout --include-sparse=3Dwork3/ &&
+	test -f work1/one &&
+	test -f work2/two &&
+	test -f work3/three
+'
+
+test_expect_success 'narrow checkout area' '
+	git checkout --exclude-sparse=3Dwork3/ &&
+	test -f work1/one &&
+	test -f work2/two &&
+	! test -f work3/three
+'
+
+test_expect_success 'update outside checkout area' '
+	git checkout --full &&
+	git checkout $WORK1 &&
+	git checkout --sparse work2/ &&
+	! test -f work1/one &&
+	git checkout $WORK1MODIFIED &&
+	! test -f work1/one &&
+	git checkout --full master
+'
+
+test_expect_success 'conflict outside checkout area' '
+	git checkout --sparse=3D"work2/" $WORK1MODIFIED &&
+	test -z "$(git ls-files --sparse work1/one)" &&
+	git merge $WORK1CONFLICT
+	test $? =3D 1 &&
+	test -n "$(git ls-files --sparse work1/one)" &&
+	git reset --hard &&
+	git checkout master
+'
+
+test_expect_success 'removal outside checkout area' '
+	git rm work1/one &&
+	git commit -m remove &&
+	git checkout --sparse=3Dwork2/ HEAD^
+'
+
+test_done
--=20
1.6.0.3.890.g95457
