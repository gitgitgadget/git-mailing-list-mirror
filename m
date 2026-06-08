Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D51306768
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 06:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780900535; cv=pass; b=H86fHKU8mJ0rOKH2P6Qjn7gVlyJNWkLfFT+s/x8lZOMfMq0korw8PZpFweTb3+psz5Wk3P6MV5eCbHN6rU8NuO2piosti/snQ4LUnwEiAFm4AwBMgPHt23mOw+EeTzkPXVNSjh4Vl6HREnTBJcuSiD/jieMJnWdWK3OT+6Oxklg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780900535; c=relaxed/simple;
	bh=Xi3H/sbyVE+KrKMHuKiJ/Evug7tkFWT+KNts8WrYV+k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MKuPPu5IImuDDn4/SFa/pyeUl5zNI0Z7NsR1WmCEux3JDi8rdsYeS+r9xW+NizslFAbA5JvU3uLOCnPUB6zPPmb6Gjjm9Q/HI3d4un2kZaXBVBXAdURRm3AGT7ZPHgzOPUQ2nuVay+iFJHyNj4xQkTdUyD5RQ/IiIaqcXiT9C5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=vmiklos@collabora.com header.b=kkRRtBXp; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=vmiklos@collabora.com header.b="kkRRtBXp"
ARC-Seal: i=1; a=rsa-sha256; t=1780900524; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CzLB8hvDvrAm4/dszlO1oRyxo+Cmp+L7rmq7op2X+jL0OQG1BKpW5mXgivsx8UkaNrzWdx6M+ZPtJCsMsj/qQF9/VBtgEKYvXp201pDL9OlrV/UyM5cGqlbIEhydKWb1pJxN0aFTz1moVs5B30KSls2acPj5lBdz7wmVKMTeJgQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780900524; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iQKtpYc/ZvN7mZ7JoxXJ6Gctk25gIOxQR//FdWvuKes=; 
	b=BuHd42eUn0IOnmiGgCMjHzZVahnwS5r2OwZ1WpncF9HeQVhCd5GWbWkmIinBSGQuGWVnsp6YWjvIKFRRgkgdbXysKq2RXLmNdlzlnsBX/cwlBwn8/royU+ifv4VNkfCpWV5uZ9ukV3FpF4kd+XMdl/U0ZwKNusFyU1TfitckskA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vmiklos@collabora.com;
	dmarc=pass header.from=<vmiklos@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780900524;
	s=zohomail; d=collabora.com; i=vmiklos@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=iQKtpYc/ZvN7mZ7JoxXJ6Gctk25gIOxQR//FdWvuKes=;
	b=kkRRtBXpZXudgJ4dnY2sXSr6sASR3TNdrHVXjtCc4MNsViXqln8N1KeXh94XB4I0
	R5yTndombu/f0AEb37mYPru8MF+CpnWApWd0lp9Fr/kSN6x3eER3adMmJurvTOSZmUc
	vYnaiAUMDNIAezTCC4oHkGdltjCaCaVy9p+3GKaE=
Received: by mx.zohomail.com with SMTPS id 1780900522874484.18435005947117;
	Sun, 7 Jun 2026 23:35:22 -0700 (PDT)
Date: Mon, 8 Jun 2026 08:35:18 +0200
From: Miklos Vajna <vmiklos@collabora.com>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: [PATCH] log: improve --follow following renames for non-linear
 history
Message-ID: <aiZipugmA7z8oBcd@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjysz7r41.fsf@gitster.g>
X-ZohoMailClient: External

Have a repo with a subtree merge, do a 'git log --follow prefix/test.c',
the output only contains history in the outer repo, not commits that
were merged via a subtree merge.

What happened is that 'git log --follow' used to store the followed path
only in opt->diffopt.pathspec, so in case the commit history is
non-linear, and multiple parents had renames to the followed path, then
the end result wasn't really defined: the first commit that happened to
be visited in one of the parents updated opt->diffopt.pathspec, and from
that point, only that updated path was visited.

Fix the problem by introducing a commit -> path map
(follow_pathspec_slab) that stores that will be path to follow when
visiting that parent. At the top of log_tree_commit(), if the slab has
an entry for this commit, we replace opt->diffopt.pathspec with it, so
the correct path is followed, even if an unrelated sub-tree changed the
path to be followed to something else. After log_tree_diff() runs, we
record each parent's path in the slab: for a non-merge commit,
try_to_follow_renames() inside diff_tree_oid() has already updated
opt->diffopt.pathspec to the parent's name, so we just record it. For a
merge, log_tree_diff() is a no-op; we run a separate
diff_tree_oid(parent, commit, ...) with follow_renames=1 for each parent
and record the path it finds. As a result, the walk order doesn't
matter, which was exactly the source of problems previously.

This helps with subtree merges (rename happens inside the merge commit),
but also the general case when the rename happens in the history of
parents, not in the merge commit itself.
---

Hi Junio, Jeff,

On Tue, May 19, 2026 at 05:14:54PM +0900, Junio C Hamano <gitster@pobox.com> wrote:
> A minor "tweak" that does not solve this inherent design issue does
> not interest me, so...

Here is a patch that attempts to actually solve the problem you point
out here, by tracking what path should be followed for multiple branches
of the history.

It obsoletes the previous two "tweak" patches in this thread.

Hopefully this one is more interesting. :-)

Thanks,

Miklos

 Documentation/config/log.adoc |   3 +-
 log-tree.c                    | 116 ++++++++++++++++++++++++++++++++++
 log-tree.h                    |   1 +
 revision.c                    |   2 +
 revision.h                    |   4 ++
 t/meson.build                 |   1 +
 t/t4218-log-follow-merge.sh   |  80 +++++++++++++++++++++++
 7 files changed, 205 insertions(+), 2 deletions(-)
 create mode 100755 t/t4218-log-follow-merge.sh

diff --git a/Documentation/config/log.adoc b/Documentation/config/log.adoc
index f20cc25cd7..757a7be196 100644
--- a/Documentation/config/log.adoc
+++ b/Documentation/config/log.adoc
@@ -53,8 +53,7 @@ This is the same as the `--decorate` option of the `git log`.
 `log.follow`::
 	If `true`, `git log` will act as if the `--follow` option was used when
 	a single <path> is given.  This has the same limitations as `--follow`,
-	i.e. it cannot be used to follow multiple files and does not work well
-	on non-linear history.
+	i.e. it cannot be used to follow multiple files.
 
 `log.graphColors`::
 	A list of colors, separated by commas, that can be used to draw
diff --git a/log-tree.c b/log-tree.c
index 7e048701d0..e7f098e571 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -3,6 +3,7 @@
 
 #include "git-compat-util.h"
 #include "commit-reach.h"
+#include "commit-slab.h"
 #include "config.h"
 #include "diff.h"
 #include "diffcore.h"
@@ -1089,6 +1090,96 @@ static int do_remerge_diff(struct rev_info *opt,
 	return !opt->loginfo;
 }
 
+/* Per-commit pathspec storage for --follow across merges */
+define_commit_slab(follow_pathspec_slab, char *);
+
+static const char *pathspec_single_path(const struct pathspec *ps)
+{
+	if (ps->nr != 1)
+		return NULL;
+	return ps->items[0].match;
+}
+
+static void set_pathspec_to_single_path(struct pathspec *ps, const char *path)
+{
+	const char *paths[2] = { path, NULL };
+
+	clear_pathspec(ps);
+	parse_pathspec(ps,
+		       PATHSPEC_ALL_MAGIC & ~PATHSPEC_LITERAL,
+		       PATHSPEC_LITERAL_PATH, "", paths);
+}
+
+static void remember_follow_pathspec(struct rev_info *opt,
+				     struct commit *c, const char *path)
+{
+	char **slot;
+
+	if (!path)
+		return;
+	if (!opt->follow_pathspec_slab) {
+		opt->follow_pathspec_slab = xmalloc(sizeof(*opt->follow_pathspec_slab));
+		init_follow_pathspec_slab(opt->follow_pathspec_slab);
+	}
+	slot = follow_pathspec_slab_at(opt->follow_pathspec_slab, c);
+	if (*slot && !strcmp(*slot, path))
+		return;
+	free(*slot);
+	*slot = xstrdup(path);
+}
+
+static const char *recall_follow_pathspec(struct rev_info *opt,
+					  struct commit *c)
+{
+	char **slot;
+
+	if (!opt->follow_pathspec_slab)
+		return NULL;
+	slot = follow_pathspec_slab_peek(opt->follow_pathspec_slab, c);
+	return slot ? *slot : NULL;
+}
+
+static void free_follow_pathspec_slot(char **slot)
+{
+	FREE_AND_NULL(*slot);
+}
+
+void release_follow_pathspec_slab(struct rev_info *opt)
+{
+	if (!opt->follow_pathspec_slab)
+		return;
+	deep_clear_follow_pathspec_slab(opt->follow_pathspec_slab,
+					free_follow_pathspec_slot);
+	FREE_AND_NULL(opt->follow_pathspec_slab);
+}
+
+/* Compute the followed pathspec that should apply to parent. */
+static void propagate_follow_pathspec_to_parent(struct rev_info *opt,
+						struct commit *commit,
+						struct commit *parent)
+{
+	struct diff_options diff_opts;
+	const char *path;
+
+	parse_commit_or_die(parent);
+	repo_diff_setup(opt->diffopt.repo, &diff_opts);
+	copy_pathspec(&diff_opts.pathspec, &opt->diffopt.pathspec);
+	diff_opts.flags.recursive = 1;
+	diff_opts.flags.follow_renames = 1;
+	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_setup_done(&diff_opts);
+	diff_tree_oid(get_commit_tree_oid(parent),
+		      get_commit_tree_oid(commit),
+		      "", &diff_opts);
+
+	path = pathspec_single_path(&diff_opts.pathspec);
+	if (path)
+		remember_follow_pathspec(opt, parent, path);
+
+	diff_queue_clear(&diff_queued_diff);
+	diff_free(&diff_opts);
+}
+
 /*
  * Show the diff of a commit.
  *
@@ -1179,6 +1270,16 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
 	opt->loginfo = &log;
 	opt->diffopt.no_free = 1;
 
+	/* Any recorded pathspec for this commit? If so, restore it. */
+	if (opt->diffopt.flags.follow_renames) {
+		const char *stored = recall_follow_pathspec(opt, commit);
+		if (stored) {
+			const char *current = pathspec_single_path(&opt->diffopt.pathspec);
+			if (!current || strcmp(current, stored))
+				set_pathspec_to_single_path(&opt->diffopt.pathspec, stored);
+		}
+	}
+
 	/* NEEDSWORK: no restoring of no_free?  Why? */
 	if (opt->line_level_traverse)
 		return line_log_print(opt, commit);
@@ -1195,6 +1296,21 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
 		fprintf(opt->diffopt.file, "\n%s\n", opt->break_bar);
 	if (shown)
 		show_diff_of_diff(opt);
+
+	/* Record what pathspec each parent of this commit should use */
+	if (opt->diffopt.flags.follow_renames) {
+		struct commit_list *parents = get_saved_parents(opt, commit);
+		if (parents && parents->next) {
+			struct commit_list *p;
+			for (p = parents; p; p = p->next)
+				propagate_follow_pathspec_to_parent(opt, commit,
+								    p->item);
+		} else if (parents) {
+			remember_follow_pathspec(opt, parents->item,
+				pathspec_single_path(&opt->diffopt.pathspec));
+		}
+	}
+
 	opt->loginfo = NULL;
 	maybe_flush_or_die(opt->diffopt.file, "stdout");
 	opt->diffopt.no_free = no_free;
diff --git a/log-tree.h b/log-tree.h
index 07924be8bc..e8679b6c4a 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -26,6 +26,7 @@ struct decoration_options {
 int parse_decorate_color_config(const char *var, const char *slot_name, const char *value);
 int log_tree_diff_flush(struct rev_info *);
 int log_tree_commit(struct rev_info *, struct commit *);
+void release_follow_pathspec_slab(struct rev_info *);
 void show_log(struct rev_info *opt);
 void format_decorations(struct strbuf *sb, const struct commit *commit,
 			enum git_colorbool use_color, const struct decoration_options *opts);
diff --git a/revision.c b/revision.c
index 5693618be4..caa85fb4c6 100644
--- a/revision.c
+++ b/revision.c
@@ -26,6 +26,7 @@
 #include "decorate.h"
 #include "string-list.h"
 #include "line-log.h"
+#include "log-tree.h"
 #include "mailmap.h"
 #include "commit-slab.h"
 #include "cache-tree.h"
@@ -3284,6 +3285,7 @@ void release_revisions(struct rev_info *revs)
 	line_log_free(revs);
 	oidset_clear(&revs->missing_commits);
 	release_revisions_bloom_keyvecs(revs);
+	release_follow_pathspec_slab(revs);
 }
 
 static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
diff --git a/revision.h b/revision.h
index c9a11827cc..607113ca74 100644
--- a/revision.h
+++ b/revision.h
@@ -65,6 +65,7 @@ struct repository;
 struct rev_info;
 struct string_list;
 struct saved_parents;
+struct follow_pathspec_slab;
 struct bloom_keyvec;
 struct bloom_filter_settings;
 struct option;
@@ -354,6 +355,9 @@ struct rev_info {
 	/* copies of the parent lists, for --full-diff display */
 	struct saved_parents *saved_parents_slab;
 
+	/* per-commit pathspec for --follow across merges */
+	struct follow_pathspec_slab *follow_pathspec_slab;
+
 	struct commit_list *previous_parents;
 	struct commit_list *ancestry_path_bottoms;
 	const char *break_bar;
diff --git a/t/meson.build b/t/meson.build
index 2af8d01279..cd43e0609a 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -576,6 +576,7 @@ integration_tests = [
   't4215-log-skewed-merges.sh',
   't4216-log-bloom.sh',
   't4217-log-limit.sh',
+  't4218-log-follow-merge.sh',
   't4252-am-options.sh',
   't4253-am-keep-cr-dos.sh',
   't4254-am-corrupt.sh',
diff --git a/t/t4218-log-follow-merge.sh b/t/t4218-log-follow-merge.sh
new file mode 100755
index 0000000000..7a1b6fcb84
--- /dev/null
+++ b/t/t4218-log-follow-merge.sh
@@ -0,0 +1,80 @@
+#!/bin/sh
+
+test_description='Test --follow follows renames across merges'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+test_expect_success 'setup subtree-merged repository' '
+	git init inner &&
+	echo inner >inner/inner.txt &&
+	git -C inner add inner.txt &&
+	git -C inner commit -m "inner init" &&
+
+	git init outer &&
+	echo outer >outer/outer.txt &&
+	git -C outer add outer.txt &&
+	git -C outer commit -m "outer init" &&
+
+	git -C outer fetch ../inner master &&
+	git -C outer merge -s ours --no-commit --allow-unrelated-histories \
+		FETCH_HEAD &&
+	git -C outer read-tree --prefix=inner/ -u FETCH_HEAD &&
+	git -C outer commit -m "Merge inner repo into inner/ subdirectory"
+'
+
+test_expect_success '--follow finds the pre-merge commit through a subtree merge' '
+	git -C outer log --follow --pretty=tformat:%s inner/inner.txt >actual &&
+	echo "inner init" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'setup merge of two branches that both renamed a file to README' '
+	git init foo &&
+	mkdir foo/foo &&
+	echo "foo readme" >foo/foo/README &&
+	git -C foo add foo/README &&
+	git -C foo commit -m "add foo README" &&
+
+	git -C foo mv foo/README README &&
+	git -C foo commit -m "promote foo README to toplevel" &&
+
+	echo "foo c" >foo/foo.c &&
+	git -C foo add foo.c &&
+	git -C foo commit -m "add foo C impl" &&
+
+	git init bar &&
+	mkdir bar/bar &&
+	echo "bar readme" >bar/bar/README &&
+	git -C bar add bar/README &&
+	git -C bar commit -m "add bar README" &&
+
+	git -C bar mv bar/README README &&
+	git -C bar commit -m "promote bar README to toplevel" &&
+
+	echo "bar c" >bar/bar.c &&
+	git -C bar add bar.c &&
+	git -C bar commit -m "add bar C impl" &&
+
+	git -C foo fetch ../bar master &&
+	git -C foo merge -s ours --no-commit --allow-unrelated-histories \
+		FETCH_HEAD &&
+	git -C foo checkout FETCH_HEAD -- bar.c &&
+	git -C foo commit -m "merge bar into foo"
+'
+
+test_expect_success '--follow follows renames across both sides of a merge' '
+	git -C foo log --follow --pretty=tformat:%s README >actual &&
+	sort actual >actual.sorted &&
+	cat >expect <<-\EOF &&
+	add bar README
+	add foo README
+	promote bar README to toplevel
+	promote foo README to toplevel
+	EOF
+	test_cmp expect actual.sorted
+'
+
+test_done
-- 
2.51.0

