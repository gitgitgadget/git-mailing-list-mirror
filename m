Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB1D33D4E9
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 06:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781158733; cv=pass; b=tU0vWwKR5RhPKXV0l5Vb4DcsL5s0ftc9lYoB+4ZF0gNfhSHVHuzNEjwQajQrOcaSlbIEnP18DG7JoGtJH7RS9XN7UHjghgOg5P9C44l1znS/9bC4aXOF1swEGJ8l7tLhTQfBLO6oJGmMollUHQabKJiA5eEFcL2F0/XICGWCdB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781158733; c=relaxed/simple;
	bh=cR/Dud4ay1zDobrrmaKCmeEQY0CLtZLevmmGJKhMeNw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=b/955DIbpj3RoWOo+Rzc09Tzv+qn86XesMujcRZHJnuc+IfbyHmfjPiSm3aKrug9WYgCR9UHcEIopeIgBnEDMehEHwq87eKg06nDymVGr8PlnLiM1gVwN3nTCOA8/EJxU0sX/2CQvJLGt5JoteiC7hCsjf7tzp4xM2MXgdhYtYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=vmiklos@collabora.com header.b=eqXM9s0V; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=vmiklos@collabora.com header.b="eqXM9s0V"
ARC-Seal: i=1; a=rsa-sha256; t=1781158722; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YOSrLByQE72R8VKHHEuRlvZ/fHaUoVyjtGl84bURoy4P9bNcUA5mbcnnIK0AyhSeZKg+y2BAAdbQ9SnYW3fRA+XsdkbE9dO6vhhg8ZUPPXS1vsNKu62ZB5ure9j3rfi9munzZyqQXE5oHveqJNONTSVd2oHvYDPX1RoONF8HKqQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781158722; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ySeX5qq75F67BzGFv+4GbDLne8c69IBpUNXXuU4cfN4=; 
	b=l/JgwM+gRRCvfer0ZtoG43IGFFJFzVDWs2zkqYOGxucl8DWlVkTqsD0+Qxn7HyXjRaB+29uplhn9LNC86p4crqc0Jp8A/m4sVKnmjnPWCTQxIQgxrdfFQe9EHCdjhN7HR7ujwNnvk7ZJ0SMiOM68OneReBKQLoOtnTQCeAzN8QA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vmiklos@collabora.com;
	dmarc=pass header.from=<vmiklos@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781158722;
	s=zohomail; d=collabora.com; i=vmiklos@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=ySeX5qq75F67BzGFv+4GbDLne8c69IBpUNXXuU4cfN4=;
	b=eqXM9s0VLtPlV1E0ySaOO729WBAL2ahhtehD5i9GNeCvLXKwHHrZg41cyY5b5lVy
	TMFlbRFh0YrCpR7SOmoBV8mpJeDMylH3O52XDWLaN033Epxj5wvHrMxzD2vqm9cbATr
	+1ryqoj7Ie6SV38WJ5P7N/uAgWXMiK+IOs1A8Q5s=
Received: by mx.zohomail.com with SMTPS id 1781158719599214.53368294554411;
	Wed, 10 Jun 2026 23:18:39 -0700 (PDT)
Date: Thu, 11 Jun 2026 08:18:34 +0200
From: Miklos Vajna <vmiklos@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: [PATCH v2] log: improve --follow following renames for non-linear
 history
Message-ID: <aipTOsH8LKTSwglj@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpl21vzj2.fsf@gitster.g>
X-ZohoMailClient: External

Have a repo with a subtree merge, do a 'git log --follow prefix/test.c',
the output only contains history in the outer repo, not commits that
were merged via a subtree merge.

What happens is that 'git log --follow' stores the followed path only in
opt->diffopt.pathspec, so in case the commit history is non-linear, and
multiple parents have renames to the followed path, then the end result
isn't really defined: the first commit that happens to be visited in one
of the parents update opt->diffopt.pathspec, and from that point, only
that updated path is visited.

Fix the problem by introducing a commit -> paths map
(follow_pathspec_slab) that stores what will be paths to follow when
visiting that parent. At the top of log_tree_commit(), if the slab has
an entry for this commit, we replace opt->diffopt.pathspec with paths
from this entry, so the correct paths are followed, even if an unrelated
sub-tree changed the paths to be followed to something else. After
log_tree_diff() runs, we record each parent's paths in the slab. As a
result, the walk order doesn't matter, which was exactly the source of
problems previously.

This helps with subtree merges (rename happens inside the merge commit),
but also fixes the general case when the rename happens in the history
of parents, not in the merge commit itself. This does not remove the
limitation that only a single path can be specified on the command-line,
but we now do follow multiple paths instead of a "last write wins"
situation when determining what path to follow for a specific commit
with multiple previously visited children.
---

Hi Junio,

On Mon, Jun 08, 2026 at 08:10:25AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> When describing a problematic symptom you are trying to improve, you
> should talk about the current state of the system in the present
> tense.  "used to store" makes it sound like in ancient times back
> when Linus wrote the first version of this feature it was so, but a
> few years ago that changed, but that is not what you want to say, is
> it?
> 
> The above may sound picky, but using the consistent style of
> description makes it easier to follow the thought process,
> especially when you need to read many commits to understand what is
> going on.

Makes sense, I now fixed this.

> Can a "map" cut it?
> 
> If a history forked at commit A, with two children commit B and
> commit C, and you started traversing the history from a much later
> descendant M that merges these two lines of history (i.e., M^1
> contains B, M^2 contains C, and A==B^1==C^1), while traversing down
> from M to B you may find that you need to follow path1 and similarly
> somewhere between M down to C the path you are following may be
> path2.  And the traversal meets at A.  The slab records path1 for B
> and path2 for C.  Wouldn't you need to be able to store both path1
> and path2 for commit A?  What path do you need to pay attention to
> when traversing past A to its ancestors?

Indeed, I focused on merge commits and their parents and I did not 
consider that slab[A] may be set to path1 when visiting one parent and 
then slab[A] may be set to path2 when visiting an other parent -- even 
if "A" itself is just a plain commit with no renames and is not a merge.

Here is an updated version, where I changed the value of 
follow_pathspec_slab to be a string_list, and appended a new test that 
shows we now handle this case.

Thanks,

Miklos

 Documentation/config/log.adoc |   3 +-
 log-tree.c                    | 133 ++++++++++++++++++++++++++++++++++
 log-tree.h                    |   1 +
 revision.c                    |   2 +
 revision.h                    |   4 +
 t/meson.build                 |   1 +
 t/t4218-log-follow-merge.sh   | 119 ++++++++++++++++++++++++++++++
 7 files changed, 261 insertions(+), 2 deletions(-)
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
index 7e048701d0..f6f396be22 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -3,6 +3,7 @@
 
 #include "git-compat-util.h"
 #include "commit-reach.h"
+#include "commit-slab.h"
 #include "config.h"
 #include "diff.h"
 #include "diffcore.h"
@@ -1089,6 +1090,104 @@ static int do_remerge_diff(struct rev_info *opt,
 	return !opt->loginfo;
 }
 
+/* Per-commit paths storage for --follow across merges */
+define_commit_slab(follow_pathspec_slab, struct string_list);
+
+static const char *pathspec_single_path(const struct pathspec *ps)
+{
+	if (ps->nr != 1)
+		return NULL;
+	return ps->items[0].match;
+}
+
+static void set_pathspec_to_paths(struct pathspec *ps,
+				  const struct string_list *paths)
+{
+	const char **argv;
+	struct string_list_item *item;
+	int i = 0;
+
+	clear_pathspec(ps);
+	if (!paths->nr)
+		return;
+	ALLOC_ARRAY(argv, paths->nr + 1);
+	for_each_string_list_item(item, paths)
+		argv[i++] = item->string;
+	argv[i] = NULL;
+	parse_pathspec(ps,
+		       PATHSPEC_ALL_MAGIC & ~PATHSPEC_LITERAL,
+		       PATHSPEC_LITERAL_PATH, "", argv);
+	free(argv);
+}
+
+static struct string_list *get_follow_pathspec_at(struct rev_info *opt,
+						  struct commit *c)
+{
+	struct string_list *list;
+
+	if (!opt->follow_pathspec_slab) {
+		opt->follow_pathspec_slab = xmalloc(sizeof(*opt->follow_pathspec_slab));
+		init_follow_pathspec_slab(opt->follow_pathspec_slab);
+	}
+	list = follow_pathspec_slab_at(opt->follow_pathspec_slab, c);
+	if (!list->strdup_strings)
+		list->strdup_strings = 1;
+	return list;
+}
+
+static void remember_follow_pathspec(struct rev_info *opt,
+				     struct commit *c, const char *path)
+{
+	if (!path)
+		return;
+	string_list_insert(get_follow_pathspec_at(opt, c), path);
+}
+
+static void free_follow_pathspec_slot(struct string_list *slot)
+{
+	string_list_clear(slot, 0);
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
+/* Compute a path to follow in parent, if there is one */
+static void propagate_follow_pathspec_to_parent(struct rev_info *opt,
+						const char *path,
+						struct commit *commit,
+						struct commit *parent)
+{
+	struct diff_options diff_opts;
+	const char *paths[2] = { path, NULL };
+	const char *out_path;
+
+	parse_commit_or_die(parent);
+	repo_diff_setup(opt->diffopt.repo, &diff_opts);
+	parse_pathspec(&diff_opts.pathspec,
+		       PATHSPEC_ALL_MAGIC & ~PATHSPEC_LITERAL,
+		       PATHSPEC_LITERAL_PATH, "", paths);
+	diff_opts.flags.recursive = 1;
+	diff_opts.flags.follow_renames = 1;
+	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_setup_done(&diff_opts);
+	diff_tree_oid(get_commit_tree_oid(parent),
+		      get_commit_tree_oid(commit),
+		      "", &diff_opts);
+
+	out_path = pathspec_single_path(&diff_opts.pathspec);
+	if (out_path)
+		remember_follow_pathspec(opt, parent, out_path);
+
+	diff_queue_clear(&diff_queued_diff);
+	diff_free(&diff_opts);
+}
+
 /*
  * Show the diff of a commit.
  *
@@ -1173,12 +1272,30 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
 	int shown;
 	/* maybe called by e.g. cmd_log_walk(), maybe stand-alone */
 	int no_free = opt->diffopt.no_free;
+	int saved_follow_renames = 0;
+	struct string_list *paths = NULL;
 
 	log.commit = commit;
 	log.parent = NULL;
 	opt->loginfo = &log;
 	opt->diffopt.no_free = 1;
 
+	/* Any recorded paths for this commit? If so, restore it */
+	if (opt->diffopt.flags.follow_renames) {
+		paths = get_follow_pathspec_at(opt, commit);
+		if (!paths->nr) {
+			const char *path = pathspec_single_path(&opt->diffopt.pathspec);
+			if (path)
+				string_list_insert(paths, path);
+		}
+		set_pathspec_to_paths(&opt->diffopt.pathspec, paths);
+		if (paths->nr > 1) {
+			/* diff_check_follow_pathspec() doesn't handle multiple paths */
+			saved_follow_renames = opt->diffopt.flags.follow_renames;
+			opt->diffopt.flags.follow_renames = 0;
+		}
+	}
+
 	/* NEEDSWORK: no restoring of no_free?  Why? */
 	if (opt->line_level_traverse)
 		return line_log_print(opt, commit);
@@ -1195,6 +1312,22 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
 		fprintf(opt->diffopt.file, "\n%s\n", opt->break_bar);
 	if (shown)
 		show_diff_of_diff(opt);
+
+	if (saved_follow_renames)
+		opt->diffopt.flags.follow_renames = saved_follow_renames;
+
+	/* Record what paths each parent of this commit should use */
+	if (opt->diffopt.flags.follow_renames && paths) {
+		struct commit_list *parents = get_saved_parents(opt, commit);
+		struct commit_list *p;
+		struct string_list_item *item;
+		for (p = parents; p; p = p->next) {
+			for_each_string_list_item(item, paths)
+				propagate_follow_pathspec_to_parent(opt,
+					item->string, commit, p->item);
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
index c5832fee05..faecae2b50 100644
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
index 0000000000..dcb0c937d7
--- /dev/null
+++ b/t/t4218-log-follow-merge.sh
@@ -0,0 +1,119 @@
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
+# When two branches rename a different file to the same name and then meet again
+# in a merge, log --follow needs to keep track both paths.
+test_expect_success 'setup criss-cross merge where two paths converge in ancestor' '
+	git init crisscross &&
+	echo "alpha content" >crisscross/alpha.txt &&
+	git -C crisscross add alpha.txt &&
+	git -C crisscross commit -m "root: add alpha.txt" &&
+
+	echo "beta content" >crisscross/beta.txt &&
+	git -C crisscross add beta.txt &&
+	git -C crisscross commit -m "fork: add beta.txt" &&
+
+	git -C crisscross checkout -b branchB &&
+	git -C crisscross mv alpha.txt combined.txt &&
+	git -C crisscross rm beta.txt &&
+	git -C crisscross commit -m "B: rename alpha to combined" &&
+
+	git -C crisscross checkout master &&
+	git -C crisscross checkout -b branchC &&
+	git -C crisscross mv beta.txt combined.txt &&
+	git -C crisscross rm alpha.txt &&
+	git -C crisscross commit -m "C: rename beta to combined" &&
+
+	git -C crisscross checkout branchB &&
+	git -C crisscross merge -s ours -m "merge C into B" branchC
+'
+
+test_expect_success '--follow follows two diverged paths past their common ancestor' '
+	git -C crisscross log --follow --pretty=tformat:%s combined.txt >actual &&
+	sort actual >actual.sorted &&
+	cat >expect <<-\EOF &&
+	B: rename alpha to combined
+	C: rename beta to combined
+	fork: add beta.txt
+	root: add alpha.txt
+	EOF
+	test_cmp expect actual.sorted
+'
+
+test_done
-- 
2.51.0

