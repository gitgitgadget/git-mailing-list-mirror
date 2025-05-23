Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06CC1F09B4
	for <git@vger.kernel.org>; Fri, 23 May 2025 09:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747992855; cv=none; b=bVBF+gkSZ7XfJCqu4CtHjLul6PyypXRzk9dAN8e/ojdhxQ7iU208NNKfV64DbOfZcGoefWXp+UP7Nk4G2C1Q5sx+0x1o7v7i/PwF24MVwyYwHdeejBh/ft6XMX3T4UB5J3fTuwmerL9wP9PvYsp9Bl/JQActyS/Xd9QMChPhLT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747992855; c=relaxed/simple;
	bh=wWtcB3DMYt0rS8Iy++KppDpi5EqQIwlCz4SesIs6OyY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=Xcrdn9mInzFk1XJp/TIWwpbRMyfwy3WmWQbYwLQhm8pUc5KOK2pJCMvs2wJoeBXdJaresKa+2TXSMQvLQ7HxOtglG62VEotQT46sBEVgjv5MAX2N5Fkacg4fi0IbXQ1CJAuF7Fdhls/VHOMVLbYocyA4s1a58nzYoHRbszXUkk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=acUgyV4c; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="acUgyV4c"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1747992844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ABB/ErphF+iek0kAap6vZ9RxwP37MRmiz6yj6JTTfuc=;
	b=acUgyV4cqxtlrNaoVI+bFwrjH8RCS88ZOaV6v5fYegv0hMSLjHCDtmISRHHko21kEvVDzs
	gbnsEzYDvp3148crpqU/TWP2CmxD/Ku/CmSWBmtyoaEDC6bjjimJs6oKtzg2VavATXSmvX
	o9DvIhZXw/TMfiCSniFN7meuxbO6+g0=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH RFC v2 0/5] Introduce git-last-modified(1) command
Date: Fri, 23 May 2025 11:33:47 +0200
Message-Id: <20250523-toon-new-blame-tree-v2-0-101e4ca4c1c9@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPtAMGgC/22NwQrCMBBEf6Xs2ZUktlg9FQQ/wKv0kKRbu9Amk
 oSqlP67oV49vhnmzQKRAlOEc7FAoJkje5dB7Qqwg3YPQu4ygxKqEqUUmLx36OiFZtQTYQpEaGx
 nzLG20ooe8vIZqOf3Zr3D7XqBNocDx+TDZ3ua5Vb9pEr9lc4SBfadqaSp9eFU6oZ9suPe+gnad
 V2/GCnAqLsAAAA=
X-Change-ID: 20250410-toon-new-blame-tree-bcdbb78c1c0f
In-Reply-To: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
References: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, 
 Derrick Stolee <stolee@gmail.com>, Toon Claes <toon@iotcl.com>, 
 =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>, 
 Derrick Stolee <stolee@gmail.com>
X-Migadu-Flow: FLOW_OUT

This is another attempt to upstream the ~~git-blame-tree(1)~~
git-last-modified(1) subcommand. After my previous attempt[1] the
people of GitHub shared their version of the subcommand, and this
version integrates those changes.

What is different from the series shared by GitHub:

* Renamed the subcommand from `blame-tree` to `last-modified`. There was
  some consensus[4] this name works better, so let's give it a try and
  see how this name feels.

* Patches for --max-depth are excluded. I think it's a separate topic to
  discuss and I'm not sure it needs to be part of series anyway. The
  main patch was submitted in the previous attempt[2] and if people
  consider it valuable, I'm happy to discuss that in a separate patch
  series.

* The patches in 'tb/blame-tree' at Taylor's fork[3] implements a
  caching layer. This feature reads/writes cached results in
  `.git/blame-tree/<hash>.btc`. To keep this series to a reviewable
  size, that feature is excluded from this series. I think it's better
  to submit this as a separate series.

* Squashed various commits together. Like they introduced a flag
  `--go-faster`, which later became the default and only implementation.
  That story was wrapped up in a single commit.

* The last-modified command isn't recursive by default. If you want
  recurse into subtrees, you need to pass `-r`.

* Fixed all memory leaks, and removed the use of
  USE_THE_REPOSITORY_VARIABLE.

I've attempted to reuse commit messages as good as possible, but feel
free to correct me where you think I didn't give proper credit or messed
up. Although I have no idea what to do with the Signed-off-by trailers.

I didn't modify the benchmark results in the commit messages, simply
because I didn't get comparable results. In my benchmarks the difference
between two implementations was negligible, and even in some scenarios
the performance was worse in the "improved" implementation. As far as I
can tell, I didn't break anything in my refactoring, because the version
in these patches acts similar to Taylor's branch. To be honest, I cannot
explain why...?

Again thanks to Taylor and the people at GitHub for sharing these
patches. I hope we can work together to get this upstreamed.

[1]: https://lore.kernel.org/git/20250326-toon-blame-tree-v1-0-4173133f3786@iotcl.com/
[2]: https://lore.kernel.org/git/20250326-toon-blame-tree-v1-3-4173133f3786@iotcl.com/
[3]: git@github.com:ttaylorr/git.git
[4]: https://lore.kernel.org/git/aCbBKj7O9LjO3SMK@pks.im/
--
Cheers,
Toon

Signed-off-by: Toon Claes <toon@iotcl.com>
---
Changes in v2:
- The subcommand is renamed from `blame-tree` to `last-modified`
- Documentation is added. Here we mark the command as experimental.
- Some test cases are added related to merges.
- Link to v1: https://lore.kernel.org/r/20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com

---
Jeff King (1):
      t/perf: add last-modified perf script

Toon Claes (4):
      last-modified: new subcommand to show when files were last modified
      last-modified: use Bloom filters when available
      last-modified: implement faster algorithm
      last-modified: initialize revision machinery without walk

 .gitignore                           |   1 +
 Documentation/git-last-modified.adoc |  49 ++++
 Documentation/meson.build            |   1 +
 Makefile                             |   2 +
 builtin.h                            |   1 +
 builtin/last-modified.c              |  43 +++
 command-list.txt                     |   1 +
 git.c                                |   1 +
 last-modified.c                      | 496 +++++++++++++++++++++++++++++++++++
 last-modified.h                      |  30 +++
 meson.build                          |   2 +
 t/meson.build                        |   2 +
 t/perf/p8020-last-modified.sh        |  21 ++
 t/t8020-last-modified.sh             | 194 ++++++++++++++
 14 files changed, 844 insertions(+)
---

Range-diff versus v1:

1:  1b6cb2603e ! 1:  586f60da1f blame-tree: introduce new subcommand to blame files
    @@ Metadata
     Author: Toon Claes <toon@iotcl.com>
     
      ## Commit message ##
    -    blame-tree: introduce new subcommand to blame files
    +    last-modified: new subcommand to show when files were last modified
     
    -    Similar to git-blame(1), introduce a new subcommand git-blame-tree(1).
    -    This command shows the most recent modification to paths in a tree. It
    -    does so by expanding the tree at a given commit, taking note of the
    -    current state of each path, and then walking backwards through history
    -    looking for commits where each path changed into its final commit ID.
    +    Similar to git-blame(1), introduce a new subcommand
    +    git-last-modified(1). This command shows the most recent modification to
    +    paths in a tree. It does so by expanding the tree at a given commit,
    +    taking note of the current state of each path, and then walking
    +    backwards through history looking for commits where each path changed
    +    into its final commit ID.
     
         Based-on-patch-by: Jeff King <peff@peff.net>
         Improved-by: "Ævar Arnfjörð Bjarmason" <avarab@gmail.com>
    @@ Commit message
     
      ## .gitignore ##
     @@
    - /git-backfill
    - /git-bisect
    - /git-blame
    -+/git-blame-tree
    - /git-branch
    - /git-bugreport
    - /git-bundle
    + /git-init-db
    + /git-interpret-trailers
    + /git-instaweb
    ++/git-last-modified
    + /git-log
    + /git-ls-files
    + /git-ls-remote
    +
    + ## Documentation/git-last-modified.adoc (new) ##
    +@@
    ++git-last-modified(1)
    ++====================
    ++
    ++NAME
    ++----
    ++git-last-modified - EXPERIMENTAL: Show when files were last modified
    ++
    ++
    ++SYNOPSIS
    ++--------
    ++[synopsis]
    ++git last-modified [-r] [<revision-range>] [[--] <path>...]
    ++
    ++DESCRIPTION
    ++-----------
    ++
    ++Shows which commit last modified each of the relevant files and subdirectories.
    ++
    ++THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
    ++
    ++OPTIONS
    ++-------
    ++
    ++-r::
    ++	Recurse into subtrees.
    ++
    ++-t::
    ++	Show tree entry itself as well as subtrees.  Implies `-r`.
    ++
    ++<revision-range>::
    ++	Only traverse commits in the specified revision range. When no
    ++	`<revision-range>` is specified, it defaults to `HEAD` (i.e. the whole
    ++	history leading to the current commit). For a complete list of ways to
    ++	spell `<revision-range>`, see the 'Specifying Ranges' section of
    ++	linkgit:gitrevisions[7].
    ++
    ++[--] <path>...::
    ++	For each _<path>_ given, the commit which last modified it is returned.
    ++	Without an optional path parameter, all files and subdirectories
    ++	of the current working directory are included in the
    ++
    ++SEE ALSO
    ++--------
    ++linkgit:git-blame[1],
    ++linkgit:git-log[1].
    ++
    ++GIT
    ++---
    ++Part of the linkgit:git[1] suite
    +
    + ## Documentation/meson.build ##
    +@@ Documentation/meson.build: manpages = {
    +   'git-init.adoc' : 1,
    +   'git-instaweb.adoc' : 1,
    +   'git-interpret-trailers.adoc' : 1,
    ++  'git-last-modified.adoc' : 1,
    +   'git-log.adoc' : 1,
    +   'git-ls-files.adoc' : 1,
    +   'git-ls-remote.adoc' : 1,
     
      ## Makefile ##
    -@@ Makefile: LIB_OBJS += archive.o
    - LIB_OBJS += attr.o
    - LIB_OBJS += base85.o
    - LIB_OBJS += bisect.o
    -+LIB_OBJS += blame-tree.o
    - LIB_OBJS += blame.o
    - LIB_OBJS += blob.o
    - LIB_OBJS += bloom.o
    -@@ Makefile: BUILTIN_OBJS += builtin/archive.o
    - BUILTIN_OBJS += builtin/backfill.o
    - BUILTIN_OBJS += builtin/bisect.o
    - BUILTIN_OBJS += builtin/blame.o
    -+BUILTIN_OBJS += builtin/blame-tree.o
    - BUILTIN_OBJS += builtin/branch.o
    - BUILTIN_OBJS += builtin/bugreport.o
    - BUILTIN_OBJS += builtin/bundle.o
    +@@ Makefile: LIB_OBJS += hook.o
    + LIB_OBJS += ident.o
    + LIB_OBJS += json-writer.o
    + LIB_OBJS += kwset.o
    ++LIB_OBJS += last-modified.o
    + LIB_OBJS += levenshtein.o
    + LIB_OBJS += line-log.o
    + LIB_OBJS += line-range.o
    +@@ Makefile: BUILTIN_OBJS += builtin/hook.o
    + BUILTIN_OBJS += builtin/index-pack.o
    + BUILTIN_OBJS += builtin/init-db.o
    + BUILTIN_OBJS += builtin/interpret-trailers.o
    ++BUILTIN_OBJS += builtin/last-modified.o
    + BUILTIN_OBJS += builtin/log.o
    + BUILTIN_OBJS += builtin/ls-files.o
    + BUILTIN_OBJS += builtin/ls-remote.o
     
    - ## blame-tree.c (new) ##
    + ## builtin.h ##
    +@@ builtin.h: int cmd_hook(int argc, const char **argv, const char *prefix, struct repository
    + int cmd_index_pack(int argc, const char **argv, const char *prefix, struct repository *repo);
    + int cmd_init_db(int argc, const char **argv, const char *prefix, struct repository *repo);
    + int cmd_interpret_trailers(int argc, const char **argv, const char *prefix, struct repository *repo);
    ++int cmd_last_modified(int argc, const char **argv, const char *prefix, struct repository *repo);
    + int cmd_log_reflog(int argc, const char **argv, const char *prefix, struct repository *repo);
    + int cmd_log(int argc, const char **argv, const char *prefix, struct repository *repo);
    + int cmd_ls_files(int argc, const char **argv, const char *prefix, struct repository *repo);
    +
    + ## builtin/last-modified.c (new) ##
     @@
     +#include "git-compat-util.h"
    -+#include "blame-tree.h"
    ++#include "last-modified.h"
    ++#include "hex.h"
    ++#include "quote.h"
    ++#include "config.h"
    ++#include "object-name.h"
    ++#include "parse-options.h"
    ++#include "builtin.h"
    ++
    ++static void show_entry(const char *path, const struct commit *commit, void *d)
    ++{
    ++	struct last_modified *lm = d;
    ++
    ++	if (commit->object.flags & BOUNDARY)
    ++		putchar('^');
    ++	printf("%s\t", oid_to_hex(&commit->object.oid));
    ++
    ++	if (lm->rev.diffopt.line_termination)
    ++		write_name_quoted(path, stdout, '\n');
    ++	else
    ++		printf("%s%c", path, '\0');
    ++
    ++	fflush(stdout);
    ++}
    ++
    ++int cmd_last_modified(int argc,
    ++		   const char **argv,
    ++		   const char *prefix,
    ++		   struct repository *repo)
    ++{
    ++	int ret = 0;
    ++	struct last_modified lm;
    ++
    ++	repo_config(repo, git_default_config, NULL);
    ++
    ++	last_modified_init(&lm, repo, prefix, argc, argv);
    ++	if (last_modified_run(&lm, show_entry, &lm) < 0)
    ++		die(_("error running last-modified traversal"));
    ++
    ++	last_modified_release(&lm);
    ++
    ++	return ret;
    ++}
    +
    + ## command-list.txt ##
    +@@ command-list.txt: git-index-pack                          plumbingmanipulators
    + git-init                                mainporcelain           init
    + git-instaweb                            ancillaryinterrogators          complete
    + git-interpret-trailers                  purehelpers
    ++git-last-modified                       plumbinginterrogators
    + git-log                                 mainporcelain           info
    + git-ls-files                            plumbinginterrogators
    + git-ls-remote                           plumbinginterrogators
    +
    + ## git.c ##
    +@@ git.c: static struct cmd_struct commands[] = {
    + 	{ "init", cmd_init_db },
    + 	{ "init-db", cmd_init_db },
    + 	{ "interpret-trailers", cmd_interpret_trailers, RUN_SETUP_GENTLY },
    ++	{ "last-modified", cmd_last_modified, RUN_SETUP },
    + 	{ "log", cmd_log, RUN_SETUP },
    + 	{ "ls-files", cmd_ls_files, RUN_SETUP },
    + 	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
    +
    + ## last-modified.c (new) ##
    +@@
    ++#include "git-compat-util.h"
    ++#include "last-modified.h"
     +#include "commit.h"
     +#include "diffcore.h"
     +#include "diff.h"
    @@ blame-tree.c (new)
     +#include "repository.h"
     +#include "log-tree.h"
     +
    -+struct blame_tree_entry {
    ++struct last_modified_entry {
     +	struct hashmap_entry hashent;
     +	struct object_id oid;
     +	struct commit *commit;
    @@ blame-tree.c (new)
     +			  struct diff_options *opt UNUSED,
     +			  void *data)
     +{
    -+	struct blame_tree *bt = data;
    ++	struct last_modified *lm = data;
     +
     +	for (int i = 0; i < q->nr; i++) {
     +		struct diff_filepair *p = q->queue[i];
    -+		struct blame_tree_entry *ent;
    ++		struct last_modified_entry *ent;
     +		const char *path = p->two->path;
     +
     +		FLEX_ALLOC_STR(ent, path, path);
     +		oidcpy(&ent->oid, &p->two->oid);
     +		hashmap_entry_init(&ent->hashent, strhash(ent->path));
    -+		hashmap_add(&bt->paths, &ent->hashent);
    ++		hashmap_add(&lm->paths, &ent->hashent);
     +	}
     +}
     +
    -+static int add_from_revs(struct blame_tree *bt)
    ++static int add_from_revs(struct last_modified *lm)
     +{
     +	size_t count = 0;
     +	struct diff_options diffopt;
     +
    -+	memcpy(&diffopt, &bt->rev.diffopt, sizeof(diffopt));
    -+	copy_pathspec(&diffopt.pathspec, &bt->rev.diffopt.pathspec);
    ++	memcpy(&diffopt, &lm->rev.diffopt, sizeof(diffopt));
    ++	copy_pathspec(&diffopt.pathspec, &lm->rev.diffopt.pathspec);
     +	diffopt.output_format = DIFF_FORMAT_CALLBACK;
     +	diffopt.format_callback = add_from_diff;
    -+	diffopt.format_callback_data = bt;
    ++	diffopt.format_callback_data = lm;
     +
    -+	for (size_t i = 0; i < bt->rev.pending.nr; i++) {
    -+		struct object_array_entry *obj = bt->rev.pending.objects + i;
    ++	for (size_t i = 0; i < lm->rev.pending.nr; i++) {
    ++		struct object_array_entry *obj = lm->rev.pending.objects + i;
     +
     +		if (obj->item->flags & UNINTERESTING)
     +			continue;
     +
     +		if (count++)
    -+			return error(_("can only blame one tree at a time"));
    ++			return error(_("can only get last-modified one tree at a time"));
     +
    -+		diff_tree_oid(bt->rev.repo->hash_algo->empty_tree,
    ++		diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
     +			      &obj->item->oid, "", &diffopt);
     +		diff_flush(&diffopt);
     +	}
    @@ blame-tree.c (new)
     +	return 0;
     +}
     +
    -+static int blame_tree_entry_hashcmp(const void *unused UNUSED,
    -+				    const struct hashmap_entry *he1,
    -+				    const struct hashmap_entry *he2,
    ++static int last_modified_entry_hashcmp(const void *unused UNUSED,
    ++				    const struct hashmap_entry *hent1,
    ++				    const struct hashmap_entry *hent2,
     +				    const void *path)
     +{
    -+	const struct blame_tree_entry *e1 =
    -+		container_of(he1, const struct blame_tree_entry, hashent);
    -+	const struct blame_tree_entry *e2 =
    -+		container_of(he2, const struct blame_tree_entry, hashent);
    -+	return strcmp(e1->path, path ? path : e2->path);
    ++	const struct last_modified_entry *ent1 =
    ++		container_of(hent1, const struct last_modified_entry, hashent);
    ++	const struct last_modified_entry *ent2 =
    ++		container_of(hent2, const struct last_modified_entry, hashent);
    ++	return strcmp(ent1->path, path ? path : ent2->path);
     +}
     +
    -+void blame_tree_init(struct blame_tree *bt,
    ++void last_modified_init(struct last_modified *lm,
     +		     struct repository *r,
     +		     const char *prefix,
     +		     int argc, const char **argv)
     +{
    -+	memset(bt, 0, sizeof(*bt));
    -+	hashmap_init(&bt->paths, blame_tree_entry_hashcmp, NULL, 0);
    ++	memset(lm, 0, sizeof(*lm));
    ++	hashmap_init(&lm->paths, last_modified_entry_hashcmp, NULL, 0);
     +
    -+	repo_init_revisions(r, &bt->rev, prefix);
    -+	bt->rev.def = "HEAD";
    -+	bt->rev.combine_merges = 1;
    -+	bt->rev.show_root_diff = 1;
    -+	bt->rev.boundary = 1;
    -+	bt->rev.no_commit_id = 1;
    -+	bt->rev.diff = 1;
    -+	if (setup_revisions(argc, argv, &bt->rev, NULL) > 1)
    -+		die(_("unknown blame-tree argument: %s"), argv[1]);
    ++	repo_init_revisions(r, &lm->rev, prefix);
    ++	lm->rev.def = "HEAD";
    ++	lm->rev.combine_merges = 1;
    ++	lm->rev.show_root_diff = 1;
    ++	lm->rev.boundary = 1;
    ++	lm->rev.no_commit_id = 1;
    ++	lm->rev.diff = 1;
    ++	if (setup_revisions(argc, argv, &lm->rev, NULL) > 1)
    ++		die(_("unknown last-modified argument: %s"), argv[1]);
     +
    -+	if (add_from_revs(bt) < 0)
    -+		die(_("unable to setup blame-tree"));
    ++	if (add_from_revs(lm) < 0)
    ++		die(_("unable to setup last-modified"));
     +}
     +
    -+void blame_tree_release(struct blame_tree *bt)
    ++void last_modified_release(struct last_modified *lm)
     +{
    -+	hashmap_clear_and_free(&bt->paths, struct blame_tree_entry, hashent);
    -+	release_revisions(&bt->rev);
    ++	hashmap_clear_and_free(&lm->paths, struct last_modified_entry, hashent);
    ++	release_revisions(&lm->rev);
     +}
     +
    -+struct blame_tree_callback_data {
    ++struct last_modified_callback_data {
     +	struct commit *commit;
     +	struct hashmap *paths;
     +
    -+	blame_tree_callback callback;
    ++	last_modified_callback callback;
     +	void *callback_data;
     +};
     +
     +static void mark_path(const char *path, const struct object_id *oid,
    -+		      struct blame_tree_callback_data *data)
    ++		      struct last_modified_callback_data *data)
     +{
    -+	struct blame_tree_entry *ent;
    ++	struct last_modified_entry *ent;
     +
     +	/* Is it even a path that we are interested in? */
     +	ent = hashmap_get_entry_from_hash(data->paths, strhash(path), path,
    -+					  struct blame_tree_entry, hashent);
    ++					  struct last_modified_entry, hashent);
     +	if (!ent)
     +		return;
     +
    -+	/* Have we already blamed a commit? */
    ++	/* Have we already found a commit? */
     +	if (ent->commit)
     +		return;
     +
    @@ blame-tree.c (new)
     +	free(ent);
     +}
     +
    -+static void blame_diff(struct diff_queue_struct *q,
    ++static void last_modified_diff(struct diff_queue_struct *q,
     +		       struct diff_options *opt UNUSED, void *cbdata)
     +{
    -+	struct blame_tree_callback_data *data = cbdata;
    ++	struct last_modified_callback_data *data = cbdata;
     +
     +	for (int i = 0; i < q->nr; i++) {
     +		struct diff_filepair *p = q->queue[i];
    @@ blame-tree.c (new)
     +			 * a final path/sha1 state. Note that this covers some
     +			 * potentially controversial areas, including:
     +			 *
    -+			 *  1. A rename or copy will be blamed, as it is the
    ++			 *  1. A rename or copy will be found, as it is the
     +			 *     first time the content has arrived at the given
     +			 *     path.
     +			 *
     +			 *  2. Even a non-content modification like a mode or
     +			 *     type change will trigger it.
     +			 *
    -+			 * We take the inclusive approach for now, and blame
    ++			 * We take the inclusive approach for now, and find
     +			 * anything which impacts the path. Options to tweak
     +			 * the behavior (e.g., to "--follow" the content across
     +			 * renames) can come later.
    @@ blame-tree.c (new)
     +	}
     +}
     +
    -+int blame_tree_run(struct blame_tree *bt, blame_tree_callback cb, void *cbdata)
    ++int last_modified_run(struct last_modified *lm, last_modified_callback cb, void *cbdata)
     +{
    -+	struct blame_tree_callback_data data;
    ++	struct last_modified_callback_data data;
     +
    -+	data.paths = &bt->paths;
    ++	data.paths = &lm->paths;
     +	data.callback = cb;
     +	data.callback_data = cbdata;
     +
    -+	bt->rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
    -+	bt->rev.diffopt.format_callback = blame_diff;
    -+	bt->rev.diffopt.format_callback_data = &data;
    ++	lm->rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
    ++	lm->rev.diffopt.format_callback = last_modified_diff;
    ++	lm->rev.diffopt.format_callback_data = &data;
     +
    -+	prepare_revision_walk(&bt->rev);
    ++	prepare_revision_walk(&lm->rev);
     +
    -+	while (hashmap_get_size(&bt->paths)) {
    -+		data.commit = get_revision(&bt->rev);
    ++	while (hashmap_get_size(&lm->paths)) {
    ++		data.commit = get_revision(&lm->rev);
     +		if (!data.commit)
     +			break;
     +
     +		if (data.commit->object.flags & BOUNDARY) {
    -+			diff_tree_oid(bt->rev.repo->hash_algo->empty_tree,
    ++			diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
     +				       &data.commit->object.oid,
    -+				       "", &bt->rev.diffopt);
    -+			diff_flush(&bt->rev.diffopt);
    ++				       "", &lm->rev.diffopt);
    ++			diff_flush(&lm->rev.diffopt);
     +		} else {
    -+			log_tree_commit(&bt->rev, data.commit);
    ++			log_tree_commit(&lm->rev, data.commit);
     +		}
     +	}
     +
     +	return 0;
     +}
     
    - ## blame-tree.h (new) ##
    + ## last-modified.h (new) ##
     @@
    -+#ifndef BLAME_TREE_H
    -+#define BLAME_TREE_H
    ++#ifndef LAST_MODIFIED_H
    ++#define LAST_MODIFIED_H
     +
     +#include "commit.h"
     +#include "revision.h"
     +#include "hashmap.h"
     +
    -+struct blame_tree {
    ++struct last_modified {
     +	struct hashmap paths;
     +	struct rev_info rev;
     +};
     +
    -+void blame_tree_init(struct blame_tree *bt,
    ++void last_modified_init(struct last_modified *lm,
     +		     struct repository *r,
     +		     const char *prefix,
     +		     int argc, const char **argv);
     +
    -+void blame_tree_release(struct blame_tree *);
    ++void last_modified_release(struct last_modified *);
     +
    -+typedef void (*blame_tree_callback)(const char *path,
    ++typedef void (*last_modified_callback)(const char *path,
     +				    const struct commit *commit,
     +				    void *data);
    -+int blame_tree_run(struct blame_tree *,
    -+		   blame_tree_callback cb,
    -+		   void *data);
    ++int last_modified_run(struct last_modified *lm,
    ++		   last_modified_callback cb,
    ++		   void *cbdata);
     +
    -+#endif /* BLAME_TREE_H */
    -
    - ## builtin.h ##
    -@@ builtin.h: int cmd_archive(int argc, const char **argv, const char *prefix, struct reposito
    - int cmd_backfill(int argc, const char **argv, const char *prefix, struct repository *repo);
    - int cmd_bisect(int argc, const char **argv, const char *prefix, struct repository *repo);
    - int cmd_blame(int argc, const char **argv, const char *prefix, struct repository *repo);
    -+int cmd_blame_tree(int argc, const char **argv, const char *prefix, struct repository *repo);
    - int cmd_branch(int argc, const char **argv, const char *prefix, struct repository *repo);
    - int cmd_bugreport(int argc, const char **argv, const char *prefix, struct repository *repo);
    - int cmd_bundle(int argc, const char **argv, const char *prefix, struct repository *repo);
    -
    - ## builtin/blame-tree.c (new) ##
    -@@
    -+#include "git-compat-util.h"
    -+#include "blame-tree.h"
    -+#include "hex.h"
    -+#include "quote.h"
    -+#include "config.h"
    -+#include "object-name.h"
    -+#include "parse-options.h"
    -+#include "builtin.h"
    -+
    -+static void show_entry(const char *path, const struct commit *commit, void *d)
    -+{
    -+	struct blame_tree *bt = d;
    -+
    -+	if (commit->object.flags & BOUNDARY)
    -+		putchar('^');
    -+	printf("%s\t", oid_to_hex(&commit->object.oid));
    -+
    -+	if (bt->rev.diffopt.line_termination)
    -+		write_name_quoted(path, stdout, '\n');
    -+	else
    -+		printf("%s%c", path, '\0');
    -+
    -+	fflush(stdout);
    -+}
    -+
    -+int cmd_blame_tree(int argc,
    -+		   const char **argv,
    -+		   const char *prefix,
    -+		   struct repository *repo)
    -+{
    -+	int ret = 0;
    -+	struct blame_tree bt;
    -+
    -+	repo_config(repo, git_default_config, NULL);
    -+
    -+	blame_tree_init(&bt, repo, prefix, argc, argv);
    -+	if (blame_tree_run(&bt, show_entry, &bt) < 0)
    -+		die(_("error running blame-tree traversal"));
    -+
    -+	blame_tree_release(&bt);
    -+
    -+	return ret;
    -+}
    -
    - ## git.c ##
    -@@ git.c: static struct cmd_struct commands[] = {
    - 	{ "backfill", cmd_backfill, RUN_SETUP },
    - 	{ "bisect", cmd_bisect, RUN_SETUP },
    - 	{ "blame", cmd_blame, RUN_SETUP },
    -+	{ "blame-tree", cmd_blame_tree, RUN_SETUP },
    - 	{ "branch", cmd_branch, RUN_SETUP | DELAY_PAGER_CONFIG },
    - 	{ "bugreport", cmd_bugreport, RUN_SETUP_GENTLY },
    - 	{ "bundle", cmd_bundle, RUN_SETUP_GENTLY },
    ++#endif /* LAST_MODIFIED_H */
     
      ## meson.build ##
     @@ meson.build: libgit_sources = [
    -   'attr.c',
    -   'base85.c',
    -   'bisect.c',
    -+  'blame-tree.c',
    -   'blame.c',
    -   'blob.c',
    -   'bloom.c',
    +   'ident.c',
    +   'json-writer.c',
    +   'kwset.c',
    ++  'last-modified.c',
    +   'levenshtein.c',
    +   'line-log.c',
    +   'line-range.c',
     @@ meson.build: builtin_sources = [
    -   'builtin/archive.c',
    -   'builtin/backfill.c',
    -   'builtin/bisect.c',
    -+  'builtin/blame-tree.c',
    -   'builtin/blame.c',
    -   'builtin/branch.c',
    -   'builtin/bugreport.c',
    -
    - ## t/helper/test-tool.h ##
    -@@
    - 
    - int cmd__advise_if_enabled(int argc, const char **argv);
    - int cmd__bitmap(int argc, const char **argv);
    -+int cmd__blame_tree(int argc, const char **argv);
    - int cmd__bloom(int argc, const char **argv);
    - int cmd__bundle_uri(int argc, const char **argv);
    - int cmd__cache_tree(int argc, const char **argv);
    +   'builtin/index-pack.c',
    +   'builtin/init-db.c',
    +   'builtin/interpret-trailers.c',
    ++  'builtin/last-modified.c',
    +   'builtin/log.c',
    +   'builtin/ls-files.c',
    +   'builtin/ls-remote.c',
     
      ## t/meson.build ##
     @@ t/meson.build: integration_tests = [
        't8012-blame-colors.sh',
        't8013-blame-ignore-revs.sh',
        't8014-blame-ignore-fuzzy.sh',
    -+  't8020-blame-tree.sh',
    ++  't8020-last-modified.sh',
        't9001-send-email.sh',
        't9002-column.sh',
        't9003-help-autocorrect.sh',
     
    - ## t/t8020-blame-tree.sh (new) ##
    + ## t/t8020-last-modified.sh (new) ##
     @@
     +#!/bin/sh
     +
    -+test_description='blame-tree tests'
    ++test_description='last-modified tests'
     +
     +. ./test-lib.sh
     +
    @@ t/t8020-blame-tree.sh (new)
     +	test_commit 3 a/b/file
     +'
     +
    -+test_expect_success 'cannot blame two trees' '
    -+	test_must_fail git blame-tree HEAD HEAD~1
    ++test_expect_success 'cannot run last-modified on two trees' '
    ++	test_must_fail git last-modified HEAD HEAD~1
     +'
     +
    -+check_blame() {
    ++check_last_modified() {
     +	local indir= &&
     +	while test $# != 0
     +	do
    @@ t/t8020-blame-tree.sh (new)
     +
     +	cat >expect &&
     +	test_when_finished "rm -f tmp.*" &&
    -+	git ${indir:+-C "$indir"} blame-tree "$@" >tmp.1 &&
    ++	git ${indir:+-C "$indir"} last-modified "$@" >tmp.1 &&
     +	git name-rev --annotate-stdin --name-only --tags \
     +		<tmp.1 >tmp.2 &&
     +	tr '\t' ' ' <tmp.2 >tmp.3 &&
    @@ t/t8020-blame-tree.sh (new)
     +	test_cmp expect actual
     +}
     +
    -+test_expect_success 'blame recursive' '
    -+	check_blame --recursive <<-\EOF
    ++test_expect_success 'last-modified non-recursive' '
    ++	check_last_modified <<-\EOF
    ++	1 file
    ++	3 a
    ++	EOF
    ++'
    ++
    ++test_expect_success 'last-modified recursive' '
    ++	check_last_modified -r <<-\EOF
     +	1 file
     +	2 a/file
     +	3 a/b/file
     +	EOF
     +'
     +
    -+test_expect_success 'blame non-recursive' '
    -+	check_blame --no-recursive <<-\EOF
    -+	1 file
    ++test_expect_success 'last-modified subdir' '
    ++	check_last_modified a <<-\EOF
     +	3 a
     +	EOF
     +'
     +
    -+test_expect_success 'blame subdir' '
    -+	check_blame a <<-\EOF
    -+	3 a
    -+	EOF
    -+'
    -+
    -+test_expect_success 'blame subdir recursive' '
    -+	check_blame --recursive a <<-\EOF
    ++test_expect_success 'last-modified subdir recursive' '
    ++	check_last_modified -r a <<-\EOF
     +	2 a/file
     +	3 a/b/file
     +	EOF
     +'
     +
    -+test_expect_success 'blame from non-HEAD commit' '
    -+	check_blame --no-recursive HEAD^ <<-\EOF
    ++test_expect_success 'last-modified from non-HEAD commit' '
    ++	check_last_modified HEAD^ <<-\EOF
     +	1 file
     +	2 a
     +	EOF
     +'
     +
    -+test_expect_success 'blame from subdir defaults to root' '
    -+	check_blame -C a --no-recursive <<-\EOF
    ++test_expect_success 'last-modified from subdir defaults to root' '
    ++	check_last_modified -C a <<-\EOF
     +	1 file
     +	3 a
     +	EOF
     +'
     +
    -+test_expect_success 'blame from subdir uses relative pathspecs' '
    -+	check_blame -C a --recursive b <<-\EOF
    ++test_expect_success 'last-modified from subdir uses relative pathspecs' '
    ++	check_last_modified -C a -r b <<-\EOF
     +	3 a/b/file
     +	EOF
     +'
     +
    -+test_expect_failure 'limit blame traversal by count' '
    -+	check_blame --no-recursive -1 <<-\EOF
    ++test_expect_success 'limit last-modified traversal by count' '
    ++	check_last_modified -1 <<-\EOF
     +	3 a
    ++	^2 file
     +	EOF
     +'
     +
    -+test_expect_success 'limit blame traversal by commit' '
    -+	check_blame --no-recursive HEAD~2..HEAD <<-\EOF
    ++test_expect_success 'limit last-modified traversal by commit' '
    ++	check_last_modified HEAD~2..HEAD <<-\EOF
     +	3 a
     +	^1 file
     +	EOF
     +'
     +
    -+test_expect_success 'only blame files in the current tree' '
    ++test_expect_success 'only last-modified files in the current tree' '
     +	git rm -rf a &&
     +	git commit -m "remove a" &&
    -+	check_blame <<-\EOF
    ++	check_last_modified <<-\EOF
     +	1 file
     +	EOF
     +'
    @@ t/t8020-blame-tree.sh (new)
     +	git rm -rf . &&
     +	test_commit m2 &&
     +	git merge m1 &&
    -+	check_blame <<-\EOF
    ++	check_last_modified <<-\EOF
     +	m1 m1.t
     +	m2 m2.t
     +	EOF
     +'
     +
    -+test_expect_success 'blame merge for resolved conflicts' '
    ++test_expect_success 'last-modified merge for resolved conflicts' '
     +	git checkout HEAD^0 &&
     +	git rm -rf . &&
     +	test_commit c1 conflict &&
    @@ t/t8020-blame-tree.sh (new)
     +	test_commit c2 conflict &&
     +	test_must_fail git merge c1 &&
     +	test_commit resolved conflict &&
    -+	check_blame conflict <<-\EOF
    ++	check_last_modified conflict <<-\EOF
     +	resolved conflict
     +	EOF
     +'
     +
    -+test_expect_success 'blame-tree complains about unknown arguments' '
    -+	test_must_fail git blame-tree --foo 2>err &&
    -+	grep "unknown blame-tree argument: --foo" err
    ++
    ++# Consider `file` with this content through history:
    ++#
    ++# A---B---B-------B---B
    ++#          \     /
    ++#           C---D
    ++test_expect_success 'last-modified merge ignores content from branch' '
    ++	git checkout HEAD^0 &&
    ++	git rm -rf . &&
    ++	test_commit a1 file A &&
    ++	test_commit a2 file B &&
    ++	test_commit a3 file C &&
    ++	test_commit a4 file D &&
    ++	git checkout a2 &&
    ++	git merge --no-commit --no-ff a4 &&
    ++	git checkout a2 -- file &&
    ++	git merge --continue &&
    ++	check_last_modified <<-\EOF
    ++	a2 file
    ++	EOF
    ++'
    ++
    ++# Consider `file` with this content through history:
    ++#
    ++#  A---B---B---C---D---B---B
    ++#           \         /
    ++#            B-------B
    ++test_expect_success 'last-modified merge undoes changes' '
    ++	git checkout HEAD^0 &&
    ++	git rm -rf . &&
    ++	test_commit b1 file A &&
    ++	test_commit b2 file B &&
    ++	test_commit b3 file C &&
    ++	test_commit b4 file D &&
    ++	git checkout b2 &&
    ++	test_commit b5 file2 2 &&
    ++	git checkout b4 &&
    ++	git merge --no-commit --no-ff b5 &&
    ++	git checkout b2 -- file &&
    ++	git merge --continue &&
    ++	check_last_modified <<-\EOF
    ++	b2 file
    ++	b5 file2
    ++	EOF
    ++'
    ++
    ++test_expect_success 'last-modified complains about unknown arguments' '
    ++	test_must_fail git last-modified --foo 2>err &&
    ++	grep "unknown last-modified argument: --foo" err
     +'
     +
     +test_done
2:  595a8836fb ! 2:  54383e3f5c t/perf: add blame-tree perf script
    @@ Metadata
     Author: Jeff King <peff@peff.net>
     
      ## Commit message ##
    -    t/perf: add blame-tree perf script
    +    t/perf: add last-modified perf script
     
    -    This just runs some simple blame-tree's. We already test correctness in
    -    the regular suite, so this is just about finding performance regressions
    -    from one version to another.
    +    This just runs some simple last-modified commands. We already test
    +    correctness in the regular suite, so this is just about finding
    +    performance regressions from one version to another.
     
         Signed-off-by: Toon Claes <toon@iotcl.com>
     
    - ## t/perf/p8020-blame-tree.sh (new) ##
    + ## t/meson.build ##
    +@@ t/meson.build: benchmarks = [
    +   'perf/p7820-grep-engines.sh',
    +   'perf/p7821-grep-engines-fixed.sh',
    +   'perf/p7822-grep-perl-character.sh',
    ++  'perf/p8020-last-modified.sh',
    +   'perf/p9210-scalar.sh',
    +   'perf/p9300-fast-import-export.sh',
    + ]
    +
    + ## t/perf/p8020-last-modified.sh (new) ##
     @@
     +#!/bin/sh
     +
    -+test_description='blame-tree perf tests'
    ++test_description='last-modified perf tests'
     +. ./perf-lib.sh
     +
     +test_perf_default_repo
     +
    -+test_perf 'top-level blame-tree' '
    -+	git blame-tree HEAD
    ++test_perf 'top-level last-modified' '
    ++	git last-modified HEAD
     +'
     +
    -+test_perf 'top-level recursive blame-tree' '
    -+	git blame-tree -r HEAD
    ++test_perf 'top-level recursive last-modified' '
    ++	git last-modified -r HEAD
     +'
     +
    -+test_perf 'subdir blame-tree' '
    ++test_perf 'subdir last-modified' '
     +	path=$(git ls-tree HEAD | grep ^040000 | head -n 1 | cut -f2)
    -+	git blame-tree -r HEAD -- "$path"
    ++	git last-modified -r HEAD -- "$path"
     +'
     +
     +test_done
    -
    - ## t/t8020-blame-tree.sh ##
    -@@ t/t8020-blame-tree.sh: check_blame() {
    - }
    - 
    - test_expect_success 'blame recursive' '
    --	check_blame --recursive <<-\EOF
    -+	check_blame -r <<-\EOF
    - 	1 file
    - 	2 a/file
    - 	3 a/b/file
    -@@ t/t8020-blame-tree.sh: test_expect_success 'blame recursive' '
    - '
    - 
    - test_expect_success 'blame non-recursive' '
    --	check_blame --no-recursive <<-\EOF
    -+	check_blame <<-\EOF
    - 	1 file
    - 	3 a
    - 	EOF
    -@@ t/t8020-blame-tree.sh: test_expect_success 'blame subdir' '
    - '
    - 
    - test_expect_success 'blame subdir recursive' '
    --	check_blame --recursive a <<-\EOF
    -+	check_blame -r a <<-\EOF
    - 	2 a/file
    - 	3 a/b/file
    - 	EOF
    - '
    - 
    - test_expect_success 'blame from non-HEAD commit' '
    --	check_blame --no-recursive HEAD^ <<-\EOF
    -+	check_blame HEAD^ <<-\EOF
    - 	1 file
    - 	2 a
    - 	EOF
    - '
    - 
    - test_expect_success 'blame from subdir defaults to root' '
    --	check_blame -C a --no-recursive <<-\EOF
    -+	check_blame -C a <<-\EOF
    - 	1 file
    - 	3 a
    - 	EOF
    - '
    - 
    - test_expect_success 'blame from subdir uses relative pathspecs' '
    --	check_blame -C a --recursive b <<-\EOF
    -+	check_blame -C a -r b <<-\EOF
    - 	3 a/b/file
    - 	EOF
    - '
    - 
    --test_expect_failure 'limit blame traversal by count' '
    --	check_blame --no-recursive -1 <<-\EOF
    -+test_expect_success 'limit blame traversal by count' '
    -+	check_blame <<-\EOF
    - 	3 a
    -+	^2 file
    - 	EOF
    - '
    - 
    - test_expect_success 'limit blame traversal by commit' '
    --	check_blame --no-recursive HEAD~2..HEAD <<-\EOF
    -+	check_blame HEAD~2..HEAD <<-\EOF
    - 	3 a
    - 	^1 file
    - 	EOF
3:  4d01e68e9b ! 3:  f67b406980 blame-tree: use Bloom filters when available
    @@
      ## Metadata ##
    -Author: Taylor Blau <me@ttaylorr.com>
    +Author: Toon Claes <toon@iotcl.com>
     
      ## Commit message ##
    -    blame-tree: use Bloom filters when available
    +    last-modified: use Bloom filters when available
     
    -    Our 'git blame-tree' performs a revision walk, and computes a diff at
    +    Our 'git last-modified' performs a revision walk, and computes a diff at
         each point in the walk to figure out whether a given revision changed
         any of the paths it considers interesting.
     
    @@ Commit message
         can avoid computing it in this case.
     
         This results in a substantial performance speed-up in common cases of
    -    'git blame-tree'. In the kernel, here is the before and after (all times
    -    computed with best-of-five):
    +    'git last-modified'. In the kernel, here is the before and after (all
    +    times computed with best-of-five):
     
         With commit-graphs (but no Bloom filters):
     
    @@ Commit message
     
         Signed-off-by: Toon Claes <toon@iotcl.com>
     
    - ## blame-tree.c ##
    + ## last-modified.c ##
     @@
      #include "revision.h"
      #include "repository.h"
    @@ blame-tree.c
     +#include "commit-graph.h"
     +#include "bloom.h"
      
    - struct blame_tree_entry {
    + struct last_modified_entry {
      	struct hashmap_entry hashent;
      	struct object_id oid;
      	struct commit *commit;
    @@ blame-tree.c
      	const char path[FLEX_ARRAY];
      };
      
    -@@ blame-tree.c: static void add_from_diff(struct diff_queue_struct *q,
    +@@ last-modified.c: static void add_from_diff(struct diff_queue_struct *q,
      
      		FLEX_ALLOC_STR(ent, path, path);
      		oidcpy(&ent->oid, &p->two->oid);
    -+		if (bt->rev.bloom_filter_settings)
    ++		if (lm->rev.bloom_filter_settings)
     +			fill_bloom_key(path, strlen(path), &ent->key,
    -+				       bt->rev.bloom_filter_settings);
    ++				       lm->rev.bloom_filter_settings);
      		hashmap_entry_init(&ent->hashent, strhash(ent->path));
    - 		hashmap_add(&bt->paths, &ent->hashent);
    + 		hashmap_add(&lm->paths, &ent->hashent);
      	}
    -@@ blame-tree.c: void blame_tree_init(struct blame_tree *bt,
    - 	if (setup_revisions(argc, argv, &bt->rev, NULL) > 1)
    - 		die(_("unknown blame-tree argument: %s"), argv[1]);
    +@@ last-modified.c: void last_modified_init(struct last_modified *lm,
    + 	if (setup_revisions(argc, argv, &lm->rev, NULL) > 1)
    + 		die(_("unknown last-modified argument: %s"), argv[1]);
      
    -+	(void)generation_numbers_enabled(bt->rev.repo);
    -+	bt->rev.bloom_filter_settings = get_bloom_filter_settings(bt->rev.repo);
    ++	(void)generation_numbers_enabled(lm->rev.repo);
    ++	lm->rev.bloom_filter_settings = get_bloom_filter_settings(lm->rev.repo);
     +
    - 	if (add_from_revs(bt) < 0)
    - 		die(_("unable to setup blame-tree"));
    + 	if (add_from_revs(lm) < 0)
    + 		die(_("unable to setup last-modified"));
      }
      
    - void blame_tree_release(struct blame_tree *bt)
    + void last_modified_release(struct last_modified *lm)
      {
     +	struct hashmap_iter iter;
    -+	struct blame_tree_entry *ent;
    ++	struct last_modified_entry *ent;
     +
    -+	hashmap_for_each_entry(&bt->paths, &iter, ent, hashent) {
    ++	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent) {
     +		clear_bloom_key(&ent->key);
     +	}
    - 	hashmap_clear_and_free(&bt->paths, struct blame_tree_entry, hashent);
    - 	release_revisions(&bt->rev);
    + 	hashmap_clear_and_free(&lm->paths, struct last_modified_entry, hashent);
    + 	release_revisions(&lm->rev);
      }
    -@@ blame-tree.c: static void mark_path(const char *path, const struct object_id *oid,
    +@@ last-modified.c: static void mark_path(const char *path, const struct object_id *oid,
      		data->callback(path, data->commit, data->callback_data);
      
      	hashmap_remove(data->paths, &ent->hashent, path);
    @@ blame-tree.c: static void mark_path(const char *path, const struct object_id *oi
      	free(ent);
      }
      
    -@@ blame-tree.c: static void blame_diff(struct diff_queue_struct *q,
    +@@ last-modified.c: static void last_modified_diff(struct diff_queue_struct *q,
      	}
      }
      
    -+static int maybe_changed_path(struct blame_tree *bt, struct commit *origin)
    ++static int maybe_changed_path(struct last_modified *lm, struct commit *origin)
     +{
     +	struct bloom_filter *filter;
    -+	struct blame_tree_entry *e;
    ++	struct last_modified_entry *ent;
     +	struct hashmap_iter iter;
     +
    -+	if (!bt->rev.bloom_filter_settings)
    ++	if (!lm->rev.bloom_filter_settings)
     +		return 1;
     +
     +	if (commit_graph_generation(origin) == GENERATION_NUMBER_INFINITY)
     +		return 1;
     +
    -+	filter = get_bloom_filter(bt->rev.repo, origin);
    ++	filter = get_bloom_filter(lm->rev.repo, origin);
     +	if (!filter)
     +		return 1;
     +
    -+	hashmap_for_each_entry(&bt->paths, &iter, e, hashent) {
    -+		if (bloom_filter_contains(filter, &e->key,
    -+					  bt->rev.bloom_filter_settings))
    ++	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent) {
    ++		if (bloom_filter_contains(filter, &ent->key,
    ++					  lm->rev.bloom_filter_settings))
     +			return 1;
     +	}
     +	return 0;
     +}
     +
    - int blame_tree_run(struct blame_tree *bt, blame_tree_callback cb, void *cbdata)
    + int last_modified_run(struct last_modified *lm, last_modified_callback cb, void *cbdata)
      {
    - 	struct blame_tree_callback_data data;
    -@@ blame-tree.c: int blame_tree_run(struct blame_tree *bt, blame_tree_callback cb, void *cbdata)
    + 	struct last_modified_callback_data data;
    +@@ last-modified.c: int last_modified_run(struct last_modified *lm, last_modified_callback cb, void
      		if (!data.commit)
      			break;
      
    -+		if (!maybe_changed_path(bt, data.commit))
    ++		if (!maybe_changed_path(lm, data.commit))
     +			continue;
     +
      		if (data.commit->object.flags & BOUNDARY) {
    - 			diff_tree_oid(bt->rev.repo->hash_algo->empty_tree,
    + 			diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
      				       &data.commit->object.oid,
4:  1a20acce8f ! 4:  3eac929e36 blame-tree: implement faster algorithm
    @@
      ## Metadata ##
    -Author: Taylor Blau <me@ttaylorr.com>
    +Author: Toon Claes <toon@iotcl.com>
     
      ## Commit message ##
    -    blame-tree: implement faster algorithm
    +    last-modified: implement faster algorithm
     
    -    The current implementation of 'git blame-tree' works by doing a revision
    -    walk, and inspecting the diff at each level of that walk to annotate the
    -    yet-unblamed entries to a path. In other words, if the diff at some
    -    level touches a path which has not yet been associated with a commit,
    -    then that commit becomes associated with the path.
    +    The current implementation of 'git last-modified' works by doing a
    +    revision walk, and inspecting the diff at each level of that walk to
    +    annotate the to-be-found entries to a path. In other words, if the diff
    +    at some level touches a path which has not yet been associated with a
    +    commit, then that commit becomes associated with the path.
     
         While a perfectly reasonable implementation, it can perform poorly in
         either one of two scenarios:
    @@ Commit message
              long time, and so we must walk through a lot of history in order to
              find a commit that touches that path.
     
    -    This patch rewrites the blame-tree implementation that addresses (2).
    +    This patch rewrites the last-modified implementation that addresses (2).
         The idea behind the algorithm is to propagate a set of 'active' paths (a
         path is 'active' if it does not yet belong to a commit) up to parents
         and do a truncated revision walk.
    @@ Commit message
         Co-authored-by: Derrick Stolee <dstolee@microsoft.com>
         Signed-off-by: Toon Claes <toon@iotcl.com>
     
    - ## blame-tree.c ##
    + ## last-modified.c ##
     @@
      #include "commit.h"
      #include "diffcore.h"
    @@ blame-tree.c
     +#include "prio-queue.h"
     +#include "commit-slab.h"
      
    - struct blame_tree_entry {
    + struct last_modified_entry {
      	struct hashmap_entry hashent;
      	struct object_id oid;
      	struct commit *commit;
    @@ blame-tree.c
      	struct bloom_key key;
      	const char path[FLEX_ARRAY];
      };
    -@@ blame-tree.c: void blame_tree_init(struct blame_tree *bt,
    +@@ last-modified.c: void last_modified_init(struct last_modified *lm,
      		     const char *prefix,
      		     int argc, const char **argv)
      {
     +	struct hashmap_iter iter;
    -+	struct blame_tree_entry *e;
    ++	struct last_modified_entry *ent;
     +
    - 	memset(bt, 0, sizeof(*bt));
    - 	hashmap_init(&bt->paths, blame_tree_entry_hashcmp, NULL, 0);
    + 	memset(lm, 0, sizeof(*lm));
    + 	hashmap_init(&lm->paths, last_modified_entry_hashcmp, NULL, 0);
      
    -@@ blame-tree.c: void blame_tree_init(struct blame_tree *bt,
    +@@ last-modified.c: void last_modified_init(struct last_modified *lm,
      
    - 	if (add_from_revs(bt) < 0)
    - 		die(_("unable to setup blame-tree"));
    + 	if (add_from_revs(lm) < 0)
    + 		die(_("unable to setup last-modified"));
     +
    -+	bt->all_paths = xcalloc(hashmap_get_size(&bt->paths), sizeof(const char *));
    -+	bt->all_paths_nr = 0;
    -+	hashmap_for_each_entry(&bt->paths, &iter, e, hashent) {
    -+		e->diff_idx = bt->all_paths_nr++;
    -+		bt->all_paths[e->diff_idx] = e->path;
    ++	lm->all_paths = xcalloc(hashmap_get_size(&lm->paths), sizeof(const char *));
    ++	lm->all_paths_nr = 0;
    ++	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent) {
    ++		ent->diff_idx = lm->all_paths_nr++;
    ++		lm->all_paths[ent->diff_idx] = ent->path;
     +	}
      }
      
    - void blame_tree_release(struct blame_tree *bt)
    -@@ blame-tree.c: void blame_tree_release(struct blame_tree *bt)
    + void last_modified_release(struct last_modified *lm)
    +@@ last-modified.c: void last_modified_release(struct last_modified *lm)
      	}
    - 	hashmap_clear_and_free(&bt->paths, struct blame_tree_entry, hashent);
    - 	release_revisions(&bt->rev);
    -+	free(bt->all_paths);
    + 	hashmap_clear_and_free(&lm->paths, struct last_modified_entry, hashent);
    + 	release_revisions(&lm->rev);
    ++	free(lm->all_paths);
     +}
     +
     +struct commit_active_paths {
    @@ blame-tree.c: void blame_tree_release(struct blame_tree *bt)
     +	free(active->active);
      }
      
    - struct blame_tree_callback_data {
    -@@ blame-tree.c: static void mark_path(const char *path, const struct object_id *oid,
    - 		      struct blame_tree_callback_data *data)
    + struct last_modified_callback_data {
    +@@ last-modified.c: static void mark_path(const char *path, const struct object_id *oid,
    + 		      struct last_modified_callback_data *data)
      {
    - 	struct blame_tree_entry *ent;
    + 	struct last_modified_entry *ent;
     +	struct commit_active_paths *active;
      
      	/* Is it even a path that we are interested in? */
      	ent = hashmap_get_entry_from_hash(data->paths, strhash(path), path,
    -@@ blame-tree.c: static void mark_path(const char *path, const struct object_id *oid,
    +@@ last-modified.c: static void mark_path(const char *path, const struct object_id *oid,
      	if (ent->commit)
      		return;
      
    @@ blame-tree.c: static void mark_path(const char *path, const struct object_id *oi
      		return;
      
      	ent->commit = data->commit;
    -@@ blame-tree.c: static void blame_diff(struct diff_queue_struct *q,
    +@@ last-modified.c: static void last_modified_diff(struct diff_queue_struct *q,
      	}
      }
      
    --static int maybe_changed_path(struct blame_tree *bt, struct commit *origin)
    +-static int maybe_changed_path(struct last_modified *lm, struct commit *origin)
     +static char *scratch;
     +
     +static void pass_to_parent(struct commit_active_paths *c,
    @@ blame-tree.c: static void blame_diff(struct diff_queue_struct *q,
     +#define PARENT1 (1u<<16) /* used instead of SEEN */
     +#define PARENT2 (1u<<17) /* used instead of BOTTOM, BOUNDARY */
     +
    -+static int diff2idx(struct blame_tree *bt, char *path)
    ++static int diff2idx(struct last_modified *lm, char *path)
     +{
    -+	struct blame_tree_entry *ent;
    -+	ent = hashmap_get_entry_from_hash(&bt->paths, strhash(path), path,
    -+					  struct blame_tree_entry, hashent);
    ++	struct last_modified_entry *ent;
    ++	ent = hashmap_get_entry_from_hash(&lm->paths, strhash(path), path,
    ++					  struct last_modified_entry, hashent);
     +	return ent ? ent->diff_idx : -1;
     +}
     +
    -+static int maybe_changed_path(struct blame_tree *bt,
    ++static int maybe_changed_path(struct last_modified *lm,
     +			      struct commit *origin,
     +			      struct commit_active_paths *active)
      {
      	struct bloom_filter *filter;
    - 	struct blame_tree_entry *e;
    -@@ blame-tree.c: static int maybe_changed_path(struct blame_tree *bt, struct commit *origin)
    + 	struct last_modified_entry *ent;
    +@@ last-modified.c: static int maybe_changed_path(struct last_modified *lm, struct commit *origin)
      		return 1;
      
    - 	hashmap_for_each_entry(&bt->paths, &iter, e, hashent) {
    -+		if (active && !active->active[e->diff_idx])
    + 	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent) {
    ++		if (active && !active->active[ent->diff_idx])
     +			continue;
    - 		if (bloom_filter_contains(filter, &e->key,
    - 					  bt->rev.bloom_filter_settings))
    + 		if (bloom_filter_contains(filter, &ent->key,
    + 					  lm->rev.bloom_filter_settings))
      			return 1;
    -@@ blame-tree.c: static int maybe_changed_path(struct blame_tree *bt, struct commit *origin)
    +@@ last-modified.c: static int maybe_changed_path(struct last_modified *lm, struct commit *origin)
      	return 0;
      }
      
    -+static int process_parent(struct blame_tree *bt,
    -+			   struct prio_queue *queue,
    -+			   struct commit *c, struct commit_active_paths *active_c,
    -+			   struct commit *parent, int parent_i)
    ++static int process_parent(struct last_modified *lm, struct prio_queue *queue,
    ++			  struct commit *c,
    ++			  struct commit_active_paths *active_c,
    ++			  struct commit *parent, int parent_i)
     +{
     +	int i, ret = 0; // TODO type & for loop var
     +	struct commit_active_paths *active_p;
     +
    -+	repo_parse_commit(bt->rev.repo, parent);
    ++	repo_parse_commit(lm->rev.repo, parent);
     +
     +	active_p = active_paths_at(&active_paths, parent);
     +	if (!active_p->active) {
    -+		active_p->active = xcalloc(sizeof(char), bt->all_paths_nr);
    ++		active_p->active = xcalloc(sizeof(char), lm->all_paths_nr);
     +		active_p->nr = 0;
     +	}
     +
    @@ blame-tree.c: static int maybe_changed_path(struct blame_tree *bt, struct commit
     +	 * Before calling 'diff_tree_oid()' on our first parent, see if Bloom
     +	 * filters will tell us the diff is conclusively uninteresting.
     +	 */
    -+	if (parent_i || maybe_changed_path(bt, c, active_c)) {
    ++	if (parent_i || maybe_changed_path(lm, c, active_c)) {
     +		diff_tree_oid(&parent->object.oid,
    -+			      &c->object.oid, "", &bt->rev.diffopt);
    -+		diffcore_std(&bt->rev.diffopt);
    ++			      &c->object.oid, "", &lm->rev.diffopt);
    ++		diffcore_std(&lm->rev.diffopt);
     +	}
     +
     +	if (!diff_queued_diff.nr) {
    @@ blame-tree.c: static int maybe_changed_path(struct blame_tree *bt, struct commit
     +		 * No diff entries means we are TREESAME on the base path, and
     +		 * so all active paths get passed onto this parent.
     +		 */
    -+		for (i = 0; i < bt->all_paths_nr; i++) {
    ++		for (i = 0; i < lm->all_paths_nr; i++) {
     +			if (active_c->active[i])
     +				pass_to_parent(active_c, active_p, i);
     +		}
    @@ blame-tree.c: static int maybe_changed_path(struct blame_tree *bt, struct commit
     +	 */
     +	for (i = 0; i < diff_queued_diff.nr; i++) {
     +		struct diff_filepair *fp = diff_queued_diff.queue[i];
    -+		int k = diff2idx(bt, fp->two->path);
    ++		int k = diff2idx(lm, fp->two->path);
     +		if (0 <= k && active_c->active[k])
     +			scratch[k] = 1;
     +		diff_free_filepair(fp);
     +	}
     +	diff_queued_diff.nr = 0;
    -+	for (i = 0; i < bt->all_paths_nr; i++) {
    ++	for (i = 0; i < lm->all_paths_nr; i++) {
     +		if (active_c->active[i] && !scratch[i])
     +			pass_to_parent(active_c, active_p, i);
     +	}
    @@ blame-tree.c: static int maybe_changed_path(struct blame_tree *bt, struct commit
     +
     +cleanup:
     +	diff_queue_clear(&diff_queued_diff);
    -+	memset(scratch, 0, bt->all_paths_nr);
    ++	memset(scratch, 0, lm->all_paths_nr);
     +
     +	return ret;
     +}
     +
    - int blame_tree_run(struct blame_tree *bt, blame_tree_callback cb, void *cbdata)
    + int last_modified_run(struct last_modified *lm, last_modified_callback cb, void *cbdata)
      {
     +	int max_count, queue_popped = 0;
     +	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
     +	struct prio_queue not_queue = { compare_commits_by_gen_then_commit_date };
    - 	struct blame_tree_callback_data data;
    + 	struct last_modified_callback_data data;
      
    - 	data.paths = &bt->paths;
    -@@ blame-tree.c: int blame_tree_run(struct blame_tree *bt, blame_tree_callback cb, void *cbdata)
    - 	bt->rev.diffopt.format_callback = blame_diff;
    - 	bt->rev.diffopt.format_callback_data = &data;
    + 	data.paths = &lm->paths;
    +@@ last-modified.c: int last_modified_run(struct last_modified *lm, last_modified_callback cb, void
    + 	lm->rev.diffopt.format_callback = last_modified_diff;
    + 	lm->rev.diffopt.format_callback_data = &data;
      
    --	prepare_revision_walk(&bt->rev);
    -+	max_count = bt->rev.max_count;
    +-	prepare_revision_walk(&lm->rev);
    ++	max_count = lm->rev.max_count;
      
    --	while (hashmap_get_size(&bt->paths)) {
    --		data.commit = get_revision(&bt->rev);
    +-	while (hashmap_get_size(&lm->paths)) {
    +-		data.commit = get_revision(&lm->rev);
     -		if (!data.commit)
     -			break;
     +	init_active_paths(&active_paths);
    -+	scratch = xcalloc(bt->all_paths_nr, sizeof(char));
    ++	scratch = xcalloc(lm->all_paths_nr, sizeof(char));
      
    --		if (!maybe_changed_path(bt, data.commit))
    +-		if (!maybe_changed_path(lm, data.commit))
     -			continue;
     +	/*
    -+	 * bt->rev.pending holds the set of boundary commits for our walk.
    ++	 * lm->rev.pending holds the set of boundary commits for our walk.
     +	 *
     +	 * Loop through each such commit, and place it in the appropriate queue.
     +	 */
    -+	for (size_t i = 0; i < bt->rev.pending.nr; i++) {
    -+		struct commit *c = lookup_commit(bt->rev.repo,
    -+						 &bt->rev.pending.objects[i].item->oid);
    -+		repo_parse_commit(bt->rev.repo, c);
    ++	for (size_t i = 0; i < lm->rev.pending.nr; i++) {
    ++		struct commit *c = lookup_commit(lm->rev.repo,
    ++						 &lm->rev.pending.objects[i].item->oid);
    ++		repo_parse_commit(lm->rev.repo, c);
      
     -		if (data.commit->object.flags & BOUNDARY) {
    --			diff_tree_oid(bt->rev.repo->hash_algo->empty_tree,
    +-			diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
     -				       &data.commit->object.oid,
    --				       "", &bt->rev.diffopt);
    --			diff_flush(&bt->rev.diffopt);
    +-				       "", &lm->rev.diffopt);
    +-			diff_flush(&lm->rev.diffopt);
     -		} else {
    --			log_tree_commit(&bt->rev, data.commit);
    +-			log_tree_commit(&lm->rev, data.commit);
     +		if (c->object.flags & BOTTOM) {
     +			prio_queue_put(&not_queue, c);
     +			c->object.flags |= PARENT2;
    @@ blame-tree.c: int blame_tree_run(struct blame_tree *bt, blame_tree_callback cb,
     +			c->object.flags |= PARENT1;
     +
     +			active = active_paths_at(&active_paths, c);
    -+			active->active = xcalloc(sizeof(char), bt->all_paths_nr);
    -+			memset(active->active, 1, bt->all_paths_nr);
    -+			active->nr = bt->all_paths_nr;
    ++			active->active = xcalloc(sizeof(char), lm->all_paths_nr);
    ++			memset(active->active, 1, lm->all_paths_nr);
    ++			active->nr = lm->all_paths_nr;
      		}
      	}
      
    @@ blame-tree.c: int blame_tree_run(struct blame_tree *bt, blame_tree_callback cb,
     +	 * Now that we have processed the pending commits, allow the revision
     +	 * machinery to flush them by calling prepare_revision_walk().
     +	 */
    -+	prepare_revision_walk(&bt->rev);
    ++	prepare_revision_walk(&lm->rev);
     +
     +	while (queue.nr) {
     +		int parent_i;
    @@ blame-tree.c: int blame_tree_run(struct blame_tree *bt, blame_tree_callback cb,
     +			 */
     +			c->object.flags |= PARENT2 | BOUNDARY;
     +			data.commit = c;
    -+			diff_tree_oid(bt->rev.repo->hash_algo->empty_tree,
    ++			diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
     +				      &c->object.oid,
    -+				      "", &bt->rev.diffopt);
    -+			diff_flush(&bt->rev.diffopt);
    ++				      "", &lm->rev.diffopt);
    ++			diff_flush(&lm->rev.diffopt);
     +			goto cleanup;
     +		}
     +
    @@ blame-tree.c: int blame_tree_run(struct blame_tree *bt, blame_tree_callback cb,
     +		 * Otherwise, keep going, but make sure that 'c' isn't reachable
     +		 * from anything in the '--not' queue.
     +		 */
    -+		repo_parse_commit(bt->rev.repo, c);
    ++		repo_parse_commit(lm->rev.repo, c);
     +
     +		while (not_queue.nr) {
     +			struct commit_list *np;
     +			struct commit *n = prio_queue_get(&not_queue);
     +
    -+			repo_parse_commit(bt->rev.repo, n);
    ++			repo_parse_commit(lm->rev.repo, n);
     +
     +			for (np = n->parents; np; np = np->next) {
     +				if (!(np->item->object.flags & PARENT2)) {
    @@ blame-tree.c: int blame_tree_run(struct blame_tree *bt, blame_tree_callback cb,
     +		 * parents in order if TREESAME.
     +		 */
     +		for (p = c->parents, parent_i = 0; p; p = p->next, parent_i++) {
    -+			if (process_parent(bt, &queue,
    ++			if (process_parent(lm, &queue,
     +					   c, active_c,
     +					   p->item, parent_i) > 0 )
     +				break;
    @@ blame-tree.c: int blame_tree_run(struct blame_tree *bt, blame_tree_callback cb,
     +		if (active_c->nr)  {
     +			/* Any paths that remain active were changed by 'c'. */
     +			data.commit = c;
    -+			for (int i = 0; i < bt->all_paths_nr; i++) {
    ++			for (int i = 0; i < lm->all_paths_nr; i++) {
     +				if (active_c->active[i])
    -+					mark_path(bt->all_paths[i], NULL, &data);
    ++					mark_path(lm->all_paths[i], NULL, &data);
     +			}
     +		}
     +
    @@ blame-tree.c: int blame_tree_run(struct blame_tree *bt, blame_tree_callback cb,
      	return 0;
      }
     
    - ## blame-tree.h ##
    + ## last-modified.h ##
     @@
    - struct blame_tree {
    + struct last_modified {
      	struct hashmap paths;
      	struct rev_info rev;
     +
    @@ blame-tree.h
     +	int all_paths_nr;
      };
      
    - void blame_tree_init(struct blame_tree *bt,
    + void last_modified_init(struct last_modified *lm,
5:  10b306953f ! 5:  6808799f8b blame-tree.c: initialize revision machinery without walk
    @@ Metadata
     Author: Toon Claes <toon@iotcl.com>
     
      ## Commit message ##
    -    blame-tree.c: initialize revision machinery without walk
    +    last-modified: initialize revision machinery without walk
     
         In a previous commit we inserted a call to 'prepare_revision_walk()'
         before we started our traversal. This was done when we leveraged the
    @@ Commit message
         Based-on-patch-by: Taylor Blau <me@ttaylorr.com>
         Signed-off-by: Toon Claes <toon@iotcl.com>
     
    - ## blame-tree.c ##
    -@@ blame-tree.c: static int maybe_changed_path(struct blame_tree *bt,
    + ## last-modified.c ##
    +@@ last-modified.c: static int maybe_changed_path(struct last_modified *lm,
      	if (!filter)
      		return 1;
      
    -+	for (int i = 0; i < bt->rev.bloom_keys_nr; i++) {
    ++	for (int i = 0; i < lm->rev.bloom_keys_nr; i++) {
     +		if (!(bloom_filter_contains(filter,
    -+					    &bt->rev.bloom_keys[i],
    -+					    bt->rev.bloom_filter_settings)))
    ++					    &lm->rev.bloom_keys[i],
    ++					    lm->rev.bloom_filter_settings)))
     +			return 0;
     +	}
     +
    - 	hashmap_for_each_entry(&bt->paths, &iter, e, hashent) {
    - 		if (active && !active->active[e->diff_idx])
    + 	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent) {
    + 		if (active && !active->active[ent->diff_idx])
      			continue;
    -@@ blame-tree.c: int blame_tree_run(struct blame_tree *bt, blame_tree_callback cb, void *cbdata)
    +@@ last-modified.c: int last_modified_run(struct last_modified *lm, last_modified_callback cb, void
      	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
      	struct prio_queue not_queue = { compare_commits_by_gen_then_commit_date };
    - 	struct blame_tree_callback_data data;
    + 	struct last_modified_callback_data data;
     +	struct commit_list *list;
      
    - 	data.paths = &bt->paths;
    + 	data.paths = &lm->paths;
      	data.callback = cb;
    -@@ blame-tree.c: int blame_tree_run(struct blame_tree *bt, blame_tree_callback cb, void *cbdata)
    - 	bt->rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
    - 	bt->rev.diffopt.format_callback = blame_diff;
    - 	bt->rev.diffopt.format_callback_data = &data;
    -+	bt->rev.no_walk = 1;
    +@@ last-modified.c: int last_modified_run(struct last_modified *lm, last_modified_callback cb, void
    + 	lm->rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
    + 	lm->rev.diffopt.format_callback = last_modified_diff;
    + 	lm->rev.diffopt.format_callback_data = &data;
    ++	lm->rev.no_walk = 1;
     +
    -+	prepare_revision_walk(&bt->rev);
    ++	prepare_revision_walk(&lm->rev);
      
    - 	max_count = bt->rev.max_count;
    + 	max_count = lm->rev.max_count;
      
    -@@ blame-tree.c: int blame_tree_run(struct blame_tree *bt, blame_tree_callback cb, void *cbdata)
    - 	scratch = xcalloc(bt->all_paths_nr, sizeof(char));
    +@@ last-modified.c: int last_modified_run(struct last_modified *lm, last_modified_callback cb, void
    + 	scratch = xcalloc(lm->all_paths_nr, sizeof(char));
      
      	/*
    --	 * bt->rev.pending holds the set of boundary commits for our walk.
    -+	 * bt->rev.commits holds the set of boundary commits for our walk.
    +-	 * lm->rev.pending holds the set of boundary commits for our walk.
    ++	 * lm->rev.commits holds the set of boundary commits for our walk.
      	 *
      	 * Loop through each such commit, and place it in the appropriate queue.
      	 */
    --	for (size_t i = 0; i < bt->rev.pending.nr; i++) {
    --		struct commit *c = lookup_commit(bt->rev.repo,
    --						 &bt->rev.pending.objects[i].item->oid);
    --		repo_parse_commit(bt->rev.repo, c);
    -+	for (list = bt->rev.commits; list; list = list->next) {
    +-	for (size_t i = 0; i < lm->rev.pending.nr; i++) {
    +-		struct commit *c = lookup_commit(lm->rev.repo,
    +-						 &lm->rev.pending.objects[i].item->oid);
    +-		repo_parse_commit(lm->rev.repo, c);
    ++	for (list = lm->rev.commits; list; list = list->next) {
     +		struct commit *c = list->item;
      
      		if (c->object.flags & BOTTOM) {
      			prio_queue_put(&not_queue, c);
    -@@ blame-tree.c: int blame_tree_run(struct blame_tree *bt, blame_tree_callback cb, void *cbdata)
    +@@ last-modified.c: int last_modified_run(struct last_modified *lm, last_modified_callback cb, void
      		}
      	}
      
    @@ blame-tree.c: int blame_tree_run(struct blame_tree *bt, blame_tree_callback cb,
     -	 * Now that we have processed the pending commits, allow the revision
     -	 * machinery to flush them by calling prepare_revision_walk().
     -	 */
    --	prepare_revision_walk(&bt->rev);
    +-	prepare_revision_walk(&lm->rev);
     -
      	while (queue.nr) {
      		int parent_i;


---

base-commit: 8613c2bb6cd16ef530dc5dd74d3b818a1ccbf1c0
change-id: 20250410-toon-new-blame-tree-bcdbb78c1c0f

Thanks
--
Toon

